Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6495EC282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C15C217D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C15C217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40183 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqQN-0002AX-Gx
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:18:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqAU-0004hh-B6
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqAT-0002F9-A6
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:02:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hTqAP-0001nJ-I4; Thu, 23 May 2019 12:02:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7138C070E3A;
	Thu, 23 May 2019 16:01:30 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-143.ams2.redhat.com
	[10.36.116.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C549C1001F5B;
	Thu, 23 May 2019 16:01:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 23 May 2019 18:00:57 +0200
Message-Id: <20190523160104.21258-9-kwolf@redhat.com>
In-Reply-To: <20190523160104.21258-1-kwolf@redhat.com>
References: <20190523160104.21258-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 23 May 2019 16:01:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 08/15] test-block-iothread: BlockBackend
 AioContext across root node change
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

Test that BlockBackends preserve their assigned AioContext even when the
root node goes away. Inserting a new root node will move it to the right
AioContext.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-block-iothread.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 38f59999ab..f41082e3bd 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -695,6 +695,38 @@ static void test_attach_second_node(void)
     blk_unref(blk);
 }
=20
+static void test_attach_preserve_blk_ctx(void)
+{
+    IOThread *iothread =3D iothread_new();
+    AioContext *ctx =3D iothread_get_aio_context(iothread);
+    BlockBackend *blk;
+    BlockDriverState *bs;
+
+    blk =3D blk_new(ctx, BLK_PERM_ALL, BLK_PERM_ALL);
+    bs =3D bdrv_new_open_driver(&bdrv_test, "base", BDRV_O_RDWR, &error_=
abort);
+    bs->total_sectors =3D 65536 / BDRV_SECTOR_SIZE;
+
+    /* Add node to BlockBackend that has an iothread context assigned */
+    blk_insert_bs(blk, bs, &error_abort);
+    g_assert(blk_get_aio_context(blk) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs) =3D=3D ctx);
+
+    /* Remove the node again */
+    blk_remove_bs(blk);
+    /* TODO bs should move back to main context here */
+    g_assert(blk_get_aio_context(blk) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs) =3D=3D ctx);
+
+    /* Re-attach the node */
+    blk_insert_bs(blk, bs, &error_abort);
+    g_assert(blk_get_aio_context(blk) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs) =3D=3D ctx);
+
+    blk_set_aio_context(blk, qemu_get_aio_context(), &error_abort);
+    bdrv_unref(bs);
+    blk_unref(blk);
+}
+
 int main(int argc, char **argv)
 {
     int i;
@@ -711,6 +743,7 @@ int main(int argc, char **argv)
=20
     g_test_add_func("/attach/blockjob", test_attach_blockjob);
     g_test_add_func("/attach/second_node", test_attach_second_node);
+    g_test_add_func("/attach/preserve_blk_ctx", test_attach_preserve_blk=
_ctx);
     g_test_add_func("/propagate/basic", test_propagate_basic);
     g_test_add_func("/propagate/diamond", test_propagate_diamond);
     g_test_add_func("/propagate/mirror", test_propagate_mirror);
--=20
2.20.1


