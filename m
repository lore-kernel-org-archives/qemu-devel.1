Received: from eggs.gnu.org ([2001:4830:134:3::10]:50938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkXf-0006ZE-5O
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkXd-0001TK-IH
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:58:07 -0500
Date: Thu, 23 Feb 2017 14:45:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223034553.GI12577@umbus.fritz.box>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
	<1487563478-22265-4-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wwX5Nmi7feudBrEr"
Content-Disposition: inline
In-Reply-To: <1487563478-22265-4-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 03/10] target/ppc/POWER9:
 Adapt LPCR handling for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--wwX5Nmi7feudBrEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:04:31PM +1100, Suraj Jitindar Singh wrote:
> The logical partitioning control register controls a threads operation
> based on the partition it is currently executing. Add new definitions and
> update the mask used when writing to the LPCR based on the POWER9 spec.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/cpu.h            | 18 ++++++++++++++++++
>  target/ppc/mmu-hash64.c     |  8 ++++++++
>  target/ppc/translate_init.c | 24 ++++++++++++++++++------
>  3 files changed, 44 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index bb96dd5..425e79d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -384,12 +384,19 @@ struct ppc_slb_t {
>  #define LPCR_DPFD         (0x7ull << LPCR_DPFD_SHIFT)
>  #define LPCR_VRMASD_SHIFT (63 - 16)
>  #define LPCR_VRMASD       (0x1full << LPCR_VRMASD_SHIFT)
> +/* P9: Power-saving mode Exit Cause Enable (Upper Section) Mask */
> +#define LPCR_PECE_U_SHIFT (63 - 19)
> +#define LPCR_PECE_U_MASK  (0x7ull << LPCR_PECE_U_SHIFT)
> +#define LPCR_HVEE         (1ull << (63 - 17)) /* Hypervisor Virt Exit En=
able */
>  #define LPCR_RMLS_SHIFT   (63 - 37)
>  #define LPCR_RMLS         (0xfull << LPCR_RMLS_SHIFT)
>  #define LPCR_ILE          (1ull << (63 - 38))
>  #define LPCR_AIL_SHIFT    (63 - 40)      /* Alternate interrupt location=
 */
>  #define LPCR_AIL          (3ull << LPCR_AIL_SHIFT)
> +#define LPCR_UPRT         (1ull << (63 - 41)) /* Use Process Table */
> +#define LPCR_EVIRT        (1ull << (63 - 42)) /* Enhanced Virtualisation=
 */
>  #define LPCR_ONL          (1ull << (63 - 45))
> +#define LPCR_LD           (1ull << (63 - 46)) /* Large Decrementer */
>  #define LPCR_P7_PECE0     (1ull << (63 - 49))
>  #define LPCR_P7_PECE1     (1ull << (63 - 50))
>  #define LPCR_P7_PECE2     (1ull << (63 - 51))
> @@ -398,11 +405,22 @@ struct ppc_slb_t {
>  #define LPCR_P8_PECE2     (1ull << (63 - 49))
>  #define LPCR_P8_PECE3     (1ull << (63 - 50))
>  #define LPCR_P8_PECE4     (1ull << (63 - 51))
> +/* P9: Power-saving mode Exit Cause Enable (Lower Section) Mask */
> +#define LPCR_PECE_L_SHIFT (63 - 51)
> +#define LPCR_PECE_L_MASK  (0x1full << LPCR_PECE_L_SHIFT)
> +#define LPCR_PDEE         (1ull << (63 - 47)) /* Privileged Doorbell Exi=
t EN */
> +#define LPCR_HDEE         (1ull << (63 - 48)) /* Hyperv Doorbell Exit En=
able */
> +#define LPCR_EEE          (1ull << (63 - 49)) /* External Exit Enable   =
     */
> +#define LPCR_DEE          (1ull << (63 - 50)) /* Decrementer Exit Enable=
     */
> +#define LPCR_OEE          (1ull << (63 - 51)) /* Other Exit Enable      =
     */
>  #define LPCR_MER          (1ull << (63 - 52))
> +#define LPCR_GTSE         (1ull << (63 - 53)) /* Guest Translation Shoot=
down */
>  #define LPCR_TC           (1ull << (63 - 54))
> +#define LPCR_HEIC         (1ull << (63 - 59)) /* HV Extern Interrupt Con=
trol */
>  #define LPCR_LPES0        (1ull << (63 - 60))
>  #define LPCR_LPES1        (1ull << (63 - 61))
>  #define LPCR_RMI          (1ull << (63 - 62))
> +#define LPCR_HVICE        (1ull << (63 - 62)) /* HV Virtualisation Int E=
nable */
>  #define LPCR_HDICE        (1ull << (63 - 63))
> =20
>  #define msr_sf   ((env->msr >> MSR_SF)   & 1)
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index bb78fb5..24d9901 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1050,6 +1050,14 @@ void helper_store_lpcr(CPUPPCState *env, target_ul=
ong val)
>                        LPCR_P8_PECE2 | LPCR_P8_PECE3 | LPCR_P8_PECE4 |
>                        LPCR_MER | LPCR_TC | LPCR_LPES0 | LPCR_HDICE);
>          break;
> +    case POWERPC_MMU_3_00: /* P9 */
> +        lpcr =3D val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
> +                      (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_A=
IL |
> +                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL |
> +                      (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_=
EEE |
> +                      LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPC=
R_TC |
> +                      LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
> +        break;
>      default:
>          ;
>      }
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 84bf125..be35cbd 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8870,12 +8870,24 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu)
>      lpcr->default_value &=3D ~LPCR_RMLS;
>      lpcr->default_value |=3D 1ull << LPCR_RMLS_SHIFT;
> =20
> -    /* P7 and P8 has slightly different PECE bits, mostly because P8 adds
> -     * bit 47 and 48 which are reserved on P7. Here we set them all, whi=
ch
> -     * will work as expected for both implementations
> -     */
> -    lpcr->default_value |=3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PEC=
E2 |
> -                           LPCR_P8_PECE3 | LPCR_P8_PECE4;
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        /* By default we choose legacy mode and switch to new hash or ra=
dix
> +         * when a register process table hcall is made. So disable proce=
ss
> +         * tables and guest translation shootdown by default
> +         */
> +        lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
> +        lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR=
_DEE |
> +                               LPCR_OEE;
> +        break;
> +    default:
> +        /* P7 and P8 has slightly different PECE bits, mostly because P8=
 adds
> +         * bit 47 and 48 which are reserved on P7. Here we set them all,=
 which
> +         * will work as expected for both implementations
> +         */
> +        lpcr->default_value |=3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8=
_PECE2 |
> +                               LPCR_P8_PECE3 | LPCR_P8_PECE4;
> +    }
> =20
>      /* We should be followed by a CPU reset but update the active value
>       * just in case...

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wwX5Nmi7feudBrEr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrlrxAAoJEGw4ysog2bOSJPMP/0PZhC6YyY/NaWp5oWKkqg8f
74FsEpQP9waOHp5FUanzbTBskhLXRIb84p4vITKAGF1eNJ+y12XgNixp94TlNCAt
FGhhgi4u0KGWZwHzltvimsrO1Vy6j/dg7NN9tQnp27xlcNX2qozwGpKX3aCXhG1Y
n2W4Qb715OhhH0S5+HB/GUR248lP+KqS3uuOwuI6kMiYapCLnsjXuuEm9oDdPeh9
uQ0vBwisMMX+B6VDk3gBFnXGMLi0/U60FXRgW8Ry6S5apO9vGlkwEKLVxHU6BJr2
4FF4vc6PTwdbWXPhm54SEpOFAXQUx6eNXGmjt+zjYVKo1PPfBLBqgVJba9XlSN2h
WdndnwRcsbkLHEsHW9K+2zw4As1IBbBM4q13We69MyCHVd+edq449nBttuDEXc7Q
MsQqDccBVv1jkg917aetMfuW4xX49Kyqvn37hUkEWwefq6wDOkYockMzoGvrkGdi
FjwEY9XuI8rxqDYvsEDFrgyq9P+vrWGmbGEUF3nXaNdxf9bVvYaYauhW9Se9jmP2
HI8s3yByuOddZg7KqFh2AZd9iTwjevkVrBt8mTwn7e2kfCj1/ilUO7iwJa7NmSP8
aT11GJh5Whm7R4UTM0Ew2fWlG/SPZCA4w4CsbyBivL9GvVMJ5E3QabDL0JRfHG6x
JUfiaoHbXICDAc/MAe6D
=s9qt
-----END PGP SIGNATURE-----

--wwX5Nmi7feudBrEr--
