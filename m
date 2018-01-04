Received: from eggs.gnu.org ([2001:4830:134:3::10]:43797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eX9iV-0001vv-7j
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eX9iT-0003JY-Ie
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:54:11 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:45793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eX9iT-0003Io-8S
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:54:09 -0500
Received: by mail-wm0-x243.google.com with SMTP id 9so4919768wme.4
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 09:54:09 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103180805.18140-7-f4bug@amsat.org>
References: <20180103180805.18140-1-f4bug@amsat.org>
	<20180103180805.18140-7-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 4 Jan 2018 09:53:37 -0800
Message-ID: <CAKmqyKMy25-6hc0HUA5w8iU+Sion-gNAcZnGC2xBmUoktgWXxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 06/17] sdhci: refactor common sysbus/pci
 realize() into sdhci_common_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jan 3, 2018 at 10:07 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
> Since previous series failed, I dropped:
>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>
>  hw/sd/sdhci.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 68bcf75478..b3dbd994fd 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1194,6 +1194,15 @@ static void sdhci_initfn(SDHCIState *s)
>      s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_tr=
ansfer, s);
>  }
>
> +static void sdhci_common_realize(SDHCIState *s, Error **errp)
> +{
> +    s->buf_maxsz =3D sdhci_get_fifolen(s);
> +    s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdh=
ci",
> +                          SDHC_REGISTERS_MAP_SIZE);
> +}
> +
>  static void sdhci_uninitfn(SDHCIState *s)
>  {
>      timer_del(s->insert_timer);
> @@ -1290,14 +1299,16 @@ static void sdhci_common_class_init(ObjectClass *=
klass, void *data)
>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>  {
>      SDHCIState *s =3D PCI_SDHCI(dev);
> +
> +    sdhci_initfn(s);
> +    sdhci_common_realize(s, errp);
> +    if (errp && *errp) {
> +        return;
> +    }
> +
>      dev->config[PCI_CLASS_PROG] =3D 0x01; /* Standard Host supported DMA=
 */
>      dev->config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin A */
> -    sdhci_initfn(s);
> -    s->buf_maxsz =3D sdhci_get_fifolen(s);
> -    s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
>      s->irq =3D pci_allocate_irq(dev);
> -    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdh=
ci",
> -            SDHC_REGISTERS_MAP_SIZE);
>      pci_register_bar(dev, 0, 0, &s->iomem);
>  }
>
> @@ -1351,11 +1362,12 @@ static void sdhci_sysbus_realize(DeviceState *dev=
, Error ** errp)
>      SDHCIState *s =3D SYSBUS_SDHCI(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>
> -    s->buf_maxsz =3D sdhci_get_fifolen(s);
> -    s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
> +    sdhci_common_realize(s, errp);
> +    if (errp && *errp) {
> +        return;
> +    }
> +
>      sysbus_init_irq(sbd, &s->irq);
> -    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdh=
ci",
> -            SDHC_REGISTERS_MAP_SIZE);
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
>
> --
> 2.15.1
>
>
