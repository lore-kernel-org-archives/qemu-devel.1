Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4855AC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD9E20830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD9E20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59770 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhNh-0003op-CK
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:26:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhG4-0005hu-GY
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhG1-00055Y-JP
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hNhFz-00052T-08; Mon, 06 May 2019 13:18:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5169C3092671;
	Mon,  6 May 2019 17:18:26 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-82.ams2.redhat.com
	[10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B42B10021B1;
	Mon,  6 May 2019 17:18:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 19:18:05 +0200
Message-Id: <20190506171805.14236-11-kwolf@redhat.com>
In-Reply-To: <20190506171805.14236-1-kwolf@redhat.com>
References: <20190506171805.14236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 06 May 2019 17:18:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 10/10] test-block-iothread: Test AioContext
 propagation for block jobs
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
 tests/test-block-iothread.c | 71 +++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 938831c9bd..59f692892e 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -588,6 +588,76 @@ static void test_propagate_diamond(void)
     bdrv_unref(bs_a);
 }
=20
+static void test_propagate_mirror(void)
+{
+    IOThread *iothread =3D iothread_new();
+    AioContext *ctx =3D iothread_get_aio_context(iothread);
+    AioContext *main_ctx =3D qemu_get_aio_context();
+    BlockDriverState *src, *target;
+    BlockBackend *blk;
+    Job *job;
+    Error *local_err =3D NULL;
+
+    /* Create src and target*/
+    src =3D bdrv_new_open_driver(&bdrv_test, "src", BDRV_O_RDWR, &error_=
abort);
+    target =3D bdrv_new_open_driver(&bdrv_test, "target", BDRV_O_RDWR,
+                                  &error_abort);
+
+    /* Start a mirror job */
+    mirror_start("job0", src, target, NULL, JOB_DEFAULT, 0, 0, 0,
+                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN,
+                 BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
+                 false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
+                 &error_abort);
+    job =3D job_get("job0");
+
+    /* Change the AioContext of src */
+    bdrv_try_set_aio_context(src, ctx, &error_abort);
+    g_assert(bdrv_get_aio_context(src) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(target) =3D=3D ctx);
+    g_assert(job->aio_context =3D=3D ctx);
+
+    /* Change the AioContext of target */
+    aio_context_acquire(ctx);
+    bdrv_try_set_aio_context(target, main_ctx, &error_abort);
+    aio_context_release(ctx);
+    g_assert(bdrv_get_aio_context(src) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(target) =3D=3D main_ctx);
+
+    /* With a BlockBackend on src, changing target must fail */
+    blk =3D blk_new(0, BLK_PERM_ALL);
+    blk_insert_bs(blk, src, &error_abort);
+
+    bdrv_try_set_aio_context(target, ctx, &local_err);
+    g_assert(local_err);
+    error_free(local_err);
+
+    g_assert(blk_get_aio_context(blk) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(src) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(target) =3D=3D main_ctx);
+
+    /* ...unless we explicitly allow it */
+    aio_context_acquire(ctx);
+    blk_set_allow_aio_context_change(blk, true);
+    bdrv_try_set_aio_context(target, ctx, &error_abort);
+    aio_context_release(ctx);
+
+    g_assert(blk_get_aio_context(blk) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(src) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(target) =3D=3D ctx);
+
+    job_cancel_sync_all();
+
+    aio_context_acquire(ctx);
+    blk_set_aio_context(blk, main_ctx);
+    bdrv_try_set_aio_context(target, main_ctx, &error_abort);
+    aio_context_release(ctx);
+
+    blk_unref(blk);
+    bdrv_unref(src);
+    bdrv_unref(target);
+}
+
 int main(int argc, char **argv)
 {
     int i;
@@ -605,6 +675,7 @@ int main(int argc, char **argv)
     g_test_add_func("/attach/blockjob", test_attach_blockjob);
     g_test_add_func("/propagate/basic", test_propagate_basic);
     g_test_add_func("/propagate/diamond", test_propagate_diamond);
+    g_test_add_func("/propagate/mirror", test_propagate_mirror);
=20
     return g_test_run();
 }
--=20
2.20.1


