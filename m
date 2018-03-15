Received: from eggs.gnu.org ([2001:4830:134:3::10]:55334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewaTM-0007O4-K9
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewaTI-0001Ul-Ll
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:31:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ewaTI-0001Tr-Fa
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:31:36 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 15 Mar 2018 15:31:27 -0600
Message-ID: <20180315212634.15150.88094.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/3] vfio/pci: ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com, eric.auger@redhat.com, aik@ozlabs.ru

A vfio ioeventfd will perform the pre-specified device write on
triggering of an eventfd.  When coupled with KVM ioeventfds, this
feature allows a VM to trap a device page for virtualization, while
also registering targeted ioeventfds to maintain performance of high
frequency register writes within the trapped range.  Much like the
existing interrupt eventfd/irqfd coupling, such writes can be handled
entirely in the host kernel.

The new VFIO device ioctl may be supported by any vfio bus driver,
including mdev drivers, but the implementation here only enables
vfio-pci.  This is intended as an acceleration path, bus drivers
may choose which regions to support and userspace should always
intend to fall back to non-accelerated handling when unavailable.

v1->v2:
 * Peter & Eric Sign-offs on 1/3
 * mutex_destroy() in 3/3
 * Slight enhancement to uapi description
 * sparse clean - Sparse didn't like that we dropped the __iomem
   address space when calling iowriteXX, re-adding it via the opaque
   and data pointers of the virq was crude, and that was not a 32-bit
   friendly soluion anyway, so add the iomem address to our ioeventfd
   struct, pass that, and use a more simple, common handler.

RFC->v1:
 * An arbitrary limit is added for the number of ioeventfds supported
   per device.  The intention is to set this high enough to allow any
   reasonable use case, but limit malicious user behavior.
 * Split patches, including adding a patch for endian neutral io reads
   and writes.  This should be a nop for little-endian and avoid
   redundant swap on big-endian, and hopefully resolves Alexey's
   comments regarding the endian nature of this interface.
 * Rebase to v4.16-rc3

Thanks,
Alex

---

Alex Williamson (3):
      vfio/pci: Pull BAR mapping setup from read-write path
      vfio/pci: Use endian neutral helpers
      vfio/pci: Add ioeventfd support


 drivers/vfio/pci/vfio_pci.c         |   35 +++++++
 drivers/vfio/pci/vfio_pci_private.h |   19 ++++
 drivers/vfio/pci/vfio_pci_rdwr.c    |  184 +++++++++++++++++++++++++++++++----
 include/uapi/linux/vfio.h           |   27 +++++
 4 files changed, 245 insertions(+), 20 deletions(-)
