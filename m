Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D718C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48087214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuVz4poY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48087214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40191 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMgN-0004jL-Ca
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lnkgyv@gmail.com>) id 1irMff-0004J4-Nc
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lnkgyv@gmail.com>) id 1irMfe-0000or-7K
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:55:51 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lnkgyv@gmail.com>) id 1irMfd-0000oh-VU
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:55:50 -0500
Received: by mail-lj1-x244.google.com with SMTP id y6so14485442lji.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 05:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2dgHMkmO2VrZ+dCtrpmLNOy8pbERU+k8EF9MW0GCX8Y=;
 b=QuVz4poYjB456o+pDubtPNWWpXNbrDLsw8RDRDa2yLwEITs4HjESS9OYBxNYJ0JyAT
 mOm0fc9wMXJ5raoX8lm/wHFPvO7ZQY+sGVLNdDnwH6e4w62Rd/evdv1qWk+TNz/RlAtf
 l9CfXZPzxSuvr0LHPYQlMVFq9n5S4shBsgYB1unGTMmfx+T00E212WT1u61Ca5QD4ovn
 FCUULVFf99bxTDT+5G9irgkXzxc9dnY2gGTQkAt5e3BxXsBmgMUYYFOvS8pFaCV6k7Mp
 SEWbwqSPVDeOeWIDl62Ln1YVRdCUjxsX07GJ7ijjHafOcccXa6CPkTFbTm6hTcB2e4xi
 aGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2dgHMkmO2VrZ+dCtrpmLNOy8pbERU+k8EF9MW0GCX8Y=;
 b=WacxgAoHDPsIrLQOUODI6cJYNb1IJ2TK7FSWxHBSI7Tfz+/kLNkQw7YlBUQhT/WToj
 aMinEj2+NLGOYlGkzPzZdZ8bWs2ndSkbUWayxwPbSBAr2U6lnxPhK5uJcSaulRjRSXqV
 3h9FQFtEMW/c61IQ7l40281oNL799tre4U1beFQWgPf+Ra0O8jevLmoWxh2hlTCXVU2J
 HMZc/rM++r63KrYHDvh6kCanU7/2Le/1mIDQNAfxlbsEkhkPo+assBXyvC3sDAAeGRLs
 8jJKp9YpZ1xMIGRGIGWxyWXR8Dp1upeMsaNmi9SXy2y9M+GQ0lCYPpem9Sh8cZE/KeHT
 xtWA==
X-Gm-Message-State: APjAAAXnUuE+Bc2jf7vgd9WEj9xDTrT8neUM73v7N6w2ZppCCH35WJEZ
 4TUYXuu5DUGBlv8Y6bNHlbNgs3mU
X-Google-Smtp-Source: APXvYqxx1ozrmF2rce9I3j8k3xhs0yxxJUBgBIwJW9qFN5NUXjvPBZgExULhsmlGAT5KCOZd87ZH3w==
X-Received: by 2002:a2e:3e03:: with SMTP id l3mr14387307lja.237.1579010147856; 
 Tue, 14 Jan 2020 05:55:47 -0800 (PST)
Received: from [192.168.101.65] ([82.97.198.254])
 by smtp.gmail.com with ESMTPSA id u24sm7551892ljo.77.2020.01.14.05.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 05:55:47 -0800 (PST)
Subject: Re: PCIe device paththrough via vfio issue
To: Alex Williamson <alex.williamson@redhat.com>
References: <9ebac151-0a9b-3f64-ccd8-0709088fa2b3@gmail.com>
 <20200113092820.7af3b10c@w520.home>
From: yurij <lnkgyv@gmail.com>
Message-ID: <410a1486-cd27-fa99-b706-7f0a80df3547@gmail.com>
Date: Tue, 14 Jan 2020 16:52:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200113092820.7af3b10c@w520.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/13/20 7:28 PM, Alex Williamson wrote:
> On Mon, 13 Jan 2020 18:49:21 +0300
> yurij <lnkgyv@gmail.com> wrote:
> 
>> Hello everybody!
>>
>> I have a specific PCIe device (sorry, but I can't tell about what is it
>> and what it does) but PCI configuration space consists of 4 BARs (lspci
>> output brief):
>>
>> lspci -s 84:00.00 -vvv
>>
>> . . .
>> Region 0: Memory at fa000000 (64-bit, non-prefetchable) [size=16M]
>> 	Region 2: Memory at fb001000 (32-bit, non-prefetchable) [size=4K]
>> 	Region 3: Memory at fb000000 (32-bit, non-prefetchable) [size=4K]
>> 	Region 4: Memory at f9000000 (64-bit, non-prefetchable) [size=16M]
>> . . .
>> Kernel driver in use: vfio-pci
>> . . .
>>
>> BAR0 merged with BAR1, BAR4 merged with BAR5 so they are 64 bit width.
>>
>> I put this PCIe device in virtual machine via vfio:
>>
>> -device vfio-pci,host=84:00.0,id=hostdev0,bus=pci.6,addr=0x0
>>
>> Virtual machine successfully boot. PCI configuration space in virtual
>> environment looks OK (lspci output brief):
>>
>> lspci -s 06:00.0 -vvv
>>
>> . . .
>> Region 0: Memory at f8000000 (64-bit, non-prefetchable) [size=16M]
>> 	Region 2: Memory at fa000000 (32-bit, non-prefetchable) [size=4K]
>> 	Region 3: Memory at fa001000 (32-bit, non-prefetchable) [size=4K]
>> 	Region 4: Memory at f9000000 (64-bit, non-prefetchable) [size=16M]
>> . . .
>> Kernel driver in use: custom_driver
>>
>> BAR0 merged with BAR1 and BAR4 merged with BAR5 and so they are also 64
>> bit width.
>>
>> The main problem in 4K HOLE in REGION 0 in virtual environment. So some
>> device features don't work.
>>
>> I have enabled iommu trace in host system (trace_event=iommu) and
>> display all events (for i in $(find
>> /sys/kernel/debug/tracing/events/iommu/ -name enable);do echo 1 > $i;
>> done). I saw next events during virtual machine booting:
>>
>> # cat /sys/kernel/debug/tracing/trace
>> . . .
>>          CPU 0/KVM-3046  [051] .... 63113.338894: map: IOMMU:
>> iova=0x00000000f8000000 paddr=0x00000000fa000000 size=24576
>>          CPU 0/KVM-3046  [051] .... 63113.339177: map: IOMMU:
>> iova=0x00000000f8007000 paddr=0x00000000fa007000 size=16748544
>>          CPU 0/KVM-3046  [051] .... 63113.339444: map: IOMMU:
>> iova=0x00000000fa000000 paddr=0x00000000fb001000 size=4096
>>          CPU 0/KVM-3046  [051] .... 63113.339697: map: IOMMU:
>> iova=0x00000000fa001000 paddr=0x00000000fb000000 size=4096
>>          CPU 0/KVM-3046  [051] .... 63113.340209: map: IOMMU:
>> iova=0x00000000f9000000 paddr=0x00000000f9000000 size=16777216
>> . . .
>>
>> I have enabled qemu trace(-trace events=/root/qemu/trace_events). Trace
>> file consists of the falling functions:
>> vfio_region_mmap
>> vfio_get_dev_region
>> vfio_pci_size_rom
>> vfio_pci_read_config
>> vfio_pci_write_config
>> vfio_iommu_map_notify
>> vfio_listener_region_add_iommu
>> vfio_listener_region_add_ram
>>
>> Some important brief from qemu trace:
>> . . .
>> янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region
>> 0000:84:00.0 BAR 0 mmaps[0] [0x0 - 0xffffff]
>> янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region
>> 0000:84:00.0 BAR 2 mmaps[0] [0x0 - 0xfff]
>> янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region
>> 0000:84:00.0 BAR 3 mmaps[0] [0x0 - 0xfff]
>> янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region
>> 0000:84:00.0 BAR 4 mmaps[0] [0x0 - 0xffffff]
>> . . .
>> янв 13 18:17:37 VM qemu-system-x86_64[7131]:
>> vfio_listener_region_add_ram region_add [ram] 0xf8000000 - 0xf8005fff
>> [0x7f691e800000]
>> янв 13 18:17:37 VM qemu-system-x86_64[7131]:
>> vfio_listener_region_add_ram region_add [ram] 0xf8007000 - 0xf8ffffff
>> [0x7f691e807000]
>> янв 13 18:17:37 VM qemu-system-x86_64[7131]:
>> vfio_listener_region_add_ram region_add [ram] 0xfa000000 - 0xfa000fff
>> [0x7f6b5de37000]
>> янв 13 18:17:37 VM qemu-system-x86_64[7131]:
>> vfio_listener_region_add_ram region_add [ram] 0xfa001000 - 0xfa001fff
>> [0x7f6b58004000]
>> янв 13 18:17:37 VM qemu-system-x86_64[7131]:
>> vfio_listener_region_add_ram region_add [ram] 0xf9000000 - 0xf9ffffff
>> [0x7f691d800000]
>>
>> I use qemu 4.0.0 which I rebuild for tracing support
>> (--enable-trace-backends=syslog).
>>
>> Please, help me solve this issue. Thank you!
> 
> Something has probably created a QEMU MemoryRegion overlapping the BAR,
> we do this for quirks where we want to intercept a range of MMIO for
> emulation, but the offset 0x6000 on BAR0 doesn't sound familiar to me.
> Run the VM with a monitor and see if 'info mtree' provides any info on
> the handling of that overlap.  Thanks,
> 
> Alex
> 

I have seen lspci more closely and find offset 0x6000 on BAR0:
. . .
	Capabilities: [90] MSI-X: Enable- Count=32 Masked-
		Vector table: BAR=0 offset=00006000
		PBA: BAR=0 offset=00007000
. . .

I have enabled next trace functions:
vfio_msix_vector_do_use
vfio_msix_vector_release
vfio_msix_enable
vfio_msix_pba_disable
vfio_msix_pba_enable
vfio_msix_disable
vfio_msix_fixup
vfio_msix_relo
vfio_msix_early_setup


Start virtual machine and see:
. . .
янв 14 16:18:49 VM qemu-system-x86_64[3645]: vfio_msix_early_setup 
0000:84:00.0 PCI MSI-X CAP @0x90, BAR 0, offset 0x6000, entries 32
. . .

So qemu split BAR0 due to MSI-X capailities. Is it true? If it seems to 
be true I need to patch qemu pci-quirks.c to add vfio_quirk_ function 
that will be workaround about my device? Can I disable allocation space 
for MSI-X capability (my device doesn't use MSI-X)?

P.S.
 > Run the VM with a monitor and see if 'info mtree' provides any info on
 > the handling of that overlap.  Thanks,
Can you explain to me, how can I use 'mtree' (debugging scenario)? I 
have never use 'mtree' and don't imagine about usage scenario.

Thank you!

-- 
with best regards
Yurij Goncharuk

