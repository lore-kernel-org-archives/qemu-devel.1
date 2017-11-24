Received: from eggs.gnu.org ([2001:4830:134:3::10]:40139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI4QH-0004x2-Du
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 22:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI4QD-0005ls-AJ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 22:13:01 -0500
Date: Fri, 24 Nov 2017 13:51:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171124025100.GA28000@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 01/25] ppc/xics: introduce an icp_create()
 helper
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


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:31PM +0100, C=E9dric Le Goater wrote:
> The sPAPR and the PowerNV core objects create the interrupt presenter
> object of the CPUs in a very similar way. Let's provide a common
> routine in which we use the presenter 'type' as a child identifier.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

One tiny nit.., apart from that

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/xics.c          | 22 ++++++++++++++++++++++
>  hw/ppc/pnv_core.c       | 10 +---------
>  hw/ppc/spapr_cpu_core.c | 13 ++-----------
>  include/hw/ppc/xics.h   |  3 +++
>  4 files changed, 28 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index a1cc0e420c98..e4ccdff8f577 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -384,6 +384,28 @@ static const TypeInfo icp_info =3D {
>      .class_size =3D sizeof(ICPStateClass),
>  };
> =20
> +Object *icp_create(CPUState *cs, const char *type, XICSFabric *xi, Error=
 **errp)
> +{
> +    Object *child =3D OBJECT(cs);

In the original context 'child' made sense, since it was the child
object of the core.  Here, it's misleading, since it's the parent of
the xics link.  It's only used in a couple of places, so I suggest you
just opencode OBJECT(cs) in each place.

> +    Error *local_err =3D NULL;
> +    Object *obj;
> +
> +    obj =3D object_new(type);
> +    object_property_add_child(child, type, obj, &error_abort);
> +    object_unref(obj);
> +    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
> +                                   &error_abort);
> +    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_abor=
t);
> +    object_property_set_bool(obj, true, "realized", &local_err);
> +    if (local_err) {
> +        object_unparent(obj);
> +        error_propagate(errp, local_err);
> +        obj =3D NULL;
> +    }
> +
> +    return obj;
> +}
> +
>  /*
>   * ICS: Source layer
>   */
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 82ff440b3334..a066736846f8 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -126,7 +126,6 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
>      Error *local_err =3D NULL;
>      CPUState *cs =3D CPU(child);
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -    Object *obj;
> =20
>      object_property_set_bool(child, true, "realized", &local_err);
>      if (local_err) {
> @@ -134,13 +133,7 @@ static void pnv_core_realize_child(Object *child, XI=
CSFabric *xi, Error **errp)
>          return;
>      }
> =20
> -    obj =3D object_new(TYPE_PNV_ICP);
> -    object_property_add_child(child, "icp", obj, NULL);
> -    object_unref(obj);
> -    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
> -                                   &error_abort);
> -    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_abor=
t);
> -    object_property_set_bool(obj, true, "realized", &local_err);
> +    icp_create(cs, TYPE_PNV_ICP, xi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -148,7 +141,6 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
> =20
>      powernv_cpu_init(cpu, &local_err);
>      if (local_err) {
> -        object_unparent(obj);
>          error_propagate(errp, local_err);
>          return;
>      }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 4ba8563d49e4..f8a520a2fa2d 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -111,7 +111,6 @@ static void spapr_cpu_core_realize_child(Object *chil=
d,
>      Error *local_err =3D NULL;
>      CPUState *cs =3D CPU(child);
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -    Object *obj;
> =20
>      object_property_set_bool(child, true, "realized", &local_err);
>      if (local_err) {
> @@ -123,21 +122,13 @@ static void spapr_cpu_core_realize_child(Object *ch=
ild,
>          goto error;
>      }
> =20
> -    obj =3D object_new(spapr->icp_type);
> -    object_property_add_child(child, "icp", obj, &error_abort);
> -    object_unref(obj);
> -    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(spapr),
> -                                   &error_abort);
> -    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_abor=
t);
> -    object_property_set_bool(obj, true, "realized", &local_err);
> +    icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &local_err);
>      if (local_err) {
> -        goto free_icp;
> +        goto error;
>      }
> =20
>      return;
> =20
> -free_icp:
> -    object_unparent(obj);
>  error:
>      error_propagate(errp, local_err);
>  }
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 2df99be111ce..126b47dec38b 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -212,4 +212,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
>  void xics_spapr_init(sPAPRMachineState *spapr);
> =20
> +Object *icp_create(CPUState *cs, const char *type, XICSFabric *xi,
> +                   Error **errp);
> +
>  #endif /* XICS_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloXiRIACgkQbDjKyiDZ
s5JJLBAAixaGqC93g8GwOi3ngiHeym8ay5533hxto7G8st2sMfg8k1rb0dZpOy5p
8MfiGiXtMHYQDF+h1H/1iDyUenM8GDCuOL5oQn33Lyu3OxKwUFiiYeaJMvtvBvp5
rUsNBoTTJE2LfFAE5me4QununQYRt8196c7uT/xE78MaF3rOOKkO1XavgG8pmoBz
s5OsO8xRkFjzpNDv+Bhcg7WBALWOwGESwVG18p/ScQFlQVLVmpi/nc2X0WitFhYU
RNunmLGeLGoOX/sqhp9qNBSTkni2OVOndl5eUcyPAI6XwsgcOFJopSCotWkkS8W6
ib99kySSbzLwhkjN28wp57xHZ0oLEfvnp+4TFLEplCSl8uuh2HUS5ZG5ScY856Aj
2LSwy/gt1F9SdBoJiw0OKLUF10uVi/nnehULBriCOPYWCOalsZ/6dq1uBQjG/RZC
5HyZJFyYAWrBnICM6l2Iv2T8koG5W+nhx5fKUcf9jy/1beWLqfj1MURoU1Ud9kD5
NSxH7qNg1xCAaSmOEUT8uEmsmPbgX8/uFX9RH1qakMZrqMxfhJ4BILdYbwSzAEcH
b7UrschBxgF/OXGXjqa6c/OA9qsWrpD5Zm31yum/mtIYOdwKrEXzQ5ThmiC4R05E
Wj2D1JxOjIlJ02JONipsvxbeFgZzLpGt5jRQr/bPy5AXzMz9VNc=
=3/mi
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
