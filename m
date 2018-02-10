Received: from eggs.gnu.org ([2001:4830:134:3::10]:45505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX7-0000jt-Qv
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX3-00016Q-JW
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:13 -0500
Date: Sun, 11 Feb 2018 10:15:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210231531.GW11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-8-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w1TwAseT95X423KH"
Content-Disposition: inline
In-Reply-To: <20180209185142.17151-8-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2 07/12] cuda: set timer 1 frequency
 property to CUDA_TIMER_FREQ
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


--w1TwAseT95X423KH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:51:37PM +0000, Mark Cave-Ayland wrote:
> Now that we have successfully decoupled the timebase frequency and the ha=
rdware
> timer frequency, set the timer 1 frequency property to CUDA_TIMER_FREQ an=
d alter
> get_next_irq_time() to use it rather than the hard-coded constant.
>=20
> In addition to this we must now switch the tb_diff calculation over to us=
e the
> timebase frequency now that the hardware clock frequency and the timebase
> frequency are different.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/macio/cuda.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 408858e688..e00df4a21a 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -158,8 +158,8 @@ static unsigned int get_counter(CUDAState *s, CUDATim=
er *ti)
>      uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> =20
>      /* Reverse of the tb calculation algorithm that Mac OS X uses on boo=
tup. */
> -    tb_diff =3D get_tb(current_time, ti->tb_frequency) - ti->load_time;
> -    d =3D (tb_diff * 0xBF401675E5DULL) / (ti->tb_frequency << 24);
> +    tb_diff =3D get_tb(current_time, s->tb_frequency) - ti->load_time;
> +    d =3D (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);

This requires an update due to the bug in the earlier patch which
touched this.  I've fixed this up in my tree.

>      if (ti->index =3D=3D 0) {
>          /* the timer goes down from latch to -1 (period of latch + 2) */
> @@ -191,7 +191,7 @@ static int64_t get_next_irq_time(CUDATimer *ti, int64=
_t current_time)
> =20
>      /* current counter value */
>      d =3D muldiv64(current_time - ti->load_time,
> -                 CUDA_TIMER_FREQ, NANOSECONDS_PER_SECOND);
> +                 ti->frequency, NANOSECONDS_PER_SECOND);
>      /* the timer goes down from latch to -1 (period of latch + 2) */
>      if (d <=3D (ti->counter_value + 1)) {
>          counter =3D (ti->counter_value - d) & 0xffff;
> @@ -210,7 +210,7 @@ static int64_t get_next_irq_time(CUDATimer *ti, int64=
_t current_time)
>      }
>      CUDA_DPRINTF("latch=3D%d counter=3D%" PRId64 " delta_next=3D%" PRId6=
4 "\n",
>                   ti->latch, d, next_time - d);
> -    next_time =3D muldiv64(next_time, NANOSECONDS_PER_SECOND, CUDA_TIMER=
_FREQ) +
> +    next_time =3D muldiv64(next_time, NANOSECONDS_PER_SECOND, ti->freque=
ncy) +
>                           ti->load_time;
>      if (next_time <=3D current_time) {
>          next_time =3D current_time + 1;
> @@ -879,7 +879,7 @@ static void cuda_realizefn(DeviceState *dev, Error **=
errp)
>      struct tm tm;
> =20
>      s->timers[0].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer1,=
 s);
> -    s->timers[0].frequency =3D s->tb_frequency;
> +    s->timers[0].frequency =3D CUDA_TIMER_FREQ;
>      s->timers[1].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer2,=
 s);
>      s->timers[1].frequency =3D (SCALE_US * 6000) / 4700;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w1TwAseT95X423KH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp/fRIACgkQbDjKyiDZ
s5I4AhAAij6JALHo2BmVN+v+oLJqG6mECC/9CvDZCzZ6zp9REUduovEbShyNw3XY
BBHLmdIUSm94SReV6HJQUWeqibM7LeIWEJfLwiL4tUnTxjfVYJQWlLODUOGZyiCk
EmkUgCVGyJQOIWhoxD6O22JoLWxcdUZGY98uFMA7KWNGukzbsrk2JRBPlHOnvGpZ
vbF37/m5eJkUHDYGs7VpesjDT3Jxzd+m03ABdaWO4gUW7PQKshJUTDjDyb84oet5
/1QVe9OjOHGWbY0g3nyqoY0AfQbkQLvd6HkbiCGox6OugHrZfhXROU7qSv+rL2x5
IVIJOByoR4sLk4IssX8Fw2P35yqZ1+i3c8Q/tc/HEFnBhvIbj39NF+gJJMRwtQy4
B+aZjusYAokTtnIkvFHqzU6/4oPYHikTL1+MS6cnP8BvzrYRp0xX3A6lRjuxXO7O
U31SJ3/G43QCTatzzzfjQrakQ/KaGO030y9VK32dTRapIuFB0ubCWr14HHlwUrQI
4xmRyWCK0nMv3N9dU5NfGeNer5LO5PSid8uc6Yq8hQy8Cv+fFv9QnxFlXPhhLqnM
9UESGaLk0dRzWs5lOWCL72EpQ87xQwxvMI47iX26pIe8tCbenHEV/lV4077XM+XG
LJac8fqklA041CYuSJnMEWJqvCfKUsk9QDxy9WGAaY0NaefNvoQ=
=PCpd
-----END PGP SIGNATURE-----

--w1TwAseT95X423KH--
