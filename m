Received: from eggs.gnu.org ([2001:4830:134:3::10]:52090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drtby-0002zx-U5
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drtbu-0005U2-IE
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:24:54 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:43275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drtbu-0005Sw-CE
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:24:50 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id EE277AA673
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 00:24:48 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 13 Sep 2017 00:24:44 +0200
Message-ID: <150525508489.11068.5231444460720976552.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/2] spapr: fix migration with nested KVM PR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

A guest running with KVM PR ends up irresponsive after migration most of the
time. This happens because the HPT allocated by QEMU is likely to have a
different address on the destination than it had on the source, but we push
the source address to KVM.

This v2 is a total rewrite.

Cheers,

--
Greg

---

Greg Kurz (2):
      spapr: introduce common helper to write HPT address to KVM PR
      spapr: preserve SDR1 during migration


 hw/ppc/spapr.c          |   61 +++++++++++++++++++++++++++++++++++++++++++----
 hw/ppc/spapr_cpu_core.c |   15 ------------
 hw/ppc/spapr_hcall.c    |   16 +-----------
 include/hw/ppc/spapr.h  |    1 +
 target/ppc/cpu.h        |    5 ++++
 target/ppc/machine.c    |   18 ++++++++++++++
 6 files changed, 81 insertions(+), 35 deletions(-)
