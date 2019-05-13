Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC0C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E88208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f+l+AsnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E88208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57679 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQBNy-0004jA-V9
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:52:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQBLu-0002eJ-NN
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQBHs-0005e2-B5
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:46:41 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:36074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hQBHs-0005cj-1o; Mon, 13 May 2019 09:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=10jZxo2pQTHlyRjmSoGjzlkHOLb5jm8EaFasG2y36X0=; 
	b=f+l+AsnFa70e60IZi128u+ezhCl1fLrmvkhoIQf/iWGGVrACCmAlNUfEt3Ii2alEvQ/U+WREaYL1MG9Mhzx7Y3glUyopX1F/bfXy2LKH/ncefYoH+eUh7XPPmD4RY9xJvde3SUeP/ehzH8cABSOUtGPOoKU8WVdtULQwIk7c1D2kO8NE6KnMkzzWw2leIMPSMPMSGa3XpVBEvi8EL4erWJ3IbNb8P6CT9Y8ek6pyDJXTcONl3WAyaDZd2XD/RfuUkRFX6N7NZR+VT8VNtpQRfwweMYjoftYWUH247x7+78kGPTB6exHBUp+oizfcFS6PFOYJqQLA39rxBAf7eONIZA==;
Received: from mobile-access-bcee32-86.dhcp.inet.fi ([188.238.50.86]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hQBHo-0003gf-ER; Mon, 13 May 2019 15:46:36 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hQBHb-0003Bw-8e; Mon, 13 May 2019 16:46:23 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 16:46:17 +0300
Message-Id: <6d1d5feaa53aa1ab127adb73d605dc4503e3abd5.1557754872.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1557754872.git.berto@igalia.com>
References: <cover.1557754872.git.berto@igalia.com>
In-Reply-To: <cover.1557754872.git.berto@igalia.com>
References: <cover.1557754872.git.berto@igalia.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH v3 1/2] block: Use bdrv_unref_child() for all
 children in bdrv_close()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_unref_child() does the following things:

  - Updates the child->bs->inherits_from pointer.
  - Calls bdrv_detach_child() to remove the BdrvChild from bs->children.
  - Calls bdrv_unref() to unref the child BlockDriverState.

When bdrv_unref_child() was introduced in commit 33a604075c it was not
used in bdrv_close() because the drivers that had additional children
(like quorum or blkverify) had already called bdrv_unref() on their
children during their own close functions.

This was changed later (in 0bd6e91a7e for quorum, in 3e586be0b2 for
blkverify) so there's no reason not to use bdrv_unref_child() in
bdrv_close() anymore.

After this there's also no need to remove bs->backing and bs->file
separately from the rest of the children, so bdrv_close() can be
simplified.

Now bdrv_close() unrefs all children (before this patch it was only
bs->file and bs->backing). As a result, none of the callers of
brvd_attach_child() should remove their reference to child_bs (because
this function effectively steals that reference). This patch updates a
couple of tests that where doing their own bdrv_unref().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c                     | 16 +++-------------
 tests/test-bdrv-drain.c     |  6 ------
 tests/test-bdrv-graph-mod.c |  1 -
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/block.c b/block.c
index 5c2c6aa761..3c3bd0f8d2 100644
--- a/block.c
+++ b/block.c
@@ -3842,22 +3842,12 @@ static void bdrv_close(BlockDriverState *bs)
         bs->drv = NULL;
     }
 
-    bdrv_set_backing_hd(bs, NULL, &error_abort);
-
-    if (bs->file != NULL) {
-        bdrv_unref_child(bs, bs->file);
-        bs->file = NULL;
-    }
-
     QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
-        /* TODO Remove bdrv_unref() from drivers' close function and use
-         * bdrv_unref_child() here */
-        if (child->bs->inherits_from == bs) {
-            child->bs->inherits_from = NULL;
-        }
-        bdrv_detach_child(child);
+        bdrv_unref_child(bs, child);
     }
 
+    bs->backing = NULL;
+    bs->file = NULL;
     g_free(bs->opaque);
     bs->opaque = NULL;
     atomic_set(&bs->copy_on_read, 0);
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index eda90750eb..5534c2adf9 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1436,12 +1436,6 @@ static void test_detach_indirect(bool by_parent_cb)
     bdrv_unref(parent_b);
     blk_unref(blk);
 
-    /* XXX Once bdrv_close() unref's children instead of just detaching them,
-     * this won't be necessary any more. */
-    bdrv_unref(a);
-    bdrv_unref(a);
-    bdrv_unref(c);
-
     g_assert_cmpint(a->refcnt, ==, 1);
     g_assert_cmpint(b->refcnt, ==, 1);
     g_assert_cmpint(c->refcnt, ==, 1);
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index 283dc84869..747c0bf8fc 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -116,7 +116,6 @@ static void test_update_perm_tree(void)
     g_assert_nonnull(local_err);
     error_free(local_err);
 
-    bdrv_unref(bs);
     blk_unref(root);
 }
 
-- 
2.11.0


