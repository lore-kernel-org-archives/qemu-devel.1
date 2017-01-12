Received: from eggs.gnu.org ([2001:4830:134:3::10]:46227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjz-0002v2-C0
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjw-0006SS-8X
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:47 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:34 +1100
Message-Id: <20170112020327.24882-15-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/67] target-ppc: add vextu[bhw][lr]x
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Avinesh Kumar <avinesku@linux.vnet.ibm.com>, "Hariharan T . S ." <hari@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Avinesh Kumar <avinesku@linux.vnet.ibm.com>

vextublx: Vector Extract Unsigned Byte Left
vextuhlx: Vector Extract Unsigned Halfword Left
vextuwlx: Vector Extract Unsigned Word Left
vextubrx: Vector Extract Unsigned Byte Right-Indexed VX-form
vextuhrx: Vector Extract Unsigned  Halfword Right-Indexed VX-form
vextuwrx: Vector Extract Unsigned Word Right-Indexed VX-form

Signed-off-by: Avinesh Kumar <avinesku@linux.vnet.ibm.com>
Signed-off-by: Hariharan T.S. <hari@linux.vnet.ibm.com>
[ implement using int128_rshift ]
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h                    |  2 ++
 target/ppc/helper.h                 |  6 ++++++
 target/ppc/int_helper.c             | 36 ++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c | 23 +++++++++++++++++++++++
 target/ppc/translate/vmx-ops.inc.c  |  8 ++++++--
 5 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b6782ba..7a6ee3f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -21,6 +21,7 @@
 #define PPC_CPU_H
 
 #include "qemu-common.h"
+#include "qemu/int128.h"
 
 //#define PPC_EMULATE_32BITS_HYPV
 
@@ -262,6 +263,7 @@ union ppc_avr_t {
 #ifdef CONFIG_INT128
     __uint128_t u128;
 #endif
+    Int128 s128;
 };
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index ac8901f..bc39efb 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -366,6 +366,12 @@ DEF_HELPER_3(vpmsumb, void, avr, avr, avr)
 DEF_HELPER_3(vpmsumh, void, avr, avr, avr)
 DEF_HELPER_3(vpmsumw, void, avr, avr, avr)
 DEF_HELPER_3(vpmsumd, void, avr, avr, avr)
+DEF_HELPER_2(vextublx, tl, tl, avr)
+DEF_HELPER_2(vextuhlx, tl, tl, avr)
+DEF_HELPER_2(vextuwlx, tl, tl, avr)
+DEF_HELPER_2(vextubrx, tl, tl, avr)
+DEF_HELPER_2(vextuhrx, tl, tl, avr)
+DEF_HELPER_2(vextuwrx, tl, tl, avr)
 
 DEF_HELPER_2(vsbox, void, avr, avr)
 DEF_HELPER_3(vcipher, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 4259876..34dfe02 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1805,6 +1805,42 @@ void helper_vlogefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
     }
 }
 
+#if defined(HOST_WORDS_BIGENDIAN)
+#define VEXTU_X_DO(name, size, left)                                \
+    target_ulong glue(helper_, name)(target_ulong a, ppc_avr_t *b)  \
+    {                                                               \
+        int index;                                                  \
+        if (left) {                                                 \
+            index = (a & 0xf) * 8;                                  \
+        } else {                                                    \
+            index = ((15 - (a & 0xf) + 1) * 8) - size;              \
+        }                                                           \
+        return int128_getlo(int128_rshift(b->s128, index)) &        \
+            MAKE_64BIT_MASK(0, size);                               \
+    }
+#else
+#define VEXTU_X_DO(name, size, left)                                \
+    target_ulong glue(helper_, name)(target_ulong a, ppc_avr_t *b)  \
+    {                                                               \
+        int index;                                                  \
+        if (left) {                                                 \
+            index = ((15 - (a & 0xf) + 1) * 8) - size;              \
+        } else {                                                    \
+            index = (a & 0xf) * 8;                                  \
+        }                                                           \
+        return int128_getlo(int128_rshift(b->s128, index)) &        \
+            MAKE_64BIT_MASK(0, size);                               \
+    }
+#endif
+
+VEXTU_X_DO(vextublx,  8, 1)
+VEXTU_X_DO(vextuhlx, 16, 1)
+VEXTU_X_DO(vextuwlx, 32, 1)
+VEXTU_X_DO(vextubrx,  8, 0)
+VEXTU_X_DO(vextuhrx, 16, 0)
+VEXTU_X_DO(vextuwrx, 32, 0)
+#undef VEXTU_X_DO
+
 /* The specification says that the results are undefined if all of the
  * shift counts are not identical.  We check to make sure that they are
  * to conform to what real hardware appears to do.  */
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index b188e60..e8e527f 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -340,6 +340,19 @@ static void glue(gen_, name0##_##name1)(DisasContext *ctx)              \
     }                                                                   \
 }
 
+#define GEN_VXFORM_HETRO(name, opc2, opc3)                              \
+static void glue(gen_, name)(DisasContext *ctx)                         \
+{                                                                       \
+    TCGv_ptr rb;                                                        \
+    if (unlikely(!ctx->altivec_enabled)) {                              \
+        gen_exception(ctx, POWERPC_EXCP_VPU);                           \
+        return;                                                         \
+    }                                                                   \
+    rb = gen_avr_ptr(rB(ctx->opcode));                                  \
+    gen_helper_##name(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], rb); \
+    tcg_temp_free_ptr(rb);                                              \
+}
+
 GEN_VXFORM(vaddubm, 0, 0);
 GEN_VXFORM_DUAL_EXT(vaddubm, PPC_ALTIVEC, PPC_NONE, 0,       \
                     vmul10cuq, PPC_NONE, PPC2_ISA300, 0x0000F800)
@@ -525,6 +538,16 @@ GEN_VXFORM_ENV(vaddfp, 5, 0);
 GEN_VXFORM_ENV(vsubfp, 5, 1);
 GEN_VXFORM_ENV(vmaxfp, 5, 16);
 GEN_VXFORM_ENV(vminfp, 5, 17);
+GEN_VXFORM_HETRO(vextublx, 6, 24)
+GEN_VXFORM_HETRO(vextuhlx, 6, 25)
+GEN_VXFORM_HETRO(vextuwlx, 6, 26)
+GEN_VXFORM_DUAL(vmrgow, PPC_NONE, PPC2_ALTIVEC_207,
+                vextuwlx, PPC_NONE, PPC2_ISA300)
+GEN_VXFORM_HETRO(vextubrx, 6, 28)
+GEN_VXFORM_HETRO(vextuhrx, 6, 29)
+GEN_VXFORM_HETRO(vextuwrx, 6, 30)
+GEN_VXFORM_DUAL(vmrgew, PPC_NONE, PPC2_ALTIVEC_207, \
+                vextuwrx, PPC_NONE, PPC2_ISA300)
 
 #define GEN_VXRFORM1(opname, name, str, opc2, opc3)                     \
 static void glue(gen_, name)(DisasContext *ctx)                         \
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index 70d7d2b..57dce6e 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -91,8 +91,12 @@ GEN_VXFORM(vmrghw, 6, 2),
 GEN_VXFORM(vmrglb, 6, 4),
 GEN_VXFORM(vmrglh, 6, 5),
 GEN_VXFORM(vmrglw, 6, 6),
-GEN_VXFORM_207(vmrgew, 6, 30),
-GEN_VXFORM_207(vmrgow, 6, 26),
+GEN_VXFORM_300(vextublx, 6, 24),
+GEN_VXFORM_300(vextuhlx, 6, 25),
+GEN_VXFORM_DUAL(vmrgow, vextuwlx, 6, 26, PPC_NONE, PPC2_ALTIVEC_207),
+GEN_VXFORM_300(vextubrx, 6, 28),
+GEN_VXFORM_300(vextuhrx, 6, 29),
+GEN_VXFORM_DUAL(vmrgew, vextuwrx, 6, 30, PPC_NONE, PPC2_ALTIVEC_207),
 GEN_VXFORM(vmuloub, 4, 0),
 GEN_VXFORM(vmulouh, 4, 1),
 GEN_VXFORM_DUAL(vmulouw, vmuluwm, 4, 2, PPC_ALTIVEC, PPC_NONE),
-- 
2.9.3
