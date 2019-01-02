Received: from eggs.gnu.org ([208.118.235.92]:57744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK2-0001hq-Az
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK1-0007oJ-5t
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:02 -0500
Date: Wed, 2 Jan 2019 15:17:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102041731.GP27457@umbus.fritz.box>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<fa4665529f65d02a924437b18e90686b173676f6.1546394798.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bvgsfYmVhxWy/2TA"
Content-Disposition: inline
In-Reply-To: <fa4665529f65d02a924437b18e90686b173676f6.1546394798.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 6/8] ppc4xx: Pass array index to function
 instead of pointer into the array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--bvgsfYmVhxWy/2TA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
> The sdram_set_bcr() function in ppc440_uc.c takes a pointer into an
> array then calculates its index from that. It's simpler and easier to
> just pass the index which simplifies both the function and its callers.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc440_uc.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index e46f59fba8..60dbb35eee 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -564,28 +564,26 @@ static target_ulong sdram_size(uint32_t bcr)
>      return size;
>  }
> =20
> -static void sdram_set_bcr(ppc440_sdram_t *sdram,
> -                          uint32_t *bcrp, uint32_t bcr, int enabled)
> +static void sdram_set_bcr(ppc440_sdram_t *sdram, int i,
> +                          uint32_t bcr, int enabled)
>  {
> -    unsigned n =3D bcrp - sdram->bcr;
> -
> -    if (*bcrp & 1) {
> -        /* Unmap RAM */
> +    if (sdram->bcr[i] & 1) {
> +        /* First unmap RAM if enabled */
>          memory_region_del_subregion(get_system_memory(),
> -                                    &sdram->containers[n]);
> -        memory_region_del_subregion(&sdram->containers[n],
> -                                    &sdram->ram_memories[n]);
> -        object_unparent(OBJECT(&sdram->containers[n]));
> +                                    &sdram->containers[i]);
> +        memory_region_del_subregion(&sdram->containers[i],
> +                                    &sdram->ram_memories[i]);
> +        object_unparent(OBJECT(&sdram->containers[i]));
>      }
> -    *bcrp =3D bcr & 0xFFDEE001;
> +    sdram->bcr[i] =3D bcr & 0xFFDEE001;
>      if (enabled && (bcr & 1)) {
> -        memory_region_init(&sdram->containers[n], NULL, "sdram-container=
s",
> +        memory_region_init(&sdram->containers[i], NULL, "sdram-container=
s",
>                             sdram_size(bcr));
> -        memory_region_add_subregion(&sdram->containers[n], 0,
> -                                    &sdram->ram_memories[n]);
> +        memory_region_add_subregion(&sdram->containers[i], 0,
> +                                    &sdram->ram_memories[i]);
>          memory_region_add_subregion(get_system_memory(),
>                                      sdram_base(bcr),
> -                                    &sdram->containers[n]);
> +                                    &sdram->containers[i]);
>      }
>  }
> =20
> @@ -595,12 +593,10 @@ static void sdram_map_bcr(ppc440_sdram_t *sdram)
> =20
>      for (i =3D 0; i < sdram->nbanks; i++) {
>          if (sdram->ram_sizes[i] !=3D 0) {
> -            sdram_set_bcr(sdram,
> -                          &sdram->bcr[i],
> -                          sdram_bcr(sdram->ram_bases[i], sdram->ram_size=
s[i]),
> -                          1);
> +            sdram_set_bcr(sdram, i, sdram_bcr(sdram->ram_bases[i],
> +                                              sdram->ram_sizes[i]), 1);
>          } else {
> -            sdram_set_bcr(sdram, &sdram->bcr[i], 0, 0);
> +            sdram_set_bcr(sdram, i, 0, 0);
>          }
>      }
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bvgsfYmVhxWy/2TA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsO1sACgkQbDjKyiDZ
s5JPKRAAqm0XHoC3UxWvf7KqiB35G0iPeWuZK7AIzfYD6+Yg/T/mOAKXboOY+hTp
JKu60ifs27uhjPLVRLOwmz+k1iDqEaymI1n5z/yap4JpOR+shK5nj2a0NrxRhzHw
yXcWsbc6rQtebHg7PbFpUPHEoSyi5bi9rIAfNtrF+/+ehcIN7yWAsio1Sg8C3ih2
22ogFFE3D5DgebWNIcA5srPiuHj80mUc00mc4KLbMPPoE+U1fiXk52DK1+qlodMA
VEruRRvXAyN/Q9ztyY00D4wnn1cBUNb48rGqIf2qtPJgC2yS053z6o24MdJl6G8o
p7nLqgDjImr4b4/qSjYePSV4YasnOYoMDTVSL+PVwul7/g4doWUfki4p2FlMUnaD
JYoWiVGS9wbAIFUV1IoRWzjxGxCncNutpzautR6Mx6STZjx63yvCyTadAoxAWEjA
7psxBJZO554eUfGt59FZPASyPCWGrP4fNcvwVlrGZhObYMWRbe2qVqNJ6pDMfIkw
fKN9GpbhtPehrD2L6NKlsIx55hlnG8P5byudQKyYJQlQb0WkcJQ1R41/IEwhxJxQ
W8wmAtX9qR8GjxD6kVBtBtx5JNC4aIm58uNwUMMqClU/y/mdb0RBBGpqNkXQlAOe
uRFYw7NswAWYQFiHMqO5jIgangfp9bdLSTKgNpAbZp7lYt3xs3k=
=Y2b+
-----END PGP SIGNATURE-----

--bvgsfYmVhxWy/2TA--
