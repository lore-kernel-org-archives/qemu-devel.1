Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8989C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69B62467B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWWbvjzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69B62467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOZA-000438-Tb
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 05:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iwOYD-00039L-DK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iwOYB-0007O5-PM
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:56:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39982
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iwOYB-0007Nh-F6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580209014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5jK0A7x5c7aYCZz0uGyY1d3eb/SjK28XgKdCurftkM=;
 b=IWWbvjzbT551qdJQlLbIMIn8Hy9U4rB78utzfPM9JVezGKXWpX1cQ2TIx2EBzXAKrBqlQT
 4K38RlMSDvin2E5m8z89a+XD0KGu0ldeae/h4gQWLmRFvD1z4DFhb4cJCnAqKsRZ0DeCpv
 7WMmekH/QEPhuUndkjIk4lXjc0cG978=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-nvTkwhPPMO-uKv8R6dwkBQ-1; Tue, 28 Jan 2020 05:56:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 899798010D0;
 Tue, 28 Jan 2020 10:56:51 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 345F88E612;
 Tue, 28 Jan 2020 10:56:46 +0000 (UTC)
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Marc Zyngier <maz@kernel.org>
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <1b718429-c74e-fbac-84b8-379f3291db40@redhat.com>
 <ff78ed012e7b8fbd656e7e4b477ee0a4@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3ae0557c-c289-8a23-d62f-3dc2a12c0623@redhat.com>
Date: Tue, 28 Jan 2020 11:56:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ff78ed012e7b8fbd656e7e4b477ee0a4@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nvTkwhPPMO-uKv8R6dwkBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, Gavin Shan <gshan@redhat.com>,
 jthierry@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 shan.gavin@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc,
On 1/28/20 10:25 AM, Marc Zyngier wrote:
> Gavin, Eric,
>=20
> On 2020-01-28 08:05, Auger Eric wrote:
>> Hi,
>>
>> On 1/28/20 7:48 AM, Gavin Shan wrote:
>>> [including more folks into the discussion]
>>>
>>>> On Fri, 17 Jan 2020 at 14:00, Peter Maydell <peter.maydell@linaro.org>
>>>> wrote:
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
>>>>>> * When the GICv3 controller is emulated by qemu, the interrupt state=
s
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
>>>>>> several NMIs, to see if the interrupt count is increased or not. The
>>>>>> result
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
>=20
> And none of that is an NMI. This is a completely SW-defined mechanism,
> and you can't rely on this to inject something that would behave as
> a NMI in in a guest. I thought the "pseudo" prefix would give it away :-(=
.
>=20
>>>
>>> It's unclear about the purpose of "nmi" QMP/HMP command. It's why I
>>> put a RFC tag. The command has been supported by multiple architects
>>> including x86/ppc. However, they are having different behaviors. The
>>> system will be restarted on ppc with this command, but a NMI is injecte=
d
>>> through LAPIC on x86. So I'm not sure what architect (system reset on
>>> ppc or injecting NMI on x86) aarch64 should follow.
>=20
> The x86 NMI has no equivalent on ARM, full stop. And the only thing that
> the ARM implementation should follow is the letter of the architecture,
> without added concepts.
>=20
>> arm_pmu driver was reworked to use pseudo-NMIs. I don't know the exact
>> status of this work though
>> (https://patchwork.kernel.org/cover/11047407/). So we cannot use any
>> random NMI for guest injection.
>>
>> I wonder whether we should implement the KVM_NMI vcpu ioctl once we have
>> agreed on which behavior is expected upon NMI injection. However the
>> kernel doc says this ioctl only is well defined if "KVM_CREATE_IRQCHIP
>> has not been called" (?).
>=20
> But what architectural concept would you map your KVM_NMI to? The number
> of things you can do is pretty limited:
>=20
> - Reset: we already have this
> - Interrupt: you don't get to decide the priority or the group
> - SError: Pretty much fatal in all cases
>=20
> You *could* try something like SDEI [1], but that's a pretty terrible
> interface too.

Thank you for the pointer.

So Gavin, not sure the QEMU QMP/HMP NMI command is relevant on ARM (at
least at this point)?

Thanks

Eric


>=20
> =A0=A0=A0=A0=A0=A0=A0 M.
>=20
> [1]
> https://static.docs.arm.com/den0054/a/ARM_DEN0054A_Software_Delegated_Exc=
eption_Interface.pdf
>=20


