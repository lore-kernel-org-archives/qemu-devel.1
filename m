Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B4AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D35124683
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVY1pw36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D35124683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwR8K-0007Rn-A0
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 08:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jthierry@redhat.com>) id 1iwMGO-0001s0-T7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jthierry@redhat.com>) id 1iwMGM-0003P2-Sd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:30:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54321
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jthierry@redhat.com>) id 1iwMGM-0003ON-Mk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580200222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHAyMmWlzwPmFdNp7MpoXNUEMypa1e6NgWm+wmveGA0=;
 b=MVY1pw36FKhf48nFMkHDeWg5ieV+dbiD9YSaHOz0kTSXiN+rHUZzLaedWBWr9qZS+QJ0i2
 32cZNIiPjNVHSxcz6cnG3Gs+y6tIDWxQDAIK1quXCDd0ceXwJUWrvSHT+AxPlmbR9Vpjbe
 UAaqMzBkktg4x5rY7lKQl4B8/kmCaZI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-xLS6rpFWMlGZeBFMbJc7pA-1; Tue, 28 Jan 2020 03:29:12 -0500
Received: by mail-wr1-f72.google.com with SMTP id k18so7700546wrw.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 00:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GHAyMmWlzwPmFdNp7MpoXNUEMypa1e6NgWm+wmveGA0=;
 b=VKMa3IVEfhhniQEx4hWQVGCBHRztb8HBpiIRYt2SaX+JQgIa9W9Qk4gWsogylklcAv
 MTBs+vfpUA+Fuoi+xi9TbW671Lc+P1SQfkQvYn14oy1Y182aPT7yNGvoBD5yUyM/rypa
 S3TGpUxphLlX0Tbgz16+/C++LNiKYDM4vZTBfWKbN+gHUHHoXivMwf0Pn6Oj+NYfx/cj
 uE7gseDY8Qztb5LedjhxQzRRrPUURuaVSviFS6UlIKp6xbrLqncHQUq3MGxf6AR4/hh0
 o8AGjMy6oF7ByDqqDnERhaty/xw1/4m+gpofbGf1+IICLDsKDdaSX8ksBD8M4CEqi09X
 LGCw==
X-Gm-Message-State: APjAAAVtB6ts4EHrw0P8IULM/2mf+H0SIvDi7H7pHp0w2Lyv/lHN+BPk
 QAIspsfu0aENqNwZTBbgKx1MxF921oND9CWhhue6j49r+nPhd/fVJdwG5bS9VYcvcaYKIboy/Zk
 fUXtvNdHfutklipM=
X-Received: by 2002:a1c:9a56:: with SMTP id c83mr3578047wme.79.1580200151375; 
 Tue, 28 Jan 2020 00:29:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqztLH7s0upuXCjg6itu2cDtiPAPzm8KmneqxXt4qQsH20KnnnGBwZ3mP4BXz9m6fp5joNR7FQ==
X-Received: by 2002:a1c:9a56:: with SMTP id c83mr3578009wme.79.1580200151074; 
 Tue, 28 Jan 2020 00:29:11 -0800 (PST)
Received: from [192.168.1.81]
 (host81-132-222-100.range81-132.btcentralplus.com. [81.132.222.100])
 by smtp.gmail.com with ESMTPSA id d16sm28021384wrg.27.2020.01.28.00.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 00:29:10 -0800 (PST)
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
From: Julien Thierry <jthierry@redhat.com>
Message-ID: <f4699b81-26ac-fcd4-d3fc-f6e055beeb65@redhat.com>
Date: Tue, 28 Jan 2020 08:29:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
Content-Language: en-US
X-MC-Unique: xLS6rpFWMlGZeBFMbJc7pA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-Mailman-Approved-At: Tue, 28 Jan 2020 08:41:33 -0500
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

Hi Gavin,

On 1/28/20 6:48 AM, Gavin Shan wrote:
> [including more folks into the discussion]
> 
>> On Fri, 17 Jan 2020 at 14:00, Peter Maydell <peter.maydell@linaro.org> 
>> wrote:
>>> On Thu, 19 Dec 2019 at 04:06, Gavin Shan <gshan@redhat.com> wrote:
>>>> This supports NMI injection for virtual machine and currently it's only
>>>> supported on GICv3 controller, which is emulated by qemu or host 
>>>> kernel.
>>>> The design is highlighted as below:
>>>>
>>>> * The NMI is identified by its priority (0x20). In the guest (linux)
>>>> kernel, the GICC_PMR is set to 0x80, to block all interrupts except
>>>> the NMIs when the external interrupt is disabled. It means the FIQ
>>>> and IRQ bit in PSTATE isn't touched when the functionality (NMI) is
>>>> functional.
>>>> * LPIs aren't considered as NMIs because of their nature. It means NMI
>>>> is either SPI or PPI. Besides, the NMIs are injected in round-robin
>>>> fashion is there are multiple NMIs existing.
>>>> * When the GICv3 controller is emulated by qemu, the interrupt states
>>>> (e.g. enabled, priority) is fetched from the corresponding data struct
>>>> directly. However, we have to pause all CPUs to fetch the interrupt
>>>> states from host in advance if the GICv3 controller is emulated by
>>>> host.
>>>>
>>>> The testing scenario is to tweak guest (linux) kernel where the 
>>>> pl011 SPI
>>>> can be enabled as NMI by request_nmi(). Check "/proc/interrupts" 
>>>> after injecting
>>>> several NMIs, to see if the interrupt count is increased or not. The 
>>>> result
>>>> is just as expected.
>>>>
>>
>> So, QEMU is trying to emulate actual hardware. None of this
>> looks to me like what GICv3 hardware does... If you want to
>> have the virt board send an interrupt, do it the usual way
>> by wiring up a qemu_irq from some device to the GIC, please.
>> (More generally, there is no concept of an "NMI" in the GIC;
>> there are just interrupts at varying possible guest-programmable
>> priority levels.)
>>
> 
> Peter, I missed to read your reply in time and apologies for late response.
> 
> Yes, there is no concept of "NMI" in the GIC from hardware perspective.
> However, NMI has been supported from the software by kernel commit
> bc3c03ccb4641 ("arm64: Enable the support of pseudo-NMIs"). The NMIs
> have higher priority than normal ones. NMIs are deliverable after
> local_irq_disable() because the SYS_ICC_PMR_EL1 is tweaked so that
> normal interrupts are masked only.
> 
> It's unclear about the purpose of "nmi" QMP/HMP command. It's why I
> put a RFC tag. The command has been supported by multiple architects
> including x86/ppc. However, they are having different behaviors. The
> system will be restarted on ppc with this command, but a NMI is injected
> through LAPIC on x86. So I'm not sure what architect (system reset on
> ppc or injecting NMI on x86) aarch64 should follow.
> 

As Peter stated, there is no NMI concept on aarch64 hardware. The 
pseudo-NMI in the Linux port is purely a software concept. The OS itself 
decides which interrupts should have the "NMI" properties and sets them 
up accordingly.

For QEMU to inject a pseudo-NMI into the guest would require it not only 
to know that the guest supports that feature. But also how such an 
interrupt has to be set up (currently there is no guaranty that the 
priority used for the NMI and the mask should stay the same across Linux 
version as it is purely internal to GICv3/arm64, no generic kAPI nor 
uAPI have access to it). And also, you would probably need to know what 
is handling the NMI you are injecting.

QEMU shouldn't try to guess "that might be dealt as an NMI, lets raise it".

I'm not familiar with the QMP/HMP nor the inner workings of QEMU, but if 
for some reason QEMU requires to trigger an NMI-like mechanic on 
aarch64, a proper way might be through para-virt. Having some 
"qemu-nmi-driver" in linux which calls "request_nmi()" and does the 
proper handling expected by QEMU.

Cheers,

-- 
Julien Thierry


