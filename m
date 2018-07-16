Received: from eggs.gnu.org ([2001:4830:134:3::10]:39313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fexCA-0006H4-E5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 02:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fexC9-0005fV-Fc
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 02:41:18 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
	<5d0c7195-ffbf-1618-6106-ef6c82df3bd7@redhat.com>
	<CAFEAcA9GspXJg2ioLrCknBgYHJ9f6qvM=n=y0dLeU12yv_5ETA@mail.gmail.com>
	<931c0545-e3d8-fc84-9b69-59fab040265c@redhat.com>
	<20180711161216.GV7451@localhost.localdomain>
	<CAFEAcA-3aBQPwiwDfZSjspiwv4L-U0LXBKaOQ2m+=OzhqRq3OQ@mail.gmail.com>
	<87y3egmzem.fsf@dusky.pond.sub.org>
	<6cc1c007-4bdf-2b8c-b0b0-d32979a56ecd@redhat.com>
	<87muuwo2dz.fsf@dusky.pond.sub.org>
	<CAFEAcA9g0Vu-cF50maC2cVrSffZA5F6AsoM5pz2XT09YKG4WHg@mail.gmail.com>
	<585e3fa1-7d56-ccb8-0357-77597ca78fa8@redhat.com>
Date: Mon, 16 Jul 2018 08:41:10 +0200
In-Reply-To: <585e3fa1-7d56-ccb8-0357-77597ca78fa8@redhat.com> (Thomas Huth's
	message of "Thu, 12 Jul 2018 18:32:17 +0200")
Message-ID: <87in5fisxl.fsf@dusky.pond.sub.org>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 12.07.2018 18:22, Peter Maydell wrote:
>> On 12 July 2018 at 17:16, Markus Armbruster <armbru@redhat.com> wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> On 12.07.2018 14:06, Markus Armbruster wrote:
>>>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>>>
>>>>>> On 11 July 2018 at 17:12, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>>>>> On Wed, Jul 11, 2018 at 09:21:48AM +0200, Thomas Huth wrote:
>>>>>>>> Hm, ok, so how to continue here now? Shall we at least mark the
>>>>>>>> bcm2836/7 devices with user_creatable=false, so that users can not crash
>>>>>>>> their QEMU so easily with device_add? The problem with introspection via
>>>>>>>> device-list-properties would still continue to exist, but I think that's
>>>>>>>> less likely used in practice... otherwise we could still move the
>>>>>>>> qdev_set_parent_bus() calls to the realize() function instead, and just
>>>>>>>> add a big fat FIXME comment in front of the code block, so that we
>>>>>>>> remember to clean that up one day...
>>>>>>>
>>>>>>> Crashing device-list-properties should be a blocker bug, IMO.
>>>>>
>>>>> Seconded.
>>>>
>>>> Well, maybe I should then not suggest to add a hmp("info qtree") below
>>>> the hmp("info qom-tree") in test_one_device() of
>>>> tests/device-introspect-test.c ... otherwise we'll be quite busy in the
>>>> next weeks...
>>>
>>> If we can't fix these bugs in time, we can bring back
>>> cannot_destroy_with_object_finalize_yet, as Eduardo mentioned upthread.
>>> Would be sad, but sad beats crash.
>> 
>> ...but are they actually interesting crashes? Nobody is ever
>> going to actually start emulation of an integratorcp machine and
>> then try to add a bcm2837 device via the QMP interface, except
>> if they're deliberately doing exhaustive testing.
>
> It's not "device_add" that is a real problem here (otherwise we could
> simply use user_creatable=false which we likely should do for this
> device anyway), but rather the "device-list-properties" QMP command,
> which also works for devices that are marked as user_creatable=false.
>
> I think it's valid that an upper layer tool scans all devices for their
> properties. But since nobody complained about crashes in the past here
> already, it seems like no upper layer tool is currently doing this. So I
> agree with you that this should not be a blocker for the 3.0 release.

Fixing the crashes by bringing back
cannot_destroy_with_object_finalize_yet would be a bit of a cop out, but
it would also be so easy that there's really no excuse for leaving them
unfixed.
