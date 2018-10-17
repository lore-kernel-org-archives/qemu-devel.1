Received: from eggs.gnu.org ([2001:4830:134:3::10]:50052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCiVz-00080N-KZ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCiVv-0008SW-54
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:53:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gCiVu-0008QW-SA
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:53:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id l6-v6so28500538wrt.1
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 02:53:14 -0700 (PDT)
References: <1539768207-18209-1-git-send-email-peng.hao2@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <61bc5059-e7b1-3371-66b3-5bc10d06935b@redhat.com>
Date: Wed, 17 Oct 2018 11:53:11 +0200
MIME-Version: 1.0
In-Reply-To: <1539768207-18209-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm : add pvpanic mmio device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Peng,

On 17/10/2018 11:23, Peng Hao wrote:
> Add pvpanic mmio device that is similar to x86's pvpanic device.

> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  default-configs/arm-softmmu.mak |  2 +-
>  hw/arm/virt.c                   | 21 ++++++++++++
>  hw/misc/Makefile.objs           |  1 +
>  hw/misc/pvpanic-mmio.c          | 76 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h           |  1 +
>  include/hw/misc/pvpanic-mmio.h  | 12 +++++++
>  6 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100644 hw/misc/pvpanic-mmio.c
>  create mode 100644 include/hw/misc/pvpanic-mmio.h
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 2420491..4713c92 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -43,7 +43,7 @@ CONFIG_USB_MUSB=y
>  CONFIG_USB_EHCI_SYSBUS=y
>  CONFIG_PLATFORM_BUS=y
>  CONFIG_VIRTIO_MMIO=y
> -
> +CONFIG_PVPANIC_MMIO=y
>  CONFIG_ARM11MPCORE=y
>  CONFIG_A9MPCORE=y
>  CONFIG_A15MPCORE=y
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a472566..ab41128 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -140,6 +140,7 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_UART] =               { 0x09000000, 0x00001000 },
>      [VIRT_RTC] =                { 0x09010000, 0x00001000 },
>      [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
> +    [VIRT_PVPANIC_MMIO] =       { 0x09020018, 0x00000002 },
>      [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>      [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
>      [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
> @@ -798,6 +799,24 @@ static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
>      g_free(nodename);
>  }
>  
> +static void create_pvpanic_device(const VirtMachineState *vms)
> +{
> +    char *nodename;
> +    hwaddr base = vms->memmap[VIRT_PVPANIC_MMIO].base;
> +    hwaddr size = vms->memmap[VIRT_PVPANIC_MMIO].size;
> +
> +    sysbus_create_simple("pvpanic-mmio", base, NULL);
> +
> +    nodename = g_strdup_printf("/pvpanic-mmio@%" PRIx64, base);
> +    qemu_fdt_add_subnode(vms->fdt, nodename);
> +    qemu_fdt_setprop_string(vms->fdt, nodename,
> +                            "compatible", "pvpanic,mmio");
> +    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
> +                                 2, base, 2, size);
> +    g_free(nodename);
> +
> +}
> +
>  static void create_virtio_devices(const VirtMachineState *vms, qemu_irq *pic)
>  {
>      int i;
> @@ -1544,6 +1563,8 @@ static void machvirt_init(MachineState *machine)
>  
>      create_pcie(vms, pic);
>  
> +    create_pvpanic_device(vms);
> +
>      create_gpio(vms, pic);
>  
>      /* Create mmio transports, so the user can create virtio backends
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 6d50b03..6326260 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -71,6 +71,7 @@ obj-$(CONFIG_IOTKIT_SYSCTL) += iotkit-sysctl.o
>  obj-$(CONFIG_IOTKIT_SYSINFO) += iotkit-sysinfo.o
>  
>  obj-$(CONFIG_PVPANIC) += pvpanic.o
> +obj-$(CONFIG_PVPANIC_MMIO) += pvpanic-mmio.o
>  obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
>  obj-$(CONFIG_AUX) += auxbus.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
> diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
> new file mode 100644
> index 0000000..c7f373e
> --- /dev/null
> +++ b/hw/misc/pvpanic-mmio.c
> @@ -0,0 +1,76 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/log.h"
> +#include "hw/misc/pvpanic-mmio.h"
> +
> +#define PVPANIC_MMIO_FEAT_CRASHED      0
> +
> +#define PVPANIC_MMIO_CRASHED        (1 << PVPANIC_MMIO_FEAT_CRASHED)
> +
> +static void handle_mmio_event(int event)
> +{
> +    static bool logged;
> +
> +    if (event & ~PVPANIC_MMIO_CRASHED && !logged) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "pvpanic-mmio: unknown event %#x.\n", event);
> +        logged = true;
> +    }
> +
> +    if (event & PVPANIC_MMIO_CRASHED) {
> +        qemu_system_guest_panicked(NULL);
> +        return;
> +    }

It would be easier to maintain a single pvpanic device. There is no
improvement here, it is the same handler than 'pvpanic.c'.

The current pvpanic device is not x86-only, it only implements the
ioport API.
If you want to use the mmio API, please add it there.
Basically you don't have to write any more code that in this patch, but
just move it in the pvpanic.c file.

Thanks,

Phil.

> +}
> +
> +static uint64_t pvpanic_mmio_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return -1;
> +}
> +
> +static void pvpanic_mmio_write(void *opaque, hwaddr addr, uint64_t value,
> +                                 unsigned size)
> +{
> +   handle_mmio_event(value);
> +}
> +
> +static const MemoryRegionOps pvpanic_mmio_ops = {
> +    .read = pvpanic_mmio_read,
> +    .write = pvpanic_mmio_write,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 2,
> +    },
> +};
> +
> +
> +static void pvpanic_mmio_initfn(Object *obj)
> +{
> +    PVPanicState *s = PVPANIC_MMIO_DEVICE(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &pvpanic_mmio_ops, s,
> +                          "pvpanic-mmio", 2);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +}
> +
> +static void pvpanic_mmio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static TypeInfo pvpanic_mmio_info = {
> +    .name          = TYPE_PVPANIC_MMIO,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(PVPanicState),
> +    .instance_init = pvpanic_mmio_initfn,
> +    .class_init    = pvpanic_mmio_class_init,
> +};
> +
> +static void pvpanic_mmio_register_types(void)
> +{
> +    type_register_static(&pvpanic_mmio_info);
> +}
> +
> +type_init(pvpanic_mmio_register_types)
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 4cc57a7..61cc310 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -70,6 +70,7 @@ enum {
>      VIRT_MMIO,
>      VIRT_RTC,
>      VIRT_FW_CFG,
> +    VIRT_PVPANIC_MMIO,
>      VIRT_PCIE,
>      VIRT_PCIE_MMIO,
>      VIRT_PCIE_PIO,
> diff --git a/include/hw/misc/pvpanic-mmio.h b/include/hw/misc/pvpanic-mmio.h
> new file mode 100644
> index 0000000..2e6bec3
> --- /dev/null
> +++ b/include/hw/misc/pvpanic-mmio.h
> @@ -0,0 +1,12 @@
> +#ifndef HW_MISC_PVPANIC_H
> +#define HW_MISC_PVPANIC_H
> +#include "hw/sysbus.h"
> +#define TYPE_PVPANIC_MMIO "pvpanic-mmio"
> +#define PVPANIC_MMIO_DEVICE(obj)    \
> +    OBJECT_CHECK(PVPanicState, (obj), TYPE_PVPANIC_MMIO)
> +#endif
> +
> +typedef struct PVPanicState {
> +    SysBusDevice parent_obj;
> +    MemoryRegion mmio;
> +} PVPanicState;
> 
