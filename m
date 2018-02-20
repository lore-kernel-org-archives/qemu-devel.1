Received: from eggs.gnu.org ([2001:4830:134:3::10]:37916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoF32-00008d-E9
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoF2x-0001KB-18
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:02:00 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoF2w-0001IP-NS
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:01:54 -0500
Received: by mail-wr0-x242.google.com with SMTP id u49so13614681wrc.10
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:01:54 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 20 Feb 2018 21:01:37 +0000
Message-Id: <20180220210137.18018-1-alex.bennee@linaro.org>
In-Reply-To: <CAFEAcA_Tp9cH5CBi4C6CRHpZ4ozygGSFYhdLaURBQOVZ9zVxvA@mail.gmail.com>
References: <CAFEAcA_Tp9cH5CBi4C6CRHpZ4ozygGSFYhdLaURBQOVZ9zVxvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] fpu/softfloat: use hardware sqrt if we can
 (EXPERIMENT!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, "open list:ARM" <qemu-arm@nongnu.org>

This is an attempt to save some of the cost of sqrt by using the
inbuilt support of the host hardware. The idea is assuming we start
with a valid input we can use the hardware. If any tininess issues
occur this will trip and FPU exception where:

  - we turn off cpu->use_host_fpu
  - mask the FPU exceptions
  - return to what we were doing

Once we return we should pick up the fact that there was something
weird about the operation and fall-back to the pure software
implementation.

You could imagine this being extended for code generation but instead
of returning to the code we could exit and re-generate the TB but this
time with pure software helpers rather than any support from the
hardware.

This is a sort of fix-it-up after the fact approach because reading
the FP state is an expensive operation for everything so let's only
worry about exceptions when they trip...

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c                        | 28 ++++++++++++++++++++++++++++
 fpu/softfloat.c               | 40 +++++++++++++++++++++++++++++++++++-----
 include/fpu/softfloat-types.h |  2 ++
 include/fpu/softfloat.h       |  4 ++++
 include/qom/cpu.h             |  1 +
 linux-user/main.c             |  8 ++++++++
 linux-user/signal.c           | 16 ++++++++++++++++
 target/arm/cpu.c              |  4 ++++
 8 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/cpus.c b/cpus.c
index f298b659f4..e435f6737b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include <fenv.h>
 #include "qemu/config-file.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
@@ -1078,10 +1079,36 @@ static void qemu_init_sigbus(void)
 
     prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_EARLY, 0, 0);
 }
+
+static void sigfpu_handler(int n, siginfo_t *siginfo, void *ctx)
+{
+    fprintf(stderr, "%s: got %d, %p/%p\n", __func__, n, siginfo, ctx);
+
+    /* Called asynchronously in VCPU thread.  */
+    g_assert(current_cpu);
+}
+
+static void qemu_init_sigfpu(void)
+{
+    struct sigaction action;
+
+    memset(&action, 0, sizeof(action));
+    action.sa_flags = SA_SIGINFO;
+    action.sa_sigaction = sigfpu_handler;
+    sigaction(SIGBUS, &action, NULL);
+
+    feenableexcept(FE_INVALID   |
+                   FE_OVERFLOW  |
+                   FE_UNDERFLOW |
+                   FE_INEXACT);
+}
 #else /* !CONFIG_LINUX */
 static void qemu_init_sigbus(void)
 {
 }
+static void qemu_init_sigfpu(void)
+{
+}
 #endif /* !CONFIG_LINUX */
 
 static QemuMutex qemu_global_mutex;
@@ -1827,6 +1854,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     if (!tcg_region_inited) {
         tcg_region_inited = 1;
         tcg_region_init();
+        qemu_init_sigfpu();
     }
 
     if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e7fb0d357a..ec9355af7a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1905,10 +1905,12 @@ float64 float64_scalbn(float64 a, int n, float_status *status)
  * bits to ensure we get a correctly rounded result.
  *
  * This does mean however the calculation is slower than before,
- * especially for 64 bit floats.
+ * especially for 64 bit floats. However the caller can only do checks
+ * if they actually want to off-load to the library.
  */
 
-static FloatParts sqrt_float(FloatParts a, float_status *s, const FloatFmt *p)
+static FloatParts sqrt_float(FloatParts a, float_status *s,
+                             const FloatFmt *p, bool check_only)
 {
     uint64_t a_frac, r_frac, s_frac;
     int bit, last_bit;
@@ -1928,6 +1930,10 @@ static FloatParts sqrt_float(FloatParts a, float_status *s, const FloatFmt *p)
         return a;  /* sqrt(+inf) = +inf */
     }
 
+    if (check_only) {
+        return a;
+    }
+
     assert(a.cls == float_class_normal);
 
     /* We need two overflow bits at the top. Adding room for that is a
@@ -1973,21 +1979,45 @@ static FloatParts sqrt_float(FloatParts a, float_status *s, const FloatFmt *p)
 float16 __attribute__((flatten)) float16_sqrt(float16 a, float_status *status)
 {
     FloatParts pa = float16_unpack_canonical(a, status);
-    FloatParts pr = sqrt_float(pa, status, &float16_params);
+    FloatParts pr = sqrt_float(pa, status, &float16_params, false);
     return float16_round_pack_canonical(pr, status);
 }
 
 float32 __attribute__((flatten)) float32_sqrt(float32 a, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
-    FloatParts pr = sqrt_float(pa, status, &float32_params);
+    FloatParts pr;
+
+    if (status->use_host_fpu && *status->use_host_fpu) {
+        pr = sqrt_float(pa, status, &float32_params, true);
+        if (pr.cls == float_class_normal) {
+            float32 r = __builtin_sqrt(a);
+            if (*status->use_host_fpu) {
+                return r;
+            }
+        }
+    }
+
+    pr = sqrt_float(pa, status, &float32_params, false);
     return float32_round_pack_canonical(pr, status);
 }
 
 float64 __attribute__((flatten)) float64_sqrt(float64 a, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
-    FloatParts pr = sqrt_float(pa, status, &float64_params);
+    FloatParts pr = sqrt_float(pa, status, &float64_params, true);
+
+    if (status->use_host_fpu && *status->use_host_fpu) {
+        pr = sqrt_float(pa, status, &float64_params, true);
+        if (pr.cls == float_class_normal) {
+            float64 r = __builtin_sqrt(a);
+            if (*status->use_host_fpu) {
+                return r;
+            }
+        }
+    }
+
+    pr = sqrt_float(pa, status, &float64_params, false);
     return float64_round_pack_canonical(pr, status);
 }
 
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 4e378cb612..4c32e56cad 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -174,6 +174,8 @@ typedef struct float_status {
     flag flush_inputs_to_zero;
     flag default_nan_mode;
     flag snan_bit_is_one;
+    /* can we use the host_fpu for some things? */
+    bool *use_host_fpu;
 } float_status;
 
 #endif /* SOFTFLOAT_TYPES_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 9b7b5e34e2..f7ee0232a2 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -157,6 +157,10 @@ static inline flag get_default_nan_mode(float_status *status)
 {
     return status->default_nan_mode;
 }
+static inline void enable_host_fpu(bool *host_fpu_flag, float_status *status)
+{
+    status->use_host_fpu = host_fpu_flag;
+}
 
 /*----------------------------------------------------------------------------
 | Routine to raise any or all of the software IEC/IEEE floating-point
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index aff88fa16f..337ebef8b6 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -396,6 +396,7 @@ struct CPUState {
     uint32_t halted;
     uint32_t can_do_io;
     int32_t exception_index;
+    bool use_host_fpu;
 
     /* shared by kvm, hax and hvf */
     bool vcpu_dirty;
diff --git a/linux-user/main.c b/linux-user/main.c
index 7de0e02487..36b6be3b2b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -20,6 +20,7 @@
 #include "qemu-version.h"
 #include <sys/syscall.h>
 #include <sys/resource.h>
+#include <fenv.h>
 
 #include "qapi/error.h"
 #include "qemu.h"
@@ -4927,6 +4928,13 @@ int main(int argc, char **argv, char **envp)
         }
         gdb_handlesig(cpu, 0);
     }
+
+    feenableexcept(FE_INVALID   |
+                   FE_OVERFLOW  |
+                   FE_UNDERFLOW |
+                   FE_INEXACT);
+    cpu->use_host_fpu = true;
+
     cpu_loop(env);
     /* never exits */
     return 0;
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 9a380b9e31..0773d3ef18 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include <sys/ucontext.h>
 #include <sys/resource.h>
+#include <fenv.h>
 
 #include "qemu.h"
 #include "qemu-common.h"
@@ -639,6 +640,21 @@ static void host_signal_handler(int host_signum, siginfo_t *info,
     ucontext_t *uc = puc;
     struct emulated_sigtable *k;
 
+    /* Catch any FPU exceptions we might get from having tried to use
+     * the host FPU to speed up some calculations
+     */
+    if (host_signum == SIGFPE && cpu->use_host_fpu) {
+        cpu->use_host_fpu = false;
+        /* sadly this gets lost on the context switch when we return */
+        fedisableexcept(FE_INVALID   |
+                        FE_OVERFLOW  |
+                        FE_UNDERFLOW |
+                        FE_INEXACT);
+        /* sigaddset(&uc->uc_sigmask, SIGFPE); */
+        uc->__fpregs_mem.mxcsr |= 0x1f80;
+        return;
+    }
+
     /* the CPU emulator uses some host signals to detect exceptions,
        we forward to it some signals */
     if ((host_signum == SIGSEGV || host_signum == SIGBUS)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1b3ae62db6..67dce53a68 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -306,6 +306,10 @@ static void arm_cpu_reset(CPUState *s)
                               &env->vfp.fp_status);
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->vfp.standard_fp_status);
+
+    enable_host_fpu(&s->use_host_fpu, &env->vfp.fp_status);
+    enable_host_fpu(&s->use_host_fpu, &env->vfp.standard_fp_status);
+
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         kvm_arm_reset_vcpu(cpu);
-- 
2.15.1
