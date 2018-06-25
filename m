Received: from eggs.gnu.org ([2001:4830:134:3::10]:55265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXNct-0006cJ-2c
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXNco-0001PB-3W
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:17:35 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:47532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fXNcn-0001KW-TN
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:17:30 -0400
Received: from player789.ha.ovh.net (unknown [10.109.120.95])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 53B431C550
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:17:28 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 25 Jun 2018 11:17:13 +0200
Message-Id: <20180625091718.18544-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] rework the ICS classes inheritance tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

It makes the class hierarchy much cleaner and removes duplicated
code. As we are touching the location of the objects states, migration
compatibility was checked and the following tests were performed under
KVM :

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

under TCG, same scenarios were run but up to 2.10 only, in which case
the migration fails for other reasons.

I wouldn't mind some extra cross checking from someone else.

Thanks,

C.

Changes since v2:

 - split the patch in smaller units. The migration tests were not
   rerun because the code is very much the same. make check was run on
   each patch.


C=C3=A9dric Le Goater (5):
  ppc/xics: introduce a parent_realize in ICSStateClass
  ppc/xics: move the instance_init handler under the ics-base class
  ppx/xics: introduce a parent_reset in ICSStateClass
  ppc/xics: move the vmstate structures under the ics-base class
  ppc/xics: rework the ICS classes inheritance tree

 include/hw/ppc/xics.h |   4 +-
 hw/intc/xics.c        | 164 ++++++++++++++++++++++++++++----------------=
------
 hw/intc/xics_kvm.c    |  46 +++++++-------
 hw/ppc/spapr.c        |   2 +-
 4 files changed, 121 insertions(+), 95 deletions(-)

--=20
2.13.6
