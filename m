Received: from eggs.gnu.org ([2001:4830:134:3::10]:42589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvfD6-0002wK-6T
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvfD3-0000P0-0I
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:55:20 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:37661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fvfD2-0000Gc-Od
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:55:16 -0400
Received: from player693.ha.ovh.net (unknown [10.109.143.249])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 1FFD1D39D2
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 10:55:09 +0200 (CEST)
References: <20180622075700.5923-1-clg@kaod.org>
	<20180622075700.5923-4-clg@kaod.org>
	<fb6480f3-2c25-bcd1-9586-3ce45b82d6e1@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4348fb77-74ec-dd52-609d-fca0c9883ad1@kaod.org>
Date: Fri, 31 Aug 2018 10:55:00 +0200
MIME-Version: 1.0
In-Reply-To: <fb6480f3-2c25-bcd1-9586-3ce45b82d6e1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] aspeed/timer: use the APB frequency
 from the SCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Markus Armbruster <armbru@redhat.com>

On 08/31/2018 10:34 AM, Thomas Huth wrote:
> On 2018-06-22 09:57, C=C3=A9dric Le Goater wrote:
>> The timer controller can be driven by either an external 1MHz clock or
>> by the APB clock. Today, the model makes the assumption that the APB
>> frequency is always set to 24MHz but this is incorrect.
>>
>> The AST2400 SoC on the palmetto machines uses a 48MHz input clock
>> source and the APB can be set to 48MHz. The consequence is a general
>> system slowdown. The QEMU machines using the AST2500 SoC do not seem
>> impacted today because the APB frequency is still set to 24MHz.
>>
>> We fix the timer frequency for all SoCs by linking the Timer model to
>> the SCU model. The APB frequency driving the timers is now the one
>> configured for the SoC.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  include/hw/timer/aspeed_timer.h |  4 ++++
>>  hw/arm/aspeed_soc.c             |  2 ++
>>  hw/timer/aspeed_timer.c         | 19 +++++++++++++++----
>>  3 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed=
_timer.h
>> index bd6c1a7f9609..040a08873432 100644
>> --- a/include/hw/timer/aspeed_timer.h
>> +++ b/include/hw/timer/aspeed_timer.h
>> @@ -24,6 +24,8 @@
>> =20
>>  #include "qemu/timer.h"
>> =20
>> +typedef struct AspeedSCUState AspeedSCUState;
>> +
>>  #define ASPEED_TIMER(obj) \
>>      OBJECT_CHECK(AspeedTimerCtrlState, (obj), TYPE_ASPEED_TIMER);
>>  #define TYPE_ASPEED_TIMER "aspeed.timer"
>> @@ -55,6 +57,8 @@ typedef struct AspeedTimerCtrlState {
>>      uint32_t ctrl;
>>      uint32_t ctrl2;
>>      AspeedTimer timers[ASPEED_TIMER_NR_TIMERS];
>> +
>> +    AspeedSCUState *scu;
>>  } AspeedTimerCtrlState;
>=20
> This patch breaks compiling with clang 3.4.2 for me:
>=20
> In file included from /home/thuth/devel/qemu/hw/timer/aspeed_timer.c:16=
:
> /home/thuth/devel/qemu/include/hw/misc/aspeed_scu.h:37:3: error:
> redefinition of typedef 'AspeedSCUState' is a C11 feature
>       [-Werror,-Wtypedef-redefinition]
> } AspeedSCUState;
>   ^
> /home/thuth/devel/qemu/include/hw/timer/aspeed_timer.h:27:31: note:
> previous definition is here
> typedef struct AspeedSCUState AspeedSCUState;

Ah. Bummer. I will just include the file then.
                             =20
>=20
> I think you should not re-typedef here. Either include the right header=
,
> or use include/qemu/typedefs.h.

I didn't know this file existed. I am not sure to like this method.

>  Thomas
>=20
>=20
> PS: Did I already mention that I really dislike the typedeffing in QEMU=
?
>=20

It's a bit painful I agree.

Thanks,

C.=20
