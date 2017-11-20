Received: from eggs.gnu.org ([2001:4830:134:3::10]:45743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eGiw2-0000hL-PE
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eGivz-0001fR-KM
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:14 -0500
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:56676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eGivz-0001XF-Eu
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:11 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id B70F886EAB
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 11:03:59 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 20 Nov 2017 11:03:44 +0100
Message-Id: <20171120100347.8601-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v3 0/3] disable the decrementer
 interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

When a CPU is stopped with the 'stop-self' RTAS call, its state
'halted' is switched to 1 and, in this case, the MSR is not taken into
account anymore in the cpu_has_work() routine. Only the pending
hardware interrupts are checked with their LPCR:PECE* enablement bit.

If the DECR timer fires after 'stop-self' is called and before the CPU
'stop' state is reached, the nearly-dead CPU will have some work to do
and the guest will crash. This case happens very frequently with the
not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
occasionally fired but after 'stop' state, so no work is to be done
and the guest survives.

I suspect there is a race between the QEMU mainloop triggering the
timers and the TCG CPU thread but I could not quite identify the root
cause. To be safe, let's disable the decrementer interrupt in the LPCR
when the CPU is halted and reenable it when the CPU is restarted.
Reseting the MSR is now pointless, so remove this dubious workaround.

Thanks,

C.

Changes in v3:

 - removed the ppc_cpu_pvr_match() routine testing the CPU family.
 - introduced a cpu_ppc_papr_pece_bits() helper to gather the PECE
   bits depending on the CPU family.  =20
 - enabled Power-saving mode Exit Cause exceptions only on the boot CPU.
=20
Changes in v2:

 - used a new routine ppc_cpu_pvr_match() to discriminate CPU versions
 - removed the LPCR:PECE* enablement bit when the CPU is initialized
   if it is a secondary
 - included Nikunj's fix to reboot SMP TCG guests
=20
C=C3=A9dric Le Goater (3):
  spapr/rtas: disable the decrementer interrupt when a CPU is unplugged
  spapr/rtas: fix reboot of a a SMP TCG guest
  spapr/rtas: do not reset the MSR in stop-self command

 hw/ppc/spapr_cpu_core.c     |  7 +++++++
 hw/ppc/spapr_rtas.c         | 19 +++++++++----------
 target/ppc/cpu.h            |  1 +
 target/ppc/translate_init.c | 33 +++++++++++++++++++++++++--------
 4 files changed, 42 insertions(+), 18 deletions(-)

--=20
2.13.6
