Received: from eggs.gnu.org ([2001:4830:134:3::10]:44279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@pond.sub.org>) id 1dACOM-0000zq-NI
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@pond.sub.org>) id 1dACOI-0001b1-PF
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:34:14 -0400
From: Markus Armbruster <armbru@redhat.com>
In-Reply-To: <20170503203604.31462-3-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Wed, 3 May 2017 17:35:45 -0300")
Date: Mon, 15 May 2017 10:43:46 +0200
References: <20170503203604.31462-1-ehabkost@redhat.com>
	<20170503203604.31462-3-ehabkost@redhat.com>
Message-ID: <87o9uuzcp0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RESEND v2 02/21] sysbus: Set
 user_creatable=false by default on TYPE_SYS_BUS_DEVICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, sstabellini@kernel.org, qemu-block@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Gabriel L . Somlo" <somlo@cmu.edu>, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Juergen Gross <jgross@suse.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, Prasad J Pandit <pjp@fedoraproject.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

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

Correct me if I'm wrong: the devices become user_creatable regardless of
machine type, but they're actually creatable only for specific machine
types.  Not perfect, but much better than what we have now.

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

Later patches indeed remove all the FIXMEs.  Good.

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
> Acked-by: John Snow <jsnow@redhat.com>
> Acked-by: Juergen Gross <jgross@suse.com>
> Acked-by: Marcel Apfelbaum <marcel@redhat.com>
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
>
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 2e629b398b..5c28a0b0ad 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -2880,6 +2880,11 @@ static void sysbus_fdc_class_init(ObjectClass *klass, void *data)
>  
>      dc->props = sysbus_fdc_properties;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo sysbus_fdc_info = {
> @@ -2906,6 +2911,11 @@ static void sun4m_fdc_class_init(ObjectClass *klass, void *data)
>  
>      dc->props = sun4m_fdc_properties;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo sun4m_fdc_info = {
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 594d4cf6fe..ef71956433 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -927,6 +927,11 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
>      dc->props = pflash_cfi01_properties;
>      dc->vmsd = &vmstate_pflash;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index c0f560b289..6a2eec8dd0 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -326,6 +326,17 @@ static void sysbus_device_class_init(ObjectClass *klass, void *data)
>      DeviceClass *k = DEVICE_CLASS(klass);
>      k->init = sysbus_device_init;
>      k->bus_type = TYPE_SYSTEM_BUS;
> +    /*
> +     * device_add plugs devices into suitable bus.  For "real" buses,
> +     * that actually connects the device.  For sysbus, the connections
> +     * need to be made separately, and device_add can't do that.  The
> +     * device would be left unconnected, and will probably not work
> +     *
> +     * However, a few machines and a few devices can handle a few sysbus
> +     * devices. In this case, the device subclass needs to override
> +     * it and set user_creatable=true.
> +     */
> +    k->user_creatable = false;
>  }
>  
>  static const TypeInfo sysbus_device_type_info = {
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index f86a40aa30..7b92c8c15a 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1186,6 +1186,11 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
>      dc->vmsd = &vmstate_amdvi;
>      dc->hotpluggable = false;
>      dc_class->realize = amdvi_realize;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo amdvi = {
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 02f047c8e3..54187a04a4 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3009,6 +3009,11 @@ static void vtd_class_init(ObjectClass *klass, void *data)
>      dc->hotpluggable = false;
>      x86_class->realize = vtd_realize;
>      x86_class->int_remap = vtd_int_remap;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo vtd_info = {
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 13eca374cd..7665bef999 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -286,6 +286,11 @@ static void kvmclock_class_init(ObjectClass *klass, void *data)
>      dc->realize = kvmclock_realize;
>      dc->vmsd = &kvmclock_vmsd;
>      dc->props = kvmclock_properties;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo kvmclock_info = {
> diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
> index 98ca480792..348c405180 100644
> --- a/hw/i386/kvm/ioapic.c
> +++ b/hw/i386/kvm/ioapic.c
> @@ -167,6 +167,11 @@ static void kvm_ioapic_class_init(ObjectClass *klass, void *data)
>      k->post_load = kvm_ioapic_put;
>      dc->reset    = kvm_ioapic_reset;
>      dc->props    = kvm_ioapic_properties;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo kvm_ioapic_info = {
> diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
> index 82a49556af..45f6267c93 100644
> --- a/hw/i386/kvmvapic.c
> +++ b/hw/i386/kvmvapic.c
> @@ -856,6 +856,11 @@ static void vapic_class_init(ObjectClass *klass, void *data)
>      dc->reset   = vapic_reset;
>      dc->vmsd    = &vmstate_vapic;
>      dc->realize = vapic_realize;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo vapic_type = {
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index f60826d6e0..7f10cda354 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1721,6 +1721,11 @@ static void sysbus_ahci_class_init(ObjectClass *klass, void *data)
>      dc->props = sysbus_ahci_properties;
>      dc->reset = sysbus_ahci_reset;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo sysbus_ahci_info = {
> @@ -1815,6 +1820,11 @@ static void allwinner_ahci_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->vmsd = &vmstate_allwinner_ahci;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo allwinner_ahci_info = {
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 37c4386ae3..f9e4f77def 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -448,6 +448,11 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
>      k->post_load = ioapic_update_kvm_routes;
>      dc->reset = ioapic_reset_common;
>      dc->props = ioapic_properties;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo ioapic_info = {
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 348e0eab9d..ad4ac3b4f6 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -221,6 +221,11 @@ static void isabus_bridge_class_init(ObjectClass *klass, void *data)
>  
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->fw_name = "isa";
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo isabus_bridge_info = {
> diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
> index bcbb585888..e446c1d652 100644
> --- a/hw/misc/unimp.c
> +++ b/hw/misc/unimp.c
> @@ -90,6 +90,11 @@ static void unimp_class_init(ObjectClass *klass, void *data)
>  
>      dc->realize = unimp_realize;
>      dc->props = unimp_properties;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo unimp_info = {
> diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
> index aa2b0d5a85..9da1932970 100644
> --- a/hw/net/fsl_etsec/etsec.c
> +++ b/hw/net/fsl_etsec/etsec.c
> @@ -416,6 +416,8 @@ static void etsec_class_init(ObjectClass *klass, void *data)
>      dc->realize = etsec_realize;
>      dc->reset = etsec_reset;
>      dc->props = etsec_properties;
> +    /* Supported by ppce500 machine */
> +    dc->user_creatable = true;
>  }
>  
>  static TypeInfo etsec_info = {
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 316fca9bc1..7993aea792 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1101,6 +1101,11 @@ static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
>  
>      dc->realize = fw_cfg_io_realize;
>      dc->props = fw_cfg_io_properties;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo fw_cfg_io_info = {
> @@ -1167,6 +1172,11 @@ static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
>  
>      dc->realize = fw_cfg_mem_realize;
>      dc->props = fw_cfg_mem_properties;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo fw_cfg_mem_info = {
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index e7567e2e8f..a7cff32bbf 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1994,6 +1994,8 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
>      dc->props = spapr_phb_properties;
>      dc->reset = spapr_phb_reset;
>      dc->vmsd = &vmstate_spapr_pci;
> +    /* Supported by TYPE_SPAPR_MACHINE */
> +    dc->user_creatable = true;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      hp->plug = spapr_phb_hot_plug_child;
>      hp->unplug = spapr_phb_hot_unplug_child;
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index eee831efeb..7bdc1e1b99 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -728,6 +728,11 @@ static void sysbus_esp_class_init(ObjectClass *klass, void *data)
>      dc->reset = sysbus_esp_hard_reset;
>      dc->vmsd = &vmstate_sysbus_esp_scsi;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo sysbus_esp_info = {
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 6d6a791ee9..dbf61fccb8 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1360,6 +1360,11 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
>      dc->props = sdhci_sysbus_properties;
>      dc->realize = sdhci_sysbus_realize;
>      dc->reset = sdhci_poweron_reset;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo sdhci_sysbus_info = {
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index a2c18b30c3..4dcbd5bb3d 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -771,6 +771,11 @@ static void hpet_device_class_init(ObjectClass *klass, void *data)
>      dc->reset = hpet_reset;
>      dc->vmsd = &vmstate_hpet;
>      dc->props = hpet_device_properties;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo hpet_device_info = {
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 3ada35e954..18b31022a7 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -2159,6 +2159,11 @@ static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
>      dc->desc = "OHCI USB Controller";
>      dc->props = ohci_sysbus_properties;
>      dc->reset = usb_ohci_reset_sysbus;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo ohci_sysbus_info = {
> diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
> index 2c60310cf9..fab196cebf 100644
> --- a/hw/vfio/amd-xgbe.c
> +++ b/hw/vfio/amd-xgbe.c
> @@ -38,6 +38,8 @@ static void vfio_amd_xgbe_class_init(ObjectClass *klass, void *data)
>      dc->realize = amd_xgbe_realize;
>      dc->desc = "VFIO AMD XGBE";
>      dc->vmsd = &vfio_platform_amd_xgbe_vmstate;
> +    /* Supported by TYPE_VIRT_MACHINE */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo vfio_amd_xgbe_dev_info = {
> diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
> index bb15d588e5..7bb17af7ad 100644
> --- a/hw/vfio/calxeda-xgmac.c
> +++ b/hw/vfio/calxeda-xgmac.c
> @@ -38,6 +38,8 @@ static void vfio_calxeda_xgmac_class_init(ObjectClass *klass, void *data)
>      dc->realize = calxeda_xgmac_realize;
>      dc->desc = "VFIO Calxeda XGMAC";
>      dc->vmsd = &vfio_platform_calxeda_xgmac_vmstate;
> +    /* Supported by TYPE_VIRT_MACHINE */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo vfio_calxeda_xgmac_dev_info = {
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 5807aa87fe..6491a771ff 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -450,6 +450,11 @@ static void virtio_mmio_class_init(ObjectClass *klass, void *data)
>      dc->reset = virtio_mmio_reset;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      dc->props = virtio_mmio_properties;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo virtio_mmio_info = {
> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index c85f1637e4..67cb4cb9f0 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -619,6 +619,11 @@ static void xendev_class_init(ObjectClass *klass, void *data)
>  
>      dc->props = xendev_properties;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo xendev_type_info = {
> @@ -662,6 +667,11 @@ static void xen_sysdev_class_init(ObjectClass *klass, void *data)
>      k->init = xen_sysdev_init;
>      dc->props = xen_sysdev_properties;
>      dc->bus_type = TYPE_XENSYSBUS;
> +    /*
> +     * FIXME: Set only because we are not sure yet if this device
> +     * will be outside the q35 sysbus whitelist.
> +     */
> +    dc->user_creatable = true;
>  }
>  
>  static const TypeInfo xensysdev_info = {

Extra points for the comments.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
