Received: from eggs.gnu.org ([2001:4830:134:3::10]:34650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVaI1-0004aB-Al
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVaHx-0000Mw-ME
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:24:37 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:50597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVaHx-0000LQ-5O
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:24:33 -0400
Received: from player778.ha.ovh.net (unknown [10.109.120.117])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id D0B661A317
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 12:24:29 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 20 Jun 2018 12:24:11 +0200
Message-Id: <20180620102413.5400-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] ppc/xics: rework the ICS classes
 inheritance tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

First patch moves the common ICS code the ICS_BASE class. It makes the
class hierarchy much cleaner and removes duplicated code. Second patch
simply introduces ICP DeviceRealize and DeviceReset handler.

As we are touching the location of the objects states, migration
compatibilty needs to be checked. The following tests were performed
under KVM :

  qemu-3.0 (pseries-3.0)   -> qemu-3.0  (pseries-3.0)   OK
  qemu-3.0 (pseries-2.12)  -> qemu-2.12 (pseries-2.12)  OK
  qemu-3.0 (pseries-2.11)  -> qemu-2.11 (pseries-2.11)  OK
  qemu-3.0 (pseries-2.10)  -> qemu-2.10 (pseries-2.10)  OK
  qemu-3.0 (pseries-2.9)   -> qemu-2.9  (pseries-2.9)   OK
  qemu-3.0 (pseries-2.8)   -> qemu-2.8  (pseries-2.8)   OK
  qemu-3.0 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL

and back :

  qemu-3.0 (pseries-3.0)  <-  qemu-3.0  (pseries-3.0)   OK
  qemu-3.0 (pseries-2.12) <-  qemu-2.12 (pseries-2.12)  OK
  qemu-3.0 (pseries-2.11) <-  qemu-2.11 (pseries-2.11)  OK
  qemu-3.0 (pseries-2.10) <-  qemu-2.10 (pseries-2.10)  OK
  qemu-3.0 (pseries-2.9)  <-  qemu-2.9  (pseries-2.9)   OK
  qemu-3.0 (pseries-2.8)  <-  qemu-2.8  (pseries-2.8)   OK
  qemu-3.0 (pseries-2.7)  <-  qemu-2.7  (pseries-2.7)   OK

under TCG, same scenarios were run but up to 2.10 only, in which
case the migration fails for other reasons.

I wouldn't mind some extra cross checking from someone else.

Thanks,

C.


C=C3=A9dric Le Goater (2):
  ppc/xics: rework the ICS classes inheritance tree
  ppc/xics: introduce ICP DeviceRealize and DeviceReset handlers

 include/hw/ppc/xics.h |   9 ++-
 hw/intc/xics.c        | 176 +++++++++++++++++++++++++++-----------------=
------
 hw/intc/xics_kvm.c    |  81 ++++++++++++++---------
 hw/intc/xics_pnv.c    |  15 ++++-
 hw/ppc/spapr.c        |   2 +-
 5 files changed, 166 insertions(+), 117 deletions(-)

--=20
2.13.6
