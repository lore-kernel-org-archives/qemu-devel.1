Received: from eggs.gnu.org ([2001:4830:134:3::10]:56858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eihNl-0008A1-GI
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eihNh-0004PY-Ij
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:04:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eihNh-0004O9-DR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:04:25 -0500
References: <1517492876-28428-1-git-send-email-arei.gonglei@huawei.com>
	<d2f644da-e6c8-da3a-55e4-13ae69c44fc4@redhat.com>
	<CAFEAcA_6wg6aS_g0mGcNyjC57BVoU+pxdaRU3buM5J6b3XNW-Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa226f5f-77c4-7167-29c6-9baf08737239@redhat.com>
Date: Mon, 5 Feb 2018 15:04:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_6wg6aS_g0mGcNyjC57BVoU+pxdaRU3buM5J6b3XNW-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] rtc: placing RTC memory region outside BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gonglei <arei.gonglei@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 04/02/2018 19:02, Peter Maydell wrote:
> On 1 February 2018 at 14:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 01/02/2018 08:47, Gonglei wrote:
>>> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
>>> index 35a05a6..d9d99c5 100644
>>> --- a/hw/timer/mc146818rtc.c
>>> +++ b/hw/timer/mc146818rtc.c
>>> @@ -986,6 +986,7 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
>>>      qemu_register_suspend_notifier(&s->suspend_notifier);
>>>
>>>      memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
>>> +    memory_region_clear_global_locking(&s->io);
>>>      isa_register_ioport(isadev, &s->io, base);
>>>
>>>      qdev_set_legacy_instance_id(dev, base, 3);
>>>
>>
>> This is not enough, you need to add a new lock or something like that.
>> Otherwise two vCPUs can access the RTC together and make a mess.
> 
> Do you also need to do something to take the global lock before
> raising the outbound IRQ line (since it might be connected to a device
> that does need the global lock), or am I confused ?

Yes, that's a good point.  Most of the time the IRQ line is raised in a
timer, but not always.

Paolo
