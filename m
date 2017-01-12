Received: from eggs.gnu.org ([2001:4830:134:3::10]:45964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjt-0002oo-AQ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjq-0006Mc-5J
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:41 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:22 +1100
Message-Id: <20170112020327.24882-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/67] target-ppc: Consolidate instruction
 decode helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Move instruction decode helpers to target-ppc/internal.h so that some
of these can be used from outside of translate.c. This movement also
helps to get rid of some duplicate helpers from target-ppc/fpu_helper.c.

Suggested-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c |  11 +---
 target/ppc/internal.h   | 151 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/translate.c  | 151 ------------------------------------------------
 3 files changed, 152 insertions(+), 161 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 8a389e1..d3741b4 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "internal.h"
 
 #define float64_snan_to_qnan(x) ((x) | 0x0008000000000000ULL)
 #define float32_snan_to_qnan(x) ((x) | 0x00400000)
@@ -1776,16 +1777,6 @@ uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_t op1, uint64_t op2)
     return helper_efdtsteq(env, op1, op2);
 }
 
-#define DECODE_SPLIT(opcode, shift1, nb1, shift2, nb2) \
-    (((((opcode) >> (shift1)) & ((1 << (nb1)) - 1)) << nb2) |    \
-     (((opcode) >> (shift2)) & ((1 << (nb2)) - 1)))
-
-#define xT(opcode) DECODE_SPLIT(opcode, 0, 1, 21, 5)
-#define xA(opcode) DECODE_SPLIT(opcode, 2, 1, 16, 5)
-#define xB(opcode) DECODE_SPLIT(opcode, 1, 1, 11, 5)
-#define xC(opcode) DECODE_SPLIT(opcode, 3, 1,  6, 5)
-#define BF(opcode) (((opcode) >> (31-8)) & 7)
-
 typedef union _ppc_vsr_t {
     uint64_t u64[2];
     uint32_t u32[4];
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 1ff4896..9a4a74a 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -47,4 +47,155 @@ FUNC_MASK(MASK, target_ulong, 32, UINT32_MAX);
 FUNC_MASK(mask_u32, uint32_t, 32, UINT32_MAX);
 FUNC_MASK(mask_u64, uint64_t, 64, UINT64_MAX);
 
+/*****************************************************************************/
+/***                           Instruction decoding                        ***/
+#define EXTRACT_HELPER(name, shift, nb)                                       \
+static inline uint32_t name(uint32_t opcode)                                  \
+{                                                                             \
+    return (opcode >> (shift)) & ((1 << (nb)) - 1);                           \
+}
+
+#define EXTRACT_SHELPER(name, shift, nb)                                      \
+static inline int32_t name(uint32_t opcode)                                   \
+{                                                                             \
+    return (int16_t)((opcode >> (shift)) & ((1 << (nb)) - 1));                \
+}
+
+#define EXTRACT_HELPER_SPLIT(name, shift1, nb1, shift2, nb2)                  \
+static inline uint32_t name(uint32_t opcode)                                  \
+{                                                                             \
+    return (((opcode >> (shift1)) & ((1 << (nb1)) - 1)) << nb2) |             \
+            ((opcode >> (shift2)) & ((1 << (nb2)) - 1));                      \
+}
+
+#define EXTRACT_HELPER_DXFORM(name,                                           \
+                              d0_bits, shift_op_d0, shift_d0,                 \
+                              d1_bits, shift_op_d1, shift_d1,                 \
+                              d2_bits, shift_op_d2, shift_d2)                 \
+static inline int16_t name(uint32_t opcode)                                   \
+{                                                                             \
+    return                                                                    \
+        (((opcode >> (shift_op_d0)) & ((1 << (d0_bits)) - 1)) << (shift_d0)) | \
+        (((opcode >> (shift_op_d1)) & ((1 << (d1_bits)) - 1)) << (shift_d1)) | \
+        (((opcode >> (shift_op_d2)) & ((1 << (d2_bits)) - 1)) << (shift_d2));  \
+}
+
+
+/* Opcode part 1 */
+EXTRACT_HELPER(opc1, 26, 6);
+/* Opcode part 2 */
+EXTRACT_HELPER(opc2, 1, 5);
+/* Opcode part 3 */
+EXTRACT_HELPER(opc3, 6, 5);
+/* Opcode part 4 */
+EXTRACT_HELPER(opc4, 16, 5);
+/* Update Cr0 flags */
+EXTRACT_HELPER(Rc, 0, 1);
+/* Update Cr6 flags (Altivec) */
+EXTRACT_HELPER(Rc21, 10, 1);
+/* Destination */
+EXTRACT_HELPER(rD, 21, 5);
+/* Source */
+EXTRACT_HELPER(rS, 21, 5);
+/* First operand */
+EXTRACT_HELPER(rA, 16, 5);
+/* Second operand */
+EXTRACT_HELPER(rB, 11, 5);
+/* Third operand */
+EXTRACT_HELPER(rC, 6, 5);
+/***                               Get CRn                                 ***/
+EXTRACT_HELPER(crfD, 23, 3);
+EXTRACT_HELPER(BF, 23, 3);
+EXTRACT_HELPER(crfS, 18, 3);
+EXTRACT_HELPER(crbD, 21, 5);
+EXTRACT_HELPER(crbA, 16, 5);
+EXTRACT_HELPER(crbB, 11, 5);
+/* SPR / TBL */
+EXTRACT_HELPER(_SPR, 11, 10);
+static inline uint32_t SPR(uint32_t opcode)
+{
+    uint32_t sprn = _SPR(opcode);
+
+    return ((sprn >> 5) & 0x1F) | ((sprn & 0x1F) << 5);
+}
+/***                              Get constants                            ***/
+/* 16 bits signed immediate value */
+EXTRACT_SHELPER(SIMM, 0, 16);
+/* 16 bits unsigned immediate value */
+EXTRACT_HELPER(UIMM, 0, 16);
+/* 5 bits signed immediate value */
+EXTRACT_HELPER(SIMM5, 16, 5);
+/* 5 bits signed immediate value */
+EXTRACT_HELPER(UIMM5, 16, 5);
+/* 4 bits unsigned immediate value */
+EXTRACT_HELPER(UIMM4, 16, 4);
+/* Bit count */
+EXTRACT_HELPER(NB, 11, 5);
+/* Shift count */
+EXTRACT_HELPER(SH, 11, 5);
+/* Vector shift count */
+EXTRACT_HELPER(VSH, 6, 4);
+/* Mask start */
+EXTRACT_HELPER(MB, 6, 5);
+/* Mask end */
+EXTRACT_HELPER(ME, 1, 5);
+/* Trap operand */
+EXTRACT_HELPER(TO, 21, 5);
+
+EXTRACT_HELPER(CRM, 12, 8);
+
+#ifndef CONFIG_USER_ONLY
+EXTRACT_HELPER(SR, 16, 4);
+#endif
+
+/* mtfsf/mtfsfi */
+EXTRACT_HELPER(FPBF, 23, 3);
+EXTRACT_HELPER(FPIMM, 12, 4);
+EXTRACT_HELPER(FPL, 25, 1);
+EXTRACT_HELPER(FPFLM, 17, 8);
+EXTRACT_HELPER(FPW, 16, 1);
+
+/* addpcis */
+EXTRACT_HELPER_DXFORM(DX, 10, 6, 6, 5, 16, 1, 1, 0, 0)
+#if defined(TARGET_PPC64)
+/* darn */
+EXTRACT_HELPER(L, 16, 2);
+#endif
+
+/***                            Jump target decoding                       ***/
+/* Immediate address */
+static inline target_ulong LI(uint32_t opcode)
+{
+    return (opcode >> 0) & 0x03FFFFFC;
+}
+
+static inline uint32_t BD(uint32_t opcode)
+{
+    return (opcode >> 0) & 0xFFFC;
+}
+
+EXTRACT_HELPER(BO, 21, 5);
+EXTRACT_HELPER(BI, 16, 5);
+/* Absolute/relative address */
+EXTRACT_HELPER(AA, 1, 1);
+/* Link */
+EXTRACT_HELPER(LK, 0, 1);
+
+/* DFP Z22-form */
+EXTRACT_HELPER(DCM, 10, 6)
+
+/* DFP Z23-form */
+EXTRACT_HELPER(RMC, 9, 2)
+
+EXTRACT_HELPER_SPLIT(xT, 0, 1, 21, 5);
+EXTRACT_HELPER_SPLIT(xS, 0, 1, 21, 5);
+EXTRACT_HELPER_SPLIT(xA, 2, 1, 16, 5);
+EXTRACT_HELPER_SPLIT(xB, 1, 1, 11, 5);
+EXTRACT_HELPER_SPLIT(xC, 3, 1,  6, 5);
+EXTRACT_HELPER(DM, 8, 2);
+EXTRACT_HELPER(UIM, 16, 2);
+EXTRACT_HELPER(SHW, 8, 2);
+EXTRACT_HELPER(SP, 19, 2);
+EXTRACT_HELPER(IMM8, 11, 8);
+
 #endif /* PPC_INTERNAL_H */
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 59e9552..6bdc433 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -422,157 +422,6 @@ typedef struct opcode_t {
 
 #define CHK_NONE
 
-
-/*****************************************************************************/
-/***                           Instruction decoding                        ***/
-#define EXTRACT_HELPER(name, shift, nb)                                       \
-static inline uint32_t name(uint32_t opcode)                                  \
-{                                                                             \
-    return (opcode >> (shift)) & ((1 << (nb)) - 1);                           \
-}
-
-#define EXTRACT_SHELPER(name, shift, nb)                                      \
-static inline int32_t name(uint32_t opcode)                                   \
-{                                                                             \
-    return (int16_t)((opcode >> (shift)) & ((1 << (nb)) - 1));                \
-}
-
-#define EXTRACT_HELPER_SPLIT(name, shift1, nb1, shift2, nb2)                  \
-static inline uint32_t name(uint32_t opcode)                                  \
-{                                                                             \
-    return (((opcode >> (shift1)) & ((1 << (nb1)) - 1)) << nb2) |             \
-            ((opcode >> (shift2)) & ((1 << (nb2)) - 1));                      \
-}
-
-#define EXTRACT_HELPER_DXFORM(name,                                           \
-                              d0_bits, shift_op_d0, shift_d0,                 \
-                              d1_bits, shift_op_d1, shift_d1,                 \
-                              d2_bits, shift_op_d2, shift_d2)                 \
-static inline int16_t name(uint32_t opcode)                                   \
-{                                                                             \
-    return                                                                    \
-        (((opcode >> (shift_op_d0)) & ((1 << (d0_bits)) - 1)) << (shift_d0)) | \
-        (((opcode >> (shift_op_d1)) & ((1 << (d1_bits)) - 1)) << (shift_d1)) | \
-        (((opcode >> (shift_op_d2)) & ((1 << (d2_bits)) - 1)) << (shift_d2));  \
-}
-
-
-/* Opcode part 1 */
-EXTRACT_HELPER(opc1, 26, 6);
-/* Opcode part 2 */
-EXTRACT_HELPER(opc2, 1, 5);
-/* Opcode part 3 */
-EXTRACT_HELPER(opc3, 6, 5);
-/* Opcode part 4 */
-EXTRACT_HELPER(opc4, 16, 5);
-/* Update Cr0 flags */
-EXTRACT_HELPER(Rc, 0, 1);
-/* Update Cr6 flags (Altivec) */
-EXTRACT_HELPER(Rc21, 10, 1);
-/* Destination */
-EXTRACT_HELPER(rD, 21, 5);
-/* Source */
-EXTRACT_HELPER(rS, 21, 5);
-/* First operand */
-EXTRACT_HELPER(rA, 16, 5);
-/* Second operand */
-EXTRACT_HELPER(rB, 11, 5);
-/* Third operand */
-EXTRACT_HELPER(rC, 6, 5);
-/***                               Get CRn                                 ***/
-EXTRACT_HELPER(crfD, 23, 3);
-EXTRACT_HELPER(crfS, 18, 3);
-EXTRACT_HELPER(crbD, 21, 5);
-EXTRACT_HELPER(crbA, 16, 5);
-EXTRACT_HELPER(crbB, 11, 5);
-/* SPR / TBL */
-EXTRACT_HELPER(_SPR, 11, 10);
-static inline uint32_t SPR(uint32_t opcode)
-{
-    uint32_t sprn = _SPR(opcode);
-
-    return ((sprn >> 5) & 0x1F) | ((sprn & 0x1F) << 5);
-}
-/***                              Get constants                            ***/
-/* 16 bits signed immediate value */
-EXTRACT_SHELPER(SIMM, 0, 16);
-/* 16 bits unsigned immediate value */
-EXTRACT_HELPER(UIMM, 0, 16);
-/* 5 bits signed immediate value */
-EXTRACT_HELPER(SIMM5, 16, 5);
-/* 5 bits signed immediate value */
-EXTRACT_HELPER(UIMM5, 16, 5);
-/* 4 bits unsigned immediate value */
-EXTRACT_HELPER(UIMM4, 16, 4);
-/* Bit count */
-EXTRACT_HELPER(NB, 11, 5);
-/* Shift count */
-EXTRACT_HELPER(SH, 11, 5);
-/* Vector shift count */
-EXTRACT_HELPER(VSH, 6, 4);
-/* Mask start */
-EXTRACT_HELPER(MB, 6, 5);
-/* Mask end */
-EXTRACT_HELPER(ME, 1, 5);
-/* Trap operand */
-EXTRACT_HELPER(TO, 21, 5);
-
-EXTRACT_HELPER(CRM, 12, 8);
-
-#ifndef CONFIG_USER_ONLY
-EXTRACT_HELPER(SR, 16, 4);
-#endif
-
-/* mtfsf/mtfsfi */
-EXTRACT_HELPER(FPBF, 23, 3);
-EXTRACT_HELPER(FPIMM, 12, 4);
-EXTRACT_HELPER(FPL, 25, 1);
-EXTRACT_HELPER(FPFLM, 17, 8);
-EXTRACT_HELPER(FPW, 16, 1);
-
-/* addpcis */
-EXTRACT_HELPER_DXFORM(DX, 10, 6, 6, 5, 16, 1, 1, 0, 0)
-#if defined(TARGET_PPC64)
-/* darn */
-EXTRACT_HELPER(L, 16, 2);
-#endif
-
-/***                            Jump target decoding                       ***/
-/* Immediate address */
-static inline target_ulong LI(uint32_t opcode)
-{
-    return (opcode >> 0) & 0x03FFFFFC;
-}
-
-static inline uint32_t BD(uint32_t opcode)
-{
-    return (opcode >> 0) & 0xFFFC;
-}
-
-EXTRACT_HELPER(BO, 21, 5);
-EXTRACT_HELPER(BI, 16, 5);
-/* Absolute/relative address */
-EXTRACT_HELPER(AA, 1, 1);
-/* Link */
-EXTRACT_HELPER(LK, 0, 1);
-
-/* DFP Z22-form */
-EXTRACT_HELPER(DCM, 10, 6)
-
-/* DFP Z23-form */
-EXTRACT_HELPER(RMC, 9, 2)
-
-EXTRACT_HELPER_SPLIT(xT, 0, 1, 21, 5);
-EXTRACT_HELPER_SPLIT(xS, 0, 1, 21, 5);
-EXTRACT_HELPER_SPLIT(xA, 2, 1, 16, 5);
-EXTRACT_HELPER_SPLIT(xB, 1, 1, 11, 5);
-EXTRACT_HELPER_SPLIT(xC, 3, 1,  6, 5);
-EXTRACT_HELPER(DM, 8, 2);
-EXTRACT_HELPER(UIM, 16, 2);
-EXTRACT_HELPER(SHW, 8, 2);
-EXTRACT_HELPER(SP, 19, 2);
-EXTRACT_HELPER(IMM8, 11, 8);
-
 /*****************************************************************************/
 /* PowerPC instructions table                                                */
 
-- 
2.9.3
