Received: from eggs.gnu.org ([2001:4830:134:3::10]:46380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7l-0007yT-GI
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7i-0008VY-R8
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:25 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:31 +1100
Message-Id: <20170301044405.1792-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/50] target/ppc: support for 32-bit carry and
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

POWER ISA 3.0 adds CA32 and OV32 status in 64-bit mode. Add the flags
and corresponding defines.

Moreover, CA32 is updated when CA is updated and OV32 is updated when OV
is updated.

Arithmetic instructions:
    * Addition and Substractions:

        addic, addic., subfic, addc, subfc, adde, subfe, addme, subfme,
        addze, and subfze always updates CA and CA32.

        => CA reflects the carry out of bit 0 in 64-bit mode and out of
           bit 32 in 32-bit mode.
        => CA32 reflects the carry out of bit 32 independent of the
           mode.

        => SO and OV reflects overflow of the 64-bit result in 64-bit
           mode and overflow of the low-order 32-bit result in 32-bit
           mode
        => OV32 reflects overflow of the low-order 32-bit independent of
           the mode

    * Multiply Low and Divide:

        For mulld, divd, divde, divdu and divdeu: SO, OV, and OV32 bits
        reflects overflow of the 64-bit result

        For mullw, divw, divwe, divwu and divweu: SO, OV, and OV32 bits
        reflects overflow of the 32-bit result

     * Negate with OE=1 (nego)

       For 64-bit mode if the register RA contains
       0x8000_0000_0000_0000, OV and OV32 are set to 1.

       For 32-bit mode if the register RA contains 0x8000_0000, OV and
       OV32 are set to 1.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.c            | 13 ++++++++++++-
 target/ppc/cpu.h            |  7 +++++++
 target/ppc/translate.c      | 21 ++++++++++++++++++---
 target/ppc/translate_init.c |  2 +-
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index de3004b..2801166 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -23,6 +23,12 @@
 
 target_ulong cpu_read_xer(CPUPPCState *env)
 {
+    if (is_isa300(env)) {
+        return env->xer | (env->so << XER_SO) |
+            (env->ov << XER_OV) | (env->ca << XER_CA) |
+            (env->ov32 << XER_OV32) | (env->ca32 << XER_CA32);
+    }
+
     return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
         (env->ca << XER_CA);
 }
@@ -32,5 +38,10 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer)
     env->so = (xer >> XER_SO) & 1;
     env->ov = (xer >> XER_OV) & 1;
     env->ca = (xer >> XER_CA) & 1;
-    env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
+    /* write all the flags, while reading back check of isa300 */
+    env->ov32 = (xer >> XER_OV32) & 1;
+    env->ca32 = (xer >> XER_CA32) & 1;
+    env->xer = xer & ~((1ul << XER_SO) |
+                       (1ul << XER_OV) | (1ul << XER_CA) |
+                       (1ul << XER_OV32) | (1ul << XER_CA32));
 }
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4e7fc2c..420e6d6 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -958,6 +958,8 @@ struct CPUPPCState {
     target_ulong so;
     target_ulong ov;
     target_ulong ca;
+    target_ulong ov32;
+    target_ulong ca32;
     /* Reservation address */
     target_ulong reserve_addr;
     /* Reservation value */
@@ -1367,11 +1369,15 @@ int ppc_compat_max_threads(PowerPCCPU *cpu);
 #define XER_SO  31
 #define XER_OV  30
 #define XER_CA  29
+#define XER_OV32  19
+#define XER_CA32  18
 #define XER_CMP  8
 #define XER_BC   0
 #define xer_so  (env->so)
 #define xer_ov  (env->ov)
 #define xer_ca  (env->ca)
+#define xer_ov32  (env->ov)
+#define xer_ca32  (env->ca)
 #define xer_cmp ((env->xer >> XER_CMP) & 0xFF)
 #define xer_bc  ((env->xer >> XER_BC)  & 0x7F)
 
@@ -2338,6 +2344,7 @@ enum {
 
 /*****************************************************************************/
 
+#define is_isa300(ctx) (!!(ctx->insns_flags2 & PPC2_ISA300))
 target_ulong cpu_read_xer(CPUPPCState *env);
 void cpu_write_xer(CPUPPCState *env, target_ulong xer);
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b09e16f..be7378b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -71,7 +71,7 @@ static TCGv cpu_lr;
 #if defined(TARGET_PPC64)
 static TCGv cpu_cfar;
 #endif
-static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca;
+static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
 static TCGv cpu_reserve;
 static TCGv cpu_fpscr;
 static TCGv_i32 cpu_access_type;
@@ -173,6 +173,10 @@ void ppc_translate_init(void)
                                 offsetof(CPUPPCState, ov), "OV");
     cpu_ca = tcg_global_mem_new(cpu_env,
                                 offsetof(CPUPPCState, ca), "CA");
+    cpu_ov32 = tcg_global_mem_new(cpu_env,
+                                  offsetof(CPUPPCState, ov32), "OV32");
+    cpu_ca32 = tcg_global_mem_new(cpu_env,
+                                  offsetof(CPUPPCState, ca32), "CA32");
 
     cpu_reserve = tcg_global_mem_new(cpu_env,
                                      offsetof(CPUPPCState, reserve_addr),
@@ -3703,7 +3707,7 @@ static void gen_tdi(DisasContext *ctx)
 
 /***                          Processor control                            ***/
 
-static void gen_read_xer(TCGv dst)
+static void gen_read_xer(DisasContext *ctx, TCGv dst)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
@@ -3715,6 +3719,12 @@ static void gen_read_xer(TCGv dst)
     tcg_gen_or_tl(t0, t0, t1);
     tcg_gen_or_tl(dst, dst, t2);
     tcg_gen_or_tl(dst, dst, t0);
+    if (is_isa300(ctx)) {
+        tcg_gen_shli_tl(t0, cpu_ov32, XER_OV32);
+        tcg_gen_or_tl(dst, dst, t0);
+        tcg_gen_shli_tl(t0, cpu_ca32, XER_CA32);
+        tcg_gen_or_tl(dst, dst, t0);
+    }
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
@@ -3722,8 +3732,13 @@ static void gen_read_xer(TCGv dst)
 
 static void gen_write_xer(TCGv src)
 {
+    /* Write all flags, while reading back check for isa300 */
     tcg_gen_andi_tl(cpu_xer, src,
-                    ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA)));
+                    ~((1u << XER_SO) |
+                      (1u << XER_OV) | (1u << XER_OV32) |
+                      (1u << XER_CA) | (1u << XER_CA32)));
+    tcg_gen_extract_tl(cpu_ov32, src, XER_OV32, 1);
+    tcg_gen_extract_tl(cpu_ca32, src, XER_CA32, 1);
     tcg_gen_extract_tl(cpu_so, src, XER_SO, 1);
     tcg_gen_extract_tl(cpu_ov, src, XER_OV, 1);
     tcg_gen_extract_tl(cpu_ca, src, XER_CA, 1);
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c92435d..4dd1e36 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -107,7 +107,7 @@ static void spr_access_nop(DisasContext *ctx, int sprn, int gprn)
 /* XER */
 static void spr_read_xer (DisasContext *ctx, int gprn, int sprn)
 {
-    gen_read_xer(cpu_gpr[gprn]);
+    gen_read_xer(ctx, cpu_gpr[gprn]);
 }
 
 static void spr_write_xer (DisasContext *ctx, int sprn, int gprn)
-- 
2.9.3
