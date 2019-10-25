Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D53CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BB121D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L878mvZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BB121D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9H4-00029w-Jc
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90z-00056D-UZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90v-0004KY-U7
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90s-0004DA-6f; Fri, 25 Oct 2019 19:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046138; x=1603582138;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CTrr4qdivPfJC5uFIs0kK2KS6KzaJSQCgGtWYHEHsP8=;
 b=L878mvZl9Ru1ttD7s9xWi3eRTS0GC4SgsYiCT3PcopSVxhjYAgz+vQtN
 Ux+WZF0uPzx5c7/1/jNjFrt0ebck0MCj4cqLuG//WtjzDnkgNtO5SelRf
 zOFTEFU1cws1/NXD5hzdU0fIdzNEGlQ56ZMckN8WIqKYMIUlgFX4exAXu
 62v4EmvNiEaLJBit4JVUeKmTEeTkFc3q0La4kK8GNDKo/FCXyDSSPqidH
 vrEfVrQ1PrVPbFYJx6Sj45MXMCi3FN4fFT59lwTYUuYN0xe2ecWUDNqgS
 P8dzwbn6fyI5dLS8ep68mannlvnzzN2zPvhQO3JogaTFcLp8z4H6WWl4C A==;
IronPort-SDR: HemOfHT8dBG6LysUmGdTO/mQ5ph8rI7nsvMM6Tdojul7BAaTLDD2LMlYVqPbWzoFiE9nu5rh1k
 E4EuibP5K4omrv75v6gnKRcYdhGukaBHsv+lyRttUFpO8MwDnHYyRMy4xQzbvLYui5tSamVoPZ
 xXoNcKGct8/0mZ9EmhE19OHIIya+EHrIn+mdng/K4Y/ZZP9uxV+V/MRMQ5dZtl/Zc4qzbsXyh9
 ibkold4qhY+bokRlsUF/U3loNlO2h/rMaRg3aX8NrTKBXB19ji3LtvHMEFGnnN4I66CV5CJuBg
 V3o=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520405"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:41 +0800
IronPort-SDR: bfnx9PCikoj75w8jTdDPON1FRg3hAUVJ6luQTBupmS/+SGmFgDFMvSOCwd8V8ZX1HGwzgLtMer
 J+Zma46Ht39ZESN4Y6QqGl6TkFEofv3IvvQpSVBpCxHYzORQ0PjFbpronpyBxv/Zg2blMum3ZW
 xjaXV6HK+itpz9mwk4RANbKDA1eBkeJhAy6WLaW1XpNeBdVqJ2qRZDtcVO6Ou+ax8cPpa6yf4/
 TLJ2lbxU49uO/H5yoQqvbh/SSwsnfbLqigIDsYojcr7s+01b0bnpfUsOeie+4N+ONawbcAwapV
 banqU3iUEYJGwhJwq6h0bSYS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:07 -0700
IronPort-SDR: MVT5WQEUQwrB2J/NGEqhyo1i9GNVAd5R/c+2+8ua9esbsidsKkabsCjl+Otn3FRVEDWU4q/+xk
 m5EMv+SB1ENOHALc6ltwb+QCsKzkz5KWSx3VM6FNhCAxN1ECQ3MFqzc9uq0fjnYNR5QO21hN3x
 dKjHRBAK3ibjsiK26XOB2Wo2vEXzauu9EVhODkmRG7pkMBzZVJ8684q1fA4itxt+wv763bZjIl
 bnKWPpV2Xvixa+5RIPhuIFOeaqf69nHiG5yr8gii9/2dnDcMfhswa+jgzHOJyVwF1DLRow++6I
 /A8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:28:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 11/27] target/riscv: Convert mie and mstatus to pointers
Date: Fri, 25 Oct 2019 16:23:46 -0700
Message-Id: <3da1c9355946d5571787f9c87ff98a74061bed76.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To handle the new Hypervisor CSR register aliasing let's use pointers.

We only need to convert the MIE and MSTATUS CSRs. With the exception of
MIP all of the other CSRs that swap with virtulsation changes are S-Mode
only, so we can just do a lazy switch. This because more challenging for
the M-Mode registers so it ends up being easier to use pointers.

As the MIP CSR is always accessed atomicly the pointer swap doesn't work
so we leave that as is.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c        | 16 ++++++++++++----
 target/riscv/cpu.h        | 12 ++++++++++--
 target/riscv/cpu_helper.c | 32 ++++++++++++++++----------------
 target/riscv/csr.c        | 28 ++++++++++++++--------------
 target/riscv/op_helper.c  | 14 +++++++-------
 5 files changed, 59 insertions(+), 43 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e66fd300fd..f75c709e35 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -228,7 +228,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
-    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", *env->mstatus);
     if (riscv_has_ext(env, RVH)) {
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bstatus ", env->vsstatus);
@@ -238,7 +238,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsip    ",
                      (target_ulong)atomic_read(&env->vsip));
     }
-    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", *env->mie);
     if (riscv_has_ext(env, RVH)) {
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsie    ", env->vsie);
     }
@@ -308,7 +308,7 @@ static bool riscv_cpu_has_work(CPUState *cs)
      * Definition of the WFI instruction requires it to ignore the privilege
      * mode and delegation registers, but respect individual enables
      */
-    return (env->mip & env->mie) != 0;
+    return (env->mip & *env->mie) != 0;
 #else
     return true;
 #endif
@@ -329,7 +329,7 @@ static void riscv_cpu_reset(CPUState *cs)
     mcc->parent_reset(cs);
 #ifndef CONFIG_USER_ONLY
     env->priv = PRV_M;
-    env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
+    *env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     env->mcause = 0;
     env->pc = env->resetvec;
 #endif
@@ -458,8 +458,16 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 static void riscv_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
+#ifndef CONFIG_USER_ONLY
+    CPURISCVState *env = &cpu->env;
+#endif
 
     cpu_set_cpustate_pointers(cpu);
+
+#ifndef CONFIG_USER_ONLY
+    env->mie = &env->mie_novirt;
+    env->mstatus = &env->mstatus_novirt;
+#endif
 }
 
 static const VMStateDescription vmstate_riscv_cpu = {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a1625e8af0..5b71ee416f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -122,12 +122,12 @@ struct CPURISCVState {
     target_ulong resetvec;
 
     target_ulong mhartid;
-    target_ulong mstatus;
+    target_ulong *mstatus;
 
     target_ulong mip;
     uint32_t miclaim;
 
-    target_ulong mie;
+    target_ulong *mie;
     target_ulong mideleg;
 
     target_ulong sptbr;  /* until: priv-1.9.1 */
@@ -145,6 +145,14 @@ struct CPURISCVState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
+    /* The following registers are the "real" versions that the pointer
+     * versions point to. These should never be used unless you know what you
+     * are doing. To access these use the pointer versions instead. This is
+     * required to handle the Hypervisor register swapping.
+     */
+    target_ulong mie_novirt;
+    target_ulong mstatus_novirt;
+
     /* Hypervisor CSRs */
     target_ulong hstatus;
     target_ulong hedeleg;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 1464f73bee..21d049cdce 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -37,9 +37,9 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 #ifndef CONFIG_USER_ONLY
 static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
-    target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
-    target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
-    target_ulong pending = env->mip & env->mie;
+    target_ulong mstatus_mie = get_field(*env->mstatus, MSTATUS_MIE);
+    target_ulong mstatus_sie = get_field(*env->mstatus, MSTATUS_SIE);
+    target_ulong pending = env->mip & *env->mie;
     target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
     target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
     target_ulong irqs = (pending & ~env->mideleg & -mie) |
@@ -75,7 +75,7 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 /* Return true is floating point support is currently enabled */
 bool riscv_cpu_fp_enabled(CPURISCVState *env)
 {
-    if (env->mstatus & MSTATUS_FS) {
+    if (*env->mstatus & MSTATUS_FS) {
         return true;
     }
 
@@ -198,8 +198,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     int mode = mmu_idx;
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
-        if (get_field(env->mstatus, MSTATUS_MPRV)) {
-            mode = get_field(env->mstatus, MSTATUS_MPP);
+        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
+            mode = get_field(*env->mstatus, MSTATUS_MPP);
         }
     }
 
@@ -213,11 +213,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 
     hwaddr base;
     int levels, ptidxbits, ptesize, vm, sum;
-    int mxr = get_field(env->mstatus, MSTATUS_MXR);
+    int mxr = get_field(*env->mstatus, MSTATUS_MXR);
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0) {
         base = (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
-        sum = get_field(env->mstatus, MSTATUS_SUM);
+        sum = get_field(*env->mstatus, MSTATUS_SUM);
         vm = get_field(env->satp, SATP_MODE);
         switch (vm) {
         case VM_1_10_SV32:
@@ -237,8 +237,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
     } else {
         base = (hwaddr)(env->sptbr) << PGSHIFT;
-        sum = !get_field(env->mstatus, MSTATUS_PUM);
-        vm = get_field(env->mstatus, MSTATUS_VM);
+        sum = !get_field(*env->mstatus, MSTATUS_PUM);
+        vm = get_field(*env->mstatus, MSTATUS_VM);
         switch (vm) {
         case VM_1_09_SV32:
           levels = 2; ptidxbits = 10; ptesize = 4; break;
@@ -493,8 +493,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
-        if (get_field(env->mstatus, MSTATUS_MPRV)) {
-            mode = get_field(env->mstatus, MSTATUS_MPP);
+        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
+            mode = get_field(*env->mstatus, MSTATUS_MPP);
         }
     }
 
@@ -607,12 +607,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (env->priv <= PRV_S &&
             cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
         /* handle the trap in S-mode */
-        target_ulong s = env->mstatus;
+        target_ulong s = *env->mstatus;
         s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_SPP, env->priv);
         s = set_field(s, MSTATUS_SIE, 0);
-        env->mstatus = s;
+        *env->mstatus = s;
         env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
         env->sepc = env->pc;
         env->sbadaddr = tval;
@@ -621,12 +621,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* handle the trap in M-mode */
-        target_ulong s = env->mstatus;
+        target_ulong s = *env->mstatus;
         s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_MPP, env->priv);
         s = set_field(s, MSTATUS_MIE, 0);
-        env->mstatus = s;
+        *env->mstatus = s;
         env->mcause = cause | ~(((target_ulong)-1) >> async);
         env->mepc = env->pc;
         env->mbadaddr = tval;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a1eb15f507..ef9c95f94d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -136,7 +136,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
-    env->mstatus |= MSTATUS_FS;
+    *env->mstatus |= MSTATUS_FS;
 #endif
     riscv_cpu_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
     return 0;
@@ -159,7 +159,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
-    env->mstatus |= MSTATUS_FS;
+    *env->mstatus |= MSTATUS_FS;
 #endif
     env->frm = val & (FSR_RD >> FSR_RD_SHIFT);
     return 0;
@@ -183,7 +183,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
-    env->mstatus |= MSTATUS_FS;
+    *env->mstatus |= MSTATUS_FS;
 #endif
     env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
     riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
@@ -307,7 +307,7 @@ static int read_mhartid(CPURISCVState *env, int csrno, target_ulong *val)
 /* Machine Trap Setup */
 static int read_mstatus(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    *val = env->mstatus;
+    *val = *env->mstatus;
     return 0;
 }
 
@@ -319,7 +319,7 @@ static int validate_vm(CPURISCVState *env, target_ulong vm)
 
 static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
-    target_ulong mstatus = env->mstatus;
+    target_ulong mstatus = *env->mstatus;
     target_ulong mask = 0;
     int dirty;
 
@@ -359,7 +359,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
              ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
             ((mstatus & MSTATUS_XS) == MSTATUS_XS);
     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
-    env->mstatus = mstatus;
+    *env->mstatus = mstatus;
 
     return 0;
 }
@@ -448,13 +448,13 @@ static int write_mideleg(CPURISCVState *env, int csrno, target_ulong val)
 
 static int read_mie(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    *val = env->mie;
+    *val = *env->mie;
     return 0;
 }
 
 static int write_mie(CPURISCVState *env, int csrno, target_ulong val)
 {
-    env->mie = (env->mie & ~all_ints) | (val & all_ints);
+    *env->mie = (*env->mie & ~all_ints) | (val & all_ints);
     return 0;
 }
 
@@ -608,7 +608,7 @@ static int read_sstatus(CPURISCVState *env, int csrno, target_ulong *val)
 {
     target_ulong mask = ((env->priv_ver >= PRIV_VERSION_1_10_0) ?
                          sstatus_v1_10_mask : sstatus_v1_9_mask);
-    *val = env->mstatus & mask;
+    *val = *env->mstatus & mask;
     return 0;
 }
 
@@ -616,19 +616,19 @@ static int write_sstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
     target_ulong mask = ((env->priv_ver >= PRIV_VERSION_1_10_0) ?
                          sstatus_v1_10_mask : sstatus_v1_9_mask);
-    target_ulong newval = (env->mstatus & ~mask) | (val & mask);
+    target_ulong newval = (*env->mstatus & ~mask) | (val & mask);
     return write_mstatus(env, CSR_MSTATUS, newval);
 }
 
 static int read_sie(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    *val = env->mie & env->mideleg;
+    *val = *env->mie & env->mideleg;
     return 0;
 }
 
 static int write_sie(CPURISCVState *env, int csrno, target_ulong val)
 {
-    target_ulong newval = (env->mie & ~env->mideleg) | (val & env->mideleg);
+    target_ulong newval = (*env->mie & ~env->mideleg) | (val & env->mideleg);
     return write_mie(env, CSR_MIE, newval);
 }
 
@@ -731,7 +731,7 @@ static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
     if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
         *val = 0;
     } else if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
+        if (env->priv == PRV_S && get_field(*env->mstatus, MSTATUS_TVM)) {
             return -1;
         } else {
             *val = env->satp;
@@ -756,7 +756,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
         validate_vm(env, get_field(val, SATP_MODE)) &&
         ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
     {
-        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
+        if (env->priv == PRV_S && get_field(*env->mstatus, MSTATUS_TVM)) {
             return -1;
         } else {
             if((val ^ env->satp) & SATP_ASID) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 331cc36232..d150551bc9 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -83,11 +83,11 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
     }
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TSR)) {
+        get_field(*env->mstatus, MSTATUS_TSR)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    target_ulong mstatus = env->mstatus;
+    target_ulong mstatus = *env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
     mstatus = set_field(mstatus,
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
@@ -96,7 +96,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
     mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
     mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
     riscv_cpu_set_mode(env, prev_priv);
-    env->mstatus = mstatus;
+    *env->mstatus = mstatus;
 
     return retpc;
 }
@@ -112,7 +112,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
-    target_ulong mstatus = env->mstatus;
+    target_ulong mstatus = *env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
     mstatus = set_field(mstatus,
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
@@ -121,7 +121,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
     mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
     mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
     riscv_cpu_set_mode(env, prev_priv);
-    env->mstatus = mstatus;
+    *env->mstatus = mstatus;
 
     return retpc;
 }
@@ -132,7 +132,7 @@ void helper_wfi(CPURISCVState *env)
 
     if (env->priv == PRV_S &&
         env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TW)) {
+        get_field(*env->mstatus, MSTATUS_TW)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         cs->halted = 1;
@@ -147,7 +147,7 @@ void helper_tlb_flush(CPURISCVState *env)
     if (!(env->priv >= PRV_S) ||
         (env->priv == PRV_S &&
          env->priv_ver >= PRIV_VERSION_1_10_0 &&
-         get_field(env->mstatus, MSTATUS_TVM))) {
+         get_field(*env->mstatus, MSTATUS_TVM))) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         tlb_flush(cs);
-- 
2.23.0


