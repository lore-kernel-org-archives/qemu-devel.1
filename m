Received: from eggs.gnu.org ([2001:4830:134:3::10]:33009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eiOcS-00005s-8N
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 13:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eiOcR-0000eb-FT
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 13:02:24 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eiOcR-0000eC-9X
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 13:02:23 -0500
Received: by mail-oi0-x243.google.com with SMTP id m83so19679492oik.8
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 10:02:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d2f644da-e6c8-da3a-55e4-13ae69c44fc4@redhat.com>
References: <1517492876-28428-1-git-send-email-arei.gonglei@huawei.com>
	<d2f644da-e6c8-da3a-55e4-13ae69c44fc4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 4 Feb 2018 18:02:02 +0000
Message-ID: <CAFEAcA_6wg6aS_g0mGcNyjC57BVoU+pxdaRU3buM5J6b3XNW-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] rtc: placing RTC memory region outside BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 1 February 2018 at 14:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 01/02/2018 08:47, Gonglei wrote:
>> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
>> index 35a05a6..d9d99c5 100644
>> --- a/hw/timer/mc146818rtc.c
>> +++ b/hw/timer/mc146818rtc.c
>> @@ -986,6 +986,7 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
>>      qemu_register_suspend_notifier(&s->suspend_notifier);
>>
>>      memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
>> +    memory_region_clear_global_locking(&s->io);
>>      isa_register_ioport(isadev, &s->io, base);
>>
>>      qdev_set_legacy_instance_id(dev, base, 3);
>>
>
> This is not enough, you need to add a new lock or something like that.
> Otherwise two vCPUs can access the RTC together and make a mess.

Do you also need to do something to take the global lock before
raising the outbound IRQ line (since it might be connected to a device
that does need the global lock), or am I confused ?

thanks
-- PMM
