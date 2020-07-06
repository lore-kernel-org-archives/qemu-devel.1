Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52394C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B05D206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B05D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXP5-0004cA-Fs
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsXNf-0001cV-Ge
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:06:23 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsXNd-0004sz-Fy
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:06:23 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MirSu-1kX6vQ3PLo-00evKx; Mon, 06 Jul 2020 22:06:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] target/m68k: consolidate physical translation offset into
 get_physical_address()
Date: Mon,  6 Jul 2020 22:05:58 +0200
Message-Id: <20200706200559.160209-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706200559.160209-1-laurent@vivier.eu>
References: <20200706200559.160209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6ByfCQdS36HnRHicBYjzL4lbMjnxZSZ4ub5HbgTD6hI+ZAOAReI
 A1EG33JFp3hN7BIzVZR5RqT3iiI+ZhzCQP1yZqcWi7OabOkb2yPXUQ71Jjbc5uGFP2ZvyJj
 ePwjlbBzxMJ88sXHzIMl+059ERuHVe9/AVOEkZCM6qGMd7E3idsSxao6M1yvo/044rXjPvk
 +pwmoNQRGU87NWww9T6vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sspCEf3us1c=:RKzRNrR17UetWFa+R4STeM
 RZ2YVBe4ITGFzrQzjo+F3Kd63OtBoK7K5cbknfKvrWyYLrzJQSTDpB0UpSAD448rgV2CWPGJy
 kb593GwOrNLAS5AyrPlcdpoa1Pml83ZC5lMA2xr3I/r2IpVmnq+++JibGS1vWQyJCtLw6DQrx
 B9d0LmnVkSz0EP7pC0tVKwyJ23MI91hcrpGCD1FocRk7c0y7kFSIaInWI9NTkF+sP8OO7KqgJ
 0+1TQlzCUqq9YDTWIzIbA+lxyrE9Gbpcz44HNOL6sKj7LZig8A9v0CC7d7sZucSWzUhskEyh6
 nBdpsMXN3aOWIrQunqxvnedCCphBDQ8TusBKAESKY6Yc50YRoDGP5mWbVa8C52Uc+WsCMiK3D
 iYn0uszYebyYxbpJjYOJsGFkRiCmZjQ8P/69P+DVGt1fI6ttmjH3VwRJwO0g/kyM8Ipfmevt+
 Delt5Z8rQ9nZS0ou0N5tmiUIzfKm6Z4tOrBWu4s/RroaoV1BoE3KC/dGzV92Mj4PRDZ9H2ojw
 gP5cqroNNTAbYWU/C4uuaLQuiFoYtoQgRqT+yS/ESpavXcn/Kc8nij4NNQmbGS5oz0CT8pp63
 nL7fG+kq20fWltupojZF6ZC/+qNeVY9p6Rytp1DNO+6LOMcNCU5lQIP3rUNga5jLLce8xaj0m
 IQVhOr74X4CLWLAcR09+yvR1+Ql+7Y03jJrTr1zYLiVzesgQ6ES2XV2CkMrAEn9UYb0NA+q3j
 T6R+56IaVBPKgH/ODAQTKduciLxz9BrsVMVxnEa4Lr4c/DM9ImQHfxZETozjSkNx5ksgfi1wz
 JTDpzU7Z5Fc8EoZ5g2Xgbp2juB2pM1ndXlEflKD2iTmh7SPamx/+4zZ0oZBrCe9peNbjKFq
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 16:06:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Since all callers to get_physical_address() now apply the same page offset to
the translation result, move the logic into get_physical_address() itself to
avoid duplication.

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200701201531.13828-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/helper.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 631eab777494..3ff57657958c 100644
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
2.26.2


