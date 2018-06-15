Received: from eggs.gnu.org ([2001:4830:134:3::10]:46308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcIr-0003kz-HV
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcIo-00004v-C3
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:09:21 -0400
Date: Fri, 15 Jun 2018 10:05:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615000526.GD4129@umbus.fritz.box>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901305726.252222.7317082325256499414.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <152901305726.252222.7317082325256499414.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 4/5] spapr_cpu_core: introduce
 spapr_create_vcpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 11:50:57PM +0200, Greg Kurz wrote:
> This moves some code out from spapr_cpu_core_realize() for clarity. No
> functional change.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/ppc/spapr_cpu_core.c |   73 +++++++++++++++++++++++++++++------------=
------
>  1 file changed, 45 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 04c818a6ecac..0ebaf804a9bc 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -172,6 +172,49 @@ error:
>      error_propagate(errp, local_err);
>  }
> =20
> +static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **er=
rp)
> +{
> +    sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(sc);
> +    CPUCore *cc =3D CPU_CORE(sc);
> +    Object *obj;
> +    char *id;
> +    CPUState *cs;
> +    PowerPCCPU *cpu;
> +    Error *local_err =3D NULL;
> +
> +    obj =3D object_new(scc->cpu_type);
> +
> +    cs =3D CPU(obj);
> +    cpu =3D POWERPC_CPU(obj);
> +    cs->cpu_index =3D cc->core_id + i;
> +    spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
> +    if (local_err) {
> +        goto err;
> +    }
> +
> +    cpu->node_id =3D sc->node_id;
> +
> +    id =3D g_strdup_printf("thread[%d]", i);
> +    object_property_add_child(OBJECT(sc), id, obj, &local_err);
> +    g_free(id);
> +    if (local_err) {
> +        goto err;
> +    }
> +
> +    object_unref(obj);
> +    return cpu;
> +
> +err:
> +    object_unref(obj);
> +    error_propagate(errp, local_err);
> +    return NULL;
> +}
> +
> +static void spapr_delete_vcpu(PowerPCCPU *cpu)
> +{
> +    object_unparent(OBJECT(cpu));
> +}
> +
>  static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>  {
>      /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
> @@ -181,10 +224,8 @@ static void spapr_cpu_core_realize(DeviceState *dev,=
 Error **errp)
>          (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
>                                                    TYPE_SPAPR_MACHINE);
>      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> -    sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
>      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
>      Error *local_err =3D NULL;
> -    Object *obj;
>      int i, j;
> =20
>      if (!spapr) {
> @@ -194,33 +235,10 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> =20
>      sc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
>      for (i =3D 0; i < cc->nr_threads; i++) {
> -        char *id;
> -        CPUState *cs;
> -        PowerPCCPU *cpu;
> -
> -        obj =3D object_new(scc->cpu_type);
> -
> -        cs =3D CPU(obj);
> -        cpu =3D sc->threads[i] =3D POWERPC_CPU(obj);
> -        cs->cpu_index =3D cc->core_id + i;
> -        spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
> -        if (local_err) {
> -            object_unref(obj);
> -            goto err;
> -        }
> -
> -
> -        /* Set NUMA node for the threads belonged to core  */
> -        cpu->node_id =3D sc->node_id;
> -
> -        id =3D g_strdup_printf("thread[%d]", i);
> -        object_property_add_child(OBJECT(sc), id, obj, &local_err);
> -        g_free(id);
> +        sc->threads[i] =3D spapr_create_vcpu(sc, i, &local_err);
>          if (local_err) {
> -            object_unref(obj);
>              goto err;
>          }
> -        object_unref(obj);
>      }
> =20
>      for (j =3D 0; j < cc->nr_threads; j++) {
> @@ -237,8 +255,7 @@ err_unrealize:
>      }
>  err:
>      while (--i >=3D 0) {
> -        obj =3D OBJECT(sc->threads[i]);
> -        object_unparent(obj);
> +        spapr_delete_vcpu(sc->threads[i]);
>      }
>      g_free(sc->threads);
>      error_propagate(errp, local_err);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjAsYACgkQbDjKyiDZ
s5J9iQ/9FOa+FIYJeoZpU/huRVVSNMa9tZePGX5+ye4crOazdgvBip3ioKsf5nBQ
Nm8Rgg1LdHHzjjwmBi4hyd19vkCWr7zWPJNat3f2NK4kFX8QiVzbotONsOJCRkQT
4QrEcjQo9rHXS33h9k2UAQsyCzxB67PIYbBZGkV2Nc7PQPlXARJBdnrVqHQFsMRs
rDBjgQoQ3hTx+eOZG2AN3zkXFpttrQKZ6yfmshKFsu50BZBVA6YzcUdW5rysWkvb
1xmNZUD2v55rsPd6vwLT5XrIQFJH4XneSYiRdkk7DxJHTgCeJOI52SWBthLJ4xym
EohkerFSyA2WKIE+NHuC/iDgXzCV7Kif2avYlmuWfvj6GVkllWXK/9oCTEWDQPqA
UMEkjVZ7YSHgDuKIjMb3rkafoql9gVo7CRhyIlLsNjkd1Rw63nO9yeN5AIaQvQTM
ucXZ9mRK3GMJUttXAVvzm304qO6nBBo/CGeVrKTYrOcIpEWICBXetxzhtzXkD6nh
ZapdVrUMsryDeGGnCGQFZrzDiEPktk4ql7ZOHzEAzuviNoX6eoBts6IxZug+/Pl4
8V3XDoL+/nCn/n8WQVoyNC2d34u/doPzPUxmRkJa68IILB5SDMZDpkKzzr1XlkSR
hZOot6Fk08RO8QzA4jrqSePBVzJm5afVJV8WqrZTsvp7NuGwhek=
=vKpv
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
