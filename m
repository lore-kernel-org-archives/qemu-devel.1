Received: from eggs.gnu.org ([2001:4830:134:3::10]:44340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfkz4-0001Nf-Eo
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfkz1-0003Ar-8u
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:14:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47065
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cfkz1-0003AJ-2U
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:14:15 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KA9rTa026526
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:14:14 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28qtvs8tgp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:14:14 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 20 Feb 2017 20:14:11 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 15:41:52 +0530
In-Reply-To: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487585521-19445-2-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 01/10] target/ppc: support for 32-bit carry
 and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

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
---
 target/ppc/cpu.h       | 30 ++++++++++++++++++++++++++++++
 target/ppc/translate.c | 17 ++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 425e79d..ef392f0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -965,6 +965,8 @@ struct CPUPPCState {
     target_ulong so;
     target_ulong ov;
     target_ulong ca;
+    target_ulong ov32;
+    target_ulong ca32;
     /* Reservation address */
     target_ulong reserve_addr;
     /* Reservation value */
@@ -1372,11 +1374,15 @@ int ppc_compat_max_threads(PowerPCCPU *cpu);
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
 
@@ -2343,11 +2349,21 @@ enum {
 
 /*****************************************************************************/
 
+#ifndef TARGET_PPC64
 static inline target_ulong cpu_read_xer(CPUPPCState *env)
 {
     return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) | (env->ca << XER_CA);
 }
+#else
+static inline target_ulong cpu_read_xer(CPUPPCState *env)
+{
+    return env->xer | (env->so << XER_SO) |
+        (env->ov << XER_OV) | (env->ca << XER_CA) |
+        (env->ov32 << XER_OV32) | (env->ca32 << XER_CA32);
+}
+#endif
 
+#ifndef TARGET_PPC64
 static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
 {
     env->so = (xer >> XER_SO) & 1;
@@ -2355,6 +2371,20 @@ static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
     env->ca = (xer >> XER_CA) & 1;
     env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
 }
+#else
+static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
+{
+    env->so = (xer >> XER_SO) & 1;
+    env->ov = (xer >> XER_OV) & 1;
+    env->ca = (xer >> XER_CA) & 1;
+    env->ov32 = (xer >> XER_OV32) & 1;
+    env->ca32 = (xer >> XER_CA32) & 1;
+    env->xer = xer & ~((1ul << XER_SO) |
+                       (1ul << XER_OV) | (1ul << XER_CA) |
+                       (1ul << XER_OV32) | (1ul << XER_CA32));
+}
+#endif
+
 
 static inline void cpu_get_tb_cpu_state(CPUPPCState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3ba2616..498b095 100644
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
@@ -3715,6 +3719,12 @@ static void gen_read_xer(TCGv dst)
     tcg_gen_or_tl(t0, t0, t1);
     tcg_gen_or_tl(dst, dst, t2);
     tcg_gen_or_tl(dst, dst, t0);
+#ifdef TARGET_PPC64
+    tcg_gen_shli_tl(t0, cpu_ov32, XER_OV32);
+    tcg_gen_or_tl(dst, dst, t0);
+    tcg_gen_shli_tl(t0, cpu_ca32, XER_CA32);
+    tcg_gen_or_tl(dst, dst, t0);
+#endif
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
@@ -3727,9 +3737,14 @@ static void gen_write_xer(TCGv src)
     tcg_gen_shri_tl(cpu_so, src, XER_SO);
     tcg_gen_shri_tl(cpu_ov, src, XER_OV);
     tcg_gen_shri_tl(cpu_ca, src, XER_CA);
+    tcg_gen_shri_tl(cpu_ov32, src, XER_OV32);
+    tcg_gen_shri_tl(cpu_ca32, src, XER_CA32);
     tcg_gen_andi_tl(cpu_so, cpu_so, 1);
     tcg_gen_andi_tl(cpu_ov, cpu_ov, 1);
     tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+    tcg_gen_andi_tl(cpu_ov32, cpu_ov32, 1);
+    tcg_gen_andi_tl(cpu_ca32, cpu_ca32, 1);
+
 }
 
 /* mcrxr */
-- 
2.7.4
