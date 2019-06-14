Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF8EC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488A02177E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXmQJYi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488A02177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54052 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqmr-0001Oy-JS
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34114)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0M-00076t-BR
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0H-000405-Qo
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:45 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0G-0003kU-R6
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id f17so575186wme.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Pim99RaJoGz7KvkA/uPJ/GgI2y9KeaVPRnEwtwD6pM=;
 b=AXmQJYi+maLcyOjnzjagS/FMhFG0lrIcC1s4cCtngwLFHUJdklkI6NwN6wQL75wY5R
 MZSwk3MmHvqqkMPFFBmYNHJZlof3Z87hisXGGj/IYf9emPU/BWSRbhkX4NcxPrD9hsRD
 WsFkFk6a3KhKMDFUUGmnwEgtXlKiEpycbYX3OtWsqPkN3UMgQvI24VVKCwjvYN7XCgw+
 vc7xH5JYVIFhCJflBV2bQQk+o6sc8opVl5aS06KlazJ+yCBvue+QmQFo3QidanCTJJto
 ZFNVD6f9eN4nQP6JtIwxIWCoK/+qRsWXx/UMrwLF2kKbYJsPxLnoyeMQkTHaslX3uQ2E
 Pp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Pim99RaJoGz7KvkA/uPJ/GgI2y9KeaVPRnEwtwD6pM=;
 b=O95zwFgDqAmP/pDGQGzfAPOQdwfI7tETaWLJCzLl2Q2WSOExZjItpVqlFlm/mEt03U
 BMlFjWZN4JP8G5p13NLo3LJcwydpVhGjy2bCGnpID7tHiiwVp9hfwsiWKgDyfK/5uaIn
 oa8PHK8/85HUg5dggDMFnCd8+Q6NYLyu6AtXLAiMJnPSrk6c4o4tRfQ4hC1XdD5YZY5o
 KtREQLTvrfBBp60Saa8EZq35RrC38SacCREBGe8gdRdYxgFwjhUTf4TnMsBy0tslORQ2
 KAB7E+ncQsxq2qHZK/F9Q674Zd5GlQDxs6SrmcOjhnqaJXfye3I+2c5VVDvqQSiv/uRJ
 YWrQ==
X-Gm-Message-State: APjAAAWdYTQamZC4KbWWw+cKl1sXbFvPkJL6iyMWat7rMQGPxCZ3F4Wr
 9iOFvx31ICv9iyU8vJvSNjzEgQ==
X-Google-Smtp-Source: APXvYqxjKA9EICeQ50IOfRJRzozVgJIRQBf9mSeMv60s8hfqY8QYeXKaFrfrzEZXdkYwMgcp7oSK1A==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr8912858wmf.138.1560533309075; 
 Fri, 14 Jun 2019 10:28:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q20sm6566985wra.36.2019.06.14.10.28.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 433601FFA6;
 Fri, 14 Jun 2019 18:12:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:29 +0100
Message-Id: <20190614171200.21078-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument memory
 accesses
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

XXX: store hostaddr from non-i386 TCG backends (do it in a helper?)
XXX: what hostaddr to return for I/O accesses?
XXX: what hostaddr to return for cross-page accesses?

Here the trickiest feature is passing the host address to
memory callbacks that request it. Perhaps it would be more
appropriate to pass a "physical" address to plugins, but since
in QEMU host addr ~= guest physical, I'm going with that for
simplicity.

To keep the implementation simple we piggy-back on the TLB fast path,
and thus can only provide the host address _after_ memory accesses
have occurred. For the slow path, it's a bit tedious because there
are many places to update, but it's fairly simple.

However, note that cross-page accesses are tricky, since the
access might be to non-contiguous host addresses. So I'm punting
on that and just passing NULL.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - fixes for cpu_neg()
---
 accel/tcg/atomic_template.h               |  5 +++
 accel/tcg/cpu-exec.c                      |  3 ++
 accel/tcg/cputlb.c                        | 37 +++++++++++++++++----
 accel/tcg/plugin-gen.c                    | 17 +++++-----
 include/exec/cpu-defs.h                   |  9 +++++
 include/exec/cpu_ldst.h                   |  9 +++++
 include/exec/cpu_ldst_template.h          | 40 ++++++++++++++---------
 include/exec/cpu_ldst_useronly_template.h | 34 ++++++++++++-------
 tcg/i386/tcg-target.inc.c                 |  8 +++++
 tcg/tcg-op.c                              | 40 ++++++++++++++++++-----
 tcg/tcg.h                                 |  1 +
 11 files changed, 153 insertions(+), 50 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 04c4c7b0d2..33ddfd498c 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -18,6 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/plugin.h"
 #include "trace/mem.h"
 
 #if DATA_SIZE == 16
@@ -73,6 +74,8 @@ void atomic_trace_rmw_pre(CPUArchState *env, target_ulong addr, uint8_t info)
 static inline void atomic_trace_rmw_post(CPUArchState *env, target_ulong addr,
                                          void *haddr, uint8_t info)
 {
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, haddr, info);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, haddr, info | TRACE_MEM_ST);
 }
 
 static inline
@@ -84,6 +87,7 @@ void atomic_trace_ld_pre(CPUArchState *env, target_ulong addr, uint8_t info)
 static inline void atomic_trace_ld_post(CPUArchState *env, target_ulong addr,
                                         void *haddr, uint8_t info)
 {
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, haddr, info);
 }
 
 static inline
@@ -95,6 +99,7 @@ void atomic_trace_st_pre(CPUArchState *env, target_ulong addr, uint8_t info)
 static inline void atomic_trace_st_post(CPUArchState *env, target_ulong addr,
                                         void *haddr, uint8_t info)
 {
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, haddr, info);
 }
 #endif /* ATOMIC_TEMPLATE_COMMON */
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6c85c3ee1e..c21353e54f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -272,6 +272,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
             qemu_mutex_unlock_iothread();
         }
         assert_no_pages_locked();
+        qemu_plugin_disable_mem_helpers(cpu);
     }
 
     if (in_exclusive_region) {
@@ -705,6 +706,8 @@ int cpu_exec(CPUState *cpu)
         if (qemu_mutex_iothread_locked()) {
             qemu_mutex_unlock_iothread();
         }
+        qemu_plugin_disable_mem_helpers(cpu);
+
         assert_no_pages_locked();
     }
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6a0dc438ff..b39c1f06f7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -879,9 +879,18 @@ static void tlb_fill(CPUState *cpu, target_ulong addr, int size,
     assert(ok);
 }
 
+static inline void set_hostaddr(CPUArchState *env, TCGMemOp mo, void *haddr)
+{
+#ifdef CONFIG_PLUGIN
+    if (mo & MO_HADDR) {
+        env_tlb(env)->c.hostaddr = haddr;
+    }
+#endif
+}
+
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          int mmu_idx, target_ulong addr, uintptr_t retaddr,
-                         MMUAccessType access_type, int size)
+                         TCGMemOp mo, MMUAccessType access_type, int size)
 {
     CPUState *cpu = env_cpu(env);
     hwaddr mr_offset;
@@ -891,6 +900,9 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
+    /* XXX Any sensible choice other than NULL? */
+    set_hostaddr(env, mo, NULL);
+
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -925,7 +937,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 
 static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                       int mmu_idx, uint64_t val, target_ulong addr,
-                      uintptr_t retaddr, int size)
+                      uintptr_t retaddr, TCGMemOp mo, int size)
 {
     CPUState *cpu = env_cpu(env);
     hwaddr mr_offset;
@@ -934,6 +946,8 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
+    set_hostaddr(env, mo, NULL);
+
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -1264,7 +1278,8 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         offsetof(CPUTLBEntry, addr_code) : offsetof(CPUTLBEntry, addr_read);
     const MMUAccessType access_type =
         code_read ? MMU_INST_FETCH : MMU_DATA_LOAD;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    TCGMemOp mo = get_memop(oi);
+    unsigned a_bits = get_alignment_bits(mo);
     void *haddr;
     uint64_t res;
 
@@ -1313,7 +1328,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         }
 
         res = io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
-                       mmu_idx, addr, retaddr, access_type, size);
+                       mmu_idx, addr, retaddr, mo, access_type, size);
         return handle_bswap(res, size, big_endian);
     }
 
@@ -1331,6 +1346,12 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         r2 = full_load(env, addr2, oi, retaddr);
         shift = (addr & (size - 1)) * 8;
 
+        /*
+         * XXX cross-page accesses would have to be split into separate accesses
+         * for the host address to make sense. For now, just return NULL.
+         */
+        set_hostaddr(env, mo, NULL);
+
         if (big_endian) {
             /* Big-endian combine.  */
             res = (r1 << shift) | (r2 >> ((size * 8) - shift));
@@ -1343,6 +1364,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 
  do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
+    set_hostaddr(env, mo, (void *)haddr);
     switch (size) {
     case 1:
         res = ldub_p(haddr);
@@ -1513,7 +1535,8 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr = tlb_addr_write(entry);
     const size_t tlb_off = offsetof(CPUTLBEntry, addr_write);
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    TCGMemOp mo = get_memop(oi);
+    unsigned a_bits = get_alignment_bits(mo);
     void *haddr;
 
     /* Handle CPU specific unaligned behaviour */
@@ -1562,7 +1585,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
         io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
                   handle_bswap(val, size, big_endian),
-                  addr, retaddr, size);
+                  addr, retaddr, mo, size);
         return;
     }
 
@@ -1607,11 +1630,13 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
             }
             helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
         }
+        set_hostaddr(env, mo, NULL);
         return;
     }
 
  do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
+    set_hostaddr(env, mo, (void *)haddr);
     switch (size) {
     case 1:
         stb_p(haddr, val);
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 7994819fe6..9d9ec29765 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -95,8 +95,7 @@ static void do_gen_mem_cb(TCGv vaddr, uint8_t info, bool is_haddr)
     TCGv_ptr udata = tcg_const_ptr(NULL);
     TCGv_ptr haddr;
 
-    tcg_gen_ld_i32(cpu_index, cpu_env,
-                   -ENV_OFFSET + offsetof(CPUState, cpu_index));
+    tcg_gen_ld_i32(cpu_index, cpu_env, -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
     tcg_gen_extu_tl_i64(vaddr64, vaddr);
 
     if (is_haddr) {
@@ -106,7 +105,9 @@ static void do_gen_mem_cb(TCGv vaddr, uint8_t info, bool is_haddr)
          */
 #ifdef CONFIG_SOFTMMU
         haddr = tcg_temp_new_ptr();
-        tcg_gen_ld_ptr(haddr, cpu_env, offsetof(CPUArchState, hostaddr));
+        tcg_gen_ld_ptr(haddr, cpu_env,
+                       offsetof(ArchCPU, neg.tlb.c.hostaddr) -
+                       offsetof(ArchCPU, env));
 #else
         haddr = tcg_const_ptr(NULL);
 #endif
@@ -128,8 +129,8 @@ static void gen_empty_udata_cb(void)
     TCGv_i32 cpu_index = tcg_temp_new_i32();
     TCGv_ptr udata = tcg_const_ptr(NULL); /* will be overwritten later */
 
-    tcg_gen_ld_i32(cpu_index, cpu_env,
-                   -ENV_OFFSET + offsetof(CPUState, cpu_index));
+    tcg_gen_ld_i32(cpu_index, cpu_env, -offsetof(ArchCPU, env) +
+                   offsetof(CPUState, cpu_index));
     gen_helper_plugin_vcpu_udata_cb(cpu_index, udata);
 
     tcg_temp_free_ptr(udata);
@@ -172,8 +173,7 @@ static void gen_empty_mem_helper(void)
     TCGv_ptr ptr;
 
     ptr = tcg_const_ptr(NULL);
-    tcg_gen_st_ptr(ptr, cpu_env, -ENV_OFFSET + offsetof(CPUState,
-                                                        plugin_mem_cbs));
+    tcg_gen_st_ptr(ptr, cpu_env, offsetof(CPUState, plugin_mem_cbs));
     tcg_temp_free_ptr(ptr);
 }
 
@@ -784,8 +784,7 @@ void plugin_gen_disable_mem_helpers(void)
         return;
     }
     ptr = tcg_const_ptr(NULL);
-    tcg_gen_st_ptr(ptr, cpu_env, -ENV_OFFSET + offsetof(CPUState,
-                                                        plugin_mem_cbs));
+    tcg_gen_st_ptr(ptr, cpu_env, offsetof(CPUState, plugin_mem_cbs));
     tcg_temp_free_ptr(ptr);
     tcg_ctx->plugin_insn->mem_helper = false;
 }
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 9bc713a70b..354788385b 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -207,6 +207,14 @@ typedef struct CPUTLBCommon {
     size_t full_flush_count;
     size_t part_flush_count;
     size_t elide_flush_count;
+#ifdef CONFIG_PLUGIN
+    /*
+     * TODO: remove and calculate on the fly
+     *
+     * Stores the host address of a guest access
+     */
+    void *hostaddr;
+#endif
 } CPUTLBCommon;
 
 /*
@@ -215,6 +223,7 @@ typedef struct CPUTLBCommon {
  * Since this is placed within CPUNegativeOffsetState, the smallest
  * negative offsets are at the end of the struct.
  */
+
 typedef struct CPUTLB {
     CPUTLBCommon c;
     CPUTLBDesc d[NB_MMU_MODES];
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index a08b11bd2c..ac07556d25 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -85,6 +85,15 @@ typedef target_ulong abi_ptr;
 #define TARGET_ABI_FMT_ptr TARGET_ABI_FMT_lx
 #endif
 
+static inline void *read_hostaddr(CPUArchState *env)
+{
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_PLUGIN)
+    return env_tlb(env)->c.hostaddr;
+#else
+    return NULL;
+#endif
+}
+
 #if defined(CONFIG_USER_ONLY)
 
 extern __thread uintptr_t helper_retaddr;
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index af7e0b49f2..38df113676 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -28,6 +28,7 @@
 #include "trace-root.h"
 #endif
 
+#include "qemu/plugin.h"
 #include "trace/mem.h"
 
 #if DATA_SIZE == 8
@@ -86,11 +87,10 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx;
     TCGMemOpIdx oi;
-
+    uintptr_t hostaddr;
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false));
+    uint8_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -101,10 +101,14 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         oi = make_memop_idx(SHIFT, mmu_idx);
         res = glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, addr,
                                                             oi, retaddr);
+        hostaddr = (uintptr_t)read_hostaddr(env);
     } else {
-        uintptr_t hostaddr = addr + entry->addend;
+        hostaddr = addr + entry->addend;
         res = glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, (void *)hostaddr, meminfo);
+#endif
     return res;
 }
 
@@ -125,11 +129,10 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx;
     TCGMemOpIdx oi;
-
+    uintptr_t hostaddr;
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false));
+    uint8_t meminfo = trace_mem_build_info(SHIFT, true, MO_TE, false);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -140,10 +143,14 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         oi = make_memop_idx(SHIFT, mmu_idx);
         res = (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
                                MMUSUFFIX)(env, addr, oi, retaddr);
+        hostaddr = (uintptr_t)read_hostaddr(env);
     } else {
-        uintptr_t hostaddr = addr + entry->addend;
+        hostaddr = addr + entry->addend;
         res = glue(glue(lds, SUFFIX), _p)((uint8_t *)hostaddr);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, (void *)hostaddr, meminfo);
+#endif
     return res;
 }
 
@@ -167,11 +174,10 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx;
     TCGMemOpIdx oi;
-
+    uintptr_t hostaddr;
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true));
+    uint8_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -182,10 +188,14 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         oi = make_memop_idx(SHIFT, mmu_idx);
         glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
                                                      retaddr);
+        hostaddr = (uintptr_t)read_hostaddr(env);
     } else {
-        uintptr_t hostaddr = addr + entry->addend;
+        hostaddr = addr + entry->addend;
         glue(glue(st, SUFFIX), _p)((uint8_t *)hostaddr, v);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, (void *)hostaddr, meminfo);
+#endif
 }
 
 static inline void
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 42a95237f1..cc625a3da8 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -64,12 +64,18 @@
 static inline RES_TYPE
 glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
+    RES_TYPE ret;
+#if !defined(CODE_ACCESS)
+    uint8_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+#endif
+
+    ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
+
 #if !defined(CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false));
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, NULL, meminfo);
 #endif
-    return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
+    return ret;
 }
 
 static inline RES_TYPE
@@ -88,12 +94,18 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 static inline int
 glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
+    int ret;
+#if !defined(CODE_ACCESS)
+    uint8_t meminfo = trace_mem_build_info(SHIFT, true, MO_TE, false);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+#endif
+
+    ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
+
 #if !defined(CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false));
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, NULL, meminfo);
 #endif
-    return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
+    return ret;
 }
 
 static inline int
@@ -114,10 +126,10 @@ static inline void
 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
                                       RES_TYPE v)
 {
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true));
+    uint8_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, NULL, meminfo);
 }
 
 static inline void
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 6ddeebf4bc..8519fd0eb0 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1775,6 +1775,14 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     /* add addend(r0), r1 */
     tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r1, r0,
                          offsetof(CPUTLBEntry, addend));
+
+#ifdef CONFIG_PLUGIN
+    if (opc & MO_HADDR) {
+        tcg_out_st(s, TCG_TYPE_PTR, r1, TCG_AREG0,
+                   offsetof(ArchCPU, neg.tlb.c.hostaddr) -
+                   offsetof(ArchCPU, env));
+    }
+#endif
 }
 
 /*
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 587d092238..e8094e27d0 100644
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
 
+static inline void plugin_gen_mem_callbacks(TCGv vaddr, uint8_t info)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn == NULL) {
+        return;
+    }
+    plugin_gen_empty_mem_callback(vaddr, info);
+#endif
+}
+
 void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     TCGMemOp orig_memop;
+    uint8_t info = trace_mem_get_info(memop, 0);
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 0));
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2807,6 +2823,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -2828,11 +2845,11 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     TCGv_i32 swap = NULL;
+    uint8_t info = trace_mem_get_info(memop, 1);
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 1));
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i32();
@@ -2852,6 +2869,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if (swap) {
         tcg_temp_free_i32(swap);
@@ -2861,6 +2879,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     TCGMemOp orig_memop;
+    uint8_t info;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
@@ -2874,8 +2893,8 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 1, 0);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 0));
+    info = trace_mem_get_info(memop, 0);
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2887,6 +2906,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -2914,6 +2934,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     TCGv_i64 swap = NULL;
+    uint8_t info;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32(TCGV_LOW(val), addr, idx, memop);
@@ -2922,8 +2943,8 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 1, 1);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 1));
+    info = trace_mem_get_info(memop, 1);
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i64();
@@ -2947,6 +2968,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if (swap) {
         tcg_temp_free_i64(swap);
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 966e89104d..0e86e18ccb 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -28,6 +28,7 @@
 #include "cpu.h"
 #include "exec/tb-context.h"
 #include "qemu/bitops.h"
+#include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "tcg-mo.h"
 #include "tcg-target.h"
-- 
2.20.1


