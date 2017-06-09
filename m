Received: from eggs.gnu.org ([2001:4830:134:3::10]:59165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJI3j-0003dO-IT
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJI3f-0000ZK-5Y
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:26:31 -0400
Received: from [59.151.112.132] (port=44692 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJI3e-0000YA-7C
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:26:27 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 9 Jun 2017 19:24:35 +0800
Message-ID: <cover.1496994386.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/7] Convert to realize and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, armbru@redhat.com, dmitry@daynix.com, jasowang@redhat.com, kraxel@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

This series mainly implements the conversions of pci-bridge devices
i82801b11, io3130_upstream/downstream and so on to realize(). Naturally
part of error messages need to be converted to Error, then propagate
to its callers via the argument errp, bonus clean related minor flaw
up. In short, the former patches are prerequisites for latter ones.

v4:
* patch4: changed from patch 5 in v3. use a elegant way to check
          the error, like 

			 function(...);
          if (function succeeded) {
             /* non-error code path here */
             foo = bar;
          }
          
          or

			 function(...);
          if (function succeeded) {
              /* non-error code path here */
              foo = bar;
          } else {
              /* error path here */
              return ret;
          }

          for readability, instead of this:

          function(...)
          if (function failed) {
              return ...;  /* or: "goto out" */
          }

          /* non-error code path here */
          foo = bar;             [Eduardo Habkost]

          meanwhile, split previous patch4 out. [Michael S. Tsirkin]
* patch5: a new patch that replace pci_add_capability() with
          pci_add_capability2(). [Eduardo Habkost]

v3:
* patch2: explain the specified means of the return value, also
          improve the commit message. [Marcel Apfelbaum]
* patch3: simplify the subject and commit message, fix another 
          wrong assert. [Marcel Apfelbaum]
* patch4: adjust the subject.
* patch5: fix a wrong optimization for errp. [Eduardo Habkost]
* patch7: a new patch that converts shpc_init() to Error in order 
          to propagate the error better.                                                                                                                                                              
v2:
* patch1: subject and commit message was rewrited by markus.
* patch2: comment was added to pci_add_capability2().
* patch3: a new patch that fix the wrong return value judgment condition.
* patch4: a new patch that fix code style problems.
* patch5: add an errp argument for pci_add_capability to pass
          error for its callers.
* patch6: convert part of pci-bridge device to realize.

v1:
* patch1: fix unreasonable return value check

Cc: mst@redhat.com
Cc: marcel@redhat.com
Cc: armbru@redhat.com
Cc: dmitry@daynix.com
Cc: jasowang@redhat.com
Cc: kraxel@redhat.com
Cc: alex.williamson@redhat.com
Cc: pbonzini@redhat.com
Cc: rth@twiddle.net
Cc: ehabkost@redhat.com

Mao Zhongyi (7):
  pci: Clean up error checking in pci_add_capability()
  pci: Add comment for pci_add_capability2()
  pci: Fix the return value checking
  pci: Make errp the last parameter of pci_add_capability()
  pci: Replace pci_add_capability() with pci_add_capability2()
  pci: Convert to realize
  pci: Convert shpc_init() to Error

 hw/i386/amd_iommu.c                | 24 +++++++++++++++++-------
 hw/net/e1000e.c                    | 30 ++++++++++++++++++------------
 hw/net/eepro100.c                  | 20 +++++++++++++++-----
 hw/pci-bridge/i82801b11.c          | 12 ++++++------
 hw/pci-bridge/pci_bridge_dev.c     | 21 ++++++++-------------
 hw/pci-bridge/pcie_root_port.c     | 15 ++++++---------
 hw/pci-bridge/xio3130_downstream.c | 20 +++++++++-----------
 hw/pci-bridge/xio3130_upstream.c   | 20 +++++++++-----------
 hw/pci/pci.c                       | 24 ++++--------------------
 hw/pci/pci_bridge.c                |  8 ++++++--
 hw/pci/pcie.c                      | 15 +++++++++++----
 hw/pci/shpc.c                      | 12 +++++++-----
 hw/pci/slotid_cap.c                | 12 ++++++++----
 hw/usb/hcd-xhci.c                  |  2 +-
 hw/vfio/pci.c                      |  9 ++++++---
 hw/virtio/virtio-pci.c             | 12 ++++++++----
 include/hw/pci/pci.h               |  2 --
 include/hw/pci/pci_bridge.h        |  3 ++-
 include/hw/pci/pcie.h              |  3 ++-
 include/hw/pci/shpc.h              |  3 ++-
 include/hw/pci/slotid_cap.h        |  3 ++-
 21 files changed, 147 insertions(+), 123 deletions(-)

-- 
2.9.3
