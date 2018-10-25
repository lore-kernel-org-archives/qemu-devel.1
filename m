Received: from eggs.gnu.org ([2001:4830:134:3::10]:53198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFdrT-0007Eq-G6
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFdoW-0002xF-Iq
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:28:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gFdoU-0002Op-Iv
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:28:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id q6-v6so8917028wrw.11
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 04:28:21 -0700 (PDT)
References: <1540495397-88089-1-git-send-email-peng.hao2@zte.com.cn>
	<1540495397-88089-5-git-send-email-peng.hao2@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f15d7c94-a7ab-0616-0719-e12f997729b6@redhat.com>
Date: Thu, 25 Oct 2018 13:28:19 +0200
MIME-Version: 1.0
In-Reply-To: <1540495397-88089-5-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 4/5] hw/arm/virt: Use the pvpanic device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi,

On 25/10/18 21:23, Peng Hao wrote:
> add pvpanic device in aarch64 virt machine.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   default-configs/aarch64-softmmu.mak |  1 +
>   hw/arm/virt.c                       | 21 +++++++++++++++++++++
>   include/hw/arm/virt.h               |  1 +
>   3 files changed, 23 insertions(+)
> 
> diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
> index 6f790f0..57c6ca5 100644
> --- a/default-configs/aarch64-softmmu.mak
> +++ b/default-configs/aarch64-softmmu.mak
> @@ -9,3 +9,4 @@ CONFIG_DPCD=y
>   CONFIG_XLNX_ZYNQMP=y
>   CONFIG_XLNX_ZYNQMP_ARM=y
>   CONFIG_ARM_SMMUV3=y
> +CONFIG_PVPANIC=y
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9f67782..ffe8d00 100644
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
> +    [VIRT_PVPANIC_MMIO] =       { 0x09060000, 0x00000002 },
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
> +    hwaddr base = vms->memmap[VIRT_PVPANIC_MMIO].base;
> +    hwaddr size = vms->memmap[VIRT_PVPANIC_MMIO].size;
> +
> +    sysbus_create_simple(TYPE_PVPANIC_MMIO, base, NULL);
> +
> +    nodename = g_strdup_printf("/pvpanic-mmio@%" PRIx64, base);

Can you add a link in the cover linking to the kernel side series?

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
>       create_gic(vms, pic);
>   
>       fdt_add_pmu_nodes(vms);
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 4cc57a7..ba54b84 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -66,6 +66,7 @@ enum {
>       VIRT_GIC_REDIST,
>       VIRT_GIC_REDIST2,
>       VIRT_SMMU,
> +    VIRT_PVPANIC_MMIO,

All those enums are MMIO, so we can simply use VIRT_PVPANIC here.

>       VIRT_UART,
>       VIRT_MMIO,
>       VIRT_RTC,
> 
