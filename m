Received: from eggs.gnu.org ([2001:4830:134:3::10]:57078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIy6z-0003BD-0W
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIy6u-0005qI-0E
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:08:32 -0400
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:44207)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dIy6t-0005pd-Lp
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:08:27 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 41CE370CE2
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 16:08:26 +0200 (CEST)
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692937985.12119.13044357560316687626.stgit@bahia>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ca66edd1-3dba-328a-8d4f-8ae95f4fc919@kaod.org>
Date: Thu, 8 Jun 2017 16:08:21 +0200
MIME-Version: 1.0
In-Reply-To: <149692937985.12119.13044357560316687626.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/6] xics: setup cpu at realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 06/08/2017 03:42 PM, Greg Kurz wrote:
> Until recently, spapr used to allocate ICPState objects for the lifetim=
e
> of the machine. They would only be associated to vCPUs in xics_cpu_setu=
p()
> when plugging a CPU core.
>=20
> Now that ICPState objects have the same lifecycle as vCPUs, it is
> possible to associate them during realization.
>=20
> This patch hence open-codes xics_cpu_setup() in icp_realize(). The vCPU
> is passed as a property. Note that vCPU now needs to be realized first
> for the IRQs to be allocated. It also needs to resetted before ICPState
> realization in order to synchronize with KVM.
>=20
> Since ICPState objects are freed when unrealized, xics_cpu_destroy() is=
n't
> needed anymore and can be safely dropped.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

I don't like the "ICP_PROP_CPU" define. A part from that :

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.


> ---
> v4: - renamed property from "cs" to "cpu" and make it a macro (ICP_PROP=
_CPU)
>     - fixed copy/paste mistake in error message in icp_realize()
> ---
>  hw/intc/xics.c          |   76 ++++++++++++++++++++-------------------=
--------
>  hw/ppc/pnv_core.c       |   18 +++++------
>  hw/ppc/spapr_cpu_core.c |   23 ++++++--------
>  include/hw/ppc/xics.h   |    3 +-
>  4 files changed, 51 insertions(+), 69 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index f74a96e932d7..fdbfddffeea5 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -38,50 +38,6 @@
>  #include "monitor/monitor.h"
>  #include "hw/intc/intc.h"
> =20
> -void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
> -{
> -    CPUState *cs =3D CPU(cpu);
> -    ICPState *icp =3D ICP(cpu->intc);
> -
> -    assert(icp);
> -    assert(cs =3D=3D icp->cs);
> -
> -    icp->output =3D NULL;
> -    icp->cs =3D NULL;
> -}
> -
> -void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu, ICPState *icp)
> -{
> -    CPUState *cs =3D CPU(cpu);
> -    CPUPPCState *env =3D &cpu->env;
> -    ICPStateClass *icpc;
> -
> -    assert(icp);
> -
> -    cpu->intc =3D OBJECT(icp);
> -    icp->cs =3D cs;
> -
> -    icpc =3D ICP_GET_CLASS(icp);
> -    if (icpc->cpu_setup) {
> -        icpc->cpu_setup(icp, cpu);
> -    }
> -
> -    switch (PPC_INPUT(env)) {
> -    case PPC_FLAGS_INPUT_POWER7:
> -        icp->output =3D env->irq_inputs[POWER7_INPUT_INT];
> -        break;
> -
> -    case PPC_FLAGS_INPUT_970:
> -        icp->output =3D env->irq_inputs[PPC970_INPUT_INT];
> -        break;
> -
> -    default:
> -        error_report("XICS interrupt controller does not support this =
CPU "
> -                     "bus model");
> -        abort();
> -    }
> -}
> -
>  void icp_pic_print_info(ICPState *icp, Monitor *mon)
>  {
>      int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
> @@ -343,6 +299,8 @@ static void icp_realize(DeviceState *dev, Error **e=
rrp)
>  {
>      ICPState *icp =3D ICP(dev);
>      ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
> +    PowerPCCPU *cpu;
> +    CPUPPCState *env;
>      Object *obj;
>      Error *err =3D NULL;
> =20
> @@ -355,6 +313,36 @@ static void icp_realize(DeviceState *dev, Error **=
errp)
> =20
>      icp->xics =3D XICS_FABRIC(obj);
> =20
> +    obj =3D object_property_get_link(OBJECT(dev), ICP_PROP_CPU, &err);
> +    if (!obj) {
> +        error_setg(errp, "%s: required link '" ICP_PROP_CPU "' not fou=
nd: %s",
> +                   __func__, error_get_pretty(err));
> +        return;
> +    }
> +
> +    cpu =3D POWERPC_CPU(obj);
> +    cpu->intc =3D OBJECT(icp);
> +    icp->cs =3D CPU(obj);
> +
> +    if (icpc->cpu_setup) {
> +        icpc->cpu_setup(icp, cpu);
> +    }
> +
> +    env =3D &cpu->env;
> +    switch (PPC_INPUT(env)) {
> +    case PPC_FLAGS_INPUT_POWER7:
> +        icp->output =3D env->irq_inputs[POWER7_INPUT_INT];
> +        break;
> +
> +    case PPC_FLAGS_INPUT_970:
> +        icp->output =3D env->irq_inputs[PPC970_INPUT_INT];
> +        break;
> +
> +    default:
> +        error_setg(errp, "XICS interrupt controller does not support t=
his CPU bus model");
> +        return;
> +    }
> +
>      if (icpc->realize) {
>          icpc->realize(icp, errp);
>      }
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 0b6e72950ca3..c7b00b610c1e 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -118,20 +118,20 @@ static void pnv_core_realize_child(Object *child,=
 XICSFabric *xi, Error **errp)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      Object *obj;
> =20
> -    obj =3D object_new(TYPE_PNV_ICP);
> -    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> -    object_unref(obj);
> -    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
> -                                   &error_abort);
> -    object_property_set_bool(obj, true, "realized", &local_err);
> +    object_property_set_bool(child, true, "realized", &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
> =20
> -    object_property_set_bool(child, true, "realized", &local_err);
> +    obj =3D object_new(TYPE_PNV_ICP);
> +    object_property_add_child(child, "icp", obj, NULL);
> +    object_unref(obj);
> +    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
> +                                   &error_abort);
> +    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_ab=
ort);
> +    object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
> -        object_unparent(obj);
>          error_propagate(errp, local_err);
>          return;
>      }
> @@ -142,8 +142,6 @@ static void pnv_core_realize_child(Object *child, X=
ICSFabric *xi, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -
> -    xics_cpu_setup(xi, cpu, ICP(obj));
>  }
> =20
>  static void pnv_core_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index e81879c7cad7..9fb896b407db 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -53,9 +53,6 @@ static void spapr_cpu_reset(void *opaque)
> =20
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> -
> -    xics_cpu_destroy(XICS_FABRIC(spapr), cpu);
>      qemu_unregister_reset(spapr_cpu_reset, cpu);
>  }
> =20
> @@ -140,29 +137,29 @@ static void spapr_cpu_core_realize_child(Object *=
child, Error **errp)
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      CPUState *cs =3D CPU(child);
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -    Object *obj;
> +    Object *obj =3D NULL;
> =20
> -    obj =3D object_new(spapr->icp_type);
> -    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> -    object_unref(obj);
> -    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(spapr),
> -                                   &error_abort);
> -    object_property_set_bool(obj, true, "realized", &local_err);
> +    object_property_set_bool(child, true, "realized", &local_err);
>      if (local_err) {
>          goto error;
>      }
> =20
> -    object_property_set_bool(child, true, "realized", &local_err);
> +    spapr_cpu_init(spapr, cpu, &local_err);
>      if (local_err) {
>          goto error;
>      }
> =20
> -    spapr_cpu_init(spapr, cpu, &local_err);
> +    obj =3D object_new(spapr->icp_type);
> +    object_property_add_child(child, "icp", obj, &error_abort);
> +    object_unref(obj);
> +    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(spapr),
> +                                   &error_abort);
> +    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_ab=
ort);
> +    object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>          goto error;
>      }
> =20
> -    xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
>      return;
> =20
>  error:
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 797df82fefc0..37b8fb1e8817 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -87,6 +87,7 @@ struct ICPState {
>  };
> =20
>  #define ICP_PROP_XICS "xics"
> +#define ICP_PROP_CPU "cpu"
> =20
>  struct PnvICPState {
>      ICPState parent_obj;
> @@ -187,8 +188,6 @@ void spapr_dt_xics(int nr_servers, void *fdt, uint3=
2_t phandle);
> =20
>  qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
>  ICPState *xics_icp_get(XICSFabric *xi, int server);
> -void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu, ICPState *icp);
> -void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu);
> =20
>  /* Internal XICS interfaces */
>  void icp_set_cppr(ICPState *icp, uint8_t cppr);
>=20
