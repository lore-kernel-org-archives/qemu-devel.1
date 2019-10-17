Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4AEECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E06F2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vyaNr3yQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E06F2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6JR-000138-Sm
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mW-0002J6-9l
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mP-0001Fd-Ux
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mP-0001FJ-Mo
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id j11so2375673wrp.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IfES+584HSyI7NbR1r5tJmwd02109CyXfgI+SsGXGhc=;
 b=vyaNr3yQP4ooj5XdVY81Nf7pb/xuoVgXX942jDRppY3mka31Jijgvd5c5e3WqSd2dX
 ZeNo9r3nc+tIY2PPaJdjl34fcJ06nyaG4i9hw05ax+qftC6Zs+kTaBCJlMJVXGAWUIbt
 6Og06dvUcyDQvqKcVswJXEmRBY6gRLegm+XDQj6hqP9mhlGiliFazI3NgQ4ueRhWGiIY
 GAxJqrFxLheZ5YNFtpwB5kGxZQwGxkehvk2HYoEm/+cqc0Kl/c2S0chffkTZXJq/xkkS
 BVRH2RSv492KNaRsBuzALWpyXG4M6jZGHAA2dH5NU/vWgEhTWwJeBYASsBUGYfnrVfQ/
 iMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IfES+584HSyI7NbR1r5tJmwd02109CyXfgI+SsGXGhc=;
 b=Vw5UHzcW+3txEB7LR2oKDHIH6uZ966Q3plP+fZiy5o5+Bpfp+f0LDEgdTVGZRDq+7z
 1NEe35kM5G5BTe+WUsuuQcIaMd5WZOB2U1QCVWGyK/psopMQL98PQR93O/ExpI3dQB0/
 AMvxY34GMtzoPW8NuO31UKcihVEg/KZcYlCZsNPr1NmCfZS1gbM9uAzwApY/LhUC/3wf
 vsuhV6OapXQIfrIaqgeo18UlRUWpIeO85xC5YTTTOoZx3H3yw20nPrROheDw5Gwdqmyj
 noaaahRl0VrzXokoM4pesJTP5A/9eczT5ZxWkHFBQsTe1P2J6QTJltQpLb+leJ91UC0N
 Q4nQ==
X-Gm-Message-State: APjAAAXc8nUG7udxRiJ1thECozZV/GJESP7ewWjSthclSDiqe0fI1NGp
 6Q6hWoaXN/OCnUXKXfI3dQb49g==
X-Google-Smtp-Source: APXvYqwC51YoI8rKQhXhWk8tVJ3t3VO9M6UYuw6kQLPDW/wfHcoZ7/fBp/yK5HO1eQSwqJgm5pUpyw==
X-Received: by 2002:adf:f686:: with SMTP id v6mr3277174wrp.141.1571318724380; 
 Thu, 17 Oct 2019 06:25:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v6sm2860197wma.24.2019.10.17.06.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B9AC1FF9E;
 Thu, 17 Oct 2019 14:16:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 15/54] tcg: let plugins instrument virtual memory accesses
Date: Thu, 17 Oct 2019 14:15:36 +0100
Message-Id: <20191017131615.19660-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
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
---
v3
  - fixes for cpu_neg()
v4
  - rebase fixups, moved cpu_neg() fixes down the stack
  - drop haddr support - will be restored with later helper
  - reword commit
v6
  - rebase fixes
---
 accel/tcg/atomic_common.inc.c             |  4 +++
 accel/tcg/atomic_template.h               |  1 +
 accel/tcg/cpu-exec.c                      |  3 ++
 include/exec/cpu-defs.h                   |  1 +
 include/exec/cpu_ldst_template.h          | 28 +++++++++-------
 include/exec/cpu_ldst_useronly_template.h | 32 +++++++++---------
 tcg/tcg-op.c                              | 40 ++++++++++++++++++-----
 tcg/tcg.h                                 |  1 +
 8 files changed, 74 insertions(+), 36 deletions(-)

diff --git a/accel/tcg/atomic_common.inc.c b/accel/tcg/atomic_common.inc.c
index a86098fb2d..344525b0bb 100644
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
index 84d3370bf0..837676231f 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -18,6 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/plugin.h"
 #include "trace/mem.h"
 
 #if DATA_SIZE == 16
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 81c33d6475..c01f59c743 100644
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
index be946ba1ce..8c44abefa2 100644
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
index 5750a26b9e..6f0d340797 100644
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
index 93ad532f94..dbdc7a845d 100644
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
index 1388bd344d..c245126f98 100644
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
index d234b4c9a5..a38659ea5b 100644
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


