Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B2EC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C58222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjAoAvpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C58222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irOlJ-0004zO-Fv
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 11:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lnkgyv@gmail.com>) id 1irOhi-0000H6-8h
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lnkgyv@gmail.com>) id 1irOhg-0000Z9-Gx
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:06:06 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lnkgyv@gmail.com>) id 1irOhg-0000Vn-8O
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:06:04 -0500
Received: by mail-lj1-x241.google.com with SMTP id l2so14934717lja.6
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 08:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D6syJXeWoLRJCfWRUUKr9dFFy+6NAZIkQzBDGNWL1vM=;
 b=EjAoAvpFvQMu9LKP0BDKkTlvaWJBojx7PzLwCcz24LUwYocTfaW4AlyyduhsxGSci9
 QlrOrXcVd3ccL+jMRFdN9C5QbRuvTjR01wxnr24EkZBkjZU0NRkwteJswGLnVf/EMVt3
 Fh8xIfWsZYvrxHuYPYp9zx+Ml1Vr/bbLAB5nc1MsgEmWqugOBGt+RKgQGRvg+cibY4F2
 tHoWhA9KmxqMZ+4NsG2btmYuiMZe0XHyiAUZIVKxsf5Kd0lZO4zka/ZKdTGczTcNBjEI
 2A+MifLdU/E93o7YQQ0bGaeeb/TAZVSPT07SLS0x6s/YKGWB4XX00edbGvdegV9BkDke
 VNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D6syJXeWoLRJCfWRUUKr9dFFy+6NAZIkQzBDGNWL1vM=;
 b=K6lbXQcfheeTSNFcU/u4zGmv9A3KCmhOVkpgJWZFCxI5vnhSmqyQT2i3fn5+YoJxXv
 l7FnTy7d7F7EK+qiOns48fQ1Wy1CRWijh491R51pZSUqXsTYPT3+PEC3O0J3ZVZSQjBG
 rUVt8iUAzWBqYuzLamtUyxbccikkvuMNsK1YWQUPuZybo+8BIJDveFUPj5uVGTxkcMd9
 lCS3TnoJvHAouxAspIga4M5OhRwAnTzuT+x2GiwNV42iRKXE0QhGuhmfVQWRJsx+cDgn
 dkt2CNO/ie25bZMeIfLmJuqPWprlQZKbNA7sRJTWEeSZGuFor0FuEhXMOznoTIk0x/+q
 ixBA==
X-Gm-Message-State: APjAAAWTyLFF4+hrSqZbn9UXOmG3OzSuBaKcPkSaLvOYxMMt7M5PCZ6l
 J83AGlPHk6VAEWXf6TsZk+RpQPJf3yk=
X-Google-Smtp-Source: APXvYqyFPDUobrCbttg9qifr5Ay+A6OFFecLhUxCsG84VokTFZCrIbPM50PTyVQBk/17WTPRJsFodg==
X-Received: by 2002:a05:651c:282:: with SMTP id
 b2mr14954719ljo.41.1579017961686; 
 Tue, 14 Jan 2020 08:06:01 -0800 (PST)
Received: from [192.168.101.65] ([82.97.198.254])
 by smtp.gmail.com with ESMTPSA id v5sm7791263ljk.67.2020.01.14.08.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 08:06:00 -0800 (PST)
Subject: Re: PCIe device paththrough via vfio issue
To: Alex Williamson <alex.williamson@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
References: <9ebac151-0a9b-3f64-ccd8-0709088fa2b3@gmail.com>
 <20200113092820.7af3b10c@w520.home>
 <1e532c1c-ee61-d2ce-2633-f73c284c6acb@ozlabs.ru>
 <20200114070415.3309a36e@x1.home>
From: yurij <lnkgyv@gmail.com>
Message-ID: <61443d01-2206-4375-e22b-674536e0e2a0@gmail.com>
Date: Tue, 14 Jan 2020 19:02:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200114070415.3309a36e@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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


On 1/14/20 5:04 PM, Alex Williamson wrote:
> On Tue, 14 Jan 2020 17:14:33 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 14/01/2020 03:28, Alex Williamson wrote:
>>> On Mon, 13 Jan 2020 18:49:21 +0300
>>> yurij <lnkgyv@gmail.com> wrote:
>>>    
>>>> Hello everybody!
>>>>
>>>> I have a specific PCIe device (sorry, but I can't tell about what is it
>>>> and what it does) but PCI configuration space consists of 4 BARs (lspci
>>>> output brief):
>>>>
>>>> lspci -s 84:00.00 -vvv
>>>>
>>>> . . .
>>>> Region 0: Memory at fa000000 (64-bit, non-prefetchable) [size=16M]
>>>> 	Region 2: Memory at fb001000 (32-bit, non-prefetchable) [size=4K]
>>>> 	Region 3: Memory at fb000000 (32-bit, non-prefetchable) [size=4K]
>>>> 	Region 4: Memory at f9000000 (64-bit, non-prefetchable) [size=16M]
>>>> . . .
>>>> Kernel driver in use: vfio-pci
>>>> . . .
>>>>
>>>> BAR0 merged with BAR1, BAR4 merged with BAR5 so they are 64 bit width.
>>>>
>>>> I put this PCIe device in virtual machine via vfio:
>>>>
>>>> -device vfio-pci,host=84:00.0,id=hostdev0,bus=pci.6,addr=0x0
>>>>
>>>> Virtual machine successfully boot. PCI configuration space in virtual
>>>> environment looks OK (lspci output brief):
>>>>
>>>> lspci -s 06:00.0 -vvv
>>>>
>>>> . . .
>>>> Region 0: Memory at f8000000 (64-bit, non-prefetchable) [size=16M]
>>>> 	Region 2: Memory at fa000000 (32-bit, non-prefetchable) [size=4K]
>>>> 	Region 3: Memory at fa001000 (32-bit, non-prefetchable) [size=4K]
>>>> 	Region 4: Memory at f9000000 (64-bit, non-prefetchable) [size=16M]
>>>> . . .
>>>> Kernel driver in use: custom_driver
>>>>
>>>> BAR0 merged with BAR1 and BAR4 merged with BAR5 and so they are also 64
>>>> bit width.
>>>>
>>>> The main problem in 4K HOLE in REGION 0 in virtual environment. So some
>>>> device features don't work.
>>>>
>>>> I have enabled iommu trace in host system (trace_event=iommu) and
>>>> display all events (for i in $(find
>>>> /sys/kernel/debug/tracing/events/iommu/ -name enable);do echo 1 > $i;
>>>> done). I saw next events during virtual machine booting:
>>>>
>>>> # cat /sys/kernel/debug/tracing/trace
>>>> . . .
>>>>          CPU 0/KVM-3046  [051] .... 63113.338894: map: IOMMU:
>>>> iova=0x00000000f8000000 paddr=0x00000000fa000000 size=24576
>>>>          CPU 0/KVM-3046  [051] .... 63113.339177: map: IOMMU:
>>>> iova=0x00000000f8007000 paddr=0x00000000fa007000 size=16748544
>>>>          CPU 0/KVM-3046  [051] .... 63113.339444: map: IOMMU:
>>>> iova=0x00000000fa000000 paddr=0x00000000fb001000 size=4096
>>>>          CPU 0/KVM-3046  [051] .... 63113.339697: map: IOMMU:
>>>> iova=0x00000000fa001000 paddr=0x00000000fb000000 size=4096
>>>>          CPU 0/KVM-3046  [051] .... 63113.340209: map: IOMMU:
>>>> iova=0x00000000f9000000 paddr=0x00000000f9000000 size=16777216
>>>> . . .
>>>>
>>>> I have enabled qemu trace(-trace events=/root/qemu/trace_events). Trace
>>>> file consists of the falling functions:
>>>> vfio_region_mmap
>>>> vfio_get_dev_region
>>>> vfio_pci_size_rom
>>>> vfio_pci_read_config
>>>> vfio_pci_write_config
>>>> vfio_iommu_map_notify
>>>> vfio_listener_region_add_iommu
>>>> vfio_listener_region_add_ram
>>>>
>>>> Some important brief from qemu trace:
>>>> . . .
>>>> янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region
>>>> 0000:84:00.0 BAR 0 mmaps[0] [0x0 - 0xffffff]
>>>> янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region
>>>> 0000:84:00.0 BAR 2 mmaps[0] [0x0 - 0xfff]
>>>> янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region
>>>> 0000:84:00.0 BAR 3 mmaps[0] [0x0 - 0xfff]
>>>> янв 13 18:17:24 VM qemu-system-x86_64[7131]: vfio_region_mmap Region
>>>> 0000:84:00.0 BAR 4 mmaps[0] [0x0 - 0xffffff]
>>>> . . .
>>>> янв 13 18:17:37 VM qemu-system-x86_64[7131]:
>>>> vfio_listener_region_add_ram region_add [ram] 0xf8000000 - 0xf8005fff
>>>> [0x7f691e800000]
>>>> янв 13 18:17:37 VM qemu-system-x86_64[7131]:
>>>> vfio_listener_region_add_ram region_add [ram] 0xf8007000 - 0xf8ffffff
>>>> [0x7f691e807000]
>>>> янв 13 18:17:37 VM qemu-system-x86_64[7131]:
>>>> vfio_listener_region_add_ram region_add [ram] 0xfa000000 - 0xfa000fff
>>>> [0x7f6b5de37000]
>>>> янв 13 18:17:37 VM qemu-system-x86_64[7131]:
>>>> vfio_listener_region_add_ram region_add [ram] 0xfa001000 - 0xfa001fff
>>>> [0x7f6b58004000]
>>>> янв 13 18:17:37 VM qemu-system-x86_64[7131]:
>>>> vfio_listener_region_add_ram region_add [ram] 0xf9000000 - 0xf9ffffff
>>>> [0x7f691d800000]
>>>>
>>>> I use qemu 4.0.0 which I rebuild for tracing support
>>>> (--enable-trace-backends=syslog).
>>>>
>>>> Please, help me solve this issue. Thank you!
>>>
>>> Something has probably created a QEMU MemoryRegion overlapping the BAR,
>>> we do this for quirks where we want to intercept a range of MMIO for
>>> emulation, but the offset 0x6000 on BAR0 doesn't sound familiar to me.
>>> Run the VM with a monitor and see if 'info mtree' provides any info on
>>> the handling of that overlap.  Thanks,
>>
>>
>> Could not it be an MSIX region? 'info mtree -f' should tell exactly what
>> is going on.
> 
> Oh, good call, that's probably it.  The PCI spec specifically
> recommends against placing non-MSIX related registers within the same
> 4K page as the vector table to avoid such things:
> 
>   If a Base Address register that maps address space for the MSI-X Table
>   or MSI-X PBA also maps other usable address space that is not
>   associated with MSI-X structures, locations (e.g., for CSRs) used in
>   the other address space must not share any naturally aligned 4-KB
>   address range with one where either MSI-X structure resides. This
>   allows system software where applicable to use different processor
>   attributes for MSI-X structures and the other address space.
> 
> We have the following QEMU vfio-pci device option to relocate the BAR
> elsewhere for hardware that violates that recommendation or for where
> the PCI spec recommended alignment isn't sufficient:
> 
>   x-msix-relocation=<OffAutoPCIBAR> - off/auto/bar0/bar1/bar2/bar3/bar4/bar5
> 
> In this case I'd probably recommend bar2 or bar3 as those BARs would
> only be extended to 8K versus bar0/4 would be extended to 32M.  Thanks,
> 
> Alex
> 

 >   x-msix-relocation=<OffAutoPCIBAR> - 
off/auto/bar0/bar1/bar2/bar3/bar4/bar5

I have used successfully 'x-msix-relocation' option:
-device 
vfio-pci,host=84:00.0,id=hostdev0,bus=pci.6,addr=0x0,x-msix-relocation=bar2

Now,  IOMMU trace looks like:
. . .
        CPU 0/KVM-4237  [055] ....  4750.918416: map: IOMMU: 
iova=0x00000000f8000000 paddr=0x00000000fa000000 size=16777216
        CPU 0/KVM-4237  [055] ....  4750.918740: map: IOMMU: 
iova=0x00000000fa000000 paddr=0x00000000fb001000 size=4096
        CPU 0/KVM-4237  [055] ....  4750.919069: map: IOMMU: 
iova=0x00000000fa002000 paddr=0x00000000fb000000 size=4096
        CPU 0/KVM-4237  [055] ....  4750.919698: map: IOMMU: 
iova=0x00000000f9000000 paddr=0x00000000f9000000 size=16777216
. . .

All seems to be OK.

Thank you very much!

-- 
with best regards
Yurij Goncharuk

