Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FA4C55ABD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F84B217A0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bpUD30ZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F84B217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5nm-0003By-1w
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kb5mj-000285-3E; Fri, 06 Nov 2020 12:44:25 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:56597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kb5mf-0007ha-IQ; Fri, 06 Nov 2020 12:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=FWPbYEvQ4sDniQZs/tN0Fc7C4jx2iT5Y1IcrYLecynY=; 
 b=bpUD30ZDfZF+PC6xk2XNfKY3xzu4OfaMhNuQzD4tn3z6xaMhEYrTFCLupluZXeoezEnoQ82bIqtR3AXC04ULRuvG8wtNcRVKURRh/pYGz4lBmTUPxeacnhxxC0cMpm1HrOTLWeJ0jVrD7z3tm08+pEossZ04pDXC09adVHRfUBLg0cf7JE4v0DJo/MtdcUnS40TDQtZRTBQA7Ur6vuvmyHGZYsRN6svCayhMAdsRqRyWC1TfWskWFtDRbOxHKUrtDhMGz5hjuXC7giFgLBWDDHnHXifcOeB2JJ4Gag4DG+RP46zWpS1CEFk/9SD8MpoyxIAYn+NcQZKcL9CSODQZGQ==;
Received: from [81.0.39.238] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kb5mb-0003zk-8b; Fri, 06 Nov 2020 18:44:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kb5mO-0007fS-CT; Fri, 06 Nov 2020 18:44:04 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] quorum: Implement bdrv_co_pwrite_zeroes()
Date: Fri,  6 Nov 2020 18:43:48 +0100
Message-Id: <9bb1362c14a065c15f6e367217ed9096aadb1f26.1604684432.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1604684432.git.berto@igalia.com>
References: <cover.1604684432.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 12:44:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This simply calls bdrv_co_pwrite_zeroes() in all children

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c             | 18 ++++++++++++++++--
 tests/qemu-iotests/312     |  7 +++++++
 tests/qemu-iotests/312.out |  4 ++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 29cee42705..70b39a7226 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -692,8 +692,13 @@ static void write_quorum_entry(void *opaque)
     QuorumChildRequest *sacb = &acb->qcrs[i];
 
     sacb->bs = s->children[i]->bs;
-    sacb->ret = bdrv_co_pwritev(s->children[i], acb->offset, acb->bytes,
-                                acb->qiov, acb->flags);
+    if (acb->flags & BDRV_REQ_ZERO_WRITE) {
+        sacb->ret = bdrv_co_pwrite_zeroes(s->children[i], acb->offset,
+                                          acb->bytes, acb->flags);
+    } else {
+        sacb->ret = bdrv_co_pwritev(s->children[i], acb->offset, acb->bytes,
+                                    acb->qiov, acb->flags);
+    }
     if (sacb->ret == 0) {
         acb->success_count++;
     } else {
@@ -739,6 +744,14 @@ static int quorum_co_pwritev(BlockDriverState *bs, uint64_t offset,
     return ret;
 }
 
+static int quorum_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
+                                   int bytes, BdrvRequestFlags flags)
+
+{
+    return quorum_co_pwritev(bs, offset, bytes, NULL,
+                             flags | BDRV_REQ_ZERO_WRITE);
+}
+
 static int64_t quorum_getlength(BlockDriverState *bs)
 {
     BDRVQuorumState *s = bs->opaque;
@@ -1248,6 +1261,7 @@ static BlockDriver bdrv_quorum = {
 
     .bdrv_co_preadv                     = quorum_co_preadv,
     .bdrv_co_pwritev                    = quorum_co_pwritev,
+    .bdrv_co_pwrite_zeroes              = quorum_co_pwrite_zeroes,
 
     .bdrv_add_child                     = quorum_add_child,
     .bdrv_del_child                     = quorum_del_child,
diff --git a/tests/qemu-iotests/312 b/tests/qemu-iotests/312
index 1b08f1552f..93046393e7 100755
--- a/tests/qemu-iotests/312
+++ b/tests/qemu-iotests/312
@@ -114,6 +114,13 @@ $QEMU_IO -c "write -P 0 $((0x200000)) $((0x10000))" "$TEST_IMG.0" | _filter_qemu
 $QEMU_IO -c "write -z   $((0x200000)) $((0x30000))" "$TEST_IMG.1" | _filter_qemu_io
 $QEMU_IO -c "write -P 0 $((0x200000)) $((0x20000))" "$TEST_IMG.2" | _filter_qemu_io
 
+# Test 5: write data to a region and then zeroize it, doing it
+# directly on the quorum device instead of the individual images.
+# This has no effect on the end result but proves that the quorum driver
+# supports 'write -z'.
+$QEMU_IO -c "open -o $quorum" -c "write $((0x250000)) $((0x10000))" | _filter_qemu_io
+$QEMU_IO -c "open -o $quorum" -c "write -z $((0x250000)) $((0x10000))" | _filter_qemu_io
+
 echo
 echo '### Launch the drive-mirror job'
 echo
diff --git a/tests/qemu-iotests/312.out b/tests/qemu-iotests/312.out
index 4ae749175b..778dda95c7 100644
--- a/tests/qemu-iotests/312.out
+++ b/tests/qemu-iotests/312.out
@@ -39,6 +39,10 @@ wrote 196608/196608 bytes at offset 2097152
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2097152
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2424832
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2424832
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 ### Launch the drive-mirror job
 
-- 
2.20.1


