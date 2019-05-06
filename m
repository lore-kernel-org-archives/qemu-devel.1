Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040E4C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C090C20830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C090C20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhLB-0001OG-Vd
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:23:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFv-0005YP-D6
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFu-0004wm-80
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hNhFr-0004t9-8Z; Mon, 06 May 2019 13:18:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F04C301BE66;
	Mon,  6 May 2019 17:18:18 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-82.ams2.redhat.com
	[10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 534781001DF9;
	Mon,  6 May 2019 17:18:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 19:18:00 +0200
Message-Id: <20190506171805.14236-6-kwolf@redhat.com>
In-Reply-To: <20190506171805.14236-1-kwolf@redhat.com>
References: <20190506171805.14236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 06 May 2019 17:18:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 05/10] test-block-iothread: Test AioContext
 propagation through the tree
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-block-iothread.c | 131 ++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 036ed9a3b3..938831c9bd 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -27,6 +27,7 @@
 #include "block/blockjob_int.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "iothread.h"
=20
 static int coroutine_fn bdrv_test_co_prwv(BlockDriverState *bs,
@@ -459,6 +460,134 @@ static void test_attach_blockjob(void)
     blk_unref(blk);
 }
=20
+/*
+ * Test that changing the AioContext for one node in a tree (here throug=
h blk)
+ * changes all other nodes as well:
+ *
+ *  blk
+ *   |
+ *   |  bs_verify [blkverify]
+ *   |   /               \
+ *   |  /                 \
+ *  bs_a [bdrv_test]    bs_b [bdrv_test]
+ *
+ */
+static void test_propagate_basic(void)
+{
+    IOThread *iothread =3D iothread_new();
+    AioContext *ctx =3D iothread_get_aio_context(iothread);
+    BlockBackend *blk;
+    BlockDriverState *bs_a, *bs_b, *bs_verify;
+    QDict *options;
+
+    /* Create bs_a and its BlockBackend */
+    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    bs_a =3D bdrv_new_open_driver(&bdrv_test, "bs_a", BDRV_O_RDWR, &erro=
r_abort);
+    blk_insert_bs(blk, bs_a, &error_abort);
+
+    /* Create bs_b */
+    bs_b =3D bdrv_new_open_driver(&bdrv_test, "bs_b", BDRV_O_RDWR, &erro=
r_abort);
+
+    /* Create blkverify filter that references both bs_a and bs_b */
+    options =3D qdict_new();
+    qdict_put_str(options, "driver", "blkverify");
+    qdict_put_str(options, "test", "bs_a");
+    qdict_put_str(options, "raw", "bs_b");
+
+    bs_verify =3D bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abo=
rt);
+
+    /* Switch the AioContext */
+    blk_set_aio_context(blk, ctx);
+    g_assert(blk_get_aio_context(blk) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_a) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_verify) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_b) =3D=3D ctx);
+
+    /* Switch the AioContext back */
+    ctx =3D qemu_get_aio_context();
+    blk_set_aio_context(blk, ctx);
+    g_assert(blk_get_aio_context(blk) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_a) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_verify) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_b) =3D=3D ctx);
+
+    bdrv_unref(bs_verify);
+    bdrv_unref(bs_b);
+    bdrv_unref(bs_a);
+    blk_unref(blk);
+}
+
+/*
+ * Test that diamonds in the graph don't lead to endless recursion:
+ *
+ *              blk
+ *               |
+ *      bs_verify [blkverify]
+ *       /              \
+ *      /                \
+ *   bs_b [raw]         bs_c[raw]
+ *      \                /
+ *       \              /
+ *       bs_a [bdrv_test]
+ */
+static void test_propagate_diamond(void)
+{
+    IOThread *iothread =3D iothread_new();
+    AioContext *ctx =3D iothread_get_aio_context(iothread);
+    BlockBackend *blk;
+    BlockDriverState *bs_a, *bs_b, *bs_c, *bs_verify;
+    QDict *options;
+
+    /* Create bs_a */
+    bs_a =3D bdrv_new_open_driver(&bdrv_test, "bs_a", BDRV_O_RDWR, &erro=
r_abort);
+
+    /* Create bs_b and bc_c */
+    options =3D qdict_new();
+    qdict_put_str(options, "driver", "raw");
+    qdict_put_str(options, "file", "bs_a");
+    qdict_put_str(options, "node-name", "bs_b");
+    bs_b =3D bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abort);
+
+    options =3D qdict_new();
+    qdict_put_str(options, "driver", "raw");
+    qdict_put_str(options, "file", "bs_a");
+    qdict_put_str(options, "node-name", "bs_c");
+    bs_c =3D bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abort);
+
+    /* Create blkverify filter that references both bs_b and bs_c */
+    options =3D qdict_new();
+    qdict_put_str(options, "driver", "blkverify");
+    qdict_put_str(options, "test", "bs_b");
+    qdict_put_str(options, "raw", "bs_c");
+
+    bs_verify =3D bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abo=
rt);
+    blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
+    blk_insert_bs(blk, bs_verify, &error_abort);
+
+    /* Switch the AioContext */
+    blk_set_aio_context(blk, ctx);
+    g_assert(blk_get_aio_context(blk) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_verify) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_a) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_b) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_c) =3D=3D ctx);
+
+    /* Switch the AioContext back */
+    ctx =3D qemu_get_aio_context();
+    blk_set_aio_context(blk, ctx);
+    g_assert(blk_get_aio_context(blk) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_verify) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_a) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_b) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs_c) =3D=3D ctx);
+
+    blk_unref(blk);
+    bdrv_unref(bs_verify);
+    bdrv_unref(bs_c);
+    bdrv_unref(bs_b);
+    bdrv_unref(bs_a);
+}
+
 int main(int argc, char **argv)
 {
     int i;
@@ -474,6 +603,8 @@ int main(int argc, char **argv)
     }
=20
     g_test_add_func("/attach/blockjob", test_attach_blockjob);
+    g_test_add_func("/propagate/basic", test_propagate_basic);
+    g_test_add_func("/propagate/diamond", test_propagate_diamond);
=20
     return g_test_run();
 }
--=20
2.20.1


