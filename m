Received: from eggs.gnu.org ([2001:4830:134:3::10]:40439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7GCL-0002B3-Ax
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7GCJ-0002y4-Hv
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:38:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g7GCI-0002wK-M7
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:38:27 -0400
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-4-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <65b6fcb2-30f2-e2ae-a4a5-b27a01bd6347@redhat.com>
Date: Tue, 2 Oct 2018 10:38:20 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/15] hw/timer/sun4v-rtc: Use
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
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On 2018-10-02 00:09, Philippe Mathieu-Daud=C3=A9 wrote:
> Move from the legacy SysBusDevice::init method to using DeviceState::re=
alize.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/timer/sun4v-rtc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
> index 13be94f8da..4e7f6a1eff 100644
> --- a/hw/timer/sun4v-rtc.c
> +++ b/hw/timer/sun4v-rtc.c
> @@ -63,21 +63,21 @@ void sun4v_rtc_init(hwaddr addr)
>      sysbus_mmio_map(s, 0, addr);
>  }
> =20
> -static int sun4v_rtc_init1(SysBusDevice *dev)
> +static void sun4v_rtc_realize(DeviceState *dev, Error **errp)
>  {
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      Sun4vRtc *s =3D SUN4V_RTC(dev);
> =20
>      memory_region_init_io(&s->iomem, OBJECT(s), &sun4v_rtc_ops, s,
>                            "sun4v-rtc", 0x08ULL);
> -    sysbus_init_mmio(dev, &s->iomem);
> -    return 0;
> +    sysbus_init_mmio(sbd, &s->iomem);
>  }
> =20
>  static void sun4v_rtc_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    k->init =3D sun4v_rtc_init1;
> +    dc->realize =3D sun4v_rtc_realize;
>  }
> =20
>  static const TypeInfo sun4v_rtc_info =3D {

Reviewed-by: Thomas Huth <thuth@redhat.com>
