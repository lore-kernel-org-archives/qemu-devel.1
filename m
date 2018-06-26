Received: from eggs.gnu.org ([2001:4830:134:3::10]:49449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXfVu-00082t-2K
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 00:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXfVs-0002FL-Tt
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 00:23:34 -0400
Date: Tue, 26 Jun 2018 13:21:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180626032156.GC14434@umbus.fritz.box>
References: <20180625091718.18544-1-clg@kaod.org>
	<20180625091718.18544-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20180625091718.18544-6-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] ppc/xics: rework the ICS classes
 inheritance tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 11:17:18AM +0200, C=E9dric Le Goater wrote:
> With the previous changes, we can now let the ICS_KVM class inherit
> directly from ICS_BASE class and not from the intermediate ICS_SIMPLE.
> It makes the class hierarchy much cleaner.
>=20
> What is left in the top classes is the low level interface to access
> the KVM XICS device in ICS_KVM and the XICS emulating handlers in
> ICS_SIMPLE.
>=20
> This should not break migration compatibility.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics_kvm.c | 12 +++++-------
>  hw/ppc/spapr.c     |  2 +-
>  2 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index b314eb7d1607..30c3769a2084 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -359,12 +359,10 @@ static void ics_kvm_class_init(ObjectClass *klass, =
void *data)
>      ICSStateClass *icsc =3D ICS_BASE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    /*
> -     * Use device_class_set_parent_realize() when ics-kvm inherits
> -     * directly from ics-base and not from ics-simple anymore.
> -     */
> -    dc->realize =3D ics_kvm_realize;
> -    dc->reset =3D ics_kvm_reset;
> +    device_class_set_parent_realize(dc, ics_kvm_realize,
> +                                    &icsc->parent_realize);
> +    device_class_set_parent_reset(dc, ics_kvm_reset,
> +                                  &icsc->parent_reset);
> =20
>      icsc->pre_save =3D ics_get_kvm_state;
>      icsc->post_load =3D ics_set_kvm_state;
> @@ -373,7 +371,7 @@ static void ics_kvm_class_init(ObjectClass *klass, vo=
id *data)
> =20
>  static const TypeInfo ics_kvm_info =3D {
>      .name =3D TYPE_ICS_KVM,
> -    .parent =3D TYPE_ICS_SIMPLE,
> +    .parent =3D TYPE_ICS_BASE,
>      .instance_size =3D sizeof(ICSState),
>      .class_init =3D ics_kvm_class_init,
>  };
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0d032a1ad03c..8cc996d0b822 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -137,7 +137,7 @@ static ICSState *spapr_ics_create(sPAPRMachineState *=
spapr,
>          goto error;
>      }
> =20
> -    return ICS_SIMPLE(obj);
> +    return ICS_BASE(obj);
> =20
>  error:
>      error_propagate(errp, local_err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsxsVIACgkQbDjKyiDZ
s5JULhAAjbcDPyC9jiAwqUmFqzbcDsRFGPC4mz6xB74flf5GXGN4XqWlaKEXrFCL
s0V+jS8sSc6b0pFeY46C5f6+OM22uXo8TOSWf2hwJpDAWnaj1o1CHfiO4BsoFSsK
wNxyOxkwMLpF1i6yHBpvtIz7b6d3Q+xp4o1vL9ZFSV06ee6b/3+q2OZkGRY2ox/f
C4Fq+6ryRhPbXz5ydks66IfX3XFov5Hd4wgdkQEO4Ia9B4GLDEnSLMxMhQeg4gqD
2CI9IDlmjS4t/UP1NUYLrN3LV8itprdB9eQxelw5IQf4q+3RLDyt0srrF/aRddk4
wKhwU2MYBFHfABGMNp3xgIIhG9/PaNWqTUKD9L3n82kopbOJMk+dgJju1/3jZCDp
3KDyRljqJk8O9AALaHxZs3Yz64z4WGnjcV4bM9Te5sDTCX5F+FktM4xEIlg1bpcl
Hg9wQ6PBUMSw/dTnzGYTDaKCX6cvNSw1m5wtrWoY4F9dCknxBy5f1Y+y6HmpUMwW
FYYj3QuNCFlW3YNUB8KwO3iIqV5dXgqiI7VcUPGCaYva5H3p1Ysu0JooRH9jeqWQ
gA9ai+6ZSoABXktObabZyQsnSgEfmjUaGLre3rD1D028slmxkYZibBzJatp4PPrc
5UMJ/QtsqIGEeGO+unY8gpQuRb15ehDH80XTr1IPip3zuYqrxw4=
=O+gw
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
