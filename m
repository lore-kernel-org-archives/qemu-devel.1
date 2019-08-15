Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32034C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A7D206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lxqV9Lm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A7D206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyNUK-0004le-TU
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 17:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRu-0002vT-GS
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRt-0006BD-1p
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19195)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRs-0006Ao-B4; Thu, 15 Aug 2019 17:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1565905100; x=1597441100;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TzSLaqGd1ijZpKYVZGyg4YDJEHLu4T6oDeS8B/digZY=;
 b=lxqV9Lm9JqaSaQwn1DBg41+JUU8SEW1y7X51H9/GOkSKtDPXw5wS72Jx
 XkuDCKCk2bWs3tKVcVJ1GSFiQT61kLmTkNhSB6tfMV4qoU+PiRWzZT5Dd
 soipP5CK3e7oOM7uSzcKWY/3n50OWbmsxKvi7Wcgj0WYzf8L1RK7LYhRo
 N0fm++J4sNhoB+l4Vjdu3P0a+LtmS3kFgHsSqKMfm2K/UZeoPsrAYI1WT
 0fjqonxlLwyV8ry7j+weupRd02uJs7XyW/uzXsJu7oHLtlNqwexuSKXWP
 5wqllZMbq/K48l9JgwAu5XuzHO0XXEulkodOqnFJRjNvRkIipnibWJm97 g==;
IronPort-SDR: mYbRdi8E4XMVKxMPHzK+ADyfaspQTyXRvgAsKEeSs24cg+hC0RtEerl976HzGNy4rSEzcXrXjo
 H3i7UIN522mti6zTC7lEBuXgYgG3VPa2JaMrLsMXmcqKaxupbRT2MLDW4MEfvSAn3SYDKKcUF1
 w2ioVYGuGbEVcF8ji5zbO/Ez5W4r6mY5lRnbcTjsk66LcVwyRPmiyamquOJqUmBTbIdBUcKajx
 K6KcG2y4lL5yEm7X36HSJEEQoGx5i9YRVssQvW3sfDu/OqgUijv0qJm9zXNZbISGek5LxSa2ci
 las=
X-IronPort-AV: E=Sophos;i="5.64,389,1559491200"; d="scan'208";a="222470286"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 05:38:15 +0800
IronPort-SDR: i6Xs2WQ8swew2MgH4r00Gx6v2n0XEux/6qkBo+zeZHbbEqazIB1iTdfk6V0Z1GPskD0TXUhd9s
 Pr9FRsH2XrzT3fghsPk6UVVAzXTQX7ZrEeGxQHAnUCOPLxTCjOWt/GBFIqph44xgUkuQxLWCc6
 67t+mjOd44uqOjni1DwvJAkDtMMPvoc2g2etcgG3jJUP5cGCrci456XI+eoUcwspxN9Y9vRkcH
 DlnlDlnFVQwemHHdWtM3islsjNDHxgcEeO84UQR19QpVYgMpwdnmcFr3BVqAApPYyD5fQASPqE
 bkRplu6NWP0jpqsHSAxT9vqr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2019 14:35:46 -0700
IronPort-SDR: 2KPJdM7gtEa5pdPQHr3uHB4LRu983Yj0FX2sBbFmztPt3fksXMvc2Y/mmUWu8rzo9x8UgjZDy3
 8WzItftpnoj1ASuYicuI4qFSna5HNTGplT1XNTOxCiV+iPUL3ZJwDlqrQwedLFpzRy+JpO9ylp
 dQ6q7MZPG7IPc6ohuhbEoNKnYTwqJf/FUYfnwzd4D//0G/WzCfKSQtfgrjwsPu0cTlzYbnby1n
 BhvsYJiXI14kpopGrjr4LVfN9DUzYq+qVZyR/XZyr6YG4HMboouBD8hiOfVpYmPqwy3oz/VK5k
 HYk=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2019 14:38:16 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 15 Aug 2019 14:34:47 -0700
Message-Id: <1a5abeb9acb758a24daddc5ca8ecd56229a73cf1.1565904855.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565904855.git.alistair.francis@wdc.com>
References: <cover.1565904855.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v3 1/7] target/riscv: Don't set write
 permissions on dirty PTEs
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Setting write permission on dirty PTEs results in userspace inside a
Hypervisor guest (VU) becoming corrupted. This appears to be because it
ends up with write permission in the second stage translation in cases
where we aren't doing a store.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e32b6126af..f027be7f16 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -340,10 +340,8 @@ restart:
             if ((pte & PTE_X)) {
                 *prot |= PAGE_EXEC;
             }
-            /* add write permission on stores or if the page is already dirty,
-               so that we TLB miss on later writes to update the dirty bit */
-            if ((pte & PTE_W) &&
-                    (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
+            /* add write permission on stores */
+            if ((pte & PTE_W) && (access_type == MMU_DATA_STORE)) {
                 *prot |= PAGE_WRITE;
             }
             return TRANSLATE_SUCCESS;
-- 
2.22.0


