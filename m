Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7E9C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09E621D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmG9XRpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09E621D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vxN-0003rT-Vr
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vky-0002jC-PN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkw-0004XL-RX
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:56 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:52760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vku-0004V8-6P
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:53 -0500
Received: by mail-pj1-x1032.google.com with SMTP id lt1so557181pjb.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=rV5zl3knvvrIidJB1TNmvgksYsMzcb+ogWZjrpQb3Yk=;
 b=FmG9XRpWqdPopmGcH/tswFUg4QZU4BPkVBpHY81YOi/6VMSnMgiDM0Wfp4FdM/pIYd
 Qv2UIz/6YjSW5GvSCwmxjsNKQdtvko+8s3DyrXvArOz2mcOBRsyeyBYrH6dwdFjOE7tS
 g/NkjXoUsCuNKsbltPh+FNCV4nGNf3ArT8u3AEfmdQ9h0F1EPQuUQ5HWmAdr5OoeZ9qj
 o5WAAVgiCxrj6cFA0cU1bXTOnI4H8qjIEcMbBGKmr3rlmEu2QwN3kIIilnx9GlQw/O//
 OIBdeYr+j5cc4/MCjaZ8XZ4LoJM2m4//7sshLX9WBtWbSgU0YlNiyfOoeTbQNF5/lvCZ
 DZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=rV5zl3knvvrIidJB1TNmvgksYsMzcb+ogWZjrpQb3Yk=;
 b=tKyqgyd6sgKC/Z19UlBeiRRuoeBSJ0tLT8e6fkIypTvLvpCUoL/zEWWAaXMhdZStYg
 I4qbL4NHlMS5dpevpxoVMVFzED/1Ed8d/7RZ92WZHgBQrPKDUZeAe9XrqD16t2Mbob6o
 qhk5b6oN4iD9yAEfsOf9eA4n1oCy8aEEJDK1WNUOqwkXE+iWFQCB1jmpV256whEbViSH
 hrHfnpO9ZO1cqVn+1HGe3vTEElmYOlEhzNwQJaAD24v56oA70uAFBcpMgp44UbV1e3wc
 EFHB84BTqc1yeTeMejjfkcdv3aHacXdkt6XNV7oSla+vEcPbSYS5b+S0+scU4SuNjU0g
 T4JA==
X-Gm-Message-State: ANhLgQ0/9YFqJfeqmcGIkqzpZm+X8yqFS9fjbK8f9i3Tn1f9HCsyqzZl
 Lnr1aFXkM2oYFgZGLzJ6Wuf0aA==
X-Google-Smtp-Source: ADFU+vvJyYtAbkxCPBuT62a/t5tLQFt8Ob2NQwfxlXevZ4mzftugqvpbnE3d/p5thmf9CuQ1vfNw4w==
X-Received: by 2002:a17:902:bc4a:: with SMTP id
 t10mr1712261plz.103.1583196591032; 
 Mon, 02 Mar 2020 16:49:51 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id w11sm22077229pgh.5.2020.03.02.16.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:50 -0800 (PST)
Subject: [PULL 30/38] target/riscv: Implement second stage MMU
Date: Mon,  2 Mar 2020 16:48:40 -0800
Message-Id: <20200303004848.136788-31-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1032
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

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.h        |   1 +
 target/riscv/cpu_helper.c | 193 ++++++++++++++++++++++++++++++++++----
 2 files changed, 175 insertions(+), 19 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index aa04e5cca7..a8534fdf2b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -104,6 +104,7 @@ struct CPURISCVState {
     target_ulong frm;
 
     target_ulong badaddr;
+    target_ulong guest_phys_fault_addr;
 
     target_ulong priv_ver;
     target_ulong misa;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8ae1038bcd..584b0c71fb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -285,11 +285,12 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
  * @mmu_idx: Indicates current privilege level
  * @first_stage: Are we in first stage translation?
  *               Second stage is used for hypervisor guest translation
+ * @two_stage: Are we going to perform two stage translation
  */
 static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 int *prot, target_ulong addr,
                                 int access_type, int mmu_idx,
-                                bool first_stage)
+                                bool first_stage, bool two_stage)
 {
     /* NOTE: the env->pc value visible here will not be
      * correct, but the value visible to the exception handler
@@ -297,13 +298,40 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     MemTxResult res;
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int mode = mmu_idx;
+    bool use_background = false;
 
+    /*
+     * Check if we should use the background registers for the two
+     * stage translation. We don't need to check if we actually need
+     * two stage translation as that happened before this function
+     * was called. Background registers will be used if the guest has
+     * forced a two stage translation to be on (in HS or M mode).
+     */
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(env->mstatus, MSTATUS_MPP);
+
+            if (riscv_has_ext(env, RVH) &&
+                get_field(env->mstatus, MSTATUS_MPV)) {
+                use_background = true;
+            }
+        }
+    }
+
+    if (mode == PRV_S && access_type != MMU_INST_FETCH &&
+        riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
+        if (get_field(env->hstatus, HSTATUS_SPRV)) {
+            mode = get_field(env->mstatus, SSTATUS_SPP);
+            use_background = true;
         }
     }
 
+    if (first_stage == false) {
+        /* We are in stage 2 translation, this is similar to stage 1. */
+        /* Stage 2 is always taken as U-mode */
+        mode = PRV_U;
+    }
+
     if (mode == PRV_M || !riscv_feature(env, RISCV_FEATURE_MMU)) {
         *physical = addr;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -313,13 +341,30 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     *prot = 0;
 
     hwaddr base;
-    int levels, ptidxbits, ptesize, vm, sum;
-    int mxr = get_field(env->mstatus, MSTATUS_MXR);
+    int levels, ptidxbits, ptesize, vm, sum, mxr, widened;
+
+    if (first_stage == true) {
+        mxr = get_field(env->mstatus, MSTATUS_MXR);
+    } else {
+        mxr = get_field(env->vsstatus, MSTATUS_MXR);
+    }
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-        base = (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
+        if (first_stage == true) {
+            if (use_background) {
+                base = (hwaddr)get_field(env->vsatp, SATP_PPN) << PGSHIFT;
+                vm = get_field(env->vsatp, SATP_MODE);
+            } else {
+                base = (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
+                vm = get_field(env->satp, SATP_MODE);
+            }
+            widened = 0;
+        } else {
+            base = (hwaddr)get_field(env->hgatp, HGATP_PPN) << PGSHIFT;
+            vm = get_field(env->hgatp, HGATP_MODE);
+            widened = 2;
+        }
         sum = get_field(env->mstatus, MSTATUS_SUM);
-        vm = get_field(env->satp, SATP_MODE);
         switch (vm) {
         case VM_1_10_SV32:
           levels = 2; ptidxbits = 10; ptesize = 4; break;
@@ -337,6 +382,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
           g_assert_not_reached();
         }
     } else {
+        widened = 0;
         base = (hwaddr)(env->sptbr) << PGSHIFT;
         sum = !get_field(env->mstatus, MSTATUS_PUM);
         vm = get_field(env->mstatus, MSTATUS_VM);
@@ -357,9 +403,16 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     }
 
     CPUState *cs = env_cpu(env);
-    int va_bits = PGSHIFT + levels * ptidxbits;
-    target_ulong mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
-    target_ulong masked_msbs = (addr >> (va_bits - 1)) & mask;
+    int va_bits = PGSHIFT + levels * ptidxbits + widened;
+    target_ulong mask, masked_msbs;
+
+    if (TARGET_LONG_BITS > (va_bits - 1)) {
+        mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
+    } else {
+        mask = 0;
+    }
+    masked_msbs = (addr >> (va_bits - 1)) & mask;
+
     if (masked_msbs != 0 && masked_msbs != mask) {
         return TRANSLATE_FAIL;
     }
@@ -371,11 +424,29 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 restart:
 #endif
     for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
-        target_ulong idx = (addr >> (PGSHIFT + ptshift)) &
+        target_ulong idx;
+        if (i == 0) {
+            idx = (addr >> (PGSHIFT + ptshift)) &
+                           ((1 << (ptidxbits + widened)) - 1);
+        } else {
+            idx = (addr >> (PGSHIFT + ptshift)) &
                            ((1 << ptidxbits) - 1);
+        }
 
         /* check that physical address of PTE is legal */
-        hwaddr pte_addr = base + idx * ptesize;
+        hwaddr pte_addr;
+
+        if (two_stage && first_stage) {
+            hwaddr vbase;
+
+            /* Do the second stage translation on the base PTE address. */
+            get_physical_address(env, &vbase, prot, base, access_type,
+                                 mmu_idx, false, true);
+
+            pte_addr = vbase + idx * ptesize;
+        } else {
+            pte_addr = base + idx * ptesize;
+        }
 
         if (riscv_feature(env, RISCV_FEATURE_PMP) &&
             !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
@@ -472,7 +543,12 @@ restart:
             /* for superpage mappings, make a fake leaf PTE for the TLB's
                benefit. */
             target_ulong vpn = addr >> PGSHIFT;
-            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
+            if (i == 0) {
+                *physical = (ppn | (vpn & ((1L << (ptshift + widened)) - 1))) <<
+                             PGSHIFT;
+            } else {
+                *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
+            }
 
             /* set permissions on the TLB entry */
             if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
@@ -531,14 +607,23 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
     hwaddr phys_addr;
     int prot;
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
-    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
-                             true)) {
+    if (get_physical_address(env, &phys_addr, &prot, addr, 0, mmu_idx,
+                             true, riscv_cpu_virt_enabled(env))) {
         return -1;
     }
+
+    if (riscv_cpu_virt_enabled(env)) {
+        if (get_physical_address(env, &phys_addr, &prot, phys_addr,
+                                 0, mmu_idx, false, true)) {
+            return -1;
+        }
+    }
+
     return phys_addr;
 }
 
@@ -592,17 +677,37 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 #ifndef CONFIG_USER_ONLY
+    vaddr im_address;
     hwaddr pa = 0;
     int prot;
     bool pmp_violation = false;
+    bool m_mode_two_stage = false;
+    bool hs_mode_two_stage = false;
+    bool first_stage_error = true;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
 
+    env->guest_phys_fault_addr = 0;
+
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
-                               true);
+    /*
+     * Determine if we are in M mode and MPRV is set or in HS mode and SPRV is
+     * set and we want to access a virtulisation address.
+     */
+    if (riscv_has_ext(env, RVH)) {
+        m_mode_two_stage = env->priv == PRV_M &&
+                           access_type != MMU_INST_FETCH &&
+                           get_field(env->mstatus, MSTATUS_MPRV) &&
+                           get_field(env->mstatus, MSTATUS_MPV);
+
+        hs_mode_two_stage = env->priv == PRV_S &&
+                            !riscv_cpu_virt_enabled(env) &&
+                            access_type != MMU_INST_FETCH &&
+                            get_field(env->hstatus, HSTATUS_SPRV) &&
+                            get_field(env->hstatus, HSTATUS_SPV);
+    }
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
@@ -610,9 +715,55 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     }
 
-    qemu_log_mask(CPU_LOG_MMU,
-                  "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
-                  " prot %d\n", __func__, address, ret, pa, prot);
+    if (riscv_cpu_virt_enabled(env) || m_mode_two_stage || hs_mode_two_stage) {
+        /* Two stage lookup */
+        ret = get_physical_address(env, &pa, &prot, address, access_type,
+                                   mmu_idx, true, true);
+
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s 1st-stage address=%" VADDR_PRIx " ret %d physical "
+                      TARGET_FMT_plx " prot %d\n",
+                      __func__, address, ret, pa, prot);
+
+        if (ret != TRANSLATE_FAIL) {
+            /* Second stage lookup */
+            im_address = pa;
+
+            ret = get_physical_address(env, &pa, &prot, im_address,
+                                       access_type, mmu_idx, false, true);
+
+            qemu_log_mask(CPU_LOG_MMU,
+                    "%s 2nd-stage address=%" VADDR_PRIx " ret %d physical "
+                    TARGET_FMT_plx " prot %d\n",
+                    __func__, im_address, ret, pa, prot);
+
+            if (riscv_feature(env, RISCV_FEATURE_PMP) &&
+                (ret == TRANSLATE_SUCCESS) &&
+                !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
+                ret = TRANSLATE_PMP_FAIL;
+            }
+
+            if (ret != TRANSLATE_SUCCESS) {
+                /*
+                 * Guest physical address translation failed, this is a HS
+                 * level exception
+                 */
+                first_stage_error = false;
+                env->guest_phys_fault_addr = (im_address |
+                                              (address &
+                                               (TARGET_PAGE_SIZE - 1))) >> 2;
+            }
+        }
+    } else {
+        /* Single stage lookup */
+        ret = get_physical_address(env, &pa, &prot, address, access_type,
+                                   mmu_idx, true, false);
+
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s address=%" VADDR_PRIx " ret %d physical "
+                      TARGET_FMT_plx " prot %d\n",
+                      __func__, address, ret, pa, prot);
+    }
 
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
@@ -622,6 +773,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (ret == TRANSLATE_PMP_FAIL) {
         pmp_violation = true;
     }
+
     if (ret == TRANSLATE_SUCCESS) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
                      prot, mmu_idx, TARGET_PAGE_SIZE);
@@ -629,9 +781,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        raise_mmu_exception(env, address, access_type, pmp_violation, true);
+        raise_mmu_exception(env, address, access_type, pmp_violation, first_stage_error);
         riscv_raise_exception(env, cs->exception_index, retaddr);
     }
+
+    return true;
+
 #else
     switch (access_type) {
     case MMU_INST_FETCH:
-- 
2.25.0.265.gbab2e86ba0-goog


