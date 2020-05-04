Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61414C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE82206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oeunp6Aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE82206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVc1J-0007BI-BV
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jVc0L-0005qV-1L; Mon, 04 May 2020 10:23:33 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:60843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jVc0I-00041r-VK; Mon, 04 May 2020 10:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=FOK68+t9AGaNHYQSO62BbFjn/8zGgPMHqN3xKHDPC4I=; 
 b=oeunp6AaB5oHNNLObwUnzSzUt30921doH3F8pzxvuLhvI4u2l0j7Ef10Lcoez3lWL2UoECmhdbp9kWuOJu8t3cwpgGK8WItcMOSc4iAwknwDPzmRlCevaVIQSY5QZH6LEmerdcZQ1/nCwsW6VQtG8BTnmyAVo6OVqo+O1rDkN1e1AzkGbPw88y3CrAz74dLddIZlThTU2ofW0isL9RD0CeetZfsVhjPdB1J8hsjdKp+mXDsYU8L2xvwXy4uqNrCG22znH6AcGfMg/6Yn6RZJ4cOPQuEof0esuLOVQqd8Oki6svVLPeyAvOHnAtBXmMpRA6AyPefEmBXIbvY+glPk4g==;
Received: from [81.0.43.160] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jVc0C-0006WT-RB; Mon, 04 May 2020 16:23:24 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jVbzx-0002jE-RE; Mon, 04 May 2020 16:23:09 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2] qcow2: Avoid integer wraparound in qcow2_co_truncate()
Date: Mon,  4 May 2020 16:23:08 +0200
Message-Id: <20200504142308.10446-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 09:47:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After commit f01643fb8b47e8a70c04bbf45e0f12a9e5bc54de when an image is
extended and BDRV_REQ_ZERO_WRITE is set then the new clusters are
zeroized.

The code however does not detect correctly situations when the old and
the new end of the image are within the same cluster. The problem can
be reproduced with these steps:

   qemu-img create -f qcow2 backing.qcow2 1M
   qemu-img create -f qcow2 -F qcow2 -b backing.qcow2 top.qcow2
   qemu-img resize --shrink top.qcow2 520k
   qemu-img resize top.qcow2 567k

In the last step offset - zero_start causes an integer wraparound.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

v2:
- Don't call qcow2_cluster_zeroize() if offset == zero_start

diff --git a/block/qcow2.c b/block/qcow2.c
index 2ba0b17c39..7ca0327995 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4234,15 +4234,20 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
         uint64_t zero_start = QEMU_ALIGN_UP(old_length, s->cluster_size);
 
+        /* zero_start should not be after the new end of the image */
+        zero_start = MIN(zero_start, offset);
+
         /*
          * Use zero clusters as much as we can. qcow2_cluster_zeroize()
          * requires a cluster-aligned start. The end may be unaligned if it is
          * at the end of the image (which it is here).
          */
-        ret = qcow2_cluster_zeroize(bs, zero_start, offset - zero_start, 0);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "Failed to zero out new clusters");
-            goto fail;
+        if (offset > zero_start) {
+            ret = qcow2_cluster_zeroize(bs, zero_start, offset - zero_start, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Failed to zero out new clusters");
+                goto fail;
+            }
         }
 
         /* Write explicit zeros for the unaligned head */
-- 
2.20.1


