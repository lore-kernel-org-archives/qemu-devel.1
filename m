Received: from eggs.gnu.org ([2001:4830:134:3::10]:54583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdbVo-0005wT-Lu
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdbVn-0000sq-FP
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:20:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
	<5d0c7195-ffbf-1618-6106-ef6c82df3bd7@redhat.com>
	<CAFEAcA9GspXJg2ioLrCknBgYHJ9f6qvM=n=y0dLeU12yv_5ETA@mail.gmail.com>
	<931c0545-e3d8-fc84-9b69-59fab040265c@redhat.com>
	<20180711161216.GV7451@localhost.localdomain>
	<CAFEAcA-3aBQPwiwDfZSjspiwv4L-U0LXBKaOQ2m+=OzhqRq3OQ@mail.gmail.com>
	<87y3egmzem.fsf@dusky.pond.sub.org>
	<CAFEAcA-RwRdgr-_YVwEWf0pSNQj_rdEmX_OZf5HFmNoR8LbthA@mail.gmail.com>
Date: Thu, 12 Jul 2018 15:19:50 +0200
In-Reply-To: <CAFEAcA-RwRdgr-_YVwEWf0pSNQj_rdEmX_OZf5HFmNoR8LbthA@mail.gmail.com>
	(Peter Maydell's message of "Thu, 12 Jul 2018 13:55:49 +0100")
Message-ID: <87efg8lhft.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 12 July 2018 at 13:06, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On 11 July 2018 at 17:12, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>> On Wed, Jul 11, 2018 at 09:21:48AM +0200, Thomas Huth wrote:
>>>>> Hm, ok, so how to continue here now? Shall we at least mark the
>>>>> bcm2836/7 devices with user_creatable=false, so that users can not crash
>>>>> their QEMU so easily with device_add? The problem with introspection via
>>>>> device-list-properties would still continue to exist, but I think that's
>>>>> less likely used in practice... otherwise we could still move the
>>>>> qdev_set_parent_bus() calls to the realize() function instead, and just
>>>>> add a big fat FIXME comment in front of the code block, so that we
>>>>> remember to clean that up one day...
>>>>
>>>> Crashing device-list-properties should be a blocker bug, IMO.
>>
>> Seconded.
>>
>>>> Moving to realize is not the best solution, but I would prefer to
>>>> do that in 3.0 instead of leaving the device-list-properties
>>>> crash unfixed.
>>>
>>> I would like to see the crash fixed too. But I'd like to
>>> see it fixed:
>>>  (a) by having clear documentation about how the QOM
>>> system works, what you should do in init and what you
>>> should do in realize, when and why you need to manually
>>> parent objects, etc
>>>  (b) as far as possible making our APIs for doing this
>>> easy to use correctly and difficult to use wrongly. At
>>> the moment we have APIs that are far too easy to misuse,
>>> which means we will continue to get bugs like this and spend
>>> a lot of time on one-off fixes for them.
>>>
>>> In particular I don't understand why we need to manually
>>> parent these objects at all.
>>
>> I want both (a) and (b) as badly as anyone, but we should not hold any
>> particular crash bug hostage to get them.
>
> Without at least (a) I can't review this patch or any other
> patch that fixes this kind of crash bug...

Fair point.  But if Paolo can, and vouches for a fix, then we shouldn't
hold the fix hostage.
