Received: from eggs.gnu.org ([2001:4830:134:3::10]:48981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1aJQ-00047E-IT
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1aJK-00032q-Lw
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:49:48 -0400
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:41154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e1aJK-00030t-F9
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:49:42 -0400
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id E2A85D5D1E
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 17:49:40 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Oct 2017 17:49:26 +0200
Message-Id: <20171009154930.29095-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] disable the decrementer interrupt when
 a CPU is unplugged
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

Changes in v2:

 - used a new routine ppc_cpu_pvr_match() to discriminate CPU versions
 - removed the LPCR:PECE* enablement bit when the CPU is initialized
   if it is a secondary
 - included Nikunj's fix to reboot SMP TCG guests

C=C3=A9dric Le Goater (4):
  target/ppc: export ppc_cpu_pvr_match() helper
  spapr/rtas: disable the decrementer interrupt when a CPU is unplugged
  spapr/rtas: fix reboot of a a SMP TCG guest
  spapr/rtas: do not reset the MSR in stop-self command

 hw/ppc/spapr_cpu_core.c     | 12 ++++++++++++
 hw/ppc/spapr_rtas.c         | 28 +++++++++++++++++++---------
 include/hw/ppc/ppc.h        |  1 +
 target/ppc/machine.c        |  5 +++--
 target/ppc/translate_init.c | 19 +++++++++++++++++--
 5 files changed, 52 insertions(+), 13 deletions(-)

--=20
2.13.6
