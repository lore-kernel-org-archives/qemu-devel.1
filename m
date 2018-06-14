Received: from eggs.gnu.org ([2001:4830:134:3::10]:48067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTSOx-0002DF-Ds
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTSOu-0008Mn-5y
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:34:59 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:43211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTSOt-0008Lf-Qd
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:34:56 -0400
Received: from player787.ha.ovh.net (unknown [10.109.108.95])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 854EB1C1140
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 15:34:52 +0200 (CEST)
Date: Thu, 14 Jun 2018 15:34:43 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180614153443.42951304@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180614044129.13606-7-david@gibson.dropbear.id.au>
References: <20180614044129.13606-1-david@gibson.dropbear.id.au>
	<20180614044129.13606-7-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3 6/7] target/ppc: Replace intc pointer
 with a general machine_data pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Thu, 14 Jun 2018 14:41:28 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> PowerPCCPU contains an (Object *)intc used to point to the cpu's interrupt
> controller.  Or more precisely to the "presentation" component of the
> interrupt controller relevant to this cpu.
> 
> Really, this field is machine specific.  The machines which use it can
> point it to different types of object depending on their needs, and most
> machines don't use it at all (since they have older style PICs which don't
> have per-cpu presentation components).
> 
> There's also other information that's per-cpu, but platform/machine
> specific.  So replace the intc pointer with a (void *)machine_data which
> can be managed as the machine type likes to conveniently store per cpu
> information.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---

Ouch... I am having some concerns with this patch now.

First, I gave a try to CPU hotplug with the full series applied. It
causes QEMU to crash:

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffee3feaa0 (LWP 23290)]
kvm_arch_put_registers (cs=0x11497fd0, level=<optimized out>) at /home/greg/Work/qemu/qemu-spapr/target/ppc/kvm.c:1068
1068                if (kvm_put_vpa(cs) < 0) {
(gdb) p ((PowerPCCPU *)cs)->machine_data
$1 = (void *) 0x0
(gdb) thread apply all bt

Thread 6 (Thread 0x7fffee3feaa0 (LWP 23290)):
#0  kvm_arch_put_registers (cs=0x11497fd0, level=<optimized out>) at /home/greg/Work/qemu/qemu-spapr/target/ppc/kvm.c:1068
#1  0x00000000100b3a18 in do_kvm_cpu_synchronize_post_init (cpu=<optimized out>, arg=...) at /home/greg/Work/qemu/qemu-spapr/accel/kvm/kvm-all.c:1817
#2  0x00000000102c2d18 in process_queued_cpu_work (cpu=<optimized out>) at /home/greg/Work/qemu/qemu-spapr/cpus-common.c:342
#3  0x0000000010081e88 in qemu_wait_io_event_common (cpu=0x11497fd0) at /home/greg/Work/qemu/qemu-spapr/cpus.c:1158
#4  0x0000000010081f38 in qemu_wait_io_event (cpu=0x11497fd0) at /home/greg/Work/qemu/qemu-spapr/cpus.c:1185
#5  0x0000000010084248 in qemu_kvm_cpu_thread_fn (arg=0x11497fd0) at /home/greg/Work/qemu/qemu-spapr/cpus.c:1220
#6  0x0000000010608cb0 in qemu_thread_start (args=0x10eb0510) at /home/greg/Work/qemu/qemu-spapr/util/qemu-thread-posix.c:507
#7  0x00007ffff2758af4 in start_thread () from /lib64/libpthread.so.0
#8  0x00007ffff2688814 in clone () from /lib64/libc.so.6

[...]

Thread 1 (Thread 0x7ffff0ee2650 (LWP 23234)):
#0  0x00007ffff275e72c in pthread_cond_wait@@GLIBC_2.17 () from /lib64/libpthread.so.0
#1  0x00000000106095d0 in qemu_cond_wait_impl (cond=0x10cf7028 <qemu_work_cond>, mutex=0x10cd4d60 <qemu_global_mutex>, file=0x107b2ea8 "/home/greg/Work/qemu/qemu-spapr/cpus-common.c", line=<optimized out>) at /home/greg/Work/qemu/qemu-spapr/util/qemu-thread-posix.c:164
#2  0x00000000102c23d8 in do_run_on_cpu (cpu=<optimized out>, func=<optimized out>, data=..., mutex=0x10cd4d60 <qemu_global_mutex>) at /home/greg/Work/qemu/qemu-spapr/cpus-common.c:152
#3  0x0000000010083cb0 in run_on_cpu (cpu=<optimized out>, func=<optimized out>, data=...) at /home/greg/Work/qemu/qemu-spapr/cpus.c:1126
#4  0x00000000100b4bc4 in kvm_cpu_synchronize_post_init (cpu=<optimized out>) at /home/greg/Work/qemu/qemu-spapr/accel/kvm/kvm-all.c:1823
#5  0x000000001047dbe8 in cpu_synchronize_post_init (cpu=0x11497fd0) at /home/greg/Work/qemu/qemu-spapr/include/sysemu/hw_accel.h:48
#6  cpu_common_realizefn (dev=0x11497fd0, errp=<optimized out>) at /home/greg/Work/qemu/qemu-spapr/qom/cpu.c:347
#7  0x00000000101aded4 in ppc_cpu_realize (dev=0x11497fd0, errp=0x7fffffffce50) at /home/greg/Work/qemu/qemu-spapr/target/ppc/translate_init.inc.c:9695
#8  0x0000000010326410 in device_set_realized (obj=0x11497fd0, value=<optimized out>, errp=0x7fffffffd080) at /home/greg/Work/qemu/qemu-spapr/hw/core/qdev.c:826
#9  0x00000000104c6ae0 in property_set_bool (obj=0x11497fd0, v=<optimized out>, name=<optimized out>, opaque=0x1182a120, errp=0x7fffffffd080) at /home/greg/Work/qemu/qemu-spapr/qom/object.c:1930
#10 0x00000000104c9838 in object_property_set (obj=0x11497fd0, v=0x119a0e20, name=0x1074fd90 "realized", errp=0x7fffffffd080) at /home/greg/Work/qemu/qemu-spapr/qom/object.c:1122
#11 0x00000000104ccd6c in object_property_set_qobject (obj=0x11497fd0, value=<optimized out>, name=<optimized out>, errp=<optimized out>) at /home/greg/Work/qemu/qemu-spapr/qom/qom-qobject.c:27
#12 0x00000000104c9b00 in object_property_set_bool (obj=0x11497fd0, value=<optimized out>, name=<optimized out>, errp=<optimized out>) at /home/greg/Work/qemu/qemu-spapr/qom/object.c:1188
#13 0x0000000010168500 in spapr_realize_vcpu (errp=0x7fffffffd078, spapr=<optimized out>, cpu=0x11497fd0) at /home/greg/Work/qemu/qemu-spapr/hw/ppc/spapr_cpu_core.c:143

This happens when the core CPU realization code decides to copy the full
set of registers to KVM, but the machine_data pointer is still NULL.

So I think the fix belongs to this patch, see below.

>  hw/intc/xics.c                  |  5 +++--
>  hw/intc/xics_spapr.c            | 16 +++++++++++-----
>  hw/ppc/pnv.c                    |  4 ++--
>  hw/ppc/pnv_core.c               | 11 +++++++++--
>  hw/ppc/spapr.c                  |  8 ++++----
>  hw/ppc/spapr_cpu_core.c         | 13 ++++++++++---
>  include/hw/ppc/pnv_core.h       |  9 +++++++++
>  include/hw/ppc/spapr_cpu_core.h | 10 ++++++++++
>  include/hw/ppc/xics.h           |  4 ++--
>  target/ppc/cpu.h                |  2 +-
>  10 files changed, 61 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index e73e623e3b..689ad44e5f 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -383,7 +383,8 @@ static const TypeInfo icp_info = {
>      .class_size = sizeof(ICPStateClass),
>  };
>  
> -Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
> +ICPState *icp_create(Object *cpu, const char *type, XICSFabric *xi,
> +                     Error **errp)
>  {
>      Error *local_err = NULL;
>      Object *obj;
> @@ -401,7 +402,7 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
>          obj = NULL;
>      }
>  
> -    return obj;
> +    return ICP(obj);
>  }
>  
>  /*
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 2e27b92b87..01c76717cf 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -31,6 +31,7 @@
>  #include "trace.h"
>  #include "qemu/timer.h"
>  #include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/xics.h"
>  #include "hw/ppc/fdt.h"
>  #include "qapi/visitor.h"
> @@ -43,8 +44,9 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
>      target_ulong cppr = args[0];
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
>  
> -    icp_set_cppr(ICP(cpu->intc), cppr);
> +    icp_set_cppr(spapr_cpu->icp, cppr);
>      return H_SUCCESS;
>  }
>  
> @@ -65,7 +67,8 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>  static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
> -    uint32_t xirr = icp_accept(ICP(cpu->intc));
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
> +    uint32_t xirr = icp_accept(spapr_cpu->icp);
>  
>      args[0] = xirr;
>      return H_SUCCESS;
> @@ -74,7 +77,8 @@ static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>  static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                               target_ulong opcode, target_ulong *args)
>  {
> -    uint32_t xirr = icp_accept(ICP(cpu->intc));
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
> +    uint32_t xirr = icp_accept(spapr_cpu->icp);
>  
>      args[0] = xirr;
>      args[1] = cpu_get_host_ticks();
> @@ -84,9 +88,10 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>  static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                            target_ulong opcode, target_ulong *args)
>  {
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
>      target_ulong xirr = args[0];
>  
> -    icp_eoi(ICP(cpu->intc), xirr);
> +    icp_eoi(spapr_cpu->icp, xirr);
>      return H_SUCCESS;
>  }
>  
> @@ -94,7 +99,8 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                              target_ulong opcode, target_ulong *args)
>  {
>      uint32_t mfrr;
> -    uint32_t xirr = icp_ipoll(ICP(cpu->intc), &mfrr);
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
> +    uint32_t xirr = icp_ipoll(spapr_cpu->icp, &mfrr);
>  
>      args[0] = xirr;
>      args[1] = mfrr;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0b9508d94d..3a36c6ac6a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1013,7 +1013,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
>  {
>      PowerPCCPU *cpu = ppc_get_vcpu_by_pir(pir);
>  
> -    return cpu ? ICP(cpu->intc) : NULL;
> +    return cpu ? pnv_cpu_state(cpu)->icp : NULL;
>  }
>  
>  static void pnv_pic_print_info(InterruptStatsProvider *obj,
> @@ -1026,7 +1026,7 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj,
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
>  
> -        icp_pic_print_info(ICP(cpu->intc), mon);
> +        icp_pic_print_info(pnv_cpu_state(cpu)->icp, mon);
>      }
>  
>      for (i = 0; i < pnv->num_chips; i++) {
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index f7cf33f547..746bc5c2c5 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -105,6 +105,7 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSFabric *xi, Error **errp)
>      int core_pir;
>      int thread_index = 0; /* TODO: TCG supports only one thread */
>      ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
> +    PnvCPUState *pnv_cpu;
>      Error *local_err = NULL;
>  
>      object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
> @@ -113,7 +114,9 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, XICSFabric *xi, Error **errp)
>          return;
>      }
>  
> -    cpu->intc = icp_create(OBJECT(cpu), TYPE_PNV_ICP, xi, &local_err);
> +    cpu->machine_data = pnv_cpu = g_new0(PnvCPUState, 1);
> +
> +    pnv_cpu->icp = icp_create(OBJECT(cpu), TYPE_PNV_ICP, xi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -188,8 +191,12 @@ err:
>  
>  static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
>  {
> +    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
> +
>      qemu_unregister_reset(pnv_cpu_reset, cpu);
> -    object_unparent(cpu->intc);
> +    object_unparent(OBJECT(pnv_cpu->icp));
> +    cpu->machine_data = NULL;
> +    g_free(pnv_cpu);
>      cpu_remove_sync(CPU(cpu));
>      object_unparent(OBJECT(cpu));
>  }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f59999daac..cbab6b6b7e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1745,8 +1745,8 @@ static int spapr_post_load(void *opaque, int version_id)
>      if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
>          CPUState *cs;
>          CPU_FOREACH(cs) {
> -            PowerPCCPU *cpu = POWERPC_CPU(cs);
> -            icp_resend(ICP(cpu->intc));
> +            sPAPRCPUState *spapr_cpu = spapr_cpu_state(POWERPC_CPU(cs));
> +            icp_resend(spapr_cpu->icp);
>          }
>      }
>  
> @@ -3783,7 +3783,7 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int vcpu_id)
>  {
>      PowerPCCPU *cpu = spapr_find_cpu(vcpu_id);
>  
> -    return cpu ? ICP(cpu->intc) : NULL;
> +    return cpu ? spapr_cpu_state(cpu)->icp : NULL;
>  }
>  
>  #define ICS_IRQ_FREE(ics, srcno)   \
> @@ -3925,7 +3925,7 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj,
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
>  
> -        icp_pic_print_info(ICP(cpu->intc), mon);
> +        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
>      }
>  
>      ics_pic_print_info(spapr->ics, mon);
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 7fdb3b6667..544bda93e2 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -104,8 +104,12 @@ const char *spapr_get_cpu_core_type(const char *cpu_type)
>  
>  static void spapr_unrealize_vcpu(PowerPCCPU *cpu)
>  {
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
> +
>      qemu_unregister_reset(spapr_cpu_reset, cpu);
> -    object_unparent(cpu->intc);
> +    object_unparent(OBJECT(spapr_cpu->icp));
> +    cpu->machine_data = NULL;
> +    g_free(spapr_cpu);
>      cpu_remove_sync(CPU(cpu));
>      object_unparent(OBJECT(cpu));
>  }
> @@ -127,12 +131,15 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>  {
>      CPUPPCState *env = &cpu->env;
>      Error *local_err = NULL;
> +    sPAPRCPUState *spapr_cpu;
>  
>      object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
>      if (local_err) {
>          goto error;
>      }
>  
> +    spapr_cpu = cpu->machine_data = g_new0(sPAPRCPUState, 1);
> +

machine_data is a cpu attribute and all users of spapr_cpu_state() assume it
is always valid. It should be set before any code tries to dereference it,
which I believe cannot happen before the call to object_property_set_bool().
So I guess setting it at the beginning of the function should be fine (at
least, it fixes the crash).


And now, looking at the function again, I realize it doesn't do any rollback
in case of error... and spapr_cpu_core_realize() doesn't care to rollback
already realized CPUs either, but it will happily free all them :)

Simulating a failure in icp_create() during CPU hotplug instantly crashes
QEMU:

(qemu) device_add host-spapr-cpu-core,core-id=1,id=gku
GKU: failing icp_create (cpu 0x11497fd0)

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffee3feaa0 (LWP 24725)]
0x00000000104c8374 in object_dynamic_cast_assert (obj=0x11497fd0, typename=0x107904a0 "powerpc64-cpu", file=0x1079a1b0 "/home/greg/Work/qemu/qemu-spapr/target/ppc/kvm.c", line=658, func=0x10799c80 <__func__.31720> "kvm_put_one_spr") at /home/greg/Work/qemu/qemu-spapr/qom/object.c:623
623         trace_object_dynamic_cast_assert(obj ? obj->class->type->name : "(null)",
(gdb) p obj->class->type
$1 = (Type) 0x0
(gdb) p * obj
$2 = {class = 0x10ea9c10, free = 0x11244620, properties = 0x0, ref = 0, parent = 0x0}

obj is a dangling pointer to the CPU that was just destroyed in spapr_cpu_core_realize().

This is a long standing issue actually, not related to this patch. But your cleanup
helped to uncover it. I'll send patches soon.

>      /* Set time-base frequency to 512 MHz */
>      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
>  
> @@ -142,8 +149,8 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>      qemu_register_reset(spapr_cpu_reset, cpu);
>      spapr_cpu_reset(cpu);
>  
> -    cpu->intc = icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(spapr),
> -                           &local_err);
> +    spapr_cpu->icp = icp_create(OBJECT(cpu), spapr->icp_type,
> +                                XICS_FABRIC(spapr), &local_err);
>      if (local_err) {
>          goto error;
>      }
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 447ae761f7..f81dff28aa 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -47,4 +47,13 @@ typedef struct PnvCoreClass {
>  #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
>  #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
>  
> +typedef struct PnvCPUState {
> +    ICPState *icp;
> +} PnvCPUState;
> +
> +static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
> +{
> +    return cpu->machine_data;
> +}
> +
>  #endif /* _PPC_PNV_CORE_H */
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index 47dcfda12b..e3d2aa45a4 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -41,4 +41,14 @@ typedef struct sPAPRCPUCoreClass {
>  const char *spapr_get_cpu_core_type(const char *cpu_type);
>  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3);
>  
> +typedef struct ICPState ICPState;
> +typedef struct sPAPRCPUState {
> +    ICPState *icp;
> +} sPAPRCPUState;
> +
> +static inline sPAPRCPUState *spapr_cpu_state(PowerPCCPU *cpu)
> +{
> +    return (sPAPRCPUState *)cpu->machine_data;
> +}
> +
>  #endif
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 6cebff47a7..48930d91e5 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -207,7 +207,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
>  void xics_spapr_init(sPAPRMachineState *spapr);
>  
> -Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
> -                   Error **errp);
> +ICPState *icp_create(Object *cpu, const char *type, XICSFabric *xi,
> +                     Error **errp);
>  
>  #endif /* XICS_H */
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a91f1a8777..abf0bf0224 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1204,7 +1204,7 @@ struct PowerPCCPU {
>      int vcpu_id;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
> -    Object *intc;
> +    void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
>  
