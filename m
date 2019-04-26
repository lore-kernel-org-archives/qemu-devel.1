Received: from eggs.gnu.org ([209.51.188.92]:60775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1Q-0006Ub-AG
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1O-0005lY-IC
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:22 +1000
Message-Id: <20190426060627.18153-32-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/36] target/ppc/kvm: Convert DPRINTF to traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155445152490.302073.17033451726459859333.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c        | 68 ++++++++++++++++-------------------------
 target/ppc/trace-events | 25 +++++++++++++++
 2 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index a1c223385d..9e86db0963 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -49,16 +49,6 @@
 #include "elf.h"
 #include "sysemu/kvm_int.h"
=20
-/* #define DEBUG_KVM */
-
-#ifdef DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
 #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
=20
 const KVMCapabilityInfo kvm_arch_required_capabilities[] =3D {
@@ -640,7 +630,7 @@ static int kvm_put_fp(CPUState *cs)
         reg.addr =3D (uintptr_t)&fpscr;
         ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to set FPSCR to KVM: %s\n", strerror(errno))=
;
+            trace_kvm_failed_fpscr_set(strerror(errno));
             return ret;
         }
=20
@@ -661,8 +651,8 @@ static int kvm_put_fp(CPUState *cs)
=20
             ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
             if (ret < 0) {
-                DPRINTF("Unable to set %s%d to KVM: %s\n", vsx ? "VSR" :=
 "FPR",
-                        i, strerror(errno));
+                trace_kvm_failed_fp_set(vsx ? "VSR" : "FPR", i,
+                                        strerror(errno));
                 return ret;
             }
         }
@@ -673,7 +663,7 @@ static int kvm_put_fp(CPUState *cs)
         reg.addr =3D (uintptr_t)&env->vscr;
         ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to set VSCR to KVM: %s\n", strerror(errno));
+            trace_kvm_failed_vscr_set(strerror(errno));
             return ret;
         }
=20
@@ -682,7 +672,7 @@ static int kvm_put_fp(CPUState *cs)
             reg.addr =3D (uintptr_t)cpu_avr_ptr(env, i);
             ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
             if (ret < 0) {
-                DPRINTF("Unable to set VR%d to KVM: %s\n", i, strerror(e=
rrno));
+                trace_kvm_failed_vr_set(i, strerror(errno));
                 return ret;
             }
         }
@@ -707,7 +697,7 @@ static int kvm_get_fp(CPUState *cs)
         reg.addr =3D (uintptr_t)&fpscr;
         ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to get FPSCR from KVM: %s\n", strerror(errno=
));
+            trace_kvm_failed_fpscr_get(strerror(errno));
             return ret;
         } else {
             env->fpscr =3D fpscr;
@@ -723,8 +713,8 @@ static int kvm_get_fp(CPUState *cs)
=20
             ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
             if (ret < 0) {
-                DPRINTF("Unable to get %s%d from KVM: %s\n",
-                        vsx ? "VSR" : "FPR", i, strerror(errno));
+                trace_kvm_failed_fp_get(vsx ? "VSR" : "FPR", i,
+                                        strerror(errno));
                 return ret;
             } else {
 #ifdef HOST_WORDS_BIGENDIAN
@@ -747,7 +737,7 @@ static int kvm_get_fp(CPUState *cs)
         reg.addr =3D (uintptr_t)&env->vscr;
         ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to get VSCR from KVM: %s\n", strerror(errno)=
);
+            trace_kvm_failed_vscr_get(strerror(errno));
             return ret;
         }
=20
@@ -756,8 +746,7 @@ static int kvm_get_fp(CPUState *cs)
             reg.addr =3D (uintptr_t)cpu_avr_ptr(env, i);
             ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
             if (ret < 0) {
-                DPRINTF("Unable to get VR%d from KVM: %s\n",
-                        i, strerror(errno));
+                trace_kvm_failed_vr_get(i, strerror(errno));
                 return ret;
             }
         }
@@ -778,7 +767,7 @@ static int kvm_get_vpa(CPUState *cs)
     reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
     ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
     if (ret < 0) {
-        DPRINTF("Unable to get VPA address from KVM: %s\n", strerror(err=
no));
+        trace_kvm_failed_vpa_addr_get(strerror(errno));
         return ret;
     }
=20
@@ -788,8 +777,7 @@ static int kvm_get_vpa(CPUState *cs)
     reg.addr =3D (uintptr_t)&spapr_cpu->slb_shadow_addr;
     ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
     if (ret < 0) {
-        DPRINTF("Unable to get SLB shadow state from KVM: %s\n",
-                strerror(errno));
+        trace_kvm_failed_slb_get(strerror(errno));
         return ret;
     }
=20
@@ -799,8 +787,7 @@ static int kvm_get_vpa(CPUState *cs)
     reg.addr =3D (uintptr_t)&spapr_cpu->dtl_addr;
     ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
     if (ret < 0) {
-        DPRINTF("Unable to get dispatch trace log state from KVM: %s\n",
-                strerror(errno));
+        trace_kvm_failed_dtl_get(strerror(errno));
         return ret;
     }
=20
@@ -828,7 +815,7 @@ static int kvm_put_vpa(CPUState *cs)
         reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
         ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(e=
rrno));
+            trace_kvm_failed_vpa_addr_set(strerror(errno));
             return ret;
         }
     }
@@ -839,7 +826,7 @@ static int kvm_put_vpa(CPUState *cs)
     reg.addr =3D (uintptr_t)&spapr_cpu->slb_shadow_addr;
     ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
     if (ret < 0) {
-        DPRINTF("Unable to set SLB shadow state to KVM: %s\n", strerror(=
errno));
+        trace_kvm_failed_slb_set(strerror(errno));
         return ret;
     }
=20
@@ -849,8 +836,7 @@ static int kvm_put_vpa(CPUState *cs)
     reg.addr =3D (uintptr_t)&spapr_cpu->dtl_addr;
     ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
     if (ret < 0) {
-        DPRINTF("Unable to set dispatch trace log state to KVM: %s\n",
-                strerror(errno));
+        trace_kvm_failed_dtl_set(strerror(errno));
         return ret;
     }
=20
@@ -859,7 +845,7 @@ static int kvm_put_vpa(CPUState *cs)
         reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
         ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(e=
rrno));
+            trace_kvm_failed_null_vpa_addr_set(strerror(errno));
             return ret;
         }
     }
@@ -1016,7 +1002,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
=20
         if (cap_papr) {
             if (kvm_put_vpa(cs) < 0) {
-                DPRINTF("Warning: Unable to set VPA information to KVM\n=
");
+                trace_kvm_failed_put_vpa();
             }
         }
=20
@@ -1320,7 +1306,7 @@ int kvm_arch_get_registers(CPUState *cs)
=20
         if (cap_papr) {
             if (kvm_get_vpa(cs) < 0) {
-                DPRINTF("Warning: Unable to get VPA information from KVM=
\n");
+                trace_kvm_failed_get_vpa();
             }
         }
=20
@@ -1380,7 +1366,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run =
*run)
          */
         irq =3D KVM_INTERRUPT_SET;
=20
-        DPRINTF("injected interrupt %d\n", irq);
+        trace_kvm_injected_interrupt(irq);
         r =3D kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &irq);
         if (r < 0) {
             printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
@@ -1732,20 +1718,20 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm=
_run *run)
     switch (run->exit_reason) {
     case KVM_EXIT_DCR:
         if (run->dcr.is_write) {
-            DPRINTF("handle dcr write\n");
+            trace_kvm_handle_dcr_write();
             ret =3D kvmppc_handle_dcr_write(env, run->dcr.dcrn, run->dcr=
.data);
         } else {
-            DPRINTF("handle dcr read\n");
+            trace_kvm_handle_drc_read();
             ret =3D kvmppc_handle_dcr_read(env, run->dcr.dcrn, &run->dcr=
.data);
         }
         break;
     case KVM_EXIT_HLT:
-        DPRINTF("handle halt\n");
+        trace_kvm_handle_halt();
         ret =3D kvmppc_handle_halt(cpu);
         break;
 #if defined(TARGET_PPC64)
     case KVM_EXIT_PAPR_HCALL:
-        DPRINTF("handle PAPR hypercall\n");
+        trace_kvm_handle_papr_hcall();
         run->papr_hcall.ret =3D spapr_hypercall(cpu,
                                               run->papr_hcall.nr,
                                               run->papr_hcall.args);
@@ -1753,18 +1739,18 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm=
_run *run)
         break;
 #endif
     case KVM_EXIT_EPR:
-        DPRINTF("handle epr\n");
+        trace_kvm_handle_epr();
         run->epr.epr =3D ldl_phys(cs->as, env->mpic_iack);
         ret =3D 0;
         break;
     case KVM_EXIT_WATCHDOG:
-        DPRINTF("handle watchdog expiry\n");
+        trace_kvm_handle_watchdog_expiry();
         watchdog_perform_action();
         ret =3D 0;
         break;
=20
     case KVM_EXIT_DEBUG:
-        DPRINTF("handle debug exception\n");
+        trace_kvm_handle_debug_exception();
         if (kvm_handle_debug(cpu, run)) {
             ret =3D EXCP_DEBUG;
             break;
diff --git a/target/ppc/trace-events b/target/ppc/trace-events
index ed4d57c6d9..7b3cfe11fd 100644
--- a/target/ppc/trace-events
+++ b/target/ppc/trace-events
@@ -3,3 +3,28 @@
 # kvm.c
 kvm_failed_spr_set(int spr, const char *msg) "Warning: Unable to set SPR=
 %d to KVM: %s"
 kvm_failed_spr_get(int spr, const char *msg) "Warning: Unable to retriev=
e SPR %d from KVM: %s"
+kvm_failed_fpscr_set(const char *msg) "Unable to set FPSCR to KVM: %s"
+kvm_failed_fp_set(const char *fpname, int fpnum, const char *msg) "Unabl=
e to set %s%d to KVM: %s"
+kvm_failed_vscr_set(const char *msg) "Unable to set VSCR to KVM: %s"
+kvm_failed_vr_set(int vr, const char *msg) "Unable to set VR%d to KVM: %=
s"
+kvm_failed_fpscr_get(const char *msg) "Unable to get FPSCR from KVM: %s"
+kvm_failed_fp_get(const char *fpname, int fpnum, const char *msg) "Unabl=
e to get %s%d from KVM: %s"
+kvm_failed_vscr_get(const char *msg) "Unable to get VSCR from KVM: %s"
+kvm_failed_vr_get(int vr, const char *msg) "Unable to get VR%d from KVM:=
 %s"
+kvm_failed_vpa_addr_get(const char *msg) "Unable to get VPA address from=
 KVM: %s"
+kvm_failed_slb_get(const char *msg) "Unable to get SLB shadow state from=
 KVM: %s"
+kvm_failed_dtl_get(const char *msg) "Unable to get dispatch trace log st=
ate from KVM: %s"
+kvm_failed_vpa_addr_set(const char *msg) "Unable to set VPA address to K=
VM: %s"
+kvm_failed_slb_set(const char *msg) "Unable to set SLB shadow state to K=
VM: %s"
+kvm_failed_dtl_set(const char *msg) "Unable to set dispatch trace log st=
ate to KVM: %s"
+kvm_failed_null_vpa_addr_set(const char *msg) "Unable to set VPA address=
 to KVM: %s"
+kvm_failed_put_vpa(void) "Warning: Unable to set VPA information to KVM"
+kvm_failed_get_vpa(void) "Warning: Unable to get VPA information from KV=
M"
+kvm_injected_interrupt(int irq) "injected interrupt %d"
+kvm_handle_dcr_write(void) "handle dcr write"
+kvm_handle_drc_read(void) "handle dcr read"
+kvm_handle_halt(void) "handle halt"
+kvm_handle_papr_hcall(void) "handle PAPR hypercall"
+kvm_handle_epr(void) "handle epr"
+kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
+kvm_handle_debug_exception(void) "handle debug exception"
--=20
2.20.1
