Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F72C35246
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3FE2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPj2+km/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3FE2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwLtP-0003AQ-0H
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 03:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iwLsi-0002by-6G
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iwLsg-00029S-NT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:05:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56962
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iwLsg-000294-Jm
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580198753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVN+wz2rKSaekie9WMPkUV/atoAqPHGM30VGYh6kWNw=;
 b=HPj2+km/PPnzONSQJIVs1HNvloMPbzsaB9h6hCYTsoLAs9lLkIkPv5ql4gPJmwN3aJKkv+
 shDoMkISrTue7c9AqgQTysaenie2T3yK4UH1NaliM7RVyqjKp70xhW5UQ7MNHrbOsQqtGf
 3PveI7PudV4zT6oXeylWeDrXzWMr+5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-iKdxFYU5MUW9eyNfP_UyGg-1; Tue, 28 Jan 2020 03:05:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2878B100550E;
 Tue, 28 Jan 2020 08:05:48 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECFB185747;
 Tue, 28 Jan 2020 08:05:43 +0000 (UTC)
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1b718429-c74e-fbac-84b8-379f3291db40@redhat.com>
Date: Tue, 28 Jan 2020 09:05:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: iKdxFYU5MUW9eyNfP_UyGg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, maz@kernel.org, qemu-devel@nongnu.org, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 1/28/20 7:48 AM, Gavin Shan wrote:
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

arm_pmu driver was reworked to use pseudo-NMIs. I don't know the exact
status of this work though
(https://patchwork.kernel.org/cover/11047407/). So we cannot use any
random NMI for guest injection.

I wonder whether we should implement the KVM_NMI vcpu ioctl once we have
agreed on which behavior is expected upon NMI injection. However the
kernel doc says this ioctl only is well defined if "KVM_CREATE_IRQCHIP
has not been called" (?).

Thanks

Eric
> 
> Thanks,
> Gavin
> 
> 


