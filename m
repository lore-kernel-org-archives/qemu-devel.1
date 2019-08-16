Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBBEC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741DA2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741DA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyYjN-0006Sq-44
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 05:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyYdQ-0008Ug-PL
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyYdP-0003iR-1x
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:35:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyYdL-0003c7-5c; Fri, 16 Aug 2019 05:34:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79961306046D;
 Fri, 16 Aug 2019 09:34:54 +0000 (UTC)
Received: from localhost.localdomain.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3BAC5C205;
 Fri, 16 Aug 2019 09:34:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 11:34:33 +0200
Message-Id: <20190816093439.14262-11-kwolf@redhat.com>
In-Reply-To: <20190816093439.14262-1-kwolf@redhat.com>
References: <20190816093439.14262-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 16 Aug 2019 09:34:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/16] tests: Test mid-drain
 bdrv_replace_child_noperm()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Add a test for what happens when you call bdrv_replace_child_noperm()
for various drain situations ({old,new} child {drained,not drained}).

Most importantly, if both the old and the new child are drained, the
parent must not be undrained at any point.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 308 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 308 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 1600d41e9a..9dffd86c47 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1835,6 +1835,311 @@ static void test_drop_intermediate_poll(void)
     bdrv_unref(chain[2]);
 }
=20
+
+typedef struct BDRVReplaceTestState {
+    bool was_drained;
+    bool was_undrained;
+    bool has_read;
+
+    int drain_count;
+
+    bool yield_before_read;
+    Coroutine *io_co;
+    Coroutine *drain_co;
+} BDRVReplaceTestState;
+
+static void bdrv_replace_test_close(BlockDriverState *bs)
+{
+}
+
+/**
+ * If @bs has a backing file:
+ *   Yield if .yield_before_read is true (and wait for drain_begin to
+ *   wake us up).
+ *   Forward the read to bs->backing.  Set .has_read to true.
+ *   If drain_begin has woken us, wake it in turn.
+ *
+ * Otherwise:
+ *   Set .has_read to true and return success.
+ */
+static int coroutine_fn bdrv_replace_test_co_preadv(BlockDriverState *bs=
,
+                                                    uint64_t offset,
+                                                    uint64_t bytes,
+                                                    QEMUIOVector *qiov,
+                                                    int flags)
+{
+    BDRVReplaceTestState *s =3D bs->opaque;
+
+    if (bs->backing) {
+        int ret;
+
+        g_assert(!s->drain_count);
+
+        s->io_co =3D qemu_coroutine_self();
+        if (s->yield_before_read) {
+            s->yield_before_read =3D false;
+            qemu_coroutine_yield();
+        }
+        s->io_co =3D NULL;
+
+        ret =3D bdrv_preadv(bs->backing, offset, qiov);
+        s->has_read =3D true;
+
+        /* Wake up drain_co if it runs */
+        if (s->drain_co) {
+            aio_co_wake(s->drain_co);
+        }
+
+        return ret;
+    }
+
+    s->has_read =3D true;
+    return 0;
+}
+
+/**
+ * If .drain_count is 0, wake up .io_co if there is one; and set
+ * .was_drained.
+ * Increment .drain_count.
+ */
+static void coroutine_fn bdrv_replace_test_co_drain_begin(BlockDriverSta=
te *bs)
+{
+    BDRVReplaceTestState *s =3D bs->opaque;
+
+    if (!s->drain_count) {
+        /* Keep waking io_co up until it is done */
+        s->drain_co =3D qemu_coroutine_self();
+        while (s->io_co) {
+            aio_co_wake(s->io_co);
+            s->io_co =3D NULL;
+            qemu_coroutine_yield();
+        }
+        s->drain_co =3D NULL;
+
+        s->was_drained =3D true;
+    }
+    s->drain_count++;
+}
+
+/**
+ * Reduce .drain_count, set .was_undrained once it reaches 0.
+ * If .drain_count reaches 0 and the node has a backing file, issue a
+ * read request.
+ */
+static void coroutine_fn bdrv_replace_test_co_drain_end(BlockDriverState=
 *bs)
+{
+    BDRVReplaceTestState *s =3D bs->opaque;
+
+    g_assert(s->drain_count > 0);
+    if (!--s->drain_count) {
+        int ret;
+
+        s->was_undrained =3D true;
+
+        if (bs->backing) {
+            char data;
+            QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, &data, 1);
+
+            /* Queue a read request post-drain */
+            ret =3D bdrv_replace_test_co_preadv(bs, 0, 1, &qiov, 0);
+            g_assert(ret >=3D 0);
+        }
+    }
+}
+
+static BlockDriver bdrv_replace_test =3D {
+    .format_name            =3D "replace_test",
+    .instance_size          =3D sizeof(BDRVReplaceTestState),
+
+    .bdrv_close             =3D bdrv_replace_test_close,
+    .bdrv_co_preadv         =3D bdrv_replace_test_co_preadv,
+
+    .bdrv_co_drain_begin    =3D bdrv_replace_test_co_drain_begin,
+    .bdrv_co_drain_end      =3D bdrv_replace_test_co_drain_end,
+
+    .bdrv_child_perm        =3D bdrv_format_default_perms,
+};
+
+static void coroutine_fn test_replace_child_mid_drain_read_co(void *opaq=
ue)
+{
+    int ret;
+    char data;
+
+    ret =3D blk_co_pread(opaque, 0, 1, &data, 0);
+    g_assert(ret >=3D 0);
+}
+
+/**
+ * We test two things:
+ * (1) bdrv_replace_child_noperm() must not undrain the parent if both
+ *     children are drained.
+ * (2) bdrv_replace_child_noperm() must never flush I/O requests to a
+ *     drained child.  If the old child is drained, it must flush I/O
+ *     requests after the new one has been attached.  If the new child
+ *     is drained, it must flush I/O requests before the old one is
+ *     detached.
+ *
+ * To do so, we create one parent node and two child nodes; then
+ * attach one of the children (old_child_bs) to the parent, then
+ * drain both old_child_bs and new_child_bs according to
+ * old_drain_count and new_drain_count, respectively, and finally
+ * we invoke bdrv_replace_node() to replace old_child_bs by
+ * new_child_bs.
+ *
+ * The test block driver we use here (bdrv_replace_test) has a read
+ * function that:
+ * - For the parent node, can optionally yield, and then forwards the
+ *   read to bdrv_preadv(),
+ * - For the child node, just returns immediately.
+ *
+ * If the read yields, the drain_begin function will wake it up.
+ *
+ * The drain_end function issues a read on the parent once it is fully
+ * undrained (which simulates requests starting to come in again).
+ */
+static void do_test_replace_child_mid_drain(int old_drain_count,
+                                            int new_drain_count)
+{
+    BlockBackend *parent_blk;
+    BlockDriverState *parent_bs;
+    BlockDriverState *old_child_bs, *new_child_bs;
+    BDRVReplaceTestState *parent_s;
+    BDRVReplaceTestState *old_child_s, *new_child_s;
+    Coroutine *io_co;
+    int i;
+
+    parent_bs =3D bdrv_new_open_driver(&bdrv_replace_test, "parent", 0,
+                                     &error_abort);
+    parent_s =3D parent_bs->opaque;
+
+    parent_blk =3D blk_new(qemu_get_aio_context(),
+                         BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
+    blk_insert_bs(parent_blk, parent_bs, &error_abort);
+
+    old_child_bs =3D bdrv_new_open_driver(&bdrv_replace_test, "old-child=
", 0,
+                                        &error_abort);
+    new_child_bs =3D bdrv_new_open_driver(&bdrv_replace_test, "new-child=
", 0,
+                                        &error_abort);
+    old_child_s =3D old_child_bs->opaque;
+    new_child_s =3D new_child_bs->opaque;
+
+    /* So that we can read something */
+    parent_bs->total_sectors =3D 1;
+    old_child_bs->total_sectors =3D 1;
+    new_child_bs->total_sectors =3D 1;
+
+    bdrv_ref(old_child_bs);
+    parent_bs->backing =3D bdrv_attach_child(parent_bs, old_child_bs, "c=
hild",
+                                           &child_backing, &error_abort)=
;
+
+    for (i =3D 0; i < old_drain_count; i++) {
+        bdrv_drained_begin(old_child_bs);
+    }
+    for (i =3D 0; i < new_drain_count; i++) {
+        bdrv_drained_begin(new_child_bs);
+    }
+
+    if (!old_drain_count) {
+        /*
+         * Start a read operation that will yield, so it will not
+         * complete before the node is drained.
+         */
+        parent_s->yield_before_read =3D true;
+        io_co =3D qemu_coroutine_create(test_replace_child_mid_drain_rea=
d_co,
+                                      parent_blk);
+        qemu_coroutine_enter(io_co);
+    }
+
+    /* If we have started a read operation, it should have yielded */
+    g_assert(!parent_s->has_read);
+
+    /* Reset drained status so we can see what bdrv_replace_node() does =
*/
+    parent_s->was_drained =3D false;
+    parent_s->was_undrained =3D false;
+
+    g_assert(parent_bs->quiesce_counter =3D=3D old_drain_count);
+    bdrv_replace_node(old_child_bs, new_child_bs, &error_abort);
+    g_assert(parent_bs->quiesce_counter =3D=3D new_drain_count);
+
+    if (!old_drain_count && !new_drain_count) {
+        /*
+         * From undrained to undrained drains and undrains the parent,
+         * because bdrv_replace_node() contains a drained section for
+         * @old_child_bs.
+         */
+        g_assert(parent_s->was_drained && parent_s->was_undrained);
+    } else if (!old_drain_count && new_drain_count) {
+        /*
+         * From undrained to drained should drain the parent and keep
+         * it that way.
+         */
+        g_assert(parent_s->was_drained && !parent_s->was_undrained);
+    } else if (old_drain_count && !new_drain_count) {
+        /*
+         * From drained to undrained should undrain the parent and
+         * keep it that way.
+         */
+        g_assert(!parent_s->was_drained && parent_s->was_undrained);
+    } else /* if (old_drain_count && new_drain_count) */ {
+        /*
+         * From drained to drained must not undrain the parent at any
+         * point
+         */
+        g_assert(!parent_s->was_drained && !parent_s->was_undrained);
+    }
+
+    if (!old_drain_count || !new_drain_count) {
+        /*
+         * If !old_drain_count, we have started a read request before
+         * bdrv_replace_node().  If !new_drain_count, the parent must
+         * have been undrained at some point, and
+         * bdrv_replace_test_co_drain_end() starts a read request
+         * then.
+         */
+        g_assert(parent_s->has_read);
+    } else {
+        /*
+         * If the parent was never undrained, there is no way to start
+         * a read request.
+         */
+        g_assert(!parent_s->has_read);
+    }
+
+    /* A drained child must have not received any request */
+    g_assert(!(old_drain_count && old_child_s->has_read));
+    g_assert(!(new_drain_count && new_child_s->has_read));
+
+    for (i =3D 0; i < new_drain_count; i++) {
+        bdrv_drained_end(new_child_bs);
+    }
+    for (i =3D 0; i < old_drain_count; i++) {
+        bdrv_drained_end(old_child_bs);
+    }
+
+    /*
+     * By now, bdrv_replace_test_co_drain_end() must have been called
+     * at some point while the new child was attached to the parent.
+     */
+    g_assert(parent_s->has_read);
+    g_assert(new_child_s->has_read);
+
+    blk_unref(parent_blk);
+    bdrv_unref(parent_bs);
+    bdrv_unref(old_child_bs);
+    bdrv_unref(new_child_bs);
+}
+
+static void test_replace_child_mid_drain(void)
+{
+    int old_drain_count, new_drain_count;
+
+    for (old_drain_count =3D 0; old_drain_count < 2; old_drain_count++) =
{
+        for (new_drain_count =3D 0; new_drain_count < 2; new_drain_count=
++) {
+            do_test_replace_child_mid_drain(old_drain_count, new_drain_c=
ount);
+        }
+    }
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -1924,6 +2229,9 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/bdrv_drop_intermediate/poll",
                     test_drop_intermediate_poll);
=20
+    g_test_add_func("/bdrv-drain/replace_child/mid-drain",
+                    test_replace_child_mid_drain);
+
     ret =3D g_test_run();
     qemu_event_destroy(&done_event);
     return ret;
--=20
2.20.1


