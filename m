Received: from eggs.gnu.org ([2001:4830:134:3::10]:56563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDgzS-0001X3-H6
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDgzR-0008Iq-8c
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:50:58 -0400
Date: Thu, 25 May 2017 10:32:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170525003238.GB12929@umbus.fritz.box>
References: <149564764390.1804.5304274992848891131.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <149564764390.1804.5304274992848891131.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] xics: add unrealize handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 07:40:43PM +0200, Greg Kurz wrote:
> Now that ICPState objects get finalized on CPU unplug, we should unregist=
er
> reset handlers as well to avoid a QEMU crash at machine reset time.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.10.

> ---
>  hw/intc/xics.c     |    5 +++++
>  hw/intc/xics_kvm.c |    6 ++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 292fffecd376..ea3516794af7 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -357,6 +357,10 @@ static void icp_realize(DeviceState *dev, Error **er=
rp)
>      qemu_register_reset(icp_reset, dev);
>  }
> =20
> +static void icp_unrealize(DeviceState *dev, Error **errp)
> +{
> +    qemu_unregister_reset(icp_reset, dev);
> +}
> =20
>  static void icp_class_init(ObjectClass *klass, void *data)
>  {
> @@ -364,6 +368,7 @@ static void icp_class_init(ObjectClass *klass, void *=
data)
> =20
>      dc->vmsd =3D &vmstate_icp_server;
>      dc->realize =3D icp_realize;
> +    dc->unrealize =3D icp_unrealize;
>  }
> =20
>  static const TypeInfo icp_info =3D {
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index dd7f29846235..14b8f6f6e478 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -164,12 +164,18 @@ static void icp_kvm_realize(DeviceState *dev, Error=
 **errp)
>      qemu_register_reset(icp_kvm_reset, dev);
>  }
> =20
> +static void icp_kvm_unrealize(DeviceState *dev, Error **errp)
> +{
> +    qemu_unregister_reset(icp_kvm_reset, dev);
> +}
> +
>  static void icp_kvm_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      ICPStateClass *icpc =3D ICP_CLASS(klass);
> =20
>      dc->realize =3D icp_kvm_realize;
> +    dc->unrealize =3D icp_kvm_unrealize;
>      icpc->pre_save =3D icp_get_kvm_state;
>      icpc->post_load =3D icp_set_kvm_state;
>      icpc->cpu_setup =3D icp_kvm_cpu_setup;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJiYkAAoJEGw4ysog2bOS1Z8QAKEzIKS5Y3MeaXebbWIdYuUJ
PJIJU5YTJWv/TpevMFLwM1VvQFNMKQIsSsBiNVHuuke6rQPmPhNYuukZvVMq1zpM
JKiCNAd8kNowUw9vNZcDrJSit0Z0TruUgy5d8eR8g5721SABxsDCUk1ui+yZ9Z/x
bg2ktJiLaLlsXRCJ5uoHI4e6ygwkuLfrIeguV76fL24r0FqIHPiSvnaJ2kGRbU1S
tIeBFebSQVzVXzaMKNA2a/VgxRFWqKXV27bZukhlNqcrZ4rBDF2+py7qxfhvIMW1
H3MFvLRlc1fZzszbqS2oKwL237pxN5ioMgcLOh9JAYPH/v5jQ2+k5cjRb3KtbEc2
6bPZUGcCSdJS9wzp7fFePjitpCEEwYkRr+h3BWoqeZ0XYjO3P/d2ewBaLx4/GPVw
ZDDn7DGon7zUBfeXbxon/GwniMefrKuzzFxY9IbEBEkl0mORNfCjx+/z0BBCh/RH
NTR0GWg6Jn5iIrjjjKgLhkydKOjWnNjypeTpvKL7mr0RPbCvMnlvpKV7dvGvQobA
/uG1/kRzo73EuJ/d2Daf0EXXTRW9NHrQCt7yxSFS6PS++PSR/1lwSs3TvQgNJKdr
mrX4zfq6dEjjHYp1SS6CsiAK7DeywjPX3vXqgHMj0+5I1K6EpoGERC2ce2fel//A
qWr8/VYNDXXCbxsYVdM9
=6iJa
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
