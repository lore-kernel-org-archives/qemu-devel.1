Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B06C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE09120780
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE09120780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqjDF-0006rX-5I
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 16:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqj99-0002DD-KZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 16:15:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:43966
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqj97-0006pM-1Z
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 16:15:55 -0400
Received: from host86-182-221-233.range86-182.btcentralplus.com
 ([86.182.221.233] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqj98-0005jj-Ld; Wed, 01 Jul 2020 21:15:58 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu
Date: Wed,  1 Jul 2020 21:15:31 +0100
Message-Id: <20200701201531.13828-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701201531.13828-1-mark.cave-ayland@ilande.co.uk>
References: <20200701201531.13828-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.182.221.233
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 2/2] target/m68k: consolidate physical translation offset
 into get_physical_address()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since all callers to get_physical_address() now apply the same page offset to
the translation result, move the logic into get_physical_address() itself to
avoid duplication.

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/m68k/helper.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 631eab7774..3ff5765795 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -643,7 +643,7 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
                 /* Transparent Translation Register bit */
                 env->mmu.mmusr = M68K_MMU_T_040 | M68K_MMU_R_040;
             }
-            *physical = address & TARGET_PAGE_MASK;
+            *physical = address;
             *page_size = TARGET_PAGE_SIZE;
             return 0;
         }
@@ -771,7 +771,7 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     }
     *page_size = 1 << page_bits;
     page_mask = ~(*page_size - 1);
-    *physical = next & page_mask;
+    *physical = (next & page_mask) + (address & (*page_size - 1));
 
     if (access_type & ACCESS_PTEST) {
         env->mmu.mmusr |= next & M68K_MMU_SR_MASK_040;
@@ -826,8 +826,6 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         return -1;
     }
 
-    addr &= TARGET_PAGE_MASK;
-    phys_addr += addr & (page_size - 1);
     return phys_addr;
 }
 
@@ -891,10 +889,8 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     ret = get_physical_address(&cpu->env, &physical, &prot,
                                address, access_type, &page_size);
     if (likely(ret == 0)) {
-        address &= TARGET_PAGE_MASK;
-        physical += address & (page_size - 1);
-        tlb_set_page(cs, address, physical,
-                     prot, mmu_idx, TARGET_PAGE_SIZE);
+        tlb_set_page(cs, address & TARGET_PAGE_MASK,
+                     physical & TARGET_PAGE_MASK, prot, mmu_idx, page_size);
         return true;
     }
 
@@ -1383,9 +1379,8 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
     ret = get_physical_address(env, &physical, &prot, addr,
                                access_type, &page_size);
     if (ret == 0) {
-        addr &= TARGET_PAGE_MASK;
-        physical += addr & (page_size - 1);
-        tlb_set_page(env_cpu(env), addr, physical,
+        tlb_set_page(env_cpu(env), addr & TARGET_PAGE_MASK,
+                     physical & TARGET_PAGE_MASK,
                      prot, access_type & ACCESS_SUPER ?
                      MMU_KERNEL_IDX : MMU_USER_IDX, page_size);
     }
-- 
2.20.1


