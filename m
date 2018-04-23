Received: from eggs.gnu.org ([2001:4830:134:3::10]:53850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAbGE-0001vW-ML
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAbGD-0001WS-Ia
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:12:02 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAbGD-0001W9-Cw
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:12:01 -0400
Received: by mail-ot0-x243.google.com with SMTP id q10-v6so12386315oth.9
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 06:12:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3301c5bc-7b47-1b0e-8ce4-30435057a276@web.de>
References: <3301c5bc-7b47-1b0e-8ce4-30435057a276@web.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 14:11:40 +0100
Message-ID: <CAFEAcA9KSUppGGom-ipX+N49j0gDJH3KDY8oyqT8cVOU0Mn8Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: Add linux, pci-domain property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>

On 23 April 2018 at 06:18, Jan Kiszka <jan.kiszka@web.de> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This allows to pin the host controller in the Linux PCI domain space.
> Linux requires that property to be available consistently or not at all,
> in which case the domain number becomes unstable on additions/removals.
> Adding it here won't make a difference in practice for most setups as we
> only expose one controller.
>
> However, enabling Jailhouse on top may introduce another controller, and
> that one would like to have stable address as well. So the property is
> needed for the first controller as well.

Am I right in thinking that for ACPI the PCI domain number is
communicated via the _SEG method? If so, looks like we already
set that, and we set it to 0, which matches what we're doing here
in the DT, so that's good.

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 94dcb125d3..943371b75e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1023,6 +1023,7 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
>      qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "pci");
>      qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 3);
>      qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 2);
> +    qemu_fdt_setprop_cell(vms->fdt, nodename, "linux,pci-domain", 0);
>      qemu_fdt_setprop_cells(vms->fdt, nodename, "bus-range", 0,
>                             nr_pcie_buses - 1);
>      qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
> --

Drew -- is minor changes to the DTC something we can do without
having to condition it on machine version? I forget...

thanks
-- PMM
