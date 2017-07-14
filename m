Received: from eggs.gnu.org ([2001:4830:134:3::10]:50262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dVrrv-0002dN-Gn
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dVrrs-0005t3-Ry
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:06:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dVrrs-0005sm-IT
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:06:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6E43pF4014950
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 00:06:15 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpmjam2dy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 00:06:14 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 14 Jul 2017 14:06:12 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 14 Jul 2017 09:34:37 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170714040437.22034-1-nikunj@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] spapr: ignore decr interrupts when MSR_EE
 is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.

When reset happens, all the CPUs are in halted state. First CPU is brough=
t out
of reset and secondary CPUs would be initialized by the guest kernel usin=
g a
rtas call start-cpu.

However, in case of TCG, decrementer interrupts keep on coming and waking=
 the
secondary CPUs up.

These secondary CPUs would see the decrementer interrupt pending, which m=
akes
cpu::has_work() to bring them out of wait loop and start executing
tcg_exec_cpu().

The problem with this is all the CPUs wake up and start booting SLOF imag=
e,
causing the following exception(4 CPUs TCG VM):

[   81.440850] reboot: Restarting system

SLOF
S
SLOF
SLOFLOF[0[0m ************************************************************=
**********
QEMU Starting
 Build Date =3D Mar  3 2017 13:29:19
 FW Version =3D git-66d250ef0fd06bb8
[0m *********************************************************************=
*
QEMU Starting
 Build Date =3D Mar  3 2017 13:29:19
 FW Version =3D git-66d250ef0fd06bb8
[0m *************************************m**********[?25l ***************=
*******************************************************
QEMU Starting
 Build Date =3D Mar  3 2017 13:29:19
 FW Version =3D git-66d250ef0fd06bb8
***********************
QEMU Starting
 Build Date =3D Mar  3 2017 13:29:19
 FW Version =3D git-66d250ef0fd06bb8
ERROR: Flatten device tree not available!

 exception 300
SRR0 =3D 00000000000060e4  SRR1 =3D 800000008000000000000000
SPRG2 =3D 0000000000400000  SPRG3 =3D 0000000000004bd8
ERROR: Flatten device tree not available!

 exception 300
SRR0 =3D 00000000000060e4  SRR1 =3D 800000008000000000000000
SPRG2 =3D 0000000000400000  SPRG3 =3D 0000000000004bd8

Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate_init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 783bf98..8b98076 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8536,7 +8536,8 @@ static bool cpu_has_work_POWER7(CPUState *cs)
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
             (env->spr[SPR_LPCR] & LPCR_P7_PECE1)) {
-            return true;
+            /* Return true only when MSR_EE is enabled */
+            return msr_ee;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK)) &&
             (env->spr[SPR_LPCR] & LPCR_P7_PECE2)) {
@@ -8693,7 +8694,8 @@ static bool cpu_has_work_POWER8(CPUState *cs)
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
             (env->spr[SPR_LPCR] & LPCR_P8_PECE3)) {
-            return true;
+            /* Return true only when MSR_EE is enabled */
+            return msr_ee;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK)) &&
             (env->spr[SPR_LPCR] & LPCR_P8_PECE4)) {
@@ -8876,7 +8878,8 @@ static bool cpu_has_work_POWER9(CPUState *cs)
         /* Decrementer Exception */
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
             (env->spr[SPR_LPCR] & LPCR_DEE)) {
-            return true;
+            /* Return true only when MSR_EE is enabled */
+            return msr_ee;
         }
         /* Machine Check or Hypervisor Maintenance Exception */
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK |
--=20
2.9.3
