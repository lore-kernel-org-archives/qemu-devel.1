Received: from eggs.gnu.org ([2001:4830:134:3::10]:48888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD8Ua-0003tq-Cw
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD8UZ-0004QY-Ct
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:37:36 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD8UZ-0004OQ-5o
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:37:35 -0400
Received: by mail-ot1-x342.google.com with SMTP id l1so29745679otj.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 06:37:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181018130434.23237-5-philmd@redhat.com>
References: <20181018130434.23237-1-philmd@redhat.com>
	<20181018130434.23237-5-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 14:37:12 +0100
Message-ID: <CAFEAcA-WC1vRmGH0t87hHFtMNTRW16xYy5R4kqickohNhECOPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] hw/arm/virt: Use the pvpanic device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, QEMU Developers <qemu-devel@nongnu.org>, Wen Congyang <wency@cn.fujitsu.com>, Hu Tao <hutao@cn.fujitsu.com>, "open list:ARM" <qemu-arm@nongnu.org>

On 18 October 2018 at 14:04, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: Use TYPE_PVPANIC definition, split in 2 patches]
> ---
>  default-configs/arm-softmmu.mak |  2 +-
>  hw/arm/virt.c                   | 21 +++++++++++++++++++++
>  include/hw/arm/virt.h           |  1 +
>  3 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
> index 2420491aac..def07fa095 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -43,7 +43,7 @@ CONFIG_USB_MUSB=3Dy
>  CONFIG_USB_EHCI_SYSBUS=3Dy
>  CONFIG_PLATFORM_BUS=3Dy
>  CONFIG_VIRTIO_MMIO=3Dy
> -
> +CONFIG_PVPANIC=3Dy
>  CONFIG_ARM11MPCORE=3Dy
>  CONFIG_A9MPCORE=3Dy
>  CONFIG_A15MPCORE=3Dy
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9f677825f9..40469e6785 100644
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
> @@ -140,6 +141,7 @@ static const MemMapEntry a15memmap[] =3D {
>      [VIRT_UART] =3D               { 0x09000000, 0x00001000 },
>      [VIRT_RTC] =3D                { 0x09010000, 0x00001000 },
>      [VIRT_FW_CFG] =3D             { 0x09020000, 0x00000018 },
> +    [VIRT_PVPANIC_MMIO] =3D       { 0x09020018, 0x00000002 },

This shouldn't be in the same physical 64K page as the preceding device:
we carefully keep them all separate so that the guest can give them
separate MMU permissions if it wants.

>      [VIRT_GPIO] =3D               { 0x09030000, 0x00001000 },
>      [VIRT_SECURE_UART] =3D        { 0x09040000, 0x00001000 },
>      [VIRT_SMMU] =3D               { 0x09050000, 0x00020000 },
> @@ -802,6 +804,23 @@ static void create_gpio(const VirtMachineState *vms,=
 qemu_irq *pic)
>      g_free(nodename);
>  }
>
> +static void create_pvpanic_device(const VirtMachineState *vms)
> +{
> +    char *nodename;
> +    hwaddr base =3D vms->memmap[VIRT_PVPANIC_MMIO].base;
> +    hwaddr size =3D vms->memmap[VIRT_PVPANIC_MMIO].size;
> +
> +    sysbus_create_simple(TYPE_PVPANIC, base, NULL);
> +
> +    nodename =3D g_strdup_printf("/pvpanic-mmio@%" PRIx64, base);
> +    qemu_fdt_add_subnode(vms->fdt, nodename);
> +    qemu_fdt_setprop_string(vms->fdt, nodename,
> +                            "compatible", "pvpanic,mmio");
> +    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
> +                                 2, base, 2, size);

This doesn't seem to be an official DT binding. It would need to be
accepted upstream (ie in the kernel's Documentation/devicetree/bindings/)
before we could add the device in QEMU.

What about an ACPI table entry?

Does this really need to be an MMIO device, rather than a PCI device?
Being a PCI device would avoid all of these issues:
 * having to specify a dt binding
 * having to specify an ACPI binding
 * having to either have the thing always present, or some custom
   way for the user to enable/disable it
plus it means it's available for other boards and architectures than
just the Arm virt board.

I'd also like some confirmation from folks more familiar with the
current state of the art in guest-to-management-layer communication
that pvpanic is still the recommended way to achieve this goal,
and hasn't been obsoleted by something else.

thanks
-- PMM
