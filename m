Received: from eggs.gnu.org ([2001:4830:134:3::10]:47247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMAO3-0004xF-DA
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMANy-0002yd-08
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:39 -0500
Date: Tue, 5 Dec 2017 17:34:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205063402.GG3057@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<e15f5f90aa5d7c2d5a7cd9e17941c635a58b846b.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
In-Reply-To: <e15f5f90aa5d7c2d5a7cd9e17941c635a58b846b.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 09/17] e500: move mpic under CCSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:07PM -0600, Michael Davidsaver wrote:
> Start moving code out of ppce500_init()
>=20
> Existing ppce500_init_mpic() suggests that MPIC may not be created w/ KVM.
> However, ppce500_init() used mpicdev unconditionally, and would
> fail if the MPIC isn't created.  So require creation.
>=20
> Not tested with KVM for lack of hardware.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/ppc/e500.c      | 102 +++--------------------------------------------=
------
>  hw/ppc/e500_ccsr.c |  85 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 84 insertions(+), 103 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index e22919f4f1..1872bb8eaa 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -29,7 +29,6 @@
>  #include "sysemu/kvm.h"
>  #include "kvm_ppc.h"
>  #include "sysemu/device_tree.h"
> -#include "hw/ppc/openpic.h"
>  #include "hw/ppc/ppc.h"
>  #include "hw/loader.h"
>  #include "elf.h"
> @@ -679,92 +678,6 @@ static void ppce500_cpu_reset(void *opaque)
>      mmubooke_create_initial_mapping(env);
>  }
> =20
> -static DeviceState *ppce500_init_mpic_qemu(PPCE500Params *params,
> -                                           qemu_irq **irqs)
> -{
> -    DeviceState *dev;
> -    SysBusDevice *s;
> -    int i, j, k;
> -
> -    dev =3D qdev_create(NULL, TYPE_OPENPIC);
> -    object_property_add_child(qdev_get_machine(), "pic", OBJECT(dev),
> -                              &error_fatal);
> -    qdev_prop_set_uint32(dev, "model", params->mpic_version);
> -    qdev_prop_set_uint32(dev, "nb_cpus", smp_cpus);
> -
> -    qdev_init_nofail(dev);
> -    s =3D SYS_BUS_DEVICE(dev);
> -
> -    k =3D 0;
> -    for (i =3D 0; i < smp_cpus; i++) {
> -        for (j =3D 0; j < OPENPIC_OUTPUT_NB; j++) {
> -            sysbus_connect_irq(s, k++, irqs[i][j]);
> -        }
> -    }
> -
> -    return dev;
> -}
> -
> -static DeviceState *ppce500_init_mpic_kvm(PPCE500Params *params,
> -                                          qemu_irq **irqs, Error **errp)
> -{
> -    Error *err =3D NULL;
> -    DeviceState *dev;
> -    CPUState *cs;
> -
> -    dev =3D qdev_create(NULL, TYPE_KVM_OPENPIC);
> -    qdev_prop_set_uint32(dev, "model", params->mpic_version);
> -
> -    object_property_set_bool(OBJECT(dev), true, "realized", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        object_unparent(OBJECT(dev));
> -        return NULL;
> -    }
> -
> -    CPU_FOREACH(cs) {
> -        if (kvm_openpic_connect_vcpu(dev, cs)) {
> -            fprintf(stderr, "%s: failed to connect vcpu to irqchip\n",
> -                    __func__);
> -            abort();
> -        }
> -    }
> -
> -    return dev;
> -}
> -
> -static DeviceState *ppce500_init_mpic(MachineState *machine,
> -                                      PPCE500Params *params,
> -                                      MemoryRegion *ccsr,
> -                                      qemu_irq **irqs)
> -{
> -    DeviceState *dev =3D NULL;
> -    SysBusDevice *s;
> -
> -    if (kvm_enabled()) {
> -        Error *err =3D NULL;
> -
> -        if (machine_kernel_irqchip_allowed(machine)) {
> -            dev =3D ppce500_init_mpic_kvm(params, irqs, &err);
> -        }
> -        if (machine_kernel_irqchip_required(machine) && !dev) {
> -            error_reportf_err(err,
> -                              "kernel_irqchip requested but unavailable:=
 ");
> -            exit(1);
> -        }
> -    }
> -
> -    if (!dev) {
> -        dev =3D ppce500_init_mpic_qemu(params, irqs);
> -    }
> -
> -    s =3D SYS_BUS_DEVICE(dev);
> -    memory_region_add_subregion(ccsr, MPC8544_MPIC_REGS_OFFSET,
> -                                s->mmio[0].memory);
> -
> -    return dev;
> -}
> -
>  static void ppce500_power_off(void *opaque, int line, int on)
>  {
>      if (on) {
> @@ -794,18 +707,14 @@ void ppce500_init(MachineState *machine, PPCE500Par=
ams *params)
>      /* irq num for pin INTA, INTB, INTC and INTD is 1, 2, 3 and
>       * 4 respectively */
>      unsigned int pci_irq_nrs[PCI_NUM_PINS] =3D {1, 2, 3, 4};
> -    qemu_irq **irqs;
>      DeviceState *dev, *mpicdev;
>      CPUPPCState *firstenv =3D NULL;
>      MemoryRegion *ccsr_addr_space;
>      SysBusDevice *s;
> =20
> -    irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
> -    irqs[0] =3D g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_N=
B);
>      for (i =3D 0; i < smp_cpus; i++) {
>          PowerPCCPU *cpu;
>          CPUState *cs;
> -        qemu_irq *input;
> =20
>          cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
>          env =3D &cpu->env;
> @@ -821,13 +730,7 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
>              firstenv =3D env;
>          }
> =20
> -        irqs[i] =3D irqs[0] + (i * OPENPIC_OUTPUT_NB);
> -        input =3D (qemu_irq *)env->irq_inputs;
> -        irqs[i][OPENPIC_OUTPUT_INT] =3D input[PPCE500_INPUT_INT];
> -        irqs[i][OPENPIC_OUTPUT_CINT] =3D input[PPCE500_INPUT_CINT];
>          env->spr_cb[SPR_BOOKE_PIR].default_value =3D cs->cpu_index =3D i;
> -        env->mpic_iack =3D params->ccsrbar_base +
> -                         MPC8544_MPIC_REGS_OFFSET + 0xa0;
> =20
>          ppc_booke_timers_init(cpu, 400000000, PPC_TIMER_E500);
> =20
> @@ -857,12 +760,15 @@ void ppce500_init(MachineState *machine, PPCE500Par=
ams *params)
>      dev =3D qdev_create(NULL, "e500-ccsr");
>      object_property_add_child(qdev_get_machine(), "e500-ccsr",
>                                OBJECT(dev), NULL);
> +    qdev_prop_set_uint32(dev, "mpic-model", params->mpic_version);
>      qdev_prop_set_uint32(dev, "base", params->ccsrbar_base);
>      qdev_prop_set_uint32(dev, "ram-size", ram_size);
>      qdev_init_nofail(dev);
>      ccsr_addr_space =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> =20
> -    mpicdev =3D ppce500_init_mpic(machine, params, ccsr_addr_space, irqs=
);
> +    /* created under "e500-ccsr" */
> +    mpicdev =3D DEVICE(object_resolve_path("/machine/pic", 0));
> +    assert(mpicdev);
> =20
>      /* Serial */
>      if (serial_hds[0]) {
> diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
> index 9400d7cf13..68d952794e 100644
> --- a/hw/ppc/e500_ccsr.c
> +++ b/hw/ppc/e500_ccsr.c
> @@ -24,10 +24,14 @@
>  #include "qemu-common.h"
>  #include "qemu/log.h"
>  #include "qemu/error-report.h"
> +#include "qapi/error.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
> +#include "hw/boards.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/kvm.h"
>  #include "hw/sysbus.h"
> +#include "hw/ppc/openpic.h"
> =20
>  /* E500_ denotes registers common to all */
>  /* Some CCSR offsets duplicated in e500.c */
> @@ -185,20 +189,90 @@ static void e500_ccsr_reset(DeviceState *dev)
>      e500_ccsr_post_move(ccsr);
>  }
> =20
> -static void e500_ccsr_initfn(Object *obj)
> +static void e500_ccsr_init(Object *obj)
>  {
> -    CCSRState *ccsr =3D E500_CCSR(obj);
> +    DeviceState *dev =3D DEVICE(obj);
> +    CCSRState *ccsr =3D E500_CCSR(dev);
> +
> +    assert(current_machine);
> +    if (kvm_enabled()) {
> +
> +        if (!machine_kernel_irqchip_allowed(current_machine)) {
> +            error_report("Machine does not allow PIC,"
> +                         " but this is not supported");
> +            exit(1);

You've changed the logic here from the original; this now always
requires a kernel irqchip with kvm, whereas previously it would allow
fallback to the non kernel irqchip unless
machine_kernel_irqchip_required().

> +        }
> =20
> -    memory_region_init_io(&ccsr->iomem, obj, &e500_ccsr_ops,
> +        ccsr->pic =3D qdev_create(NULL, TYPE_KVM_OPENPIC);
> +    } else {
> +        ccsr->pic =3D qdev_create(NULL, TYPE_OPENPIC);
> +    }
> +
> +    if (!ccsr->pic) {
> +        error_report("Failed to create PIC");
> +        exit(1);
> +    }
> +
> +    object_property_add_child(qdev_get_machine(), "pic", OBJECT(ccsr->pi=
c),
> +                              &error_fatal);
> +
> +    qdev_prop_set_uint32(ccsr->pic, "nb_cpus", smp_cpus);
> +
> +    object_property_add_alias(obj, "mpic-model",
> +                              OBJECT(ccsr->pic), "model",
> +                              &error_fatal);
> +}
> +
> +static void e500_ccsr_realize(DeviceState *dev, Error **errp)
> +{
> +    CCSRState *ccsr =3D E500_CCSR(dev);
> +    SysBusDevice *pic;
> +
> +    /* Base 1MB CCSR Region */
> +    memory_region_init_io(&ccsr->iomem, OBJECT(dev), &e500_ccsr_ops,
>                            ccsr, "e500-ccsr", 1024 * 1024);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &ccsr->iomem);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &ccsr->iomem);
> +
> +    qdev_init_nofail(ccsr->pic);
> +    pic =3D SYS_BUS_DEVICE(ccsr->pic);
> +
> +    /* connect MPIC to CPU(s) */
> +    if (kvm_enabled()) {
> +        CPUState *cs;
> +
> +        CPU_FOREACH(cs) {
> +            if (kvm_openpic_connect_vcpu(ccsr->pic, cs)) {
> +                error_setg(errp, "%s: failed to connect vcpu to irqchip",
> +                           __func__);
> +                return;
> +            }
> +        }
> +
> +    } else {
> +        CPUState *cs;
> +
> +        CPU_FOREACH(cs) {
> +            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +            CPUPPCState *env =3D &cpu->env;
> +            qemu_irq *inputs =3D (qemu_irq *)env->irq_inputs;
> +            int base =3D cs->cpu_index * PPCE500_INPUT_NB;
> +
> +            sysbus_connect_irq(pic, base + OPENPIC_OUTPUT_INT,
> +                               inputs[PPCE500_INPUT_INT]);
> +            sysbus_connect_irq(pic, base + OPENPIC_OUTPUT_CINT,
> +                               inputs[PPCE500_INPUT_CINT]);
> +        }
> +    }
> =20
> +    memory_region_add_subregion(&ccsr->iomem, E500_MPIC_OFFSET,
> +                                sysbus_mmio_get_region(pic, 0));
>  }
> =20
>  static Property e500_ccsr_props[] =3D {
>      DEFINE_PROP_UINT32("base", CCSRState, defbase, 0xff700000),
>      DEFINE_PROP_UINT32("ram-size", CCSRState, ram_size, 0),
>      DEFINE_PROP_UINT32("porpllsr", CCSRState, porpllsr, 0),
> +    /* "mpic-model" aliased from MPIC */
>      DEFINE_PROP_END_OF_LIST()
>  };
> =20
> @@ -221,6 +295,7 @@ void e500_ccsr_class_initfn(ObjectClass *klass, void =
*data)
> =20
>      dc->props =3D e500_ccsr_props;
>      dc->vmsd =3D &vmstate_e500_ccsr;
> +    dc->realize =3D e500_ccsr_realize;
>      dc->reset =3D e500_ccsr_reset;
>  }
> =20
> @@ -228,7 +303,7 @@ static const TypeInfo e500_ccsr_info =3D {
>      .name          =3D TYPE_E500_CCSR,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(CCSRState),
> -    .instance_init =3D e500_ccsr_initfn,
> +    .instance_init =3D e500_ccsr_init,
>      .class_size    =3D sizeof(SysBusDeviceClass),
>      .class_init    =3D e500_ccsr_class_initfn
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlomPdgACgkQbDjKyiDZ
s5Jtzg/+J8sbi07+M5xzxiNkxDYXSde7vaUV0zypry9J/+U3OnunAMr4v7TKGNaV
T1yEAZZtSrsgJTUFcatMJ/BzQi3fCsZt8fMD1On7pWlMtkkTnPpCIn1ukJ+UTTaU
Bw2f4iaVFa7cZPIw5ApB1Fv91UrFqdw58Qs1fBDP+DWL9g3Rp9Br/uCNWaI98k2B
W5z6H2/oDKUl8DBpDh9xVydsp3kOlBuaDSeTR1czVVL4JR9oZp2axK+jqdiUNxLR
1mxg3yD9e8iI5+KdsjT3as3lgHZhaz8x1Y87EqeIiG/afoJKKvF19xUQ+GPlUkkH
FI6Pi/jcqItjFm0euTW1gYerFUZe7ugKdfUD884L/DzuQcse1O0tfn37BNJDA5Yc
AejKoZqeu8g3HDvdJVZxWt4hBLnrAIJIf++GWaGd/FR9tLZd60kVoOWcF7zAYUpq
UCqqzng+LF8zRhn8I9PbaRqZFNlcBbUu5dMIDGZVdw56GZTui+imMrByOo6OYQyO
abctw77i5Cox2dQmFuR3o5AXNPHs6l9DEvg86yV3sb3IyguK6XwD5bV000+LU5Jp
Uc8DQzEkqU7AdR9LFRWMza7vR5PGJ5St3nni5azZtMIak9ySOvhbTViw4xu5d0fX
DfM2Cfh8TqIgcsvdgWr829GgCsIkc6OSxN3yzVuC//DDkrc/0AY=
=JFFG
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
