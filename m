Received: from eggs.gnu.org ([2001:4830:134:3::10]:52342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTGkd-0000II-2V
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTGkZ-0000zI-W9
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:47 -0500
Date: Tue, 17 Jan 2017 08:40:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170116214030.GG15853@umbus>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-6-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-6-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 05/17] target/ppc/POWER9: Adapt LPCR
 handling for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:11PM +1100, Suraj Jitindar Singh wrote:
> The logical partitioning control register controls a threads operation
> based on the partition it is currently executing. Add new definitions and
> update the mask used when writing to the LPCR based on the POWER9 spec.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  target/ppc/cpu.h            | 20 +++++++++++++++++++-
>  target/ppc/mmu-hash64.c     |  8 ++++++++
>  target/ppc/translate_init.c | 24 ++++++++++++++++++------
>  3 files changed, 45 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index afb7ddb..0ab49b3 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -379,15 +379,22 @@ struct ppc_slb_t {
>  #define LPCR_ISL          (1ull << (63 - 2))
>  #define LPCR_KBV          (1ull << (63 - 3))
>  #define LPCR_DPFD_SHIFT   (63 - 11)
> -#define LPCR_DPFD         (0x3ull << LPCR_DPFD_SHIFT)
> +#define LPCR_DPFD         (0x7ull << LPCR_DPFD_SHIFT)

Changing this define effectively changes the valid LPCR mask for
existing POWER8 and POWER7 models, which is not what you want, I think.

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
> @@ -396,11 +403,22 @@ struct ppc_slb_t {
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
> index fdb7a78..3a2acb8 100644
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
> index 2402eef..a1994d3 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8887,12 +8887,24 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu)
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

I'm not sure of mmu_model is conceptually the right thing to switch
on, although I guess it will work in practice.

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

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYfT3OAAoJEGw4ysog2bOS8R0P/ij+QcOcFaNasQpHpOfmUlnq
R5XCB9cKT8OYd7lfgQ++fkdmV44te9urJRQ1/8vjvghPd+GzvP5043oRacQyM41b
aSL1ntCiDYUK23vh31II77S1PH174cU9/CvUTNDTDELaDF5roZs5zEp1qqryS9pP
ctqQBnIXJIAkg1iCHNhYoJXRkJTK5rNkZOcbeWj3fmC1AuYwpP55f4C7UFnmEkYQ
+awxn5dj9DrUD5S1QGSP7px8fQQbNWP9lPmyfjpU6B9jBE31uB5/n/y+ByhGXf+n
321KUiyrPPdmPt5oqmSncTgpWCt6xvTcrb/1A5YYpKTZrLvgsVahn7yJ0OhS1/d8
fwhza29BgIs1erVtQQdN4wjtVCa7iuHme+hhYuPtCizjGCUB2Avi/idoUmwDRhVp
3gVg2HLdwMC3FuIRa/3X8PIkoIJvSKQFVx7IenG56Fq8YLjwbMWR2i9ddmABY1s2
DgqcD/WNghlGQtZDlRsrtKSK1JhPOvXEcIMwKvkIiYkynNmBKIDAW1kgrcY+3/BA
mRDjZ0Y3JX3lDAVDc4+W26mJWJXvyE5y+RIDueJdtQ1UnKFd8AEjPAZE9d0Bfjaj
4+avk7lOT6u/X12Z1e0VgzShE1Jh9u/z5pZCplYHq/X05ouv9ZV+yYbMyib98/zQ
uGQthufunPDEvhgu2ti0
=e/ty
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--
