Received: from eggs.gnu.org ([2001:4830:134:3::10]:38484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqp2f-0004lR-0T
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqp2d-0002Os-Rt
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:52:17 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqp2d-0002OP-Fu
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:52:15 -0500
Received: by mail-wr0-x242.google.com with SMTP id u49so533148wrc.10
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 15:52:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1519755964.git.alistair.francis@xilinx.com>
	<5df08e2ebca98ec9a589fbdb939f2413b27b2156.1519755964.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4c025860-0bd3-681e-fecf-dbcf101a8927@amsat.org>
Date: Tue, 27 Feb 2018 20:52:11 -0300
MIME-Version: 1.0
In-Reply-To: <5df08e2ebca98ec9a589fbdb939f2413b27b2156.1519755964.git.alistair.francis@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="dcvX40QkXC5HUVgwWISYGQDpZaxA7S8ME"
Subject: Re: [Qemu-devel] [PATCH v7 2/3] xlnx-zynqmp-rtc: Add basic time
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dcvX40QkXC5HUVgwWISYGQDpZaxA7S8ME
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Cc: alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Message-ID: <4c025860-0bd3-681e-fecf-dbcf101a8927@amsat.org>
Subject: Re: [PATCH v7 2/3] xlnx-zynqmp-rtc: Add basic time support
References: <cover.1519755964.git.alistair.francis@xilinx.com>
 <5df08e2ebca98ec9a589fbdb939f2413b27b2156.1519755964.git.alistair.francis@xilinx.com>
In-Reply-To: <5df08e2ebca98ec9a589fbdb939f2413b27b2156.1519755964.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2018 03:52 PM, Alistair Francis wrote:
> Allow the guest to determine the time set from the QEMU command line.
>=20
> This includes adding a trace event to debug the new time.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
> V7:
>  - Make the current_tm local to init
> V6:
>  - Migrate tick_offset and add a pre_save call
> V5:
>  - Recalculate tick_offset after migration
> V4:
>  - Use the .unimp property
> V3:
>  - Store an offset value
>  - Use mktimegm()
>  - Log unimplemented writes
> V2:
>  - Convert DB_PRINT() macro to trace
>=20
>  include/hw/timer/xlnx-zynqmp-rtc.h |  2 ++
>  hw/timer/xlnx-zynqmp-rtc.c         | 58 ++++++++++++++++++++++++++++++=
++++++++
>  hw/timer/trace-events              |  3 ++
>  3 files changed, 63 insertions(+)
>=20
> diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx=
-zynqmp-rtc.h
> index 87649836cc..5ba4d8bc4a 100644
> --- a/include/hw/timer/xlnx-zynqmp-rtc.h
> +++ b/include/hw/timer/xlnx-zynqmp-rtc.h
> @@ -79,6 +79,8 @@ typedef struct XlnxZynqMPRTC {
>      qemu_irq irq_rtc_int;
>      qemu_irq irq_addr_error_int;
> =20
> +    uint32_t tick_offset;
> +
>      uint32_t regs[XLNX_ZYNQMP_RTC_R_MAX];
>      RegisterInfo regs_info[XLNX_ZYNQMP_RTC_R_MAX];
>  } XlnxZynqMPRTC;
> diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
> index 707f145027..c98dc3d94e 100644
> --- a/hw/timer/xlnx-zynqmp-rtc.c
> +++ b/hw/timer/xlnx-zynqmp-rtc.c
> @@ -29,6 +29,10 @@
>  #include "hw/register.h"
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
> +#include "hw/ptimer.h"
> +#include "qemu/cutils.h"
> +#include "sysemu/sysemu.h"
> +#include "trace.h"
>  #include "hw/timer/xlnx-zynqmp-rtc.h"
> =20
>  #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
> @@ -47,6 +51,19 @@ static void addr_error_int_update_irq(XlnxZynqMPRTC =
*s)
>      qemu_set_irq(s->irq_addr_error_int, pending);
>  }
> =20
> +static uint32_t rtc_get_count(XlnxZynqMPRTC *s)
> +{
> +    int64_t now =3D qemu_clock_get_ns(rtc_clock);
> +    return s->tick_offset + now / NANOSECONDS_PER_SECOND;
> +}
> +
> +static uint64_t current_time_postr(RegisterInfo *reg, uint64_t val64)
> +{
> +    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
> +
> +    return rtc_get_count(s);
> +}
> +
>  static void rtc_int_status_postw(RegisterInfo *reg, uint64_t val64)
>  {
>      XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
> @@ -97,13 +114,17 @@ static uint64_t addr_error_int_dis_prew(RegisterIn=
fo *reg, uint64_t val64)
> =20
>  static const RegisterAccessInfo rtc_regs_info[] =3D {
>      {   .name =3D "SET_TIME_WRITE",  .addr =3D A_SET_TIME_WRITE,
> +        .unimp =3D MAKE_64BIT_MASK(0, 32),
>      },{ .name =3D "SET_TIME_READ",  .addr =3D A_SET_TIME_READ,
>          .ro =3D 0xffffffff,
> +        .post_read =3D current_time_postr,
>      },{ .name =3D "CALIB_WRITE",  .addr =3D A_CALIB_WRITE,
> +        .unimp =3D MAKE_64BIT_MASK(0, 32),
>      },{ .name =3D "CALIB_READ",  .addr =3D A_CALIB_READ,
>          .ro =3D 0x1fffff,
>      },{ .name =3D "CURRENT_TIME",  .addr =3D A_CURRENT_TIME,
>          .ro =3D 0xffffffff,
> +        .post_read =3D current_time_postr,
>      },{ .name =3D "CURRENT_TICK",  .addr =3D A_CURRENT_TICK,
>          .ro =3D 0xffff,
>      },{ .name =3D "ALARM",  .addr =3D A_ALARM,
> @@ -162,6 +183,7 @@ static void rtc_init(Object *obj)
>      XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>      RegisterInfoArray *reg_array;
> +    struct tm current_tm;
> =20
>      memory_region_init(&s->iomem, obj, TYPE_XLNX_ZYNQMP_RTC,
>                         XLNX_ZYNQMP_RTC_R_MAX * 4);
> @@ -178,14 +200,50 @@ static void rtc_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->iomem);
>      sysbus_init_irq(sbd, &s->irq_rtc_int);
>      sysbus_init_irq(sbd, &s->irq_addr_error_int);
> +
> +    qemu_get_timedate(&current_tm, 0);
> +    s->tick_offset =3D mktimegm(&current_tm) -
> +        qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
> +
> +    trace_xlnx_zynqmp_rtc_gettime(current_tm.tm_year, current_tm.tm_mo=
n,
> +                                  current_tm.tm_mday, current_tm.tm_ho=
ur,
> +                                  current_tm.tm_min, current_tm.tm_sec=
);
> +}
> +
> +static int rtc_pre_save(void *opaque)
> +{
> +    XlnxZynqMPRTC *s =3D opaque;
> +    int64_t now =3D qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SEC=
OND;
> +
> +    /* Add the time at migration */
> +    s->tick_offset =3D s->tick_offset + now;
> +
> +    return 0;
> +}
> +
> +static int rtc_post_load(void *opaque, int version_id)
> +{
> +    XlnxZynqMPRTC *s =3D opaque;
> +    int64_t now =3D qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SEC=
OND;
> +
> +    /* Subtract the time after migration. This combined with the pre_s=
ave
> +     * action results in us having subtracted the time that the guest =
was
> +     * stopped to the offset.
> +     */
> +    s->tick_offset =3D s->tick_offset - now;
> +
> +    return 0;
>  }
> =20
>  static const VMStateDescription vmstate_rtc =3D {
>      .name =3D TYPE_XLNX_ZYNQMP_RTC,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> +    .pre_save =3D rtc_pre_save,
> +    .post_load =3D rtc_post_load,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPRTC, XLNX_ZYNQMP_RTC_R_MA=
X),
> +        VMSTATE_UINT32(tick_offset, XlnxZynqMPRTC),
>          VMSTATE_END_OF_LIST(),
>      }
>  };
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 640722b5d1..e6e042fddb 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -60,3 +60,6 @@ systick_write(uint64_t addr, uint32_t value, unsigned=
 size) "systick write addr
>  cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "C=
MSDK APB timer read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "=
CMSDK APB timer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"
> +
> +# hw/timer/xlnx-zynqmp-rtc.c
> +xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int mi=
n, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
>=20


--dcvX40QkXC5HUVgwWISYGQDpZaxA7S8ME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlqV7ysACgkQ4+MsLN6t
wN4Csw/9EKaSsfp7Dm4J8U5dB9Q0qyDUdbN5DSAUOVKnMa04Un72IuYw24Oz2rvJ
i/37whSCH1U1k9IKzVW7ejDUiADv4Jd3thIAjYC+cvHdgNE8exL8fwRntG7Zfnx+
CWU/JZUM838fBeUjrIFkk7vSFr1Tw1FHVFCzmll7IF71qmJQgnb0cdkW8MU9u43m
QUWPWoYE8fL5qGNvzYKzoWn8AmmqACRhmrRkS2mA6C/KX7KvhbtnADWHXzfWWSYP
3ozUBD2qkK+H6fpQ7IdjhRZLi+7f++1Eoouw+5FDc4M+UyMOzPOjNtUPxBd/5FtS
ghNW68HEIZ8a4+JF5div7xL2AqOZNkl9fyoV10RIKRKppqkNzbA3epw6SZqab7ts
hJ7hlmoEPliUiZMjnsgHk1qlaA20fnQivSaq4KTzOW6VUb0SV7mqkK3pQ8FhQm2w
2ELRsOE3VcmeIf3Nsbc7niO52wfTwsuctdcDZxYxkTjyFHfv/ZifE35pQcqrLaBL
Y36i2+YorTEZKD2JumlcTxkUdpnh54MbICsu1ElBDsM/iiHWSerkmb2eKjIviz7B
WlIQDpbeQmQ/70Z9vPdYOg1bmANofgSK25j0Orq/ud981zw7Y7KT9EY16jLoaEC4
mtXEnTvOs+kxnrH+1Y4QW9fHj+aLfXw09izQ5w+RubHQibDT0CU=
=zyYP
-----END PGP SIGNATURE-----

--dcvX40QkXC5HUVgwWISYGQDpZaxA7S8ME--
