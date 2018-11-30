Received: from eggs.gnu.org ([2001:4830:134:3::10]:35337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSl2B-0003ey-2c
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSl2A-0003wU-1I
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:48:50 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSl29-0003vs-QV
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:48:49 -0500
Received: by mail-ot1-x342.google.com with SMTP id v23so5462802otk.9
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 07:48:49 -0800 (PST)
MIME-Version: 1.0
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
	<1543407172-16175-5-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543407172-16175-5-git-send-email-peng.hao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:48:37 +0000
Message-ID: <CAFEAcA-D==grLysFf9Mm2iwQ1uUm7hf+OUtx5QKje9tGyu9SFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V10 4/9] hw/arm/virt: Use the pvpanic device
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

On Wed, 28 Nov 2018 at 03:50, Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Add pvpanic device in arm virt machine.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  default-configs/arm-softmmu.mak |  1 +
>  hw/arm/virt.c                   | 21 +++++++++++++++++++++
>  include/hw/arm/virt.h           |  1 +
>  3 files changed, 23 insertions(+)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 2420491..50345df 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -159,3 +159,4 @@ CONFIG_PCI_DESIGNWARE=y
>  CONFIG_STRONGARM=y
>  CONFIG_HIGHBANK=y
>  CONFIG_MUSICPAL=y
> +CONFIG_PVPANIC=y
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a2b8d8f..f2cb5de 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -143,6 +143,7 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>      [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
>      [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
> +    [VIRT_PVPANIC] =            { 0x09070000, 0x00000002 },
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -190,6 +191,24 @@ static bool cpu_type_valid(const char *cpu)
>      return false;
>  }
>
> +static void create_pvpanic_device(const VirtMachineState *vms)
> +{
> +     char *nodename;
> +     hwaddr base = vms->memmap[VIRT_PVPANIC].base;
> +     hwaddr size = vms->memmap[VIRT_PVPANIC].size;
> +
> +     sysbus_create_simple(TYPE_PVPANIC_MMIO, base, NULL);
> +
> +     nodename = g_strdup_printf("/pvpanic-mmio@%" PRIx64, base);
> +     qemu_fdt_add_subnode(vms->fdt, nodename);
> +     qemu_fdt_setprop_string(vms->fdt, nodename,
> +                             "compatible", "qemu,pvpanic-mmio");
> +     qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
> +                                  2, base, 2, size);
> +
> +     g_free(nodename);
> +}

Just a note that the binding documentation for this still doesn't
seem to be in the mainline kernel git repo yet; I won't take
the patchset until it is.

thanks
-- PMM
