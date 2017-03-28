Received: from eggs.gnu.org ([2001:4830:134:3::10]:51096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csift-0001Eb-LE
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 00:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csifs-0008DO-4Z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 00:24:05 -0400
Date: Tue, 28 Mar 2017 15:23:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170328042317.GD21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-7-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <1490189568-167621-7-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 06/23] spapr: add node-id property
 to sPAPR core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 02:32:31PM +0100, Igor Mammedov wrote:
> it will allow switching from cpu_index to core based numa
> mapping in follow up patches.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/spapr_cpu_core.h |  1 +
>  include/qom/cpu.h               |  2 ++
>  hw/ppc/spapr.c                  | 17 +++++++++++++++++
>  hw/ppc/spapr_cpu_core.c         | 11 ++++++++---
>  4 files changed, 28 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 3c35665..93051e9 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -27,6 +27,7 @@ typedef struct sPAPRCPUCore {
> =20
>      /*< public >*/
>      void *threads;
> +    int node_id;
>  } sPAPRCPUCore;
> =20
>  typedef struct sPAPRCPUCoreClass {
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index c3292ef..7f27d56 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -258,6 +258,8 @@ typedef void (*run_on_cpu_func)(CPUState *cpu, run_on=
_cpu_data data);
> =20
>  struct qemu_work_item;
> =20
> +#define CPU_UNSET_NUMA_NODE_ID -1
> +
>  /**
>   * CPUState:
>   * @cpu_index: CPU index (informative).
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9dcbbcc..9c61721 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2770,9 +2770,11 @@ static void spapr_core_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
>      MachineClass *mc =3D MACHINE_GET_CLASS(hotplug_dev);
>      Error *local_err =3D NULL;
>      CPUCore *cc =3D CPU_CORE(dev);
> +    sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(dev);
>      char *base_core_type =3D spapr_get_cpu_core_type(machine->cpu_model);
>      const char *type =3D object_get_typename(OBJECT(dev));
>      CPUArchId *core_slot;
> +    int node_id;
>      int index;
> =20
>      if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
> @@ -2801,6 +2803,21 @@ static void spapr_core_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
>          goto out;
>      }
> =20
> +    node_id =3D numa_get_node_for_cpu(cc->core_id);
> +    if (node_id =3D=3D nb_numa_nodes) {
> +        /* by default CPUState::numa_node was 0 if it's not set via CLI
> +         * keep it this way for now but in future we probably should
> +         * refuse to start up with incomplete numa mapping */
> +        node_id =3D 0;
> +    }
> +    if (sc->node_id =3D=3D CPU_UNSET_NUMA_NODE_ID) {
> +        sc->node_id =3D node_id;
> +    } else if (sc->node_id !=3D node_id) {
> +        error_setg(&local_err, "node-id %d must match numa node specifie=
d"
> +            "with -numa option for cpu-index %d", sc->node_id, cc->core_=
id);
> +        goto out;
> +    }
> +
>  out:
>      g_free(base_core_type);
>      error_propagate(errp, local_err);
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 6883f09..25988f8 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -163,7 +163,6 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>      const char *typename =3D object_class_get_name(scc->cpu_class);
>      size_t size =3D object_type_get_instance_size(typename);
>      Error *local_err =3D NULL;
> -    int core_node_id =3D numa_get_node_for_cpu(cc->core_id);;
>      void *obj;
>      int i, j;
> =20
> @@ -181,10 +180,10 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> =20
>          /* Set NUMA node for the added CPUs  */
>          node_id =3D numa_get_node_for_cpu(cs->cpu_index);
> -        if (node_id !=3D core_node_id) {
> +        if (node_id !=3D sc->node_id) {
>              error_setg(&local_err, "Invalid node-id=3D%d of thread[cpu-i=
ndex: %d]"
>                  " on CPU[core-id: %d, node-id: %d], node-id must be the =
same",
> -                 node_id, cs->cpu_index, cc->core_id, core_node_id);
> +                 node_id, cs->cpu_index, cc->core_id, sc->node_id);
>              goto err;
>          }
>          if (node_id < nb_numa_nodes) {
> @@ -250,6 +249,11 @@ static const char *spapr_core_models[] =3D {
>      "POWER9_v1.0",
>  };
> =20
> +static Property spapr_cpu_core_properties[] =3D {
> +    DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_N=
ODE_ID),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
>  void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> @@ -257,6 +261,7 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void =
*data)
> =20
>      dc->realize =3D spapr_cpu_core_realize;
>      dc->unrealize =3D spapr_cpu_core_unrealizefn;
> +    dc->props =3D spapr_cpu_core_properties;
>      scc->cpu_class =3D cpu_class_by_name(TYPE_POWERPC_CPU, data);
>      g_assert(scc->cpu_class);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2eU1AAoJEGw4ysog2bOSYAQQAIGGBYnYHsL4Rw5Ae5uY1FEk
FvuvoJbXv5yFCwBaCLfpJN62hPAJ3SkawAsCVqcZc6ODmBpzIa1GzzW7EfcZOaKo
5XI6BriGOLXHHn1Du2wL271TRQ3Tp3KEaucSYlRovqT6URV2/uzUJ3Y/Z574l/34
LxPwkclEcka9V6NNYxXFX2+Hpz9PCVTOITW665nb5vISlCf/egi6Rnu9ADeiImtA
GqtM5x/+7eNwUWI4qfwNO9g+zs8ZO8OV7Vh9uFS0UGfYyFALuTU3IABHKI7diuhW
NI84f71eIhRq2nRvCN2P0rI+s3FDzhrqP8H9+/GuTVBNKbXdFSTkznIaGzoM1Kq6
ZD1E3SNC5avukLt5WJypKyZ7axmnyHhiqu6hQtk1ewacrJHhKUjVwIViGfKQDre5
Unppewz8pXZG8GT8IIlfFO2xqRglIwHISlQm8ZnUB45lgoDnYQOBn7ioRZzK2l1L
MphcPU3qKZlcOciGA8/WWCenHiZx8B6Uik7Gmy7/p1cN7pFo5BUH+9ONuRk2Ju2q
iV6NU5DOjeE5nObKep2hssc+i0CTmLInKwrvoRicDRVv8TgNMUjP3xbWBxTWeMXR
8dgL5QR5P81CsKG9SVc4HOQtGnQOiToJTWf4Eijhn85AWDZfU1QCXtjJBA3bItSI
klgVOIapBzlidr43vP/Z
=cGBR
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
