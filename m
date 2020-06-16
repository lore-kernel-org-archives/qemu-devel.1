Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A61C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BD020786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="beUuICaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BD020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl64X-0002IQ-VS
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jl63k-0001ra-09
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 03:31:04 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:57314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jl63g-0004Oz-Vs
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 03:31:03 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
 by vultr.net.flygoat.com (Postfix) with ESMTPSA id 2552E20D32;
 Tue, 16 Jun 2020 07:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
 t=1592292659; bh=2N2irRF5t8pcsrolL8b7XRn5nUKOqkVCPc6GVwyawbw=;
 h=From:To:Cc:Subject:Date:From;
 b=beUuICaPIbM/k5BUJm/yh39WkPXoAyvY1oWEb66qJyKI69NPLei1A0yN69QZpiI6G
 b1oo/POJj179ybZucvf821Q+nQGNMQkPXSl8FZbPQlUlj47avL6KJFEgLR6YByg+YK
 JUkwri4enabVHtvoUxp4INM86T1S4/1tKJYrMEmej/t2P6JqTiEBcwZd2StlOxGW2o
 y1z5HLgX0IPKpZ87fo6pcXHuuAyXnqEyG7lCxv/uzmL/4SxpY0XxqK1FBnpQGklAvU
 jklaVCggLraMykaH8moWj9E/4QXkFelda5CWOemH2gM0pNz2u8D3yHRzxdCviNxtoB
 GtwnaLcUZtZMA==
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] target/mips: Fix PageMask with variable page size
Date: Tue, 16 Jun 2020 15:30:53 +0800
Message-Id: <20200616073053.2999026-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=149.28.68.211;
 envelope-from=jiaxun.yang@flygoat.com; helo=vultr.net.flygoat.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 03:30:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our current code assumed the target page size is always 4k
when handling PageMask and VPN2, however, variable page size
was just added to mips target and that's nolonger true.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Remove Big Page support from this patch
---
 target/mips/cp0_helper.c | 41 ++++++++++++++++++++++++++++------------
 target/mips/cpu.h        |  1 +
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index bbf12e4a97..f6dc590315 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -872,20 +872,37 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
+void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
 {
-    uint64_t mask = arg1 >> (TARGET_PAGE_BITS + 1);
-    if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 == ~0) ||
-        (mask == 0x0000 || mask == 0x0003 || mask == 0x000F ||
-         mask == 0x003F || mask == 0x00FF || mask == 0x03FF ||
-         mask == 0x0FFF || mask == 0x3FFF || mask == 0xFFFF)) {
-        env->CP0_PageMask = arg1 & (0x1FFFFFFF & (TARGET_PAGE_MASK << 1));
+    unsigned long mask;
+    int maskbits;
+
+    if (env->insn_flags & ISA_MIPS32R6) {
+        return;
     }
-}
+    /* Don't care MASKX as we don't support 1KB page */
+    mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
+    maskbits = find_first_zero_bit(&mask, 32);
 
-void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
-{
-    update_pagemask(env, arg1, &env->CP0_PageMask);
+    /* Ensure no more set bit after first zero */
+    if (mask >> maskbits) {
+        goto invalid;
+    }
+    /* We don't support VTLB entry smaller than target page */
+    if ((maskbits + 12) < TARGET_PAGE_BITS) {
+        goto invalid;
+    }
+    env->CP0_PageMask = mask << CP0PM_MASK;
+
+    return;
+
+invalid:
+    /*
+     * When invalid, ensure the value is bigger tan or equel to
+     * the minimal but smaller than or equel to the maxium.
+     */
+    maskbits = MIN(16, MAX(maskbits, TARGET_PAGE_BITS - 12));
+    env->CP0_PageMask = ((1 << (16 + 1)) - 1) << CP0PM_MASK;
 }
 
 void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
@@ -1111,7 +1128,7 @@ void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
 void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong old, val, mask;
-    mask = (TARGET_PAGE_MASK << 1) | env->CP0_EntryHi_ASID_mask;
+    mask = ~((1 << 14) - 1) | env->CP0_EntryHi_ASID_mask;
     if (((env->CP0_Config4 >> CP0C4_IE) & 0x3) >= 2) {
         mask |= 1 << CP0EnHi_EHINV;
     }
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7cf7f5239f..9c8bb23807 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -618,6 +618,7 @@ struct CPUMIPSState {
  * CP0 Register 5
  */
     int32_t CP0_PageMask;
+#define CP0PM_MASK 13
     int32_t CP0_PageGrain_rw_bitmask;
     int32_t CP0_PageGrain;
 #define CP0PG_RIE 31
-- 
2.27.0.rc2


