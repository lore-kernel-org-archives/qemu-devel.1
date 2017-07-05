Received: from eggs.gnu.org ([2001:4830:134:3::10]:39541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSkWK-0006tG-0y
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSkWG-0004uH-SY
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:39:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dSkWG-0004u7-JU
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:39:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9228DC04D2A4
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 13:39:03 +0000 (UTC)
Date: Wed, 5 Jul 2017 09:39:00 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1631360003.47097808.1499261940413.JavaMail.zimbra@redhat.com>
In-Reply-To: <f00c4251-ad8d-475b-5c3c-653835791552@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-5-marcandre.lureau@redhat.com>
	<f00c4251-ad8d-475b-5c3c-653835791552@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/35] coroutine: remove coroutine_fn from
 qemu_coroutine_self()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hi

----- Original Message -----
> On 05/07/2017 00:03, Marc-Andr=C3=A9 Lureau wrote:
> > The function may be safely called from non-coroutine context.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> It can, but it shouldn't...  What are the callers?

There is aio_co_enter() & qemu_aio_coroutine_enter() that call it without c=
oroutine context, but they are probably safe and can be manually tagged as =
coroutine-section.

This help reveal a few more functions to be marked coroutine_fn:

diff --git a/block/io.c b/block/io.c
index a53a86df3e..e2dc1bf061 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1952,6 +1952,7 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *=
bs, int64_t sector_num,
  *  allocated/unallocated state.
  *
  */
+coroutine_fn
 int bdrv_is_allocated_above(BlockDriverState *top,
                             BlockDriverState *base,
                             int64_t sector_num,
diff --git a/block/iscsi.c b/block/iscsi.c
index e16311cb4a..5af98d9e99 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -310,6 +310,7 @@ out:
     }
 }
=20
+coroutine_fn
 static void iscsi_co_init_iscsitask(IscsiLun *iscsilun, struct IscsiTask *=
iTask)
 {
     *iTask =3D (struct IscsiTask) {
diff --git a/block/nfs.c b/block/nfs.c
index 3f393a95a4..9198d4406e 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -220,6 +220,7 @@ static void nfs_process_write(void *arg)
     qemu_mutex_unlock(&client->mutex);
 }
=20
+coroutine_fn
 static void nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
 {
     *task =3D (NFSRPC) {
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 1d25147392..9891908970 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -164,6 +164,7 @@ static int qcow2_cache_flush_dependency(BlockDriverStat=
e *bs, Qcow2Cache *c)
     return 0;
 }
=20
+coroutine_fn
 static int qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, in=
t i)
 {
     BDRVQcow2State *s =3D bs->opaque;
@@ -221,6 +222,7 @@ static int qcow2_cache_entry_flush(BlockDriverState *bs=
, Qcow2Cache *c, int i)
     return 0;
 }
=20
+coroutine_fn
 int qcow2_cache_write(BlockDriverState *bs, Qcow2Cache *c)
 {
     BDRVQcow2State *s =3D bs->opaque;
@@ -240,6 +242,7 @@ int qcow2_cache_write(BlockDriverState *bs, Qcow2Cache =
*c)
     return result;
 }
=20
+coroutine_fn
 int qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c)
 {
     int result =3D qcow2_cache_write(bs, c);
@@ -282,6 +285,7 @@ void qcow2_cache_depends_on_flush(Qcow2Cache *c)
     c->depends_on_flush =3D true;
 }
=20
+coroutine_fn
 int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c)
 {
     int ret, i;
@@ -304,6 +308,7 @@ int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache =
*c)
     return 0;
 }
=20
+coroutine_fn
 static int qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c,
     uint64_t offset, void **table, bool read_from_disk)
 {
@@ -378,12 +383,14 @@ found:
     return 0;
 }
=20
+coroutine_fn
 int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
     void **table)
 {
     return qcow2_cache_do_get(bs, c, offset, table, true);
 }
=20
+coroutine_fn
 int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t of=
fset,
     void **table)
 {
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 964d23aee8..da4d0c2b98 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1087,6 +1087,7 @@ handle_dependencies(BlockDriverState *bs, uint64_t gu=
est_offset,
  *
  *  -errno: in error cases
  */
+coroutine_fn
 static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
     uint64_t *host_offset, uint64_t *bytes, QCowL2Meta **m)
 {
@@ -1195,6 +1196,7 @@ out:
  * function has been waiting for another request and the allocation must b=
e
  * restarted, but the whole request should not be failed.
  */
+coroutine_fn
 static int do_alloc_cluster_offset(BlockDriverState *bs, uint64_t guest_of=
fset,
                                    uint64_t *host_offset, uint64_t *nb_clu=
sters)
 {
@@ -1243,6 +1245,7 @@ static int do_alloc_cluster_offset(BlockDriverState *=
bs, uint64_t guest_offset,
  *
  *  -errno: in error cases
  */
+coroutine_fn
 static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     uint64_t *host_offset, uint64_t *bytes, QCowL2Meta **m)
 {
diff --git a/block/quorum.c b/block/quorum.c
index b086d70daa..9772b20a78 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -154,6 +154,7 @@ static bool quorum_64bits_compare(QuorumVoteValue *a, Q=
uorumVoteValue *b)
     return a->l =3D=3D b->l;
 }
=20
+coroutine_fn
 static QuorumAIOCB *quorum_aio_get(BlockDriverState *bs,
                                    QEMUIOVector *qiov,
                                    uint64_t offset,
diff --git a/nbd/server.c b/nbd/server.c
index 4112b4b184..eb7f98ba32 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -995,6 +995,7 @@ nbd_co_send_reply(NBDRequestData *req, NBDReply *reply,=
 int len)
  * the client (although the caller may still need to disconnect after repo=
rting
  * the error).
  */
+coroutine_fn
 static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request=
)
 {
     NBDClient *client =3D req->client;
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index b44b5d55eb..a15cdfc6cd 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -173,6 +173,7 @@ typedef struct CoWaitRecord {
     QSLIST_ENTRY(CoWaitRecord) next;
 } CoWaitRecord;
=20
+coroutine_fn
 static void push_waiter(CoMutex *mutex, CoWaitRecord *w)
 {
     w->co =3D qemu_coroutine_self();
