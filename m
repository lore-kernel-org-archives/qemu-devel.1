Received: from eggs.gnu.org ([2001:4830:134:3::10]:49472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqsmp-0006TC-KK
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqsmo-0004Hg-E7
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:19:55 -0400
Date: Sun, 10 Sep 2017 13:17:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170910031731.GY2735@umbus.fritz.box>
References: <20170908143344.12960-1-clg@kaod.org>
	<20170908143344.12960-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kigERAySUJmIn/9g"
Content-Disposition: inline
In-Reply-To: <20170908143344.12960-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr: fix CAS-generated reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--kigERAySUJmIn/9g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2017 at 04:33:43PM +0200, C=E9dric Le Goater wrote:
> The OV5_MMU_RADIX_300 requires special handling in the CAS negotiation
> process. It is cleared from the option vector of the guest before
> evaluating the changes and re-added later. But, when testing for a
> possible CAS reset :
>=20
>     spapr->cas_reboot =3D spapr_ovec_diff(ov5_updates,
>                                         ov5_cas_old, spapr->ov5_cas);
>=20
> the bit OV5_MMU_RADIX_300 will each time be seen as removed from the
> previous OV5 set, hence generating a reset loop.
>=20
> Fix this problem by also clearing the same bit in the ov5_cas_old set.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Kind of an ugly hack, but probably the easiest fix for now. Applied to ppc-=
for-2.11.

> ---
>  hw/ppc/spapr_hcall.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 07b3da8dc4cd..92f1e21358b8 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1575,6 +1575,13 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>       * to worry about this for now.
>       */
>      ov5_cas_old =3D spapr_ovec_clone(spapr->ov5_cas);
> +
> +    /* also clear the radix/hash bit from the current ov5_cas bits to
> +     * be in sync with the newly ov5 bits. Else the radix bit will be
> +     * seen as being removed and this will generate a reset loop
> +     */
> +    spapr_ovec_clear(ov5_cas_old, OV5_MMU_RADIX_300);
> +
>      /* full range of negotiated ov5 capabilities */
>      spapr_ovec_intersect(spapr->ov5_cas, spapr->ov5, ov5_guest);
>      spapr_ovec_cleanup(ov5_guest);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kigERAySUJmIn/9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm0rskACgkQbDjKyiDZ
s5K7MRAA5Jc7UGhwZDPQXeDa8wnbVTGGYyi560rIk8Ll/e7zFBjwBOcIZWTuh5pn
QK99GtUcOmwZdryhduFfM+FSmv516ZBXVXjkhVtU1ZExDHinmI4nDakAdfwBXTT0
6+7d/t2aVLhV7uVKSOVXRqi7jaq+0nClzGT+Kda8YH7fRjZWSsIybw7Eg1ZYuAxj
2xEY/2W4RZFNPUJnoOGectJFRU1xNuHaSJInAKAMjy7n5yttjOp4BM803Jryg6V8
INu4GfKEWQpJkEBLty8zOSyvj2O0Qwba/hlhq33Xo0uTa+7VtuMVeJFQ3qNpHjzZ
TaYJr43e/d9Zmb4EA7FoYfBR7UHsSslNWAhl+xoaC37zDhLbHp3aOTqrFxVYmi0Q
nsuduC5B49PNOCNOiqzslLuJBi8wwqnHND2vAjZ1RW5iPJ2EB4upRzv/C1v1cQU3
cTEuqISaWtHJEErXD9+Jmkg8r3QqqlvBY5QvW70q+14A3YTLeDNN7sMFFJzv5h/d
OZ+lzw71lRSfP8SLQfy3keMhU56Zw9s3ChhWXXs65NHW7Qkgqr7mCgdg2t61F0nQ
4XMcBl5QJVwkCX5qstC1qNSe2lDV27nP5oqahEFwRA3AxaWLw2CtPBsgx6VLh+Po
fgtHyrDMhq9+FA0qPLMzHx9jqxHhMuC9N33VPOdi/V73p5VZ1SA=
=HnLz
-----END PGP SIGNATURE-----

--kigERAySUJmIn/9g--
