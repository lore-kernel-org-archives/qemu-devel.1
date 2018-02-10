Received: from eggs.gnu.org ([2001:4830:134:3::10]:45499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX7-0000jo-Kz
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekeX6-000196-7S
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:26:13 -0500
Date: Sun, 11 Feb 2018 10:18:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210231803.GX11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-9-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LvnU4bbuCGLV8PtK"
Content-Disposition: inline
In-Reply-To: <20180209185142.17151-9-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2 08/12] cuda: factor out timebase-derived
 counter value and load time
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


--LvnU4bbuCGLV8PtK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:51:38PM +0000, Mark Cave-Ayland wrote:
> Commit b981289c49 "PPC: Cuda: Use cuda timer to expose tbfreq to guest" a=
ltered
> the timer calculations from those based upon the hardware CUDA clock freq=
uency
> to those based upon the CPU timebase frequency.
>=20
> In fact we can isolate the differences to 2 simple changes: one to the co=
unter
> read value and another to the counter load time. Move these changes into
> separate functions so the implementation can be swapped later.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Applied, thanks.

> ---
>  hw/misc/macio/cuda.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index e00df4a21a..a185252144 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -145,21 +145,29 @@ static void cuda_update_irq(CUDAState *s)
>      }
>  }
> =20
> -static uint64_t get_tb(uint64_t time, uint64_t freq)
> +static uint64_t get_counter_value(CUDAState *s, CUDATimer *ti)
>  {
> -    return muldiv64(time, freq, NANOSECONDS_PER_SECOND);
> +    /* Reverse of the tb calculation algorithm that Mac OS X uses on boo=
tup */
> +    uint64_t tb_diff =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                                s->tb_frequency, NANOSECONDS_PER_SECOND)=
 -
> +                           ti->load_time;
> +
> +    return (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
> +}
> +
> +static uint64_t get_counter_load_time(CUDAState *s, CUDATimer *ti)
> +{
> +    uint64_t load_time =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
),
> +                                  s->tb_frequency, NANOSECONDS_PER_SECON=
D);
> +    return load_time;
>  }
> =20
>  static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
>  {
>      int64_t d;
>      unsigned int counter;
> -    uint64_t tb_diff;
> -    uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> =20
> -    /* Reverse of the tb calculation algorithm that Mac OS X uses on boo=
tup. */
> -    tb_diff =3D get_tb(current_time, s->tb_frequency) - ti->load_time;
> -    d =3D (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
> +    d =3D get_counter_value(s, ti);
> =20
>      if (ti->index =3D=3D 0) {
>          /* the timer goes down from latch to -1 (period of latch + 2) */
> @@ -178,8 +186,7 @@ static unsigned int get_counter(CUDAState *s, CUDATim=
er *ti)
>  static void set_counter(CUDAState *s, CUDATimer *ti, unsigned int val)
>  {
>      CUDA_DPRINTF("T%d.counter=3D%d\n", 1 + ti->index, val);
> -    ti->load_time =3D get_tb(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                           s->tb_frequency);
> +    ti->load_time =3D get_counter_load_time(s, ti);
>      ti->counter_value =3D val;
>      cuda_timer_update(s, ti, ti->load_time);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LvnU4bbuCGLV8PtK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp/fasACgkQbDjKyiDZ
s5IQsBAAxp0Esv9j5IRemS/nUYWVImWNiPjwPK6zZKqhti5CharVDAtCn9uRPMr2
BC/Ki1bZuSgTunKzfYR9VP7a6pUF01TI+DzprJ/mKay/nefdtsr/stoGrQleTfN6
YIKryl0iehQFj+P2lhHKuCU8ewI1NrjuBM8qbX1toxsTze5QNwR/vYrETJO/FJdh
Nu3kIO6zMfMUSnrqjBt0m7tL++aJwOFUosjWW18cH+8rL+CieeUZ8FepqzD7ajGl
g9bWZGK5USfpxLPpW11BHak1hTpEvq0bOKZX0WanLV6ljcFJr7cYTH60K17QJnBK
zv6F4apOCe97rONuNtT5lrbc9ec5EOryfCFvudr+omUlJAzS+Xzj0gjgIbotW01C
ZYJv+hLA1W/wWmMxh+RPk10sricadhg9TuvUPq2VK+Pa5a4SfgEgFYE0XB81h6wE
7/bp8KyU6U3YQnGUHwZepxXJPvTGrBJoOmFOuUmQZuppcZlV6S6RRbf22wU3QCCX
04exC67hIaoIEEfvAtPAS27r6l0q9ThPpFX5DH9F35BSbL+V0Yfv2zK2VE89Hr/s
2f4c8Xg4YuBPOuj/yD/qw4Io+r52HimR4QBA3gTkO+JI7hp9lc5fH1P+D60dyAbA
cauKjXjfvo6dN//uY6mrgd0/oM6Xiv9q45h2tTDrAye7GuWE1pQ=
=UKGl
-----END PGP SIGNATURE-----

--LvnU4bbuCGLV8PtK--
