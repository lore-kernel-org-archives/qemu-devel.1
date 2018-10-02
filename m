Received: from eggs.gnu.org ([2001:4830:134:3::10]:45891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvn-0004Xf-KR
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvm-0007JL-Hj
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:51 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:55747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7Mvm-0007IO-Ao
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:50 -0400
Received: from player750.ha.ovh.net (unknown [10.109.160.153])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 02B612E516
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 17:49:47 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-8-f4bug@amsat.org>
Message-ID: <49859d4f-884e-8833-c99e-b234f4354329@kaod.org>
Date: Tue, 2 Oct 2018 17:49:41 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/15] hw/mips/gt64xxx_pci: Convert
 gt64120_reset() function into Device reset method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 10/2/18 12:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Convert the gt64120_reset() function into a proper Device reset method.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/mips/gt64xxx_pci.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index 24ad0ad024..dcd1a66329 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -992,9 +992,9 @@ static void gt64120_pci_set_irq(void *opaque, int i=
rq_num, int level)
>  }
> =20
> =20
> -static void gt64120_reset(void *opaque)
> +static void gt64120_reset(DeviceState *dev)
>  {
> -    GT64120State *s =3D opaque;
> +    GT64120State *s =3D GT64120_PCI_HOST_BRIDGE(dev);
> =20
>      /* FIXME: Malta specific hw assumptions ahead */
> =20
> @@ -1184,16 +1184,6 @@ PCIBus *gt64120_register(qemu_irq *pic)
>      return phb->bus;
>  }
> =20
> -static int gt64120_init(SysBusDevice *dev)
> -{
> -    GT64120State *s;
> -
> -    s =3D GT64120_PCI_HOST_BRIDGE(dev);
> -
> -    qemu_register_reset(gt64120_reset, s);
> -    return 0;
> -}
> -
>  static void gt64120_pci_realize(PCIDevice *d, Error **errp)
>  {
>      /* FIXME: Malta specific hw assumptions ahead */
> @@ -1241,9 +1231,8 @@ static const TypeInfo gt64120_pci_info =3D {
>  static void gt64120_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *sdc =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    sdc->init =3D gt64120_init;
> +    dc->reset =3D gt64120_reset;
>      dc->vmsd =3D &vmstate_gt64120;
>  }
> =20
>=20
