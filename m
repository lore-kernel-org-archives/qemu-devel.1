Received: from eggs.gnu.org ([209.51.188.92]:58404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grDlf-0005Hd-Lf
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grDlc-0003zo-P2
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:20:55 -0500
Date: Wed, 6 Feb 2019 13:39:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190206023940.GU22661@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4WCFFtl4AQpQKunj"
Content-Disposition: inline
In-Reply-To: <20190107183946.7230-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 02/13] spapr/xive: add KVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--4WCFFtl4AQpQKunj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:39:35PM +0100, C=E9dric Le Goater wrote:
> This introduces a set of helpers when KVM is in use, which create the
> KVM XIVE device, initialize the interrupt sources at a KVM level and
> connect the interrupt presenters to the vCPU.
>=20
> They also handle the initialization of the TIMA and the source ESB
> memory regions of the controller. These have a different type under
> KVM. They are 'ram device' memory mappings, similarly to VFIO, exposed
> to the guest and the associated VMAs on the host are populated
> dynamically with the appropriate pages using a fault handler.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Looks fine apart from the details of how the KVM interface works.

> ---
>  default-configs/ppc64-softmmu.mak |   1 +
>  include/hw/ppc/spapr_xive.h       |  10 ++
>  include/hw/ppc/xive.h             |  22 +++
>  target/ppc/kvm_ppc.h              |   6 +
>  hw/intc/spapr_xive.c              |  31 ++--
>  hw/intc/spapr_xive_kvm.c          | 254 ++++++++++++++++++++++++++++++
>  hw/intc/xive.c                    |  22 ++-
>  hw/ppc/spapr_irq.c                |  11 +-
>  target/ppc/kvm.c                  |   7 +
>  hw/intc/Makefile.objs             |   1 +
>  10 files changed, 349 insertions(+), 16 deletions(-)
>  create mode 100644 hw/intc/spapr_xive_kvm.c
>=20
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
> index 7f34ad0528ed..c1bf5cd951f5 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -18,6 +18,7 @@ CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
>  CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
>  CONFIG_XIVE=3D$(CONFIG_PSERIES)
>  CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
> +CONFIG_XIVE_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
>  CONFIG_MEM_DEVICE=3Dy
>  CONFIG_DIMM=3Dy
>  CONFIG_SPAPR_RNG=3Dy
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 7fdc25057420..24a0be478039 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -35,6 +35,10 @@ typedef struct sPAPRXive {
>      /* TIMA mapping address */
>      hwaddr        tm_base;
>      MemoryRegion  tm_mmio;
> +
> +    /* KVM support */
> +    int           fd;
> +    void          *tm_mmap;
>  } sPAPRXive;
> =20
>  bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
> @@ -48,5 +52,11 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t =
nr_servers, void *fdt,
>                     uint32_t phandle);
>  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>  void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
> +void spapr_xive_map_mmio(sPAPRXive *xive);
> +
> +/*
> + * KVM XIVE device helpers
> + */
> +void kvmppc_xive_connect(sPAPRXive *xive, Error **errp);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index ec23253ba448..4bbba8d39a65 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -140,6 +140,7 @@
>  #ifndef PPC_XIVE_H
>  #define PPC_XIVE_H
> =20
> +#include "sysemu/kvm.h"
>  #include "hw/qdev-core.h"
>  #include "hw/sysbus.h"
>  #include "hw/ppc/xive_regs.h"
> @@ -194,6 +195,9 @@ typedef struct XiveSource {
>      uint32_t        esb_shift;
>      MemoryRegion    esb_mmio;
> =20
> +    /* KVM support */
> +    void            *esb_mmap;
> +
>      XiveNotifier    *xive;
>  } XiveSource;
> =20
> @@ -421,4 +425,22 @@ static inline uint32_t xive_nvt_cam_line(uint8_t nvt=
_blk, uint32_t nvt_idx)
>      return (nvt_blk << 19) | nvt_idx;
>  }
> =20
> +/*
> + * KVM XIVE device helpers
> + */
> +
> +/* Keep inlined to discard compile of KVM code sections */
> +static inline bool kvmppc_xive_enabled(void)
> +{
> +    if (kvm_enabled()) {
> +        return machine_kernel_irqchip_allowed(MACHINE(qdev_get_machine()=
));
> +    } else {
> +        return false;
> +    }
> +}
> +
> +void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp);
> +void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
> +void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
> +
>  #endif /* PPC_XIVE_H */
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index bdfaa4e70a83..d2159660f9f2 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -59,6 +59,7 @@ bool kvmppc_has_cap_fixup_hcalls(void);
>  bool kvmppc_has_cap_htm(void);
>  bool kvmppc_has_cap_mmu_radix(void);
>  bool kvmppc_has_cap_mmu_hash_v3(void);
> +bool kvmppc_has_cap_xive(void);
>  int kvmppc_get_cap_safe_cache(void);
>  int kvmppc_get_cap_safe_bounds_check(void);
>  int kvmppc_get_cap_safe_indirect_branch(void);
> @@ -307,6 +308,11 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
>      return false;
>  }
> =20
> +static inline bool kvmppc_has_cap_xive(void)
> +{
> +    return false;
> +}
> +
>  static inline int kvmppc_get_cap_safe_cache(void)
>  {
>      return 0;
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index d391177ab81f..cf6d3a5f12e1 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -172,7 +172,7 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Monit=
or *mon)
>      }
>  }
> =20
> -static void spapr_xive_map_mmio(sPAPRXive *xive)
> +void spapr_xive_map_mmio(sPAPRXive *xive)
>  {
>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->vc_base);
>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->end_base);
> @@ -250,6 +250,9 @@ static void spapr_xive_instance_init(Object *obj)
>                        TYPE_XIVE_END_SOURCE);
>      object_property_add_child(obj, "end_source", OBJECT(&xive->end_sourc=
e),
>                                NULL);
> +
> +    /* Not connected to the KVM XIVE device */
> +    xive->fd =3D -1;
>  }
> =20
>  static void spapr_xive_realize(DeviceState *dev, Error **errp)
> @@ -304,17 +307,25 @@ static void spapr_xive_realize(DeviceState *dev, Er=
ror **errp)
>      xive->eat =3D g_new0(XiveEAS, xive->nr_irqs);
>      xive->endt =3D g_new0(XiveEND, xive->nr_ends);
> =20
> -    /* TIMA initialization */
> -    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
> -                          "xive.tima", 4ull << TM_SHIFT);
> +    if (kvmppc_xive_enabled()) {
> +        kvmppc_xive_connect(xive, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    } else {
> +        /* TIMA initialization */
> +        memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops=
, xive,
> +                              "xive.tima", 4ull << TM_SHIFT);
> =20
> -    /* Define all XIVE MMIO regions on SysBus */
> -    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
> +        /* Define all XIVE MMIO regions on SysBus */
> +        sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
> +        sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
> +        sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
> =20
> -    /* Map all regions */
> -    spapr_xive_map_mmio(xive);
> +        /* Map all regions */
> +        spapr_xive_map_mmio(xive);
> +    }
> =20
>      qemu_register_reset(spapr_xive_reset, dev);
>  }
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> new file mode 100644
> index 000000000000..f96c66fa419d
> --- /dev/null
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -0,0 +1,254 @@
> +/*
> + * QEMU PowerPC sPAPR XIVE interrupt controller model
> + *
> + * Copyright (c) 2017-2019, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "target/ppc/cpu.h"
> +#include "sysemu/cpus.h"
> +#include "sysemu/kvm.h"
> +#include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_xive.h"
> +#include "hw/ppc/xive.h"
> +#include "kvm_ppc.h"
> +
> +#include <sys/ioctl.h>
> +
> +/*
> + * Helpers for CPU hotplug
> + *
> + * TODO: make a common KVMEnabledCPU layer for XICS and XIVE
> + */
> +typedef struct KVMEnabledCPU {
> +    unsigned long vcpu_id;
> +    QLIST_ENTRY(KVMEnabledCPU) node;
> +} KVMEnabledCPU;
> +
> +static QLIST_HEAD(, KVMEnabledCPU)
> +    kvm_enabled_cpus =3D QLIST_HEAD_INITIALIZER(&kvm_enabled_cpus);
> +
> +static bool kvm_cpu_is_enabled(CPUState *cs)
> +{
> +    KVMEnabledCPU *enabled_cpu;
> +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
> +
> +    QLIST_FOREACH(enabled_cpu, &kvm_enabled_cpus, node) {
> +        if (enabled_cpu->vcpu_id =3D=3D vcpu_id) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static void kvm_cpu_enable(CPUState *cs)
> +{
> +    KVMEnabledCPU *enabled_cpu;
> +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
> +
> +    enabled_cpu =3D g_malloc(sizeof(*enabled_cpu));
> +    enabled_cpu->vcpu_id =3D vcpu_id;
> +    QLIST_INSERT_HEAD(&kvm_enabled_cpus, enabled_cpu, node);
> +}
> +
> +/*
> + * XIVE Thread Interrupt Management context (KVM)
> + */
> +
> +void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
> +{
> +    sPAPRXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
> +    unsigned long vcpu_id;
> +    int ret;
> +
> +    /* Check if CPU was hot unplugged and replugged. */
> +    if (kvm_cpu_is_enabled(tctx->cs)) {
> +        return;
> +    }
> +
> +    vcpu_id =3D kvm_arch_vcpu_id(tctx->cs);
> +
> +    ret =3D kvm_vcpu_enable_cap(tctx->cs, KVM_CAP_PPC_IRQ_XIVE, 0, xive-=
>fd,
> +                              vcpu_id, 0);
> +    if (ret < 0) {
> +        error_setg(errp, "XIVE: unable to connect CPU%ld to KVM device: =
%s",
> +                   vcpu_id, strerror(errno));
> +        return;
> +    }
> +
> +    kvm_cpu_enable(tctx->cs);
> +}
> +
> +/*
> + * XIVE Interrupt Source (KVM)
> + */
> +
> +/*
> + * At reset, the interrupt sources are simply created and MASKED. We
> + * only need to inform the KVM XIVE device about their type: LSI or
> + * MSI.
> + */
> +void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(xsrc->xive);
> +    int i;
> +
> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
> +        Error *local_err =3D NULL;
> +        uint64_t state =3D 0;
> +
> +        if (xive_source_irq_is_lsi(xsrc, i)) {
> +            state |=3D KVM_XIVE_LEVEL_SENSITIVE;
> +            if (xsrc->status[i] & XIVE_STATUS_ASSERTED) {
> +                state |=3D KVM_XIVE_LEVEL_ASSERTED;
> +            }
> +        }
> +
> +        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCES, i, &state,
> +                          true, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +}
> +
> +void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
> +{
> +    XiveSource *xsrc =3D opaque;
> +    struct kvm_irq_level args;
> +    int rc;
> +
> +    args.irq =3D srcno;
> +    if (!xive_source_irq_is_lsi(xsrc, srcno)) {
> +        if (!val) {
> +            return;
> +        }
> +        args.level =3D KVM_INTERRUPT_SET;
> +    } else {
> +        if (val) {
> +            xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
> +            args.level =3D KVM_INTERRUPT_SET_LEVEL;
> +        } else {
> +            xsrc->status[srcno] &=3D ~XIVE_STATUS_ASSERTED;
> +            args.level =3D KVM_INTERRUPT_UNSET;
> +        }
> +    }
> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_IRQ_LINE, &args);
> +    if (rc < 0) {
> +        error_report("XIVE: kvm_irq_line() failed : %s", strerror(errno)=
);
> +    }
> +}
> +
> +/*
> + * sPAPR XIVE interrupt controller (KVM)
> + */
> +
> +static void *kvmppc_xive_mmap(sPAPRXive *xive, int ctrl, size_t len,
> +                                 Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    void *addr;
> +    int fd;
> +
> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL, ctrl, &fd, false,
> +                      &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    addr =3D mmap(NULL, len, PROT_WRITE | PROT_READ, MAP_SHARED, fd, 0);
> +    close(fd);
> +    if (addr =3D=3D MAP_FAILED) {
> +        error_setg_errno(errp, errno, "XIVE: unable to set memory mappin=
g");
> +        return NULL;
> +    }
> +
> +    return addr;
> +}
> +
> +/*
> + * All the XIVE memory regions are now backed by mappings from the KVM
> + * XIVE device.
> + */
> +void kvmppc_xive_connect(sPAPRXive *xive, Error **errp)
> +{
> +    XiveSource *xsrc =3D &xive->source;
> +    XiveENDSource *end_xsrc =3D &xive->end_source;
> +    Error *local_err =3D NULL;
> +    size_t esb_len;
> +    size_t tima_len;
> +
> +    if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
> +        error_setg(errp, "IRQ_XIVE capability must be present for KVM");
> +        return;
> +    }
> +
> +    /* First, create the KVM XIVE device */
> +    xive->fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, false);
> +    if (xive->fd < 0) {
> +        error_setg_errno(errp, -xive->fd, "XIVE: error creating KVM devi=
ce");
> +        return;
> +    }
> +
> +    /*
> +     * Source ESBs KVM mapping
> +     *
> +     * Inform KVM where we will map the ESB pages. This is needed by
> +     * the H_INT_GET_SOURCE_INFO hcall which returns the source
> +     * characteristics, among which the ESB page address.
> +     */
> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL, KVM_DEV_XIVE_VC_B=
ASE,
> +                      &xive->vc_base, true, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> +    xsrc->esb_mmap =3D kvmppc_xive_mmap(xive, KVM_DEV_XIVE_GET_ESB_FD,
> +                                      esb_len, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    memory_region_init_ram_device_ptr(&xsrc->esb_mmio, OBJECT(xsrc),
> +                                      "xive.esb", esb_len, xsrc->esb_mma=
p);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
> +
> +    /* END ESBs mapping (No KVM) */
> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
> +
> +    /*
> +     * TIMA KVM mapping
> +     *
> +     * We could also inform KVM where the TIMA will be mapped but as
> +     * this is a fixed MMIO address for the system it does not seem
> +     * necessary to provide a KVM ioctl to change it.
> +     */
> +    tima_len =3D 4ull << TM_SHIFT;
> +    xive->tm_mmap =3D kvmppc_xive_mmap(xive, KVM_DEV_XIVE_GET_TIMA_FD,
> +                                     tima_len, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    memory_region_init_ram_device_ptr(&xive->tm_mmio, OBJECT(xive),
> +                                      "xive.tima", tima_len, xive->tm_mm=
ap);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
> +
> +    kvm_kernel_irqchip =3D true;
> +    kvm_msi_via_irqfd_allowed =3D true;
> +    kvm_gsi_direct_mapping =3D true;
> +
> +    /* Map all regions */
> +    spapr_xive_map_mmio(xive);
> +}
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index a3cb0cf0e348..9a2d7be283f8 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -15,6 +15,7 @@
>  #include "sysemu/dma.h"
>  #include "hw/qdev-properties.h"
>  #include "monitor/monitor.h"
> +#include "hw/boards.h"
>  #include "hw/ppc/xive.h"
>  #include "hw/ppc/xive_regs.h"
> =20
> @@ -493,6 +494,15 @@ static void xive_tctx_realize(DeviceState *dev, Erro=
r **errp)
>          return;
>      }
> =20
> +    /* Connect the presenter to the VCPU (required for CPU hotplug) */
> +    if (kvmppc_xive_enabled()) {
> +        kvmppc_xive_cpu_connect(tctx, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +
>      qemu_register_reset(xive_tctx_reset, dev);
>  }
> =20
> @@ -895,6 +905,10 @@ static void xive_source_reset(void *dev)
> =20
>      /* PQs are initialized to 0b01 (Q=3D1) which corresponds to "ints of=
f" */
>      memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
> +
> +    if (kvmppc_xive_enabled()) {
> +        kvmppc_xive_source_reset(xsrc, &error_fatal);
> +    }
>  }
> =20
>  static void xive_source_realize(DeviceState *dev, Error **errp)
> @@ -928,9 +942,11 @@ static void xive_source_realize(DeviceState *dev, Er=
ror **errp)
>      xsrc->status =3D g_malloc0(xsrc->nr_irqs);
>      xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
> =20
> -    memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
> -                          &xive_source_esb_ops, xsrc, "xive.esb",
> -                          (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
> +    if (!kvmppc_xive_enabled()) {
> +        memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
> +                              &xive_source_esb_ops, xsrc, "xive.esb",
> +                              (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
> +    }
> =20
>      qemu_register_reset(xive_source_reset, dev);
>  }
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 5fce72fe0f6c..afbdabfa6543 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -15,6 +15,7 @@
>  #include "hw/ppc/spapr_xive.h"
>  #include "hw/ppc/xics.h"
>  #include "sysemu/kvm.h"
> +#include "kvm_ppc.h"
> =20
>  #include "trace.h"
> =20
> @@ -266,9 +267,9 @@ static void spapr_irq_init_xive(sPAPRMachineState *sp=
apr, Error **errp)
>      DeviceState *dev;
>      int i;
> =20
> -    /* KVM XIVE device not yet available */
>      if (kvm_enabled()) {
> -        if (machine_kernel_irqchip_required(machine)) {
> +        if (machine_kernel_irqchip_required(machine) &&
> +            !kvmppc_has_cap_xive()) {
>              error_setg(errp, "kernel_irqchip requested. no KVM XIVE supp=
ort");
>              return;
>          }
> @@ -384,7 +385,11 @@ static void spapr_irq_set_irq_xive(void *opaque, int=
 srcno, int val)
>  {
>      sPAPRMachineState *spapr =3D opaque;
> =20
> -    xive_source_set_irq(&spapr->xive->source, srcno, val);
> +    if (kvmppc_xive_enabled()) {
> +        kvmppc_xive_source_set_irq(&spapr->xive->source, srcno, val);
> +    } else {
> +        xive_source_set_irq(&spapr->xive->source, srcno, val);
> +    }
>  }
> =20
>  /*
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index ebbb48c42f25..88a470a73e7c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -86,6 +86,7 @@ static int cap_fixup_hcalls;
>  static int cap_htm;             /* Hardware transactional memory support=
 */
>  static int cap_mmu_radix;
>  static int cap_mmu_hash_v3;
> +static int cap_xive;
>  static int cap_resize_hpt;
>  static int cap_ppc_pvr_compat;
>  static int cap_ppc_safe_cache;
> @@ -149,6 +150,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_htm =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
>      cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
>      cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V=
3);
> +    cap_xive =3D kvm_vm_check_extension(s, KVM_CAP_PPC_IRQ_XIVE);
>      cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
>      kvmppc_get_cpu_characteristics(s);
>      cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_NEST=
ED_HV);
> @@ -2389,6 +2391,11 @@ static int parse_cap_ppc_safe_indirect_branch(stru=
ct kvm_ppc_cpu_char c)
>      return 0;
>  }
> =20
> +bool kvmppc_has_cap_xive(void)
> +{
> +    return cap_xive;
> +}
> +
>  static void kvmppc_get_cpu_characteristics(KVMState *s)
>  {
>      struct kvm_ppc_cpu_char c;
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index 301a8e972d91..23126c199178 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -39,6 +39,7 @@ obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
>  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
>  obj-$(CONFIG_XIVE) +=3D xive.o
>  obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
> +obj-$(CONFIG_XIVE_KVM) +=3D spapr_xive_kvm.o
>  obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
>  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
>  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4WCFFtl4AQpQKunj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxaSOkACgkQbDjKyiDZ
s5JHRg//ZOAJdj3RRJNCq8yKR0QtCwp4lqraNKg3IvjUW4K5iQYDgIV26GtY/5ke
MDM7YKC+Y4NF+KxWZH+9HkaqA5AKV2SJJ4yrax+R07SGExo3KXT+T10BsXExfswz
q2UlG+hHW8GrVCzhqldo5rLLsFSzj5cQO3u6+O8IjX/LOuDzwqLikltgpA7oW3P0
2xeTI9BYgRZSwa/2+jYLZa7eFhZwFf7BslOlC2WtQjkQ4x/yNhrrDhPudpfj5SLY
DQXJ70rrm7QlzkxYflD/7hrznr3u4oujlFiANM2/GkrRACWwiD04d39IhY/oEgeB
uw3lu3T8XF0PrxdxfCrm5EM3d/bd4aYUeeRNhCn56CEcsprZD4h7O3eMHjdMleLo
Mo989Y1fsEYyoW4bZ0YjtV7QL6rFcTR9rLaqXWSJCyS4cSxDJV3oYSQBY5VDtGIw
9OQJmmJ9gDlZNFn/WtPuarz2ogA6Bfd7bkUaV7j4OTNFv0Yjv6rq9fdVPeSRJAeN
Z1/g5xZKulBAGWArjILz1TNJGeVsETuQRHEs4C1MBCBTlQUgOM/GrfOAJp75foGP
ye76xhj3RQN9B5Azs36ekOuyROz5z2rJht7/qFU/MsS+a/zGWXiYyb5z7AftzYFg
0U9TiDSoAYgNIs6fj+5QQK3POAkKlZJq9L0lg0px54R9EXvTgGs=
=hFkm
-----END PGP SIGNATURE-----

--4WCFFtl4AQpQKunj--
