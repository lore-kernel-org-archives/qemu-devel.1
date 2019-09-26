Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3450C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 00:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC3321D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 00:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xHMkPOtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC3321D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDHSS-0001ST-N1
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 20:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iDHQZ-0000Hn-F7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 20:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iDHQX-0000Xs-I5
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 20:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iDHQW-0000SS-Il; Wed, 25 Sep 2019 20:14:33 -0400
Received: from guoren-Inspiron-7460.lan (89.208.247.74.16clouds.com
 [89.208.247.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A0F5720872;
 Thu, 26 Sep 2019 00:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569456868;
 bh=nkYa3WtRIEfBWb7YBlTFdX/qMHhKMBrRs4NV9j2H004=;
 h=From:To:Cc:Subject:Date:From;
 b=xHMkPOtG2yIc0lDPVxtW00HufdmozLXvSm6BWlIGBIThiahFIKVL0oLqGf9cfcZxW
 3jmXrHE+DYdJJO8ENtITOukYG/VbMMYxnkpbPmWSI2TqT1DZ06Z3jEuCIu9TBjkwmg
 O1QMtHK+Kh15+MrCZLkBs+kcPm7/+9o7xpUWcuMo=
From: guoren@kernel.org
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH V6] target/riscv: Ignore reserved bits in PTE for RV64
Date: Thu, 26 Sep 2019 08:14:21 +0800
Message-Id: <1569456861-8502-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com,
 Guo Ren <ren_guo@c-sky.com>, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guo Ren <ren_guo@c-sky.com>

Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
need to ignore them. They cannot be a part of ppn.

1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
   4.4 Sv39: Page-Based 39-bit Virtual-Memory System
   4.5 Sv48: Page-Based 48-bit Virtual-Memory System

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h   | 7 +++++++
 target/riscv/cpu_helper.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

 Changelog V6:
  - Add Reviewer: Alistair Francis

 Changelog V5:
  - Add Reviewer and Tester: Bin Meng

 Changelog V4:
  - Change title to Ignore not Bugfix
  - Use PTE_PPN_MASK for RV32 and RV64

 Changelog V3:
  - Use UUL define for PTE_RESERVED
  - Keep ppn >> PTE_PPN_SHIFT

 Changelog V2:
  - Bugfix pte destroyed cause boot fail
  - Change to AND with a mask instead of shifting both directions

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e998348..399c2c6 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -473,6 +473,13 @@
 /* Page table PPN shift amount */
 #define PTE_PPN_SHIFT       10
 
+/* Page table PPN mask */
+#if defined(TARGET_RISCV32)
+#define PTE_PPN_MASK        0xffffffffUL
+#elif defined(TARGET_RISCV64)
+#define PTE_PPN_MASK        0x3fffffffffffffULL
+#endif
+
 /* Leaf page shift amount */
 #define PGSHIFT             12
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 87dd6a6..9961b37 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -261,7 +261,7 @@ restart:
 #elif defined(TARGET_RISCV64)
         target_ulong pte = ldq_phys(cs->as, pte_addr);
 #endif
-        hwaddr ppn = pte >> PTE_PPN_SHIFT;
+        hwaddr ppn = (pte & PTE_PPN_MASK) >> PTE_PPN_SHIFT;
 
         if (!(pte & PTE_V)) {
             /* Invalid PTE */
-- 
2.7.4


