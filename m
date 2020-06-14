Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC3FC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 03:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D8420714
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 03:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="lbSGKIit";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="aS8uLqSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D8420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkJdp-00085e-81
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 23:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jkJd9-0007f4-O1
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 23:48:24 -0400
Received: from relay5.mymailcheap.com ([159.100.241.64]:56044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jkJd7-0004tj-2V
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 23:48:23 -0400
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com
 [217.182.119.157])
 by relay5.mymailcheap.com (Postfix) with ESMTPS id AD0ED20096
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 03:48:16 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id 429613F1CC;
 Sun, 14 Jun 2020 05:48:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 6831D2A3AB;
 Sat, 13 Jun 2020 23:48:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1592106489;
 bh=YN7E3xl1eNZ5H2IPbaiSBqzAEZUaLXI6vSNkSxzMl5o=;
 h=From:To:Cc:Subject:Date:From;
 b=lbSGKIitP85+sadjAQhfT+V9RX7t6c7p2nugY/m33Zir5su58HrcpwhZm2LgNkv4e
 WCUWUhJnj9yDiMzMFCROVkKifZpkxnDbDqLBugpxXF5R0WOuVk+gXESK+KFA5ewjTN
 jXI+Igq3amDfGaxOzffDn0yhCjb7y6/pOyZngdP4=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SEmpGC_I8R5Q; Sat, 13 Jun 2020 23:48:08 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Sat, 13 Jun 2020 23:48:08 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id D1573403B5;
 Sun, 14 Jun 2020 03:48:04 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="aS8uLqSN"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from halation.202.net.flygoat.com (unknown [183.157.45.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id A00ED403B5;
 Sun, 14 Jun 2020 03:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1592106482;
 bh=YN7E3xl1eNZ5H2IPbaiSBqzAEZUaLXI6vSNkSxzMl5o=;
 h=From:To:Cc:Subject:Date:From;
 b=aS8uLqSNhyPU5Ri/yzAYkGNjvx42up/zy9qCERu3JE+gLVSJxfiTd+wt2lwnSb3b5
 XWA7kGtN802jGnSuDUVjT69AcwZoTFlo+6WG/D/6jFAHGgXyzMbMuzVIs2KMAdyIfN
 nEOuxvgKnqslcsSW/wXO3CFGtRSX0QLJv9fdxPU0=
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: aleksandar.qemu.devel@gmail.com
Subject: [PATCH] target/mips: Fix PageMask with variable page size
Date: Sun, 14 Jun 2020 11:47:29 +0800
Message-Id: <20200614034729.3004-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D1573403B5
X-Spamd-Result: default: False [6.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(0.00)[~all];
 RCPT_COUNT_FIVE(0.00)[5]; ML_SERVERS(-3.10)[213.133.102.83];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_NO_TLS_LAST(0.10)[];
 RECEIVED_SPAMHAUS_PBL(0.00)[183.157.45.207:received];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_CONTAINS_FROM(1.00)[];
 RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
X-Spam: Yes
Received-SPF: pass client-ip=159.100.241.64;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay5.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 23:48:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, aleksandar.rikalo@syrmia.com,
 qemu-devel@nongnu.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our current code assumed the target page size is always 4k
when handling PageMask and VPN2, however, variable page size
was just added to mips target and that's nolonger true.

So we refined this piece of code to handle any target page size.
Also added Big Page support defined by MIPS64 Release2.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/cp0_helper.c | 48 ++++++++++++++++++++++++++++++----------
 target/mips/cpu.h        |  3 ++-
 target/mips/machine.c    |  2 +-
 3 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index bbf12e4a97..7a134085f7 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -872,20 +872,44 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
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
+    uint64_t mask;
+    int maxmaskbits, maskbits;
+
+    if (env->insn_flags & ISA_MIPS32R6) {
+        return;
     }
-}
 
-void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
-{
-    update_pagemask(env, arg1, &env->CP0_PageMask);
+    /* Don't care MASKX as we don't support 1KB page */
+#ifdef TARGET_MIPS64
+    if (env->CP0_Config3 & CP0C3_BPG) {
+        maxmaskbits = 47;
+    } else {
+        maxmaskbits = 16;
+    }
+#else
+    maxmaskbits = 16;
+#endif
+    mask = extract64((uint64_t)arg1, CP0PM_MASK, maxmaskbits);
+
+    maskbits = find_first_zero_bit(&mask, 64);
+
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
+    maskbits = MIN(maxmaskbits, MAX(maskbits, TARGET_PAGE_BITS - 12));
+    env->CP0_PageMask = ((1 << (maskbits + 1)) - 1) << CP0PM_MASK;
 }
 
 void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
@@ -1111,7 +1135,7 @@ void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
 void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong old, val, mask;
-    mask = (TARGET_PAGE_MASK << 1) | env->CP0_EntryHi_ASID_mask;
+    mask = ~((1 << 14) - 1) | env->CP0_EntryHi_ASID_mask;
     if (((env->CP0_Config4 >> CP0C4_IE) & 0x3) >= 2) {
         mask |= 1 << CP0EnHi_EHINV;
     }
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 0b3c987bb3..b69806792d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -617,7 +617,8 @@ struct CPUMIPSState {
 /*
  * CP0 Register 5
  */
-    int32_t CP0_PageMask;
+    target_ulong CP0_PageMask;
+#define CP0PM_MASK 13
     int32_t CP0_PageGrain_rw_bitmask;
     int32_t CP0_PageGrain;
 #define CP0PG_RIE 31
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 5b23e3e912..b30a75d46b 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -252,7 +252,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINT64(env.CP0_EntryLo1, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_Context, MIPSCPU),
         VMSTATE_INT32(env.CP0_MemoryMapID, MIPSCPU),
-        VMSTATE_INT32(env.CP0_PageMask, MIPSCPU),
+        VMSTATE_UINTTL(env.CP0_PageMask, MIPSCPU),
         VMSTATE_INT32(env.CP0_PageGrain, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_SegCtl0, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_SegCtl1, MIPSCPU),
-- 
2.27.0

