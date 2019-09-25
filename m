Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E27C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C08F20673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs8BMP7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C08F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD63k-0003la-FM
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iD62z-0003GZ-HE
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iD62y-0004Ef-Bs
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iD62y-0004EX-6q; Wed, 25 Sep 2019 08:05:28 -0400
Received: from guoren-Inspiron-7460.lan (unknown [223.93.147.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C756F21D7E;
 Wed, 25 Sep 2019 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569413127;
 bh=RymcLTzDRHd3IS+crgKJC/SWyf0bAdWMAU14Lt5SOxw=;
 h=From:To:Cc:Subject:Date:From;
 b=fs8BMP7nlVaML+AjwfP8XJ+pfFhGPbOXjnF97ksMBn+FRnwT9jfXKnFIgpvqc/hm7
 KXs94LEhS5sy6QReB9oqrQNREolOvK3NgGvbxf0DENV7okpp72gLlPobgtYAV2IvWc
 w7xnS4LW8+eoJwF5KsKvcrr/njO5RwjIHEC0Oeik=
From: guoren@kernel.org
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH V5] target/riscv: Ignore reserved bits in PTE for RV64
Date: Wed, 25 Sep 2019 20:04:59 +0800
Message-Id: <1569413099-6859-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
---
 target/riscv/cpu_bits.h   | 7 +++++++
 target/riscv/cpu_helper.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

 Changelog V5:
  - Update Reviewer and Tester.

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


