Received: from eggs.gnu.org ([2001:4830:134:3::10]:51990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePQXs-0001D0-V4
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePQXo-0004LJ-Vv
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:59091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ePQXo-0004HD-Op
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:12 -0500
From: Hannes Reinecke <hare@suse.de>
Date: Thu, 14 Dec 2017 11:14:31 +0100
Message-Id: <20171214101435.26265-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 0/4] virtio-vfc implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>

Hi all,

here's my attempt to implement a 'Virtual FC' emulation for virtio-scsi,
based on the presentation at the KVM Forum in Prague.

This doesn't so much implement the FC protocol per se, but rather enables
virtio to pass in addition port information so that the guest can setup
the FC infrastructure in sysfs.

This patchset has a complementary patchset for the linux virtio-scsi driver
which will be posted to the linux-scsi mailing list.

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  scsi: use 64-bit LUN
  virtio-scsi: implement target rescan
  virtio-scsi: Implement 'native LUN' feature
  scsi: support REPORT_LUNS for LUNs != 0

 hw/scsi/esp.c                                |   6 +-
 hw/scsi/lsi53c895a.c                         |   7 +-
 hw/scsi/megasas.c                            |  24 +++--
 hw/scsi/mptsas.c                             |  10 +-
 hw/scsi/scsi-bus.c                           | 149 ++++++++++++++++++---------
 hw/scsi/scsi-disk.c                          |  22 +++-
 hw/scsi/scsi-generic.c                       |   2 +-
 hw/scsi/spapr_vscsi.c                        |  17 +--
 hw/scsi/virtio-scsi.c                        |  90 ++++++++++++++--
 hw/scsi/vmw_pvscsi.c                         |  22 ++--
 hw/usb/dev-storage.c                         |  11 +-
 hw/usb/dev-uas.c                             |  27 ++---
 include/hw/scsi/scsi.h                       |  62 +++++++++--
 include/hw/virtio/virtio-scsi.h              |   7 +-
 include/scsi/constants.h                     |  11 ++
 include/standard-headers/linux/virtio_scsi.h |  16 +++
 16 files changed, 343 insertions(+), 140 deletions(-)

-- 
2.12.3
