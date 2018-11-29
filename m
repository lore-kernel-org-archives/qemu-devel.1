Received: from eggs.gnu.org ([2001:4830:134:3::10]:42330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBG-0004Zz-Et
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBC-0008K3-R1
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:02 -0500
Date: Thu, 29 Nov 2018 15:08:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129040806.GE14697@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-29-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-29-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 28/36] ppc/xics: introduce a
 icp_kvm_init() routine
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


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:21AM +0100, C=E9dric Le Goater wrote:
> This routine gathers all the KVM initialization of the XICS KVM
> presenter. It will be useful when the initialization of the KVM XICS
> device is moved to a global routine.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I dislike calling things *_init() because it's not clear which of
qemu's many "init" hooks it belongs with.

> ---
>  hw/intc/xics_kvm.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index e8fa9a53aeba..efad1b19d821 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -123,11 +123,8 @@ static void icp_kvm_reset(DeviceState *dev)
>      icp_set_kvm_state(ICP(dev), 1);
>  }
> =20
> -static void icp_kvm_realize(DeviceState *dev, Error **errp)
> +static void icp_kvm_init(ICPState *icp, Error **errp)
>  {
> -    ICPState *icp =3D ICP(dev);
> -    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
> -    Error *local_err =3D NULL;
>      CPUState *cs;
>      KVMEnabledICP *enabled_icp;
>      unsigned long vcpu_id;
> @@ -137,12 +134,6 @@ static void icp_kvm_realize(DeviceState *dev, Error =
**errp)
>          abort();
>      }
> =20
> -    icpc->parent_realize(dev, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
>      cs =3D icp->cs;
>      vcpu_id =3D kvm_arch_vcpu_id(cs);
> =20
> @@ -168,6 +159,24 @@ static void icp_kvm_realize(DeviceState *dev, Error =
**errp)
>      QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
>  }
> =20
> +static void icp_kvm_realize(DeviceState *dev, Error **errp)
> +{
> +    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
> +    Error *local_err =3D NULL;
> +
> +    icpc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    icp_kvm_init(ICP(dev), &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +}
> +
>  static void icp_kvm_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv/ZiYACgkQbDjKyiDZ
s5JU3hAAy8WwErLS5jha2/TR2BiE6oCfyLcKKyFZOW7VimQWJbapBeVBHEsHKLO1
la/3I1L/6NXeijv5nZBw1vjuek9VHQkS3fVPLx8AefV9eMtv1Uay0qTDb/+SjPr5
PEyQTq0SplPHfVOqvFIXOHfTmZ1sogQFTvfEsyGqreVUSoMIauj5An1ZuuZ7UgTI
qBQHMUYxCN8DGlvwTPzH3w4MafNiFUS3rUpyPIdKBHJu+xdhTyow0sBhS1BU5NAD
5eAqJHY2ed/tk1HQbpEL7FhugZm6H2ZHLVrKdbzlIBkgZ4ctzZHrqbmxk3oXu9/Q
t4vSkC6bwuGOC7ledUNyQaJbJ3wNMsfV0ARGK2Pquh+b609HCe2+O/ObVBfoxYLh
E5AKATjpR/YOhobAU/1t2MgL1nyhCdTJFh2zz3S4XhPpmOcOY1ULg4693GqHT5CA
dehN5L543IL4qTaEh85z4ZjN8T62cbodKXAkrjilbLLbuIUywBcSsvZgKLkUJ8LO
W4RAHXsHa4XfZV+bhBI9m3ajZ95sxvjkrk/f5QCuNflL7MGJcRvopFu9mnz71yMl
16RH84/chAcSerl2vZ7+acBmetfKshVaPB5Ok1mdkBJW+zDDpEcrhFPCcZNKPv1W
6jNLNTvetaUHfIw6pSFcIZGxZhf0Vkkc0rSU86LYRPrLzocloFU=
=b5MX
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--
