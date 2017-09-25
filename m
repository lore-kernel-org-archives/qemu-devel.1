Received: from eggs.gnu.org ([2001:4830:134:3::10]:44745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dwQOH-00024Y-6B
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dwQOD-0007BY-LN
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:13:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dwQOD-0007BH-CZ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:13:25 -0400
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <aea5e5cc-8a14-4de6-7c6b-2bc58252e1ac@redhat.com>
Date: Mon, 25 Sep 2017 13:13:07 +0300
MIME-Version: 1.0
In-Reply-To: <1506071794-4373-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On 22/09/2017 12:16, Thomas Huth wrote:
> Historically we've marked all devices as hotpluggable by default. However,
> most devices are not hotpluggable, and you also need a HotplugHandler to
> support these devices. So if the user tries to "device_add" or "device_del"
> such a non-hotpluggable device during runtime, either nothing really usable
> happens, or QEMU even crashes/aborts unexpectedly (see for example commit
> 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
> So let's change this dangerous default behaviour and mark the devices as
> non-hotpluggable by default. Certain parent devices classes which are known
> as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable = true",
> so that devices that are derived from these classes continue to work as
> expected.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Add missing devices and dropped "RFC" status. See Eduardo's reply on
>   the previous version of this patch for the rationale which devices need
>   to be hotpluggable:
>   https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06128.html
> 
>   hw/char/virtio-serial-bus.c   |  1 +
>   hw/core/qdev.c                | 10 ++++------
>   hw/mem/nvdimm.c               |  3 +++
>   hw/mem/pc-dimm.c              |  1 +
>   hw/pci/pci.c                  |  1 +
>   hw/ppc/spapr_cpu_core.c       |  1 +
>   hw/s390x/ccw-device.c         |  1 +
>   hw/scsi/scsi-bus.c            |  1 +
>   hw/usb/bus.c                  |  1 +
>   hw/usb/dev-smartcard-reader.c |  1 +
>   hw/xen/xen_backend.c          |  1 +
>   target/i386/cpu.c             |  4 ++--
>   target/s390x/cpu.c            |  1 +
>   13 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 17a1bb0..da26fc2 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -1097,6 +1097,7 @@ static void virtio_serial_port_class_init(ObjectClass *klass, void *data)
>       k->realize = virtser_port_device_realize;
>       k->unrealize = virtser_port_device_unrealize;
>       k->props = virtser_props;
> +    k->hotpluggable = true;
>   }
>   
>   static const TypeInfo virtio_serial_port_type_info = {
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index d9ccce6..28fd92f 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1125,13 +1125,11 @@ static void device_class_init(ObjectClass *class, void *data)
>       dc->realize = device_realize;
>       dc->unrealize = device_unrealize;
>   
> -    /* by default all devices were considered as hotpluggable,
> -     * so with intent to check it in generic qdev_unplug() /
> -     * device_set_realized() functions make every device
> -     * hotpluggable. Devices that shouldn't be hotpluggable,
> -     * should override it in their class_init()
> +    /*
> +     * All devices are considered as cold-pluggable by default. The devices
> +     * that are hotpluggable should override it in their class_init().
>        */
> -    dc->hotpluggable = true;
> +    dc->hotpluggable = false;
>       dc->user_creatable = true;
>   }
>   
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 952fce5..02be9f3 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -148,9 +148,12 @@ static MemoryRegion *nvdimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
>   
>   static void nvdimm_class_init(ObjectClass *oc, void *data)
>   {
> +    DeviceClass *dc = DEVICE_CLASS(oc);
>       PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
>       NVDIMMClass *nvc = NVDIMM_CLASS(oc);
>   
> +    dc->hotpluggable = true;
> +
>       ddc->realize = nvdimm_realize;
>       ddc->get_memory_region = nvdimm_get_memory_region;
>       ddc->get_vmstate_memory_region = nvdimm_get_vmstate_memory_region;
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 66eace5..1f78567 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -443,6 +443,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
>       dc->unrealize = pc_dimm_unrealize;
>       dc->props = pc_dimm_properties;
>       dc->desc = "DIMM memory module";
> +    dc->hotpluggable = true;
>   
>       ddc->get_memory_region = pc_dimm_get_memory_region;
>       ddc->get_vmstate_memory_region = pc_dimm_get_vmstate_memory_region;
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1e6fb88..8db380d 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2534,6 +2534,7 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
>       k->unrealize = pci_qdev_unrealize;
>       k->bus_type = TYPE_PCI_BUS;
>       k->props = pci_props;
> +    k->hotpluggable = true;
>       pc->realize = pci_default_realize;
>   }
>   
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index c08ee75..720284e 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -325,6 +325,7 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
>       dc->realize = spapr_cpu_core_realize;
>       dc->unrealize = spapr_cpu_core_unrealizefn;
>       dc->props = spapr_cpu_core_properties;
> +    dc->hotpluggable = true;
>       scc->cpu_class = cpu_class_by_name(TYPE_POWERPC_CPU, data);
>       g_assert(scc->cpu_class);
>   }
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index f9bfa15..d1b6e6f 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -48,6 +48,7 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
>       k->realize = ccw_device_realize;
>       k->refill_ids = ccw_device_refill_ids;
>       dc->props = ccw_device_properties;
> +    dc->hotpluggable = true;
>   }
>   
>   const VMStateDescription vmstate_ccw_dev = {
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 977f7bc..6703b2a 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -1741,6 +1741,7 @@ static void scsi_device_class_init(ObjectClass *klass, void *data)
>       k->realize   = scsi_qdev_realize;
>       k->unrealize = scsi_qdev_unrealize;
>       k->props     = scsi_props;
> +    k->hotpluggable = true;
>   }
>   
>   static void scsi_dev_instance_init(Object *obj)
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index d910f84..16701aa 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -793,6 +793,7 @@ static void usb_device_class_init(ObjectClass *klass, void *data)
>       k->realize  = usb_qdev_realize;
>       k->unrealize = usb_qdev_unrealize;
>       k->props    = usb_props;
> +    k->hotpluggable = true;
>   }
>   
>   static const TypeInfo usb_device_type_info = {
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index bef1f03..e28d1ba 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -1499,6 +1499,7 @@ static void ccid_card_class_init(ObjectClass *klass, void *data)
>       k->init = ccid_card_init;
>       k->exit = ccid_card_exit;
>       k->props = ccid_props;
> +    k->hotpluggable = true;
>   }
>   
>   static const TypeInfo ccid_card_type_info = {
> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index c46cbb0..96621fe 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -620,6 +620,7 @@ static void xendev_class_init(ObjectClass *klass, void *data)
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       /* xen-backend devices can be plugged/unplugged dynamically */
>       dc->user_creatable = true;
> +    dc->hotpluggable = true;
>   }
>   
>   static const TypeInfo xendev_type_info = {
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0aa28fc..122623b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4170,6 +4170,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>       dc->realize = x86_cpu_realizefn;
>       dc->unrealize = x86_cpu_unrealizefn;
>       dc->props = x86_cpu_properties;
> +    dc->user_creatable = true;
> +    dc->hotpluggable = true;
>   
>       xcc->parent_reset = cc->reset;
>       cc->reset = x86_cpu_reset;
> @@ -4215,8 +4217,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>   #endif
>       cc->cpu_exec_enter = x86_cpu_exec_enter;
>       cc->cpu_exec_exit = x86_cpu_exec_exit;
> -
> -    dc->user_creatable = true;
>   }
>   
>   static const TypeInfo x86_cpu_type_info = {
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 34538c3..ef61d19 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -462,6 +462,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>       dc->realize = s390_cpu_realizefn;
>       dc->props = s390x_cpu_properties;
>       dc->user_creatable = true;
> +    dc->hotpluggable = true;
>   
>       scc->parent_reset = cc->reset;
>   #if !defined(CONFIG_USER_ONLY)
> 

For the PCI related code:
     Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
