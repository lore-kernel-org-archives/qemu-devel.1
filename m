Received: from eggs.gnu.org ([2001:4830:134:3::10]:41212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeT-0005wc-1G
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeN-00071R-SC
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:32 -0500
Received: from [59.151.112.132] (port=14080 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeN-0006sZ-51
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:27 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Sat, 31 Dec 2016 17:13:04 +0800
Message-ID: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC v11 0/4] vfio-pci: pass non-fatal error to
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, izumi.taku@jp.fujitsu.com

As previous discussion suggest, we could take a step back to handle non-fatal
error first, this will make this patchset much more thinner, because we could
drop all the configuration restriction related patches.

FYI: patch 1 has been cherry picked into another series, and wait to be merged
first, so this patchset can't compile in your host.

v11 changelog:
1. drop a bunch of code which check the configuration.
2. modify patch 3 to handle non-fatal error only, fatal error still
   results in vm stop.
   Doesn't modify as suggestion "add another eventfd do distinguish fatal &
   non-fatal error", because 1st, user has the ability to distinguish them
   just from the uncorrectable error status; 2nd, for back compatible, e.g.
   an old user handle both error, rely on the current error eventfd.

Test:
Test it with intel 82576 NIC, which has 2 functions, function 1 has cable
connected to gateway, function 0 has no link. Test in 4 scenario.
1. just assign function 1 to one vm, function 0 has no user
2. assign 2 function to one vm, totally comply previous configuraton restrction
3. assign 2 function to one vm, under different virtual bus
4, assign functions to 2 different vm

The test steps are the same as v10: assign ip to function 1, add route info,
and ping the gateway. The results meet expectation. But the unsteady hardware
often emit fatal error, still don't know why. And igb driver in guest seems
has bug: ping gateway for a while, even if I don't do anything, it will show
"Destination Host Unreachable" after many successful ping. But obviously,
neither of these has relationship with this patchset.


Chen Fan (3):
  vfio: new function to init aer cap for vfio device
  vfio-pci: pass the aer error to guest
  vfio: add 'aer' property to expose aercap

Dou Liyang (1):
  pcie_aer: support configurable AER capa version

 hw/net/e1000e.c                    |   3 +-
 hw/pci-bridge/ioh3420.c            |   2 +-
 hw/pci-bridge/xio3130_downstream.c |   2 +-
 hw/pci-bridge/xio3130_upstream.c   |   2 +-
 hw/pci/pcie_aer.c                  |   5 +-
 hw/vfio/pci.c                      | 139 +++++++++++++++++++++++++++++++++----
 hw/vfio/pci.h                      |   3 +
 include/hw/pci/pcie_aer.h          |   3 +-
 8 files changed, 139 insertions(+), 20 deletions(-)

-- 
1.8.3.1
