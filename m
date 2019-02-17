Received: from eggs.gnu.org ([209.51.188.92]:52603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiA-0008Bk-KQ
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi9-0005dL-Jf
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:06 -0500
Date: Mon, 18 Feb 2019 10:41:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217234148.GH2765@umbus.fritz.box>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023082407.1011724.1983100830860273401.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hAW+M2+FUO+onfmf"
Content-Disposition: inline
In-Reply-To: <155023082407.1011724.1983100830860273401.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 07/10] xics: Handle KVM ICS reset from the
 "simple" ICS code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--hAW+M2+FUO+onfmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 12:40:24PM +0100, Greg Kurz wrote:
> The KVM ICS reset handler simply writes the ICS state to KVM. This
> doesn't need the overkill parent_reset logic we have today. Also
> we want to use the same ICS type for the KVM and non-KVM case with
> pseries.
>=20
> Call icp_set_kvm_state() from the "simple" ICS reset function.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics.c     |    4 ++++
>  hw/intc/xics_kvm.c |   18 ------------------
>  2 files changed, 4 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index ae5d5ea135b8..49401745c410 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -553,6 +553,10 @@ static void ics_simple_reset(DeviceState *dev)
>      ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
> =20
>      icsc->parent_reset(dev);
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        ics_set_kvm_state(ICS_BASE(dev));
> +    }
>  }
> =20
>  static void ics_simple_reset_handler(void *dev)
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 642351e5790f..e7b8d4c29ce6 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -280,20 +280,6 @@ void ics_kvm_set_irq(void *opaque, int srcno, int va=
l)
>      }
>  }
> =20
> -static void ics_kvm_reset(DeviceState *dev)
> -{
> -    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
> -
> -    icsc->parent_reset(dev);
> -
> -    ics_set_kvm_state(ICS_KVM(dev));
> -}
> -
> -static void ics_kvm_reset_handler(void *dev)
> -{
> -    ics_kvm_reset(dev);
> -}
> -
>  static void ics_kvm_realize(DeviceState *dev, Error **errp)
>  {
>      ICSState *ics =3D ICS_KVM(dev);
> @@ -305,8 +291,6 @@ static void ics_kvm_realize(DeviceState *dev, Error *=
*errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -
> -    qemu_register_reset(ics_kvm_reset_handler, ics);
>  }
> =20
>  static void ics_kvm_class_init(ObjectClass *klass, void *data)
> @@ -316,8 +300,6 @@ static void ics_kvm_class_init(ObjectClass *klass, vo=
id *data)
> =20
>      device_class_set_parent_realize(dc, ics_kvm_realize,
>                                      &icsc->parent_realize);
> -    device_class_set_parent_reset(dc, ics_kvm_reset,
> -                                  &icsc->parent_reset);
>  }
> =20
>  static const TypeInfo ics_kvm_info =3D {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hAW+M2+FUO+onfmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp8TsACgkQbDjKyiDZ
s5LoIBAAnv31rhEOfAGKKeSjkl5yhPrEHzZVIIGX4ct5QUMNh0ncYVzpzhTf2d0c
2UlMTO6TAuMSwhW3xbRVWlq9Gw7zCN2MVXpTSWx9uh+/8sRSm0d3s4EnlmmARK2Q
2U3iu5xFDUcVqSWT/wZiQPUDdkQoTMuofe6jzIU5mWSRKlZ5IIhd+IznHsvGS8/s
ehKh4OG7+B/Ay1Yz6Qo5hVmev/Zo8mrSEi00V0N8JeHWgtW7cX3HBmyfTo6rU7LJ
f1x6xGFmnPQPwfjOF+wj5dtPmwGP+dQyv2PPB92KaG0+melFS7DWi4KW6iYAxicp
JPL72c9FDQkUe0g2Q0dVaf65bsK6ZIk3ps0F12QUBTDMnYI4N3wJonFX6+1mN98Z
LDatsXucAe+PXrVY9NGCMDZ4WRBQf4vCAH9DaLUrfVYI/tLWBinQnxLr1KyiXZb7
DAakdacqWNhcrZu1zxB0yrVcZPkg4e1j6F1+Dhn5DOh4S0B+vuJ/PniQvZ5Z+qbL
bLJqKKAHbtICzAi4h4cMWKbABv4Nh5m9Q3WsdLE2U6QkFqL+dmBtwyCJc42mZhNt
AlFGLfkUmPC2QHs0GUqAfzN1wF7s4jpokxrEpvinoarAOp+oKe524FNAW7TD3USw
qBEtuYsJ3768oGLgDVSXr+B/SJ+gHqwPtWJ/z1UDQUL6ln+o/Pw=
=TBne
-----END PGP SIGNATURE-----

--hAW+M2+FUO+onfmf--
