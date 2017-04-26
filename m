Received: from eggs.gnu.org ([2001:4830:134:3::10]:41909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Ddv-0007vT-Mg
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Ddu-0000Fi-H7
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:29:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d3Ddt-0000DH-GA
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:29:26 -0400
Date: Wed, 26 Apr 2017 12:42:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170426024244.GK16882@umbus.fritz.box>
References: <1493103101-25165-1-git-send-email-clg@kaod.org>
	<1493103101-25165-3-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZG5hGh9V5E9QzVHS"
Content-Disposition: inline
In-Reply-To: <1493103101-25165-3-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] ipmi: don't try to open a NULL filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org


--ZG5hGh9V5E9QzVHS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2017 at 08:51:41AM +0200, C=E9dric Le Goater wrote:
> Currenlty, the code relies on the fact that open() handles NULL
> filenames but that can cause an error with new clang:
>=20
>   hw/core/loader.c:67:15: runtime error: null pointer passed as argument =
1,
>   which is declared to never be null
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Since my ppc-for-2.10 pull request has been held up because of this
anyway, tather than just apply this on top, I've folded it into your
earlier patch which caused the bug - that way we won't break bisect.

> ---
>  hw/ipmi/ipmi_bmc_sim.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 155561d06614..277c28cb40ed 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -1899,6 +1899,10 @@ static void ipmi_fru_init(IPMIFru *fru)
>      int fsize;
>      int size =3D 0;
> =20
> +    if (!fru->filename) {
> +        goto out;
> +    }
> +
>      fsize =3D get_image_size(fru->filename);
>      if (fsize > 0) {
>          size =3D QEMU_ALIGN_UP(fsize, fru->areasize);
> @@ -1910,6 +1914,7 @@ static void ipmi_fru_init(IPMIFru *fru)
>          }
>      }
> =20
> +out:
>      if (!fru->data) {
>          /* give one default FRU */
>          size =3D fru->areasize;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZG5hGh9V5E9QzVHS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZAAkkAAoJEGw4ysog2bOS6zsQALEogq5MT245RWCdfZuqzODh
Etik1tlCyeqKlefftQ8qOtmIqxVGwyfNuCDo+jl1yX0FJ6dWAvT3HUPBt85t61qy
DRE7povHb/JU+SKmgJSYN/xHMWVwkM2oqTg78PlSv+6SOcSmR3hbmxGG0fuLRFEo
NxiYCX87ZmQ3mfDcAe9ycKXzy6wbLK/ISkDTSvav3a2uV91XoSx4cYA6t9c3kvTe
Ow5e3YJrpo1BZU1/+D9n0HzOF5QcOah0JmUqHvnvYVKyO00ZMGcdKtS0v6ojq0OS
A6HEllDMMwkAUXpwy87Wu39UGH8iSw2jQ9QX2CU/OsmkmhpJZJIIravh87vAgTqx
tnOZTVErb+Be8i3xy7dGizVrGwxxcxlbXATJP0r4Wuh2DYojuAKN8HsgoHxpM77v
aFPvu90FyoPnlMVlfzVfg2n4XW+HeU57TDi04JFz8zBORgN1d2UuJvCygWFN5TQK
ysCdeboLbj0EhVnL27jSJhOV9z5KGgTUEkaOytmI8rrIeatLAwB/nmItnbnLmgS9
5O8Lceg9LANeX3sM3hqpdi0lvQofxt4Z+iNKrPL/nfUjyCWcdlwWiiusgtrNHZnj
SWdDkgerZw5G9ILaqd89mrmKNdidtoydQf7b+Dx9HOZo5cQhT0Nlk0V89g8Y8h5P
m5jOL72kJgt4y7tcqsmN
=gir0
-----END PGP SIGNATURE-----

--ZG5hGh9V5E9QzVHS--
