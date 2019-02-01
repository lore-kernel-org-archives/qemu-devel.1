Received: from eggs.gnu.org ([209.51.188.92]:38721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbnV-0007Cw-HO
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbnM-0008Bp-UA
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:07 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:34:57 +0100
Message-Id: <20190201163518.31157-7-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/27] block: Fix hangs in synchronous APIs with
 iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

In the block layer, synchronous APIs are often implemented by creating a
coroutine that calls the asynchronous coroutine-based implementation and
then waiting for completion with BDRV_POLL_WHILE().

For this to work with iothreads (more specifically, when the synchronous
API is called in a thread that is not the home thread of the block
device, so that the coroutine will run in a different thread), we must
make sure to call aio_wait_kick() at the end of the operation. Many
places are missing this, so that BDRV_POLL_WHILE() keeps hanging even if
the condition has long become false.

Note that bdrv_dec_in_flight() involves an aio_wait_kick() call. This
corresponds to the BDRV_POLL_WHILE() in the drain functions, but it is
generally not enough for most other operations because they haven't set
the return value in the coroutine entry stub yet. To avoid race
conditions there, we need to kick after setting the return value.

The race window is small enough that the problem doesn't usually surface
in the common path. However, it does surface and causes easily
reproducible hangs if the operation can return early before even calling
bdrv_inc/dec_in_flight, which many of them do (trivial error or no-op
success paths).

The bug in bdrv_truncate(), bdrv_check() and bdrv_invalidate_cache() is
slightly different: These functions even neglected to schedule the
coroutine in the home thread of the node. This avoids the hang, but is
obviously wrong, too. Fix those to schedule the coroutine in the right
AioContext in addition to adding aio_wait_kick() calls.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block.c                     |   6 +-
 block/block-backend.c       |   5 +
 block/io.c                  |   8 +-
 block/nbd-client.c          |   1 +
 block/nvme.c                |   1 +
 block/qcow2.c               |   1 +
 block/qed.c                 |   1 +
 tests/test-block-iothread.c | 372 ++++++++++++++++++++++++++++++++++++
 tests/Makefile.include      |   2 +
 9 files changed, 394 insertions(+), 3 deletions(-)
 create mode 100644 tests/test-block-iothread.c

diff --git a/block.c b/block.c
index e795a7c5de..0c5d1f11a5 100644
--- a/block.c
+++ b/block.c
@@ -3725,6 +3725,7 @@ static void bdrv_check_co_entry(void *opaque)
 {
     CheckCo *cco =3D opaque;
     cco->ret =3D bdrv_co_check(cco->bs, cco->res, cco->fix);
+    aio_wait_kick();
 }
=20
 int bdrv_check(BlockDriverState *bs,
@@ -3743,7 +3744,7 @@ int bdrv_check(BlockDriverState *bs,
         bdrv_check_co_entry(&cco);
     } else {
         co =3D qemu_coroutine_create(bdrv_check_co_entry, &cco);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, cco.ret =3D=3D -EINPROGRESS);
     }
=20
@@ -4708,6 +4709,7 @@ static void coroutine_fn bdrv_invalidate_cache_co_e=
ntry(void *opaque)
     InvalidateCacheCo *ico =3D opaque;
     bdrv_co_invalidate_cache(ico->bs, ico->errp);
     ico->done =3D true;
+    aio_wait_kick();
 }
=20
 void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
@@ -4724,7 +4726,7 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Er=
ror **errp)
         bdrv_invalidate_cache_co_entry(&ico);
     } else {
         co =3D qemu_coroutine_create(bdrv_invalidate_cache_co_entry, &ic=
o);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !ico.done);
     }
 }
diff --git a/block/block-backend.c b/block/block-backend.c
index cf05abd89d..f0be0d9039 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1220,6 +1220,7 @@ static void blk_read_entry(void *opaque)
=20
     rwco->ret =3D blk_co_preadv(rwco->blk, rwco->offset, qiov->size,
                               qiov, rwco->flags);
+    aio_wait_kick();
 }
=20
 static void blk_write_entry(void *opaque)
@@ -1229,6 +1230,7 @@ static void blk_write_entry(void *opaque)
=20
     rwco->ret =3D blk_co_pwritev(rwco->blk, rwco->offset, qiov->size,
                                qiov, rwco->flags);
+    aio_wait_kick();
 }
=20
 static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
@@ -1540,6 +1542,7 @@ static void blk_ioctl_entry(void *opaque)
=20
     rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset,
                              qiov->iov[0].iov_base);
+    aio_wait_kick();
 }
=20
 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf)
@@ -1586,6 +1589,7 @@ static void blk_flush_entry(void *opaque)
 {
     BlkRwCo *rwco =3D opaque;
     rwco->ret =3D blk_co_flush(rwco->blk);
+    aio_wait_kick();
 }
=20
 int blk_flush(BlockBackend *blk)
@@ -2018,6 +2022,7 @@ static void blk_pdiscard_entry(void *opaque)
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
     rwco->ret =3D blk_co_pdiscard(rwco->blk, rwco->offset, qiov->size);
+    aio_wait_kick();
 }
=20
 int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
diff --git a/block/io.c b/block/io.c
index bd9d688f8b..213ca03d8d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -806,6 +806,7 @@ static void coroutine_fn bdrv_rw_co_entry(void *opaqu=
e)
                                     rwco->qiov->size, rwco->qiov,
                                     rwco->flags);
     }
+    aio_wait_kick();
 }
=20
 /*
@@ -2279,6 +2280,7 @@ static void coroutine_fn bdrv_block_status_above_co=
_entry(void *opaque)
                                            data->offset, data->bytes,
                                            data->pnum, data->map, data->=
file);
     data->done =3D true;
+    aio_wait_kick();
 }
=20
 /*
@@ -2438,6 +2440,7 @@ static void coroutine_fn bdrv_co_rw_vmstate_entry(v=
oid *opaque)
 {
     BdrvVmstateCo *co =3D opaque;
     co->ret =3D bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_rea=
d);
+    aio_wait_kick();
 }
=20
 static inline int
@@ -2559,6 +2562,7 @@ static void coroutine_fn bdrv_flush_co_entry(void *=
opaque)
     FlushCo *rwco =3D opaque;
=20
     rwco->ret =3D bdrv_co_flush(rwco->bs);
+    aio_wait_kick();
 }
=20
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
@@ -2704,6 +2708,7 @@ static void coroutine_fn bdrv_pdiscard_co_entry(voi=
d *opaque)
     DiscardCo *rwco =3D opaque;
=20
     rwco->ret =3D bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->byte=
s);
+    aio_wait_kick();
 }
=20
 int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int =
bytes)
@@ -3217,6 +3222,7 @@ static void coroutine_fn bdrv_truncate_co_entry(voi=
d *opaque)
     TruncateCo *tco =3D opaque;
     tco->ret =3D bdrv_co_truncate(tco->child, tco->offset, tco->prealloc=
,
                                 tco->errp);
+    aio_wait_kick();
 }
=20
 int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode preallo=
c,
@@ -3236,7 +3242,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset,=
 PreallocMode prealloc,
         bdrv_truncate_co_entry(&tco);
     } else {
         co =3D qemu_coroutine_create(bdrv_truncate_co_entry, &tco);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(child->bs, co);
         BDRV_POLL_WHILE(child->bs, tco.ret =3D=3D NOT_DONE);
     }
=20
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 813539676d..50a8dadd85 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -119,6 +119,7 @@ static coroutine_fn void nbd_read_reply_entry(void *o=
paque)
     s->quit =3D true;
     nbd_recv_coroutines_wake_all(s);
     s->read_reply_co =3D NULL;
+    aio_wait_kick();
 }
=20
 static int nbd_co_send_request(BlockDriverState *bs,
diff --git a/block/nvme.c b/block/nvme.c
index 982097b5b1..b5952c9b08 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -390,6 +390,7 @@ static void nvme_cmd_sync_cb(void *opaque, int ret)
 {
     int *pret =3D opaque;
     *pret =3D ret;
+    aio_wait_kick();
 }
=20
 static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
diff --git a/block/qcow2.c b/block/qcow2.c
index 4897abae5e..8c91b92865 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1671,6 +1671,7 @@ static int qcow2_open(BlockDriverState *bs, QDict *=
options, int flags,
         /* From bdrv_co_create.  */
         qcow2_open_entry(&qoc);
     } else {
+        assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_contex=
t());
         qemu_coroutine_enter(qemu_coroutine_create(qcow2_open_entry, &qo=
c));
         BDRV_POLL_WHILE(bs, qoc.ret =3D=3D -EINPROGRESS);
     }
diff --git a/block/qed.c b/block/qed.c
index 9377c0b7ad..1280870024 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -559,6 +559,7 @@ static int bdrv_qed_open(BlockDriverState *bs, QDict =
*options, int flags,
     if (qemu_in_coroutine()) {
         bdrv_qed_open_entry(&qoc);
     } else {
+        assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_contex=
t());
         qemu_coroutine_enter(qemu_coroutine_create(bdrv_qed_open_entry, =
&qoc));
         BDRV_POLL_WHILE(bs, qoc.ret =3D=3D -EINPROGRESS);
     }
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
new file mode 100644
index 0000000000..97ac0b159d
--- /dev/null
+++ b/tests/test-block-iothread.c
@@ -0,0 +1,372 @@
+/*
+ * Block tests for iothreads
+ *
+ * Copyright (c) 2018 Kevin Wolf <kwolf@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block.h"
+#include "block/blockjob_int.h"
+#include "sysemu/block-backend.h"
+#include "qapi/error.h"
+#include "iothread.h"
+
+static int coroutine_fn bdrv_test_co_prwv(BlockDriverState *bs,
+                                          uint64_t offset, uint64_t byte=
s,
+                                          QEMUIOVector *qiov, int flags)
+{
+    return 0;
+}
+
+static int coroutine_fn bdrv_test_co_pdiscard(BlockDriverState *bs,
+                                              int64_t offset, int bytes)
+{
+    return 0;
+}
+
+static int coroutine_fn
+bdrv_test_co_truncate(BlockDriverState *bs, int64_t offset,
+                      PreallocMode prealloc, Error **errp)
+{
+    return 0;
+}
+
+static int coroutine_fn bdrv_test_co_block_status(BlockDriverState *bs,
+                                                  bool want_zero,
+                                                  int64_t offset, int64_=
t count,
+                                                  int64_t *pnum, int64_t=
 *map,
+                                                  BlockDriverState **fil=
e)
+{
+    *pnum =3D count;
+    return 0;
+}
+
+static BlockDriver bdrv_test =3D {
+    .format_name            =3D "test",
+    .instance_size          =3D 1,
+
+    .bdrv_co_preadv         =3D bdrv_test_co_prwv,
+    .bdrv_co_pwritev        =3D bdrv_test_co_prwv,
+    .bdrv_co_pdiscard       =3D bdrv_test_co_pdiscard,
+    .bdrv_co_truncate       =3D bdrv_test_co_truncate,
+    .bdrv_co_block_status   =3D bdrv_test_co_block_status,
+};
+
+static void test_sync_op_pread(BdrvChild *c)
+{
+    uint8_t buf[512];
+    int ret;
+
+    /* Success */
+    ret =3D bdrv_pread(c, 0, buf, sizeof(buf));
+    g_assert_cmpint(ret, =3D=3D, 512);
+
+    /* Early error: Negative offset */
+    ret =3D bdrv_pread(c, -2, buf, sizeof(buf));
+    g_assert_cmpint(ret, =3D=3D, -EIO);
+}
+
+static void test_sync_op_pwrite(BdrvChild *c)
+{
+    uint8_t buf[512];
+    int ret;
+
+    /* Success */
+    ret =3D bdrv_pwrite(c, 0, buf, sizeof(buf));
+    g_assert_cmpint(ret, =3D=3D, 512);
+
+    /* Early error: Negative offset */
+    ret =3D bdrv_pwrite(c, -2, buf, sizeof(buf));
+    g_assert_cmpint(ret, =3D=3D, -EIO);
+}
+
+static void test_sync_op_blk_pread(BlockBackend *blk)
+{
+    uint8_t buf[512];
+    int ret;
+
+    /* Success */
+    ret =3D blk_pread(blk, 0, buf, sizeof(buf));
+    g_assert_cmpint(ret, =3D=3D, 512);
+
+    /* Early error: Negative offset */
+    ret =3D blk_pread(blk, -2, buf, sizeof(buf));
+    g_assert_cmpint(ret, =3D=3D, -EIO);
+}
+
+static void test_sync_op_blk_pwrite(BlockBackend *blk)
+{
+    uint8_t buf[512];
+    int ret;
+
+    /* Success */
+    ret =3D blk_pwrite(blk, 0, buf, sizeof(buf), 0);
+    g_assert_cmpint(ret, =3D=3D, 512);
+
+    /* Early error: Negative offset */
+    ret =3D blk_pwrite(blk, -2, buf, sizeof(buf), 0);
+    g_assert_cmpint(ret, =3D=3D, -EIO);
+}
+
+static void test_sync_op_load_vmstate(BdrvChild *c)
+{
+    uint8_t buf[512];
+    int ret;
+
+    /* Error: Driver does not support snapshots */
+    ret =3D bdrv_load_vmstate(c->bs, buf, 0, sizeof(buf));
+    g_assert_cmpint(ret, =3D=3D, -ENOTSUP);
+}
+
+static void test_sync_op_save_vmstate(BdrvChild *c)
+{
+    uint8_t buf[512];
+    int ret;
+
+    /* Error: Driver does not support snapshots */
+    ret =3D bdrv_save_vmstate(c->bs, buf, 0, sizeof(buf));
+    g_assert_cmpint(ret, =3D=3D, -ENOTSUP);
+}
+
+static void test_sync_op_pdiscard(BdrvChild *c)
+{
+    int ret;
+
+    /* Normal success path */
+    c->bs->open_flags |=3D BDRV_O_UNMAP;
+    ret =3D bdrv_pdiscard(c, 0, 512);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* Early success: UNMAP not supported */
+    c->bs->open_flags &=3D ~BDRV_O_UNMAP;
+    ret =3D bdrv_pdiscard(c, 0, 512);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* Early error: Negative offset */
+    ret =3D bdrv_pdiscard(c, -2, 512);
+    g_assert_cmpint(ret, =3D=3D, -EIO);
+}
+
+static void test_sync_op_blk_pdiscard(BlockBackend *blk)
+{
+    int ret;
+
+    /* Early success: UNMAP not supported */
+    ret =3D blk_pdiscard(blk, 0, 512);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* Early error: Negative offset */
+    ret =3D blk_pdiscard(blk, -2, 512);
+    g_assert_cmpint(ret, =3D=3D, -EIO);
+}
+
+static void test_sync_op_truncate(BdrvChild *c)
+{
+    int ret;
+
+    /* Normal success path */
+    ret =3D bdrv_truncate(c, 65536, PREALLOC_MODE_OFF, NULL);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* Early error: Negative offset */
+    ret =3D bdrv_truncate(c, -2, PREALLOC_MODE_OFF, NULL);
+    g_assert_cmpint(ret, =3D=3D, -EINVAL);
+
+    /* Error: Read-only image */
+    c->bs->read_only =3D true;
+    c->bs->open_flags &=3D ~BDRV_O_RDWR;
+
+    ret =3D bdrv_truncate(c, 65536, PREALLOC_MODE_OFF, NULL);
+    g_assert_cmpint(ret, =3D=3D, -EACCES);
+
+    c->bs->read_only =3D false;
+    c->bs->open_flags |=3D BDRV_O_RDWR;
+}
+
+static void test_sync_op_block_status(BdrvChild *c)
+{
+    int ret;
+    int64_t n;
+
+    /* Normal success path */
+    ret =3D bdrv_is_allocated(c->bs, 0, 65536, &n);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* Early success: No driver support */
+    bdrv_test.bdrv_co_block_status =3D NULL;
+    ret =3D bdrv_is_allocated(c->bs, 0, 65536, &n);
+    g_assert_cmpint(ret, =3D=3D, 1);
+
+    /* Early success: bytes =3D 0 */
+    ret =3D bdrv_is_allocated(c->bs, 0, 0, &n);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* Early success: Offset > image size*/
+    ret =3D bdrv_is_allocated(c->bs, 0x1000000, 0x1000000, &n);
+    g_assert_cmpint(ret, =3D=3D, 0);
+}
+
+static void test_sync_op_flush(BdrvChild *c)
+{
+    int ret;
+
+    /* Normal success path */
+    ret =3D bdrv_flush(c->bs);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* Early success: Read-only image */
+    c->bs->read_only =3D true;
+    c->bs->open_flags &=3D ~BDRV_O_RDWR;
+
+    ret =3D bdrv_flush(c->bs);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    c->bs->read_only =3D false;
+    c->bs->open_flags |=3D BDRV_O_RDWR;
+}
+
+static void test_sync_op_blk_flush(BlockBackend *blk)
+{
+    BlockDriverState *bs =3D blk_bs(blk);
+    int ret;
+
+    /* Normal success path */
+    ret =3D blk_flush(blk);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* Early success: Read-only image */
+    bs->read_only =3D true;
+    bs->open_flags &=3D ~BDRV_O_RDWR;
+
+    ret =3D blk_flush(blk);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    bs->read_only =3D false;
+    bs->open_flags |=3D BDRV_O_RDWR;
+}
+
+static void test_sync_op_check(BdrvChild *c)
+{
+    BdrvCheckResult result;
+    int ret;
+
+    /* Error: Driver does not implement check */
+    ret =3D bdrv_check(c->bs, &result, 0);
+    g_assert_cmpint(ret, =3D=3D, -ENOTSUP);
+}
+
+static void test_sync_op_invalidate_cache(BdrvChild *c)
+{
+    /* Early success: Image is not inactive */
+    bdrv_invalidate_cache(c->bs, NULL);
+}
+
+
+typedef struct SyncOpTest {
+    const char *name;
+    void (*fn)(BdrvChild *c);
+    void (*blkfn)(BlockBackend *blk);
+} SyncOpTest;
+
+const SyncOpTest sync_op_tests[] =3D {
+    {
+        .name   =3D "/sync-op/pread",
+        .fn     =3D test_sync_op_pread,
+        .blkfn  =3D test_sync_op_blk_pread,
+    }, {
+        .name   =3D "/sync-op/pwrite",
+        .fn     =3D test_sync_op_pwrite,
+        .blkfn  =3D test_sync_op_blk_pwrite,
+    }, {
+        .name   =3D "/sync-op/load_vmstate",
+        .fn     =3D test_sync_op_load_vmstate,
+    }, {
+        .name   =3D "/sync-op/save_vmstate",
+        .fn     =3D test_sync_op_save_vmstate,
+    }, {
+        .name   =3D "/sync-op/pdiscard",
+        .fn     =3D test_sync_op_pdiscard,
+        .blkfn  =3D test_sync_op_blk_pdiscard,
+    }, {
+        .name   =3D "/sync-op/truncate",
+        .fn     =3D test_sync_op_truncate,
+    }, {
+        .name   =3D "/sync-op/block_status",
+        .fn     =3D test_sync_op_block_status,
+    }, {
+        .name   =3D "/sync-op/flush",
+        .fn     =3D test_sync_op_flush,
+        .blkfn  =3D test_sync_op_blk_flush,
+    }, {
+        .name   =3D "/sync-op/check",
+        .fn     =3D test_sync_op_check,
+    }, {
+        .name   =3D "/sync-op/invalidate_cache",
+        .fn     =3D test_sync_op_invalidate_cache,
+    },
+};
+
+/* Test synchronous operations that run in a different iothread, so we h=
ave to
+ * poll for the coroutine there to return. */
+static void test_sync_op(const void *opaque)
+{
+    const SyncOpTest *t =3D opaque;
+    IOThread *iothread =3D iothread_new();
+    AioContext *ctx =3D iothread_get_aio_context(iothread);
+    BlockBackend *blk;
+    BlockDriverState *bs;
+    BdrvChild *c;
+
+    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    bs =3D bdrv_new_open_driver(&bdrv_test, "base", BDRV_O_RDWR, &error_=
abort);
+    bs->total_sectors =3D 65536 / BDRV_SECTOR_SIZE;
+    blk_insert_bs(blk, bs, &error_abort);
+    c =3D QLIST_FIRST(&bs->parents);
+
+    blk_set_aio_context(blk, ctx);
+    aio_context_acquire(ctx);
+    t->fn(c);
+    if (t->blkfn) {
+        t->blkfn(blk);
+    }
+    aio_context_release(ctx);
+    blk_set_aio_context(blk, qemu_get_aio_context());
+
+    bdrv_unref(bs);
+    blk_unref(blk);
+}
+
+int main(int argc, char **argv)
+{
+    int i;
+
+    bdrv_init();
+    qemu_init_main_loop(&error_abort);
+
+    g_test_init(&argc, &argv, NULL);
+
+    for (i =3D 0; i < ARRAY_SIZE(sync_op_tests); i++) {
+        const SyncOpTest *t =3D &sync_op_tests[i];
+        g_test_add_data_func(t->name, t, test_sync_op);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 19b4c0a696..75ad9c0dd3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -73,6 +73,7 @@ check-unit-y +=3D tests/test-bdrv-drain$(EXESUF)
 check-unit-y +=3D tests/test-blockjob$(EXESUF)
 check-unit-y +=3D tests/test-blockjob-txn$(EXESUF)
 check-unit-y +=3D tests/test-block-backend$(EXESUF)
+check-unit-y +=3D tests/test-block-iothread$(EXESUF)
 check-unit-y +=3D tests/test-image-locking$(EXESUF)
 check-unit-y +=3D tests/test-x86-cpuid$(EXESUF)
 # all code tested by test-x86-cpuid is inside topology.h
@@ -557,6 +558,7 @@ tests/test-bdrv-drain$(EXESUF): tests/test-bdrv-drain=
.o $(test-block-obj-y) $(te
 tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) =
$(test-util-obj-y)
 tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block=
-obj-y) $(test-util-obj-y)
 tests/test-block-backend$(EXESUF): tests/test-block-backend.o $(test-blo=
ck-obj-y) $(test-util-obj-y)
+tests/test-block-iothread$(EXESUF): tests/test-block-iothread.o $(test-b=
lock-obj-y) $(test-util-obj-y)
 tests/test-image-locking$(EXESUF): tests/test-image-locking.o $(test-blo=
ck-obj-y) $(test-util-obj-y)
 tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-o=
bj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
--=20
2.20.1
