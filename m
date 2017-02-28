Received: from eggs.gnu.org ([2001:4830:134:3::10]:43820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPm-0003J9-04
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPj-0003hy-GO
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:17 -0500
Received: from clearmind.me ([178.32.49.9]:39637)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cilPj-0003go-6z
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:15 -0500
From: Alessandro Di Federico <ale+qemu@clearmind.me>
Date: Tue, 28 Feb 2017 18:19:20 +0100
Message-Id: <20170228171921.21602-7-ale+qemu@clearmind.me>
In-Reply-To: <20170228171921.21602-1-ale+qemu@clearmind.me>
References: <20170228171921.21602-1-ale+qemu@clearmind.me>
Sender: ale@clearmind.me
Subject: [Qemu-devel] [PATCH 6/7] Factor out tcg/tcg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This patch factors out all the necessary data structures contained in
tcg.h into include/tcg-common.h so that they can be made available to
users of the library version of the TCG, libtcg.

The data structures have been modified in a way that allows them to be
easily prefixed in different ways depending on the situation. For
internal use, the prefix will typically be TCG_ for constants and TCG
for data structures, while it will be LIBTCG_/LibTCG for external use.

In addition to this, certain data types (namely TCGReg, TCGRegSet and
tcg_temp) have been forced to be the same over all the targets, so that
the data structures are architecture-independent, a vital requirement to
provide a uniform interface to libtcg users.

Finally tcg/tcg-opc.h has been moved to include/.
---
 include/qemu-common.h      |   3 +
 include/tcg-common.h       | 233 +++++++++++++++++++++++++++++++++++++++++++++
 {tcg => include}/tcg-opc.h |   0
 tcg/aarch64/tcg-target.h   |   4 +-
 tcg/arm/tcg-target.h       |   4 +-
 tcg/i386/tcg-target.h      |   4 +-
 tcg/ia64/tcg-target.h      |   4 +-
 tcg/mips/tcg-target.h      |   4 +-
 tcg/ppc/tcg-target.h       |   4 +-
 tcg/s390/tcg-target.h      |   4 +-
 tcg/sparc/tcg-target.h     |   4 +-
 tcg/tcg.c                  |   7 --
 tcg/tcg.h                  | 212 ++---------------------------------------
 tcg/tci/tcg-target.h       |   4 +-
 14 files changed, 264 insertions(+), 227 deletions(-)
 create mode 100644 include/tcg-common.h
 rename {tcg => include}/tcg-opc.h (100%)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 1430390eb6..c81828ef55 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -12,6 +12,7 @@
 #ifndef QEMU_COMMON_H
 #define QEMU_COMMON_H
 
+#include <stdint.h>
 #include "qemu/fprintf-fn.h"
 
 #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
@@ -79,6 +80,8 @@ int qemu_openpty_raw(int *aslave, char *pty_name);
 void tcg_exec_init(unsigned long tb_size);
 bool tcg_enabled(void);
 
+typedef uint32_t TCGReg;
+
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
 
diff --git a/include/tcg-common.h b/include/tcg-common.h
new file mode 100644
index 0000000000..856c4974a0
--- /dev/null
+++ b/include/tcg-common.h
@@ -0,0 +1,233 @@
+/* This is file has no include guards because it's OK to include it multiple
+ * times */
+
+/* Includers should define the following macros:
+ *
+ * PREFIX: prefix for data types and structures.
+ * PREFIX2: prefix for enum data types.
+ * PREFIX3: prefix for other enum data types which, internally, do not need a
+ *          prefix, since they already have one.
+ */
+#if !defined(PREFIX) || !defined(PREFIX2) || !defined(PREFIX3)
+# error You need to define PREFIX, PREFIX2 and PREFIX3 to include this file
+#endif
+
+#include <stdint.h>
+
+/* Includers outside the QEMU environment might need this. */
+#ifndef TCG_TARGET_REG_BITS
+# if __SIZEOF_POINTER__ == 8
+#  define TCG_TARGET_REG_BITS 64
+#  define TCG_TARGET_REG_BITS 64
+# else
+#  define TCG_TARGET_REG_BITS 32
+# endif
+#endif
+
+typedef uint64_t PREFIX(RegSet);
+typedef uint64_t tcg_temp;
+typedef uint64_t PREFIX(Arg);
+
+typedef struct PREFIX(ArgConstraint) {
+    uint16_t ct;
+    uint8_t alias_index;
+    union {
+        PREFIX(RegSet) regs;
+    } u;
+} PREFIX(ArgConstraint);
+
+typedef enum PREFIX(Opcode) {
+#define DEF(name, oargs, iargs, cargs, flags) PREFIX3(INDEX_op_ ## name),
+#include "tcg-opc.h"
+#undef DEF
+    PREFIX3(NB_OPS),
+} PREFIX(Opcode);
+
+typedef enum PREFIX(TempVal) {
+    PREFIX3(TEMP_VAL_DEAD),
+    PREFIX3(TEMP_VAL_REG),
+    PREFIX3(TEMP_VAL_MEM),
+    PREFIX3(TEMP_VAL_CONST),
+} PREFIX(TempVal);
+
+typedef enum PREFIX(Type) {
+    PREFIX2(TYPE_I32),
+    PREFIX2(TYPE_I64),
+    PREFIX2(TYPE_COUNT), /* number of different types */
+
+#ifndef LIBTCG_INTERFACE
+    /* An alias for the size of the host register.  */
+#if TCG_TARGET_REG_BITS == 32
+    PREFIX2(TYPE_REG) = PREFIX2(TYPE_I32),
+#else
+    PREFIX2(TYPE_REG) = PREFIX2(TYPE_I64),
+#endif
+
+    /* An alias for the size of the native pointer.  */
+#if UINTPTR_MAX == UINT32_MAX
+    PREFIX2(TYPE_PTR) = PREFIX2(TYPE_I32),
+#else
+    PREFIX2(TYPE_PTR) = PREFIX2(TYPE_I64),
+#endif
+
+    /* An alias for the size of the target "long", aka register.  */
+#if TARGET_LONG_BITS == 64
+    PREFIX2(TYPE_TL) = PREFIX2(TYPE_I64),
+#else
+    PREFIX2(TYPE_TL) = PREFIX2(TYPE_I32),
+#endif
+#endif
+} PREFIX(Type);
+
+typedef struct PREFIX(Temp) {
+    PREFIX(Reg) reg:8;
+    PREFIX(TempVal) val_type:8;
+    PREFIX(Type) base_type:8;
+    PREFIX(Type) type:8;
+    unsigned int fixed_reg:1;
+    unsigned int indirect_reg:1;
+    unsigned int indirect_base:1;
+    unsigned int mem_coherent:1;
+    unsigned int mem_allocated:1;
+    unsigned int temp_local:1; /* If true, the temp is saved across
+                                  basic blocks. Otherwise, it is not
+                                  preserved across basic blocks. */
+    unsigned int temp_allocated:1; /* never used for code gen */
+
+    tcg_temp val;
+    struct PREFIX(Temp) *mem_base;
+    intptr_t mem_offset;
+    const char *name;
+} PREFIX(Temp);
+
+typedef struct PREFIX(OpDef) {
+    const char *name;
+    uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;
+    uint8_t flags;
+    PREFIX(ArgConstraint) *args_ct;
+    int *sorted_args;
+#if defined(CONFIG_DEBUG_TCG)
+    int used;
+#endif
+} PREFIX(OpDef);
+
+/* Conditions.  Note that these are laid out for easy manipulation by
+   the functions below:
+     bit 0 is used for inverting;
+     bit 1 is signed,
+     bit 2 is unsigned,
+     bit 3 is used with bit 0 for swapping signed/unsigned.  */
+typedef enum {
+    /* non-signed */
+    PREFIX2(COND_NEVER)  = 0 | 0 | 0 | 0,
+    PREFIX2(COND_ALWAYS) = 0 | 0 | 0 | 1,
+    PREFIX2(COND_EQ)     = 8 | 0 | 0 | 0,
+    PREFIX2(COND_NE)     = 8 | 0 | 0 | 1,
+    /* signed */
+    PREFIX2(COND_LT)     = 0 | 0 | 2 | 0,
+    PREFIX2(COND_GE)     = 0 | 0 | 2 | 1,
+    PREFIX2(COND_LE)     = 8 | 0 | 2 | 0,
+    PREFIX2(COND_GT)     = 8 | 0 | 2 | 1,
+    /* unsigned */
+    PREFIX2(COND_LTU)    = 0 | 4 | 0 | 0,
+    PREFIX2(COND_GEU)    = 0 | 4 | 0 | 1,
+    PREFIX2(COND_LEU)    = 8 | 4 | 0 | 0,
+    PREFIX2(COND_GTU)    = 8 | 4 | 0 | 1,
+} PREFIX(Cond);
+
+/* Constants for qemu_ld and qemu_st for the Memory Operation field.  */
+typedef enum PREFIX(MemOp) {
+    PREFIX3(MO_8)     = 0,
+    PREFIX3(MO_16)    = 1,
+    PREFIX3(MO_32)    = 2,
+    PREFIX3(MO_64)    = 3,
+    PREFIX3(MO_SIZE)  = 3,   /* Mask for the above.  */
+
+    PREFIX3(MO_SIGN)  = 4,   /* Sign-extended, otherwise zero-extended.  */
+
+    PREFIX3(MO_BSWAP) = 8,   /* Host reverse endian.  */
+#ifndef LIBTCG_INTERFACE
+#ifdef HOST_WORDS_BIGENDIAN
+    PREFIX3(MO_LE)    = PREFIX3(MO_BSWAP),
+    PREFIX3(MO_BE)    = 0,
+#else
+    PREFIX3(MO_LE)    = 0,
+    PREFIX3(MO_BE)    = PREFIX3(MO_BSWAP),
+#endif
+#ifdef TARGET_WORDS_BIGENDIAN
+    PREFIX3(MO_TE)    = PREFIX3(MO_BE),
+#else
+    PREFIX3(MO_TE)    = PREFIX3(MO_LE),
+#endif
+
+    /* MO_UNALN accesses are never checked for alignment.
+     * MO_ALIGN accesses will result in a call to the CPU's
+     * do_unaligned_access hook if the guest address is not aligned.
+     * The default depends on whether the target CPU defines ALIGNED_ONLY.
+     *
+     * Some architectures (e.g. ARMv8) need the address which is aligned
+     * to a size more than the size of the memory access.
+     * Some architectures (e.g. SPARCv9) need an address which is aligned,
+     * but less strictly than the natural alignment.
+     *
+     * MO_ALIGN supposes the alignment size is the size of a memory access.
+     *
+     * There are three options:
+     * - unaligned access permitted (MO_UNALN).
+     * - an alignment to the size of an access (MO_ALIGN);
+     * - an alignment to a specified size, which may be more or less than
+     *   the access size (MO_ALIGN_x where 'x' is a size in bytes);
+     */
+    PREFIX3(MO_ASHIFT) = 4,
+    PREFIX3(MO_AMASK) = 7 << PREFIX3(MO_ASHIFT),
+#ifdef ALIGNED_ONLY
+    PREFIX3(MO_ALIGN) = 0,
+    PREFIX3(MO_UNALN) = PREFIX3(MO_AMASK),
+#else
+    PREFIX3(MO_ALIGN) = PREFIX3(MO_AMASK),
+    PREFIX3(MO_UNALN) = 0,
+#endif
+    PREFIX3(MO_ALIGN_2)  = 1 << PREFIX3(MO_ASHIFT),
+    PREFIX3(MO_ALIGN_4)  = 2 << PREFIX3(MO_ASHIFT),
+    PREFIX3(MO_ALIGN_8)  = 3 << PREFIX3(MO_ASHIFT),
+    PREFIX3(MO_ALIGN_16) = 4 << PREFIX3(MO_ASHIFT),
+    PREFIX3(MO_ALIGN_32) = 5 << PREFIX3(MO_ASHIFT),
+    PREFIX3(MO_ALIGN_64) = 6 << PREFIX3(MO_ASHIFT),
+
+    /* Combinations of the above, for ease of use.  */
+    PREFIX3(MO_UB)    = PREFIX3(MO_8),
+    PREFIX3(MO_UW)    = PREFIX3(MO_16),
+    PREFIX3(MO_UL)    = PREFIX3(MO_32),
+    PREFIX3(MO_SB)    = PREFIX3(MO_SIGN) | PREFIX3(MO_8),
+    PREFIX3(MO_SW)    = PREFIX3(MO_SIGN) | PREFIX3(MO_16),
+    PREFIX3(MO_SL)    = PREFIX3(MO_SIGN) | PREFIX3(MO_32),
+    PREFIX3(MO_Q)     = PREFIX3(MO_64),
+
+    PREFIX3(MO_LEUW)  = PREFIX3(MO_LE) | PREFIX3(MO_UW),
+    PREFIX3(MO_LEUL)  = PREFIX3(MO_LE) | PREFIX3(MO_UL),
+    PREFIX3(MO_LESW)  = PREFIX3(MO_LE) | PREFIX3(MO_SW),
+    PREFIX3(MO_LESL)  = PREFIX3(MO_LE) | PREFIX3(MO_SL),
+    PREFIX3(MO_LEQ)   = PREFIX3(MO_LE) | PREFIX3(MO_Q),
+
+    PREFIX3(MO_BEUW)  = PREFIX3(MO_BE) | PREFIX3(MO_UW),
+    PREFIX3(MO_BEUL)  = PREFIX3(MO_BE) | PREFIX3(MO_UL),
+    PREFIX3(MO_BESW)  = PREFIX3(MO_BE) | PREFIX3(MO_SW),
+    PREFIX3(MO_BESL)  = PREFIX3(MO_BE) | PREFIX3(MO_SL),
+    PREFIX3(MO_BEQ)   = PREFIX3(MO_BE) | PREFIX3(MO_Q),
+
+    PREFIX3(MO_TEUW)  = PREFIX3(MO_TE) | PREFIX3(MO_UW),
+    PREFIX3(MO_TEUL)  = PREFIX3(MO_TE) | PREFIX3(MO_UL),
+    PREFIX3(MO_TESW)  = PREFIX3(MO_TE) | PREFIX3(MO_SW),
+    PREFIX3(MO_TESL)  = PREFIX3(MO_TE) | PREFIX3(MO_SL),
+    PREFIX3(MO_TEQ)   = PREFIX3(MO_TE) | PREFIX3(MO_Q),
+
+    PREFIX3(MO_SSIZE) = PREFIX3(MO_SIZE) | PREFIX3(MO_SIGN),
+#endif
+} PREFIX(MemOp);
+
+typedef struct PREFIX(HelperInfo) {
+    void *func;
+    const char *name;
+    unsigned flags;
+    unsigned sizemask;
+} PREFIX(HelperInfo);
diff --git a/tcg/tcg-opc.h b/include/tcg-opc.h
similarity index 100%
rename from tcg/tcg-opc.h
rename to include/tcg-opc.h
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 1a5ea23844..3a23a4c025 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -17,7 +17,7 @@
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
 #undef TCG_TARGET_STACK_GROWSUP
 
-typedef enum {
+enum {
     TCG_REG_X0, TCG_REG_X1, TCG_REG_X2, TCG_REG_X3,
     TCG_REG_X4, TCG_REG_X5, TCG_REG_X6, TCG_REG_X7,
     TCG_REG_X8, TCG_REG_X9, TCG_REG_X10, TCG_REG_X11,
@@ -35,7 +35,7 @@ typedef enum {
     TCG_REG_FP = TCG_REG_X29,
     TCG_REG_LR = TCG_REG_X30,
     TCG_AREG0  = TCG_REG_X19,
-} TCGReg;
+};
 
 #define TCG_TARGET_NB_REGS 32
 
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 09a19c6f35..7e9e5dc372 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -61,7 +61,7 @@ extern int arm_arch;
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 
-typedef enum {
+enum {
     TCG_REG_R0 = 0,
     TCG_REG_R1,
     TCG_REG_R2,
@@ -78,7 +78,7 @@ typedef enum {
     TCG_REG_R13,
     TCG_REG_R14,
     TCG_REG_PC,
-} TCGReg;
+};
 
 #define TCG_TARGET_NB_REGS 16
 
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 21d96ec35c..89d0771e90 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -36,7 +36,7 @@
 # define TCG_TARGET_NB_REGS    8
 #endif
 
-typedef enum {
+enum {
     TCG_REG_EAX = 0,
     TCG_REG_ECX,
     TCG_REG_EDX,
@@ -64,7 +64,7 @@ typedef enum {
     TCG_REG_RBP = TCG_REG_EBP,
     TCG_REG_RSI = TCG_REG_ESI,
     TCG_REG_RDI = TCG_REG_EDI,
-} TCGReg;
+};
 
 /* used for function call generation */
 #define TCG_REG_CALL_STACK TCG_REG_ESP 
diff --git a/tcg/ia64/tcg-target.h b/tcg/ia64/tcg-target.h
index 42aea03a8b..230f1de1c8 100644
--- a/tcg/ia64/tcg-target.h
+++ b/tcg/ia64/tcg-target.h
@@ -36,7 +36,7 @@ typedef struct {
 
 /* We only map the first 64 registers */
 #define TCG_TARGET_NB_REGS 64
-typedef enum {
+enum {
     TCG_REG_R0 = 0,
     TCG_REG_R1,
     TCG_REG_R2,
@@ -103,7 +103,7 @@ typedef enum {
     TCG_REG_R63,
 
     TCG_AREG0 = TCG_REG_R32,
-} TCGReg;
+};
 
 #define TCG_CT_CONST_ZERO 0x100
 #define TCG_CT_CONST_S22 0x200
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index f46d64a3a7..acd1aea71b 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -39,7 +39,7 @@
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 #define TCG_TARGET_NB_REGS 32
 
-typedef enum {
+enum {
     TCG_REG_ZERO = 0,
     TCG_REG_AT,
     TCG_REG_V0,
@@ -75,7 +75,7 @@ typedef enum {
 
     TCG_REG_CALL_STACK = TCG_REG_SP,
     TCG_AREG0 = TCG_REG_S0,
-} TCGReg;
+};
 
 /* used for function call generation */
 #define TCG_TARGET_STACK_ALIGN        16
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index abd8b3d6cd..e08ac7dc91 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -35,7 +35,7 @@
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 
-typedef enum {
+enum {
     TCG_REG_R0,  TCG_REG_R1,  TCG_REG_R2,  TCG_REG_R3,
     TCG_REG_R4,  TCG_REG_R5,  TCG_REG_R6,  TCG_REG_R7,
     TCG_REG_R8,  TCG_REG_R9,  TCG_REG_R10, TCG_REG_R11,
@@ -47,7 +47,7 @@ typedef enum {
 
     TCG_REG_CALL_STACK = TCG_REG_R1,
     TCG_AREG0 = TCG_REG_R27
-} TCGReg;
+};
 
 extern bool have_isa_2_06;
 extern bool have_isa_3_00;
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index cbdd2a6275..2345946c54 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -28,7 +28,7 @@
 #define TCG_TARGET_INSN_UNIT_SIZE 2
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 19
 
-typedef enum TCGReg {
+enum TCGReg {
     TCG_REG_R0 = 0,
     TCG_REG_R1,
     TCG_REG_R2,
@@ -45,7 +45,7 @@ typedef enum TCGReg {
     TCG_REG_R13,
     TCG_REG_R14,
     TCG_REG_R15
-} TCGReg;
+};
 
 #define TCG_TARGET_NB_REGS 16
 
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index b8b74f96ff..6652c776ec 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -31,7 +31,7 @@
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
 #define TCG_TARGET_NB_REGS 32
 
-typedef enum {
+enum {
     TCG_REG_G0 = 0,
     TCG_REG_G1,
     TCG_REG_G2,
@@ -64,7 +64,7 @@ typedef enum {
     TCG_REG_I5,
     TCG_REG_I6,
     TCG_REG_I7,
-} TCGReg;
+};
 
 #define TCG_CT_CONST_S11  0x100
 #define TCG_CT_CONST_S13  0x200
diff --git a/tcg/tcg.c b/tcg/tcg.c
index cb898f1636..652131e5e9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -307,13 +307,6 @@ void tcg_pool_reset(TCGContext *s)
     s->pool_current = NULL;
 }
 
-typedef struct TCGHelperInfo {
-    void *func;
-    const char *name;
-    unsigned flags;
-    unsigned sizemask;
-} TCGHelperInfo;
-
 #include "exec/helper-proto.h"
 
 static const TCGHelperInfo all_helpers[] = {
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 631c6f69b1..09e452ca46 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -79,13 +79,16 @@ typedef uint64_t tcg_target_ulong;
 #error unsupported
 #endif
 
-#if TCG_TARGET_NB_REGS <= 32
-typedef uint32_t TCGRegSet;
-#elif TCG_TARGET_NB_REGS <= 64
-typedef uint64_t TCGRegSet;
-#else
-#error unsupported
-#endif
+#define PREFIX(x) TCG ## x
+#define PREFIX2(x) TCG_ ## x
+/* No prefix if not libtcg */
+#define PREFIX3(x) x
+
+#include "tcg-common.h"
+
+#undef PREFIX
+#undef PREFIX2
+#undef PREFIX3
 
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
@@ -169,13 +172,6 @@ typedef uint64_t TCGRegSet;
 # define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)
 #endif
 
-typedef enum TCGOpcode {
-#define DEF(name, oargs, iargs, cargs, flags) INDEX_op_ ## name,
-#include "tcg-opc.h"
-#undef DEF
-    NB_OPS,
-} TCGOpcode;
-
 #define tcg_regset_clear(d) (d) = 0
 #define tcg_regset_set(d, s) (d) = (s)
 #define tcg_regset_set32(d, reg, val32) (d) |= (val32) << (reg)
@@ -243,121 +239,6 @@ typedef struct TCGPool {
    this value, they are statically allocated in the TB stack frame */
 #define TCG_STATIC_CALL_ARGS_SIZE 128
 
-typedef enum TCGType {
-    TCG_TYPE_I32,
-    TCG_TYPE_I64,
-    TCG_TYPE_COUNT, /* number of different types */
-
-    /* An alias for the size of the host register.  */
-#if TCG_TARGET_REG_BITS == 32
-    TCG_TYPE_REG = TCG_TYPE_I32,
-#else
-    TCG_TYPE_REG = TCG_TYPE_I64,
-#endif
-
-    /* An alias for the size of the native pointer.  */
-#if UINTPTR_MAX == UINT32_MAX
-    TCG_TYPE_PTR = TCG_TYPE_I32,
-#else
-    TCG_TYPE_PTR = TCG_TYPE_I64,
-#endif
-
-    /* An alias for the size of the target "long", aka register.  */
-#if TARGET_LONG_BITS == 64
-    TCG_TYPE_TL = TCG_TYPE_I64,
-#else
-    TCG_TYPE_TL = TCG_TYPE_I32,
-#endif
-} TCGType;
-
-/* Constants for qemu_ld and qemu_st for the Memory Operation field.  */
-typedef enum TCGMemOp {
-    MO_8     = 0,
-    MO_16    = 1,
-    MO_32    = 2,
-    MO_64    = 3,
-    MO_SIZE  = 3,   /* Mask for the above.  */
-
-    MO_SIGN  = 4,   /* Sign-extended, otherwise zero-extended.  */
-
-    MO_BSWAP = 8,   /* Host reverse endian.  */
-#ifdef HOST_WORDS_BIGENDIAN
-    MO_LE    = MO_BSWAP,
-    MO_BE    = 0,
-#else
-    MO_LE    = 0,
-    MO_BE    = MO_BSWAP,
-#endif
-#ifdef TARGET_WORDS_BIGENDIAN
-    MO_TE    = MO_BE,
-#else
-    MO_TE    = MO_LE,
-#endif
-
-    /* MO_UNALN accesses are never checked for alignment.
-     * MO_ALIGN accesses will result in a call to the CPU's
-     * do_unaligned_access hook if the guest address is not aligned.
-     * The default depends on whether the target CPU defines ALIGNED_ONLY.
-     *
-     * Some architectures (e.g. ARMv8) need the address which is aligned
-     * to a size more than the size of the memory access.
-     * Some architectures (e.g. SPARCv9) need an address which is aligned,
-     * but less strictly than the natural alignment.
-     *
-     * MO_ALIGN supposes the alignment size is the size of a memory access.
-     *
-     * There are three options:
-     * - unaligned access permitted (MO_UNALN).
-     * - an alignment to the size of an access (MO_ALIGN);
-     * - an alignment to a specified size, which may be more or less than
-     *   the access size (MO_ALIGN_x where 'x' is a size in bytes);
-     */
-    MO_ASHIFT = 4,
-    MO_AMASK = 7 << MO_ASHIFT,
-#ifdef ALIGNED_ONLY
-    MO_ALIGN = 0,
-    MO_UNALN = MO_AMASK,
-#else
-    MO_ALIGN = MO_AMASK,
-    MO_UNALN = 0,
-#endif
-    MO_ALIGN_2  = 1 << MO_ASHIFT,
-    MO_ALIGN_4  = 2 << MO_ASHIFT,
-    MO_ALIGN_8  = 3 << MO_ASHIFT,
-    MO_ALIGN_16 = 4 << MO_ASHIFT,
-    MO_ALIGN_32 = 5 << MO_ASHIFT,
-    MO_ALIGN_64 = 6 << MO_ASHIFT,
-
-    /* Combinations of the above, for ease of use.  */
-    MO_UB    = MO_8,
-    MO_UW    = MO_16,
-    MO_UL    = MO_32,
-    MO_SB    = MO_SIGN | MO_8,
-    MO_SW    = MO_SIGN | MO_16,
-    MO_SL    = MO_SIGN | MO_32,
-    MO_Q     = MO_64,
-
-    MO_LEUW  = MO_LE | MO_UW,
-    MO_LEUL  = MO_LE | MO_UL,
-    MO_LESW  = MO_LE | MO_SW,
-    MO_LESL  = MO_LE | MO_SL,
-    MO_LEQ   = MO_LE | MO_Q,
-
-    MO_BEUW  = MO_BE | MO_UW,
-    MO_BEUL  = MO_BE | MO_UL,
-    MO_BESW  = MO_BE | MO_SW,
-    MO_BESL  = MO_BE | MO_SL,
-    MO_BEQ   = MO_BE | MO_Q,
-
-    MO_TEUW  = MO_TE | MO_UW,
-    MO_TEUL  = MO_TE | MO_UL,
-    MO_TESW  = MO_TE | MO_SW,
-    MO_TESL  = MO_TE | MO_SL,
-    MO_TEQ   = MO_TE | MO_Q,
-
-    MO_SSIZE = MO_SIZE | MO_SIGN,
-} TCGMemOp;
-
 /**
  * get_alignment_bits
  * @memop: TCGMemOp value
@@ -385,8 +266,6 @@ static inline unsigned get_alignment_bits(TCGMemOp memop)
     return a;
 }
 
-typedef tcg_target_ulong TCGArg;
-
 /* Define type and accessor macros for TCG variables.
 
    TCG variables are the inputs and outputs of TCG ops, as described
@@ -515,30 +394,6 @@ typedef enum {
     TCG_BAR_SC    = 0x30,  /* No ops cross barrier; OR of the above */
 } TCGBar;
 
-/* Conditions.  Note that these are laid out for easy manipulation by
-   the functions below:
-     bit 0 is used for inverting;
-     bit 1 is signed,
-     bit 2 is unsigned,
-     bit 3 is used with bit 0 for swapping signed/unsigned.  */
-typedef enum {
-    /* non-signed */
-    TCG_COND_NEVER  = 0 | 0 | 0 | 0,
-    TCG_COND_ALWAYS = 0 | 0 | 0 | 1,
-    TCG_COND_EQ     = 8 | 0 | 0 | 0,
-    TCG_COND_NE     = 8 | 0 | 0 | 1,
-    /* signed */
-    TCG_COND_LT     = 0 | 0 | 2 | 0,
-    TCG_COND_GE     = 0 | 0 | 2 | 1,
-    TCG_COND_LE     = 8 | 0 | 2 | 0,
-    TCG_COND_GT     = 8 | 0 | 2 | 1,
-    /* unsigned */
-    TCG_COND_LTU    = 0 | 4 | 0 | 0,
-    TCG_COND_GEU    = 0 | 4 | 0 | 1,
-    TCG_COND_LEU    = 8 | 4 | 0 | 0,
-    TCG_COND_GTU    = 8 | 4 | 0 | 1,
-} TCGCond;
-
 /* Invert the sense of the comparison.  */
 static inline TCGCond tcg_invert_cond(TCGCond c)
 {
@@ -578,34 +433,6 @@ static inline TCGCond tcg_high_cond(TCGCond c)
     }
 }
 
-typedef enum TCGTempVal {
-    TEMP_VAL_DEAD,
-    TEMP_VAL_REG,
-    TEMP_VAL_MEM,
-    TEMP_VAL_CONST,
-} TCGTempVal;
-
-typedef struct TCGTemp {
-    TCGReg reg:8;
-    TCGTempVal val_type:8;
-    TCGType base_type:8;
-    TCGType type:8;
-    unsigned int fixed_reg:1;
-    unsigned int indirect_reg:1;
-    unsigned int indirect_base:1;
-    unsigned int mem_coherent:1;
-    unsigned int mem_allocated:1;
-    unsigned int temp_local:1; /* If true, the temp is saved across
-                                  basic blocks. Otherwise, it is not
-                                  preserved across basic blocks. */
-    unsigned int temp_allocated:1; /* never used for code gen */
-
-    tcg_target_long val;
-    struct TCGTemp *mem_base;
-    intptr_t mem_offset;
-    const char *name;
-} TCGTemp;
-
 typedef struct TCGContext TCGContext;
 
 typedef struct TCGTempSet {
@@ -858,14 +685,6 @@ void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf);
 #define TCG_CT_REG    0x01
 #define TCG_CT_CONST  0x02 /* any constant of register size */
 
-typedef struct TCGArgConstraint {
-    uint16_t ct;
-    uint8_t alias_index;
-    union {
-        TCGRegSet regs;
-    } u;
-} TCGArgConstraint;
-
 #define TCG_MAX_OP_ARGS 16
 
 /* Bits for TCGOpDef->flags, 8 bits available.  */
@@ -884,17 +703,6 @@ enum {
     TCG_OPF_NOT_PRESENT  = 0x10,
 };
 
-typedef struct TCGOpDef {
-    const char *name;
-    uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;
-    uint8_t flags;
-    TCGArgConstraint *args_ct;
-    int *sorted_args;
-#if defined(CONFIG_DEBUG_TCG)
-    int used;
-#endif
-} TCGOpDef;
-
 extern TCGOpDef tcg_op_defs[];
 extern const size_t tcg_op_defs_max;
 
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 838bf3a858..321b5465c4 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -135,7 +135,7 @@
 /* #define TCG_TARGET_NB_REGS 32 */
 
 /* List of registers which are used by TCG. */
-typedef enum {
+enum {
     TCG_REG_R0 = 0,
     TCG_REG_R1,
     TCG_REG_R2,
@@ -174,7 +174,7 @@ typedef enum {
 #endif
     /* Special value UINT8_MAX is used by TCI to encode constant values. */
     TCG_CONST = UINT8_MAX
-} TCGReg;
+};
 
 #define TCG_AREG0                       (TCG_TARGET_NB_REGS - 2)
 
-- 
2.11.1
