Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417E0C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B60D206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B60D206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv20J-0001Hv-77
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iv1zA-0007zG-3Z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iv1z8-0006n9-Nm
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:39:08 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60743 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iv1z8-0006jz-CE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:39:06 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id A2E8D1A2112;
 Fri, 24 Jan 2020 17:39:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 791801A2123;
 Fri, 24 Jan 2020 17:39:02 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/7] target/mips: Amend CP0 WatchHi register implementation
Date: Fri, 24 Jan 2020 17:38:45 +0100
Message-Id: <1579883929-1517-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
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
Cc: aleksandar.rikalo@rt-rk.com, Yongbok Kim <yongbok.kim@mips.com>,
 aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yongbok Kim <yongbok.kim@mips.com>

WatchHi is extended by the field MemoryMapID with the GINVT instruction.
The field is accessible by MTHC0/MFHC0 in 32-bit architectures and DMTC0/
DMFC0 in 64-bit architectures.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  2 +-
 target/mips/helper.h    |  3 +++
 target/mips/machine.c   |  6 +++---
 target/mips/op_helper.c | 23 +++++++++++++++++++++--
 target/mips/translate.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ca00f41..a7e9857 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -961,7 +961,7 @@ struct CPUMIPSState {
 /*
  * CP0 Register 19
  */
-    int32_t CP0_WatchHi[8];
+    uint64_t CP0_WatchHi[8];
 #define CP0WH_ASID 16
 /*
  * CP0 Register 20
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 2095330..032ea8a 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -80,6 +80,7 @@ DEF_HELPER_1(mfc0_maar, tl, env)
 DEF_HELPER_1(mfhc0_maar, tl, env)
 DEF_HELPER_2(mfc0_watchlo, tl, env, i32)
 DEF_HELPER_2(mfc0_watchhi, tl, env, i32)
+DEF_HELPER_2(mfhc0_watchhi, tl, env, i32)
 DEF_HELPER_1(mfc0_debug, tl, env)
 DEF_HELPER_1(mftc0_debug, tl, env)
 #ifdef TARGET_MIPS64
@@ -91,6 +92,7 @@ DEF_HELPER_1(dmfc0_tcschefback, tl, env)
 DEF_HELPER_1(dmfc0_lladdr, tl, env)
 DEF_HELPER_1(dmfc0_maar, tl, env)
 DEF_HELPER_2(dmfc0_watchlo, tl, env, i32)
+DEF_HELPER_2(dmfc0_watchhi, tl, env, i32)
 DEF_HELPER_1(dmfc0_saar, tl, env)
 #endif /* TARGET_MIPS64 */
 
@@ -161,6 +163,7 @@ DEF_HELPER_2(mthc0_maar, void, env, tl)
 DEF_HELPER_2(mtc0_maari, void, env, tl)
 DEF_HELPER_3(mtc0_watchlo, void, env, tl, i32)
 DEF_HELPER_3(mtc0_watchhi, void, env, tl, i32)
+DEF_HELPER_3(mthc0_watchhi, void, env, tl, i32)
 DEF_HELPER_2(mtc0_xcontext, void, env, tl)
 DEF_HELPER_2(mtc0_framemask, void, env, tl)
 DEF_HELPER_2(mtc0_debug, void, env, tl)
diff --git a/target/mips/machine.c b/target/mips/machine.c
index c139239..8d5b18b 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 18,
-    .minimum_version_id = 18,
+    .version_id = 19,
+    .minimum_version_id = 19,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         /* Active TC */
@@ -296,7 +296,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_INT32(env.CP0_MAARI, MIPSCPU),
         VMSTATE_UINTTL(env.lladdr, MIPSCPU),
         VMSTATE_UINTTL_ARRAY(env.CP0_WatchLo, MIPSCPU, 8),
-        VMSTATE_INT32_ARRAY(env.CP0_WatchHi, MIPSCPU, 8),
+        VMSTATE_UINT64_ARRAY(env.CP0_WatchHi, MIPSCPU, 8),
         VMSTATE_UINTTL(env.CP0_XContext, MIPSCPU),
         VMSTATE_INT32(env.CP0_Framemask, MIPSCPU),
         VMSTATE_INT32(env.CP0_Debug, MIPSCPU),
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 5cd396d..bcff2f9 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1026,7 +1026,12 @@ target_ulong helper_mfc0_watchlo(CPUMIPSState *env, uint32_t sel)
 
 target_ulong helper_mfc0_watchhi(CPUMIPSState *env, uint32_t sel)
 {
-    return env->CP0_WatchHi[sel];
+    return (int32_t) env->CP0_WatchHi[sel];
+}
+
+target_ulong helper_mfhc0_watchhi(CPUMIPSState *env, uint32_t sel)
+{
+    return env->CP0_WatchHi[sel] >> 32;
 }
 
 target_ulong helper_mfc0_debug(CPUMIPSState *env)
@@ -1104,6 +1109,11 @@ target_ulong helper_dmfc0_saar(CPUMIPSState *env)
     }
     return 0;
 }
+
+target_ulong helper_dmfc0_watchhi(CPUMIPSState *env, uint32_t sel)
+{
+    return env->CP0_WatchHi[sel];
+}
 #endif /* TARGET_MIPS64 */
 
 void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
@@ -1950,11 +1960,20 @@ void helper_mtc0_watchlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 
 void helper_mtc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 {
-    int mask = 0x40000FF8 | (env->CP0_EntryHi_ASID_mask << CP0WH_ASID);
+    uint64_t mask = 0x40000FF8 | (env->CP0_EntryHi_ASID_mask << CP0WH_ASID);
+    if ((env->CP0_Config5 >> CP0C5_MI) & 1) {
+        mask |= 0xFFFFFFFF00000000ULL; /* MMID */
+    }
     env->CP0_WatchHi[sel] = arg1 & mask;
     env->CP0_WatchHi[sel] &= ~(env->CP0_WatchHi[sel] & arg1 & 0x7);
 }
 
+void helper_mthc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
+{
+    env->CP0_WatchHi[sel] = ((uint64_t) (arg1) << 32) |
+                            (env->CP0_WatchHi[sel] & 0x00000000ffffffffULL);
+}
+
 void helper_mtc0_xcontext(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong mask = (1ULL << (env->SEGBITS - 7)) - 1;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1b38356..7cda5c7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2549,6 +2549,7 @@ typedef struct DisasContext {
     bool abs2008;
     bool saar;
     bool crcp;
+    bool mi;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
@@ -6785,6 +6786,25 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
+    case CP0_REGISTER_19:
+        switch (sel) {
+        case 0:
+        case 1:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
+            /* upper 32 bits are only available when Config5MI != 0 */
+            CP0_CHECK(ctx->mi);
+            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, CP0_WatchHi[sel]), 0);
+            register_name = "WatchHi";
+            break;
+        default:
+            goto cp0_unimplemented;
+        }
+        break;
     case CP0_REGISTER_28:
         switch (sel) {
         case 0:
@@ -6871,6 +6891,25 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
+    case CP0_REGISTER_19:
+        switch (sel) {
+        case 0:
+        case 1:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
+            /* upper 32 bits are only available when Config5MI != 0 */
+            CP0_CHECK(ctx->mi);
+            gen_helper_0e1i(mthc0_watchhi, arg, sel);
+            register_name = "WatchHi";
+            break;
+        default:
+            goto cp0_unimplemented;
+        }
+        break;
     case CP0_REGISTER_28:
         switch (sel) {
         case 0:
@@ -8924,7 +8963,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case CP0_REG19__WATCHHI6:
         case CP0_REG19__WATCHHI7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
-            gen_helper_1e0i(mfc0_watchhi, arg, sel);
+            gen_helper_1e0i(dmfc0_watchhi, arg, sel);
             register_name = "WatchHi";
             break;
         default:
@@ -30854,6 +30893,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
     ctx->crcp = (env->CP0_Config5 >> CP0C5_CRCP) & 1;
+    ctx->mi = (env->CP0_Config5 >> CP0C5_MI) & 1;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
-- 
2.7.4


