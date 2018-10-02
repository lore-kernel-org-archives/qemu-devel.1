Received: from eggs.gnu.org ([2001:4830:134:3::10]:40962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7GDx-00036p-1E
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7GDt-0003S4-Se
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:40:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g7GDt-0003Rm-LZ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:40:05 -0400
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-5-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9582d68e-5704-3924-6e5c-efc6f3c2a896@redhat.com>
Date: Tue, 2 Oct 2018 10:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On 2018-10-02 00:09, Philippe Mathieu-Daud=C3=A9 wrote:
> Move from the legacy SysBusDevice::init method to using DeviceState::re=
alize.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/ssi/xilinx_spi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
> index 83585bc8b2..3dae303d5b 100644
> --- a/hw/ssi/xilinx_spi.c
> +++ b/hw/ssi/xilinx_spi.c
> @@ -319,9 +319,9 @@ static const MemoryRegionOps spi_ops =3D {
>      }
>  };
> =20
> -static int xilinx_spi_init(SysBusDevice *sbd)
> +static void xilinx_spi_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      XilinxSPI *s =3D XILINX_SPI(dev);
>      int i;
> =20
> @@ -344,8 +344,6 @@ static int xilinx_spi_init(SysBusDevice *sbd)
> =20
>      fifo8_create(&s->tx_fifo, FIFO_CAPACITY);
>      fifo8_create(&s->rx_fifo, FIFO_CAPACITY);
> -
> -    return 0;
>  }
> =20
>  static const VMStateDescription vmstate_xilinx_spi =3D {
> @@ -368,9 +366,8 @@ static Property xilinx_spi_properties[] =3D {
>  static void xilinx_spi_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D xilinx_spi_init;
> +    dc->realize =3D xilinx_spi_realize;
>      dc->reset =3D xlx_spi_reset;
>      dc->props =3D xilinx_spi_properties;
>      dc->vmsd =3D &vmstate_xilinx_spi;
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
