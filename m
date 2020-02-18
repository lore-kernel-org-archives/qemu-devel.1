Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10C4C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705DE20801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705DE20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46Ww-00010B-KN
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j46Up-0006eV-93
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j46Ul-0001DH-A2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:17:18 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:22159)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j46Uh-00015s-O3; Tue, 18 Feb 2020 12:17:14 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D96E07475F6;
 Tue, 18 Feb 2020 18:17:02 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 979F074637D; Tue, 18 Feb 2020 18:17:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 18 Feb 2020 18:10:16 +0100
Subject: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: qemu-devel@nongnu.org
Message-Id: <20200218171702.979F074637D@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc@nongnu.org,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While other targets take advantage of using host FPU to do floating
point computations, this was disabled for PPC target because always
clearing exception flags before every FP op made it slightly slower
than emulating everyting with softfloat. To emulate some FPSCR bits,
clearing of fp_status may be necessary (unless these could be handled
e.g. using FP exceptions on host but there's no API for that in QEMU
yet) but preserving at least the inexact flag makes hardfloat usable
and faster than softfloat. Since most clients don't actually care
about this flag, we can gain some speed trading some emulation
accuracy.

This patch implements a simple way to keep the inexact flag set for
hardfloat while still allowing to revert to softfloat for workloads
that need more accurate albeit slower emulation. (Set hardfloat
property of CPU, i.e. -cpu name,hardfloat=false for that.) There may
still be room for further improvement but this seems to increase
floating point performance. Unfortunately the softfloat case is slower
than before this patch so this patch only makes sense if the default
is also set to enable hardfloat.

Because of the above this patch at the moment is mainly for testing
different workloads to evaluate how viable would this be in practice.
Thus, RFC and not ready for merge yet.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v2: use different approach to avoid needing if () in
helper_reset_fpstatus() but this does not seem to change overhead
much, also make it a single patch as adding the hardfloat option is
only a few lines; with this we can use same value at other places where
float_status is reset and maybe enable hardfloat for a few more places
for a little more performance but not too much. With this I got:

lame: 3:13, lame_vmx: 1:55 (this is probably within jitter though and
still far from the results on real hardware) also tried mplayer test
and got results between 144-146s (this test is more VMX bound).

I've also done some profiling for hardfloat=true and false cases with
this patch to see what are the hot functions. Results are:

Overhead  Command          Symbol
-cpu G4,hardfloat=false, lame:
   9.82%  qemu-system-ppc  [.] round_canonical
   8.35%  qemu-system-ppc  [.] soft_f64_muladd
   7.16%  qemu-system-ppc  [.] soft_f64_addsub
   5.27%  qemu-system-ppc  [.] float32_to_float64
   5.20%  qemu-system-ppc  [.] helper_compute_fprf_float64
   4.61%  qemu-system-ppc  [.] helper_frsp
   4.59%  qemu-system-ppc  [.] soft_f64_mul
   4.01%  qemu-system-ppc  [.] float_to_float.isra.26
   3.84%  qemu-system-ppc  [.] float64_classify
   2.97%  qemu-system-ppc  [.] do_float_check_status

-cpu G4,hardfloat=false, lame_vmx:
Overhead  Command          Symbol
  10.04%  qemu-system-ppc  [.] float32_muladd
   9.49%  qemu-system-ppc  [.] helper_vperm
   6.10%  qemu-system-ppc  [.] round_canonical
   4.13%  qemu-system-ppc  [.] soft_f64_addsub
   3.23%  qemu-system-ppc  [.] helper_frsp
   3.13%  qemu-system-ppc  [.] soft_f64_muladd
   2.88%  qemu-system-ppc  [.] helper_vmaddfp
   2.69%  qemu-system-ppc  [.] float32_add
   2.60%  qemu-system-ppc  [.] float32_to_float64
   2.52%  qemu-system-ppc  [.] helper_compute_fprf_float64
    
-cpu G4,hardfloat=true, lame:
  11.59%  qemu-system-ppc  [.] round_canonical
   6.18%  qemu-system-ppc  [.] helper_compute_fprf_float64
   6.01%  qemu-system-ppc  [.] float32_to_float64
   4.58%  qemu-system-ppc  [.] float64_classify
   3.87%  qemu-system-ppc  [.] helper_frsp
   3.75%  qemu-system-ppc  [.] float_to_float.isra.26
   3.48%  qemu-system-ppc  [.] helper_todouble
   3.31%  qemu-system-ppc  [.] float64_muladd
   3.21%  qemu-system-ppc  [.] do_float_check_status
   3.01%  qemu-system-ppc  [.] float64_mul

-cpu G4,hardfloat=true, lame_vmx:
   9.34%  qemu-system-ppc  [.] float32_muladd
   8.83%  qemu-system-ppc  [.] helper_vperm
   5.41%  qemu-system-ppc  [.] round_canonical
   4.51%  qemu-system-ppc  [.] page_collection_lock
   3.58%  qemu-system-ppc  [.] page_trylock_add.isra.17
   2.71%  qemu-system-ppc  [.] helper_vmaddfp
   2.53%  qemu-system-ppc  [.] float32_add
   2.30%  qemu-system-ppc  [.] helper_compute_fprf_float64
   2.21%  qemu-system-ppc  [.] float32_to_float64
   2.06%  qemu-system-ppc  [.] helper_frsp

round_canonical seems to come up frequently in this with large overhead.

Could those with better test cases or benchmarks give it a test please
on different CPUs to see what else this would break?

---
fpu/softfloat.c                 | 14 +++++++-------
 target/ppc/cpu.h                |  2 ++
 target/ppc/fpu_helper.c         | 32 ++++++++++++++++----------------
 target/ppc/translate_init.inc.c |  3 +++
 4 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 301ce3b537..6d3f4af72a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -216,15 +216,15 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
 #endif
 
 /*
- * Some targets clear the FP flags before most FP operations. This prevents
- * the use of hardfloat, since hardfloat relies on the inexact flag being
- * already set.
+ * Disable hardfloat for known problem cases.
+ * Additionally, some targets clear the FP flags before most FP operations.
+ * This prevents the use of hardfloat, since it relies on the inexact flag
+ * being already set and clearing it often may result in slower computations.
+ * Those targets could also be listed here.
  */
-#if defined(TARGET_PPC) || defined(__FAST_MATH__)
-# if defined(__FAST_MATH__)
-#  warning disabling hardfloat due to -ffast-math: hardfloat requires an exact \
+#if defined(__FAST_MATH__)
+# warning disabling hardfloat due to -ffast-math: hardfloat requires an exact \
     IEEE implementation
-# endif
 # define QEMU_NO_HARDFLOAT 1
 # define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN
 #else
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b283042515..5f412f9fba 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1033,6 +1033,7 @@ struct CPUPPCState {
     float_status vec_status;
     float_status fp_status; /* Floating point execution context */
     target_ulong fpscr;     /* Floating point status and control register */
+    int default_fp_excpt_flags;
 
     /* Internal devices resources */
     ppc_tb_t *tb_env;      /* Time base and decrementer */
@@ -1163,6 +1164,7 @@ struct PowerPCCPU {
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
+    bool hardfloat;  /* use hardfloat (this breaks FPSCR[FI] bit emulation) */
 
     /* Those resources are used only during code translation */
     /* opcode handlers */
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index ae43b08eb5..bbbd1cb987 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -659,7 +659,7 @@ void helper_float_check_status(CPUPPCState *env)
 
 void helper_reset_fpstatus(CPUPPCState *env)
 {
-    set_float_exception_flags(0, &env->fp_status);
+    set_float_exception_flags(env->default_fp_excpt_flags, &env->fp_status);
 }
 
 static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,
@@ -1823,7 +1823,7 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,                          \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
-        set_float_exception_flags(0, &tstat);                                \
+        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);      \
         t.fld = tp##_##op(xa->fld, xb->fld, &tstat);                         \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
                                                                              \
@@ -1867,7 +1867,7 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode,
         tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    set_float_exception_flags(0, &tstat);
+    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
     t.f128 = float128_add(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
@@ -1902,7 +1902,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                            \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
-        set_float_exception_flags(0, &tstat);                                \
+        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);      \
         t.fld = tp##_mul(xa->fld, xb->fld, &tstat);                          \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
                                                                              \
@@ -1942,7 +1942,7 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opcode,
         tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    set_float_exception_flags(0, &tstat);
+    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
     t.f128 = float128_mul(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
@@ -1976,7 +1976,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                             \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
         float_status tstat = env->fp_status;                                  \
-        set_float_exception_flags(0, &tstat);                                 \
+        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);       \
         t.fld = tp##_div(xa->fld, xb->fld, &tstat);                           \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags;  \
                                                                               \
@@ -2019,7 +2019,7 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode,
         tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    set_float_exception_flags(0, &tstat);
+    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
     t.f128 = float128_div(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
@@ -2095,7 +2095,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
-        set_float_exception_flags(0, &tstat);                                \
+        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);      \
         t.fld = tp##_sqrt(xb->fld, &tstat);                                  \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
                                                                              \
@@ -2143,7 +2143,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
-        set_float_exception_flags(0, &tstat);                                \
+        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);      \
         t.fld = tp##_sqrt(xb->fld, &tstat);                                  \
         t.fld = tp##_div(tp##_one, t.fld, &tstat);                           \
         env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
@@ -2305,7 +2305,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                             \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
         float_status tstat = env->fp_status;                                  \
-        set_float_exception_flags(0, &tstat);                                 \
+        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);       \
         if (r2sp && (tstat.float_rounding_mode == float_round_nearest_even)) {\
             /*                                                                \
              * Avoid double rounding errors by rounding the intermediate      \
@@ -2886,7 +2886,7 @@ uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
     uint64_t result, sign, exp, frac;
 
     float_status tstat = env->fp_status;
-    set_float_exception_flags(0, &tstat);
+    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
 
     sign = extract64(xb, 63,  1);
     exp  = extract64(xb, 52, 11);
@@ -2924,7 +2924,7 @@ uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
 uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_t xb)
 {
     float_status tstat = env->fp_status;
-    set_float_exception_flags(0, &tstat);
+    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
 
     return float32_to_float64(xb >> 32, &tstat);
 }
@@ -3327,7 +3327,7 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode,
     }
 
     tstat = env->fp_status;
-    set_float_exception_flags(0, &tstat);
+    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
     set_float_rounding_mode(rmode, &tstat);
     t.f128 = float128_round_to_int(xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
@@ -3384,7 +3384,7 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode,
     }
 
     tstat = env->fp_status;
-    set_float_exception_flags(0, &tstat);
+    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
     set_float_rounding_mode(rmode, &tstat);
     round_res = float128_to_floatx80(xb->f128, &tstat);
     t.f128 = floatx80_to_float128(round_res, &tstat);
@@ -3415,7 +3415,7 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode,
         tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    set_float_exception_flags(0, &tstat);
+    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
     t.f128 = float128_sqrt(xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
@@ -3449,7 +3449,7 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode,
         tstat.float_rounding_mode = float_round_to_odd;
     }
 
-    set_float_exception_flags(0, &tstat);
+    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
     t.f128 = float128_sub(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
 
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 53995f62ea..ab1a6db4f1 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10736,6 +10736,8 @@ static void ppc_cpu_reset(CPUState *s)
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->fp_status);
+    /* hardfloat needs inexact flag already set */
+    env->default_fp_excpt_flags = (cpu->hardfloat ? float_flag_inexact : 0);
 
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
@@ -10868,6 +10870,7 @@ static Property ppc_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
                      false),
+    DEFINE_PROP_BOOL("hardfloat", PowerPCCPU, hardfloat, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.21.1


