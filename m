Received: from eggs.gnu.org ([209.51.188.92]:39958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1h1tcj-0003lN-2t
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1h1tcd-0002hF-Ax
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:03:49 -0500
From: Sergio Lopez <slp@redhat.com>
Date: Thu,  7 Mar 2019 15:03:12 +0100
Message-Id: <20190307140312.28072-1-slp@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] mirror: Confirm we're quiesced only if the job
 is paused or cancelled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, Sergio Lopez <slp@redhat.com>

While child_job_drained_begin() calls to job_pause(), the job doesn't
actually transition between states until it runs again and reaches a
pause point. This means bdrv_drained_begin() may return with some jobs
using the node still having 'busy =3D=3D true'.

As a consequence, block_job_detach_aio_context() may get into a
deadlock, waiting for the job to be actually paused, while the coroutine
servicing the job is yielding and doesn't get the opportunity to get
scheduled again. This situation can be reproduced by issuing a
'block-commit' immediately followed by a 'device_del'.

To ensure bdrv_drained_begin() only returns when the jobs have been
paused, we change mirror_drained_poll() to only confirm it's quiesced
when job->paused =3D=3D true and there aren't any in-flight requests, exc=
ept
if we reached that point by a drained section initiated by the
mirror/commit job itself.

The other block jobs shouldn't need any changes, as the default
drained_poll() behavior is to only confirm it's quiesced if the job is
not busy or completed.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 block/mirror.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 726d3c27fb..b7f076f97c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -80,6 +80,7 @@ typedef struct MirrorBlockJob {
     bool initial_zeroing_ongoing;
     int in_active_write_counter;
     bool prepared;
+    bool in_drain;
 } MirrorBlockJob;
=20
 typedef struct MirrorBDSOpaque {
@@ -679,9 +680,11 @@ static int mirror_exit_common(Job *job)
=20
         /* The mirror job has no requests in flight any more, but we nee=
d to
          * drain potential other users of the BDS before changing the gr=
aph. */
+        s->in_drain =3D true;
         bdrv_drained_begin(target_bs);
         bdrv_replace_node(to_replace, target_bs, &local_err);
         bdrv_drained_end(target_bs);
+        s->in_drain =3D false;
         if (local_err) {
             error_report_err(local_err);
             ret =3D -EPERM;
@@ -717,6 +720,7 @@ static int mirror_exit_common(Job *job)
     bs_opaque->job =3D NULL;
=20
     bdrv_drained_end(src);
+    s->in_drain =3D false;
     bdrv_unref(mirror_top_bs);
     bdrv_unref(src);
=20
@@ -1000,10 +1004,12 @@ static int coroutine_fn mirror_run(Job *job, Erro=
r **errp)
              */
             trace_mirror_before_drain(s, cnt);
=20
+            s->in_drain =3D true;
             bdrv_drained_begin(bs);
             cnt =3D bdrv_get_dirty_count(s->dirty_bitmap);
             if (cnt > 0 || mirror_flush(s) < 0) {
                 bdrv_drained_end(bs);
+                s->in_drain =3D false;
                 continue;
             }
=20
@@ -1051,6 +1057,7 @@ immediate_exit:
     bdrv_dirty_iter_free(s->dbi);
=20
     if (need_drain) {
+        s->in_drain =3D true;
         bdrv_drained_begin(bs);
     }
=20
@@ -1119,6 +1126,16 @@ static void coroutine_fn mirror_pause(Job *job)
 static bool mirror_drained_poll(BlockJob *job)
 {
     MirrorBlockJob *s =3D container_of(job, MirrorBlockJob, common);
+
+    /* If the job isn't paused nor cancelled, we can't be sure that it w=
on't
+     * issue more requets. We make an exception if we've reached this po=
int
+     * from one of our own drain sections, to avoid a deadlock waiting f=
or
+     * ourselves.
+     */
+    if (!s->common.job.paused && !s->common.job.cancelled && !s->in_drai=
n) {
+        return true;
+    }
+
     return !!s->in_flight;
 }
=20
--=20
2.20.1
