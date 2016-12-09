Received: from eggs.gnu.org ([2001:4830:134:3::10]:60544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cFOei-0006wE-Ig
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cFOeb-0002nd-RY
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:08:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56180
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cFOeb-0002nN-NA
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:08:13 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB9H3Vk4005775
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 12:08:13 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277ymjku5v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 12:08:12 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 9 Dec 2016 10:08:12 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20161209022314.14399-3-david@gibson.dropbear.id.au>
References: <20161209022314.14399-1-david@gibson.dropbear.id.au>
	<20161209022314.14399-3-david@gibson.dropbear.id.au>
Date: Fri, 09 Dec 2016 11:08:02 -0600
Message-Id: <20161209170802.3613.88250@loki>
Subject: Re: [Qemu-devel] [for-2.9 2/5] pseries: Stubs for HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org, sjitindarsingh@gmail.com
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com

Quoting David Gibson (2016-12-08 20:23:11)
> This introduces stub implementations of the H_RESIZE_HPT_PREPARE and
> H_RESIZE_HPT_COMMIT hypercalls which we hope to add in a PAPR
> extension to allow run time resizing of a guest's hash page table.  It
> also adds a new machine property for controlling whether this new
> facility is available, and logic to check that against availability
> with KVM (only supported with KVM PR for now).
> =

> Finally, it adds a new string to the hypertas property in the device
> tree, advertising to the guest the availability of the HPT resizing
> hypercalls.  This is a tentative suggested value, and would need to be
> standardized by PAPR before being merged.
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/spapr_hcall.c   | 36 +++++++++++++++++++++++++++
>  hw/ppc/trace-events    |  2 ++
>  include/hw/ppc/spapr.h | 11 +++++++++
>  target-ppc/kvm.c       | 26 ++++++++++++++++++++
>  target-ppc/kvm_ppc.h   |  5 ++++
>  6 files changed, 146 insertions(+)
> =

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0f25e83..ecb0822 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -760,6 +760,11 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, =
void *fdt)
>      if (!kvm_enabled() || kvmppc_spapr_use_multitce()) {
>          add_str(hypertas, "hcall-multi-tce");
>      }
> +
> +    if (spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DISABLED) {
> +        add_str(hypertas, "hcall-hpt-resize");
> +    }
> +
>      _FDT(fdt_setprop(fdt, rtas, "ibm,hypertas-functions",
>                       hypertas->str, hypertas->len));
>      g_string_free(hypertas, TRUE);
> @@ -1839,11 +1844,31 @@ static void ppc_spapr_init(MachineState *machine)
>      long load_limit, fw_size;
>      char *filename;
>      int smt =3D kvmppc_smt_threads();
> +    Error *resize_hpt_err =3D NULL;
> =

>      msi_nonbroken =3D true;
> =

>      QLIST_INIT(&spapr->phbs);
> =

> +    /* Check HPT resizing availability */
> +    kvmppc_check_papr_resize_hpt(&resize_hpt_err);
> +    if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DEFAULT) {
> +        if (resize_hpt_err) {
> +            spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DISABLED;
> +            error_free(resize_hpt_err);
> +            resize_hpt_err =3D NULL;
> +        } else {
> +            spapr->resize_hpt =3D smc->resize_hpt_default;
> +        }
> +    }
> +
> +    assert(spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DEFAULT);
> +
> +    if ((spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DISABLED) && resize_hpt=
_err) {
> +        error_report_err(resize_hpt_err);
> +        exit(1);
> +    }

I'm also a bit confused by this. Aren't semantics that HPT_ENABLED will all=
ow
a fallback to non-resizable HPTs if the feature isn't available (whereas
HPT_REQUIRED won't)? I don't understand how such a fallback can ever be rea=
ched
with this check in place.

> +
>      /* Allocate RMA if necessary */
>      rma_alloc_size =3D kvmppc_alloc_rma(&rma);
> =

> @@ -2236,6 +2261,40 @@ static void spapr_set_modern_hotplug_events(Object=
 *obj, bool value,
>      spapr->use_hotplug_event_source =3D value;
>  }
> =

> +static char *spapr_get_resize_hpt(Object *obj, Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    switch (spapr->resize_hpt) {
> +    case SPAPR_RESIZE_HPT_DEFAULT:
> +        return g_strdup("default");
> +    case SPAPR_RESIZE_HPT_DISABLED:
> +        return g_strdup("disabled");
> +    case SPAPR_RESIZE_HPT_ENABLED:
> +        return g_strdup("enabled");
> +    case SPAPR_RESIZE_HPT_REQUIRED:
> +        return g_strdup("required");
> +    }
> +    assert(0);
> +}
> +
> +static void spapr_set_resize_hpt(Object *obj, const char *value, Error *=
*errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    if (strcmp(value, "default") =3D=3D 0) {
> +        spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DEFAULT;
> +    } else if (strcmp(value, "disabled") =3D=3D 0) {
> +        spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DISABLED;
> +    } else if (strcmp(value, "enabled") =3D=3D 0) {
> +        spapr->resize_hpt =3D SPAPR_RESIZE_HPT_ENABLED;
> +    } else if (strcmp(value, "required") =3D=3D 0) {
> +        spapr->resize_hpt =3D SPAPR_RESIZE_HPT_REQUIRED;
> +    } else {
> +        error_setg(errp, "Bad value for \"resize-hpt\" property");
> +    }
> +}
> +
>  static void spapr_machine_initfn(Object *obj)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> @@ -2256,6 +2315,12 @@ static void spapr_machine_initfn(Object *obj)
>                                      " place of standard EPOW events when=
 possible"
>                                      " (required for memory hot-unplug su=
pport)",
>                                      NULL);
> +
> +    object_property_add_str(obj, "resize-hpt",
> +                            spapr_get_resize_hpt, spapr_set_resize_hpt, =
NULL);
> +    object_property_set_description(obj, "resize-hpt",
> +                                    "Resizing of the Hash Page Table (en=
abled, disabled, required)",
> +                                    NULL);
>  }
> =

>  static void spapr_machine_finalizefn(Object *obj)
> @@ -2707,6 +2772,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
> =

>      smc->dr_lmb_enabled =3D true;
>      smc->tcg_default_cpu =3D "POWER8";
> +    smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_DISABLED;
>      mc->query_hotpluggable_cpus =3D spapr_query_hotpluggable_cpus;
>      fwc->get_dev_path =3D spapr_get_fw_dev_path;
>      nc->nmi_monitor_handler =3D spapr_nmi;
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index fd9f1d4..72a9c4d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -355,6 +355,38 @@ static target_ulong h_read(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
>      return H_SUCCESS;
>  }
> =

> +static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
> +                                         sPAPRMachineState *spapr,
> +                                         target_ulong opcode,
> +                                         target_ulong *args)
> +{
> +    target_ulong flags =3D args[0];
> +    target_ulong shift =3D args[1];
> +
> +    if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> +        return H_AUTHORITY;
> +    }
> +
> +    trace_spapr_h_resize_hpt_prepare(flags, shift);
> +    return H_HARDWARE;
> +}
> +
> +static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
> +                                        sPAPRMachineState *spapr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
> +    target_ulong flags =3D args[0];
> +    target_ulong shift =3D args[1];
> +
> +    if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> +        return H_AUTHORITY;
> +    }
> +
> +    trace_spapr_h_resize_hpt_commit(flags, shift);
> +    return H_HARDWARE;
> +}
> +
>  static target_ulong h_set_sprg0(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
>                                  target_ulong opcode, target_ulong *args)
>  {
> @@ -1134,6 +1166,10 @@ static void hypercall_register_types(void)
>      /* hcall-bulk */
>      spapr_register_hypercall(H_BULK_REMOVE, h_bulk_remove);
> =

> +    /* hcall-hpt-resize */
> +    spapr_register_hypercall(H_RESIZE_HPT_PREPARE, h_resize_hpt_prepare);
> +    spapr_register_hypercall(H_RESIZE_HPT_COMMIT, h_resize_hpt_commit);
> +
>      /* hcall-splpar */
>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>      spapr_register_hypercall(H_CEDE, h_cede);
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 2297ead..bf59a8f 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -16,6 +16,8 @@ spapr_cas_continue(unsigned long n) "Copy changes to th=
e guest: %ld bytes"
>  # hw/ppc/spapr_hcall.c
>  spapr_cas_pvr_try(uint32_t pvr) "%x"
>  spapr_cas_pvr(uint32_t cur_pvr, bool cpu_match, uint32_t new_pvr, uint64=
_t pcr) "current=3D%x, cpu_match=3D%u, new=3D%x, compat flags=3D%"PRIx64
> +spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=3D0x%"=
PRIx64", shift=3D%"PRIu64
> +spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=3D0x%"P=
RIx64", shift=3D%"PRIu64
> =

>  # hw/ppc/spapr_iommu.c
>  spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t re=
t) "liobn=3D%"PRIx64" ioba=3D0x%"PRIx64" tce=3D0x%"PRIx64" ret=3D%"PRId64
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a2d8964..d2c758b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -31,6 +31,13 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>  #define SPAPR_MACHINE_CLASS(klass) \
>      OBJECT_CLASS_CHECK(sPAPRMachineClass, klass, TYPE_SPAPR_MACHINE)
> =

> +typedef enum {
> +    SPAPR_RESIZE_HPT_DEFAULT =3D 0,
> +    SPAPR_RESIZE_HPT_DISABLED,
> +    SPAPR_RESIZE_HPT_ENABLED,
> +    SPAPR_RESIZE_HPT_REQUIRED,
> +} sPAPRResizeHPT;
> +
>  /**
>   * sPAPRMachineClass:
>   */
> @@ -46,6 +53,7 @@ struct sPAPRMachineClass {
>                            uint64_t *buid, hwaddr *pio, =

>                            hwaddr *mmio32, hwaddr *mmio64,
>                            unsigned n_dma, uint32_t *liobns, Error **errp=
);
> +    sPAPRResizeHPT resize_hpt_default;
>  };
> =

>  /**
> @@ -61,6 +69,7 @@ struct sPAPRMachineState {
>      XICSState *xics;
>      DeviceState *rtc;
> =

> +    sPAPRResizeHPT resize_hpt;
>      void *htab;
>      uint32_t htab_shift;
>      hwaddr rma_size;
> @@ -347,6 +356,8 @@ struct sPAPRMachineState {
>  #define H_XIRR_X                0x2FC
>  #define H_RANDOM                0x300
>  #define H_SET_MODE              0x31C
> +#define H_RESIZE_HPT_PREPARE    0x36C
> +#define H_RESIZE_HPT_COMMIT     0x370
>  #define H_SIGNAL_SYS_RESET      0x380
>  #define MAX_HCALL_OPCODE        H_SIGNAL_SYS_RESET
> =

> diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
> index 15e12f3..dcd8cef 100644
> --- a/target-ppc/kvm.c
> +++ b/target-ppc/kvm.c
> @@ -22,6 +22,7 @@
>  #include <linux/kvm.h>
> =

>  #include "qemu-common.h"
> +#include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "qemu/timer.h"
> @@ -2269,6 +2270,7 @@ int kvmppc_reset_htab(int shift_hint)
>          /* Full emulation, tell caller to allocate htab itself */
>          return 0;
>      }
> +
>      if (kvm_check_extension(kvm_state, KVM_CAP_PPC_ALLOC_HTAB)) {
>          int ret;
>          ret =3D kvm_vm_ioctl(kvm_state, KVM_PPC_ALLOCATE_HTAB, &shift);
> @@ -2672,3 +2674,27 @@ int kvmppc_enable_hwrng(void)
> =

>      return kvmppc_enable_hcall(kvm_state, H_RANDOM);
>  }
> +
> +void kvmppc_check_papr_resize_hpt(Error **errp)
> +{
> +    if (!kvm_enabled()) {
> +        return;
> +    }
> +
> +    /* TODO: Check specific capabilities for HPT resize aware host kerne=
ls */
> +
> +    /*
> +     * It's tempting to try to check directly if the HPT is under our
> +     * control or KVM's, which is what's really relevant here.
> +     * Unfortunately, in order to correctly size the HPT, we need to
> +     * know if we can do resizing, _before_ we attempt to allocate it
> +     * with KVM.  Before that point, we don't officially know whether
> +     * we'll control the HPT or not.  So we have to use a fallback
> +     * test for PR vs HV KVM to predict that.
> +     */
> +    if (kvmppc_is_pr(kvm_state)) {
> +        return;
> +    }
> +
> +    error_setg(errp, "Hash page table resizing not available with this K=
VM version");
> +}
> diff --git a/target-ppc/kvm_ppc.h b/target-ppc/kvm_ppc.h
> index 841a29b..3e852ba 100644
> --- a/target-ppc/kvm_ppc.h
> +++ b/target-ppc/kvm_ppc.h
> @@ -59,6 +59,7 @@ bool kvmppc_has_cap_htm(void);
>  int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> +void kvmppc_check_papr_resize_hpt(Error **errp);
> =

>  #else
> =

> @@ -270,6 +271,10 @@ static inline PowerPCCPUClass *kvm_ppc_get_host_cpu_=
class(void)
>      return NULL;
>  }
> =

> +static inline void kvmppc_check_papr_resize_hpt(Error **errp)
> +{
> +    return;
> +}
>  #endif
> =

>  #ifndef CONFIG_KVM
> -- =

> 2.9.3
>=20
