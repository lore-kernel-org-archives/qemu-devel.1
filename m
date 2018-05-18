Received: from eggs.gnu.org ([2001:4830:134:3::10]:59837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKj-000097-G2
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKi-0006Fa-H9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:22:09 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 18 May 2018 15:21:02 +0200
Message-Id: <20180518132114.4070-29-kwolf@redhat.com>
In-Reply-To: <20180518132114.4070-1-kwolf@redhat.com>
References: <20180518132114.4070-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 28/40] block: Cancel job in bdrv_close_all()
 callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Now that we cancel all jobs and not only block jobs on shutdown, doing
that in bdrv_close_all() isn't really appropriate any more. Move the
job_cancel_sync_all() call to the callers, and only assert that there
are no job running in bdrv_close_all().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c    | 4 +---
 qemu-nbd.c | 8 +++++++-
 vl.c       | 1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index d50b08c29b..501b64c819 100644
--- a/block.c
+++ b/block.c
@@ -3362,9 +3362,7 @@ static void bdrv_close(BlockDriverState *bs)
 
 void bdrv_close_all(void)
 {
-    /* TODO We do want to cancel all jobs instead of just block jobs on
-     * shutdown, but bdrv_close_all() isn't the right place any more. */
-    job_cancel_sync_all();
+    assert(job_next(NULL) == NULL);
     nbd_export_close_all();
 
     /* Drop references from requests still in flight, such as canceled block
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 0af0560ad1..51b9d38c72 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -482,6 +482,12 @@ static const char *socket_activation_validate_opts(const char *device,
     return NULL;
 }
 
+static void qemu_nbd_shutdown(void)
+{
+    job_cancel_sync_all();
+    bdrv_close_all();
+}
+
 int main(int argc, char **argv)
 {
     BlockBackend *blk;
@@ -928,7 +934,7 @@ int main(int argc, char **argv)
         exit(EXIT_FAILURE);
     }
     bdrv_init();
-    atexit(bdrv_close_all);
+    atexit(qemu_nbd_shutdown);
 
     srcpath = argv[optind];
     if (imageOpts) {
diff --git a/vl.c b/vl.c
index 3b39bbd7a8..d8c53ab9fd 100644
--- a/vl.c
+++ b/vl.c
@@ -4679,6 +4679,7 @@ int main(int argc, char **argv, char **envp)
     /* No more vcpu or device emulation activity beyond this point */
     vm_shutdown();
 
+    job_cancel_sync_all();
     bdrv_close_all();
 
     res_free();
-- 
2.13.6
