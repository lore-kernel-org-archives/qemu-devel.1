Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E970C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE71206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="e/sQO1Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE71206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECea-0004Jq-GA
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECaN-0003Qa-UA; Fri, 04 Sep 2020 10:21:03 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECaK-0002jO-UY; Fri, 04 Sep 2020 10:21:03 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 28CDFBFB11;
 Fri,  4 Sep 2020 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599229235;
 bh=EQ+4R5Vy/UfJdr5yFK7JiK6m8tq6GI0f6UYFm4P+Xfo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e/sQO1MtL8CasgfXqaY82NXNFAXcaB4R2FIsUdrJ57RC5LMD2CUIev5SHcaRj3Qd8
 gFim2PafLrQ+YUfYX0tenI1iTXigqi8m/sJ8hQgJvq3sAq6ruwhBGJwtLS+MoxSXZO
 ny2T05P8H56FASZQfREYuM95UnynP9KvQ4s38BDuyUXi9J6B/yk48J3mH0K1d4MXGa
 DvpRw//GnqmFjgzqpBI12HMvrjc9ZEbpQXyz6t6kiQlSZI2oErqYzL4xrOhiH3Wksk
 cZxUf4UjScm2OO0IDMWY3zHZw644eN7xcOdqxI2NlvHhwznoWwqkDvF4UTfWyx6dq5
 HeFxCF6lI7zng==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/17] hw/block/nvme: harden cmb access
Date: Fri,  4 Sep 2020 16:19:50 +0200
Message-Id: <20200904141956.576630-12-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904141956.576630-1-its@irrelevant.dk>
References: <20200904141956.576630-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Since the controller has only supported PRPs so far it has not been
required to check the ending address (addr + len - 1) of the CMB access
for validity since it has been guaranteed to be in range of the CMB.

This changes when the controller adds support for SGLs (next patch), so
add that check.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 36ec8cbb1168..6ef4dc762b80 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -143,7 +143,12 @@ static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
 
 static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
-    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
+    hwaddr hi = addr + size - 1;
+    if (hi < addr) {
+        return 1;
+    }
+
+    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr) && nvme_addr_is_cmb(n, hi)) {
         memcpy(buf, nvme_addr_to_cmb(n, addr), size);
         return 0;
     }
-- 
2.28.0


