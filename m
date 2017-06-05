Received: from eggs.gnu.org ([2001:4830:134:3::10]:34422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dHgJ9-00053j-IH
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dHgJ5-0005SJ-K7
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:55:47 -0400
Date: Mon, 5 Jun 2017 10:55:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170605005534.GX13397@umbus.fritz.box>
References: <201706021132.v52BWx1t027533@linux03a.ddci.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uWCTLymdFNG0vGYZ"
Content-Disposition: inline
In-Reply-To: <201706021132.v52BWx1t027533@linux03a.ddci.com>
Subject: Re: [Qemu-devel] [PATCH] target-ppc: Fix openpic timer read
 register offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Larson <alarson@ddci.com>
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--uWCTLymdFNG0vGYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2017 at 04:32:59AM -0700, Aaron Larson wrote:
>=20
> openpic_tmr_read() is incorrectly computing register offset of the
> TCCR, TBCR, TVPR, and TDR registers when accessing the open pic timer
> registers.  Specifically the offset of timer registers for
> openpic_tmr_read() is not accounting for the timer frequency reporting
> register (TFFR) which is the first register in the "tmr" memory
> region.
>=20
> openpic_tmr_write() *is* correctly computing the offset by adding
> 0x10f0 to the address prior to computing the register index.  This
> patch instead subtracts 0x10 in both the read and write routines and
> eliminates some other gratuitous differences between the functions.
>=20
> Signed-off-by: Aaron Larson <alarson@ddci.com>

Applied to ppc-for-2.10.  It looks saner than the existing code, but I
don't know openpic well enough to really review it; so I'm trusting
you on that.

> ---
>  hw/intc/openpic.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index 4349e45..f966d06 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -796,27 +796,24 @@ static uint64_t openpic_gbl_read(void *opaque, hwad=
dr addr, unsigned len)
>  }
> =20
>  static void openpic_tmr_write(void *opaque, hwaddr addr, uint64_t val,
> -                                unsigned len)
> +                              unsigned len)
>  {
>      OpenPICState *opp =3D opaque;
>      int idx;
> =20
> -    addr +=3D 0x10f0;
> -
>      DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D %08" PRIx64 "\n",
> -            __func__, addr, val);
> +            __func__, (addr + 0x10f0), val);
>      if (addr & 0xF) {
>          return;
>      }
> =20
> -    if (addr =3D=3D 0x10f0) {
> +    if (addr =3D=3D 0) {
>          /* TFRR */
>          opp->tfrr =3D val;
>          return;
>      }
> -
> +    addr -=3D 0x10;  /* correct for TFRR */
>      idx =3D (addr >> 6) & 0x3;
> -    addr =3D addr & 0x30;
> =20
>      switch (addr & 0x30) {
>      case 0x00: /* TCCR */
> @@ -844,16 +841,17 @@ static uint64_t openpic_tmr_read(void *opaque, hwad=
dr addr, unsigned len)
>      uint32_t retval =3D -1;
>      int idx;
> =20
> -    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
> +    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr + 0x10f0);
>      if (addr & 0xF) {
>          goto out;
>      }
> -    idx =3D (addr >> 6) & 0x3;
> -    if (addr =3D=3D 0x0) {
> +    if (addr =3D=3D 0) {
>          /* TFRR */
>          retval =3D opp->tfrr;
>          goto out;
>      }
> +    addr -=3D 0x10;  /* correct for TFRR */
> +    idx =3D (addr >> 6) & 0x3;
>      switch (addr & 0x30) {
>      case 0x00: /* TCCR */
>          retval =3D opp->timers[idx].tccr;
> @@ -861,10 +859,10 @@ static uint64_t openpic_tmr_read(void *opaque, hwad=
dr addr, unsigned len)
>      case 0x10: /* TBCR */
>          retval =3D opp->timers[idx].tbcr;
>          break;
> -    case 0x20: /* TIPV */
> +    case 0x20: /* TVPR */
>          retval =3D read_IRQreg_ivpr(opp, opp->irq_tim0 + idx);
>          break;
> -    case 0x30: /* TIDE (TIDR) */
> +    case 0x30: /* TDR */
>          retval =3D read_IRQreg_idr(opp, opp->irq_tim0 + idx);
>          break;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uWCTLymdFNG0vGYZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZNKwGAAoJEGw4ysog2bOSs/cP/Ru2hxQ0mDA72Z5O0bIgIcDX
EFH56ZYNf5XZcEHoDmiruT98hF4/qtVGx3vIPRYVmqaN7zROVE2NrhM07VoDm3CA
byTHl99pKszPRfgLeDSoI3gY/PzFLiwsmhReCOLyWOiQCx0055VqcV6n8yo1oA7p
9eDW4s+oNjPK62YkZkVNT3CLJjm6mewl7inJZY7SIFghw2Ok32x2qHihm4aLPKLN
6UdLR/QLai2wRV+j85hGuBAS7AamYxDgbRJ+ZSFI11s15EyBmq3ds0j/Y5HBQ5jP
XkNSisbW354NIEZCr7euwtQ07wbrb0uWvHLL7M3hrhRHQRdUblt0dQZFrpp11zJx
Q8FQmqeplXVOw95SYJ9xECafybYTNNd/gkSHx3A86EUT9NjXUt2PlA41hyHoM1mR
ESbBWY17Z+J7mwxw1GqDbHAPXzkqTcCBJEp2w9Zc2EH0oZO176LdPzkKy/HAU524
WQsvnWm/szeH4SctBOdg3L/iacuzuHDFpAoo0qbB+NVJiYiFUl3XpeLvGnfVo5/0
W7IohuqgrOp9eeaxOzJ70I8KNrXPkPFMwv5SS9vnQ6rpVEDXb6QU/RB67wtKQq5p
ixt4gZQHIJ0WZJ9zAU9ocETGlH52Dfm+il+4E+NTeIPZRjjjmYpGphxsnkrUHZjw
pG+63Feob/4Z07cZYgrQ
=p6ig
-----END PGP SIGNATURE-----

--uWCTLymdFNG0vGYZ--
