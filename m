Received: from eggs.gnu.org ([2001:4830:134:3::10]:54426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gNUoz-00057Y-6x
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gNUou-0001Ef-1h
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:29:27 -0500
References: <1542365406-81310-1-git-send-email-peng.hao2@zte.com.cn>
	<1542365406-81310-5-git-send-email-peng.hao2@zte.com.cn>
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Message-ID: <28d47b6b-acfd-3e24-2926-84e9fffee6c8@gmail.com>
Date: Fri, 16 Nov 2018 11:29:13 +0800
MIME-Version: 1.0
In-Reply-To: <1542365406-81310-5-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH V7 4/6] hw/arm/virt: Use the
 pvpanic device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi,

On 2018/11/16 18:50, Peng Hao wrote:
>   Add pvpanic device in arm virt machine.
> 
> Signed-off-by: Peng Hao<peng.hao2@zte.com.cn>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@redhat.com>
> ---
>   default-configs/arm-softmmu.mak |  1 +
>   hw/arm/virt.c                   | 21 +++++++++++++++++++++
>   include/hw/arm/virt.h           |  1 +
>   3 files changed, 23 insertions(+)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 2420491..50345df 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -159,3 +159,4 @@ CONFIG_PCI_DESIGNWARE=y
>   CONFIG_STRONGARM=y
>   CONFIG_HIGHBANK=y
>   CONFIG_MUSICPAL=y
> +CONFIG_PVPANIC=y
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9f67782..c4f29c8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -59,6 +59,7 @@
>   #include "qapi/visitor.h"
>   #include "standard-headers/linux/input.h"
>   #include "hw/arm/smmuv3.h"
> +#include "hw/misc/pvpanic.h"
>   
>   #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>       static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -143,6 +144,7 @@ static const MemMapEntry a15memmap[] = {
>       [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>       [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
>       [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
> +    [VIRT_PVPANIC] =            { 0x09070000, 0x00000002 },
>       [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>       /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>       [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -190,6 +192,23 @@ static bool cpu_type_valid(const char *cpu)
>       return false;
>   }
>   
> +static void create_pvpanic_device(const VirtMachineState *vms)
> +{
> +    char *nodename;
> +    hwaddr base = vms->memmap[VIRT_PVPANIC].base;
> +    hwaddr size = vms->memmap[VIRT_PVPANIC].size;
> +
> +    sysbus_create_simple(TYPE_PVPANIC_MMIO, base, NULL);
> +
> +    nodename = g_strdup_printf("/pvpanic-mmio@%" PRIx64, base);
> +    qemu_fdt_add_subnode(vms->fdt, nodename);
> +    qemu_fdt_setprop_string(vms->fdt, nodename,
> +                            "compatible", "qemu,pvpanic-mmio");
> +    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
> +                                 2, base, 2, size);
> +    g_free(nodename);
> +}
> +
>   static void create_fdt(VirtMachineState *vms)
>   {
>       void *fdt = create_device_tree(&vms->fdt_size);
> @@ -1531,6 +1550,8 @@ static void machvirt_init(MachineState *machine)
>   
>       create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
>   
> +    create_pvpanic_device(vms);
> +
It should not create pvpanic by default. It should be configurable via 
-device pvpanic.

Thanks,
Shannon
