Received: from eggs.gnu.org ([2001:4830:134:3::10]:50400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=655ddeee3=Paul.Durrant@citrix.com>)
	id 1fEbBj-0004wf-LR
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=655ddeee3=Paul.Durrant@citrix.com>)
	id 1fEbBf-0003Qn-Ay
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:55:55 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 4 May 2018 14:55:26 +0100
Message-ID: <1525442134-20488-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/8] xen_disk: legacy code removal and
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>, Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

The grant copy operation was added to libxengnttab in Xen 4.8.0 (released
nearly 18 months ago) but the xen_disk PV backend QEMU is still carrying
a significant amount of code purely to remain compatible with older
versions of Xen.

As can be inferred from the diff stats below, removing this support for
older versions of Xen from QEMU reduces the size of the xen_disk source by
around 320 lines (~25%).

Version 2 of this series maintains compatibility with older Xen, and OS
not supporting the grant copy operation, by adding an emulation of it
into the xen_backend code. Thus xen_disk can be simplified without
regressing support for any environment. This version also performs
general cleanup of the code by introducing and consistently using
helper functions for calling into libxenttab.

Paul Durrant (8):
  xen_backend: add grant table helpers
  xen_disk: remove open-coded use of libxengnttab
  xen: remove other open-coded use of libxengnttab
  xen_backend: add an emulation of grant copy
  xen_disk: remove use of grant map/unmap
  xen_backend: make the xen_feature_grant_copy flag private
  xen_disk: use a single entry iovec
  xen_disk: be consistent with use of xendev and blkdev->xendev

 hw/9pfs/xen-9p-backend.c     |  32 ++-
 hw/block/xen_disk.c          | 609 +++++++------------------------------------
 hw/char/xen_console.c        |   9 +-
 hw/net/xen_nic.c             |  34 ++-
 hw/usb/xen-usb.c             |  37 ++-
 hw/xen/xen_backend.c         | 178 ++++++++++++-
 include/hw/xen/xen_backend.h |  34 ++-
 7 files changed, 348 insertions(+), 585 deletions(-)
---
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

-- 
2.1.4
