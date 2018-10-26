Received: from eggs.gnu.org ([2001:4830:134:3::10]:33580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFxZO-00081K-3P
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFxZN-0004Ny-Ay
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:34:14 -0400
Date: Fri, 26 Oct 2018 05:27:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181026082741.GK4096@habkost.net>
References: <20181025133301.16578-1-ehabkost@redhat.com>
	<20181025133301.16578-6-ehabkost@redhat.com>
	<20181025171759.GG2697@umbus.hotspot.internet-for-guests.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181025171759.GG2697@umbus.hotspot.internet-for-guests.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 05/43] hw/timer/sun4v-rtc: Convert from
 DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, Oct 25, 2018 at 06:17:59PM +0100, David Gibson wrote:
> On Thu, Oct 25, 2018 at 10:32:23AM -0300, Eduardo Habkost wrote:
> > From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
> > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> > Message-Id: <20181002212522.23303-3-f4bug@amsat.org>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  hw/timer/sun4v-rtc.c  | 13 +++----------
> >  hw/timer/trace-events |  4 ++++
> >  2 files changed, 7 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
> > index 310523225f..13be94f8da 100644
> > --- a/hw/timer/sun4v-rtc.c
> > +++ b/hw/timer/sun4v-rtc.c
> > @@ -14,15 +14,8 @@
> >  #include "hw/sysbus.h"
> >  #include "qemu/timer.h"
> >  #include "hw/timer/sun4v-rtc.h"
> > +#include "trace.h"
> > =20
> > -//#define DEBUG_SUN4V_RTC
> > -
> > -#ifdef DEBUG_SUN4V_RTC
> > -#define DPRINTF(fmt, ...)                                       \
> > -    do { printf("sun4v_rtc: " fmt , ## __VA_ARGS__); } while (0)
> > -#else
> > -#define DPRINTF(fmt, ...) do {} while (0)
> > -#endif
> > =20
> >  #define TYPE_SUN4V_RTC "sun4v_rtc"
> >  #define SUN4V_RTC(obj) OBJECT_CHECK(Sun4vRtc, (obj), TYPE_SUN4V_RTC)
> > @@ -41,14 +34,14 @@ static uint64_t sun4v_rtc_read(void *opaque, hwad=
dr addr,
> >          /* accessing the high 32 bits */
> >          val >>=3D 32;
> >      }
> > -    DPRINTF("read from " TARGET_FMT_plx " val %lx\n", addr, val);
> > +    trace_sun4v_rtc_read(addr, val);
> >      return val;
> >  }
> > =20
> >  static void sun4v_rtc_write(void *opaque, hwaddr addr,
> >                               uint64_t val, unsigned size)
> >  {
> > -    DPRINTF("write 0x%x to " TARGET_FMT_plx "\n", (unsigned)val, add=
r);
> > +    trace_sun4v_rtc_read(addr, val);
>=20
> Uh.. as in v1, it looks like this should be trace_sun4v_rtc_write().

Oops, my bad.  I can fix this manually in case there's a v3 pull
request, but I would really prefer that to be included in a
follow up patch instead of making this block the entire pull
request.

--=20
Eduardo
