Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5E8C47254
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 01:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D889D20721
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 01:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i2TTOJWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D889D20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW8mN-0001mz-Vf
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 21:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=3884e71da=alistair.francis@wdc.com>)
 id 1jW8jh-0007vu-PK; Tue, 05 May 2020 21:20:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:1677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=3884e71da=alistair.francis@wdc.com>)
 id 1jW8je-0005UR-VS; Tue, 05 May 2020 21:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588728031; x=1620264031;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N9MhgPPg7IPRCiV7k9AHL7ldHKDkULH8EwoDhsj+uL8=;
 b=i2TTOJWqQNsMjtnpL05DlsawlkMvWrvjPKqt62uwUBrxBjtfZ1Fehxq5
 xBO1FfYS7zmH5ODsWFxp0xq6eu2m62ufRkdjGhhqKAZM8PM6Ni5EKp2jc
 pH54+09AS+gjC/Ig5LfuIvExvpqA4qwcEZosyelfXoWsS0/RIWXFW0hEe
 J0VrSBPVv/S56eHrx21n9Lt2mddm/jeOtkv2cq0CZHSbr9TwRGFGJ1mnI
 ruCsQqHPRVriAk31jtQT1OjxNh+xkNuWx7Xcq1BGutwY8D/nmRZeUxRiM
 wk9vsbuRsS2mbgio5nm8y9YOVBmjcv6TMjuNII33O+x0Po7seCF5AX34M w==;
IronPort-SDR: 6yBRWDSyKC0HG/KTKp30szcViQYka1u447t/QwGE7LBfCM/zvLxzwY+nfv09zHkI7ptFIshE07
 cETDs6zo9K17U3VE8AXtLbxzUCpi7R9L7TdX0i7qAyunoTys53jeZhXm/RCVWpeRZWWay184C9
 wKyQMcHgxwNLBParuzhFarAK2S/t74zOztiebFuYBTRaQURkJXPocdVy1LhRJ+/tF8q4mbjqXe
 8T/UBsnetgkSNh5xp65TyeU82nRW5t0/md1gtLGPvm1ZU4bktZ+fjBD5ZMBszZoK5SP91uS37C
 T9E=
X-IronPort-AV: E=Sophos;i="5.73,357,1583164800"; d="scan'208";a="138433831"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 06 May 2020 09:20:29 +0800
IronPort-SDR: mlRyUITPe+2thttFavfxxNPyOukRMOpLZfgBX/JUgxJpZ+6kUt2bxLZDdL/EwnbZXqhyroMhdQ
 2T7Ffs+fMBV9GJphwmPREGYizxv5Yqe5U=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 18:10:56 -0700
IronPort-SDR: a94lCTybhGbVD3k5krTyIvqplyck7/8OP4bg0/ZBgSjBbroB6aEyw+4eIlCVKAUJ4uUvRgRHc/
 c+06m81mnxeg==
WDCIronportException: Internal
Received: from use204286.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.224])
 by uls-op-cesaip01.wdc.com with ESMTP; 05 May 2020 18:20:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 2/2] target/riscv: Drop support for ISA spec version 1.09.1
Date: Tue,  5 May 2020 18:12:11 -0700
Message-Id: <31e61b6cd45bbfa91ce924cdb19ca9844f0907b9.1588727508.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588727508.git.alistair.francis@wdc.com>
References: <cover.1588727508.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=3884e71da=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 21:20:25
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
 target/riscv/cpu.c                            | 30 -------
 target/riscv/cpu.h                            |  8 --
 target/riscv/csr.c                            | 82 ++++---------------
 .../riscv/insn_trans/trans_privileged.inc.c   |  6 --
 tests/qtest/machine-none-test.c               |  4 +-
 5 files changed, 19 insertions(+), 111 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c7..eeb91f8513 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -135,16 +135,6 @@ static void riscv_base32_cpu_init(Object *obj)
     set_misa(env, 0);
 }
 
-static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    set_priv_version(env, PRIV_VERSION_1_09_1);
-    set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_MMU);
-    set_feature(env, RISCV_FEATURE_PMP);
-}
-
 static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -182,16 +172,6 @@ static void riscv_base64_cpu_init(Object *obj)
     set_misa(env, 0);
 }
 
-static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    set_priv_version(env, PRIV_VERSION_1_09_1);
-    set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_MMU);
-    set_feature(env, RISCV_FEATURE_PMP);
-}
-
 static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -388,8 +368,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
             priv_version = PRIV_VERSION_1_11_0;
         } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
             priv_version = PRIV_VERSION_1_10_0;
-        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.9.1")) {
-            priv_version = PRIV_VERSION_1_09_1;
         } else {
             error_setg(errp,
                        "Unsupported privilege spec version '%s'",
@@ -621,18 +599,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
-    /* Depreacted */
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init)
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
-    /* Deprecated */
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init)
 #endif
 };
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d0e7f5b9c5..c022539012 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -40,13 +40,6 @@
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
-/* Deprecated */
-#define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu-nommu")
-#define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
-#define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.10.0")
-#define TYPE_RISCV_CPU_RV64IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv64imacu-nommu")
-#define TYPE_RISCV_CPU_RV64GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.9.1")
-#define TYPE_RISCV_CPU_RV64GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.10.0")
 
 #define RV32 ((target_ulong)1 << (TARGET_LONG_BITS - 2))
 #define RV64 ((target_ulong)2 << (TARGET_LONG_BITS - 2))
@@ -80,7 +73,6 @@ enum {
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
 
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 8bb54a6360..b52311ec2e 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -54,8 +54,8 @@ static struct arch2cpu cpus_map[] = {
     { "xtensa", "dc233c" },
     { "xtensaeb", "fsf" },
     { "hppa", "hppa" },
-    { "riscv64", "rv64gcsu-v1.10.0" },
-    { "riscv32", "rv32gcsu-v1.9.1" },
+    { "riscv64", "sifive-u54" },
+    { "riscv32", "sifive-u34" },
     { "rx", "rx62n" },
 };
 
-- 
2.26.2


