Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC489C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A6F20880
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A6F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPAj-000543-Hy
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37777)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hoPAB-0003CE-4o
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hoPA9-00065r-U6
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:26:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hoPA7-00063Z-6s; Fri, 19 Jul 2019 05:26:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8DF79307D85B;
 Fri, 19 Jul 2019 09:26:46 +0000 (UTC)
Received: from localhost (unknown [10.40.205.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0742461B6A;
 Fri, 19 Jul 2019 09:26:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 11:26:13 +0200
Message-Id: <20190719092618.24891-6-mreitz@redhat.com>
In-Reply-To: <20190719092618.24891-1-mreitz@redhat.com>
References: <20190719092618.24891-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 19 Jul 2019 09:26:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 05/10] tests: Lock AioContexts in
 test-block-iothread
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When changing a node's AioContext, the caller must acquire the old
AioContext (unless it currently runs in that old context).  Therefore,
unless the node currently is in the main context, we always have to
acquire the old context around calls that may change a node's
AioContext.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/test-block-iothread.c | 40 ++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 79d9cf8a57..1949d5e61a 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -348,8 +348,8 @@ static void test_sync_op(const void *opaque)
     if (t->blkfn) {
         t->blkfn(blk);
     }
-    aio_context_release(ctx);
     blk_set_aio_context(blk, qemu_get_aio_context(), &error_abort);
+    aio_context_release(ctx);
=20
     bdrv_unref(bs);
     blk_unref(blk);
@@ -476,6 +476,7 @@ static void test_propagate_basic(void)
 {
     IOThread *iothread =3D iothread_new();
     AioContext *ctx =3D iothread_get_aio_context(iothread);
+    AioContext *main_ctx;
     BlockBackend *blk;
     BlockDriverState *bs_a, *bs_b, *bs_verify;
     QDict *options;
@@ -504,12 +505,14 @@ static void test_propagate_basic(void)
     g_assert(bdrv_get_aio_context(bs_b) =3D=3D ctx);
=20
     /* Switch the AioContext back */
-    ctx =3D qemu_get_aio_context();
-    blk_set_aio_context(blk, ctx, &error_abort);
-    g_assert(blk_get_aio_context(blk) =3D=3D ctx);
-    g_assert(bdrv_get_aio_context(bs_a) =3D=3D ctx);
-    g_assert(bdrv_get_aio_context(bs_verify) =3D=3D ctx);
-    g_assert(bdrv_get_aio_context(bs_b) =3D=3D ctx);
+    main_ctx =3D qemu_get_aio_context();
+    aio_context_acquire(ctx);
+    blk_set_aio_context(blk, main_ctx, &error_abort);
+    aio_context_release(ctx);
+    g_assert(blk_get_aio_context(blk) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(bs_a) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(bs_verify) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(bs_b) =3D=3D main_ctx);
=20
     bdrv_unref(bs_verify);
     bdrv_unref(bs_b);
@@ -534,6 +537,7 @@ static void test_propagate_diamond(void)
 {
     IOThread *iothread =3D iothread_new();
     AioContext *ctx =3D iothread_get_aio_context(iothread);
+    AioContext *main_ctx;
     BlockBackend *blk;
     BlockDriverState *bs_a, *bs_b, *bs_c, *bs_verify;
     QDict *options;
@@ -573,13 +577,15 @@ static void test_propagate_diamond(void)
     g_assert(bdrv_get_aio_context(bs_c) =3D=3D ctx);
=20
     /* Switch the AioContext back */
-    ctx =3D qemu_get_aio_context();
-    blk_set_aio_context(blk, ctx, &error_abort);
-    g_assert(blk_get_aio_context(blk) =3D=3D ctx);
-    g_assert(bdrv_get_aio_context(bs_verify) =3D=3D ctx);
-    g_assert(bdrv_get_aio_context(bs_a) =3D=3D ctx);
-    g_assert(bdrv_get_aio_context(bs_b) =3D=3D ctx);
-    g_assert(bdrv_get_aio_context(bs_c) =3D=3D ctx);
+    main_ctx =3D qemu_get_aio_context();
+    aio_context_acquire(ctx);
+    blk_set_aio_context(blk, main_ctx, &error_abort);
+    aio_context_release(ctx);
+    g_assert(blk_get_aio_context(blk) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(bs_verify) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(bs_a) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(bs_b) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(bs_c) =3D=3D main_ctx);
=20
     blk_unref(blk);
     bdrv_unref(bs_verify);
@@ -685,7 +691,9 @@ static void test_attach_second_node(void)
     g_assert(bdrv_get_aio_context(bs) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(filter) =3D=3D ctx);
=20
+    aio_context_acquire(ctx);
     blk_set_aio_context(blk, main_ctx, &error_abort);
+    aio_context_release(ctx);
     g_assert(blk_get_aio_context(blk) =3D=3D main_ctx);
     g_assert(bdrv_get_aio_context(bs) =3D=3D main_ctx);
     g_assert(bdrv_get_aio_context(filter) =3D=3D main_ctx);
@@ -712,7 +720,9 @@ static void test_attach_preserve_blk_ctx(void)
     g_assert(bdrv_get_aio_context(bs) =3D=3D ctx);
=20
     /* Remove the node again */
+    aio_context_acquire(ctx);
     blk_remove_bs(blk);
+    aio_context_release(ctx);
     g_assert(blk_get_aio_context(blk) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(bs) =3D=3D qemu_get_aio_context());
=20
@@ -721,7 +731,9 @@ static void test_attach_preserve_blk_ctx(void)
     g_assert(blk_get_aio_context(blk) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(bs) =3D=3D ctx);
=20
+    aio_context_acquire(ctx);
     blk_set_aio_context(blk, qemu_get_aio_context(), &error_abort);
+    aio_context_release(ctx);
     bdrv_unref(bs);
     blk_unref(blk);
 }
--=20
2.21.0


