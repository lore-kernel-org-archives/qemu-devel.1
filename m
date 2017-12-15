Received: from eggs.gnu.org ([2001:4830:134:3::10]:60336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePtSh-0001Xt-1N
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePtSf-00030b-IY
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:50 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:46710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ePtSf-00030F-Bw
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:49 -0500
Received: by mail-it0-x241.google.com with SMTP id t1so21005784ite.5
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 09:07:49 -0800 (PST)
Received: from cloudburst.twiddle.net (141-126-166-226.dhcp.chtrptr.net.
	[141.126.166.226]) by smtp.gmail.com with ESMTPSA id
	k23sm4012974iti.22.2017.12.15.09.07.46 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 15 Dec 2017 09:07:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Dec 2017 11:07:32 -0600
Message-Id: <20171215170732.31125-8-richard.henderson@linaro.org>
In-Reply-To: <20171215170732.31125-1-richard.henderson@linaro.org>
References: <20171215170732.31125-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 7/7] tcg: Allow 6 arguments to TCG helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We already handle this in the backends, and the lifetime datum
for the TCGOp is already large enough.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-gen.h   | 11 +++++++++++
 include/exec/helper-head.h  |  2 ++
 include/exec/helper-proto.h |  5 +++++
 include/exec/helper-tcg.h   |  7 +++++++
 tcg/tcg.h                   |  2 +-
 tcg/tci.c                   | 12 ++++++++----
 tcg/tci/tcg-target.inc.c    |  6 ++++--
 7 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 15204ab961..22381a1708 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -56,6 +56,16 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
   tcg_gen_callN(HELPER(name), dh_retvar(ret), 5, args);                 \
 }
 
+#define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6)    \
+static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
+    dh_arg_decl(t1, 1),  dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),        \
+    dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
+{                                                                       \
+  TCGTemp *args[6] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),     \
+                     dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6) };     \
+  tcg_gen_callN(HELPER(name), dh_retvar(ret), 6, args);                 \
+}
+
 #include "helper.h"
 #include "trace/generated-helpers.h"
 #include "trace/generated-helpers-wrappers.h"
@@ -67,6 +77,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 #undef DEF_HELPER_FLAGS_3
 #undef DEF_HELPER_FLAGS_4
 #undef DEF_HELPER_FLAGS_5
+#undef DEF_HELPER_FLAGS_6
 #undef GEN_HELPER
 
 #endif /* HELPER_GEN_H */
diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index 639eefdbc0..e1fd08f2ba 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -125,6 +125,8 @@
     DEF_HELPER_FLAGS_4(name, 0, ret, t1, t2, t3, t4)
 #define DEF_HELPER_5(name, ret, t1, t2, t3, t4, t5) \
     DEF_HELPER_FLAGS_5(name, 0, ret, t1, t2, t3, t4, t5)
+#define DEF_HELPER_6(name, ret, t1, t2, t3, t4, t5, t6) \
+    DEF_HELPER_FLAGS_6(name, 0, ret, t1, t2, t3, t4, t5, t6)
 
 /* MAX_OPC_PARAM_IARGS must be set to n if last entry is DEF_HELPER_FLAGS_n. */
 
diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
index 954bef85ce..74943edb13 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -26,6 +26,10 @@ dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
 dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
                             dh_ctype(t4), dh_ctype(t5));
 
+#define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6) \
+dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
+                            dh_ctype(t4), dh_ctype(t5), dh_ctype(t6));
+
 #include "helper.h"
 #include "trace/generated-helpers.h"
 #include "tcg-runtime.h"
@@ -36,5 +40,6 @@ dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
 #undef DEF_HELPER_FLAGS_3
 #undef DEF_HELPER_FLAGS_4
 #undef DEF_HELPER_FLAGS_5
+#undef DEF_HELPER_FLAGS_6
 
 #endif /* HELPER_PROTO_H */
diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
index b0c5bafa99..b3bdb0c399 100644
--- a/include/exec/helper-tcg.h
+++ b/include/exec/helper-tcg.h
@@ -39,6 +39,12 @@
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) \
     | dh_sizemask(t5, 5) },
 
+#define DEF_HELPER_FLAGS_6(NAME, FLAGS, ret, t1, t2, t3, t4, t5, t6) \
+  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
+    .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
+    | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) \
+    | dh_sizemask(t5, 5) | dh_sizemask(t6, 6) },
+
 #include "helper.h"
 #include "trace/generated-helpers.h"
 #include "tcg-runtime.h"
@@ -50,5 +56,6 @@
 #undef DEF_HELPER_FLAGS_3
 #undef DEF_HELPER_FLAGS_4
 #undef DEF_HELPER_FLAGS_5
+#undef DEF_HELPER_FLAGS_6
 
 #endif /* HELPER_TCG_H */
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 8c45f7edbc..2ce497cebf 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -41,7 +41,7 @@
 #else
 #define MAX_OPC_PARAM_PER_ARG 1
 #endif
-#define MAX_OPC_PARAM_IARGS 5
+#define MAX_OPC_PARAM_IARGS 6
 #define MAX_OPC_PARAM_OARGS 1
 #define MAX_OPC_PARAM_ARGS (MAX_OPC_PARAM_IARGS + MAX_OPC_PARAM_OARGS)
 
diff --git a/tcg/tci.c b/tcg/tci.c
index 63f2cd54ab..33edca1903 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -40,11 +40,12 @@
         tcg_abort(); \
     } while (0)
 
-#if MAX_OPC_PARAM_IARGS != 5
+#if MAX_OPC_PARAM_IARGS != 6
 # error Fix needed, number of supported input arguments changed!
 #endif
 #if TCG_TARGET_REG_BITS == 32
 typedef uint64_t (*helper_function)(tcg_target_ulong, tcg_target_ulong,
+                                    tcg_target_ulong, tcg_target_ulong,
                                     tcg_target_ulong, tcg_target_ulong,
                                     tcg_target_ulong, tcg_target_ulong,
                                     tcg_target_ulong, tcg_target_ulong,
@@ -52,7 +53,7 @@ typedef uint64_t (*helper_function)(tcg_target_ulong, tcg_target_ulong,
 #else
 typedef uint64_t (*helper_function)(tcg_target_ulong, tcg_target_ulong,
                                     tcg_target_ulong, tcg_target_ulong,
-                                    tcg_target_ulong);
+                                    tcg_target_ulong, tcg_target_ulong);
 #endif
 
 static tcg_target_ulong tci_read_reg(const tcg_target_ulong *regs, TCGReg index)
@@ -520,7 +521,9 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
                                           tci_read_reg(regs, TCG_REG_R7),
                                           tci_read_reg(regs, TCG_REG_R8),
                                           tci_read_reg(regs, TCG_REG_R9),
-                                          tci_read_reg(regs, TCG_REG_R10));
+                                          tci_read_reg(regs, TCG_REG_R10),
+                                          tci_read_reg(regs, TCG_REG_R11),
+                                          tci_read_reg(regs, TCG_REG_R12));
             tci_write_reg(regs, TCG_REG_R0, tmp64);
             tci_write_reg(regs, TCG_REG_R1, tmp64 >> 32);
 #else
@@ -528,7 +531,8 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
                                           tci_read_reg(regs, TCG_REG_R1),
                                           tci_read_reg(regs, TCG_REG_R2),
                                           tci_read_reg(regs, TCG_REG_R3),
-                                          tci_read_reg(regs, TCG_REG_R5));
+                                          tci_read_reg(regs, TCG_REG_R5),
+                                          tci_read_reg(regs, TCG_REG_R6));
             tci_write_reg(regs, TCG_REG_R0, tmp64);
 #endif
             break;
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 913c3802a3..cc949bea85 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -292,7 +292,7 @@ static const int tcg_target_reg_alloc_order[] = {
 #endif
 };
 
-#if MAX_OPC_PARAM_IARGS != 5
+#if MAX_OPC_PARAM_IARGS != 6
 # error Fix needed, number of supported input arguments changed!
 #endif
 
@@ -305,14 +305,16 @@ static const int tcg_target_call_iarg_regs[] = {
     TCG_REG_R4,
 #endif
     TCG_REG_R5,
+    TCG_REG_R6,
 #if TCG_TARGET_REG_BITS == 32
     /* 32 bit hosts need 2 * MAX_OPC_PARAM_IARGS registers. */
-    TCG_REG_R6,
     TCG_REG_R7,
 #if TCG_TARGET_NB_REGS >= 16
     TCG_REG_R8,
     TCG_REG_R9,
     TCG_REG_R10,
+    TCG_REG_R11,
+    TCG_REG_R12,
 #else
 # error Too few input registers available
 #endif
-- 
2.14.3
