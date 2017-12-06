Received: from eggs.gnu.org ([2001:4830:134:3::10]:55616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMWXF-0000A7-V8
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMWXB-0004dm-GA
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:02:38 -0500
Date: Wed, 6 Dec 2017 20:49:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171206094908.GY3057@umbus.fritz.box>
References: <20171206094150.11231-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B7FF+pnjRCrp0ISR"
Content-Disposition: inline
In-Reply-To: <20171206094150.11231-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: introduce the PPC_BIT() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--B7FF+pnjRCrp0ISR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 10:41:50AM +0100, C=E9dric Le Goater wrote:
> and use them in a couple of obvious places. Other macros will be used
> in the model of the XIVE interrupt controller.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.12.

> ---
>  target/ppc/cpu.h | 105 +++++++++++++++++++++++++++++--------------------=
------
>  1 file changed, 56 insertions(+), 49 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 989761b79569..370b05e76ede 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -87,6 +87,13 @@
>  #define PPC_ELF_MACHINE     EM_PPC
>  #endif
> =20
> +#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
> +#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
> +#define PPC_BIT8(bit)           (0x80UL >> (bit))
> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
> +#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
> +                                 PPC_BIT32(bs))
> +
>  /***********************************************************************=
******/
>  /* Exception vectors definitions                                        =
     */
>  enum {
> @@ -371,10 +378,10 @@ struct ppc_slb_t {
>  #define MSR_LE   0  /* Little-endian mode                           1 hf=
lags */
> =20
>  /* LPCR bits */
> -#define LPCR_VPM0         (1ull << (63 - 0))
> -#define LPCR_VPM1         (1ull << (63 - 1))
> -#define LPCR_ISL          (1ull << (63 - 2))
> -#define LPCR_KBV          (1ull << (63 - 3))
> +#define LPCR_VPM0         PPC_BIT(0)
> +#define LPCR_VPM1         PPC_BIT(1)
> +#define LPCR_ISL          PPC_BIT(2)
> +#define LPCR_KBV          PPC_BIT(3)
>  #define LPCR_DPFD_SHIFT   (63 - 11)
>  #define LPCR_DPFD         (0x7ull << LPCR_DPFD_SHIFT)
>  #define LPCR_VRMASD_SHIFT (63 - 16)
> @@ -382,41 +389,41 @@ struct ppc_slb_t {
>  /* P9: Power-saving mode Exit Cause Enable (Upper Section) Mask */
>  #define LPCR_PECE_U_SHIFT (63 - 19)
>  #define LPCR_PECE_U_MASK  (0x7ull << LPCR_PECE_U_SHIFT)
> -#define LPCR_HVEE         (1ull << (63 - 17)) /* Hypervisor Virt Exit En=
able */
> +#define LPCR_HVEE         PPC_BIT(17) /* Hypervisor Virt Exit Enable */
>  #define LPCR_RMLS_SHIFT   (63 - 37)
>  #define LPCR_RMLS         (0xfull << LPCR_RMLS_SHIFT)
> -#define LPCR_ILE          (1ull << (63 - 38))
> +#define LPCR_ILE          PPC_BIT(38)
>  #define LPCR_AIL_SHIFT    (63 - 40)      /* Alternate interrupt location=
 */
>  #define LPCR_AIL          (3ull << LPCR_AIL_SHIFT)
> -#define LPCR_UPRT         (1ull << (63 - 41)) /* Use Process Table */
> -#define LPCR_EVIRT        (1ull << (63 - 42)) /* Enhanced Virtualisation=
 */
> -#define LPCR_ONL          (1ull << (63 - 45))
> -#define LPCR_LD           (1ull << (63 - 46)) /* Large Decrementer */
> -#define LPCR_P7_PECE0     (1ull << (63 - 49))
> -#define LPCR_P7_PECE1     (1ull << (63 - 50))
> -#define LPCR_P7_PECE2     (1ull << (63 - 51))
> -#define LPCR_P8_PECE0     (1ull << (63 - 47))
> -#define LPCR_P8_PECE1     (1ull << (63 - 48))
> -#define LPCR_P8_PECE2     (1ull << (63 - 49))
> -#define LPCR_P8_PECE3     (1ull << (63 - 50))
> -#define LPCR_P8_PECE4     (1ull << (63 - 51))
> +#define LPCR_UPRT         PPC_BIT(41) /* Use Process Table */
> +#define LPCR_EVIRT        PPC_BIT(42) /* Enhanced Virtualisation */
> +#define LPCR_ONL          PPC_BIT(45)
> +#define LPCR_LD           PPC_BIT(46) /* Large Decrementer */
> +#define LPCR_P7_PECE0     PPC_BIT(49)
> +#define LPCR_P7_PECE1     PPC_BIT(50)
> +#define LPCR_P7_PECE2     PPC_BIT(51)
> +#define LPCR_P8_PECE0     PPC_BIT(47)
> +#define LPCR_P8_PECE1     PPC_BIT(48)
> +#define LPCR_P8_PECE2     PPC_BIT(49)
> +#define LPCR_P8_PECE3     PPC_BIT(50)
> +#define LPCR_P8_PECE4     PPC_BIT(51)
>  /* P9: Power-saving mode Exit Cause Enable (Lower Section) Mask */
>  #define LPCR_PECE_L_SHIFT (63 - 51)
>  #define LPCR_PECE_L_MASK  (0x1full << LPCR_PECE_L_SHIFT)
> -#define LPCR_PDEE         (1ull << (63 - 47)) /* Privileged Doorbell Exi=
t EN */
> -#define LPCR_HDEE         (1ull << (63 - 48)) /* Hyperv Doorbell Exit En=
able */
> -#define LPCR_EEE          (1ull << (63 - 49)) /* External Exit Enable   =
     */
> -#define LPCR_DEE          (1ull << (63 - 50)) /* Decrementer Exit Enable=
     */
> -#define LPCR_OEE          (1ull << (63 - 51)) /* Other Exit Enable      =
     */
> -#define LPCR_MER          (1ull << (63 - 52))
> -#define LPCR_GTSE         (1ull << (63 - 53)) /* Guest Translation Shoot=
down */
> -#define LPCR_TC           (1ull << (63 - 54))
> -#define LPCR_HEIC         (1ull << (63 - 59)) /* HV Extern Interrupt Con=
trol */
> -#define LPCR_LPES0        (1ull << (63 - 60))
> -#define LPCR_LPES1        (1ull << (63 - 61))
> -#define LPCR_RMI          (1ull << (63 - 62))
> -#define LPCR_HVICE        (1ull << (63 - 62)) /* HV Virtualisation Int E=
nable */
> -#define LPCR_HDICE        (1ull << (63 - 63))
> +#define LPCR_PDEE         PPC_BIT(47) /* Privileged Doorbell Exit EN */
> +#define LPCR_HDEE         PPC_BIT(48) /* Hyperv Doorbell Exit Enable */
> +#define LPCR_EEE          PPC_BIT(49) /* External Exit Enable        */
> +#define LPCR_DEE          PPC_BIT(50) /* Decrementer Exit Enable     */
> +#define LPCR_OEE          PPC_BIT(51) /* Other Exit Enable           */
> +#define LPCR_MER          PPC_BIT(52)
> +#define LPCR_GTSE         PPC_BIT(53) /* Guest Translation Shootdown */
> +#define LPCR_TC           PPC_BIT(54)
> +#define LPCR_HEIC         PPC_BIT(59) /* HV Extern Interrupt Control */
> +#define LPCR_LPES0        PPC_BIT(60)
> +#define LPCR_LPES1        PPC_BIT(61)
> +#define LPCR_RMI          PPC_BIT(62)
> +#define LPCR_HVICE        PPC_BIT(62) /* HV Virtualisation Int Enable */
> +#define LPCR_HDICE        PPC_BIT(63)
> =20
>  #define msr_sf   ((env->msr >> MSR_SF)   & 1)
>  #define msr_isf  ((env->msr >> MSR_ISF)  & 1)
> @@ -507,22 +514,22 @@ struct ppc_slb_t {
>  #define FSCR_IC_TAR         8
> =20
>  /* Exception state register bits definition                             =
     */
> -#define ESR_PIL   (1 << (63 - 36)) /* Illegal Instruction               =
     */
> -#define ESR_PPR   (1 << (63 - 37)) /* Privileged Instruction            =
     */
> -#define ESR_PTR   (1 << (63 - 38)) /* Trap                              =
     */
> -#define ESR_FP    (1 << (63 - 39)) /* Floating-Point Operation          =
     */
> -#define ESR_ST    (1 << (63 - 40)) /* Store Operation                   =
     */
> -#define ESR_AP    (1 << (63 - 44)) /* Auxiliary Processor Operation     =
     */
> -#define ESR_PUO   (1 << (63 - 45)) /* Unimplemented Operation           =
     */
> -#define ESR_BO    (1 << (63 - 46)) /* Byte Ordering                     =
     */
> -#define ESR_PIE   (1 << (63 - 47)) /* Imprecise exception               =
     */
> -#define ESR_DATA  (1 << (63 - 53)) /* Data Access (Embedded page table) =
     */
> -#define ESR_TLBI  (1 << (63 - 54)) /* TLB Ineligible (Embedded page tabl=
e)   */
> -#define ESR_PT    (1 << (63 - 55)) /* Page Table (Embedded page table)  =
     */
> -#define ESR_SPV   (1 << (63 - 56)) /* SPE/VMX operation                 =
     */
> -#define ESR_EPID  (1 << (63 - 57)) /* External Process ID operation     =
     */
> -#define ESR_VLEMI (1 << (63 - 58)) /* VLE operation                     =
     */
> -#define ESR_MIF   (1 << (63 - 62)) /* Misaligned instruction (VLE)      =
     */
> +#define ESR_PIL   PPC_BIT(36) /* Illegal Instruction                    =
*/
> +#define ESR_PPR   PPC_BIT(37) /* Privileged Instruction                 =
*/
> +#define ESR_PTR   PPC_BIT(38) /* Trap                                   =
*/
> +#define ESR_FP    PPC_BIT(39) /* Floating-Point Operation               =
*/
> +#define ESR_ST    PPC_BIT(40) /* Store Operation                        =
*/
> +#define ESR_AP    PPC_BIT(44) /* Auxiliary Processor Operation          =
*/
> +#define ESR_PUO   PPC_BIT(45) /* Unimplemented Operation                =
*/
> +#define ESR_BO    PPC_BIT(46) /* Byte Ordering                          =
*/
> +#define ESR_PIE   PPC_BIT(47) /* Imprecise exception                    =
*/
> +#define ESR_DATA  PPC_BIT(53) /* Data Access (Embedded page table)      =
*/
> +#define ESR_TLBI  PPC_BIT(54) /* TLB Ineligible (Embedded page table)   =
*/
> +#define ESR_PT    PPC_BIT(55) /* Page Table (Embedded page table)       =
*/
> +#define ESR_SPV   PPC_BIT(56) /* SPE/VMX operation                      =
*/
> +#define ESR_EPID  PPC_BIT(57) /* External Process ID operation          =
*/
> +#define ESR_VLEMI PPC_BIT(58) /* VLE operation                          =
*/
> +#define ESR_MIF   PPC_BIT(62) /* Misaligned instruction (VLE)           =
*/
> =20
>  /* Transaction EXception And Summary Register bits                      =
     */
>  #define TEXASR_FAILURE_PERSISTENT                (63 - 7)
> @@ -1991,7 +1998,7 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
>  #define HID0_DEEPNAP        (1 << 24)           /* pre-2.06 */
>  #define HID0_DOZE           (1 << 23)           /* pre-2.06 */
>  #define HID0_NAP            (1 << 22)           /* pre-2.06 */
> -#define HID0_HILE           (1ull << (63 - 19)) /* POWER8 */
> +#define HID0_HILE           PPC_BIT(19) /* POWER8 */
> =20
>  /***********************************************************************=
******/
>  /* PowerPC Instructions types definitions                               =
     */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B7FF+pnjRCrp0ISR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlonvRQACgkQbDjKyiDZ
s5LgYBAAr8iUp/eajE6VNRerQXMIlRFSLLzO9wGprlWZOqyWVGozygDVNUB1oDrw
Vehv7tPJUGXE8sV/gGPMEhkQa6ma1nQ5KHOLbLK8QOiqd1ISgBDcCK0dy3pAyy+j
EfRF9Vvol8zeXv9TUbbcmyJ9Q2lRK87lDoNRus4Kbv15Uu4JTEpmthqqsYLnOpeE
+0G3l2XZZgVL4RZyAZ5tSWomEbCjyKfTZcpahWOJTGG0fFwUgm/7QhWy7WCwS5uK
vNfYC6qi5DCj3jAmDMcu+vmvEiR29KoISAwcHBaoE7e9Fc7k1yePgbFb9g0CDxKT
Dr5EDeBRqqk0uwdAdylBetb2kPg8p/iXWW+dgJe65vJHtH0GLkHmo+VmZmJjYHbV
+e+R2Z9aJmskk2x3FgRU7ArIUsChr/2c0mDY995DM/LQK8krJ2U8ov1KsH/l2ufG
gd8Duu6qf3ahy31Wp33kStizMU+f8SvOCjb+BTfkiAWkDZE8IR80ABFdzs0woEg1
QcjM4X48TRqP6JDoUjh2aFNX20ZJ3eTuy3dMI5QIagxXIW7v6jpaMBHiWvGjNdu3
l9nekgOPYWoecQ0FRikRCiVYjTmVTmPu3suQRXdrrvlWFEv/VEDC16aVDwxqOSEC
QbKlPaWaBxQ/Avfx8r7JD+BdcfDCIlX1F8gO+1id/FRjwy7kl80=
=2PVD
-----END PGP SIGNATURE-----

--B7FF+pnjRCrp0ISR--
