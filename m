Received: from eggs.gnu.org ([2001:4830:134:3::10]:43401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1delli-00041X-6D
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1delld-00029b-9S
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:24:42 -0400
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:47459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1delld-00028s-3M
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:24:37 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 5C56D8B487
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 19:24:34 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 07 Aug 2017 19:24:24 +0200
Message-ID: <150212666472.12227.5292551535430570753.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.10 PATCH 0/3] spapr: fix PCI hotplug issue when
 PHBs don't have index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

While working on PHB hotplug for 2.11, a bug was discovered in the PCI DR
logic in the PHB code: it relies on the PHB index property to be set but
it doesn't enforce it. It is hence possible to create two PHBs with the
same index (ie, the default value -1), even though this isn't expected
by the rest of the PHB code. The most visible consequence, is that PCI
hotplug doesn't work anymore.

It was agreed that the right fix would be to make the index property
mandatory. This is too an intrusive change to do during soft/hard
freeze though. It is postponed for 2.11.

In the meantime, we can at least have QEMU to detect the error early
and to exit with an error message, instead of silently going on with
half-broken PHBs.

David,

These patches were made with the future work on PHB hotplug in mind. If
the series is too long, a similar result can be achieved with this single
change in spapr_dr_connector_new():

-    object_property_set_bool(OBJECT(drc), true, "realized", NULL);
+    object_property_set_bool(OBJECT(drc), true, "realized", &error_fatal);
 
Just tell me, if you prefer the shorter version.

--
Greg

---

Greg Kurz (3):
      spapr_drc: abort if object_property_add_child() fails
      spapr_drc: add Error ** argument to spapr_dr_connector_new()
      spapr: error out if PHB fails to setup PCI DRCs


 hw/ppc/spapr.c             |    4 ++--
 hw/ppc/spapr_drc.c         |    6 +++---
 hw/ppc/spapr_pci.c         |    8 +++++++-
 include/hw/ppc/spapr_drc.h |    2 +-
 4 files changed, 13 insertions(+), 7 deletions(-)
