Received: from eggs.gnu.org ([2001:4830:134:3::10]:33798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dNHn6-0000XU-Bw
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 07:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dNHn2-0003AJ-KV
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 07:57:52 -0400
Received: from [59.151.112.132] (port=41058 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dNHn2-00039g-8B
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 07:57:48 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Tue, 20 Jun 2017 19:57:16 +0800
Message-ID: <cover.1497957189.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 0/9] Convert to realize and cleanup
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

v6:
* patch3: -rename the subject.
* patch6: -simplify the commit message.
          -use error_append_hint replace original error_setg rather
           than remove it directly. [Marcel Apfelbaum]
          -report the error message from local_err. [Marcel Apfelbaum]
v5:
* patch5: replace pci_add_capability2() with pci_add_capability(), because
          it's confusing to have a function named pci_add_capability2() if
          pci_add_capability() doesn't exist anymore. [Eduardo Habkost]
* patch8: a new patch that fix the return type of verify_irqchip_kernel().
* patch9: a new patch that use the errp directly instead of the local_err to
          propagate the error messages.

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

Mao Zhongyi (9):
  pci: Clean up error checking in pci_add_capability()
  pci: Add comment for pci_add_capability2()
  pci: Fix the wrong assertion.
  pci: Make errp the last parameter of pci_add_capability()
  pci: Replace pci_add_capability2() with pci_add_capability()
  pci: Convert to realize
  pci: Convert shpc_init() to Error
  i386/kvm/pci-assign: Fix return type of verify_irqchip_kernel()
  i386/kvm/pci-assign: Use errp directly rather than local_err

 hw/i386/amd_iommu.c                | 24 ++++++++++++-----
 hw/i386/kvm/pci-assign.c           | 54 ++++++++++++++------------------------
 hw/ide/ich.c                       |  2 +-
 hw/net/e1000e.c                    | 30 ++++++++++++---------
 hw/net/eepro100.c                  | 18 ++++++++++---
 hw/pci-bridge/i82801b11.c          | 12 ++++-----
 hw/pci-bridge/pci_bridge_dev.c     | 21 ++++++---------
 hw/pci-bridge/pcie_root_port.c     | 18 ++++++-------
 hw/pci-bridge/xio3130_downstream.c | 20 +++++++-------
 hw/pci-bridge/xio3130_upstream.c   | 20 +++++++-------
 hw/pci/msi.c                       |  2 +-
 hw/pci/msix.c                      |  2 +-
 hw/pci/pci.c                       | 24 +++--------------
 hw/pci/pci_bridge.c                |  8 ++++--
 hw/pci/pcie.c                      | 28 +++++++++++++++-----
 hw/pci/shpc.c                      | 10 ++++---
 hw/pci/slotid_cap.c                | 12 ++++++---
 hw/usb/hcd-xhci.c                  |  2 +-
 hw/vfio/pci.c                      | 15 ++++++-----
 hw/virtio/virtio-pci.c             | 12 ++++++---
 include/hw/pci/pci.h               |  2 --
 include/hw/pci/pci_bridge.h        |  3 ++-
 include/hw/pci/pcie.h              |  3 ++-
 include/hw/pci/shpc.h              |  3 ++-
 include/hw/pci/slotid_cap.h        |  3 ++-
 25 files changed, 185 insertions(+), 163 deletions(-)

-- 
2.9.3
