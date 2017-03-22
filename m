Received: from eggs.gnu.org ([2001:4830:134:3::10]:43307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqiz5-0001Sg-GA
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqiz2-0001e4-4v
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cqiz1-0001dN-Sd
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:19:36 -0400
References: <1490198476-12244-1-git-send-email-mst@redhat.com>
	<1490198476-12244-4-git-send-email-mst@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bf935b4a-a4f8-6bfd-b62e-3222f3c83ad0@redhat.com>
Date: Wed, 22 Mar 2017 17:19:28 +0100
MIME-Version: 1.0
In-Reply-To: <1490198476-12244-4-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 3/4] hw/acpi/vmgenid: prevent device
 realization on pre-2.5 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 03/22/17 17:01, Michael S. Tsirkin wrote:
> From: Laszlo Ersek <lersek@redhat.com>
> 
> The WRITE_POINTER linker/loader command that underlies VMGENID depends on
> commit baf2d5bfbac0 ("fw-cfg: support writeable blobs", 2017-01-12), which
> in turn depends on fw_cfg DMA.
> 
> DMA for fw_cfg is enabled in 2.5+ machine types only (see commit
> e6915b5f3a87, "fw_cfg: unbreak migration compatibility for 2.4 and earlier
> machines", 2016-02-18).
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Ben Warren <ben@skyportsystems.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Can you please add the feedback tags from Ben and Igor?

http://mid.mail-archive.com/20170321131306.332253d2@nial.brq.redhat.com
http://mid.mail-archive.com/71BEDF9C-3FA5-4F2B-8763-5169B729103B@skyportsystems.com

Thanks,
Laszlo


> ---
>  include/hw/acpi/vmgenid.h |  1 +
>  include/hw/compat.h       |  4 ++++
>  hw/acpi/vmgenid.c         | 14 ++++++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
> index db7fa0e..8578476 100644
> --- a/include/hw/acpi/vmgenid.h
> +++ b/include/hw/acpi/vmgenid.h
> @@ -21,6 +21,7 @@ typedef struct VmGenIdState {
>      DeviceClass parent_obj;
>      QemuUUID guid;                /* The 128-bit GUID seen by the guest */
>      uint8_t vmgenid_addr_le[8];   /* Address of the GUID (little-endian) */
> +    bool write_pointer_available;
>  } VmGenIdState;
>  
>  static inline Object *find_vmgenid_dev(void)
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index fc8c3e0..5d5be91 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -131,6 +131,10 @@
>          .driver   = "fw_cfg_io",\
>          .property = "dma_enabled",\
>          .value    = "off",\
> +    },{\
> +        .driver   = "vmgenid",\
> +        .property = "x-write-pointer-available",\
> +        .value    = "off",\
>      },
>  
>  #define HW_COMPAT_2_3 \
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index 7a3ad17..c3ddcc8 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -205,9 +205,22 @@ static void vmgenid_handle_reset(void *opaque)
>      memset(vms->vmgenid_addr_le, 0, ARRAY_SIZE(vms->vmgenid_addr_le));
>  }
>  
> +static Property vmgenid_properties[] = {
> +    DEFINE_PROP_BOOL("x-write-pointer-available", VmGenIdState,
> +                     write_pointer_available, true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void vmgenid_realize(DeviceState *dev, Error **errp)
>  {
>      VmGenIdState *vms = VMGENID(dev);
> +
> +    if (!vms->write_pointer_available) {
> +        error_setg(errp, "%s requires DMA write support in fw_cfg, "
> +                   "which this machine type does not provide", VMGENID_DEVICE);
> +        return;
> +    }
> +
>      qemu_register_reset(vmgenid_handle_reset, vms);
>  }
>  
> @@ -218,6 +231,7 @@ static void vmgenid_device_class_init(ObjectClass *klass, void *data)
>      dc->vmsd = &vmstate_vmgenid;
>      dc->realize = vmgenid_realize;
>      dc->hotpluggable = false;
> +    dc->props = vmgenid_properties;
>  
>      object_class_property_add_str(klass, VMGENID_GUID, NULL,
>                                    vmgenid_set_guid, NULL);
> 
