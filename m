Received: from eggs.gnu.org ([2001:4830:134:3::10]:45501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX7-0000jq-M5
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX3-00016c-Jh
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:13 -0500
Date: Sun, 11 Feb 2018 09:33:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210223347.GT11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-7-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kG2acDqmwoBDcCHP"
Content-Disposition: inline
In-Reply-To: <20180209185142.17151-7-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2 06/12] cuda: minor cosmetic tidy-ups to
 get_next_irq_time()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com


--kG2acDqmwoBDcCHP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:51:36PM +0000, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Applied, thanks.

> ---
>  hw/misc/macio/cuda.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 232b7f61aa..408858e688 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -184,36 +184,37 @@ static void set_counter(CUDAState *s, CUDATimer *ti=
, unsigned int val)
>      cuda_timer_update(s, ti, ti->load_time);
>  }
> =20
> -static int64_t get_next_irq_time(CUDATimer *s, int64_t current_time)
> +static int64_t get_next_irq_time(CUDATimer *ti, int64_t current_time)
>  {
>      int64_t d, next_time;
>      unsigned int counter;
> =20
>      /* current counter value */
> -    d =3D muldiv64(current_time - s->load_time,
> +    d =3D muldiv64(current_time - ti->load_time,
>                   CUDA_TIMER_FREQ, NANOSECONDS_PER_SECOND);
>      /* the timer goes down from latch to -1 (period of latch + 2) */
> -    if (d <=3D (s->counter_value + 1)) {
> -        counter =3D (s->counter_value - d) & 0xffff;
> +    if (d <=3D (ti->counter_value + 1)) {
> +        counter =3D (ti->counter_value - d) & 0xffff;
>      } else {
> -        counter =3D (d - (s->counter_value + 1)) % (s->latch + 2);
> -        counter =3D (s->latch - counter) & 0xffff;
> +        counter =3D (d - (ti->counter_value + 1)) % (ti->latch + 2);
> +        counter =3D (ti->latch - counter) & 0xffff;
>      }
> =20
>      /* Note: we consider the irq is raised on 0 */
>      if (counter =3D=3D 0xffff) {
> -        next_time =3D d + s->latch + 1;
> +        next_time =3D d + ti->latch + 1;
>      } else if (counter =3D=3D 0) {
> -        next_time =3D d + s->latch + 2;
> +        next_time =3D d + ti->latch + 2;
>      } else {
>          next_time =3D d + counter;
>      }
>      CUDA_DPRINTF("latch=3D%d counter=3D%" PRId64 " delta_next=3D%" PRId6=
4 "\n",
> -                 s->latch, d, next_time - d);
> +                 ti->latch, d, next_time - d);
>      next_time =3D muldiv64(next_time, NANOSECONDS_PER_SECOND, CUDA_TIMER=
_FREQ) +
> -        s->load_time;
> -    if (next_time <=3D current_time)
> +                         ti->load_time;
> +    if (next_time <=3D current_time) {
>          next_time =3D current_time + 1;
> +    }
>      return next_time;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kG2acDqmwoBDcCHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp/c0sACgkQbDjKyiDZ
s5IU+Q//VYYjpMzIdiB2/BT7ZbAZn9lh5z+v/Ej68C+4Jjp1oP1euMFSjeEdRr9Z
+pM7TdiWE4zsQI0d0hB0yFhxDZtZy2TVQt91ouMauRs1Rj11xniTD0XvaU43MjhW
IpG6yOf0r75eWO3ImAy20/dd5lRy+NZEe+AXEAXJ0b9pdVEDjoebUURtjrNyBO4S
Mm3nCi2Q+ijJZkzc9QltjpQQ9vSWmSNyHPADIxxAfP0sCst3D9zOB802Ck1YKUVy
ix2jI1QQujQbN2wrl7f5bgzFauIl3S5Jv58L3XOM83GNnBxGk57XEAk9UsLB/8SK
WGhVxXSaGA3jzMkeTfjo8tBdTUsR/bjE1duceYIMYUpW8H0PlJcusTaYNZDkqkVL
PBq0IHI+1YbmZfY1GjgOsl9wex72TMv8/u0SI9tNUQ8/FbF+40heQOfZYigZak8P
3snzv1qZ0FTl/w8e2pFTnNi1zv2DMmz0FHlUgqkKMEgzy33Onu9ddawyPZvdkT1E
l4wAw9XllvjR9W9NcZN41eiJqFfzKNrk4LLY5FAbcNryI+kfE6ZQ+ck3/pDntNE+
Hqv9KxwvwqU3hQHP2Jmn0xDQTI7TpKPR73dlM/vlfxV+QeNPBa4GaRMs6Fyn/C2x
ECtsEZwOwEcdR6VowWobtwDvtNPW13MD9e/+ZxhPM7GwhE1loPA=
=iyNv
-----END PGP SIGNATURE-----

--kG2acDqmwoBDcCHP--
