Received: from eggs.gnu.org ([2001:4830:134:3::10]:51276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1chXa2-0001VZ-0L
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 03:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1chXa0-0008U5-St
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 03:19:50 -0500
Received: from [59.151.112.132] (port=44237 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1chXa0-0008OA-Gq
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 03:19:48 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Sat, 25 Feb 2017 16:26:34 +0800
Message-ID: <1488011202-32121-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v10 0/8] the reset of msix_init series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

v10 changelog:
1. drop the unliked patch, introduce a new patch 1 according to mst's comments.
2. base on the new patch, remove the following statements

        /* Any error other than -ENOTSUP(board's MSI support is broken)
         * is a programming error */
        assert(!ret || ret == -ENOTSUP);

   for the affected device: megasas, hcd-xhci. This is trivial changes,
   so I left the R-bs where it was.

Test:
1. Detailed test via command line as v9
2. make check hangs at: GTESTER check-qtest-x86_64. After ctrl-C, it says:

    make: *** [check-qtest-x86_64] Interrupt
    qemu-system-x86_64: Failed to read msg header. Read -1 instead of 12. Original request 11.
    qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Input/output error (5)
    qemu-system-x86_64: Failed to set msg fds.
    qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Invalid argument (22)

    qemu-system-x86_64: Failed to set msg fds.
    qemu-system-x86_64: vhost VQ 1 ring restore failed: -1: Invalid argument (22)

   Is it a regresstion or I missed something?

CC: Jason Wang <jasowang@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Dmitry Fleytman <dmitry@daynix.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Hannes Reinecke <hare@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Alex Williamson <alex.williamson@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>

Cao jin (8):
  msix: Rename and create a wrapper
  megasas: change behaviour of msix switch
  hcd-xhci: change behaviour of msix switch
  megasas: undo the overwrites of msi user configuration
  vmxnet3: fix reference leak issue
  vmxnet3: remove unnecessary internal msix flag
  msi_init: convert assert to return -errno
  megasas: remove unnecessary megasas_use_msix()

 hw/net/vmxnet3.c      | 40 +++++++++++++++-------------------------
 hw/pci/msi.c          |  9 ++++++---
 hw/pci/msix.c         | 30 +++++++++++++++++++++---------
 hw/scsi/megasas.c     | 48 +++++++++++++++++++++++++-----------------------
 hw/usb/hcd-xhci.c     | 29 +++++++++++++++++++++--------
 hw/vfio/pci.c         | 12 ++++++------
 include/hw/pci/msix.h |  5 +++++
 7 files changed, 99 insertions(+), 74 deletions(-)

-- 
2.1.0
