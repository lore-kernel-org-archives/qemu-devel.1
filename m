Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D01C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E73821835
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TVPtbzq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E73821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWm6X-00025H-Bg
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm3d-0005MO-Cg; Thu, 07 May 2020 15:19:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm3b-0000wE-Nf; Thu, 07 May 2020 15:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588879183; x=1620415183;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X7f6BLu7XPQ5Nlou8nPG0/ptu1lZX5ZnYkrfQRviITE=;
 b=TVPtbzq4k6ux8IO+yUXAKAckNoNHNyFY9r/c7/YPwhtoHnUjzRAwq1Dk
 2zL2YaUMSFveMHgRscVXL4HMSSk6a6ooPyGnhWmE3sbvVnRVHXSIea46o
 6ishD5ZObUVYwzEnCVUI5QSMayITf7SD29p++yaQY0y2kimvRI68SOtz4
 +L9Xx/UAdoyID8a6DuAdrDw6lJ0O9JPYjqu6WZpNHMc+2XThEW04X7kRn
 6dFWVzOkqVXzIwNRO8YSBlVUBdf9CwtUH5ZkO9LeOK/FNOkg2aOdAAgoz
 CSeWHpBa83F0MR1TTg9fw0ArO/R1ClBlRtF24r26IZMrs66Ykb4uvbu5R g==;
IronPort-SDR: Nu+6GLEgx23NL/wMyOyQbvipVm2hjXJmJwoYB/LiLXV300ikzoQypxNQ3uSODjmhedfDA3yfEg
 XYYsbu63cvepuGUixxbo6z37b12F+KnsAN0m964QzhHKakMqRj7MK9Y8kUE1CTmRbINzKUm0gp
 aFAjQGwPmy7J8EvRtefzYD3snImXyYGPBrEWZetx/EL8T3WYzUeyGxDdWVarbqaInHvNPH8wV8
 RE/6t+b1btWIKRUG0obOHu21kPUb6C6w287KcpAN0Voyw7S2q3L9gitebxo+2SmhqqFf6tfmLw
 jsM=
X-IronPort-AV: E=Sophos;i="5.73,364,1583164800"; d="scan'208";a="137166259"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 03:19:42 +0800
IronPort-SDR: 7QSgY4/XYhm1hmmy34iHWRA7I+xZxSGmlhYCPLtO6CRprjHeUAbG7pzTaAVCk1eW+C1SpSFy+S
 eLxxqRd46KV6MN3uGnF7GpRayOIXYY2ig=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 12:09:33 -0700
IronPort-SDR: usz5hogJk5ReFpGrUhdC0wS1ANngsk766eDezQeiHVW+WhvEzWHK1yzfUvS0dW8YPb5o/g+4Lz
 TUemdJtm1L2w==
WDCIronportException: Internal
Received: from uscxm6l72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.6])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 May 2020 12:19:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 3/3] target/riscv: Drop support for ISA spec version 1.09.1
Date: Thu,  7 May 2020 12:11:23 -0700
Message-Id: <341f49712f36d53b9d8588da8c7bac712fa7bfcc.1588878640.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588878640.git.alistair.francis@wdc.com>
References: <cover.1588878640.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=38990af3b=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 15:19:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The RISC-V ISA spec version 1.09.1 has been deprecated in QEMU since
4.1. It's not commonly used so let's remove support for it.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                            |  2 -
 target/riscv/cpu.h                            |  1 -
 target/riscv/csr.c                            | 82 ++++---------------
 .../riscv/insn_trans/trans_privileged.inc.c   |  6 --
 4 files changed, 17 insertions(+), 74 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 112f2e3a2f..eeb91f8513 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -368,8 +368,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
             priv_version = PRIV_VERSION_1_11_0;
         } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
             priv_version = PRIV_VERSION_1_10_0;
-        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.9.1")) {
-            priv_version = PRIV_VERSION_1_09_1;
         } else {
             error_setg(errp,
                        "Unsupported privilege spec version '%s'",
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 76b98d7a33..c022539012 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -73,7 +73,6 @@ enum {
     RISCV_FEATURE_MISA
 };
 
-#define PRIV_VERSION_1_09_1 0x00010901
 #define PRIV_VERSION_1_10_0 0x00011000
 #define PRIV_VERSION_1_11_0 0x00011100
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 11d184cd16..df3498b24f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -58,31 +58,11 @@ static int ctr(CPURISCVState *env, int csrno)
 #if !defined(CONFIG_USER_ONLY)
     CPUState *cs = env_cpu(env);
     RISCVCPU *cpu = RISCV_CPU(cs);
-    uint32_t ctr_en = ~0u;
 
     if (!cpu->cfg.ext_counters) {
         /* The Counters extensions is not enabled */
         return -1;
     }
-
-    /*
-     * The counters are always enabled at run time on newer priv specs, as the
-     * CSR has changed from controlling that the counters can be read to
-     * controlling that the counters increment.
-     */
-    if (env->priv_ver > PRIV_VERSION_1_09_1) {
-        return 0;
-    }
-
-    if (env->priv < PRV_M) {
-        ctr_en &= env->mcounteren;
-    }
-    if (env->priv < PRV_S) {
-        ctr_en &= env->scounteren;
-    }
-    if (!(ctr_en & (1u << (csrno & 31)))) {
-        return -1;
-    }
 #endif
     return 0;
 }
@@ -358,34 +338,21 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
     int dirty;
 
     /* flush tlb on mstatus fields that affect VM */
-    if (env->priv_ver <= PRIV_VERSION_1_09_1) {
-        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
-                MSTATUS_MPRV | MSTATUS_SUM | MSTATUS_VM)) {
-            tlb_flush(env_cpu(env));
-        }
-        mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
-            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
-            MSTATUS_MPP | MSTATUS_MXR |
-            (validate_vm(env, get_field(val, MSTATUS_VM)) ?
-                MSTATUS_VM : 0);
+    if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_MPV |
+            MSTATUS_MPRV | MSTATUS_SUM)) {
+        tlb_flush(env_cpu(env));
     }
-    if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_MPV |
-                MSTATUS_MPRV | MSTATUS_SUM)) {
-            tlb_flush(env_cpu(env));
-        }
-        mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
-            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
-            MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
-            MSTATUS_TW;
+    mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
+        MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
+        MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
+        MSTATUS_TW;
 #if defined(TARGET_RISCV64)
-            /*
-             * RV32: MPV and MTL are not in mstatus. The current plan is to
-             * add them to mstatush. For now, we just don't support it.
-             */
-            mask |= MSTATUS_MTL | MSTATUS_MPV;
+        /*
+         * RV32: MPV and MTL are not in mstatus. The current plan is to
+         * add them to mstatush. For now, we just don't support it.
+         */
+        mask |= MSTATUS_MTL | MSTATUS_MPV;
 #endif
-    }
 
     mstatus = (mstatus & ~mask) | (val & mask);
 
@@ -553,8 +520,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
 /* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
 static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    if (env->priv_ver > PRIV_VERSION_1_09_1
-        && env->priv_ver < PRIV_VERSION_1_11_0) {
+    if (env->priv_ver < PRIV_VERSION_1_11_0) {
         return -1;
     }
     *val = env->mcounteren;
@@ -564,8 +530,7 @@ static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 /* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
 static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
 {
-    if (env->priv_ver > PRIV_VERSION_1_09_1
-        && env->priv_ver < PRIV_VERSION_1_11_0) {
+    if (env->priv_ver < PRIV_VERSION_1_11_0) {
         return -1;
     }
     env->mcounteren = val;
@@ -574,20 +539,13 @@ static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
 
 static int read_mucounteren(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    if (env->priv_ver > PRIV_VERSION_1_09_1) {
-        return -1;
-    }
-    *val = env->scounteren;
+    return -1;
     return 0;
 }
 
 static int write_mucounteren(CPURISCVState *env, int csrno, target_ulong val)
 {
-    if (env->priv_ver > PRIV_VERSION_1_09_1) {
-        return -1;
-    }
-    env->scounteren = val;
-    return 0;
+    return -1;
 }
 
 /* Machine Trap Handling */
@@ -829,13 +787,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
     if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
         return 0;
     }
-    if (env->priv_ver <= PRIV_VERSION_1_09_1 && (val ^ env->sptbr)) {
-        tlb_flush(env_cpu(env));
-        env->sptbr = val & (((target_ulong)
-            1 << (TARGET_PHYS_ADDR_SPACE_BITS - PGSHIFT)) - 1);
-    }
-    if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        validate_vm(env, get_field(val, SATP_MODE)) &&
+    if (validate_vm(env, get_field(val, SATP_MODE)) &&
         ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
     {
         if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index 76c2fad71c..1af9fa7df8 100644
--- a/target/riscv/insn_trans/trans_privileged.inc.c
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -95,12 +95,6 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 
 static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
 {
-#ifndef CONFIG_USER_ONLY
-    if (ctx->priv_ver <= PRIV_VERSION_1_09_1) {
-        gen_helper_tlb_flush(cpu_env);
-        return true;
-    }
-#endif
     return false;
 }
 
-- 
2.26.2


