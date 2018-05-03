Received: from eggs.gnu.org ([2001:4830:134:3::10]:37115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fELaY-0001G5-0j
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fELaU-0008JF-TS
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:16:29 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:56259)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fELaU-0008Hy-Mp
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:16:26 -0400
Received: from player691.ha.ovh.net (unknown [10.109.122.88])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 1BC57BDEF3
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 23:16:24 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 03 May 2018 23:16:10 +0200
Message-ID: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/3] spapr: fix backward migration from POWER9
 to POWER8 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

Hi,

It is expected to be able to migrate a guest started with

     -machine max-cpu-compat=power8

from a POWER9 host to a POWER8 host. It works with recent QEMU versions,
but it is badly broken if the destination runs QEMU 2.7 or older.

This can cause problems in cloud environments that still have systems with
older QEMU versions, eg, hosts running ubuntu LTS 16.04.4 (QEMU 2.5) which
are likely to stay around until admins could transition to some newer OS.

This series was lightly tested, but the patches are simple enough, so I'm
confident they shouldn't break anything :)

Please review as I'd like these to go to QEMU 2.11.2 as well.

--
Greg

---

Greg Kurz (3):
      target/ppc: always set PPC_MEM_TLBIE in pre 2.8 migration hack
      spapr: don't migrate "spapr_option_vector_ov5_cas" to pre 2.8 machines
      spapr: don't advertise radix GTSE if max-compat-cpu < power9


 hw/ppc/spapr.c       |   19 +++++++++++++------
 target/ppc/machine.c |    5 +++++
 2 files changed, 18 insertions(+), 6 deletions(-)
