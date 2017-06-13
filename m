Received: from eggs.gnu.org ([2001:4830:134:3::10]:36829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKxAK-0001kq-I1
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 21:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKxAJ-0006H7-Hh
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 21:32:12 -0400
Date: Tue, 13 Jun 2017 23:29:39 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170613152939.GC13420@umbus>
References: <1497351329-12936-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <1497351329-12936-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc/excp_helper: Take BQL before
 calling cpu_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 12:55:29PM +0200, Thomas Huth wrote:
> Since the introduction of MTTCG, using the msgsnd instruction
> abort()s if being called without holding the BQL. So let's protect
> that part of the code now with qemu_mutex_lock_iothread().
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1694998
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.10.

> ---
>  target/ppc/excp_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 9cb2123..3a9f086 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -17,6 +17,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
> @@ -1132,6 +1133,7 @@ void helper_msgsnd(target_ulong rb)
>          return;
>      }
> =20
> +    qemu_mutex_lock_iothread();
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>          CPUPPCState *cenv =3D &cpu->env;
> @@ -1141,5 +1143,6 @@ void helper_msgsnd(target_ulong rb)
>              cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>          }
>      }
> +    qemu_mutex_unlock_iothread();
>  }
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQATgAAoJEGw4ysog2bOSWAsQAKGhxc/bNx3m7YfCV4oVCMsh
ln1Wtv8SAZ3ihgEZaP2DtMD0rPLQdqsIlDVEPSoikjBgKioCyMVLAVbjMSrMfoHs
ov05stARj/DhLT4kS4O1rHI8O8aqWrL2gqdFNcO0DIiiDo21iKtTzCEQ8Q69EHsp
Pr7roU4TsUwfX8EmkJK5VmqUhTOZCR8J8iEJsO3ht2coAu37YrNy6FMoxLNB7lbQ
xAfgJdqElFJGzgeGHh4fiN6eXjwkzqadwwTOigGIwbruLyJeffv6dtTBaEb5bnUm
H21qbd5VWrtzN/FX+36PRYW73wji85fNqhVIUktg1m9BfX9DC4kdpYigFZBna1E+
hEhMrNYrHW3LUSiZRKWh2bE/AFX5sXsIWBiO+AaIj4tueBBVFQQ2GfT6KpNVxEVO
plXQRd+8cIiYDQrg9+f0X84lVHiUOqXQW9BkKxgxfIV6gIYveEZCTXp9xsV5Tiqi
DJHjINpQVFbzWqAf+OXqASzVSi0fMalmpITeFPs+Cyh1lhTKiDNlKdcq+NOos79p
O8N4do9mNrvjlOlJJkdLOCxx3vDhvzr3Xg4ylZTJrjA9AxwTHVArXOQILXhg3195
6rZFkUrCFGV5gc33Wp9bymuNhNeSxYhKrAPt7NQpfSimU3EeiEPd6Deb7/Hsntn9
DvrBK2P+QSamwliJROu/
=IPn9
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
