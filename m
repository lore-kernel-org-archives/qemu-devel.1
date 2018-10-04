Received: from eggs.gnu.org ([2001:4830:134:3::10]:43469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g83iE-0002OD-0d
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g83i7-0000d5-UB
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:30:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g83i7-0000aZ-KQ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:30:35 -0400
References: <20180928135003.8650-1-clg@kaod.org>
	<20180928135003.8650-5-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <863c5fa6-0122-b470-ea6d-f86c6f3fe0d8@redhat.com>
Date: Thu, 4 Oct 2018 15:30:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180928135003.8650-5-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/11] net: lance: convert SysBus init
 method to a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 2018-09-28 15:49, C=C3=A9dric Le Goater wrote:
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/net/lance.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/net/lance.c b/hw/net/lance.c
> index a08d5ac6a848..f987b2fd180f 100644
> --- a/hw/net/lance.c
> +++ b/hw/net/lance.c
> @@ -97,9 +97,9 @@ static const VMStateDescription vmstate_lance =3D {
>      }
>  };
> =20
> -static int lance_init(SysBusDevice *sbd)
> +static void lance_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      SysBusPCNetState *d =3D SYSBUS_PCNET(dev);
>      PCNetState *s =3D &d->state;
> =20
> @@ -115,7 +115,6 @@ static int lance_init(SysBusDevice *sbd)
>      s->phys_mem_read =3D ledma_memory_read;
>      s->phys_mem_write =3D ledma_memory_write;
>      pcnet_common_init(dev, s, &net_lance_info);
> -    return 0;
>  }
> =20
>  static void lance_reset(DeviceState *dev)
> @@ -144,9 +143,8 @@ static Property lance_properties[] =3D {
>  static void lance_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D lance_init;
> +    dc->realize =3D lance_realize;
>      set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
>      dc->fw_name =3D "ethernet";
>      dc->reset =3D lance_reset;
>=20

Tested-by: Thomas Huth <thuth@redhat.com>
