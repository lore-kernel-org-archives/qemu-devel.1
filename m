Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6DDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 02:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0182E207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 02:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="FDS4Suup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0182E207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiUJh-0002NJ-8W
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 22:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jiUJ4-0001tn-UX
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 22:48:06 -0400
Received: from vultr.net.flygoat.com
 ([2001:19f0:6001:3633:5400:2ff:fe8c:553]:38224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jiUJ3-0002TE-Jq
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 22:48:06 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
 by vultr.net.flygoat.com (Postfix) with ESMTPSA id 6DC751FAF8;
 Tue,  9 Jun 2020 02:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
 t=1591670881; bh=veK+SR4g8Ulqn5TtYEUsTTTv/wHdxDcm2yT9dXEkZCg=;
 h=From:To:Cc:Subject:Date:From;
 b=FDS4Suupwu7WsVX/e2KdlRhIliQwLPI4jtj0HKzWtNtIwDewESh71/sx7PywONiQH
 +VBLWdprbLW3yCSye0ThXsneKFBfagOwHMKU/e01zTsoUXi9MOcvxKhqdXt7rCDzoI
 wUW0o2zmTN2Ft6pKOfW09XQbWcvmjsktk5/W/PDBlb4G083DEZMAk6R5is0KdpCI/4
 pIFGpg4LgD5QKT7wG/HuYQoks0oSUm372cmypCAFctk6tgOgkOuWhYVkm/B3bfebNq
 rvp6uR1nrsCyhb7Bpt/+k/MvUx8ZqZNhFAAw7N/CInz0rFyTYIDnfF9pPYnyI5Q952
 s3m3Csbl2RTRw==
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/mips: Fix PageMask with variable page size
Date: Tue,  9 Jun 2020 10:47:46 +0800
Message-Id: <20200609024746.2498909-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:19f0:6001:3633:5400:2ff:fe8c:553;
 envelope-from=jiaxun.yang@flygoat.com; helo=vultr.net.flygoat.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 22:48:01
X-ACL-Warn: Detected OS   = ???
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
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, aurelien@aurel32.net
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
 2 files changed, 38 insertions(+), 13 deletions(-)

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
-- 
2.27.0.rc2


