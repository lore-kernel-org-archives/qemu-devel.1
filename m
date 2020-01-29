Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EAAC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D0920702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaRFLHBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D0920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwiFF-0003ow-KJ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jthierry@redhat.com>) id 1iwiEQ-0003BI-Az
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jthierry@redhat.com>) id 1iwiEN-0007yN-M6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:57:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jthierry@redhat.com>) id 1iwiEN-0007us-BK
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580284666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDoJVR0XnRjpcsHf7NylsdLMfZxrhpQZJENHRcXvtJQ=;
 b=QaRFLHBNQVq0zbePFTDkf3feIDks3Fer8x4DDsgLIoeRGZEApEQRZgrQtsKebdZ+5VSOrS
 yJpHoOY0zFxpBsfJ2t7khLrKX/ioszu1ZWLt04X8fq5KcDpxSmEs70L7xExU96jORs85/b
 Bz6WfsTV7OZ8SWL8Nlsq4VtK30SAy7M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-AVOzXu7jOGaBl0X9TPW38Q-1; Wed, 29 Jan 2020 02:57:45 -0500
Received: by mail-wm1-f71.google.com with SMTP id y24so2034684wmj.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 23:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DDoJVR0XnRjpcsHf7NylsdLMfZxrhpQZJENHRcXvtJQ=;
 b=jbDuC28YnkviVJMx0I7Yt6JDQdrkyoiaubJnKQ+JSuRkZ+QVLR3Mg4PUVeDrOGY+7v
 RUG2cJAZLMhGmRhSrOe41sWNZl92/o75RXS1/eTds7UwHajhX+RSf8ELr3aYtjJDY1hJ
 +k6kqqhmhpC9gWwN45IENQxlv83MBj7ilzEU60ckJyaNgZEJafrRqJZTfqJls+YeckvA
 wM+T+fXJC+CZcLn7jFiMr0R9r5xb7xul0559tdlR3UsgQJO4d8IpewRY2rZEKiCv/LHP
 MLWzLzGDzYZfAS1GeLL+22u5q6wZzi8R5lZK6iEX1I3h0m53zBLEW4/9fLGXUWj2mY9r
 kCcw==
X-Gm-Message-State: APjAAAXGbT6xSk+AiNvUnLKrDFE2ivVWd7qz649YqaeLlC3LzNUSV3FZ
 ZqZnLKfDBb2bWHnfehvujH1SXfdE//yMNRFszSTGtDmGGB9FD1rlZDWLE62Gs7a4pUK0jMC9cIn
 MiZcI2OUhoVqYTPI=
X-Received: by 2002:a05:600c:2c41:: with SMTP id
 r1mr8553741wmg.57.1580284663838; 
 Tue, 28 Jan 2020 23:57:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhE5koraAdITI4RuwIi9KjyBa3iAsfLpz5vJRQWmxYkNlveSSlsrSsZvCTHd5GICJ1rGJ3Ew==
X-Received: by 2002:a05:600c:2c41:: with SMTP id
 r1mr8553686wmg.57.1580284663386; 
 Tue, 28 Jan 2020 23:57:43 -0800 (PST)
Received: from [192.168.1.81]
 (host81-132-222-100.range81-132.btcentralplus.com. [81.132.222.100])
 by smtp.gmail.com with ESMTPSA id f18sm1773611wrt.75.2020.01.28.23.57.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 23:57:42 -0800 (PST)
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <f4699b81-26ac-fcd4-d3fc-f6e055beeb65@redhat.com>
 <9f82206e-0852-ae17-8c77-01d2a5cea97d@redhat.com>
From: Julien Thierry <jthierry@redhat.com>
Message-ID: <51a83889-f2ef-5403-6661-710cfa1ffe01@redhat.com>
Date: Wed, 29 Jan 2020 07:57:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9f82206e-0852-ae17-8c77-01d2a5cea97d@redhat.com>
Content-Language: en-US
X-MC-Unique: AVOzXu7jOGaBl0X9TPW38Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, drjones@redhat.com, aik@ozlabs.ru, maz@kernel.org,
 qemu-devel@nongnu.org, eric.auger@redhat.com, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/29/20 3:46 AM, Gavin Shan wrote:
> On 1/28/20 7:29 PM, Julien Thierry wrote:
>> Hi Gavin,
>>
>> On 1/28/20 6:48 AM, Gavin Shan wrote:
>>> [including more folks into the discussion]
>>>
>>>> On Fri, 17 Jan 2020 at 14:00, Peter Maydell 
>>>> <peter.maydell@linaro.org> wrote:
>>>>> On Thu, 19 Dec 2019 at 04:06, Gavin Shan <gshan@redhat.com> wrote:
>>>>>> This supports NMI injection for virtual machine and currently it's 
>>>>>> only
>>>>>> supported on GICv3 controller, which is emulated by qemu or host 
>>>>>> kernel.
>>>>>> The design is highlighted as below:
>>>>>>
>>>>>> * The NMI is identified by its priority (0x20). In the guest (linux)
>>>>>> kernel, the GICC_PMR is set to 0x80, to block all interrupts except
>>>>>> the NMIs when the external interrupt is disabled. It means the FIQ
>>>>>> and IRQ bit in PSTATE isn't touched when the functionality (NMI) is
>>>>>> functional.
>>>>>> * LPIs aren't considered as NMIs because of their nature. It means 
>>>>>> NMI
>>>>>> is either SPI or PPI. Besides, the NMIs are injected in round-robin
>>>>>> fashion is there are multiple NMIs existing.
>>>>>> * When the GICv3 controller is emulated by qemu, the interrupt states
>>>>>> (e.g. enabled, priority) is fetched from the corresponding data 
>>>>>> struct
>>>>>> directly. However, we have to pause all CPUs to fetch the interrupt
>>>>>> states from host in advance if the GICv3 controller is emulated by
>>>>>> host.
>>>>>>
>>>>>> The testing scenario is to tweak guest (linux) kernel where the 
>>>>>> pl011 SPI
>>>>>> can be enabled as NMI by request_nmi(). Check "/proc/interrupts" 
>>>>>> after injecting
>>>>>> several NMIs, to see if the interrupt count is increased or not. 
>>>>>> The result
>>>>>> is just as expected.
>>>>>>
>>>>
>>>> So, QEMU is trying to emulate actual hardware. None of this
>>>> looks to me like what GICv3 hardware does... If you want to
>>>> have the virt board send an interrupt, do it the usual way
>>>> by wiring up a qemu_irq from some device to the GIC, please.
>>>> (More generally, there is no concept of an "NMI" in the GIC;
>>>> there are just interrupts at varying possible guest-programmable
>>>> priority levels.)
>>>>
>>>
>>> Peter, I missed to read your reply in time and apologies for late 
>>> response.
>>>
>>> Yes, there is no concept of "NMI" in the GIC from hardware perspective.
>>> However, NMI has been supported from the software by kernel commit
>>> bc3c03ccb4641 ("arm64: Enable the support of pseudo-NMIs"). The NMIs
>>> have higher priority than normal ones. NMIs are deliverable after
>>> local_irq_disable() because the SYS_ICC_PMR_EL1 is tweaked so that
>>> normal interrupts are masked only.
>>>
>>> It's unclear about the purpose of "nmi" QMP/HMP command. It's why I
>>> put a RFC tag. The command has been supported by multiple architects
>>> including x86/ppc. However, they are having different behaviors. The
>>> system will be restarted on ppc with this command, but a NMI is injected
>>> through LAPIC on x86. So I'm not sure what architect (system reset on
>>> ppc or injecting NMI on x86) aarch64 should follow.
>>>
>>
>> As Peter stated, there is no NMI concept on aarch64 hardware. The 
>> pseudo-NMI in the Linux port is purely a software concept. The OS 
>> itself decides which interrupts should have the "NMI" properties and 
>> sets them up accordingly.
>>
>> For QEMU to inject a pseudo-NMI into the guest would require it not 
>> only to know that the guest supports that feature. But also how such 
>> an interrupt has to be set up (currently there is no guaranty that the 
>> priority used for the NMI and the mask should stay the same across 
>> Linux version as it is purely internal to GICv3/arm64, no generic kAPI 
>> nor uAPI have access to it). And also, you would probably need to know 
>> what is handling the NMI you are injecting.
>>
>> QEMU shouldn't try to guess "that might be dealt as an NMI, lets raise 
>> it".
>>
>> I'm not familiar with the QMP/HMP nor the inner workings of QEMU, but 
>> if for some reason QEMU requires to trigger an NMI-like mechanic on 
>> aarch64, a proper way might be through para-virt. Having some 
>> "qemu-nmi-driver" in linux which calls "request_nmi()" and does the 
>> proper handling expected by QEMU.
>>
>> Cheers,
>>
> 
> Julien, thanks for the explanation. The question we're not sure if NMI 
> should
> be injected on receiving HMP/QMP "nmi" command. It means it's not clear 
> what
> behavior we should have for this command on ARM. However, I have one more
> unrelated question: "pseudo" NMI on ARM64 should be PPI? I mean SPI can't
> be "pseudo" NMI.
> 

I'm not sure I understand why you say "SPI can't be "pseudo" NMI". 
Currently both PPI and SPI are supported in the "pseudo" NMI scheme. Do 
you think that should not be the case? If so, can you elaborate?

Thanks,

-- 
Julien Thierry


