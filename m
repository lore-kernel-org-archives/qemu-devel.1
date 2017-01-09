Received: from eggs.gnu.org ([2001:4830:134:3::10]:51612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQVxI-0001sq-CT
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQVxF-000721-7G
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:09:28 -0500
Received: from [45.249.212.187] (port=2518 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQVxE-0006nA-DS
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:09:25 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 9 Jan 2017 09:08:50 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA180CB2@DGGEMA505-MBX.china.huawei.com>
References: <20161219060336.10176-1-hangaohuai@huawei.com>
In-Reply-To: <20161219060336.10176-1-hangaohuai@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4] bugfix: vm halt when in reset looping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hangaohuai <hangaohuai@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

>
> From: Hangaohuai
> Sent: Monday, December 19, 2016 2:04 PM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; pbonzini@redhat.com; Gonglei (Arei); Hangaohuai
> Subject: [PATCH v4] bugfix: vm halt when in reset looping
>=20
> reset mc146818rtc device when RESET event happens.
>=20
> Fix the problem:
>   1. Guest boot the second cpu, set CMOS_RESET_CODE 0x0a to protect
> selfboot;
>   2. VM being reset by others, hmp_system_reset;
>   3. seabios resume check the CMOS_RESET_CODE, if 0x0a, jump to the BDA
>      resume execution by jump via 40h:0067h;
>   4. Guest halt;
>=20
> Signed-off-by: hangaohuai <hangaohuai@huawei.com>
> ---
>  hw/timer/mc146818rtc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Paolo, could you pls pick up this patch?

Thanks,
-Gonglei

> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index da209d0..637f872 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -946,11 +946,23 @@ static Property mc146818rtc_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20
> +static void rtc_resetdev(DeviceState *d)
> +{
> +    RTCState *s =3D MC146818_RTC(d);
> +
> +    /* Reason: VM do suspend self will set 0xfe
> +     * Reset any values other than 0xfe(Guest suspend case) */
> +    if (s->cmos_data[0x0f] !=3D 0xfe) {
> +        s->cmos_data[0x0f] =3D 0x00;
> +    }
> +}
> +
>  static void rtc_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>=20
>      dc->realize =3D rtc_realizefn;
> +    dc->reset =3D rtc_resetdev;
>      dc->vmsd =3D &vmstate_rtc;
>      dc->props =3D mc146818rtc_properties;
>      /* Reason: needs to be wired up by rtc_init() */
> --
> 1.8.3.1
>=20
