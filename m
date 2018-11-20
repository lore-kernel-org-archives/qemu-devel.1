Received: from eggs.gnu.org ([2001:4830:134:3::10]:41081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP75G-0006NR-Mm
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP75F-0008N6-QC
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:32:58 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP75F-0008Mg-L7
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:32:57 -0500
Received: by mail-oi1-x244.google.com with SMTP id p82-v6so1615134oih.11
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:32:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1542365406-81310-5-git-send-email-peng.hao2@zte.com.cn>
References: <1542365406-81310-1-git-send-email-peng.hao2@zte.com.cn>
	<1542365406-81310-5-git-send-email-peng.hao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:32:36 +0000
Message-ID: <CAFEAcA-u=_kq66ZxawHhGCjkKjCo=urw7W3GfOwYK00AMRfWjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V7 4/6] hw/arm/virt: Use the pvpanic device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 16 November 2018 at 10:50, Peng Hao <peng.hao2@zte.com.cn> wrote:
>  Add pvpanic device in arm virt machine.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  default-configs/arm-softmmu.mak |  1 +
>  hw/arm/virt.c                   | 21 +++++++++++++++++++++
>  include/hw/arm/virt.h           |  1 +
>  3 files changed, 23 insertions(+)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
> index 2420491..50345df 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -159,3 +159,4 @@ CONFIG_PCI_DESIGNWARE=3Dy
>  CONFIG_STRONGARM=3Dy
>  CONFIG_HIGHBANK=3Dy
>  CONFIG_MUSICPAL=3Dy
> +CONFIG_PVPANIC=3Dy
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9f67782..c4f29c8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -59,6 +59,7 @@
>  #include "qapi/visitor.h"
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
> +#include "hw/misc/pvpanic.h"
>
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -143,6 +144,7 @@ static const MemMapEntry a15memmap[] =3D {
>      [VIRT_GPIO] =3D               { 0x09030000, 0x00001000 },
>      [VIRT_SECURE_UART] =3D        { 0x09040000, 0x00001000 },
>      [VIRT_SMMU] =3D               { 0x09050000, 0x00020000 },
> +    [VIRT_PVPANIC] =3D            { 0x09070000, 0x00000002 },
>      [VIRT_MMIO] =3D               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that s=
ize */
>      [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
> @@ -190,6 +192,23 @@ static bool cpu_type_valid(const char *cpu)
>      return false;
>  }
>
> +static void create_pvpanic_device(const VirtMachineState *vms)
> +{
> +    char *nodename;
> +    hwaddr base =3D vms->memmap[VIRT_PVPANIC].base;
> +    hwaddr size =3D vms->memmap[VIRT_PVPANIC].size;
> +
> +    sysbus_create_simple(TYPE_PVPANIC_MMIO, base, NULL);
> +
> +    nodename =3D g_strdup_printf("/pvpanic-mmio@%" PRIx64, base);
> +    qemu_fdt_add_subnode(vms->fdt, nodename);
> +    qemu_fdt_setprop_string(vms->fdt, nodename,
> +                            "compatible", "qemu,pvpanic-mmio");
> +    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
> +                                 2, base, 2, size);

Note that we can't take these patches into QEMU until the device
tree binding has been agreed upstream and accepted into the kernel.

> +    g_free(nodename);
> +}
> +
>  static void create_fdt(VirtMachineState *vms)
>  {
>      void *fdt =3D create_device_tree(&vms->fdt_size);
> @@ -1531,6 +1550,8 @@ static void machvirt_init(MachineState *machine)
>
>      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
>
> +    create_pvpanic_device(vms);
> +
>      create_gic(vms, pic);

As Shannon suggests, we should not be creating this device by default.

thanks
-- PMM
