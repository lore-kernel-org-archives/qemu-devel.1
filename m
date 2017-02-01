Received: from eggs.gnu.org ([2001:4830:134:3::10]:44252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBO-0003xv-5m
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBM-0007WD-OH
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:58 -0500
Date: Wed, 1 Feb 2017 11:50:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201005050.GF30639@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-7-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-7-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 06/17] target/ppc/POWER9: Direct all
 instr and data storage interrupts to the hypv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:12PM +1100, Suraj Jitindar Singh wrote:
> The vpm0 bit was removed from the LPCR in POWER9, this bit controlled
> whether ISI and DSI interrupts were directed to the hypervisor or the
> partition. These interrupts now go to the hypervisor irrespective, thus
> it is no longer necessary to check the vmp0 bit in the LPCR.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/mmu-hash64.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 3a2acb8..fe7da18 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -640,7 +640,15 @@ static void ppc_hash64_set_isi(CPUState *cs, CPUPPCS=
tate *env,
>      if (msr_ir) {
>          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>      } else {
> -        vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> +        switch (env->mmu_model) {
> +        case POWERPC_MMU_3_00:
> +            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
> +            vpm =3D true;
> +            break;
> +        default:
> +            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> +            break;
> +        }
>      }
>      if (vpm && !msr_hv) {
>          cs->exception_index =3D POWERPC_EXCP_HISI;
> @@ -658,7 +666,15 @@ static void ppc_hash64_set_dsi(CPUState *cs, CPUPPCS=
tate *env, uint64_t dar,
>      if (msr_dr) {
>          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>      } else {
> -        vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> +        switch (env->mmu_model) {
> +        case POWERPC_MMU_3_00:
> +            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
> +            vpm =3D true;
> +            break;
> +        default:
> +            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> +            break;
> +        }
>      }
>      if (vpm && !msr_hv) {
>          cs->exception_index =3D POWERPC_EXCP_HDSI;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkTDqAAoJEGw4ysog2bOSqMcP/0e1cY7bdnVHwTofhM5Kn7P8
bZ49E5qc/U31Dj8FkOmToE4invzNIWRJDJq4QMG24cpZRyAJvqQzj1cZEg41bmX7
gTLBO7B5AYdGps+oBDyI5D5VN+MNpekETM4Z32e6lrjGReQ60m1vp61TqBnMrVMA
eCQhgMqunZgQSUAksHiRgBfNVUTuwlRLvqDROxqZKTiQGj7p7aPSXMkgeaxUa1YL
Xw3BaXa3Anf67/1ZyardqtHzBZELpcE/eY+ITKU2jNbRtuNODQOkvoYj74rPinHD
f7tn2Jukg5xyMgdvfU1+xVJomMxhwQtCWWekLlUcXf2Y2dszfE173ZozxXAf0R6J
boHQM+kf07WxPS9Zp7URh2JKPfCuG539PkqeLc4lBsAYknZETwOdNcDjEMZ7OUpR
zZFL3iKWEa2JktcyRm+gq/0CM22HCxHIUb+p7ti+/ICW1oR96YoJWJPH7Mgc7Q59
7Svh6W221GhQjcYXaETeb0dLyBFGhw5d3A/ZgI7CMzAfVnMveoKEagBOGN46nbvj
iq1n4qx8ZW271P863ysuRwJj4B9cZzRwGQgM5YbKoeLl+vcM+ZPtTdzlcGsPTAA3
W5XDcYv183iWfioRKjLXds56lucEHF6/xRgomxWPJ1byZlJ/yyGIswPfncvtbIVL
SRHJbVOS/+e3aaz5fAel
=XD8L
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--
