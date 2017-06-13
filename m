Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dKeNM-0001IZ-Fs
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 01:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dKeNJ-0006Nx-A6
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 01:28:24 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:58487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dKeNJ-0006Lp-0e
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 01:28:21 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6BBE14B6C8
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 07:28:17 +0200 (CEST)
References: <1496739312-32304-1-git-send-email-clg@kaod.org>
	<1496975205.23335.9.camel@aj.id.au>
	<bc98777b-e99d-3b55-3904-8f752a350b6c@kaod.org>
	<1497328676.11158.1.camel@aj.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <037b940c-a387-6d2e-b64b-ce22d1fe3d27@kaod.org>
Date: Tue, 13 Jun 2017 07:28:08 +0200
MIME-Version: 1.0
In-Reply-To: <1497328676.11158.1.camel@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] timer/aspeed: fix timer enablement when a
 reload is not set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/13/2017 06:37 AM, Andrew Jeffery wrote:
> On Fri, 2017-06-09 at 07:40 +0200, C=C3=A9dric Le Goater wrote:
>> On 06/09/2017 04:26 AM, Andrew Jeffery wrote:
>>> On Tue, 2017-06-06 at 10:55 +0200, C=C3=A9dric Le Goater wrote:
>>>> When a timer is enabled before a reload value is set, the controller
>>>> waits for a reload value to be set before starting decrementing. Thi=
s
>>>> fix tries to cover that case by changing the timer expiry only when
>>>> a reload value is valid.
>>>>
>>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>
>>>> ---
>>>>  hw/timer/aspeed_timer.c | 37 +++++++++++++++++++++++++++++--------
>>>>  1 file changed, 29 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
>>>> index 9b70ee09b07f..50acbf530a3a 100644
>>>> --- a/hw/timer/aspeed_timer.c
>>>> +++ b/hw/timer/aspeed_timer.c
>>>> @@ -130,15 +130,26 @@ static uint64_t calculate_next(struct AspeedTi=
mer *t)
>>>>              next =3D seq[1];
>>>>          } else if (now < seq[2]) {
>>>>              next =3D seq[2];
>>>> -        } else {
>>>> +        } else if (t->reload) {
>>>>              reload_ns =3D muldiv64(t->reload, NANOSECONDS_PER_SECON=
D, rate);
>>>>              t->start =3D now - ((now - t->start) % reload_ns);
>>>> +        } else {
>>>> +            /* no reload value, return 0 */
>>>> +            break;
>>>>          }
>>>>      }
>>>> =20
>>>>      return next;
>>>>  }
>>>> =20
>>>> +static void aspeed_timer_mod(AspeedTimer *t)
>>>> +{
>>>> +    uint64_t next =3D calculate_next(t);
>>>> +    if (next) {
>>>> +        timer_mod(&t->timer, next);
>>>> +    }
>>>> +}
>>>> +
>>>>  static void aspeed_timer_expire(void *opaque)
>>>>  {
>>>>      AspeedTimer *t =3D opaque;
>>>> @@ -164,7 +175,7 @@ static void aspeed_timer_expire(void *opaque)
>>>>          qemu_set_irq(t->irq, t->level);
>>>>      }
>>>> =20
>>>> -    timer_mod(&t->timer, calculate_next(t));
>>>> +    aspeed_timer_mod(t);
>>>>  }
>>>> =20
>>>>  static uint64_t aspeed_timer_get_value(AspeedTimer *t, int reg)
>>>> @@ -227,10 +238,23 @@ static void aspeed_timer_set_value(AspeedTimer=
CtrlState *s, int timer, int reg,
>>>>                                     uint32_t value)
>>>>  {
>>>>      AspeedTimer *t;
>>>> +    uint32_t old_reload;
>>>> =20
>>>>      trace_aspeed_timer_set_value(timer, reg, value);
>>>>      t =3D &s->timers[timer];
>>>>      switch (reg) {
>>>> +    case TIMER_REG_RELOAD:
>>>> +        old_reload =3D t->reload;
>>>> +        t->reload =3D value;
>>>> +
>>>> +        /* If the reload value was not previously set, or zero, and
>>>> +         * the current value is valid, try to start the timer if it=
 is
>>>> +         * enabled.
>>>> +         */
>>>> +        if (old_reload || !t->reload) {
>>>> +            break;
>>>> +        }
>>>
>>> Maybe I need more caffeine, but I initially struggled to reconcile th=
e
>>> condition with the comment, as the condition checks the inverse in
>>> order to break while the comment discusses the non-breaking case.=20
>>
>> I agree. The reload "value" is used in a hidden way to the activate th=
e=20
>> timer.
>>
>>> However, after trying for several minutes, I'm not sure there's an ea=
sy
>>> way to improve it.
>>
>> I tried a few things. May be, we could move the following code in=20
>> its own routine and call it twice ?=20
>=20
> I don't think it's necessary. The comment serves as enough warning - it
> should at least make people think before modifying the code.

OK. Let it be.


Peter,=20

The Moxa Art timer driver was recently merged into the Faraday=20
FTTMR010 driver and the initial setup is slightly different,=20
it enables the timer before setting the reload value, which=20
breaks the current QEMU model.

Thanks,

C.=20


> Cheers,
>=20
> Andrew
>=20
>> =20
>>>> +
>>>>      case TIMER_REG_STATUS:
>>>>          if (timer_enabled(t)) {
>>>>              uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>>> @@ -238,17 +262,14 @@ static void aspeed_timer_set_value(AspeedTimer=
CtrlState *s, int timer, int reg,
>>>>              uint32_t rate =3D calculate_rate(t);
>>>> =20
>>>>              t->start +=3D muldiv64(delta, NANOSECONDS_PER_SECOND, r=
ate);
>>>> -            timer_mod(&t->timer, calculate_next(t));
>>>> +            aspeed_timer_mod(t);
>>>>          }
>>>>          break;
>>>> -    case TIMER_REG_RELOAD:
>>>> -        t->reload =3D value;
>>>> -        break;
>>>>      case TIMER_REG_MATCH_FIRST:
>>>>      case TIMER_REG_MATCH_SECOND:
>>>>          t->match[reg - 2] =3D value;
>>>>          if (timer_enabled(t)) {
>>>> -            timer_mod(&t->timer, calculate_next(t));
>>>> +            aspeed_timer_mod(t);
>>>>          }
>>>>          break;
>>>>      default:
>>>> @@ -268,7 +289,7 @@ static void aspeed_timer_ctrl_enable(AspeedTimer=
 *t, bool enable)
>>>>      trace_aspeed_timer_ctrl_enable(t->id, enable);
>>>>      if (enable) {
>>>>          t->start =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>>> -        timer_mod(&t->timer, calculate_next(t));
>>>> +        aspeed_timer_mod(t);
>>>>      } else {
>>>>          timer_del(&t->timer);
>>>>      }
>>>
>>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>>
>> Thanks,
>>
>> C.
