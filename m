Received: from eggs.gnu.org ([2001:4830:134:3::10]:39102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dmodZ-0007pr-Ma
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dmodU-0001LJ-Jp
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:05:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dmodU-0001L3-DE
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:05:28 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 29 Aug 2017 16:05:24 -0600
Message-ID: <20170829214929.31136.21144.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/3] vfio/pci: Add NVIDIA GPUDirect P2P clique
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: a175818323@gmail.com

NVIDIA has a specification for exposing a virtual vendor capability
which provides a hint to guest drivers as to which sets of GPUs can
support direct peer-to-peer DMA.  Devices with the same clique ID are
expected to support this.  The user can specify a clique ID for an
NVIDIA graphics device using the new vfio-pci x-nv-gpudirect-clique=
option, where valid clique IDs are a 4-bit integer.  It's entirely the
user's responsibility to specify sets of devices for which P2P works
correctly and provides some benefit.  This is only useful for DMA
between NVIDIA GPUs, therefore it's only useful to specify cliques
comprised of more than one GPU.  Furthermore, this does not enable DMA
between VMs, there is no change to VM DMA mapping, this only exposes
hints about existing DMA paths to the guest driver.  Thanks,

Alex

---

Alex Williamson (3):
      vfio/pci: Do not unwind on error
      vfio/pci: Add virtual capabilities quirk infrastructure
      vfio/pci: Add NVIDIA GPUDirect Cliques support


 hw/vfio/pci-quirks.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c        |   17 +++++++
 hw/vfio/pci.h        |    4 ++
 3 files changed, 133 insertions(+), 2 deletions(-)
