Received: from eggs.gnu.org ([209.51.188.92]:39847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0hS5-0007NB-Qj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0hIO-00047G-1c
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:41:53 -0500
Date: Mon, 4 Mar 2019 16:51:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304055138.GN7792@umbus.fritz.box>
References: <20190228225759.21328-1-farosas@linux.ibm.com>
	<20190228225759.21328-4-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/TUrtqMIkCP4YtJm"
Content-Disposition: inline
In-Reply-To: <20190228225759.21328-4-farosas@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4 3/5] target/ppc: Move handling of
 hardware breakpoints to a separate function
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


--/TUrtqMIkCP4YtJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 07:57:57PM -0300, Fabiano Rosas wrote:
> This is in preparation for a refactoring of the kvm_handle_debug
> function in the next patch.
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>

Nice cleanup regardless of anything else.  Applied to ppc-for-4.0.

> ---
>  target/ppc/kvm.c | 47 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d01852fe31..941c4e7523 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1593,35 +1593,44 @@ void kvm_arch_update_guest_debug(CPUState *cs, st=
ruct kvm_guest_debug *dbg)
>      }
>  }
> =20
> +static int kvm_handle_hw_breakpoint(CPUState *cs,
> +                                    struct kvm_debug_exit_arch *arch_inf=
o)
> +{
> +    int handle =3D 0;
> +    int n;
> +    int flag =3D 0;
> +
> +    if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
> +        if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
> +            n =3D find_hw_breakpoint(arch_info->address, GDB_BREAKPOINT_=
HW);
> +            if (n >=3D 0) {
> +                handle =3D 1;
> +            }
> +        } else if (arch_info->status & (KVMPPC_DEBUG_WATCH_READ |
> +                                        KVMPPC_DEBUG_WATCH_WRITE)) {
> +            n =3D find_hw_watchpoint(arch_info->address,  &flag);
> +            if (n >=3D 0) {
> +                handle =3D 1;
> +                cs->watchpoint_hit =3D &hw_watchpoint;
> +                hw_watchpoint.vaddr =3D hw_debug_points[n].addr;
> +                hw_watchpoint.flags =3D flag;
> +            }
> +        }
> +    }
> +    return handle;
> +}
> +
>  static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      struct kvm_debug_exit_arch *arch_info =3D &run->debug.arch;
>      int handle =3D 0;
> -    int n;
> -    int flag =3D 0;
> =20
>      if (cs->singlestep_enabled) {
>          handle =3D 1;
>      } else if (arch_info->status) {
> -        if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
> -            if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
> -                n =3D find_hw_breakpoint(arch_info->address, GDB_BREAKPO=
INT_HW);
> -                if (n >=3D 0) {
> -                    handle =3D 1;
> -                }
> -            } else if (arch_info->status & (KVMPPC_DEBUG_WATCH_READ |
> -                                            KVMPPC_DEBUG_WATCH_WRITE)) {
> -                n =3D find_hw_watchpoint(arch_info->address,  &flag);
> -                if (n >=3D 0) {
> -                    handle =3D 1;
> -                    cs->watchpoint_hit =3D &hw_watchpoint;
> -                    hw_watchpoint.vaddr =3D hw_debug_points[n].addr;
> -                    hw_watchpoint.flags =3D flag;
> -                }
> -            }
> -        }
> +        handle =3D kvm_handle_hw_breakpoint(cs, arch_info);
>      } else if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
>          handle =3D 1;
>      } else {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/TUrtqMIkCP4YtJm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8vOoACgkQbDjKyiDZ
s5J3DxAA5059wHnBhQ2Lg47Rx5N/FMcZ3v4XiulmsMxR3ZI7Eby8B2z56JRTm2yl
iqjDVGTEtl64rfKGDKvUKgIGvfrtnJ7dXw36RzFQwykdcdvlvRFea32i3SSOOMSm
dnirVWXGz+WmNdPB8MWnvm8VMqslE3UhIANkvBMmYyf0tS7OTfOcTI3TZZFU1dz9
qeKe5pFxtnrwECvLlIlVtO6a0Sbtq17KE16lxzBLVFkU0ZeSuJiSQYyENcmtBGZC
O3TBGj5V/EpG3HzNTb+VJO0ehJMp+RtkBPCT+qkWlC7E17UhQY/P2UyMUexWIeUe
rVtRD7Ruy02raZhQvxi32qsUAgxnnlCAF0T1gyPCn012mBae33mcGfAdOHclV4EK
6aiTVIZdn69yiAJ3nsL0a/Z/TMv7aVN4Tl1n9gRCVeBHq13JXIvdaAOIiJ7HQ6lb
g9qNtDXghGU0h/uUXxf7l6tuoS3DBZo4vcMvaiM44WRCERwxMf8Wee4HabPAyCCV
ZvrlQAMCqSBk72csMJvwFp8c6ECxiSd57LMuy58OZLIVq5f6fHTpa7eUPP+Uad+e
l3lE4uMA+32jNb3CVHah2VLFCejgx4p+QABR5yPplkDFlQokEgyZ4djjakaIseM0
yDGcQlTf3k6I13Lempdkw83076WEzavhwEGS3NbxuBvkgiiGrHE=
=xwJw
-----END PGP SIGNATURE-----

--/TUrtqMIkCP4YtJm--
