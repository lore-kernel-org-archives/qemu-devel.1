Received: from eggs.gnu.org ([209.51.188.92]:51110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hEmhS-0008J3-MI
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hEmhR-0000k4-Nz
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:17:58 -0400
MIME-Version: 1.0
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-2-joel@jms.id.au>
	<CAFEAcA_K1Rv1G-s=ndVYX6i_BvWME6ToShL6ZBpB4gnE3zdZdA@mail.gmail.com>
	<89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
In-Reply-To: <89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 12 Apr 2019 03:17:40 +0000
Message-ID: <CACPK8Xc_WeP3xuimjTBFRArteecikin9Qj8ZoCW-J2qBY4C=5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: timer: Add ASPEED RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Thanks for the review Peter and Cedric.

On Thu, 11 Apr 2019 at 15:30, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 4/11/19 5:25 PM, Peter Maydell wrote:
> >> +
> >> +#define COUNTER1        (0x00 / 4)
> >> +#define COUNTER2        (0x04 / 4)
> >> +#define ALARM           (0x08 / 4)
> >> +#define CONTROL         (0x10 / 4)
> >> +#define ALARM_STATUS    (0x14 / 4)
> >
> > Not mandatory, but you might like the REG32() macro in
> > hw/registerfields.h which defines A_FOO and R_FOO
> > constants for you for the addresses and the indexes.
>
> Yes. May be we should start using these macros in all our models.

I don't like them as you can no longer jump between the definition and
the use of the defines.

>
> >
> >> +
> >> +#define RTC_UNLOCKED    BIT(1)
> >> +#define RTC_ENABLED     BIT(0)
> >> +
> >> +static void aspeed_rtc_calc_offset(AspeedRtcState *rtc)
> >> +{
> >> +    struct tm tm;
> >> +    uint32_t year, cent;
> >> +    uint32_t reg1 =3D rtc->reg[COUNTER1];
> >> +    uint32_t reg2 =3D rtc->reg[COUNTER2];
> >> +
> >> +    tm.tm_mday =3D (reg1 >> 24) & 0x1f;
> >> +    tm.tm_hour =3D (reg1 >> 16) & 0x1f;
> >> +    tm.tm_min =3D (reg1 >> 8) & 0x3f;
> >> +    tm.tm_sec =3D (reg1 >> 0) & 0x3f;
> >
> > Shift by zero ?
> >
> > Consider using extract32() rather than by-hand shift and mask.

I looked at these and found them more confusing than writing what was
actually happening.

This code came from the Linux kernel driver, which I wrote, so I know
it's correct. The shift by zero is there to follow the pattern of the
code proceeding it, again to stop mistakes.

If we require using these helper macros then I can make the change. If
it's optional then I would prefer to leave it as is.

>
> What about the FIELD*() macros in hw/registerfields.h ?
>

> >> +static void aspeed_rtc_class_init(ObjectClass *klass, void *data)
> >> +{
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +
> >> +    dc->realize =3D aspeed_rtc_realize;
> >
> > This is missing a reset function and vmstate.

Ok, I can add those.

vmstate and migration is a foreign concept for the small ARM machines.
As well as being a developer, I am an end user of Qemu for them (the
aspeeds, microbit), and the use case is to boot up a firmware and
check that it does correct thing. I've never considered saving the
state and resming it, and can't think of a situation where that would
be done.

If we're adding it for consistency then I understand. I don't think it
sees any testing though.

Cheers,

Joel
