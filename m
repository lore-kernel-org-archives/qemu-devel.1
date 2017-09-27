Received: from eggs.gnu.org ([2001:4830:134:3::10]:37571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx7Sf-0006GI-5D
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx7SZ-0001ZL-DS
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:12:53 -0400
Date: Wed, 27 Sep 2017 17:59:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170927075917.GQ12504@umbus>
References: <20170926121750.9015-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JaBjgNvtdKe5H086"
Content-Disposition: inline
In-Reply-To: <20170926121750.9015-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: select default vty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--JaBjgNvtdKe5H086
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2017 at 02:17:50PM +0200, Laurent Vivier wrote:
> SLOF uses the "/chosen/linux,stdout-path" variable to
> choose its console. This variable is provided by QEMU.
> QEMU selects the spapr-vty using the "reg" property:
> it takes the vty with the lowest reg number.
> This patch allows the user to define "linux,stdout-path"
> from the command line by adding a keyword 'default' to
> the spapr-vty device.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

I'm a bit dubious about the worth of this.  With your SLOF fixes it
should still be possible to redirect output correctly using -prom-env,
yes?  Using a secondary vty is a pretty niche case, so I'm not
convinced we need extra properties just to make it simpler.
> ---
>  hw/char/spapr_vty.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
> index 0fa416ca6b..aa56a9a6cb 100644
> --- a/hw/char/spapr_vty.c
> +++ b/hw/char/spapr_vty.c
> @@ -15,6 +15,7 @@ typedef struct VIOsPAPRVTYDevice {
>      CharBackend chardev;
>      uint32_t in, out;
>      uint8_t buf[VTERM_BUFSIZE];
> +    bool is_default;
>  } VIOsPAPRVTYDevice;
> =20
>  #define TYPE_VIO_SPAPR_VTY_DEVICE "spapr-vty"
> @@ -153,6 +154,7 @@ void spapr_vty_create(VIOsPAPRBus *bus, Chardev *char=
dev)
>  static Property spapr_vty_properties[] =3D {
>      DEFINE_SPAPR_PROPERTIES(VIOsPAPRVTYDevice, sdev),
>      DEFINE_PROP_CHR("chardev", VIOsPAPRVTYDevice, chardev),
> +    DEFINE_PROP_BOOL("default", VIOsPAPRVTYDevice, is_default, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -194,11 +196,13 @@ static const TypeInfo spapr_vty_info =3D {
>  VIOsPAPRDevice *spapr_vty_get_default(VIOsPAPRBus *bus)
>  {
>      VIOsPAPRDevice *sdev, *selected;
> +    VIOsPAPRVTYDevice *dev;
>      BusChild *kid;
> =20
>      /*
>       * To avoid the console bouncing around we want one VTY to be
> -     * the "default". We haven't really got anything to go on, so
> +     * the "default". If the user doesn't provide the information
> +     * we haven't really got anything to go on, so
>       * arbitrarily choose the one with the lowest reg value.
>       */
> =20
> @@ -213,6 +217,13 @@ VIOsPAPRDevice *spapr_vty_get_default(VIOsPAPRBus *b=
us)
> =20
>          sdev =3D VIO_SPAPR_DEVICE(iter);
> =20
> +        /* The user can provide the default console to use */
> +
> +        dev =3D VIO_SPAPR_VTY_DEVICE(sdev);
> +        if (dev->is_default) {
> +            return sdev;
> +        }
> +
>          /* First VTY we've found, so it is selected for now */
>          if (!selected) {
>              selected =3D sdev;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JaBjgNvtdKe5H086
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnLWlQACgkQbDjKyiDZ
s5KBTxAAtT6aB/9hB1MMwSbVR/IU/s3x62sa2FZKEU8hNjZcTc/4guvTBsWcs4NQ
L4tkgN5JjOnums2fLETI8B6FZqrXrsIwR5WdZxrW6JcCcqrjuJHigZfjR/c1N92L
coVSOLNb4qKCfytgi6+JAzeiniuT5C8f0gzuOxyMP6r0uutyFnIZIVFUaSEj0xhT
iSSoQiXriNIMS+yNXCc0HQf86FeEtlZ6vku2gK28NeGTuZk7PDFdCjHHYlh0cWwE
NRRkizGx1uL986tMU+ZEs4/XHXVsu5UKOVjFxMAV8UuoFYwseKQt0ZNw7pX9p2J2
kq9CthE6+4fKcWR4oc6Xktcp8gtrVUVyDvXCZ76UNrA01nErVjIqdR9mdnTN9zHB
LOSyKtQ8SWc7MW2E2v/h/mQXNm0qI6+EfiH47VgeSfWBGZMbASKydHCXT0EMpsRm
FU9wBBcESlwgO0+uCDMbbTLjjTjdGtuaPvQafdLEe5MveZWoAlrz9ySLrBZxd9Dl
yrrNxULJG/yE6BYjR6UHaYWR6b1MdXRSg3EDtVlru187U3hLDROCDtEDQSDRlnNj
aE7bvLaPNdvHIjDRP5pRtYf0+Jzi1bHQGoCt4bOzBbHs8qMvmyNlXq2eLhi0X+KS
+IirbJd/PymLkRIlv0Jxjg0z/MLRD5DCjMN7NRXvL5BS+O3n0k0=
=B/Wt
-----END PGP SIGNATURE-----

--JaBjgNvtdKe5H086--
