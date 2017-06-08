Received: from eggs.gnu.org ([2001:4830:134:3::10]:39930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImlS-0007Xn-1r
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 22:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImlQ-0004Wy-K4
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 22:01:34 -0400
Date: Thu, 8 Jun 2017 12:01:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608020112.GT13397@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582923.12025.13700165807436904935.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QQ8SllDnVL7XJJuW"
Content-Disposition: inline
In-Reply-To: <149685582923.12025.13700165807436904935.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] xics: setup cpu at realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--QQ8SllDnVL7XJJuW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 07:17:09PM +0200, Greg Kurz wrote:
> Until recently, spapr used to allocate ICPState objects for the lifetime
> of the machine. They would only be associated to vCPUs in xics_cpu_setup()
> when plugging a CPU core.
>=20
> Now that ICPState objects have the same lifecycle as vCPUs, it is
> possible to associate them during realization.
>=20
> This patch hence open-codes xics_cpu_setup() in icp_realize(). The vCPU
> is passed as a property. Note that vCPU now needs to be realized first
> for the IRQs to be allocated. It also needs to resetted before ICPState
> realization in order to synchronize with KVM.

Ok, what enforces those ordering constraints?

> Since ICPState objects are freed when unrealized, xics_cpu_destroy() isn't
> needed anymore and can be safely dropped.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Looks pretty good, though a couple nits below.

> ---
>  hw/intc/xics.c          |   76 ++++++++++++++++++++---------------------=
------
>  hw/ppc/pnv_core.c       |   16 ++++------
>  hw/ppc/spapr_cpu_core.c |   21 ++++++-------
>  include/hw/ppc/xics.h   |    2 -
>  4 files changed, 48 insertions(+), 67 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index ec73f02144c9..330441ff7fe8 100644
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
> -        error_report("XICS interrupt controller does not support this CP=
U "
> -                     "bus model");
> -        abort();
> -    }
> -}
> -
>  void icp_pic_print_info(ICPState *icp, Monitor *mon)
>  {
>      int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
> @@ -343,6 +299,8 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
>  {
>      ICPState *icp =3D ICP(dev);
>      ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
> +    PowerPCCPU *cpu;
> +    CPUPPCState *env;
>      Object *obj;
>      Error *err =3D NULL;
> =20
> @@ -355,6 +313,36 @@ static void icp_realize(DeviceState *dev, Error **er=
rp)
> =20
>      icp->xics =3D XICS_FABRIC(obj);
> =20
> +    obj =3D object_property_get_link(OBJECT(dev), "cs", &err);

I don't like the name "cs" for an externally visible property.  "cpu"
would be better.

> +    if (!obj) {
> +        error_setg(errp, "%s: required link 'xics' not found: %s",

Copy/paste mistake in this message.

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
> +        error_setg(errp, "XICS interrupt controller does not support thi=
s CPU bus model");
> +        return;
> +    }
> +
>      if (icpc->realize) {
>          icpc->realize(dev, errp);
>      }
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index e8a9a94d5a24..1393005e76f3 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -118,19 +118,19 @@ static void pnv_core_realize_child(Object *child, X=
ICSFabric *xi, Error **errp)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      Object *obj;
> =20
> -    obj =3D object_new(TYPE_PNV_ICP);
> -    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> -    object_unref(obj);
> -    object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abort=
);
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
> +    object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abort=
);
> +    object_property_add_const_link(obj, "cs", child, &error_abort);
> +    object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
> -        object_unparent(obj);
>          error_propagate(errp, local_err);
>          return;
>      }
> @@ -141,8 +141,6 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -
> -    xics_cpu_setup(xi, cpu, ICP(obj));
>  }
> =20
>  static void pnv_core_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 029a14120edd..9a6259525953 100644
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
> @@ -140,28 +137,28 @@ static void spapr_cpu_core_realize_child(Object *ch=
ild, Error **errp)
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      CPUState *cs =3D CPU(child);
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -    Object *obj;
> +    Object *obj =3D NULL;
> =20
> -    obj =3D object_new(spapr->icp_type);
> -    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> -    object_unref(obj);
> -    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_ab=
ort);
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
> +    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_ab=
ort);
> +    object_property_add_const_link(obj, "cs", child, &error_abort);
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
> index 40a506eacfb4..05767a15be9a 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -183,8 +183,6 @@ void spapr_dt_xics(int nr_servers, void *fdt, uint32_=
t phandle);
> =20
>  qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
>  ICPState *xics_icp_get(XICSFabric *xi, int server);
> -void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu, ICPState *icp);
> -void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu);
> =20
>  /* Internal XICS interfaces */
>  void icp_set_cppr(ICPState *icp, uint8_t cppr);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QQ8SllDnVL7XJJuW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOK/oAAoJEGw4ysog2bOSjHYQAI7n4W/C0HRYZcwhsNhNaOs+
N93E7T2LI3J+KRgEnIfuwXh8mxsqBCEX8od550pPDEb8tNY+p8tvskhbaWC27QWz
Fahv0o1L68sKjKQWFbmK1qjqhxV3WlIqLRWVBr+9NxqVjI8ai48SeOP4qxoRovO1
fUSwEzdXGuE6Ts7t88yK/Ieiv6wgQCU4CsDFyVwdF8pQlTWtwSTR26XTiZQPxyPA
KUfP5OR8JkVHGzWMqXvSoIh/gwCqDQp0zNyuzHpro9Fze4Nwjk3vxnoMAkk6KPon
y7k+bqwfNhtsazABuVhwN/9bc1cNBEu8G0ukbNp050osWgBEK9atHFLYRpCn5HoB
Syfzr/YUsNK+HIF1elALjKniCJL3lcTF2GjV+BlWdt7ZiB6RfJ9sAI9RHn++q+1V
cr/A/emEgtmYOHaluo+AyaOjLsAzxtCiDPAGYEfzD8AVg/vQB98iepdUHHJ4XaaA
9YF6MHfyYCBkOMRJsnbzLAE1A9TqVPzMXXdmvW1KFJAjgGACX+pBRwZj5ycBwi5K
TQDGEUJQYEvIiI60+wY6+Bobw8DwBN1O5i4WgSEfWXOGbnJ1uqDhIB8b5OvoVnyE
rtEt9iUXH7q7uPuH/SM3cV3kJ3rMm3RQnx5QRi1v1VTylfmABf3XurlEJtlPA0jV
5Mob99YGDZETLLS6gaIH
=ipCY
-----END PGP SIGNATURE-----

--QQ8SllDnVL7XJJuW--
