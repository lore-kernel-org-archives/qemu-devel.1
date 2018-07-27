Received: from eggs.gnu.org ([2001:4830:134:3::10]:58599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fitaX-000288-Fh
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 23:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fitaW-0005dv-FY
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 23:38:45 -0400
Date: Fri, 27 Jul 2018 13:13:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180727031348.GD3694@umbus.fritz.box>
References: <153259340275.5529.15876484471761179518.stgit@dhcp-9-109-246-16>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
In-Reply-To: <153259340275.5529.15876484471761179518.stgit@dhcp-9-109-246-16>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] linux-user: ppc64: don't use
 volatile register during safe_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Cc: dgibson@redhat.com, riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 01:56:19PM +0530, Shivaprasad G Bhat wrote:
> r11 is a volatile register on PPC as per calling conventions.
> The safe_syscall code uses it to check if the signal_pending
> is set during the safe_syscall. When a syscall is interrupted
> on return from signal handling, the r11 might be corrupted
> before we retry the syscall leading to a crash. The registers
> r0-r13 are not to be used here as they have
> volatile/designated/reserved usages. Change the code to use
> r14 which is non-volatile and is appropriate for local use in
> safe_syscall.
>=20
> Steps to reproduce:
> On PPC host, issue `qemu-x86_64 /usr/bin/cc -E -`
> Attempt Ctrl-C, the issue is reproduced.
>=20
> Reference:
> https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#REG
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Applied to ppc-for-3.0.

> ---
> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg05089.html
> Changes from v1:
>    Fixed the commit message as suggested
>=20
>  linux-user/host/ppc64/safe-syscall.inc.S |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/linux-user/host/ppc64/safe-syscall.inc.S b/linux-user/host/p=
pc64/safe-syscall.inc.S
> index d30050a67c..b0cbbe6a69 100644
> --- a/linux-user/host/ppc64/safe-syscall.inc.S
> +++ b/linux-user/host/ppc64/safe-syscall.inc.S
> @@ -49,7 +49,7 @@ safe_syscall_base:
>  	 *               and returns the result in r3
>  	 * Shuffle everything around appropriately.
>  	 */
> -	mr	11, 3	/* signal_pending */
> +	mr	14, 3	/* signal_pending */
>  	mr	0, 4	/* syscall number */
>  	mr	3, 5	/* syscall arguments */
>  	mr	4, 6
> @@ -67,7 +67,7 @@ safe_syscall_base:
>  	 */
>  safe_syscall_start:
>  	/* if signal_pending is non-zero, don't do the call */
> -	lwz	12, 0(11)
> +	lwz	12, 0(14)
>  	cmpwi	0, 12, 0
>  	bne-	0f
>  	sc
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltajekACgkQbDjKyiDZ
s5IANA//a+m9Ez4xMOA9Rczh3LRoqNP+3feLlEL7a8wUxSLHrvKz5fcH6Halch2U
QUseRrJs76EP8HRriz2sX96RW2WDEfJz6IDWuCBkK4iMLg4H7FKk1IOu+Ib2alPS
FL/eXngIkpfoYWaMCavmjymMcmREbIx8kTApZi6OtOGPUla6e3Vt0wWwesWSYa5v
fC6OlOr+MjfOrrrZgQeUzycGcAc5dT5m00ydEz0XD1XECkQjEZHn8r369NQpK77k
8eFZb2GZiU7VzO6SUJT+oLKsfsFEeKyrhdv0Qnk79OpVRC8sayUJCEsgaO7fJzfQ
aOmy0pYD2/uCXxfqAVL09w3GMCwAKla06dhIyR1rP+T7UojhWU5s5aG8kDuicvH4
PBrduu+ZH8Vo/Ffe5/pyvLCJzOh/+HyVQDt6Xj0ACKEkwGIUjxoqo9u8Vc7n+sF2
8uyDGrcIOWYRSeOblMbz1vSiGcMbpnCmKOyPBuq1ofQW7PstLlpNplb1S2Lv7P9P
bcJXPgMC8PRcoAJPBFzHnIDpTgiAotQnKsUKqoSlVVFNDoCs7kL+yXbwCQR+n+v3
m2C9SOa78RUQ4fRXVg+UE6YelryStfaj+2gpYgJZqbAUQ9mAqFuykc2v3rLtQhYA
LI4HlLAkIZ6/fObfjcoVn8/UGJs5+AoQPsi/hoVYvlSEfLKWIrQ=
=hHlk
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
