Received: from eggs.gnu.org ([2001:4830:134:3::10]:34648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd9ok-0004uH-CA
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 01:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd9oj-0002r6-0Q
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 01:08:54 -0500
Date: Mon, 13 Feb 2017 16:33:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213053340.GC25381@umbus>
References: <4c44ad5045020be90edfdc8787002e09691db1d3.1479770377.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k/A+UfywgnnvevLW"
Content-Disposition: inline
In-Reply-To: <4c44ad5045020be90edfdc8787002e09691db1d3.1479770377.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 1/1] hw/net/spapr_llan: 6
 byte mac address device tree entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, qemu-ppc@nongnu.org


--k/A+UfywgnnvevLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2016 at 10:19:38AM +1100, Sam Bobroff wrote:
> The spapr-vlan device in QEMU has always presented it's MAC address in
> the device tree as an 8 byte value, even though PAPR requires it to be
> 6 bytes.  This is because, at the time, AIX required the value to be 8
> bytes.  However, modern versions of AIX support the (correct) 6
> byte value so they no longer require the workaround.
>=20
> It would be neatest to always provide a 6 byte value but that would
> cause a problem with old Linux kernel ibmveth drivers, so the old 8
> byte value is still presented when necessary.
>=20
> Since commit 13f85203e (3.10, May 2013) the driver has been able to
> handle 6 or 8 byte addresses so versions after that don't need to be
> considered specially.
>=20
> Drivers from kernels before that can also handle either type of
> address, but not always:
> * If the first byte's lowest bits are 10, the address must be 6 bytes.
> * Otherwise, the address must be 8 bytes.
> (The two bits in question are significant in a MAC address: they
> indicate a locally-administered unicast address.)
>=20
> So to maintain compatibility the old 8 byte value is presented when
> the lowest two bits of the first byte are not 10.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Sorry, I didn't see this one until now.

Since we need a workaround for the workaround, is it actually worth
going to the 6-byte property?

> ---
>=20
> v3:
>=20
> Made code comments more accurate.
>=20
> v2:
>=20
> Re-introduced the old workaround so that old Linux kernel drivers aren't
> broken, at the cost of AIX seeing the old value for for non-locally gener=
ated
> or broadcast addresses (this shouldn't matter because those addresses pro=
bably
> aren't used on virtual adapters).
>=20
> Reworded first paragraph of commit message because AIX seems to still sup=
port
> the old 8 byte value.
>=20
>  hw/net/spapr_llan.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index 01ecb02..74910e8 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -385,18 +385,24 @@ static int spapr_vlan_devnode(VIOsPAPRDevice *dev, =
void *fdt, int node_off)
>      int ret;
> =20
>      /* Some old phyp versions give the mac address in an 8-byte
> -     * property.  The kernel driver has an insane workaround for this;
> +     * property.  The kernel driver (before 3.10) has an insane workarou=
nd;
>       * rather than doing the obvious thing and checking the property
>       * length, it checks whether the first byte has 0b10 in the low
>       * bits.  If a correct 6-byte property has a different first byte
>       * the kernel will get the wrong mac address, overrunning its
>       * buffer in the process (read only, thank goodness).
>       *
> -     * Here we workaround the kernel workaround by always supplying an
> -     * 8-byte property, with the mac address in the last six bytes */
> -    memcpy(&padded_mac[2], &vdev->nicconf.macaddr, ETH_ALEN);
> -    ret =3D fdt_setprop(fdt, node_off, "local-mac-address",
> -                      padded_mac, sizeof(padded_mac));
> +     * Here we return a 6-byte address unless that would break a pre-3.10
> +     * driver.  In that case we return a padded 8-byte address to allow =
the old
> +     * workaround to succeed. */
> +    if ((vdev->nicconf.macaddr.a[0] & 0x3) =3D=3D 0x2) {
> +        ret =3D fdt_setprop(fdt, node_off, "local-mac-address",
> +                          &vdev->nicconf.macaddr, ETH_ALEN);
> +    } else {
> +        memcpy(&padded_mac[2], &vdev->nicconf.macaddr, ETH_ALEN);
> +        ret =3D fdt_setprop(fdt, node_off, "local-mac-address",
> +                          padded_mac, sizeof(padded_mac));
> +    }
>      if (ret < 0) {
>          return ret;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k/A+UfywgnnvevLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoUUyAAoJEGw4ysog2bOS6JIQAMBk+AzN9NLcn9Z1gZrqO9Vq
+JamrSjfKEXRxY+RB3IzWNKPlACFVPZ4hiEQQExJ72Qo/ViX4GDrpdCqFtyDhdkN
bAASSCLHQ4vON13eYtKMyeOPqNi5RvQyauTwXUquCYOPOztsJXmnTaPrI7y8KPwv
+Zqnis2xWye1zGhSs8vvz/qA3vSvWsTZqt/rXwgWheuzSO7fbqe1ml9lW39uz0RN
47r9Ca7NHWzquY3KEJ25BS+dLl14GGuSHeBTN/uw5AxKPuNItCK3jiDEZMI9MBCM
AjrjdyfId2K6C5oO7jIjRMkDFlCxY0KfbLl7w9xSeFeDXJPQEOAvia4N51ho89Jw
L74VihRzZtH1Wbfa1PxcBogTb4uB8q7rqlifVI+NlSMZ/S/d3re4/SuYFCR5ymHi
bDynB30WbMjKW3T68ZxtHCHyaCnjy0ZZJSeOpXQOrl2/NgSCrLmfC+45o6LTV7Li
NY+l4tOE1K7BqhAib04U6bfL/WRwKg5h35jeXBhczcMERx/l7LunuiyKLFdmd+O7
3wVtvmn4o4v05CM+7bkWj1QwbKyyW+XPxUVoW/oBbLt9naER3otPixDVdzs1Lugl
awDNnKWnwROZg95rxMET5UX3f7OzvrRH90knNYUup7I8cvdargT/ABuLiQ8Qpb2t
GUKzbe7lYMuBXBK6eoP2
=Raox
-----END PGP SIGNATURE-----

--k/A+UfywgnnvevLW--
