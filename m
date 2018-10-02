Received: from eggs.gnu.org ([2001:4830:134:3::10]:54254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1g7Ist-0003rK-8p
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1g7Iss-0008Q7-8v
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:30:35 -0400
Received: from mail-it1-x133.google.com ([2607:f8b0:4864:20::133]:39274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1g7Iss-0008PD-09
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:30:34 -0400
Received: by mail-it1-x133.google.com with SMTP id w200-v6so3074178itc.4
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 04:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-3-f4bug@amsat.org>
In-Reply-To: <20181001220942.2382-3-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 2 Oct 2018 13:30:22 +0200
Message-ID: <CACXAS8BnJAoJ3_Pvx=CFu6=SPT3S8wVxdQmHvgDbnVQzHJGPvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/15] hw/timer/sun4v-rtc: Convert from
 DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, clg@kaod.org, qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Oct 2, 2018 at 12:10 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/timer/sun4v-rtc.c  | 13 +++----------
>  hw/timer/trace-events |  4 ++++
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
> index 310523225f..13be94f8da 100644
> --- a/hw/timer/sun4v-rtc.c
> +++ b/hw/timer/sun4v-rtc.c
> @@ -14,15 +14,8 @@
>  #include "hw/sysbus.h"
>  #include "qemu/timer.h"
>  #include "hw/timer/sun4v-rtc.h"
> +#include "trace.h"
>
> -//#define DEBUG_SUN4V_RTC
> -
> -#ifdef DEBUG_SUN4V_RTC
> -#define DPRINTF(fmt, ...)                                       \
> -    do { printf("sun4v_rtc: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while (0)
> -#endif
>
>  #define TYPE_SUN4V_RTC "sun4v_rtc"
>  #define SUN4V_RTC(obj) OBJECT_CHECK(Sun4vRtc, (obj), TYPE_SUN4V_RTC)
> @@ -41,14 +34,14 @@ static uint64_t sun4v_rtc_read(void *opaque, hwaddr a=
ddr,
>          /* accessing the high 32 bits */
>          val >>=3D 32;
>      }
> -    DPRINTF("read from " TARGET_FMT_plx " val %lx\n", addr, val);
> +    trace_sun4v_rtc_read(addr, val);
>      return val;
>  }
>
>  static void sun4v_rtc_write(void *opaque, hwaddr addr,
>                               uint64_t val, unsigned size)
>  {
> -    DPRINTF("write 0x%x to " TARGET_FMT_plx "\n", (unsigned)val, addr);
> +    trace_sun4v_rtc_read(addr, val);
>  }
>
>  static const MemoryRegionOps sun4v_rtc_ops =3D {
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index ca9ad6321a..75bd3b1042 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -66,5 +66,9 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t data=
, unsigned size) "CMSDK A
>  cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size)=
 "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %=
u"
>  cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
>
> +# hw/timer/sun4v-rtc.c
> +sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " =
value 0x%" PRIx64
> +sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 =
" value 0x%" PRIx64
> +
>  # hw/timer/xlnx-zynqmp-rtc.c
>  xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min,=
 int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
> --
> 2.19.0
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
