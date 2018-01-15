Received: from eggs.gnu.org ([2001:4830:134:3::10]:56406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb5Af-0003S8-W3
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb5AO-0004Hg-MV
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:51:29 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:42154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb5AO-0004H4-Dh
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:51:12 -0500
Received: by mail-ot0-x229.google.com with SMTP id s3so10668247otc.9
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:51:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180113050717.22969-14-f4bug@amsat.org>
References: <20180113050717.22969-1-f4bug@amsat.org>
	<20180113050717.22969-14-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 13:50:51 +0000
Message-ID: <CAFEAcA-Vbm8WFAHOv3-g7fSyBbdxjf7ajymDTj2H5PVTFn72Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 13/14] sdhci: fix the PCI device,
 using the PCI address space for DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>

On 13 January 2018 at 05:07, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> While SysBus devices can use the get_system_memory() address space,
> PCI devices should use the bus master address space for DMA.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Should we check for the PCI_COMMAND_MASTER bit before
> using pci_get_address_space()?

That isn't necessary -- the PCI core code handles the master
bit by mapping or unmapping a memory region from the container
which is what the pci_get_address_space() does its writes to.

> @@ -1382,6 +1381,9 @@ static void sdhci_sysbus_realize(DeviceState *dev, =
Error ** errp)
>          return;
>      }
>
> +    s->dma_as =3D g_new0(AddressSpace, 1);
> +    address_space_init(s->dma_as, get_system_memory(), "sdhci-dma");

You can just use address_space_memory rather than creating
a new address space here.

> +
>      sysbus_init_irq(sbd, &s->irq);
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
> @@ -1391,6 +1393,9 @@ static void sdhci_sysbus_unrealize(DeviceState *dev=
, Error **errp)
>      SDHCIState *s =3D SYSBUS_SDHCI(dev);
>
>      sdhci_common_unrealize(s, &error_abort);
> +
> +    address_space_destroy(s->dma_as);
> +    g_free(s->dma_as);
>  }
>
>  static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
> --
> 2.15.1

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
