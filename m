Received: from eggs.gnu.org ([2001:4830:134:3::10]:42957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fd9Rn-0005Dm-Dv
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fd9Rm-0004Z7-Dt
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:21:59 -0400
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
	<5d0c7195-ffbf-1618-6106-ef6c82df3bd7@redhat.com>
	<CAFEAcA9GspXJg2ioLrCknBgYHJ9f6qvM=n=y0dLeU12yv_5ETA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <931c0545-e3d8-fc84-9b69-59fab040265c@redhat.com>
Date: Wed, 11 Jul 2018 09:21:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9GspXJg2ioLrCknBgYHJ9f6qvM=n=y0dLeU12yv_5ETA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 10.07.2018 08:50, Peter Maydell wrote:
> On 9 July 2018 at 23:03, Thomas Huth <thuth@redhat.com> wrote:
>> On 09.07.2018 23:42, Peter Maydell wrote:
>>> On 9 July 2018 at 22:03, Thomas Huth <thuth@redhat.com> wrote:
>>>> When trying to "device_add bcm2837" on a machine that is not suitable for
>>>> this device, you can quickly crash QEMU afterwards, e.g. with "info qtree":
>>>>
>>>> echo "{'execute':'qmp_capabilities'} {'execute':'device_add', " \
>>>>  "'arguments':{'driver':'bcm2837'}} {'execute': 'human-monitor-command', " \
>>>>  "'arguments': {'command-line': 'info qtree'}}" | \
>>>>  aarch64-softmmu/qemu-system-aarch64 -M integratorcp,accel=qtest -S -qmp stdio
>>>>
>>>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
>>>>  "package": "build-all"}, "capabilities": []}}
>>>> {"return": {}}
>>>> {"error": {"class": "GenericError", "desc": "Device 'bcm2837' can not be
>>>>  hotplugged on this machine"}}
>>>> Segmentation fault (core dumped)
>>>>
>>>> The problem is that qdev_set_parent_bus() from instance_init adds a link
>>>> to the child devices which is not valid anymore after the device init
>>>> failed. Thus the qdev_set_parent_bus() must rather be done in the realize
>>>> function instead.
>>>
>>> Yuck. The real problem here is that we're still requiring the
>>> code that creates these QOM devices to manually set the parent
>>> in the first place. It's not surprising that we don't get it right
>>> (either parenting in the wrong place or not at all). I'd much
>>> rather see us fix that properly than keep papering over places
>>> where we get it wrong.
>>
>> Sorry, I'm still not an expert in all this QOM stuff yet ... so what do
>> you exactly recommend to do instead?
> 
> I'm not clear either, but I don't think that what we're
> currently doing can be right.

Hm, ok, so how to continue here now? Shall we at least mark the
bcm2836/7 devices with user_creatable=false, so that users can not crash
their QEMU so easily with device_add? The problem with introspection via
device-list-properties would still continue to exist, but I think that's
less likely used in practice... otherwise we could still move the
qdev_set_parent_bus() calls to the realize() function instead, and just
add a big fat FIXME comment in front of the code block, so that we
remember to clean that up one day...

 Thomas
