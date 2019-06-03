Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8985C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FEE279D7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FEE279D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXoaT-0004ll-04
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:09:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUz-0000j1-Ku
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUy-0007xG-Fr
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoUv-0007sG-Ux; Mon, 03 Jun 2019 11:03:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46C443107B1C;
	Mon,  3 Jun 2019 15:03:36 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87A5867279;
	Mon,  3 Jun 2019 15:03:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:15 +0200
Message-Id: <20190603150233.6614-11-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 03 Jun 2019 15:03:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/28] test-block-iothread: Check filter node in
 test_propagate_mirror
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just make the test cover the AioContext of the filter node as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-block-iothread.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 59f692892e..e424d360c8 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -593,7 +593,7 @@ static void test_propagate_mirror(void)
     IOThread *iothread =3D iothread_new();
     AioContext *ctx =3D iothread_get_aio_context(iothread);
     AioContext *main_ctx =3D qemu_get_aio_context();
-    BlockDriverState *src, *target;
+    BlockDriverState *src, *target, *filter;
     BlockBackend *blk;
     Job *job;
     Error *local_err =3D NULL;
@@ -610,11 +610,13 @@ static void test_propagate_mirror(void)
                  false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
                  &error_abort);
     job =3D job_get("job0");
+    filter =3D bdrv_find_node("filter_node");
=20
     /* Change the AioContext of src */
     bdrv_try_set_aio_context(src, ctx, &error_abort);
     g_assert(bdrv_get_aio_context(src) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(target) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(filter) =3D=3D ctx);
     g_assert(job->aio_context =3D=3D ctx);
=20
     /* Change the AioContext of target */
@@ -623,6 +625,7 @@ static void test_propagate_mirror(void)
     aio_context_release(ctx);
     g_assert(bdrv_get_aio_context(src) =3D=3D main_ctx);
     g_assert(bdrv_get_aio_context(target) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(filter) =3D=3D main_ctx);
=20
     /* With a BlockBackend on src, changing target must fail */
     blk =3D blk_new(0, BLK_PERM_ALL);
@@ -635,6 +638,7 @@ static void test_propagate_mirror(void)
     g_assert(blk_get_aio_context(blk) =3D=3D main_ctx);
     g_assert(bdrv_get_aio_context(src) =3D=3D main_ctx);
     g_assert(bdrv_get_aio_context(target) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(filter) =3D=3D main_ctx);
=20
     /* ...unless we explicitly allow it */
     aio_context_acquire(ctx);
@@ -645,6 +649,7 @@ static void test_propagate_mirror(void)
     g_assert(blk_get_aio_context(blk) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(src) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(target) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(filter) =3D=3D ctx);
=20
     job_cancel_sync_all();
=20
--=20
2.20.1


