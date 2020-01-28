Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B413C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0D524684
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiEClKD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0D524684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwN8I-0004SV-0R
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 04:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1iwN7W-0003aF-Mz
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1iwN7V-0002I5-8Y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1iwN7N-00020M-Ht; Tue, 28 Jan 2020 04:25:09 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AAB2A24684;
 Tue, 28 Jan 2020 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580203507;
 bh=GV78bYrwP32wEq1gerhdBeVdMGIQi/GctwQCHPZiYQ4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HiEClKD2Uj+3Wgwgnvxn0o/bf+Outk437IeVNHBGUUKbXhiaKuiehxsyuDo6+Elje
 bz8f2Av9fy1IYf8V2NYF7JuVycvjaV4G2kB/lLXslpFfk7A0XgKGsXyEn2YXoB+p+B
 uUTR41haDB060w/1dwYk7IXQXimGQ9u8ESF2LQ1c=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1iwN7J-001mJQ-TZ; Tue, 28 Jan 2020 09:25:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Jan 2020 09:25:05 +0000
From: Marc Zyngier <maz@kernel.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
In-Reply-To: <1b718429-c74e-fbac-84b8-379f3291db40@redhat.com>
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <1b718429-c74e-fbac-84b8-379f3291db40@redhat.com>
Message-ID: <ff78ed012e7b8fbd656e7e4b477ee0a4@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, gshan@redhat.com, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, qemu-devel@nongnu.org, shan.gavin@gmail.com,
 pbonzini@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, Gavin Shan <gshan@redhat.com>,
 jthierry@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 shan.gavin@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gavin, Eric,

On 2020-01-28 08:05, Auger Eric wrote:
> Hi,
> 
> On 1/28/20 7:48 AM, Gavin Shan wrote:
>> [including more folks into the discussion]
>> 
>>> On Fri, 17 Jan 2020 at 14:00, Peter Maydell 
>>> <peter.maydell@linaro.org>
>>> wrote:
>>>> On Thu, 19 Dec 2019 at 04:06, Gavin Shan <gshan@redhat.com> wrote:
>>>>> This supports NMI injection for virtual machine and currently it's 
>>>>> only
>>>>> supported on GICv3 controller, which is emulated by qemu or host
>>>>> kernel.
>>>>> The design is highlighted as below:
>>>>> 
>>>>> * The NMI is identified by its priority (0x20). In the guest 
>>>>> (linux)
>>>>> kernel, the GICC_PMR is set to 0x80, to block all interrupts except
>>>>> the NMIs when the external interrupt is disabled. It means the FIQ
>>>>> and IRQ bit in PSTATE isn't touched when the functionality (NMI) is
>>>>> functional.
>>>>> * LPIs aren't considered as NMIs because of their nature. It means 
>>>>> NMI
>>>>> is either SPI or PPI. Besides, the NMIs are injected in round-robin
>>>>> fashion is there are multiple NMIs existing.
>>>>> * When the GICv3 controller is emulated by qemu, the interrupt 
>>>>> states
>>>>> (e.g. enabled, priority) is fetched from the corresponding data 
>>>>> struct
>>>>> directly. However, we have to pause all CPUs to fetch the interrupt
>>>>> states from host in advance if the GICv3 controller is emulated by
>>>>> host.
>>>>> 
>>>>> The testing scenario is to tweak guest (linux) kernel where the
>>>>> pl011 SPI
>>>>> can be enabled as NMI by request_nmi(). Check "/proc/interrupts"
>>>>> after injecting
>>>>> several NMIs, to see if the interrupt count is increased or not. 
>>>>> The
>>>>> result
>>>>> is just as expected.
>>>>> 
>>> 
>>> So, QEMU is trying to emulate actual hardware. None of this
>>> looks to me like what GICv3 hardware does... If you want to
>>> have the virt board send an interrupt, do it the usual way
>>> by wiring up a qemu_irq from some device to the GIC, please.
>>> (More generally, there is no concept of an "NMI" in the GIC;
>>> there are just interrupts at varying possible guest-programmable
>>> priority levels.)
>>> 
>> 
>> Peter, I missed to read your reply in time and apologies for late 
>> response.
>> 
>> Yes, there is no concept of "NMI" in the GIC from hardware 
>> perspective.
>> However, NMI has been supported from the software by kernel commit
>> bc3c03ccb4641 ("arm64: Enable the support of pseudo-NMIs"). The NMIs
>> have higher priority than normal ones. NMIs are deliverable after
>> local_irq_disable() because the SYS_ICC_PMR_EL1 is tweaked so that
>> normal interrupts are masked only.

And none of that is an NMI. This is a completely SW-defined mechanism,
and you can't rely on this to inject something that would behave as
a NMI in in a guest. I thought the "pseudo" prefix would give it away 
:-(.

>> 
>> It's unclear about the purpose of "nmi" QMP/HMP command. It's why I
>> put a RFC tag. The command has been supported by multiple architects
>> including x86/ppc. However, they are having different behaviors. The
>> system will be restarted on ppc with this command, but a NMI is 
>> injected
>> through LAPIC on x86. So I'm not sure what architect (system reset on
>> ppc or injecting NMI on x86) aarch64 should follow.

The x86 NMI has no equivalent on ARM, full stop. And the only thing that
the ARM implementation should follow is the letter of the architecture,
without added concepts.

> arm_pmu driver was reworked to use pseudo-NMIs. I don't know the exact
> status of this work though
> (https://patchwork.kernel.org/cover/11047407/). So we cannot use any
> random NMI for guest injection.
> 
> I wonder whether we should implement the KVM_NMI vcpu ioctl once we 
> have
> agreed on which behavior is expected upon NMI injection. However the
> kernel doc says this ioctl only is well defined if "KVM_CREATE_IRQCHIP
> has not been called" (?).

But what architectural concept would you map your KVM_NMI to? The number
of things you can do is pretty limited:

- Reset: we already have this
- Interrupt: you don't get to decide the priority or the group
- SError: Pretty much fatal in all cases

You *could* try something like SDEI [1], but that's a pretty terrible
interface too.

         M.

[1] 
https://static.docs.arm.com/den0054/a/ARM_DEN0054A_Software_Delegated_Exception_Interface.pdf
-- 
Jazz is not dead. It just smells funny...

