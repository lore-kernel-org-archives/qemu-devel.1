Received: from eggs.gnu.org ([2001:4830:134:3::10]:60426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkHMI-0000ty-2u
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkHME-0006L7-Uo
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:13:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fkHME-0006Ks-Na
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:13:42 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 30 Jul 2018 17:13:26 -0600
Message-ID: <153299204130.14411.11438396195753743913.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/4] Balloon inhibit enhancements,
 vfio restriction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, peterx@redhat.com, cohuck@redhat.com, mst@redhat.com, david@redhat.com

v2:
 - Use atomic ops for balloon inhibit counter (Peter)
 - Allow endpoint driver opt-in for ballooning, vfio-ccw opt-in by
   default, vfio-pci opt-in by device option, only allowed for mdev
   devices, no support added for platform as there are no platform
   mdev devices.

See patch 3/4 for detailed explanation why ballooning and device
assignment typically don't mix.  If this eventually changes, flags
on the iommu info struct or perhaps device info struct can inform
us for automatic opt-in.  Thanks,

Alex

---

Alex Williamson (4):
      balloon: Allow nested inhibits
      kvm: Use inhibit to prevent ballooning without synchronous mmu
      vfio: Inhibit ballooning based on group attachment to a container
      vfio/ccw/pci: Allow devices to opt-in for ballooning


 accel/kvm/kvm-all.c           |    4 ++++
 balloon.c                     |   13 ++++++++++---
 hw/vfio/ccw.c                 |    9 +++++++++
 hw/vfio/common.c              |   26 ++++++++++++++++++++++++++
 hw/vfio/pci.c                 |   26 +++++++++++++++++++++++++-
 hw/vfio/trace-events          |    1 +
 hw/virtio/virtio-balloon.c    |    4 +---
 include/hw/vfio/vfio-common.h |    2 ++
 8 files changed, 78 insertions(+), 7 deletions(-)
