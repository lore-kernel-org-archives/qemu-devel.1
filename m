Received: from eggs.gnu.org ([2001:4830:134:3::10]:53177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ezcQs-0001tD-OV
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 02:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ezcQp-0003AO-Gt
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 02:13:38 -0400
Received: from ozlabs.org ([103.22.144.67]:53309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ezcQo-00034p-8t
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 02:13:35 -0400
Date: Sat, 24 Mar 2018 16:30:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180324053038.GA7432@umbus.fritz.box>
References: <alpine.LSU.2.21.1802231729040.10187@wotan.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1802231729040.10187@wotan.suse.de>
Subject: Re: [Qemu-devel] [PATCH] ppc: Fix size of ppc64 xer register (fwd)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Matz <matz@suse.de>
Cc: qemu-devel@nongnu.org, Torsten Duwe <duwe@suse.de>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 05:29:56PM +0000, Michael Matz wrote:
> The normal gdb definition of the XER registers is only 32 bit,
> and that's what the current version of power64-core.xml also
> says (seems copied from gdb's).  But qemu's idea of the XER register
> is target_ulong (in CPUPPCState, ppc_gdb_register_len and
> ppc_cpu_gdb_read_register)
>=20
> That mismatch leads to the following message when attaching
> with gdb:
>=20
>   Truncated register 32 in remote 'g' packet
>=20
> (and following on that qemu stops responding).  The simple fix is
> to say the truth in the .xml file.  But the better fix is to
> actually make it 32bit on the wire, as old gdbs don't support
> XML files for describing registers.  Also the XER state in qemu
> doesn't seem to use the high 32 bits, so sending it off to gdb
> doesn't seem worthwhile.
>=20
> Signed-off-by: Michael Matz <matz@suse.de>

Sorry I've taken so long to look at this.  I've now applied it to my
ppc-for-2.13 branch (since it's not a regression, I don't think it's
justified to include it during the 2.12 hard freeze).

In future, please CC me directly on mails (as ppc maintainer) and also
CC qemu-ppc@nongnu.org.  I might never have spotted this if Alex Graf
hadn't forwarded a pointer to me.

> ---
>  target/ppc/gdbstub.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 7a33813..b6f6693 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -37,10 +37,10 @@ static int ppc_gdb_register_len_apple(int n)
>      case 65+32: /* msr */
>      case 67+32: /* lr */
>      case 68+32: /* ctr */
> -    case 69+32: /* xer */
>      case 70+32: /* fpscr */
>          return 8;
>      case 66+32: /* cr */
> +    case 69+32: /* xer */
>          return 4;
>      default:
>          return 0;
> @@ -61,6 +61,8 @@ static int ppc_gdb_register_len(int n)
>          return 8;
>      case 66:
>          /* cr */
> +    case 69:
> +        /* xer */
>          return 4;
>      case 64:
>          /* nip */
> @@ -70,8 +72,6 @@ static int ppc_gdb_register_len(int n)
>          /* lr */
>      case 68:
>          /* ctr */
> -    case 69:
> -        /* xer */
>          return sizeof(target_ulong);
>      case 70:
>          /* fpscr */
> @@ -152,7 +152,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *=
mem_buf, int n)
>              gdb_get_regl(mem_buf, env->ctr);
>              break;
>          case 69:
> -            gdb_get_regl(mem_buf, env->xer);
> +            gdb_get_reg32(mem_buf, env->xer);
>              break;
>          case 70:
>              gdb_get_reg32(mem_buf, env->fpscr);
> @@ -208,7 +208,7 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, uin=
t8_t *mem_buf, int n)
>              gdb_get_reg64(mem_buf, env->ctr);
>              break;
>          case 69 + 32:
> -            gdb_get_reg64(mem_buf, env->xer);
> +            gdb_get_reg32(mem_buf, env->xer);
>              break;
>          case 70 + 32:
>              gdb_get_reg64(mem_buf, env->fpscr);
> @@ -259,7 +259,7 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t =
*mem_buf, int n)
>              env->ctr =3D ldtul_p(mem_buf);
>              break;
>          case 69:
> -            env->xer =3D ldtul_p(mem_buf);
> +            env->xer =3D ldl_p(mem_buf);
>              break;
>          case 70:
>              /* fpscr */
> @@ -309,7 +309,7 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cs, ui=
nt8_t *mem_buf, int n)
>              env->ctr =3D ldq_p(mem_buf);
>              break;
>          case 69 + 32:
> -            env->xer =3D ldq_p(mem_buf);
> +            env->xer =3D ldl_p(mem_buf);
>              break;
>          case 70 + 32:
>              /* fpscr */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlq14nsACgkQbDjKyiDZ
s5IG3BAAvoQHXB6x8rqShzjABfLEJ8BX9neT4jGtG7a2BczuP1pC09fO128xrXFr
5JrT1aaVmJ799qSNU3BJrJUN+RtHF1HRYauljHKydDJeXoYTgjME/vNfcubvWydJ
/erIpidqBW4YxjzITNknUU3iQAzFw1dNGzb8gji4eczeQLM/dCFbMajtA31PR2Aa
Dq1NcFK4pThnY4YesAe59iHBVOR2A8PaxysaSiFfkSAFIsvzbmhkN+BhM2HYa8dt
UVYzVLrZtLIR1l4Ols6oCr7wpfZs53rkkPVFEcYtWNCRb5UuSYNZEmNrm0eoDsgA
OQbny96TtxEDia8+OIBZgfuc8YHGPU3itPhgU7paVWUxuMcKYqW33aTLWbm3qt/N
tjDn/piesF95mbnaP82jxnnURLZuLUEdSoLIZzz1me7OjHF6KTt2C6b7JNpvvmmf
tg7MH3eQynRyVYIp5UHrLcxQwX0jHr0bGimCSZkNOLFMMNJ7K7BwtaMnmVvPYzq2
Vo4Crtf97mDEPIYzX3jqbSkWqaYNaUNVmzvO76ogLizP9hiBOoj9U8MWsCU8jWAp
MSfFuedBMhB9BrEHkbCGH1Bb7EYPGQNMqRnvXCSAlzkLX6jLd96bIdcHkvjqMJMs
jOO+PicIEgRgUuCzGzP2x8XTperwhqcJcjIr7ILTldkuRmoWKfA=
=JVpJ
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
