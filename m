Received: from eggs.gnu.org ([209.51.188.92]:47646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1hCOeN-0002WV-5r
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1hCOeL-00082s-5z
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:12:55 -0400
From: "Murilo Opsfelder =?utf-8?Q?Ara=C3=BAjo?=" <mopsfelder@gmail.com>
In-Reply-To: <155445152490.302073.17033451726459859333.stgit@bahia.lan>
References: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
	<155445152490.302073.17033451726459859333.stgit@bahia.lan>
Date: Fri, 05 Apr 2019 10:12:42 -0300
Message-ID: <87tvfc8uk5.fsf@kermit.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] target/ppc/kvm: Convert DPRINTF to
 traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Hi, Greg.

Greg Kurz <groug@kaod.org> writes:

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/ppc/kvm.c        |   68 +++++++++++++++++++----------------------------
>  target/ppc/trace-events |   25 +++++++++++++++++
>  2 files changed, 52 insertions(+), 41 deletions(-)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 2427c8ee13ae..3a11d2e1060c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -49,16 +49,6 @@
>  #include "elf.h"
>  #include "sysemu/kvm_int.h"
>
> -//#define DEBUG_KVM
> -
> -#ifdef DEBUG_KVM
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> -#endif
> -
>  #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
>
>  const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
> @@ -626,7 +616,7 @@ static int kvm_put_fp(CPUState *cs)
>          reg.addr = (uintptr_t)&fpscr;
>          ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to set FPSCR to KVM: %s\n", strerror(errno));
> +            trace_kvm_failed_fpscr_set(strerror(errno));
>              return ret;
>          }
>
> @@ -647,8 +637,8 @@ static int kvm_put_fp(CPUState *cs)
>
>              ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>              if (ret < 0) {
> -                DPRINTF("Unable to set %s%d to KVM: %s\n", vsx ? "VSR" : "FPR",
> -                        i, strerror(errno));
> +                trace_kvm_failed_fp_set(vsx ? "VSR" : "FPR", i,
> +                                        strerror(errno));
>                  return ret;
>              }
>          }
> @@ -659,7 +649,7 @@ static int kvm_put_fp(CPUState *cs)
>          reg.addr = (uintptr_t)&env->vscr;
>          ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to set VSCR to KVM: %s\n", strerror(errno));
> +            trace_kvm_failed_vscr_set(strerror(errno));
>              return ret;
>          }
>
> @@ -668,7 +658,7 @@ static int kvm_put_fp(CPUState *cs)
>              reg.addr = (uintptr_t)cpu_avr_ptr(env, i);
>              ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>              if (ret < 0) {
> -                DPRINTF("Unable to set VR%d to KVM: %s\n", i, strerror(errno));
> +                trace_kvm_failed_vr_set(i, strerror(errno));
>                  return ret;
>              }
>          }
> @@ -693,7 +683,7 @@ static int kvm_get_fp(CPUState *cs)
>          reg.addr = (uintptr_t)&fpscr;
>          ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to get FPSCR from KVM: %s\n", strerror(errno));
> +            trace_kvm_failed_fpscr_get(strerror(errno));
>              return ret;
>          } else {
>              env->fpscr = fpscr;
> @@ -709,8 +699,8 @@ static int kvm_get_fp(CPUState *cs)
>
>              ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>              if (ret < 0) {
> -                DPRINTF("Unable to get %s%d from KVM: %s\n",
> -                        vsx ? "VSR" : "FPR", i, strerror(errno));
> +                trace_kvm_failed_fp_get(vsx ? "VSR" : "FPR", i,
> +                                        strerror(errno));
>                  return ret;
>              } else {
>  #ifdef HOST_WORDS_BIGENDIAN
> @@ -733,7 +723,7 @@ static int kvm_get_fp(CPUState *cs)
>          reg.addr = (uintptr_t)&env->vscr;
>          ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to get VSCR from KVM: %s\n", strerror(errno));
> +            trace_kvm_failed_vscr_get(strerror(errno));
>              return ret;
>          }
>
> @@ -742,8 +732,7 @@ static int kvm_get_fp(CPUState *cs)
>              reg.addr = (uintptr_t)cpu_avr_ptr(env, i);
>              ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>              if (ret < 0) {
> -                DPRINTF("Unable to get VR%d from KVM: %s\n",
> -                        i, strerror(errno));
> +                trace_kvm_failed_vr_get(i, strerror(errno));
>                  return ret;
>              }
>          }
> @@ -764,7 +753,7 @@ static int kvm_get_vpa(CPUState *cs)
>      reg.addr = (uintptr_t)&spapr_cpu->vpa_addr;
>      ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>      if (ret < 0) {
> -        DPRINTF("Unable to get VPA address from KVM: %s\n", strerror(errno));
> +        trace_kvm_failed_vpa_addr_get(strerror(errno));
>          return ret;
>      }
>
> @@ -774,8 +763,7 @@ static int kvm_get_vpa(CPUState *cs)
>      reg.addr = (uintptr_t)&spapr_cpu->slb_shadow_addr;
>      ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>      if (ret < 0) {
> -        DPRINTF("Unable to get SLB shadow state from KVM: %s\n",
> -                strerror(errno));
> +        trace_kvm_failed_slb_get(strerror(errno));
>          return ret;
>      }
>
> @@ -785,8 +773,7 @@ static int kvm_get_vpa(CPUState *cs)
>      reg.addr = (uintptr_t)&spapr_cpu->dtl_addr;
>      ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>      if (ret < 0) {
> -        DPRINTF("Unable to get dispatch trace log state from KVM: %s\n",
> -                strerror(errno));
> +        trace_kvm_failed_dtl_get(strerror(errno));
>          return ret;
>      }
>
> @@ -812,7 +799,7 @@ static int kvm_put_vpa(CPUState *cs)
>          reg.addr = (uintptr_t)&spapr_cpu->vpa_addr;
>          ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(errno));
> +            trace_kvm_failed_vpa_addr_set(strerror(errno));
>              return ret;
>          }
>      }
> @@ -823,7 +810,7 @@ static int kvm_put_vpa(CPUState *cs)
>      reg.addr = (uintptr_t)&spapr_cpu->slb_shadow_addr;
>      ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>      if (ret < 0) {
> -        DPRINTF("Unable to set SLB shadow state to KVM: %s\n", strerror(errno));
> +        trace_kvm_failed_slb_set(strerror(errno));
>          return ret;
>      }
>
> @@ -833,8 +820,7 @@ static int kvm_put_vpa(CPUState *cs)
>      reg.addr = (uintptr_t)&spapr_cpu->dtl_addr;
>      ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>      if (ret < 0) {
> -        DPRINTF("Unable to set dispatch trace log state to KVM: %s\n",
> -                strerror(errno));
> +        trace_kvm_failed_dtl_set(strerror(errno));
>          return ret;
>      }
>
> @@ -843,7 +829,7 @@ static int kvm_put_vpa(CPUState *cs)
>          reg.addr = (uintptr_t)&spapr_cpu->vpa_addr;
>          ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(errno));
> +            trace_kvm_failed_null_vpa_addr_set(strerror(errno));
>              return ret;
>          }
>      }
> @@ -996,7 +982,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>
>          if (cap_papr) {
>              if (kvm_put_vpa(cs) < 0) {
> -                DPRINTF("Warning: Unable to set VPA information to KVM\n");
> +                trace_kvm_failed_put_vpa();
>              }
>          }
>
> @@ -1296,7 +1282,7 @@ int kvm_arch_get_registers(CPUState *cs)
>
>          if (cap_papr) {
>              if (kvm_get_vpa(cs) < 0) {
> -                DPRINTF("Warning: Unable to get VPA information from KVM\n");
> +                trace_kvm_failed_get_vpa();
>              }
>          }
>
> @@ -1352,7 +1338,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
>           */
>          irq = KVM_INTERRUPT_SET;
>
> -        DPRINTF("injected interrupt %d\n", irq);
> +        trace_kvm_injected_interrupt(irq);
>          r = kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &irq);
>          if (r < 0) {
>              printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
> @@ -1697,20 +1683,20 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>      switch (run->exit_reason) {
>      case KVM_EXIT_DCR:
>          if (run->dcr.is_write) {
> -            DPRINTF("handle dcr write\n");
> +            trace_kvm_handle_dcr_write();
>              ret = kvmppc_handle_dcr_write(env, run->dcr.dcrn, run->dcr.data);
>          } else {
> -            DPRINTF("handle dcr read\n");
> +            trace_kvm_handle_drc_read();
>              ret = kvmppc_handle_dcr_read(env, run->dcr.dcrn, &run->dcr.data);
>          }
>          break;
>      case KVM_EXIT_HLT:
> -        DPRINTF("handle halt\n");
> +        trace_kvm_handle_halt();
>          ret = kvmppc_handle_halt(cpu);
>          break;
>  #if defined(TARGET_PPC64)
>      case KVM_EXIT_PAPR_HCALL:
> -        DPRINTF("handle PAPR hypercall\n");
> +        trace_kvm_handle_papr_hcall();
>          run->papr_hcall.ret = spapr_hypercall(cpu,
>                                                run->papr_hcall.nr,
>                                                run->papr_hcall.args);
> @@ -1718,18 +1704,18 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>          break;
>  #endif
>      case KVM_EXIT_EPR:
> -        DPRINTF("handle epr\n");
> +        trace_kvm_handle_epr();
>          run->epr.epr = ldl_phys(cs->as, env->mpic_iack);
>          ret = 0;
>          break;
>      case KVM_EXIT_WATCHDOG:
> -        DPRINTF("handle watchdog expiry\n");
> +        trace_kvm_handle_watchdog_expiry();
>          watchdog_perform_action();
>          ret = 0;
>          break;
>
>      case KVM_EXIT_DEBUG:
> -        DPRINTF("handle debug exception\n");
> +        trace_kvm_handle_debug_exception();
>          if (kvm_handle_debug(cpu, run)) {
>              ret = EXCP_DEBUG;
>              break;
> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
> index ed4d57c6d9c1..7b3cfe11fdfe 100644
> --- a/target/ppc/trace-events
> +++ b/target/ppc/trace-events
> @@ -3,3 +3,28 @@
>  # kvm.c
>  kvm_failed_spr_set(int spr, const char *msg) "Warning: Unable to set SPR %d to KVM: %s"
>  kvm_failed_spr_get(int spr, const char *msg) "Warning: Unable to retrieve SPR %d from KVM: %s"
> +kvm_failed_fpscr_set(const char *msg) "Unable to set FPSCR to KVM: %s"
> +kvm_failed_fp_set(const char *fpname, int fpnum, const char *msg) "Unable to set %s%d to KVM: %s"
> +kvm_failed_vscr_set(const char *msg) "Unable to set VSCR to KVM: %s"
> +kvm_failed_vr_set(int vr, const char *msg) "Unable to set VR%d to KVM: %s"
> +kvm_failed_fpscr_get(const char *msg) "Unable to get FPSCR from KVM: %s"
> +kvm_failed_fp_get(const char *fpname, int fpnum, const char *msg) "Unable to get %s%d from KVM: %s"
> +kvm_failed_vscr_get(const char *msg) "Unable to get VSCR from KVM: %s"
> +kvm_failed_vr_get(int vr, const char *msg) "Unable to get VR%d from KVM: %s"
> +kvm_failed_vpa_addr_get(const char *msg) "Unable to get VPA address from KVM: %s"
> +kvm_failed_slb_get(const char *msg) "Unable to get SLB shadow state from KVM: %s"
> +kvm_failed_dtl_get(const char *msg) "Unable to get dispatch trace log state from KVM: %s"
> +kvm_failed_vpa_addr_set(const char *msg) "Unable to set VPA address to KVM: %s"
> +kvm_failed_slb_set(const char *msg) "Unable to set SLB shadow state to KVM: %s"
> +kvm_failed_dtl_set(const char *msg) "Unable to set dispatch trace log state to KVM: %s"
> +kvm_failed_null_vpa_addr_set(const char *msg) "Unable to set VPA address to KVM: %s"
> +kvm_failed_put_vpa(void) "Warning: Unable to set VPA information to KVM"
> +kvm_failed_get_vpa(void) "Warning: Unable to get VPA information from KVM"

Some messages have "Warning:" and some don't.

Since these traces indicate some kind of failure, do you think adding
the warning prefix would be welcome?  Having it also facilitates when
searching logs.

Murilo

> +kvm_injected_interrupt(int irq) "injected interrupt %d"
> +kvm_handle_dcr_write(void) "handle dcr write"
> +kvm_handle_drc_read(void) "handle dcr read"
> +kvm_handle_halt(void) "handle halt"
> +kvm_handle_papr_hcall(void) "handle PAPR hypercall"
> +kvm_handle_epr(void) "handle epr"
> +kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
> +kvm_handle_debug_exception(void) "handle debug exception"
