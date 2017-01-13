Received: from eggs.gnu.org ([2001:4830:134:3::10]:59374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvx1-0008JU-L6
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvwz-0001Qq-2k
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:03 -0500
Received: from [59.151.112.132] (port=54421 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvwy-0001HH-7n
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:01 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Fri, 13 Jan 2017 15:11:54 +0800
Message-ID: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 00/10] Convert msix_init() to error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Only a tiny modification in patch "megasas: remove unnecessary
megasas_use_msix()" to fix a megasas issue.

v8 changelog:
1. reorder: place the "megasas: remove unnecessary megasas_use_msix()"
   as the last one. and fix the bug in it, detailed description in it,
   also removed the R-b of it.
2. Add the Acked-by from Marcel for first 9 patches; add the R-b from Markus
   to "hcd-xhci: check & correct param before using it".

Test:
1. make check ok
2. command line test for all affected device, make sure their realization
   is ok.
3. detailed test for megasas, hcd-xhci, vmxnet3.
   megasas: install a linux distro is ok
   ./qemu-system-x86_64 --enable-kvm -m 1024
   -device megasas,id=scsi0,bus=pci.0
   -drive file=/xx/scsi-disk.img,if=none,id=drive-scsi0
   -device scsi-disk,bus=scsi0.0,channel=0,scsi-id=4,lun=0,drive=drive-scsi0,id=scsi0-4
   -cdrom /xx/Fedora-Server-DVD-x86_64-23.iso --monitor stdio

   hcd-xhci: partition the usbstick.img, mkfs, write to file, is ok
   ./qemu-system-x86_64 -M q35 -m 1024 --enable-kvm
   -drive if=none,id=usbstick,file=/xx/usbstick.img
   -device nec-usb-xhci,id=usb,p2=8,p3=8,bus=pcie.0
   -device usb-storage,bus=usb.0,drive=usbstick --monitor stdio
   /xx/FedoraWorkStatsion23-x86_64.img

   vmxnet3: ping another destination belongs to host's network is ok.
   But no migration test, because I don't have a spare machine for now.
   ./qemu-system-x86_64 -M q35 -m 1024 --enable-kvm
   -netdev tap,id=mynet0 -device vmxnet3,netdev=mynet0
   --monitor stdio /home/pino/vm/FedoraWorkStatsion23-x86_64.img

CC: Jiri Pirko <jiri@resnulli.us>
CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Dmitry Fleytman <dmitry@daynix.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Hannes Reinecke <hare@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Alex Williamson <alex.williamson@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>

Cao jin (10):
  msix: Follow CODING_STYLE
  hcd-xhci: check & correct param before using it
  pci: Convert msix_init() to Error and fix callers to check it
  megasas: change behaviour of msix switch
  hcd-xhci: change behaviour of msix switch
  megasas: undo the overwrites of msi user configuration
  vmxnet3: fix reference leak issue
  vmxnet3: remove unnecessary internal msix flag
  msi_init: convert assert to return -errno
  megasas: remove unnecessary megasas_use_msix()

 hw/block/nvme.c        |  5 +++-
 hw/misc/ivshmem.c      |  8 +++---
 hw/net/e1000e.c        |  6 ++++-
 hw/net/rocker/rocker.c |  7 ++++-
 hw/net/vmxnet3.c       | 46 +++++++++++++++------------------
 hw/pci/msi.c           |  9 ++++---
 hw/pci/msix.c          | 42 +++++++++++++++++++++++++-----
 hw/scsi/megasas.c      | 49 ++++++++++++++++++++---------------
 hw/usb/hcd-xhci.c      | 69 ++++++++++++++++++++++++++++++--------------------
 hw/vfio/pci.c          |  8 ++++--
 hw/virtio/virtio-pci.c | 11 ++++----
 include/hw/pci/msix.h  |  5 ++--
 12 files changed, 164 insertions(+), 101 deletions(-)

-- 
2.1.0
