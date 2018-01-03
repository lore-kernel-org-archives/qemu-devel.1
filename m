Received: from eggs.gnu.org ([2001:4830:134:3::10]:48621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWdr7-00047X-BA
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWdr3-0006uF-Fb
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:52:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eWdr3-0006te-76
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 02:52:53 -0500
Date: Wed, 3 Jan 2018 15:52:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180103075249.GD25984@localhost.localdomain>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<20171229174933.1781-7-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171229174933.1781-7-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/42] sdhci: refactor common sysbus/pci
 realize() into sdhci_realizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org

On Fri, 12/29 14:48, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>  hw/sd/sdhci.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 38d82b4c61..ad5853d527 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1194,6 +1194,15 @@ static void sdhci_initfn(SDHCIState *s)
>      s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_=
transfer, s);
>  }
> =20
> +static void sdhci_realizefn(SDHCIState *s, Error **errp)

errp is not used here. It doesn't hurt to have it but if the contract is =
"the
function MAY return error", the callers should check and handle it correc=
tly
(like return early instead of continuing).

Fam

> +{
> +    s->buf_maxsz =3D sdhci_get_fifolen(s);
> +    s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "s=
dhci",
> +                          SDHC_REGISTERS_MAP_SIZE);
> +}
> +
>  static void sdhci_uninitfn(SDHCIState *s)
>  {
>      timer_del(s->insert_timer);
> @@ -1292,12 +1301,11 @@ static void sdhci_pci_realize(PCIDevice *dev, E=
rror **errp)
>      SDHCIState *s =3D PCI_SDHCI(dev);
>      dev->config[PCI_CLASS_PROG] =3D 0x01; /* Standard Host supported D=
MA */
>      dev->config[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin A */
> +
>      sdhci_initfn(s);
> -    s->buf_maxsz =3D sdhci_get_fifolen(s);
> -    s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
> +    sdhci_realizefn(s, errp);
> +
>      s->irq =3D pci_allocate_irq(dev);
> -    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "s=
dhci",
> -            SDHC_REGISTERS_MAP_SIZE);
>      pci_register_bar(dev, 0, 0, &s->iomem);
>  }
> =20
> @@ -1351,11 +1359,9 @@ static void sdhci_sysbus_realize(DeviceState *de=
v, Error ** errp)
>      SDHCIState *s =3D SYSBUS_SDHCI(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> =20
> -    s->buf_maxsz =3D sdhci_get_fifolen(s);
> -    s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
> +    sdhci_realizefn(s, errp);
> +
>      sysbus_init_irq(sbd, &s->irq);
> -    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "s=
dhci",
> -            SDHC_REGISTERS_MAP_SIZE);
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
> =20
> --=20
> 2.15.1
>=20
>=20
