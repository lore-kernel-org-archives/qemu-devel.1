Received: from eggs.gnu.org ([2001:4830:134:3::10]:34494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eX6Xs-0001R2-0r
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eX6Xd-00037z-A4
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:31:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eX6Xc-00034z-Qs
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:30:45 -0500
References: <20171229142922.31701-1-hpoussin@reactos.org>
	<20171229142922.31701-5-hpoussin@reactos.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <48e5c12c-d598-4917-5c59-e0017ed52ffa@redhat.com>
Date: Thu, 4 Jan 2018 16:30:34 +0200
MIME-Version: 1.0
In-Reply-To: <20171229142922.31701-5-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/16] mc146818rtc: always register rtc
 to rtc list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 29/12/2017 16:29, Herv=C3=A9 Poussineau wrote:
> We are not required anymore to use rtc_init() function.
>=20
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>   hw/timer/mc146818rtc.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 3e8c0b7d33..0b0da691cc 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -905,6 +905,13 @@ static void rtc_get_date(Object *obj, struct tm *c=
urrent_tm, Error **errp)
>       rtc_get_time(s, current_tm);
>   }
>  =20
> +static int rtc_initfn(DeviceState *dev)
> +{
> +    RTCState *s =3D MC146818_RTC(dev);
> +    QLIST_INSERT_HEAD(&rtc_devices, s, link);
> +    return 0;
> +}
> +
>   static void rtc_realizefn(DeviceState *dev, Error **errp)
>   {
>       ISADevice *isadev =3D ISA_DEVICE(dev);
> @@ -973,11 +980,9 @@ ISADevice *mc146818_rtc_init(ISABus *bus, int base=
_year, qemu_irq intercept_irq)
>   {
>       DeviceState *dev;
>       ISADevice *isadev;
> -    RTCState *s;
>  =20
>       isadev =3D isa_create(bus, TYPE_MC146818_RTC);
>       dev =3D DEVICE(isadev);
> -    s =3D MC146818_RTC(isadev);
>       qdev_prop_set_int32(dev, "base_year", base_year);
>       qdev_init_nofail(dev);
>       if (intercept_irq) {
> @@ -985,7 +990,6 @@ ISADevice *mc146818_rtc_init(ISABus *bus, int base_=
year, qemu_irq intercept_irq)
>       } else {
>           isa_connect_gpio_out(isadev, 0, RTC_ISA_IRQ);
>       }
> -    QLIST_INSERT_HEAD(&rtc_devices, s, link);
>  =20
>       return isadev;
>   }
> @@ -1012,12 +1016,11 @@ static void rtc_class_initfn(ObjectClass *klass=
, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
> +    dc->init =3D rtc_initfn;

I am not sure you want to use dc->init function.

I think you need TypeInfo's instance_init.

Thanks,
Marcel

>       dc->realize =3D rtc_realizefn;
>       dc->reset =3D rtc_resetdev;
>       dc->vmsd =3D &vmstate_rtc;
>       dc->props =3D mc146818rtc_properties;
> -    /* Reason: needs to be wired up by rtc_init() */
> -    dc->user_creatable =3D false;
>   }
>  =20
>   static void rtc_finalize(Object *obj)
>=20
