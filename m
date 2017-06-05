Received: from eggs.gnu.org ([2001:4830:134:3::10]:52382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI1ph-0001BS-4K
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI1pg-00038m-1E
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:54:49 -0400
Date: Tue, 6 Jun 2017 09:19:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170605231925.GA13397@umbus.fritz.box>
References: <1496675657-11599-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cDyoBSpeMmeqjtIY"
Content-Disposition: inline
In-Reply-To: <1496675657-11599-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] spapr_nvram: Check return value from
 blk_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--cDyoBSpeMmeqjtIY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 04:14:17PM +0100, Peter Maydell wrote:
> The blk_getlength() function can return an error value if the
> image size cannot be determined. Check for this rather than
> ploughing on and trying to g_malloc0() a negative number.
> (Spotted by Coverity, CID 1288484.)
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Applied to ppc-for-2.10, thanks.

> ---
>  hw/nvram/spapr_nvram.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
> index aa5d2c1..bc355a4 100644
> --- a/hw/nvram/spapr_nvram.c
> +++ b/hw/nvram/spapr_nvram.c
> @@ -144,7 +144,15 @@ static void spapr_nvram_realize(VIOsPAPRDevice *dev,=
 Error **errp)
>      int ret;
> =20
>      if (nvram->blk) {
> -        nvram->size =3D blk_getlength(nvram->blk);
> +        int64_t len =3D blk_getlength(nvram->blk);
> +
> +        if (len < 0) {
> +            error_setg_errno(errp, -len,
> +                             "could not get length of backing image");
> +            return;
> +        }
> +
> +        nvram->size =3D len;
> =20
>          ret =3D blk_set_perm(nvram->blk,
>                             BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cDyoBSpeMmeqjtIY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZNeb7AAoJEGw4ysog2bOSkTEP/0cQL5bnYx54dVLIaqMwZlEP
LVlYWWZuuEi11jLBLCyoKEX06+Uckh8zDHarnKPKnkWLCq0SifOcGFoCvg+LGc8a
myBuVQ4W7G9wj3BzOBVVm/g0rne1tkdyBirQIOqK1nImLX6DJn4B/zt3qPSN5EGd
r6elbqBm2U5GPHyxCk24qY9s4fZ8eKssWCXbqITCOJBDqiK/kPe99Dd8gYWo8v0t
B1C1Kqg0y+4PQ9Se1fOeJllzsOV7qiKgYG4tjsx/Od+dP9lW9dVDLrinVIv4tWis
7vat9WmKIqnC2UF9bhfiBY71cNsCiMWu+amJ1y/SWnxU6TiCwgalWDH7FJ8TN+Fc
KWCqf29t1v7UIxFUQQ0cttiGQj1fjfIbaP+FtbKe6JJuk0Ax7tmAfJL6aEXsD4aL
1Rq/iO8RCieTNoaeucvIZcjzW/SSDlF26wM/bx+p/adLA/4d96ozBryINHuBlMNT
MZOVLQU2AAte6z35D6NKzRje2AeSbh7y69MAOsnigeKOzIiWF0hhteOWDwUXcFRF
+dBIUgXuoqERq7vlXaUJb+L6T/V5NFDcWaXPNt2FZCDDEmC9NVs0Rp5k6herxhtZ
Jvt8kTCZm832X9OISsKd8Nxkbjuj7m9n2jbeiMo8K/IsOyofpTP5DdD9uDCBKlkO
TxxTBylSxY/yYaN/SPJK
=/GZC
-----END PGP SIGNATURE-----

--cDyoBSpeMmeqjtIY--
