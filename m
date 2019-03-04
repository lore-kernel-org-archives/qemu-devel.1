Received: from eggs.gnu.org ([209.51.188.92]:58491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0gNq-0005B9-Bu
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 00:43:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0gNm-0005fY-Ll
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 00:43:26 -0500
Date: Mon, 4 Mar 2019 16:36:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304053647.GI7792@umbus.fritz.box>
References: <20190228225759.21328-1-farosas@linux.ibm.com>
	<20190228225759.21328-2-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h22Fi9ANawrtbNPX"
Content-Disposition: inline
In-Reply-To: <20190228225759.21328-2-farosas@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4 1/5] target/ppc: Move exception
 vector offset computation into a function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexey Kardashevskiy <aik@ozlabs.ru>


--h22Fi9ANawrtbNPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 07:57:55PM -0300, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

This is a nice cleanup, regardless of the rest of the series.  Applied
to ppc-for-4.0.

> ---
>  target/ppc/excp_helper.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 39bedbb11d..beafcf1ebd 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -107,6 +107,24 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPC=
State *env, int excp,
>      return POWERPC_EXCP_RESET;
>  }
> =20
> +static uint64_t ppc_excp_vector_offset(CPUState *cs, int ail)
> +{
> +    uint64_t offset =3D 0;
> +
> +    switch (ail) {
> +    case AIL_0001_8000:
> +        offset =3D 0x18000;
> +        break;
> +    case AIL_C000_0000_0000_4000:
> +        offset =3D 0xc000000000004000ull;
> +        break;
> +    default:
> +        cpu_abort(cs, "Invalid AIL combination %d\n", ail);
> +        break;
> +    }
> +
> +    return offset;
> +}
> =20
>  /* Note that this function should be greatly optimized
>   * when called with a constant excp, from ppc_hw_interrupt
> @@ -708,17 +726,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>      /* Handle AIL */
>      if (ail) {
>          new_msr |=3D (1 << MSR_IR) | (1 << MSR_DR);
> -        switch(ail) {
> -        case AIL_0001_8000:
> -            vector |=3D 0x18000;
> -            break;
> -        case AIL_C000_0000_0000_4000:
> -            vector |=3D 0xc000000000004000ull;
> -            break;
> -        default:
> -            cpu_abort(cs, "Invalid AIL combination %d\n", ail);
> -            break;
> -        }
> +        vector |=3D ppc_excp_vector_offset(cs, ail);
>      }
> =20
>  #if defined(TARGET_PPC64)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h22Fi9ANawrtbNPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8uWwACgkQbDjKyiDZ
s5JaWg/9Hvpi11qPxVEmZNjnwSL7isSKHLUzv82Lla+gWC0cUubLxVvFZzdDRa1N
PxKeeB5jH57PubHDZnkKHQ6IK7j7TX36MS89Y2bZI6/xfo9eWiw03ziSS+90MDUm
SECT3dkynJ3+LX3JPdoXPmjZmsmHLrcHhEG+dgvusN6EfLFuSzHclgn/6SLQDc73
Y+mX0nsfk6z4rBjzaM943ffFJgHGD+QdUlHElPl0heOFI8PBO6ees4LQ3kCUvCxn
GF2NaCp5rGWvrr3vSm9TlSDW5tC5vnBJqpzKJ7c937N4huYPXiKAWigk8EQAc1jW
beCdsXnU+/YYsHxeQxzmMwAsZvWfqkTx1FU67vgxsba4SqSrM5lz+27q+llEKo0W
+c5C/1G7KorHN1xhloYGewf7ozHt1a8oRRSQM1I6u2KD59v85ZkwZKhtuDegPzRi
0odGDQDjmkntH2Ww+/kI+Zo65l+yH1F+LTQEET9cjKI3fkXigi6Lt33sSuXbn4K6
m66fHJl38xFRB70qk+xM2bviL6ljCm3urEPW97j/NkxmFnwEJ3FiWLhEGFxSTsmM
bffz0TfxEDFv6Eyxy1Yk840Wt/GQSklj082pNhCzumd5BJKCIWCbpf1Nm29bvVqp
n5odH9Iy6G0JM+orWYdzc7QnCJA4lWBVvsZagWrNgqdxF8FHsus=
=ABJL
-----END PGP SIGNATURE-----

--h22Fi9ANawrtbNPX--
