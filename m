Received: from eggs.gnu.org ([2001:4830:134:3::10]:40311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKj-0006hn-At
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKJ-00008N-7F
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:45 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKH-0008Qz-9l
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:27 -0400
Message-Id: <20181025172057.20414-19-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 18/48] tcg: add memory callbacks for plugins (WIP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

XXX: store hostaddr from non-i386 TCG backends
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
---
 accel/tcg/atomic_template.h               |  8 ++++-
 accel/tcg/softmmu_template.h              | 39 ++++++++++++++++++++
 include/exec/cpu-defs.h                   |  2 ++
 include/exec/cpu_ldst_template.h          | 43 +++++++++++++++--------
 include/exec/cpu_ldst_useronly_template.h | 42 +++++++++++++++-------
 tcg/tcg-op.h                              |  5 +++
 tcg/tcg.h                                 |  4 +++
 tcg/i386/tcg-target.inc.c                 |  5 +++
 tcg/tcg-op.c                              | 37 ++++++++++++++-----
 tcg/tcg.c                                 |  3 ++
 10 files changed, 152 insertions(+), 36 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index b13318c1ce..3de34dc462 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -18,6 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/plugin.h"
 #include "trace/mem.h"
 
 #if DATA_SIZE == 16
@@ -66,17 +67,22 @@
     trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info | TRACE_MEM_ST); \
 } while (0)
 
-# define ATOMIC_TRACE_RMW_POST                                          \
+# define ATOMIC_TRACE_RMW_POST do {                                            \
+  qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info);                \
+  qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info | TRACE_MEM_ST); \
+} while (0)
 
 # define ATOMIC_TRACE_LD_PRE                                    \
     trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info)
 
 # define ATOMIC_TRACE_LD_POST                                           \
+    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info)
 
 # define ATOMIC_TRACE_ST_PRE                                    \
     trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info)
 
 # define ATOMIC_TRACE_ST_POST                                           \
+    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info)
 
 #endif /* ATOMIC_TRACE_RMW_PRE */
 
diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index b0adea045e..f6d2f60b81 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -103,6 +103,11 @@ static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArchState *env,
                                               MMUAccessType access_type)
 {
     CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+
+    /* XXX Any sensible choice other than NULL? */
+    if (tcg_ctx->plugin_mem_cb) {
+        env->hostaddr = NULL;
+    }
     return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, recheck,
                     access_type, DATA_SIZE);
 }
@@ -162,12 +167,23 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
         res2 = helper_le_ld_name(env, addr2, oi, retaddr);
         shift = (addr & (DATA_SIZE - 1)) * 8;
 
+        /*
+         * XXX cross-page accesses would have to be split into separate accesses
+         * for the host address to make sense. For now, just return NULL.
+         */
+        if (tcg_ctx->plugin_mem_cb) {
+            env->hostaddr = NULL;
+        }
+
         /* Little-endian combine.  */
         res = (res1 >> shift) | (res2 << ((DATA_SIZE * 8) - shift));
         return res;
     }
 
     haddr = addr + entry->addend;
+    if (tcg_ctx->plugin_mem_cb) {
+        env->hostaddr = (void *)haddr;
+    }
 #if DATA_SIZE == 1
     res = glue(glue(ld, LSUFFIX), _p)((uint8_t *)haddr);
 #else
@@ -231,12 +247,19 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
         res2 = helper_be_ld_name(env, addr2, oi, retaddr);
         shift = (addr & (DATA_SIZE - 1)) * 8;
 
+        if (tcg_ctx->plugin_mem_cb) {
+            env->hostaddr = NULL;
+        }
+
         /* Big-endian combine.  */
         res = (res1 << shift) | (res2 >> ((DATA_SIZE * 8) - shift));
         return res;
     }
 
     haddr = addr + entry->addend;
+    if (tcg_ctx->plugin_mem_cb) {
+        env->hostaddr = (void *)haddr;
+    }
     res = glue(glue(ld, LSUFFIX), _be_p)((uint8_t *)haddr);
     return res;
 }
@@ -270,6 +293,10 @@ static inline void glue(io_write, SUFFIX)(CPUArchState *env,
                                           bool recheck)
 {
     CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+
+    if (tcg_ctx->plugin_mem_cb) {
+        env->hostaddr = NULL;
+    }
     return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
                      recheck, DATA_SIZE);
 }
@@ -340,10 +367,16 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
             glue(helper_ret_stb, MMUSUFFIX)(env, addr + i, val8,
                                             oi, retaddr);
         }
+        if (tcg_ctx->plugin_mem_cb) {
+            env->hostaddr = NULL;
+        }
         return;
     }
 
     haddr = addr + entry->addend;
+    if (tcg_ctx->plugin_mem_cb) {
+        env->hostaddr = (void *)haddr;
+    }
 #if DATA_SIZE == 1
     glue(glue(st, SUFFIX), _p)((uint8_t *)haddr, val);
 #else
@@ -418,10 +451,16 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
             glue(helper_ret_stb, MMUSUFFIX)(env, addr + i, val8,
                                             oi, retaddr);
         }
+        if (tcg_ctx->plugin_mem_cb) {
+            env->hostaddr = NULL;
+        }
         return;
     }
 
     haddr = addr + entry->addend;
+    if (tcg_ctx->plugin_mem_cb) {
+        env->hostaddr = (void *)haddr;
+    }
     glue(glue(st, SUFFIX), _be_p)((uint8_t *)haddr, val);
 }
 #endif /* DATA_SIZE > 1 */
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 40cd5d4774..c92c24a4a3 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -186,6 +186,8 @@ typedef struct CPUTLBDesc {
     CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
     CPU_IOTLB                                                           \
     CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];                 \
+    /* stores the host address of a guest access, if needed for plugins */ \
+    void *hostaddr;                                                     \
     size_t tlb_flush_count;                                             \
     target_ulong tlb_flush_addr;                                        \
     target_ulong tlb_flush_mask;                                        \
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 0f061d47ef..e25319de4b 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -28,6 +28,7 @@
 #include "trace-root.h"
 #endif
 
+#include "qemu/plugin.h"
 #include "trace/mem.h"
 
 #if DATA_SIZE == 8
@@ -86,11 +87,11 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx;
     TCGMemOpIdx oi;
-
+    uintptr_t hostaddr;
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false));
+    uint8_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false);
+
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -101,10 +102,14 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         oi = make_memop_idx(SHIFT, mmu_idx);
         res = glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, addr,
                                                             oi, retaddr);
+        hostaddr = (uintptr_t)env->hostaddr;
     } else {
-        uintptr_t hostaddr = addr + entry->addend;
+        hostaddr = addr + entry->addend;
         res = glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, (void *)hostaddr, meminfo);
+#endif
     return res;
 }
 
@@ -125,11 +130,11 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx;
     TCGMemOpIdx oi;
-
+    uintptr_t hostaddr;
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false));
+    uint8_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false);
+
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -140,10 +145,14 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         oi = make_memop_idx(SHIFT, mmu_idx);
         res = (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
                                MMUSUFFIX)(env, addr, oi, retaddr);
+        hostaddr = (uintptr_t)env->hostaddr;
     } else {
-        uintptr_t hostaddr = addr + entry->addend;
+        hostaddr = addr + entry->addend;
         res = glue(glue(lds, SUFFIX), _p)((uint8_t *)hostaddr);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, (void *)hostaddr, meminfo);
+#endif
     return res;
 }
 
@@ -167,11 +176,11 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx;
     TCGMemOpIdx oi;
-
+    uintptr_t hostaddr;
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true));
+    uint8_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true);
+
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -182,10 +191,14 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         oi = make_memop_idx(SHIFT, mmu_idx);
         glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
                                                      retaddr);
+        hostaddr = (uintptr_t)env->hostaddr;
     } else {
-        uintptr_t hostaddr = addr + entry->addend;
+        hostaddr = addr + entry->addend;
         glue(glue(st, SUFFIX), _p)((uint8_t *)hostaddr, v);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, (void *)hostaddr, meminfo);
+#endif
 }
 
 static inline void
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 0fd6019af0..e752e9c00e 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -64,12 +64,19 @@
 static inline RES_TYPE
 glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
+    RES_TYPE ret;
+#if !defined(CODE_ACCESS)
+    uint8_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false);
+
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
+#endif
+
+    ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
+
 #if !defined(CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false));
+    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, NULL, meminfo);
 #endif
-    return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
+    return ret;
 }
 
 static inline RES_TYPE
@@ -88,12 +95,19 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 static inline int
 glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
+    int ret;
 #if !defined(CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false));
+    uint8_t meminfo = trace_mem_build_info(SHIFT, true, MO_TE, false);
+
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
 #endif
-    return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
+
+    ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
+
+#if !defined(CODE_ACCESS)
+    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, NULL, meminfo);
+#endif
+    return ret;
 }
 
 static inline int
@@ -109,17 +123,21 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 }
 #endif
 
-#ifndef CODE_ACCESS
+#if !defined(CODE_ACCESS)
 static inline void
 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
                                       RES_TYPE v)
 {
 #if !defined(CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true));
+    uint8_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true);
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
 #endif
+
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
+
+#if !defined(CODE_ACCESS)
+    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), ptr, NULL, meminfo);
+#endif
 }
 
 static inline void
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 7513c1eb7c..cded8fc05b 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1208,6 +1208,11 @@ static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
     glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
 }
 
+static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    glue(tcg_gen_st_,PTR)((NAT)r, a, o);
+}
+
 static inline void tcg_gen_discard_ptr(TCGv_ptr a)
 {
     glue(tcg_gen_discard_,PTR)((NAT)a);
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 2c378415d2..d5afe25c97 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -29,6 +29,7 @@
 #include "cpu.h"
 #include "exec/tb-context.h"
 #include "qemu/bitops.h"
+#include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "tcg-mo.h"
 #include "tcg-target.h"
@@ -719,6 +720,9 @@ struct TCGContext {
 
     TCGLabel *exitreq_label;
 
+    struct qemu_plugin_dyn_cb_arr *plugin_mem_cb;
+    struct qemu_plugin_insn *plugin_insn;
+
     TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
 
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5cbb07deab..7d9e6765c4 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1685,6 +1685,11 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     /* add addend(r0), r1 */
     tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r1, r0,
                          offsetof(CPUTLBEntry, addend));
+
+    if (s->plugin_mem_cb) {
+        tcg_out_st(s, TCG_TYPE_PTR, r1, TCG_AREG0,
+                   offsetof(CPUArchState, hostaddr));
+    }
 }
 
 /*
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7a8015c5a9..add63547e3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -31,6 +31,7 @@
 #include "tcg-mo.h"
 #include "trace-tcg.h"
 #include "trace/mem.h"
+#include "exec/plugin-gen.h"
 
 /* Reduce the number of ifdefs below.  This assumes that all uses of
    TCGV_HIGH and TCGV_LOW are properly protected by a conditional that
@@ -2699,26 +2700,42 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
+static inline void plugin_gen_mem_callbacks(TCGv vaddr, uint8_t info)
+{
+    struct qemu_plugin_dyn_cb_arr *arr = tcg_ctx->plugin_mem_cb;
+
+    if (arr == NULL) {
+        return;
+    }
+    qemu_plugin_gen_vcpu_mem_callbacks(arr, vaddr, info);
+}
+
 void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    uint8_t info = trace_mem_get_info(memop, 0);
+
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 0));
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 }
 
 void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    uint8_t info = trace_mem_get_info(memop, 1);
+
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 1));
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 }
 
 void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    uint8_t info;
+
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
@@ -2731,13 +2748,16 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     memop = tcg_canonicalize_memop(memop, 1, 0);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 0));
+    info = trace_mem_get_info(memop, 0);
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 }
 
 void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    uint8_t info;
+
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32(TCGV_LOW(val), addr, idx, memop);
@@ -2745,9 +2765,10 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     memop = tcg_canonicalize_memop(memop, 1, 1);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 1));
+    info = trace_mem_get_info(memop, 1);
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 }
 
 static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a6824145b0..b10bda587a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1839,6 +1839,9 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
      * that @func can only be in one TCGHelperInfo.
      */
     info = qht_lookup_custom(&helper_table, func, hash, tcg_helper_lookup_cmp);
+    if (unlikely(tcg_ctx->plugin_insn)) {
+        tcg_ctx->plugin_insn->calls_helpers = true;
+    }
     do_tcg_gen_callN(info, ret, nargs, args);
 }
 
-- 
2.17.1
