Received: from eggs.gnu.org ([2001:4830:134:3::10]:59114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct6Rw-0007wa-KS
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct6Rt-00029t-HP
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:47:16 -0400
Date: Wed, 29 Mar 2017 16:23:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329052311.GB21068@umbus.fritz.box>
References: <cover.1490763676.git.sam.bobroff@au1.ibm.com>
	<fe96334e261ed8da1c03202ea88a139b479c0c23.1490763676.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nm48CqPeykZpOG4/"
Content-Disposition: inline
In-Reply-To: <fe96334e261ed8da1c03202ea88a139b479c0c23.1490763676.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] target/ppc: Improve accuracy of guest
 HTM availability on P8s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, thuth@redhat.com


--Nm48CqPeykZpOG4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 04:01:28PM +1100, Sam Bobroff wrote:
> On Power8 hosts it is currently theoretically possible for QEMU/KVM-HV gu=
ests
> to receive a ibm,pa-features property indicating that HTM support is avai=
lable
> when it is not.  The situation would occur if the platform firmware of
> a Power8 host cleared the HTM bit of the ibm,pa-features property.
> QEMU would query KVM for the availability of HTM, which will return no
> support, but workaround code in kvm_arch_init_vcpu() would then
> re-enable it because KVM_HV is in use and the processor is P8.
>=20
> This patch adjusts the workaround in kvm_arch_init_vcpu() so that it does=
 not
> enable HTM (in the above case) unless the host kernel indicates to the QE=
MU
> process, via the auxiliary vector, that userspace can use HTM (via the HW=
CAP2
> bit KVM_FEATURE2_HTM).
>=20
> The reason to use the value from the auxiliary vector is that it is
> set based only on what the host kernel found in the ibm,pa-features
> HTM bit at boot time.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Applied to ppc-for-2.9.

> ---
>  target/ppc/kvm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 9f1f132cef..8a54709ae4 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -49,6 +49,7 @@
>  #if defined(TARGET_PPC64)
>  #include "hw/ppc/spapr_cpu_core.h"
>  #endif
> +#include "elf.h"
> =20
>  //#define DEBUG_KVM
> =20
> @@ -509,8 +510,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      case POWERPC_MMU_2_07:
>          if (!cap_htm && !kvmppc_is_pr(cs->kvm_state)) {
>              /* KVM-HV has transactional memory on POWER8 also without the
> -             * KVM_CAP_PPC_HTM extension, so enable it here instead. */
> -            cap_htm =3D true;
> +             * KVM_CAP_PPC_HTM extension, so enable it here instead as
> +             * long as it's availble to userspace on the host. */
> +            if (qemu_getauxval(AT_HWCAP2) & PPC_FEATURE2_HAS_HTM) {
> +                cap_htm =3D true;
> +            }
>          }
>          break;
>      default:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Nm48CqPeykZpOG4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY20S/AAoJEGw4ysog2bOSeAwP/jZhN0ziX/ff+lyr8T1HOneh
ubVxW4EF+PT8/fAk3x7gu630e0jdi2vvT/VUR6E2uiUcMIB2feJu/Kd869q8jZ+8
Q0buoIVIvG7LPrc5TxvxpycUkm2Xr7S4WjPWnsTmOPvDGhTattXkPA8WHJqBFzfs
wWxqldRz9OY7M8vDpRe6g1ZyJH1FGGREYGsqG6qp8cDwpHXs60NZ+fZdhblEXfm0
pdSuip6oPG0rlA14XaItH/b7g4T7o1SzwMXA6qwbHLXbNVTeN6V3X/n1v76i/aKK
d66mkkuI3Up0o5R83eIreK7tCc827XJJ4Ct2M8ecA+S/8GiwEhDPBWd1CkL2xtK/
ziQdCCQSKWKakblQjbJNbzpY+9/+Ynf3R5HcBnzIcx6hXgdhLv0oi/+W+Yt90ZTf
WVYOkRXl23hkR6mj8NLqcBDQ0fogPkwn3Phs4DLZl/FXU+Qdv8JgY9r8V8lEKI1g
jIEqRGNqKx5CTAxdHLsB4AJ+5Wwpq/+sWiCz1Ras0DzCZOuMikbLfkMja2QmHfA4
f8BT1Za98PmcetGbPtF8cYk132lEMEKJEXMdzhG/iMygJhXW+ZCyRR6kLRwi4Mrt
lw2zVCh8p6MIb+Wevkmn21ncUo5oiYhDSeGOz+XZGHS3GtpBdhweXPFYYENooU8g
gSCBKhWEMVAtjhVimFSl
=bY5T
-----END PGP SIGNATURE-----

--Nm48CqPeykZpOG4/--
