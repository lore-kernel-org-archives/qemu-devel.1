Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC86C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 03:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD16214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 03:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rbp8vU75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD16214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iweFE-00028i-9P
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 22:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1iweEI-0001dK-Gc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 22:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1iweEG-0003w5-LS
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 22:41:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1iweEF-0003tx-2T
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 22:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580269282;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2mCvVd0vufppUuHojjTjaGL3Tx+S5PTxMyPJZcBfbM=;
 b=Rbp8vU756+T1blpi7EC2jTH12/er8zYeri0cKv/tLd/YVEI9S8WUeIFiPjYCqbNRN3qiYn
 Qc7hwWSUBC1qa8eoVHn/F++f41PYP78MyXezi86eAAFNnR0go0dGWC5sseO4KVO45uUTuE
 eCwWP5bP0vfhpbLDCZSV6ljzwp567WA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-tQj_gzCHNs-DpY_cwJRm2Q-1; Tue, 28 Jan 2020 22:41:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C08CB800D41;
 Wed, 29 Jan 2020 03:41:18 +0000 (UTC)
Received: from 192-168-1-108.tpgi.com.au (vpn2-54-26.bne.redhat.com
 [10.64.54.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AB5E10001AE;
 Wed, 29 Jan 2020 03:41:12 +0000 (UTC)
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-arm@nongnu.org
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <7f6e29e6-1df9-4513-79ba-b53873b0735e@ozlabs.ru>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <5586dcae-3872-faa8-870a-92fad2357fdd@redhat.com>
Date: Wed, 29 Jan 2020 14:41:10 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <7f6e29e6-1df9-4513-79ba-b53873b0735e@ozlabs.ru>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: tQj_gzCHNs-DpY_cwJRm2Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 maz@kernel.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 shan.gavin@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 1:44 PM, Alexey Kardashevskiy wrote:
> 
> 
> On 28/01/2020 17:48, Gavin Shan wrote:
>> [including more folks into the discussion]
>>
>>> On Fri, 17 Jan 2020 at 14:00, Peter Maydell <peter.maydell@linaro.org>
>>> wrote:
>>>> On Thu, 19 Dec 2019 at 04:06, Gavin Shan <gshan@redhat.com> wrote:
>>>>> This supports NMI injection for virtual machine and currently it's only
>>>>> supported on GICv3 controller, which is emulated by qemu or host
>>>>> kernel.
>>>>> The design is highlighted as below:
>>>>>
>>>>> * The NMI is identified by its priority (0x20). In the guest (linux)
>>>>> kernel, the GICC_PMR is set to 0x80, to block all interrupts except
>>>>> the NMIs when the external interrupt is disabled. It means the FIQ
>>>>> and IRQ bit in PSTATE isn't touched when the functionality (NMI) is
>>>>> functional.
>>>>> * LPIs aren't considered as NMIs because of their nature. It means NMI
>>>>> is either SPI or PPI. Besides, the NMIs are injected in round-robin
>>>>> fashion is there are multiple NMIs existing.
>>>>> * When the GICv3 controller is emulated by qemu, the interrupt states
>>>>> (e.g. enabled, priority) is fetched from the corresponding data struct
>>>>> directly. However, we have to pause all CPUs to fetch the interrupt
>>>>> states from host in advance if the GICv3 controller is emulated by
>>>>> host.
>>>>>
>>>>> The testing scenario is to tweak guest (linux) kernel where the
>>>>> pl011 SPI
>>>>> can be enabled as NMI by request_nmi(). Check "/proc/interrupts"
>>>>> after injecting
>>>>> several NMIs, to see if the interrupt count is increased or not. The
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
>> Peter, I missed to read your reply in time and apologies for late response.
>>
>> Yes, there is no concept of "NMI" in the GIC from hardware perspective.
>> However, NMI has been supported from the software by kernel commit
>> bc3c03ccb4641 ("arm64: Enable the support of pseudo-NMIs"). The NMIs
>> have higher priority than normal ones. NMIs are deliverable after
>> local_irq_disable() because the SYS_ICC_PMR_EL1 is tweaked so that
>> normal interrupts are masked only.
>>
>> It's unclear about the purpose of "nmi" QMP/HMP command. It's why I
>> put a RFC tag. The command has been supported by multiple architects
>> including x86/ppc. However, they are having different behaviors. The
>> system will be restarted on ppc with this command,
> 
> We inject "system reset" as it is the closest thing to the idea of NMI
> (could be a "machine check").
> 
> The system behaviour is configurable on POWERPC, it is either kdump
> (store a system dump and reboot) or simple reboot or activate XMON
> (in-kernel debugger, needs to be enabled beforehand).
> 
> The injector in QEMU is called NMIClass::nmi_monitor_handler and as the
> name suggests it is not an NMI (the hardware concept which x86 may be
> still has and others do not) but an "nmi" command of the QEMU monitor
> which is rather a debug tool - "kick an unresponsive guest" - for us
> (POWERPC).
> 

Alexey, thanks for the explanation. The behavior for PowerPC is clear now :)

> 
>> but a NMI is injected
>> through LAPIC on x86. So I'm not sure what architect (system reset on
>> ppc or injecting NMI on x86) aarch64 should follow.
> 
> I'd say whatever triggers in-kernel debugger or kdump but I am not
> familiar with ARM at all :)
> 

For x86, the behavior is really depending the NMI handler. Currently, it
seems nothing other than outputting below messages. However, it's configurable
to get a system crash via "/proc/sys/kernel/unknown_nmi_panic"

(qemu) nmi
[ 6731.137504] Uhhuh. NMI received for unknown reason 30 on CPU 0.
[ 6731.137511] Do you have a strange power saving mode enabled?
[ 6731.137512] Dazed and confused, but trying to continue

guest# cat /proc/sys/kernel/unknown_nmi_panic
0
guest# echo 1 > /proc/sys/kernel/unknown_nmi_panic
(qemu) nmi
[ 6852.848600] Do you have a strange power saving mode enabled?
[ 6852.848601] Kernel panic - not syncing: NMI: Not continuing
[ 6852.848602] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc6-gshan+ #21
[ 6852.848604] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-48-4
[ 6852.848604] Call Trace:
[ 6852.848605]  <NMI>
[ 6852.848606]  dump_stack+0x6d/0x9a
[ 6852.848607]  panic+0x101/0x2e3
[ 6852.848608]  nmi_panic.cold+0xc/0xc
[ 6852.848609]  unknown_nmi_error.cold+0x46/0x57
[ 6852.848609]  default_do_nmi+0xda/0x110
[ 6852.848610]  do_nmi+0x16e/0x1d0
[ 6852.848611]  end_repeat_nmi+0x16/0x1a
[ 6852.848625] RIP: 0010:native_safe_halt+0xe/0x10
[ 6852.848628] Code: 7b ff ff ff eb bd 90 90 90 90 90 90 e9 07 00 00 00 0f 00 2d 56 bc5
[ 6852.848639] RSP: 0018:ffffffffba603e10 EFLAGS: 00000246
[ 6852.848642] RAX: ffffffffb9ccbdb0 RBX: 0000000000000000 RCX: 0000000000000001
[ 6852.848643] RDX: 00000000000202ce RSI: 0000000000000083 RDI: 0000000000000000
[ 6852.848644] RBP: ffffffffba603e30 R08: 0000063b8ee46b61 R09: 0000000000000201
[ 6852.848645] R10: ffff9e29be53866c R11: 0000000000000018 R12: 0000000000000000
[ 6852.848646] R13: ffffffffba611780 R14: 0000000000000000 R15: 0000000000000000
[ 6852.848647]  ? __sched_text_end+0x1/0x1
[ 6852.848648]  ? native_safe_halt+0xe/0x10
[ 6852.848649]  ? native_safe_halt+0xe/0x10
[ 6852.848650]  </NMI>
[ 6852.848650]  ? default_idle+0x20/0x140
[ 6852.848651]  arch_cpu_idle+0x15/0x20
[ 6852.848652]  default_idle_call+0x23/0x30
[ 6852.848653]  do_idle+0x1fb/0x270
[ 6852.848654]  cpu_startup_entry+0x20/0x30
[ 6852.848655]  rest_init+0xae/0xb0
[ 6852.848656]  arch_call_rest_init+0xe/0x1b
[ 6852.848657]  start_kernel+0x4dd/0x4fd
[ 6852.848658]  x86_64_start_reservations+0x24/0x26
[ 6852.848658]  x86_64_start_kernel+0x75/0x79
[ 6852.848659]  secondary_startup_64+0xa4/0xb0
[ 6852.849153] Kernel Offset: 0x38400000 from 0xffffffff81000000 (relocation range: 0x)

Thanks,
Gavin



