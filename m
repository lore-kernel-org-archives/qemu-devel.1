Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB0DC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D7E2407D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D7E2407D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36426 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXof5-0000LB-1i
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:14:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVs-0001Ok-5c
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVo-00011x-AL
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoVO-00007u-Gi; Mon, 03 Jun 2019 11:04:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 401653001464;
	Mon,  3 Jun 2019 15:04:04 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4B2706727B;
	Mon,  3 Jun 2019 15:04:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:22 +0200
Message-Id: <20190603150233.6614-18-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 03 Jun 2019 15:04:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 17/28] test-block-iothread: Test adding parent
 to iothread node
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

Opening a new parent node for a node that has already been moved into a
different AioContext must cause the new parent to move into the same
context.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-block-iothread.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 2200487d76..38f59999ab 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -663,6 +663,38 @@ static void test_propagate_mirror(void)
     bdrv_unref(target);
 }
=20
+static void test_attach_second_node(void)
+{
+    IOThread *iothread =3D iothread_new();
+    AioContext *ctx =3D iothread_get_aio_context(iothread);
+    AioContext *main_ctx =3D qemu_get_aio_context();
+    BlockBackend *blk;
+    BlockDriverState *bs, *filter;
+    QDict *options;
+
+    blk =3D blk_new(ctx, BLK_PERM_ALL, BLK_PERM_ALL);
+    bs =3D bdrv_new_open_driver(&bdrv_test, "base", BDRV_O_RDWR, &error_=
abort);
+    blk_insert_bs(blk, bs, &error_abort);
+
+    options =3D qdict_new();
+    qdict_put_str(options, "driver", "raw");
+    qdict_put_str(options, "file", "base");
+
+    filter =3D bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abort)=
;
+    g_assert(blk_get_aio_context(blk) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(filter) =3D=3D ctx);
+
+    blk_set_aio_context(blk, main_ctx, &error_abort);
+    g_assert(blk_get_aio_context(blk) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(bs) =3D=3D main_ctx);
+    g_assert(bdrv_get_aio_context(filter) =3D=3D main_ctx);
+
+    bdrv_unref(filter);
+    bdrv_unref(bs);
+    blk_unref(blk);
+}
+
 int main(int argc, char **argv)
 {
     int i;
@@ -678,6 +710,7 @@ int main(int argc, char **argv)
     }
=20
     g_test_add_func("/attach/blockjob", test_attach_blockjob);
+    g_test_add_func("/attach/second_node", test_attach_second_node);
     g_test_add_func("/propagate/basic", test_propagate_basic);
     g_test_add_func("/propagate/diamond", test_propagate_diamond);
     g_test_add_func("/propagate/mirror", test_propagate_mirror);
--=20
2.20.1


