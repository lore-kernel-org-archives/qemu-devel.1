Received: from eggs.gnu.org ([2001:4830:134:3::10]:56386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cw0y9-0006F6-TB
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 02:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cw0y8-00015S-Fm
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 02:32:33 -0400
References: <20170404202429.14643-1-ehabkost@redhat.com>
	<20170404202429.14643-3-ehabkost@redhat.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <735c80a5-c8e6-e78d-d2c4-a9daee0e9d96@suse.com>
Date: Thu, 6 Apr 2017 08:32:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170404202429.14643-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/21] sysbus: Set user_creatable=false
 by default on TYPE_SYS_BUS_DEVICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, "Gabriel L . Somlo" <somlo@cmu.edu>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Rob Herring <robh@kernel.org>, Shannon Zhao <zhaoshenglong@huawei.com>, sstabellini@kernel.org, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

On 04/04/17 22:24, Eduardo Habkost wrote:
> commit 33cd52b5d7b9adfd009e95f07e6c64dd88ae2a31 unset
> cannot_instantiate_with_device_add_yet in TYPE_SYSBUS, making all
> sysbus devices appear on "-device help" and lack the "no-user"
> flag in "info qdm".
> 
> To fix this, we can set user_creatable=false by default on
> TYPE_SYS_BUS_DEVICE, but this requires setting
> user_creatable=true explicitly on the sysbus devices that
> actually work with -device.
> 
> Fortunately today we have just a few has_dynamic_sysbus=1
> machines: virt, pc-q35-*, ppce500, and spapr.
> 
> virt, ppce500, and spapr have extra checks to ensure just a few
> device types can be instantiated:
> 
> * virt supports only TYPE_VFIO_CALXEDA_XGMAC, TYPE_VFIO_AMD_XGBE.
> * ppce500 supports only TYPE_ETSEC_COMMON.
> * spapr supports only TYPE_SPAPR_PCI_HOST_BRIDGE.
> 
> This patch sets user_creatable=true explicitly on those 4 device
> classes.
> 
> Now, the more complex cases:
> 
> pc-q35-*: q35 has no sysbus device whitelist yet (which is a
> separate bug). We are in the process of fixing it and building a
> sysbus whitelist on q35, but in the meantime we can fix the
> "-device help" and "info qdm" bugs mentioned above. Also, despite
> not being strictly necessary for fixing the q35 bug, reducing the
> list of user_creatable=true devices will help us be more
> confident when building the q35 whitelist.
> 
> xen: We also have a hack at xen_set_dynamic_sysbus(), that sets
> has_dynamic_sysbus=true at runtime when using the Xen
> accelerator. This hack is only used to allow xen-backend devices
> to be dynamically plugged/unplugged.
> 
> This means today we can use -device with the following 22 device
> types, that are the ones compiled into the qemu-system-x86_64 and
> qemu-system-i386 binaries:
> 
> * allwinner-ahci
> * amd-iommu
> * cfi.pflash01
> * esp
> * fw_cfg_io
> * fw_cfg_mem
> * generic-sdhci
> * hpet
> * intel-iommu
> * ioapic
> * isabus-bridge
> * kvmclock
> * kvm-ioapic
> * kvmvapic
> * SUNW,fdtwo
> * sysbus-ahci
> * sysbus-fdc
> * sysbus-ohci
> * unimplemented-device
> * virtio-mmio
> * xen-backend
> * xen-sysdev
> 
> This patch adds user_creatable=true explicitly to those devices,
> temporarily, just to keep 100% compatibility with existing
> behavior of q35. Subsequent patches will remove
> user_creatable=true from the devices that are really not meant to
> user-creatable on any machine, and remove the FIXME comment from
> the ones that are really supposed to be user-creatable. This is
> being done in separate patches because we still don't have an
> obvious list of devices that will be whitelisted by q35, and I
> would like to get each device reviewed individually.
> 
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Beniamino Galvani <b.galvani@gmail.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Frank Blaschka <frank.blaschka@de.ibm.com>
> Cc: Gabriel L. Somlo <somlo@cmu.edu>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Cc: Prasad J Pandit <pjp@fedoraproject.org>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: qemu-ppc@nongnu.org
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Shannon Zhao <zhaoshenglong@huawei.com>
> Cc: sstabellini@kernel.org
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Rewrite commit message: don't pretend we are actually fixing
>   the q35 issue. We're just fixing "info qdm" and "-device help".
>   Making it easier to fix q35 is just a nice side-effect.
> * Rewrite FIXME comments to make it clear that we just have
>   user_creatable=true because we don't know yet if the device
>   should be in the q35 whitelist
> ---
>  hw/block/fdc.c           | 10 ++++++++++
>  hw/block/pflash_cfi01.c  |  5 +++++
>  hw/core/sysbus.c         | 11 +++++++++++
>  hw/i386/amd_iommu.c      |  5 +++++
>  hw/i386/intel_iommu.c    |  5 +++++
>  hw/i386/kvm/clock.c      |  5 +++++
>  hw/i386/kvm/ioapic.c     |  5 +++++
>  hw/i386/kvmvapic.c       |  5 +++++
>  hw/ide/ahci.c            | 10 ++++++++++
>  hw/intc/ioapic.c         |  5 +++++
>  hw/isa/isa-bus.c         |  5 +++++
>  hw/misc/unimp.c          |  5 +++++
>  hw/net/fsl_etsec/etsec.c |  2 ++
>  hw/nvram/fw_cfg.c        | 10 ++++++++++
>  hw/ppc/spapr_pci.c       |  2 ++
>  hw/scsi/esp.c            |  5 +++++
>  hw/sd/sdhci.c            |  5 +++++
>  hw/timer/hpet.c          |  5 +++++
>  hw/usb/hcd-ohci.c        |  5 +++++
>  hw/vfio/amd-xgbe.c       |  2 ++
>  hw/vfio/calxeda-xgmac.c  |  2 ++
>  hw/virtio/virtio-mmio.c  |  5 +++++
>  hw/xen/xen_backend.c     | 10 ++++++++++
>  23 files changed, 129 insertions(+)

Patches 2 (Xen related stuff), 3 and 20:

Acked-by: Juergen Gross <jgross@suse.com>


Juergen
