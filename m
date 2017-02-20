Received: from eggs.gnu.org ([2001:4830:134:3::10]:38962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cfuns-0001Z5-JH
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cfunp-0008SX-HJ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cfunp-0008S7-BM
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:21 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7017B0831
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 20:43:20 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon, 20 Feb 2017 22:43:09 +0200
Message-Id: <1487623393-2492-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2 0/4] hw/virtio: fix several PCI Express
 compliance issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com

v1 -> v2:
  - Added compat properties (Michael S. Tsirkin)
  - Rebased on latest master
  - Regarding the patch 1/4, we don't need to init the PCI "standard"
    config capabilities to 0 since they are "protected" by the Capabilities List bit
   (bit 4) to indicate that the Capabilities Pointer is located at offset 34h.


Fix a few issues found while running WHQL tests:

 - Assertion 1F27399E-30B9-44BC-8908-D6E6F3836212: FAILED. Enhanced Capability Header register
   of the PCI Express Enhanced Capabilities Absent Indicator table must be read-only .

   Solved in patch 1/4

 - Assertion 47C39833-84AD-44EA-9723-0695202ADDEA: FAILED. Bit 0 (Correctable Error Reporting Enable)
   in the Device Control register (offset 8h) in the PCI Express Capability table must be read-writable .
 - Assertion 5CBA2A63-A48E-4443-85FA-A7DCD8EA47BC: FAILED. Bit 1 (Non-Fatal Error Reporting Enable)
   in the Device Control register (offset 8h) in the PCI Express Capability table must be read-writable .
 - Assertion 0AB06F7C-59CB-4F9A-8363-B51B1ACAB54F: FAILED. Bit 2 (Fatal Error Reporting Enable)
   in the Device Control register (offset 8h) in the PCI Express Capability table must be read-writable .
 - Assertion E3834E4A-A7BD-410C-9A61-FA91770D2A71: FAILED. Bit 3 (Unsupported Request Reporting Enable)
   in the Device Control register (offset 8h) in the PCI Express Capability table must be read-writable 

   Solved in patch 2/4

 - Assertion 1587DC0B-FE59-494E-85B5-C2A59D0CC098: FAILED. Bit 6 (Common Clock Configuration)
   in the Link Control register (offset 10h) in the PCI Express Capability table must be read-writable .
 - Assertion 13DD25A3-07E4-4477-BE0F-2273BBB32174: FAILED. Bit 7 (Extended Synch) in the Link Control
   register (offset 10h) in the PCI Express Capability table must be read-writable .

  Solved in patch 3/4

  - AM Assertion 06779BD9-0C35-4CA1-9EB3-96E7DA9A74F8: FAILED. Bit range 1:0 (PowerState)in
    the Power Management Control/Status register (offset 4h) in the Power Management Capability table is 0h.
    It must be 3h after a supported D3 transition. 

Thanks,
Marcel

Marcel Apfelbaum (4):
  hw/pcie: fix Extended Configuration Space for devices with no Extended
    Capabilities
  hw/virtio: fix error enabling flags in Device Control register
  hw/virtio: fix Link Control Register for PCI Express virtio devices
  hw/virtio: fix Power Management Control Register for PCI Express
    virtio devices

 hw/pci/pci.c           |  2 ++
 hw/pci/pcie.c          | 20 ++++++++++++++++++++
 hw/virtio/virtio-pci.c | 31 +++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.h | 12 ++++++++++++
 include/hw/compat.h    | 16 ++++++++++++++++
 include/hw/pci/pci.h   |  2 ++
 include/hw/pci/pcie.h  |  5 +++++
 7 files changed, 88 insertions(+)

-- 
2.5.5
