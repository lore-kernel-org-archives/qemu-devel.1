Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D7BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB6B20867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+N7XBlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB6B20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNu3z-00052g-Up
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWi-0003kZ-8a
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWf-0007pM-II
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWf-0007ow-AU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:45 -0400
Received: by mail-wr1-x436.google.com with SMTP id q13so937477wrs.12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=91dz7KJADMxPUVCAuh+UOifd4EFprDikV0cfmChkEVM=;
 b=T+N7XBlwRwJjXw63dKnSEQP0tYvN7HTOBf/FD6e47vP6GtHvp6uiszceVLA/DQYeRE
 VgLrl8zkMBMsDjTY9FooRVZn8Kfzv9zaDz15VvFHctlLixp7QgS/JEnILQ3vy6P+QCFr
 ysCUJeOO4HkOcenzgpdlWmU6wFLhUiFYs7UP4VdQ9FecrkFr9vhatCuQcJEV7SZDZSOc
 EAbRjwcT8OYRvLKYVulK8KjGPfqAhyu0pGmq17m9F8DWyV/ZDhr+0Ny78uK4tTRhfPfO
 //Kzcty5liEDrg/SkW+ccK1kVo0PjJco2k71TLqo5NJPqM2pKgTyywJx7QOFP2ajOCoB
 a5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=91dz7KJADMxPUVCAuh+UOifd4EFprDikV0cfmChkEVM=;
 b=TyHmgQFP8wQA42EBznO3RfGgw8TyDubnrIys7gMKm4DpJ8+KCIOBhhLkfHwUP9tnir
 0+Es9Di3SglEBV2X8cnD6sqrMszYzzrMDeI8+Bs5N6NvB21lKFXqTtz+qyuurWs9PXdx
 SyuedI4SAc/P8pGmZkofSwTCG47HTypLONFsVJ93HeQFB19mCm+p40cIu40vj4xfDlOc
 1AegC7lIVCM+Qlmlcu+deWh2jWGKNaZx3qCHd3vDesh6+NRabxRKSmUyFwTyN1ZdbZrl
 xF57tEDCwHsy2MPZ4S0RUKpzDbymAfSZxsGCIVNsS5Asll8qBte2R76pat8a1CKwHy5+
 Tlow==
X-Gm-Message-State: APjAAAUQ15PJFzX0KEPoovLP5SfIiHMYZp1J40jcvbeeX4mTXJvxRTOI
 2l6DZfPVDjs82FOTZOvrORVUCw==
X-Google-Smtp-Source: APXvYqz+e5IVVPu9+X2DPUOCtop+1kzv9O37eXEQK0jT2Ky/EwfB+VpP/9Mw+8u322no4bbU+U84Rg==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr1393010wrp.185.1571986603974; 
 Thu, 24 Oct 2019 23:56:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h205sm1191520wmf.35.2019.10.24.23.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B75271FF8F;
 Fri, 25 Oct 2019 07:37:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 31/73] tcg: let plugins instrument virtual memory accesses
Date: Fri, 25 Oct 2019 07:36:31 +0100
Message-Id: <20191025063713.23374-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

To capture all memory accesses we need hook into all the various
helper functions that are involved in memory operations as well as the
injected inline helper calls. A later commit will allow us to resolve
the actual guest HW addresses by replaying the lookup.

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: drop haddr handling, just deal in vaddr]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/accel/tcg/atomic_common.inc.c b/accel/tcg/atomic_common.inc.c
index a86098fb2de..344525b0bb3 100644
--- a/accel/tcg/atomic_common.inc.c
+++ b/accel/tcg/atomic_common.inc.c
@@ -25,6 +25,8 @@ void atomic_trace_rmw_pre(CPUArchState *env, target_ulong addr, uint16_t info)
 static inline void
 atomic_trace_rmw_post(CPUArchState *env, target_ulong addr, uint16_t info)
 {
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, info);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, info | TRACE_MEM_ST);
 }
 
 static inline
@@ -36,6 +38,7 @@ void atomic_trace_ld_pre(CPUArchState *env, target_ulong addr, uint16_t info)
 static inline
 void atomic_trace_ld_post(CPUArchState *env, target_ulong addr, uint16_t info)
 {
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, info);
 }
 
 static inline
@@ -47,4 +50,5 @@ void atomic_trace_st_pre(CPUArchState *env, target_ulong addr, uint16_t info)
 static inline
 void atomic_trace_st_post(CPUArchState *env, target_ulong addr, uint16_t info)
 {
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, info);
 }
diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 84d3370bf01..837676231f6 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -18,6 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/plugin.h"
 #include "trace/mem.h"
 
 #if DATA_SIZE == 16
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 81c33d6475d..c01f59c7433 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -268,6 +268,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
             qemu_mutex_unlock_iothread();
         }
         assert_no_pages_locked();
+        qemu_plugin_disable_mem_helpers(cpu);
     }
 
     if (cpu_in_exclusive_context(cpu)) {
@@ -701,6 +702,8 @@ int cpu_exec(CPUState *cpu)
         if (qemu_mutex_iothread_locked()) {
             qemu_mutex_unlock_iothread();
         }
+        qemu_plugin_disable_mem_helpers(cpu);
+
         assert_no_pages_locked();
     }
 
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index be946ba1ce5..8c44abefa22 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -214,6 +214,7 @@ typedef struct CPUTLBCommon {
  * Since this is placed within CPUNegativeOffsetState, the smallest
  * negative offsets are at the end of the struct.
  */
+
 typedef struct CPUTLB {
     CPUTLBCommon c;
     CPUTLBDesc d[NB_MMU_MODES];
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 5750a26b9ec..6f0d3407979 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -28,6 +28,7 @@
 #include "trace-root.h"
 #endif
 
+#include "qemu/plugin.h"
 #include "trace/mem.h"
 
 #if DATA_SIZE == 8
@@ -86,11 +87,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
-
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false, mmu_idx));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false, mmu_idx);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -104,6 +103,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         uintptr_t hostaddr = addr + entry->addend;
         res = glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+#endif
     return res;
 }
 
@@ -124,11 +126,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
-
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false, mmu_idx));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, true, MO_TE, false, mmu_idx);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -142,6 +142,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         uintptr_t hostaddr = addr + entry->addend;
         res = glue(glue(lds, SUFFIX), _p)((uint8_t *)hostaddr);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+#endif
     return res;
 }
 
@@ -165,11 +168,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
-
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true, mmu_idx));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true, mmu_idx);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -183,6 +184,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         uintptr_t hostaddr = addr + entry->addend;
         glue(glue(st, SUFFIX), _p)((uint8_t *)hostaddr, v);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+#endif
 }
 
 static inline void
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 93ad532f943..dbdc7a845d6 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -64,18 +64,18 @@
 static inline RES_TYPE
 glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#ifdef CODE_ACCESS
     RES_TYPE ret;
+#ifdef CODE_ACCESS
     set_helper_retaddr(1);
     ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
     clear_helper_retaddr();
-    return ret;
 #else
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false, MMU_USER_IDX));
-    return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false,
+                                            MMU_USER_IDX);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+    ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
 #endif
+    return ret;
 }
 
 #ifndef CODE_ACCESS
@@ -96,18 +96,19 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 static inline int
 glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#ifdef CODE_ACCESS
     int ret;
+#ifdef CODE_ACCESS
     set_helper_retaddr(1);
     ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
     clear_helper_retaddr();
-    return ret;
 #else
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false, MMU_USER_IDX));
-    return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, true, MO_TE, false,
+                                            MMU_USER_IDX);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+    ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
 #endif
+    return ret;
 }
 
 #ifndef CODE_ACCESS
@@ -130,10 +131,11 @@ static inline void
 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
                                       RES_TYPE v)
 {
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true, MMU_USER_IDX));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true,
+                                            MMU_USER_IDX);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
 }
 
 static inline void
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1388bd344d3..c245126f981 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -30,6 +30,7 @@
 #include "tcg-mo.h"
 #include "trace-tcg.h"
 #include "trace/mem.h"
+#include "exec/plugin-gen.h"
 
 /* Reduce the number of ifdefs below.  This assumes that all uses of
    TCGV_HIGH and TCGV_LOW are properly protected by a conditional that
@@ -2684,6 +2685,7 @@ void tcg_gen_exit_tb(TranslationBlock *tb, unsigned idx)
         tcg_debug_assert(idx == TB_EXIT_REQUESTED);
     }
 
+    plugin_gen_disable_mem_helpers();
     tcg_gen_op1i(INDEX_op_exit_tb, val);
 }
 
@@ -2696,6 +2698,7 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0);
     tcg_ctx->goto_tb_issue_mask |= 1 << idx;
 #endif
+    plugin_gen_disable_mem_helpers();
     /* When not chaining, we simply fall through to the "fallback" exit.  */
     if (!qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
         tcg_gen_op1i(INDEX_op_goto_tb, idx);
@@ -2705,7 +2708,10 @@ void tcg_gen_goto_tb(unsigned idx)
 void tcg_gen_lookup_and_goto_ptr(void)
 {
     if (TCG_TARGET_HAS_goto_ptr && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
-        TCGv_ptr ptr = tcg_temp_new_ptr();
+        TCGv_ptr ptr;
+
+        plugin_gen_disable_mem_helpers();
+        ptr = tcg_temp_new_ptr();
         gen_helper_lookup_tb_ptr(ptr, cpu_env);
         tcg_gen_op1i(INDEX_op_goto_ptr, tcgv_ptr_arg(ptr));
         tcg_temp_free_ptr(ptr);
@@ -2788,14 +2794,24 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
+static inline void plugin_gen_mem_callbacks(TCGv vaddr, uint16_t info)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn == NULL) {
+        return;
+    }
+    plugin_gen_empty_mem_callback(vaddr, info);
+#endif
+}
+
 void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
 {
     MemOp orig_memop;
+    uint16_t info = trace_mem_get_info(memop, idx, 0);
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, idx, 0));
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2807,6 +2823,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
     }
 
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -2828,11 +2845,11 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
 void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
 {
     TCGv_i32 swap = NULL;
+    uint16_t info = trace_mem_get_info(memop, idx, 1);
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, idx, 1));
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i32();
@@ -2852,6 +2869,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
     }
 
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if (swap) {
         tcg_temp_free_i32(swap);
@@ -2861,6 +2879,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
 void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
 {
     MemOp orig_memop;
+    uint16_t info;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
@@ -2874,8 +2893,8 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 1, 0);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, idx, 0));
+    info = trace_mem_get_info(memop, idx, 0);
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2887,6 +2906,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
     }
 
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -2914,6 +2934,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
 void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
 {
     TCGv_i64 swap = NULL;
+    uint16_t info;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32(TCGV_LOW(val), addr, idx, memop);
@@ -2922,8 +2943,8 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 1, 1);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, idx, 1));
+    info = trace_mem_get_info(memop, idx, 1);
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i64();
@@ -2947,6 +2968,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
     }
 
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if (swap) {
         tcg_temp_free_i64(swap);
diff --git a/tcg/tcg.h b/tcg/tcg.h
index d234b4c9a53..a38659ea5b3 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -29,6 +29,7 @@
 #include "exec/memop.h"
 #include "exec/tb-context.h"
 #include "qemu/bitops.h"
+#include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "tcg-mo.h"
 #include "tcg-target.h"
-- 
2.20.1


