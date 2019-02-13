Received: from eggs.gnu.org ([209.51.188.92]:45509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtn6V-0008Hm-R0
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtmwX-0005NT-EX
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:18:49 -0500
Date: Wed, 13 Feb 2019 16:11:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213051109.GQ1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-16-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5ch3vXimoUl90IHM"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-16-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 15/19] target/ppc: Detect erroneous
 condition in interrupt delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--5ch3vXimoUl90IHM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:21AM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> It's very easy for the CPU specific has_work() implementation
> and the logic in ppc_hw_interrupt() to be subtly out of sync.
>=20
> This can occasionally allow a CPU to wakeup from a PM state
> and resume executing past the PM instruction when it should
> resume at the 0x100 vector.
>=20
> This detects if it happens and aborts, making it a lot easier
> to catch such bugs when testing rather than chasing obscure
> guest misbehaviour.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/excp_helper.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 37546bb0f0fe..1a2f469a5fa2 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -878,6 +878,22 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>              return;
>          }
>      }
> +
> +    if (env->resume_as_sreset) {
> +        /*
> +         * This is a bug ! It means that has_work took us out of halt wi=
thout
> +         * anything to deliver while in a PM state that requires getting
> +         * out via a 0x100
> +         *
> +         * This means we will incorrectly execute past the power managem=
ent
> +         * instruction instead of triggering a reset.
> +         *
> +         * It generally means a discrepancy between the wakup conditions=
 in the
> +         * processor has_work implementation and the logic in this funct=
ion.
> +         */
> +        cpu_abort(CPU(ppc_env_get_cpu(env)),
> +                  "Wakeup from PM state but interrupt Undelivered");
> +    }
>  }
> =20
>  void ppc_cpu_do_system_reset(CPUState *cs)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5ch3vXimoUl90IHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjpu0ACgkQbDjKyiDZ
s5LFARAAgcJAyvWFIwqM+Vtef0EbpeXkJtmVHs+FAWgVQafiFEoVKeQV/qQckRG5
kfsfpgO7TPrNsjHhnuVBpgxK2MUBQUzqfmcozZIq0G8HBApqF+8kry8DatfiSX3s
livuU6NOG0qEvD1iYZnhEkDzA+0NqGAseJX9ynco9WpAoXEiDN0bNSv9Hi+DQ3zz
3Ru2B+YwdGrzo1FS0nG9kPbjcaRSubHc6iHIhZtWlbFbMFNU3uTpDEE3Y2thxoAn
7aXJYf9TcOmBORoYPXfj1euHcVDLA1ySWEhgzZF4ulihLNcL9Dwt2iIFUGYxAZu4
ndb133JLtNAdEqlzhlR2t+gC4N6n1bUafuMOL/m3jp+h4vI7Y633xBWTT8zMJ35l
8tPdiBzzLm+6QOHjkNfwAcTQTPnIvHPBcXEq7TAIu3Zwa9lBYV2twNK0HHnXJUWS
ZYGBrdNHVFBnmUwf9RLNcm7dH6FKUYJU+5vhnWmnrIrBREA0KH7Myxdk0TSgMmc6
K5+TQxgWY9CenUJMgKJoxMJMfYXnCgs+jgK4a8mjvTsHH9EE2iEncrWzzo2dd7Ga
QwvMQZLTWhNdIVqUpjAVsA6Yq13YZ3aVuzlvAMHH8XVlNNS5Egqnap/wCXJ4EaA5
rlcowE3/2Y1y55+OQCHq1rZ2qzka59fL11s8FhQoRPlMWFhzaww=
=TmT3
-----END PGP SIGNATURE-----

--5ch3vXimoUl90IHM--
