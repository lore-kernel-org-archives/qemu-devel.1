Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46BDC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 04:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BB821A4A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 04:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="btfWax6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BB821A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCzEy-0005gM-I0
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 00:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iCzEE-0005Cs-W8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 00:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iCzEB-0001lk-Uf
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 00:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iCzEB-0001lN-Ob; Wed, 25 Sep 2019 00:48:35 -0400
Received: from guoren-Inspiron-7460.lan (unknown [223.93.147.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E6B021A4A;
 Wed, 25 Sep 2019 04:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569386914;
 bh=GMapcb2WUHqhsll7OX2TGMlEII/fxxpk18SPz1OiNHQ=;
 h=From:To:Cc:Subject:Date:From;
 b=btfWax6XT8Qss02p583ulK8ekt0bfbP9xQn6wnma5yluT6oaT0Agr5n0xdURfPh1r
 BRqeyhZ78ASME5v1ZVHCF4l+5S4mCPJE/ZDSsLzj57LGgt808LU67C/KP6mwGB/qKM
 gGnaNWZyGy7qgRhftjQEV5m0oJCF/b2uEnYhGKeQ=
From: guoren@kernel.org
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH V3] target/riscv: Bugfix reserved bits in PTE for RV64
Date: Wed, 25 Sep 2019 12:48:15 +0800
Message-Id: <1569386895-8726-1-git-send-email-guoren@kernel.org>
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
 Guo Ren <ren_guo@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guo Ren <ren_guo@c-sky.com>

Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
need to ignore them. They can not be a part of ppn.

1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
   4.4 Sv39: Page-Based 39-bit Virtual-Memory System
   4.5 Sv48: Page-Based 48-bit Virtual-Memory System

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/cpu_bits.h   | 3 +++
 target/riscv/cpu_helper.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)
---
Changelog V3:
 - Use UUL define for PTE_RESERVED.
 - Keep ppn >> PTE_PPN_SHIFT 

Changelog V2:
 - Bugfix pte destroyed cause boot fail
 - Change to AND with a mask instead of shifting both directions

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e998348..cdc62a8 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -470,6 +470,9 @@
 #define PTE_D               0x080 /* Dirty */
 #define PTE_SOFT            0x300 /* Reserved for Software */
 
+/* Reserved highest 10 bits in PTE */
+#define PTE_RESERVED        0xFFC0000000000000ULL
+
 /* Page table PPN shift amount */
 #define PTE_PPN_SHIFT       10
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 87dd6a6..7e04ff5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -258,10 +258,12 @@ restart:
         }
 #if defined(TARGET_RISCV32)
         target_ulong pte = ldl_phys(cs->as, pte_addr);
+        hwaddr ppn = pte;
 #elif defined(TARGET_RISCV64)
         target_ulong pte = ldq_phys(cs->as, pte_addr);
+        hwaddr ppn = pte & ~PTE_RESERVED;
 #endif
-        hwaddr ppn = pte >> PTE_PPN_SHIFT;
+        ppn = ppn >> PTE_PPN_SHIFT;
 
         if (!(pte & PTE_V)) {
             /* Invalid PTE */
-- 
2.7.4


