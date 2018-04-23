Received: from eggs.gnu.org ([2001:4830:134:3::10]:40631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAXrv-0006CT-Og
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAXru-0002cc-Sc
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:34:43 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:36146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAXru-0002cJ-O3
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:34:42 -0400
Received: by mail-oi0-x232.google.com with SMTP id h11-v6so13640915oic.3
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 02:34:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53691cbf-08bf-e3f7-22d3-601a279aa08a@kaod.org>
References: <20180423064020.25434-1-clg@kaod.org>
	<CAFEAcA-LtNpGTV08jvK4i5C5i64WjM5gMB4zGr8P4fkVSkNH7g@mail.gmail.com>
	<53691cbf-08bf-e3f7-22d3-601a279aa08a@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 10:34:21 +0100
Message-ID: <CAFEAcA9XBHE5YxN27M1ugprmSf=o5iiNakO2omrY+HBgCszV5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] timer/aspeed: fix vmstate version id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

On 23 April 2018 at 10:28, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 04/23/2018 11:12 AM, Peter Maydell wrote:
>>> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
>>> index 50acbf530a3a..7df19bd9df91 100644
>>> --- a/hw/timer/aspeed_timer.c
>>> +++ b/hw/timer/aspeed_timer.c
>>> @@ -498,8 +498,8 @@ static const VMStateDescription vmstate_aspeed_time=
r =3D {
>>>
>>>  static const VMStateDescription vmstate_aspeed_timer_state =3D {
>>>      .name =3D "aspeed.timerctrl",
>>> -    .version_id =3D 1,
>>> -    .minimum_version_id =3D 1,
>>> +    .version_id =3D 2,
>>> +    .minimum_version_id =3D 2,
>>>      .fields =3D (VMStateField[]) {
>>>          VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
>>>          VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),
>> Wouldn't it be simpler to just fix the incorrect value in
>> the VMSTATE_STRUCT_ARRAY(timers, AspeedTimerCtrlState,
>> line ?
>
> Yes. Also.
>
> Or bring back all the version ids to 1, as we never supported
> migration before.

I think it's nice to at least do the "bump version" thing, so you
get a (hopefully comprehensible) error rather than just wrong
data if you do try a cross version migration, so I would
vote for just fixing the one thing that was wrong: the
number in VMSTATE_STRUCT_ARRAY is the version to be used of
the substruct, so it didn't need to be bumped in commit
1d3e65aa7a; the main version numbers for vmstate_aspeed_timer
did need to be bumped because part of the main struct changed.

thanks
-- PMM
