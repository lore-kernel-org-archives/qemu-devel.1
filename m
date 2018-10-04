Received: from eggs.gnu.org ([2001:4830:134:3::10]:54087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g87Rp-00086H-Ij
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g87Ro-0005GS-PV
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:30:01 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1g87Rl-0005EF-1L
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:29:58 -0400
Received: by mail-lj1-x244.google.com with SMTP id v7-v6so8681153ljg.5
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 10:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-5-f4bug@amsat.org>
In-Reply-To: <20181001220942.2382-5-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 4 Oct 2018 10:29:26 -0700
Message-ID: <CAKmqyKMCBBKOoB3fC9P=UBfNhFexAsqH=4DUjrg63wmq0XoCqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/15] hw/ssi/xilinx_spi: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Oct 1, 2018 at 3:32 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Move from the legacy SysBusDevice::init method to using DeviceState::real=
ize.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ssi/xilinx_spi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
> index 83585bc8b2..3dae303d5b 100644
> --- a/hw/ssi/xilinx_spi.c
> +++ b/hw/ssi/xilinx_spi.c
> @@ -319,9 +319,9 @@ static const MemoryRegionOps spi_ops =3D {
>      }
>  };
>
> -static int xilinx_spi_init(SysBusDevice *sbd)
> +static void xilinx_spi_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      XilinxSPI *s =3D XILINX_SPI(dev);
>      int i;
>
> @@ -344,8 +344,6 @@ static int xilinx_spi_init(SysBusDevice *sbd)
>
>      fifo8_create(&s->tx_fifo, FIFO_CAPACITY);
>      fifo8_create(&s->rx_fifo, FIFO_CAPACITY);
> -
> -    return 0;
>  }
>
>  static const VMStateDescription vmstate_xilinx_spi =3D {
> @@ -368,9 +366,8 @@ static Property xilinx_spi_properties[] =3D {
>  static void xilinx_spi_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init =3D xilinx_spi_init;
> +    dc->realize =3D xilinx_spi_realize;
>      dc->reset =3D xlx_spi_reset;
>      dc->props =3D xilinx_spi_properties;
>      dc->vmsd =3D &vmstate_xilinx_spi;
> --
> 2.19.0
>
>
