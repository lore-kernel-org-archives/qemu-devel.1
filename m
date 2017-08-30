Received: from eggs.gnu.org ([2001:4830:134:3::10]:48092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmsTr-0005fq-V7
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 22:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmsTo-0006Tk-09
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 22:11:47 -0400
Date: Wed, 30 Aug 2017 12:11:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170830021132.GC3386@umbus.fritz.box>
References: <1504030416-18618-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <1504030416-18618-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] tests: Fix broken
 ivshmem-server-msi/-irq tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2017 at 08:13:36PM +0200, Thomas Huth wrote:
> Broken with commit b4ba67d9a7025 ("libqos: Change PCI accessors to take
> opaque BAR handle") a while ago, but nobody noticed since the tests are
> only run in SPEED=3Dslow mode: The msix_pba_bar is not correctly initiali=
zed
> anymore if bir_pba has the same value as bir_table. With this fix,
> "make check SPEED=3Dslow" should work fine again.
>=20
> Fixes: b4ba67d9a702507793c2724e56f98e9b0f7be02b
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  tests/libqos/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
> index 2dcdead..28d576c 100644
> --- a/tests/libqos/pci.c
> +++ b/tests/libqos/pci.c
> @@ -120,6 +120,8 @@ void qpci_msix_enable(QPCIDevice *dev)
>      bir_pba =3D table & PCI_MSIX_FLAGS_BIRMASK;
>      if (bir_pba !=3D bir_table) {
>          dev->msix_pba_bar =3D qpci_iomap(dev, bir_pba, NULL);
> +    } else {
> +        dev->msix_pba_bar =3D dev->msix_table_bar;
>      }
>      dev->msix_pba_off =3D table & ~PCI_MSIX_FLAGS_BIRMASK;
> =20
> @@ -138,8 +140,11 @@ void qpci_msix_disable(QPCIDevice *dev)
>      qpci_config_writew(dev, addr + PCI_MSIX_FLAGS,
>                                                  val & ~PCI_MSIX_FLAGS_EN=
ABLE);
> =20
> +    if (dev->msix_pba_bar.addr !=3D dev->msix_table_bar.addr) {
> +        qpci_iounmap(dev, dev->msix_pba_bar);
> +    }
>      qpci_iounmap(dev, dev->msix_table_bar);
> -    qpci_iounmap(dev, dev->msix_pba_bar);
> +
>      dev->msix_enabled =3D 0;
>      dev->msix_table_off =3D 0;
>      dev->msix_pba_off =3D 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmmHtQACgkQbDjKyiDZ
s5JHlhAAzG2Wl0hhEktQ7QbnK8rOVw3Jxr6FmLx6sE7ZiCz+a5Ia1F4eb/K8gSBu
t2E1J5+d0CPcIu3l8te8WKKmPseQawNuSyoT4wtWUd9+mAPMvmswXMExEQGpGl9U
gI9A4bZYNf91LV6pzYGhM6buJXWcMDqtY3o52BykrFvz4Q4sWH1hS7rV6oQNEYjr
K4W5gF+siPo0Y4ufD0KDThERSQYkqNKsWPQDsxTh8WOTRG+e3xXwIMGsU5Ww4wU8
2JhD1tw+oRU0Rg1YVz42uap//ba/dIC/DilDeoC964Ryv71a5Vsuh9WR+U9dYgcv
vLC8gYb9b5UcaPv34O/X61RHVFtpTa8TLDkMkIQDwG73pWYSyNKRQn/FzGf3BTiQ
Ml2WkzBzuE6ZwsjOIvxAPK3HqTbXJNaZWLK0/5lKOoLrbRelYNG/LhyENRY4xyzR
Y2a1t88017L6aNez89RG+cCmVs2PUw72OuafklvNpYOBywjUBkcnuAkH8j/BFwPM
qIEZBRV1+lTtkZj8u1Cz8Xd2uhQvIZsugEjBUZN95wfNhAXzpWVaN4iY3Yj+tfAP
y5io2VFYnk7UG5us6SbZdq1xb3khERD/c3tWewzUtp7xyrTBKIPUthFYDyb7LnqD
JqXCfAlzNx8LgKGHRj+vXXQ5vgrC5edIYgnADwZSGVdZbeIk+hY=
=Wuc7
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
