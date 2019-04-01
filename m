Received: from eggs.gnu.org ([209.51.188.92]:34440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hB19z-0006iN-OR
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hB19r-000085-MK
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:55:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51210
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hB19p-0008Eb-Hx
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:55:41 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31Hsubj068200
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 13:55:03 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkp324pv5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 13:55:02 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 1 Apr 2019 18:55:01 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 01 Apr 2019 19:54:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155414129703.574858.5054152366329409898.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH for-4.0 0/2] spapr: Fix extended config space
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Recent commit c2077e2ca0da7 added stricter checks that now prevent
a guest to access the extended config space of a PCIe device connected
attached to a PHB on a pseries machine.

PAPR compatible PHBs act like legacy PCI busses, but they do allow access
to the full 4k config space of PCIe devices. As discussed several times on
the list ([1] and [2]), we cannot really change PAPR PHB to have a true
PCIe root bus since it would call for massive and unwanted changes in
libvirt.

This series tries to address the issue with a new PCI bus class method
that tells if the PCI bus supports extended config space accesses,
instead of relying on pci_bus_is_express() which wants a PCIe root bus.
A new legacy PCI bus type is added to implement the PAPR behaviour.

Note that this fixes a potential 4.0 regression, hence the for-4.0 tag.

[1] https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07377.html
    https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02839.html

[2] https://lists.gnu.org/archive/html/qemu-ppc/2017-01/msg00034.html

--
Greg

---

Greg Kurz (2):
      pci: Allow PCI bus subtypes to support extended config space accesses
      spapr_pci: Fix extended config space accesses


 hw/pci/pci.c             |   24 ++++++++++++++++++++++++
 hw/pci/pci_host.c        |    2 +-
 hw/ppc/spapr_pci.c       |   26 +++++++++++++++++++++++++-
 include/hw/pci/pci.h     |    2 ++
 include/hw/pci/pci_bus.h |    1 +
 5 files changed, 53 insertions(+), 2 deletions(-)
