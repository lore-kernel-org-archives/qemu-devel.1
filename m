Received: from eggs.gnu.org ([2001:4830:134:3::10]:35375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW4Si-000147-RK
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW4Sf-00010d-PT
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:00:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cW4Sf-00010K-Ho
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:00:49 -0500
Date: Tue, 24 Jan 2017 19:00:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170124185538-mutt-send-email-mst@kernel.org>
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v9 00/11] Convert msix_init() to error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Jiri Pirko <jiri@resnulli.us>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Tue, Jan 17, 2017 at 02:18:45PM +0800, Cao jin wrote:
> v9 changelog:
> 1. split previous patch 3 into two separate patches(3 & 4), per mst's review.

So I merged 1-3, making progress here.
I really don't like forcing all callers to check and assert on specific
return status, IMO most callers want an assert on any error so that
should be the default, and special cases (probably just vfio) will use a
version that does not assert.


> test:
> 1. make check ok.
> 2. detailed test on megasas/megasas-gen2, hcd-xhci, vmxnet3.
>    megasas/megasas-gen2(M q35...bus=pcie.0): install a distro
>    ./qemu-system-x86_64 --enable-kvm -m 1024
>    -device megasas,id=scsi0,bus=pci.0
>    -drive file=/xx/scsi-disk.img,if=none,id=drive-scsi0
>    -device scsi-disk,bus=scsi0.0,channel=0,scsi-id=4,lun=0,drive=drive-scsi0,id=scsi0-4
>    -cdrom /xx/Fedora-Server-DVD-x86_64-23.iso -boot once=d --monitor stdio
> 
>     hcd-xhci: fdisk, mkfs.ext4, write file to usbstick.img
>     ./qemu-system-x86_64 -M q35 --enable-kvm -m 1024
>     -drive if=none,id=usbstick,file=/xx/usbstick.img
>     -device nec-usb-xhci,id=usb,p2=8,p3=8,bus=pcie.0
>     -device usb-storage,bus=usb.0,drive=usbstick
>     /xx/FedoraServer23-X86_64.img --monitor stdio
> 
>     vmxnet3: ping another destination belongs to host's network is ok; then
>              migrate to another qemu instance on the same host is ok. After
>              migration, ping can't work as before, out of the patchset's scope,
>              it is the same issue as upstream.
>     ./qemu-system-x86_64 -M q35 --enable-kvm -m 1024
>     -netdev tap,id=mynet0 -device vmxnet3,netdev=mynet0
>     /xx/FedoraServer23-X86_64.img --monitor stdio
> 
> CC: Jiri Pirko <jiri@resnulli.us>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Dmitry Fleytman <dmitry@daynix.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Hannes Reinecke <hare@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> 
> Cao jin (11):
>   msix: Follow CODING_STYLE
>   hcd-xhci: check & correct param before using it
>   pci: Convert msix_init() to Error and fix callers
>   msix: check msix_init's return value
>   megasas: change behaviour of msix switch
>   hcd-xhci: change behaviour of msix switch
>   megasas: undo the overwrites of msi user configuration
>   vmxnet3: fix reference leak issue
>   vmxnet3: remove unnecessary internal msix flag
>   msi_init: convert assert to return -errno
>   megasas: remove unnecessary megasas_use_msix()
> 
>  hw/block/nvme.c        |  2 +-
>  hw/misc/ivshmem.c      |  8 +++---
>  hw/net/e1000e.c        |  6 ++++-
>  hw/net/rocker/rocker.c |  9 ++++++-
>  hw/net/vmxnet3.c       | 46 +++++++++++++++------------------
>  hw/pci/msi.c           |  9 ++++---
>  hw/pci/msix.c          | 44 +++++++++++++++++++++++++++-----
>  hw/scsi/megasas.c      | 49 ++++++++++++++++++++---------------
>  hw/usb/hcd-xhci.c      | 69 ++++++++++++++++++++++++++++++--------------------
>  hw/vfio/pci.c          |  8 ++++--
>  hw/virtio/virtio-pci.c | 13 +++++-----
>  include/hw/pci/msix.h  |  5 ++--
>  12 files changed, 167 insertions(+), 101 deletions(-)
> 
> -- 
> 2.1.0
> 
> 
