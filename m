Received: from eggs.gnu.org ([2001:4830:134:3::10]:34020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e09Lz-0008Eb-Ir
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e09Lu-0003El-PC
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:50:31 -0400
Received: from 4.mo7.mail-out.ovh.net ([178.32.122.254]:50311)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e09Lu-00036M-I4
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:50:26 -0400
Received: from player697.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 6EFB0752B6
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 18:50:17 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  5 Oct 2017 18:49:57 +0200
Message-Id: <20171005164959.26024-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] disable the decrementer interrupt when a
 CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>
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

C=C3=A9dric Le Goater (2):
  spapr/rtas: disable the decrementer interrupt when a CPU is unplugged
  spapr/rtas: do not reset the MSR in stop-self command

 hw/ppc/spapr_rtas.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--=20
2.13.6
