Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA199C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6C926573
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6C926573
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36514 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXoke-0005XE-KP
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:19:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVs-0001Op-65
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVo-00012B-C3
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoVa-0000Nl-GH; Mon, 03 Jun 2019 11:04:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01C8B3082231;
	Mon,  3 Jun 2019 15:04:11 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 02FA26727B;
	Mon,  3 Jun 2019 15:04:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:24 +0200
Message-Id: <20190603150233.6614-20-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 03 Jun 2019 15:04:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 19/28] block: Move node without parents to main
 AioContext
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

A node should only be in a non-default AioContext if a user is attached
to it that requires this. When the last parent of a node is gone, it can
move back to the main AioContext.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                     | 4 ++++
 tests/test-bdrv-drain.c     | 2 +-
 tests/test-block-iothread.c | 3 +--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 7d9ed1a724..6830f2d940 100644
--- a/block.c
+++ b/block.c
@@ -2235,6 +2235,10 @@ static void bdrv_replace_child(BdrvChild *child, B=
lockDriverState *new_bs)
         bdrv_get_cumulative_perm(old_bs, &perm, &shared_perm);
         bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL, &error_ab=
ort);
         bdrv_set_perm(old_bs, perm, shared_perm);
+
+        /* When the parent requiring a non-default AioContext is removed=
, the
+         * node moves back to the main AioContext */
+        bdrv_try_set_aio_context(old_bs, qemu_get_aio_context(), NULL);
     }
=20
     if (new_bs) {
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 16ea2b813f..44e658bde0 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1003,7 +1003,7 @@ static void test_blockjob_common_drain_node(enum dr=
ain_type drain_type,
=20
     if (use_iothread) {
         blk_set_aio_context(blk_src, qemu_get_aio_context(), &error_abor=
t);
-        blk_set_aio_context(blk_target, qemu_get_aio_context(), &error_a=
bort);
+        assert(blk_get_aio_context(blk_target) =3D=3D qemu_get_aio_conte=
xt());
     }
     aio_context_release(ctx);
=20
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index f41082e3bd..79d9cf8a57 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -713,9 +713,8 @@ static void test_attach_preserve_blk_ctx(void)
=20
     /* Remove the node again */
     blk_remove_bs(blk);
-    /* TODO bs should move back to main context here */
     g_assert(blk_get_aio_context(blk) =3D=3D ctx);
-    g_assert(bdrv_get_aio_context(bs) =3D=3D ctx);
+    g_assert(bdrv_get_aio_context(bs) =3D=3D qemu_get_aio_context());
=20
     /* Re-attach the node */
     blk_insert_bs(blk, bs, &error_abort);
--=20
2.20.1


