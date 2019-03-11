Received: from eggs.gnu.org ([209.51.188.92]:46580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3NGM-0006QS-LG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3NEq-0007DL-6I
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:53:18 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:44921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h3NEp-0007CZ-S0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:53:16 -0400
Received: from player714.ha.ovh.net (unknown [10.109.146.32])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 52457183D97
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 16:53:13 +0100 (CET)
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-2-clg@kaod.org>
	<20190225055522.GV7668@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <71e3014c-c7e1-f2ca-97d2-5ab98e81f754@kaod.org>
Date: Mon, 11 Mar 2019 16:53:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190225055522.GV7668@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/13] spapr/xive: add KVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/25/19 6:55 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 02:13:10PM +0100, C=E9dric Le Goater wrote:
>> This introduces a set of helpers when KVM is in use, which create the
>> KVM XIVE device, initialize the interrupt sources at a KVM level and
>> connect the interrupt presenters to the vCPU.
>>
>> They also handle the initialization of the TIMA and the source ESB
>> memory regions of the controller. These have a different type under
>> KVM. They are 'ram device' memory mappings, similarly to VFIO, exposed
>> to the guest and the associated VMAs on the host are populated
>> dynamically with the appropriate pages using a fault handler.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  default-configs/ppc64-softmmu.mak |   1 +
>>  include/hw/ppc/spapr_xive.h       |  10 ++
>>  include/hw/ppc/xive.h             |  13 ++
>>  target/ppc/kvm_ppc.h              |   6 +
>>  hw/intc/spapr_xive.c              |  48 +++++-
>>  hw/intc/spapr_xive_kvm.c          | 237 +++++++++++++++++++++++++++++=
+
>>  hw/intc/xive.c                    |  21 ++-
>>  hw/ppc/spapr_irq.c                |   6 +-
>>  target/ppc/kvm.c                  |   7 +
>>  hw/intc/Makefile.objs             |   1 +
>>  10 files changed, 340 insertions(+), 10 deletions(-)
>>  create mode 100644 hw/intc/spapr_xive_kvm.c
>>
>> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64=
-softmmu.mak
>> index 7f34ad0528ed..c1bf5cd951f5 100644
>> --- a/default-configs/ppc64-softmmu.mak
>> +++ b/default-configs/ppc64-softmmu.mak
>> @@ -18,6 +18,7 @@ CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
>>  CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
>>  CONFIG_XIVE=3D$(CONFIG_PSERIES)
>>  CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
>> +CONFIG_XIVE_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
>>  CONFIG_MEM_DEVICE=3Dy
>>  CONFIG_DIMM=3Dy
>>  CONFIG_SPAPR_RNG=3Dy
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 2d31f24e3bfe..ab6732b14a02 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -38,6 +38,10 @@ typedef struct sPAPRXive {
>>      /* TIMA mapping address */
>>      hwaddr        tm_base;
>>      MemoryRegion  tm_mmio;
>> +
>> +    /* KVM support */
>> +    int           fd;
>> +    void          *tm_mmap;
>>  } sPAPRXive;
>> =20
>>  bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
>> @@ -49,5 +53,11 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint32=
_t nr_servers, void *fdt,
>>                     uint32_t phandle);
>>  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>>  void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
>> +void spapr_xive_map_mmio(sPAPRXive *xive);
>> +
>> +/*
>> + * KVM XIVE device helpers
>> + */
>> +void kvmppc_xive_connect(sPAPRXive *xive, Error **errp);
>> =20
>>  #endif /* PPC_SPAPR_XIVE_H */
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 13a487527b11..061d43fea24d 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -140,6 +140,7 @@
>>  #ifndef PPC_XIVE_H
>>  #define PPC_XIVE_H
>> =20
>> +#include "sysemu/kvm.h"
>>  #include "hw/qdev-core.h"
>>  #include "hw/sysbus.h"
>>  #include "hw/ppc/xive_regs.h"
>> @@ -194,6 +195,9 @@ typedef struct XiveSource {
>>      uint32_t        esb_shift;
>>      MemoryRegion    esb_mmio;
>> =20
>> +    /* KVM support */
>> +    void            *esb_mmap;
>> +
>>      XiveNotifier    *xive;
>>  } XiveSource;
>> =20
>> @@ -419,4 +423,13 @@ static inline uint32_t xive_nvt_cam_line(uint8_t =
nvt_blk, uint32_t nvt_idx)
>>      return (nvt_blk << 19) | nvt_idx;
>>  }
>> =20
>> +/*
>> + * KVM XIVE device helpers
>> + */
>> +
>> +void kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error =
**errp);
>> +void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp);
>> +void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
>> +void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
>> +
>>  #endif /* PPC_XIVE_H */
>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
>> index bdfaa4e70a83..d2159660f9f2 100644
>> --- a/target/ppc/kvm_ppc.h
>> +++ b/target/ppc/kvm_ppc.h
>> @@ -59,6 +59,7 @@ bool kvmppc_has_cap_fixup_hcalls(void);
>>  bool kvmppc_has_cap_htm(void);
>>  bool kvmppc_has_cap_mmu_radix(void);
>>  bool kvmppc_has_cap_mmu_hash_v3(void);
>> +bool kvmppc_has_cap_xive(void);
>>  int kvmppc_get_cap_safe_cache(void);
>>  int kvmppc_get_cap_safe_bounds_check(void);
>>  int kvmppc_get_cap_safe_indirect_branch(void);
>> @@ -307,6 +308,11 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(voi=
d)
>>      return false;
>>  }
>> =20
>> +static inline bool kvmppc_has_cap_xive(void)
>> +{
>> +    return false;
>> +}
>> +
>>  static inline int kvmppc_get_cap_safe_cache(void)
>>  {
>>      return 0;
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 06e3c9fdbfeb..c24d649e3668 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -173,7 +173,7 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Mo=
nitor *mon)
>>      }
>>  }
>> =20
>> -static void spapr_xive_map_mmio(sPAPRXive *xive)
>> +void spapr_xive_map_mmio(sPAPRXive *xive)
>>  {
>>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->vc_base);
>>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->end_base);
>> @@ -251,6 +251,9 @@ static void spapr_xive_instance_init(Object *obj)
>>                        TYPE_XIVE_END_SOURCE);
>>      object_property_add_child(obj, "end_source", OBJECT(&xive->end_so=
urce),
>>                                NULL);
>> +
>> +    /* Not connected to the KVM XIVE device */
>> +    xive->fd =3D -1;
>>  }
>> =20
>>  static void spapr_xive_realize(DeviceState *dev, Error **errp)
>> @@ -259,6 +262,7 @@ static void spapr_xive_realize(DeviceState *dev, E=
rror **errp)
>>      XiveSource *xsrc =3D &xive->source;
>>      XiveENDSource *end_xsrc =3D &xive->end_source;
>>      Error *local_err =3D NULL;
>> +    MachineState *machine =3D MACHINE(qdev_get_machine());
>> =20
>>      if (!xive->nr_irqs) {
>>          error_setg(errp, "Number of interrupt needs to be greater 0")=
;
>> @@ -305,6 +309,32 @@ static void spapr_xive_realize(DeviceState *dev, =
Error **errp)
>>      xive->eat =3D g_new0(XiveEAS, xive->nr_irqs);
>>      xive->endt =3D g_new0(XiveEND, xive->nr_ends);
>> =20
>> +    xive->nodename =3D g_strdup_printf("interrupt-controller@%" PRIx6=
4,
>> +                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << =
TM_SHIFT));
>> +
>> +    qemu_register_reset(spapr_xive_reset, dev);
>> +
>> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
>> +        kvmppc_xive_connect(xive, &local_err);
>> +        if (local_err && machine_kernel_irqchip_required(machine)) {
>> +            error_prepend(&local_err,
>> +                          "kernel_irqchip requested but unavailable: =
");
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>> +
>> +        if (!local_err) {
>> +            return;
>> +        }
>> +
>> +        /*
>> +         * We failed to initialize the XIVE KVM device, fallback to
>> +         * emulated mode
>> +         */
>> +        error_prepend(&local_err, "kernel_irqchip allowed but unavail=
able: ");
>> +        error_report_err(local_err);
>=20
> Since we can fall back this should probably just be
> warn_report_err().  Maybe not even that, for the case where the host
> kernel doesn't support KVM XIVE at all.

Let's use a warn_report_err().

Thanks,=20

C.=20

=20
>> +    }
>> +
>>      /* TIMA initialization */
>>      memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops,=
 xive,
>>                            "xive.tima", 4ull << TM_SHIFT);
>> @@ -316,11 +346,6 @@ static void spapr_xive_realize(DeviceState *dev, =
Error **errp)
>> =20
>>      /* Map all regions */
>>      spapr_xive_map_mmio(xive);
>> -
>> -    xive->nodename =3D g_strdup_printf("interrupt-controller@%" PRIx6=
4,
>> -                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << =
TM_SHIFT));
>> -
>> -    qemu_register_reset(spapr_xive_reset, dev);
>>  }
>> =20
>>  static int spapr_xive_get_eas(XiveRouter *xrtr, uint8_t eas_blk,
>> @@ -495,6 +520,17 @@ bool spapr_xive_irq_claim(sPAPRXive *xive, uint32=
_t lisn, bool lsi)
>>      if (lsi) {
>>          xive_source_irq_set_lsi(xsrc, lisn);
>>      }
>> +
>> +    if (kvm_irqchip_in_kernel()) {
>> +        Error *local_err =3D NULL;
>> +
>> +        kvmppc_xive_source_reset_one(xsrc, lisn, &local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            return false;
>> +        }
>> +    }
>> +
>>      return true;
>>  }
>> =20
>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>> new file mode 100644
>> index 000000000000..623fbf74f23e
>> --- /dev/null
>> +++ b/hw/intc/spapr_xive_kvm.c
>> @@ -0,0 +1,237 @@
>> +/*
>> + * QEMU PowerPC sPAPR XIVE interrupt controller model
>> + *
>> + * Copyright (c) 2017-2019, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "qemu/error-report.h"
>> +#include "qapi/error.h"
>> +#include "target/ppc/cpu.h"
>> +#include "sysemu/cpus.h"
>> +#include "sysemu/kvm.h"
>> +#include "hw/ppc/spapr.h"
>> +#include "hw/ppc/spapr_xive.h"
>> +#include "hw/ppc/xive.h"
>> +#include "kvm_ppc.h"
>> +
>> +#include <sys/ioctl.h>
>> +
>> +/*
>> + * Helpers for CPU hotplug
>> + *
>> + * TODO: make a common KVMEnabledCPU layer for XICS and XIVE
>> + */
>> +typedef struct KVMEnabledCPU {
>> +    unsigned long vcpu_id;
>> +    QLIST_ENTRY(KVMEnabledCPU) node;
>> +} KVMEnabledCPU;
>> +
>> +static QLIST_HEAD(, KVMEnabledCPU)
>> +    kvm_enabled_cpus =3D QLIST_HEAD_INITIALIZER(&kvm_enabled_cpus);
>> +
>> +static bool kvm_cpu_is_enabled(CPUState *cs)
>> +{
>> +    KVMEnabledCPU *enabled_cpu;
>> +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
>> +
>> +    QLIST_FOREACH(enabled_cpu, &kvm_enabled_cpus, node) {
>> +        if (enabled_cpu->vcpu_id =3D=3D vcpu_id) {
>> +            return true;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>> +static void kvm_cpu_enable(CPUState *cs)
>> +{
>> +    KVMEnabledCPU *enabled_cpu;
>> +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
>> +
>> +    enabled_cpu =3D g_malloc(sizeof(*enabled_cpu));
>> +    enabled_cpu->vcpu_id =3D vcpu_id;
>> +    QLIST_INSERT_HEAD(&kvm_enabled_cpus, enabled_cpu, node);
>> +}
>> +
>> +/*
>> + * XIVE Thread Interrupt Management context (KVM)
>> + */
>> +
>> +void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
>> +    unsigned long vcpu_id;
>> +    int ret;
>> +
>> +    /* Check if CPU was hot unplugged and replugged. */
>> +    if (kvm_cpu_is_enabled(tctx->cs)) {
>> +        return;
>> +    }
>> +
>> +    vcpu_id =3D kvm_arch_vcpu_id(tctx->cs);
>> +
>> +    ret =3D kvm_vcpu_enable_cap(tctx->cs, KVM_CAP_PPC_IRQ_XIVE, 0, xi=
ve->fd,
>> +                              vcpu_id, 0);
>> +    if (ret < 0) {
>> +        error_setg(errp, "XIVE: unable to connect CPU%ld to KVM devic=
e: %s",
>> +                   vcpu_id, strerror(errno));
>> +        return;
>> +    }
>> +
>> +    kvm_cpu_enable(tctx->cs);
>> +}
>> +
>> +/*
>> + * XIVE Interrupt Source (KVM)
>> + */
>> +
>> +/*
>> + * At reset, the interrupt sources are simply created and MASKED. We
>> + * only need to inform the KVM XIVE device about their type: LSI or
>> + * MSI.
>> + */
>> +void kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error =
**errp)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(xsrc->xive);
>> +    uint64_t state =3D 0;
>> +
>> +    if (xive_source_irq_is_lsi(xsrc, srcno)) {
>> +        state |=3D KVM_XIVE_LEVEL_SENSITIVE;
>> +        if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
>> +            state |=3D KVM_XIVE_LEVEL_ASSERTED;
>> +        }
>> +    }
>> +
>> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE, srcno, &stat=
e,
>> +                      true, errp);
>> +}
>> +
>> +void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
>> +{
>> +    int i;
>> +
>> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
>> +        Error *local_err =3D NULL;
>> +
>> +        kvmppc_xive_source_reset_one(xsrc, i, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>> +    }
>> +}
>> +
>> +void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
>> +{
>> +    XiveSource *xsrc =3D opaque;
>> +    struct kvm_irq_level args;
>> +    int rc;
>> +
>> +    args.irq =3D srcno;
>> +    if (!xive_source_irq_is_lsi(xsrc, srcno)) {
>> +        if (!val) {
>> +            return;
>> +        }
>> +        args.level =3D KVM_INTERRUPT_SET;
>> +    } else {
>> +        if (val) {
>> +            xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
>> +            args.level =3D KVM_INTERRUPT_SET_LEVEL;
>> +        } else {
>> +            xsrc->status[srcno] &=3D ~XIVE_STATUS_ASSERTED;
>> +            args.level =3D KVM_INTERRUPT_UNSET;
>> +        }
>> +    }
>> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_IRQ_LINE, &args);
>> +    if (rc < 0) {
>> +        error_report("XIVE: kvm_irq_line() failed : %s", strerror(err=
no));
>> +    }
>> +}
>> +
>> +/*
>> + * sPAPR XIVE interrupt controller (KVM)
>> + */
>> +
>> +static void *kvmppc_xive_mmap(sPAPRXive *xive, int pgoff, size_t len,
>> +                              Error **errp)
>> +{
>> +    void *addr;
>> +    uint32_t page_shift =3D 16; /* TODO: fix page_shift */
>> +
>> +    addr =3D mmap(NULL, len, PROT_WRITE | PROT_READ, MAP_SHARED, xive=
->fd,
>> +                pgoff << page_shift);
>> +    if (addr =3D=3D MAP_FAILED) {
>> +        error_setg_errno(errp, errno, "XIVE: unable to set memory map=
ping");
>> +        return NULL;
>> +    }
>> +
>> +    return addr;
>> +}
>> +
>> +/*
>> + * All the XIVE memory regions are now backed by mappings from the KV=
M
>> + * XIVE device.
>> + */
>> +void kvmppc_xive_connect(sPAPRXive *xive, Error **errp)
>> +{
>> +    XiveSource *xsrc =3D &xive->source;
>> +    XiveENDSource *end_xsrc =3D &xive->end_source;
>> +    Error *local_err =3D NULL;
>> +    size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
>> +    size_t tima_len =3D 4ull << TM_SHIFT;
>> +
>> +    if (!kvmppc_has_cap_xive()) {
>> +        error_setg(errp, "IRQ_XIVE capability must be present for KVM=
");
>> +        return;
>> +    }
>> +
>> +    /* First, create the KVM XIVE device */
>> +    xive->fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, fals=
e);
>> +    if (xive->fd < 0) {
>> +        error_setg_errno(errp, -xive->fd, "XIVE: error creating KVM d=
evice");
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * 1. Source ESB pages - KVM mapping
>> +     */
>> +    xsrc->esb_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSE=
T, esb_len,
>> +                                      &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    memory_region_init_ram_device_ptr(&xsrc->esb_mmio, OBJECT(xsrc),
>> +                                      "xive.esb", esb_len, xsrc->esb_=
mmap);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
>> +
>> +    /*
>> +     * 2. END ESB pages (No KVM support yet)
>> +     */
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
>> +
>> +    /*
>> +     * 3. TIMA pages - KVM mapping
>> +     */
>> +    xive->tm_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSE=
T, tima_len,
>> +                                     &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +    memory_region_init_ram_device_ptr(&xive->tm_mmio, OBJECT(xive),
>> +                                      "xive.tima", tima_len, xive->tm=
_mmap);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
>> +
>> +    kvm_kernel_irqchip =3D true;
>> +    kvm_msi_via_irqfd_allowed =3D true;
>> +    kvm_gsi_direct_mapping =3D true;
>> +
>> +    /* Map all regions */
>> +    spapr_xive_map_mmio(xive);
>> +}
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index daa7badc8492..0284b5803551 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -491,6 +491,15 @@ static void xive_tctx_realize(DeviceState *dev, E=
rror **errp)
>>          return;
>>      }
>> =20
>> +    /* Connect the presenter to the VCPU (required for CPU hotplug) *=
/
>> +    if (kvm_irqchip_in_kernel()) {
>> +        kvmppc_xive_cpu_connect(tctx, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>> +    }
>> +
>>      qemu_register_reset(xive_tctx_reset, dev);
>>  }
>> =20
>> @@ -893,6 +902,10 @@ static void xive_source_reset(void *dev)
>> =20
>>      /* PQs are initialized to 0b01 (Q=3D1) which corresponds to "ints=
 off" */
>>      memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
>> +
>> +    if (kvm_irqchip_in_kernel()) {
>> +        kvmppc_xive_source_reset(xsrc, &error_fatal);
>> +    }
>>  }
>> =20
>>  static void xive_source_realize(DeviceState *dev, Error **errp)
>> @@ -926,9 +939,11 @@ static void xive_source_realize(DeviceState *dev,=
 Error **errp)
>>      xsrc->status =3D g_malloc0(xsrc->nr_irqs);
>>      xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
>> =20
>> -    memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
>> -                          &xive_source_esb_ops, xsrc, "xive.esb",
>> -                          (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
>> +    if (!kvm_irqchip_in_kernel()) {
>> +        memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
>> +                              &xive_source_esb_ops, xsrc, "xive.esb",
>> +                              (1ull << xsrc->esb_shift) * xsrc->nr_ir=
qs);
>> +    }
>> =20
>>      qemu_register_reset(xive_source_reset, dev);
>>  }
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 4145079d7fa5..6e1c36dc62ca 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -387,7 +387,11 @@ static void spapr_irq_set_irq_xive(void *opaque, =
int srcno, int val)
>>  {
>>      sPAPRMachineState *spapr =3D opaque;
>> =20
>> -    xive_source_set_irq(&spapr->xive->source, srcno, val);
>> +    if (kvm_irqchip_in_kernel()) {
>> +        kvmppc_xive_source_set_irq(&spapr->xive->source, srcno, val);
>> +    } else {
>> +        xive_source_set_irq(&spapr->xive->source, srcno, val);
>> +    }
>>  }
>> =20
>>  static const char *spapr_irq_get_nodename_xive(sPAPRMachineState *spa=
pr)
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index d01852fe3112..43e42e3c2af9 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -85,6 +85,7 @@ static int cap_fixup_hcalls;
>>  static int cap_htm;             /* Hardware transactional memory supp=
ort */
>>  static int cap_mmu_radix;
>>  static int cap_mmu_hash_v3;
>> +static int cap_xive;
>>  static int cap_resize_hpt;
>>  static int cap_ppc_pvr_compat;
>>  static int cap_ppc_safe_cache;
>> @@ -148,6 +149,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      cap_htm =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
>>      cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX=
);
>>      cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HAS=
H_V3);
>> +    cap_xive =3D kvm_vm_check_extension(s, KVM_CAP_PPC_IRQ_XIVE);
>>      cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE=
_HPT);
>>      kvmppc_get_cpu_characteristics(s);
>>      cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_N=
ESTED_HV);
>> @@ -2388,6 +2390,11 @@ static int parse_cap_ppc_safe_indirect_branch(s=
truct kvm_ppc_cpu_char c)
>>      return 0;
>>  }
>> =20
>> +bool kvmppc_has_cap_xive(void)
>> +{
>> +    return cap_xive;
>> +}
>> +
>>  static void kvmppc_get_cpu_characteristics(KVMState *s)
>>  {
>>      struct kvm_ppc_cpu_char c;
>> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
>> index 301a8e972d91..23126c199178 100644
>> --- a/hw/intc/Makefile.objs
>> +++ b/hw/intc/Makefile.objs
>> @@ -39,6 +39,7 @@ obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
>>  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
>>  obj-$(CONFIG_XIVE) +=3D xive.o
>>  obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
>> +obj-$(CONFIG_XIVE_KVM) +=3D spapr_xive_kvm.o
>>  obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
>>  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
>>  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
>=20
