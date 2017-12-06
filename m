Received: from eggs.gnu.org ([2001:4830:134:3::10]:47036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eMWDR-00059y-VH
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eMWDN-00013t-24
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:42:09 -0500
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:49800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eMWDM-00013E-OY
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:42:04 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3F1A3126C31
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 10:42:03 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Dec 2017 10:41:50 +0100
Message-Id: <20171206094150.11231-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] target/ppc: introduce the PPC_BIT() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

and use them in a couple of obvious places. Other macros will be used
in the model of the XIVE interrupt controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h | 105 +++++++++++++++++++++++++++++--------------------=
------
 1 file changed, 56 insertions(+), 49 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 989761b79569..370b05e76ede 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -87,6 +87,13 @@
 #define PPC_ELF_MACHINE     EM_PPC
 #endif
=20
+#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
+#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
+#define PPC_BIT8(bit)           (0x80UL >> (bit))
+#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
+#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
+                                 PPC_BIT32(bs))
+
 /***********************************************************************=
******/
 /* Exception vectors definitions                                        =
     */
 enum {
@@ -371,10 +378,10 @@ struct ppc_slb_t {
 #define MSR_LE   0  /* Little-endian mode                           1 hf=
lags */
=20
 /* LPCR bits */
-#define LPCR_VPM0         (1ull << (63 - 0))
-#define LPCR_VPM1         (1ull << (63 - 1))
-#define LPCR_ISL          (1ull << (63 - 2))
-#define LPCR_KBV          (1ull << (63 - 3))
+#define LPCR_VPM0         PPC_BIT(0)
+#define LPCR_VPM1         PPC_BIT(1)
+#define LPCR_ISL          PPC_BIT(2)
+#define LPCR_KBV          PPC_BIT(3)
 #define LPCR_DPFD_SHIFT   (63 - 11)
 #define LPCR_DPFD         (0x7ull << LPCR_DPFD_SHIFT)
 #define LPCR_VRMASD_SHIFT (63 - 16)
@@ -382,41 +389,41 @@ struct ppc_slb_t {
 /* P9: Power-saving mode Exit Cause Enable (Upper Section) Mask */
 #define LPCR_PECE_U_SHIFT (63 - 19)
 #define LPCR_PECE_U_MASK  (0x7ull << LPCR_PECE_U_SHIFT)
-#define LPCR_HVEE         (1ull << (63 - 17)) /* Hypervisor Virt Exit En=
able */
+#define LPCR_HVEE         PPC_BIT(17) /* Hypervisor Virt Exit Enable */
 #define LPCR_RMLS_SHIFT   (63 - 37)
 #define LPCR_RMLS         (0xfull << LPCR_RMLS_SHIFT)
-#define LPCR_ILE          (1ull << (63 - 38))
+#define LPCR_ILE          PPC_BIT(38)
 #define LPCR_AIL_SHIFT    (63 - 40)      /* Alternate interrupt location=
 */
 #define LPCR_AIL          (3ull << LPCR_AIL_SHIFT)
-#define LPCR_UPRT         (1ull << (63 - 41)) /* Use Process Table */
-#define LPCR_EVIRT        (1ull << (63 - 42)) /* Enhanced Virtualisation=
 */
-#define LPCR_ONL          (1ull << (63 - 45))
-#define LPCR_LD           (1ull << (63 - 46)) /* Large Decrementer */
-#define LPCR_P7_PECE0     (1ull << (63 - 49))
-#define LPCR_P7_PECE1     (1ull << (63 - 50))
-#define LPCR_P7_PECE2     (1ull << (63 - 51))
-#define LPCR_P8_PECE0     (1ull << (63 - 47))
-#define LPCR_P8_PECE1     (1ull << (63 - 48))
-#define LPCR_P8_PECE2     (1ull << (63 - 49))
-#define LPCR_P8_PECE3     (1ull << (63 - 50))
-#define LPCR_P8_PECE4     (1ull << (63 - 51))
+#define LPCR_UPRT         PPC_BIT(41) /* Use Process Table */
+#define LPCR_EVIRT        PPC_BIT(42) /* Enhanced Virtualisation */
+#define LPCR_ONL          PPC_BIT(45)
+#define LPCR_LD           PPC_BIT(46) /* Large Decrementer */
+#define LPCR_P7_PECE0     PPC_BIT(49)
+#define LPCR_P7_PECE1     PPC_BIT(50)
+#define LPCR_P7_PECE2     PPC_BIT(51)
+#define LPCR_P8_PECE0     PPC_BIT(47)
+#define LPCR_P8_PECE1     PPC_BIT(48)
+#define LPCR_P8_PECE2     PPC_BIT(49)
+#define LPCR_P8_PECE3     PPC_BIT(50)
+#define LPCR_P8_PECE4     PPC_BIT(51)
 /* P9: Power-saving mode Exit Cause Enable (Lower Section) Mask */
 #define LPCR_PECE_L_SHIFT (63 - 51)
 #define LPCR_PECE_L_MASK  (0x1full << LPCR_PECE_L_SHIFT)
-#define LPCR_PDEE         (1ull << (63 - 47)) /* Privileged Doorbell Exi=
t EN */
-#define LPCR_HDEE         (1ull << (63 - 48)) /* Hyperv Doorbell Exit En=
able */
-#define LPCR_EEE          (1ull << (63 - 49)) /* External Exit Enable   =
     */
-#define LPCR_DEE          (1ull << (63 - 50)) /* Decrementer Exit Enable=
     */
-#define LPCR_OEE          (1ull << (63 - 51)) /* Other Exit Enable      =
     */
-#define LPCR_MER          (1ull << (63 - 52))
-#define LPCR_GTSE         (1ull << (63 - 53)) /* Guest Translation Shoot=
down */
-#define LPCR_TC           (1ull << (63 - 54))
-#define LPCR_HEIC         (1ull << (63 - 59)) /* HV Extern Interrupt Con=
trol */
-#define LPCR_LPES0        (1ull << (63 - 60))
-#define LPCR_LPES1        (1ull << (63 - 61))
-#define LPCR_RMI          (1ull << (63 - 62))
-#define LPCR_HVICE        (1ull << (63 - 62)) /* HV Virtualisation Int E=
nable */
-#define LPCR_HDICE        (1ull << (63 - 63))
+#define LPCR_PDEE         PPC_BIT(47) /* Privileged Doorbell Exit EN */
+#define LPCR_HDEE         PPC_BIT(48) /* Hyperv Doorbell Exit Enable */
+#define LPCR_EEE          PPC_BIT(49) /* External Exit Enable        */
+#define LPCR_DEE          PPC_BIT(50) /* Decrementer Exit Enable     */
+#define LPCR_OEE          PPC_BIT(51) /* Other Exit Enable           */
+#define LPCR_MER          PPC_BIT(52)
+#define LPCR_GTSE         PPC_BIT(53) /* Guest Translation Shootdown */
+#define LPCR_TC           PPC_BIT(54)
+#define LPCR_HEIC         PPC_BIT(59) /* HV Extern Interrupt Control */
+#define LPCR_LPES0        PPC_BIT(60)
+#define LPCR_LPES1        PPC_BIT(61)
+#define LPCR_RMI          PPC_BIT(62)
+#define LPCR_HVICE        PPC_BIT(62) /* HV Virtualisation Int Enable */
+#define LPCR_HDICE        PPC_BIT(63)
=20
 #define msr_sf   ((env->msr >> MSR_SF)   & 1)
 #define msr_isf  ((env->msr >> MSR_ISF)  & 1)
@@ -507,22 +514,22 @@ struct ppc_slb_t {
 #define FSCR_IC_TAR         8
=20
 /* Exception state register bits definition                             =
     */
-#define ESR_PIL   (1 << (63 - 36)) /* Illegal Instruction               =
     */
-#define ESR_PPR   (1 << (63 - 37)) /* Privileged Instruction            =
     */
-#define ESR_PTR   (1 << (63 - 38)) /* Trap                              =
     */
-#define ESR_FP    (1 << (63 - 39)) /* Floating-Point Operation          =
     */
-#define ESR_ST    (1 << (63 - 40)) /* Store Operation                   =
     */
-#define ESR_AP    (1 << (63 - 44)) /* Auxiliary Processor Operation     =
     */
-#define ESR_PUO   (1 << (63 - 45)) /* Unimplemented Operation           =
     */
-#define ESR_BO    (1 << (63 - 46)) /* Byte Ordering                     =
     */
-#define ESR_PIE   (1 << (63 - 47)) /* Imprecise exception               =
     */
-#define ESR_DATA  (1 << (63 - 53)) /* Data Access (Embedded page table) =
     */
-#define ESR_TLBI  (1 << (63 - 54)) /* TLB Ineligible (Embedded page tabl=
e)   */
-#define ESR_PT    (1 << (63 - 55)) /* Page Table (Embedded page table)  =
     */
-#define ESR_SPV   (1 << (63 - 56)) /* SPE/VMX operation                 =
     */
-#define ESR_EPID  (1 << (63 - 57)) /* External Process ID operation     =
     */
-#define ESR_VLEMI (1 << (63 - 58)) /* VLE operation                     =
     */
-#define ESR_MIF   (1 << (63 - 62)) /* Misaligned instruction (VLE)      =
     */
+#define ESR_PIL   PPC_BIT(36) /* Illegal Instruction                    =
*/
+#define ESR_PPR   PPC_BIT(37) /* Privileged Instruction                 =
*/
+#define ESR_PTR   PPC_BIT(38) /* Trap                                   =
*/
+#define ESR_FP    PPC_BIT(39) /* Floating-Point Operation               =
*/
+#define ESR_ST    PPC_BIT(40) /* Store Operation                        =
*/
+#define ESR_AP    PPC_BIT(44) /* Auxiliary Processor Operation          =
*/
+#define ESR_PUO   PPC_BIT(45) /* Unimplemented Operation                =
*/
+#define ESR_BO    PPC_BIT(46) /* Byte Ordering                          =
*/
+#define ESR_PIE   PPC_BIT(47) /* Imprecise exception                    =
*/
+#define ESR_DATA  PPC_BIT(53) /* Data Access (Embedded page table)      =
*/
+#define ESR_TLBI  PPC_BIT(54) /* TLB Ineligible (Embedded page table)   =
*/
+#define ESR_PT    PPC_BIT(55) /* Page Table (Embedded page table)       =
*/
+#define ESR_SPV   PPC_BIT(56) /* SPE/VMX operation                      =
*/
+#define ESR_EPID  PPC_BIT(57) /* External Process ID operation          =
*/
+#define ESR_VLEMI PPC_BIT(58) /* VLE operation                          =
*/
+#define ESR_MIF   PPC_BIT(62) /* Misaligned instruction (VLE)           =
*/
=20
 /* Transaction EXception And Summary Register bits                      =
     */
 #define TEXASR_FAILURE_PERSISTENT                (63 - 7)
@@ -1991,7 +1998,7 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
 #define HID0_DEEPNAP        (1 << 24)           /* pre-2.06 */
 #define HID0_DOZE           (1 << 23)           /* pre-2.06 */
 #define HID0_NAP            (1 << 22)           /* pre-2.06 */
-#define HID0_HILE           (1ull << (63 - 19)) /* POWER8 */
+#define HID0_HILE           PPC_BIT(19) /* POWER8 */
=20
 /***********************************************************************=
******/
 /* PowerPC Instructions types definitions                               =
     */
--=20
2.13.6
