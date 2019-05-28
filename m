Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BBFC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18C72075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18C72075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59761 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYRi-0001tG-0q
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:31:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVYQk-0001UH-Cy
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVYQj-0001aF-72
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:30:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVYQj-0001ZX-1U
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:30:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so19412137wrx.0
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xpTJyBTlo5WML685aK486J7Xio0VN0q5gST9GfNi71w=;
	b=XWPvvXnIa3rG1GzCaRFxD/hhCbqq59F58JAvqdCQZTn1hOLKScuNHBw7ynvvz26shA
	5ZZUzLmUxgQVYHqA93NI0y3OHUFq8G4o2A5//JgQB7XuICB4pm82qprGchFqIqK2lqX1
	YlRbiWMOyOoRz8oMFRWaO8hOkAoNGSGRzKva0y8UIPJF1vtLJ681PSnzQ0fn8PesfH+W
	NSHTmHx2U31Uhg6thXFXnD1rt76lRF4N84MyFW3gxTwfaYp9TNdDzp+P1oJmBwqvbfSC
	7Llk/9c+LxXKi4DUQAXn7XpQydduvlNgqAj2T2DhNU+meGt+lVTH7/IS0BKYgnLTVUzw
	VzxA==
X-Gm-Message-State: APjAAAXlghJP1GXS9fR15+hzLdkYLkjcx5G0T/7JiqKjiMZULxOeMTQ7
	V7hkC8dhfd6lBPfvlLvAutAFWQ==
X-Google-Smtp-Source: APXvYqwiBWXhISVdgfUVrAJ5qlwKOgcW2HLnqswAoA4fAEnctAEXzPl60XCFfIq8b7D9WscGoNQRdQ==
X-Received: by 2002:adf:f542:: with SMTP id j2mr333608wrp.16.1559035799945;
	Tue, 28 May 2019 02:29:59 -0700 (PDT)
Received: from [172.16.16.236] ([213.170.48.162])
	by smtp.gmail.com with ESMTPSA id w2sm7221800wru.16.2019.05.28.02.29.58
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 02:29:59 -0700 (PDT)
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
References: <51df31ee-54a1-d7be-bef4-71ae003b8811@redhat.com>
	<3fab9e76-53ad-2de7-45df-eb69c8604709@redhat.com>
	<016edc53-278e-cc58-0061-d2c5de80afd2@de.ibm.com>
	<1ddf0d83-ce0c-f1c9-065d-ff88ddb9293b@redhat.com>
	<60d1bf3d-659c-d199-6592-d3659702d754@redhat.com>
	<d38b05af-effc-97a1-0b4a-a0d44a13f769@de.ibm.com>
	<573cd34d-fc70-b26f-92f1-4eafd7126e87@redhat.com>
	<20190528103311.5d660c27.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9c24ca9d-c114-5db1-9cca-1f264fbf0cd1@redhat.com>
Date: Tue, 28 May 2019 11:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528103311.5d660c27.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] hw/s390x/ipl: Dubious use of qdev_reset_all_fn
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/19 10:33 AM, Cornelia Huck wrote:
> On Tue, 28 May 2019 10:29:09 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 24.05.19 21:45, Christian Borntraeger wrote:
>>>
>>>
>>> On 24.05.19 21:00, David Hildenbrand wrote:  
>>>> On 24.05.19 20:36, David Hildenbrand wrote:  
>>>>> On 24.05.19 20:28, Christian Borntraeger wrote:  
>>>>>>
>>>>>>
>>>>>> On 24.05.19 20:04, David Hildenbrand wrote:  
>>>>>>> On 24.05.19 19:54, Philippe Mathieu-Daudé wrote:  
>>>>>>>> Hi Christian,
>>>>>>>>
>>>>>>>> I'm having hard time to understand why the S390_IPL object calls
>>>>>>>> qemu_register_reset(qdev_reset_all_fn) in its realize() method, while
>>>>>>>> being QOM'ified (it has a reset method).
>>>>>>>>
>>>>>>>> It doesn't seem to have a qdev children added explicitly to it.
>>>>>>>> I see it is used as a singleton, what else am I missing?
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>> Phil.
>>>>>>>>  
>>>>>>>
>>>>>>> Looks like I added it back then (~4 years ago) when converting it into a
>>>>>>> TYPE_DEVICE.
>>>>>>>
>>>>>>> I could imagine that - back then - this was needed because only
>>>>>>> TYPE_SYS_BUS_DEVICE would recursively get reset.  
>>>>>>
>>>>>> Yes, back then singleton devices were not recursively resetted. Has that changed?  
>>>>>
>>>>> Hacking that call out, I don't see it getting called anymore. So it is
>>>>> still required. The question is if it can be reworked.
>>>>>  
>>>>
>>>> Yes, as it is not a sysbus device, it won't get reset.
>>>> The owner (machine) has to take care of this. The following works:
>>>>
>>>>
>>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>>> index b93750c14e..91a31c2cd0 100644
>>>> --- a/hw/s390x/ipl.c
>>>> +++ b/hw/s390x/ipl.c
>>>> @@ -232,7 +232,6 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>>>>       */
>>>>      ipl->compat_start_addr = ipl->start_addr;
>>>>      ipl->compat_bios_start_addr = ipl->bios_start_addr;
>>>> -    qemu_register_reset(qdev_reset_all_fn, dev);
>>>>  error:
>>>>      error_propagate(errp, err);
>>>>  }
>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>> index bbc6e8fa0b..658ab529a1 100644
>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>> @@ -338,6 +338,11 @@ static inline void s390_do_cpu_ipl(CPUState *cs, run_on_cpu_data arg)
>>>>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>>>>  }
>>>>  
>>>> +static void s390_ipl_reset(void)
>>>> +{
>>>> +    qdev_reset_all(DEVICE(object_resolve_path_type("", TYPE_S390_IPL, NULL)));
>>>> +}
>>>> +
>>>>  static void s390_machine_reset(void)
>>>>  {
>>>>      enum s390_reset reset_type;
>>>> @@ -353,6 +358,7 @@ static void s390_machine_reset(void)
>>>>      case S390_RESET_EXTERNAL:
>>>>      case S390_RESET_REIPL:
>>>>          qemu_devices_reset();
>>>> +        s390_ipl_reset();
>>>>          s390_crypto_reset();
>>>>  
>>>>          /* configure and start the ipl CPU only */
>>>>  
>>>
>>> While this patch is certainly ok, I find it disturbing that qdev devices are being resetted,
>>> but qom devices not.
>>>   
>>
>> Shall I send that as a proper patch, or do we want to stick to the
>> existing approach until we have improved the general reset approach?
> 
> I don't think the current code is really broken, so personally I'd
> prefer to just leave it alone until we figured out how the reset should
> work in general.

Agreed, I'd rather wait we better understand QOM/reset limitations, then
fix this properly, and finally kill the qdev_reset_all_fn() function.

Thanks all for having a look at this btw :)

Regards,

Phil.

