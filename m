Received: from eggs.gnu.org ([2001:4830:134:3::10]:37970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRrgu-0001Ro-7c
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 23:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRrgq-0006nj-3G
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 23:43:12 -0500
Date: Wed, 28 Nov 2018 15:39:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181128043953.GB2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-19-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="avNtfD0ffNO6L/9g"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-19-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 18/36] spapr: allocate the interrupt
 thread context under the CPU core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--avNtfD0ffNO6L/9g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:11AM +0100, C=E9dric Le Goater wrote:
> Each interrupt mode has its own specific interrupt presenter object,
> that we store under the CPU object, one for XICS and one for XIVE.
>=20
> Extend the sPAPR IRQ backend with a new handler to support them both.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/spapr.h     |  1 +
>  include/hw/ppc/spapr_irq.h |  2 ++
>  include/hw/ppc/xive.h      |  2 ++
>  hw/intc/xive.c             | 21 +++++++++++++++++++++
>  hw/ppc/spapr_cpu_core.c    |  5 ++---
>  hw/ppc/spapr_irq.c         | 17 +++++++++++++++++
>  6 files changed, 45 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 8415faea7b82..f43ef69d61bc 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -177,6 +177,7 @@ struct sPAPRMachineState {
>      int32_t irq_map_nr;
>      unsigned long *irq_map;
>      sPAPRXive  *xive;
> +    const char *xive_tctx_type;
> =20
>      bool cmd_line_caps[SPAPR_CAP_NUM];
>      sPAPRCapabilities def, eff, mig;
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index cfdc1f86e713..c3b4c38145eb 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -42,6 +42,8 @@ typedef struct sPAPRIrq {
>      void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
>                          void *fdt, uint32_t phandle);
> +    Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
> +                               Error **errp);
>  } sPAPRIrq;
> =20
>  extern sPAPRIrq spapr_irq_xics;
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index e6931ddaa83f..b74eb326dcd1 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -284,6 +284,8 @@ typedef struct XiveTCTX {
>  extern const MemoryRegionOps xive_tm_ops;
> =20
>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
> +Object *xive_tctx_create(Object *cpu, const char *type, XiveRouter *xrtr,
> +                         Error **errp);
> =20
>  static inline uint32_t xive_tctx_cam_line(uint8_t nvt_blk, uint32_t nvt_=
idx)
>  {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index fc6ef5895e6d..7d921023e2ee 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -579,6 +579,27 @@ static const TypeInfo xive_tctx_info =3D {
>      .class_init    =3D xive_tctx_class_init,
>  };
> =20
> +Object *xive_tctx_create(Object *cpu, const char *type, XiveRouter *xrtr,
> +                         Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    Object *obj;
> +
> +    obj =3D object_new(type);
> +    object_property_add_child(cpu, type, obj, &error_abort);
> +    object_unref(obj);
> +    object_property_add_const_link(obj, "cpu", cpu, &error_abort);
> +    object_property_add_const_link(obj, "xive", OBJECT(xrtr), &error_abo=
rt);
> +    object_property_set_bool(obj, true, "realized", &local_err);
> +    if (local_err) {
> +        object_unparent(obj);
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    return obj;
> +}
> +
>  /*
>   * XIVE ESB helpers
>   */
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 2398ce62c0e7..1811cd48db90 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -11,7 +11,6 @@
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "target/ppc/cpu.h"
>  #include "hw/ppc/spapr.h"
> -#include "hw/ppc/xics.h" /* for icp_create() - to be removed */
>  #include "hw/boards.h"
>  #include "qapi/error.h"
>  #include "sysemu/cpus.h"
> @@ -215,6 +214,7 @@ static void spapr_cpu_core_unrealize(DeviceState *dev=
, Error **errp)
>  static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                                 sPAPRCPUCore *sc, Error **errp)
>  {
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>      CPUPPCState *env =3D &cpu->env;
>      CPUState *cs =3D CPU(cpu);
>      Error *local_err =3D NULL;
> @@ -233,8 +233,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
>      qemu_register_reset(spapr_cpu_reset, cpu);
>      spapr_cpu_reset(cpu);
> =20
> -    cpu->intc =3D icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(s=
papr),
> -                           &local_err);
> +    cpu->intc =3D smc->irq->cpu_intc_create(spapr, OBJECT(cpu), &local_e=
rr);
>      if (local_err) {
>          goto error_unregister;
>      }
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index d88a029d8c5c..253abc10e780 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -197,6 +197,12 @@ static void spapr_irq_dt_populate_xics(sPAPRMachineS=
tate *spapr,
>      spapr_dt_xics(nr_servers, fdt, phandle);
>  }
> =20
> +static Object *spapr_irq_cpu_intc_create_xics(sPAPRMachineState *spapr,
> +                                              Object *cpu, Error **errp)
> +{
> +    return icp_create(cpu, spapr->icp_type, XICS_FABRIC(spapr), errp);
> +}
> +
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> @@ -211,6 +217,7 @@ sPAPRIrq spapr_irq_xics =3D {
>      .qirq        =3D spapr_qirq_xics,
>      .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_irq_dt_populate_xics,
> +    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
>  };
> =20
>   /*
> @@ -267,6 +274,7 @@ static void spapr_irq_init_xive(sPAPRMachineState *sp=
apr, int nr_irqs,
>          return;
>      }
> =20
> +    spapr->xive_tctx_type =3D TYPE_XIVE_TCTX;
>      spapr_xive_hcall_init(spapr);
>  }
> =20
> @@ -315,6 +323,13 @@ static void spapr_irq_dt_populate_xive(sPAPRMachineS=
tate *spapr,
>      spapr_dt_xive(spapr->xive, nr_servers, fdt, phandle);
>  }
> =20
> +static Object *spapr_irq_cpu_intc_create_xive(sPAPRMachineState *spapr,
> +                                              Object *cpu, Error **errp)
> +{
> +    return xive_tctx_create(cpu, spapr->xive_tctx_type,
> +                            XIVE_ROUTER(spapr->xive), errp);
> +}
> +
>  /*
>   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
>   * with XICS.
> @@ -333,6 +348,7 @@ sPAPRIrq spapr_irq_xive =3D {
>      .qirq        =3D spapr_qirq_xive,
>      .print_info  =3D spapr_irq_print_info_xive,
>      .dt_populate =3D spapr_irq_dt_populate_xive,
> +    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
>  };
> =20
>  /*
> @@ -438,4 +454,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
>      .qirq        =3D spapr_qirq_xics,
>      .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_irq_dt_populate_xics,
> +    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--avNtfD0ffNO6L/9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv+HBkACgkQbDjKyiDZ
s5LkwQ//QMdtQ+UwFRWFDVF72AqNVH4yxOC5g+mugse7lNTCfgBYRe2Gxb8Z9wv7
JJLrrSzPo+QAEQFQ03XtGCHL7PHh/BheEKCjSRPMGRdkx+OU6gGmh7fTemVqCKKF
wp8Bp1h1H1kbEATUbVENKTIbqD0VykdsAUhpRvlvYZE6w9a/EGsddMnb9IfLjfAv
FHrOk47ZgPWTzq/5dowYkEmZr1BQhf/eawsLWgOcCUazLhlF/tAvwdH/GWZwKle6
iYSa6BLNbEJbgmUc5ghbNMWKVNNv9tfhwn5sYcj38GDPQSouH1FaVbgz2bgoe8aA
TLP+BTY10v0a3359SP5uU6zNTng5OVivGDmeVClBcXiLfbD2ydDFReRRFcpdbJOj
QV311UCsAmIIzSR0v95CmXlWFw7n4JD1qtcNBZWnAOHTTCdvswxqg3QEaeTyOGpm
Klp0dvagvX0/f04iafDZRuQP6FkGB0O++HS/Z7GtI20CYJ/5cjray/b0XcsuqtAa
AgKaDhaGGj8ahzVfZCo4/aCtUcxfJqti54RpszipsXlgaRikLDG/CVGnxMRYijj4
n2qsoAROkOZcJ9RusGacyt6bK4spaQ+6OTswtaGfWlF7PD98P0zTBhVBMMRPBI6O
zXWx+lK5FhL54F92itUCi0xyVMvU6IrgiHQ1P9s7T2Ag5GFtrBI=
=Y8by
-----END PGP SIGNATURE-----

--avNtfD0ffNO6L/9g--
