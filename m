Received: from eggs.gnu.org ([2001:4830:134:3::10]:34072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPpZp-0002cl-8Q
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPpZk-0007Mt-UM
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:03:29 -0500
Received: from ozlabs.org ([203.11.71.1]:51959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gPpZj-0007HO-Sm
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:03:24 -0500
Date: Fri, 23 Nov 2018 00:22:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181122132238.GL10448@umbus.fritz.box>
References: <20181121181347.24035-1-farosas@linux.ibm.com>
	<20181121181347.24035-2-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AGBBLMjITsWHeOTZ"
Content-Disposition: inline
In-Reply-To: <20181121181347.24035-2-farosas@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/3] target/ppc: Add macro
 definitions for relocated interrupt vectors offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: qemu-devel@nongnu.org, philmd@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>


--AGBBLMjITsWHeOTZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 04:13:45PM -0200, Fabiano Rosas wrote:
> The PowerISA prescribes that depending on the values of MSR_IR,
> MSR_DR, MSR_HV and LPCR_AIL, the interrupt vectors might be relocated
> by specific offsets.
>=20
> This patch defines macros for these offsets so that they can be used
> by another part of the code in a future patch.
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  target/ppc/cpu.h         | 3 +++
>  target/ppc/excp_helper.c | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index ab68abe8a2..5147db4460 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2390,6 +2390,9 @@ enum {
>      AIL_C000_0000_0000_4000 =3D 3,
>  };
> =20
> +#define AIL_0001_8000_OFFSET 0x18000
> +#define AIL_C000_0000_0000_4000_OFFSET 0xc000000000004000ull

Hrm.  Is there really a point making a #define, if the name spells out
the value?  It's not like you can change the value without having to
change the places that use it that way?


>  /***********************************************************************=
******/
> =20
>  #define is_isa300(ctx) (!!(ctx->insns_flags2 & PPC2_ISA300))
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 0ec7ae1ad4..49bdf7dd54 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -687,10 +687,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, in=
t excp_model, int excp)
>          new_msr |=3D (1 << MSR_IR) | (1 << MSR_DR);
>          switch(ail) {
>          case AIL_0001_8000:
> -            vector |=3D 0x18000;
> +            vector |=3D AIL_0001_8000_OFFSET;
>              break;
>          case AIL_C000_0000_0000_4000:
> -            vector |=3D 0xc000000000004000ull;
> +            vector |=3D AIL_C000_0000_0000_4000_OFFSET;
>              break;
>          default:
>              cpu_abort(cs, "Invalid AIL combination %d\n", ail);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AGBBLMjITsWHeOTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv2rZwACgkQbDjKyiDZ
s5KpcA/+KVJLfQYBnu+nZjQ6ZGPTxE/JAwPUczCBLrRshoRqkHFvUAdY7MRzOTs6
JI/gP1+7ZPIAW/nTrlg5ylY0Hmt8Wdork9KtfNg8i2McpDPooJcuixfKMQl/ST5d
tH4KYlU8z0cUe/E/UsD3OdqORa55hwY+RzyJtdJXCreBXHIILYBYYy3FPn2JH2C2
yfOJlNnAFHsK7MgMzfw7GngUrfO2iJ/Rb10mrA8loMUALHFiRijNKibdmSU6QQai
dociwXvmobRxztqbLx+OKH/8eoMJrWcaDTMsN9kY6lqx2NcflKJjHzGpJyn0pyQ6
em6HQpQa04G6X7MiwvtursbipSAnN99ZbU19eVNna1uR77rNHYFEsZBeAAhqiP+0
Sax+EJoOE3N72x7mYnNggz0S/C6R9Ll8garUvQPaCCOR4ax7cQ+MngAJdyntSa+V
D45ymn1QYt9p4iyUZ0GKj+v+5xcIIbFVgokipsbpOXiXHvBqy9hGP81v++4akExb
VbZZXjzlKKtSmVGtP3G0iu2XZ4jjLXgefLPLhoQWrdpVb7Mv1M4FaYns1MszgdjQ
DV3IFabwAqOcyVjJNR3JRr//rl/jecnJqIOvnbBpLOt0sLTJi9HabbHXeQn9ZVld
6gie40QYw479fel2OQiYf5/rog6dyurd07xyNPEhOo0cpIqVmvA=
=hXAF
-----END PGP SIGNATURE-----

--AGBBLMjITsWHeOTZ--
