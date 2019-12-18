Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96EDC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823F5206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="2C4Z/igc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823F5206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihRld-0004mR-KH
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 00:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ihRkj-0004GA-1Q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ihRkh-0005Vk-8x
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:20:04 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ihRkg-0005SY-P6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:20:03 -0500
Received: by mail-pf1-x444.google.com with SMTP id y14so530003pfm.13
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 21:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QUDVbXqmzSEvL7gTnBG7f1ej57k/I/lns2jZToM5uqI=;
 b=2C4Z/igcJlL/++pcp71xQgwKL22CGuS5Bn8s7rbYT1psILuAVtc/z9dnsQhZ3OQlWO
 nFRJONSIfRAaRgkYlBs8/4rQWifn577qtdvKli1iObHElufFZNOsnsrbmZBLSVI3HaU1
 Eb9uOp46j6IZNgbUpgnSABFRabvupbV6uyUX90fXu5SGW2rZF6G4mc9guEF0LPUgopmE
 XRfZnwWp3I2t3JwdhykWaHEHeyc6hdBeQAW6cGBwA4m0L6TUQ6MqIvYpApAIBZzRRM3l
 KrgmNOyms67tNVz4f+TF3k7tvXlI8048VA5u5ErFq38jlQiTIbIyGoG7uyKgwm0vwOVx
 oehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QUDVbXqmzSEvL7gTnBG7f1ej57k/I/lns2jZToM5uqI=;
 b=looRqdHlaVmr0BugI/+BqAv/Q6CzonF4UABA8Vp6Hce74sbnIy2wN8TxGCsNX66cBv
 r/JcRZg2iS3+NM+q4WyZDcpOJpk3rLzsC6Aatc35s4CaK7PaUF6R1lfwYtbNyiYGrhkQ
 q699rAuGPQUoKEybk/vWZI64F9HJ1UPVXVJ7oSG1JAGQcFUrNrOutPCbV9so/62ufGxm
 kiG94zMmKIFvPdmGsSbvFiI7YnWkUZYPUCyWvZsLAJgXsP31Dj2rsm9eYBM/lwht3u+q
 Axk6uGDeUIYYbJYBxxPiHS5VfrHI/YwNSbuTo/nvdYwkEdMVdvG5mU2zVkq5/XL1mBTF
 sxPQ==
X-Gm-Message-State: APjAAAUp2P5ez2moBEkjFbUnIpz1TNkExLRXsPx0QHVqdmeGN9T1nQN6
 VfCwodeZF3RdV1FktS2U9t1F+D2urjA=
X-Google-Smtp-Source: APXvYqyGOTfklfG92AeC6AmJNU8mxAPeD++UUdZvwaQcY+0/8Np82iVGhdrMZ2ifkGVWt0UvZzytWA==
X-Received: by 2002:a62:cece:: with SMTP id y197mr1000642pfg.9.1576646400163; 
 Tue, 17 Dec 2019 21:20:00 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id k15sm1012377pfg.37.2019.12.17.21.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 21:19:59 -0800 (PST)
Subject: Re: virtio capabilities
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <823b58f1-f17e-6645-11be-406ad1494e06@ozlabs.ru>
 <20191213021820-mutt-send-email-mst@kernel.org>
 <aff36770-9f21-988f-91ea-b106a8d5f1be@ozlabs.ru>
 <20191213033620-mutt-send-email-mst@kernel.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <f3c32495-6fe4-7401-c96b-12e9b90e23d9@ozlabs.ru>
Date: Wed, 18 Dec 2019 16:19:57 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213033620-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 13/12/2019 19:36, Michael S. Tsirkin wrote:
> On Fri, Dec 13, 2019 at 07:29:40PM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 13/12/2019 18:24, Michael S. Tsirkin wrote:
>>> On Fri, Dec 13, 2019 at 05:05:05PM +1100, Alexey Kardashevskiy wrote:
>>>> Hi!
>>>>
>>>> I am having an issue with capabilities (hopefully the chunk formatting
>>>> won't break).
>>>>
>>>> The problem is that when virtio_pci_find_capability() reads
>>>> pci_find_capability(dev, PCI_CAP_ID_VNDR), 0 is returned; if repeated,
>>>> it returns a valid number (0x84). Timing seems to matter. pci_cfg_read
>>>> trace shows that that first time read does not reach QEMU but others do
>>>> reach QEMU and return what is expected.
>>>>
>>>> How to debug this, any quick ideas?
>>>> The config space is not a MMIO BAR
>>>> or KVM memory slot or anything like this, right? :) Thanks,
>>>
>>> Depends on the platform.
>>>
>>> E.g. on x86, when using cf8/cfc pair, if guest doesn't
>>
>>
>> Is there an easy way to tell if it is this "cf8/cfc" case?
>>
>> I have these bars, is any of them related to cf8/cfc? Thanks,
>>
>> root@le-dbg:~# (qemu) info mtree -f
>> FlatView #0
>>  AS "memory", root: system
>>  AS "cpu-memory-0", root: system
>>  Root memory region: system
>>   0000000000000000-00000000ffffffff (prio 0, ram): ppc_spapr.ram kvm
>>   0000200080000000-000020008000002f (prio 0, i/o): msix-table
>>   0000200080000800-0000200080000807 (prio 0, i/o): msix-pba
>>   0000210000000000-0000210000000fff (prio 0, i/o): virtio-pci-common
>>   0000210000001000-0000210000001fff (prio 0, i/o): virtio-pci-isr
>>   0000210000002000-0000210000002fff (prio 0, i/o): virtio-pci-device
>>   0000210000003000-0000210000003fff (prio 0, i/o): virtio-pci-notify
>>
> 
> 
> No, you want stuff in hw/ppc/spapr_pci.c


The problem was with our firmware, fixing that now.

Out of curiosity. I do not see cf8/cfc on x86 either, or I just do not
recognize those, what is this cf8/cfc? Thanks,

FlatView #2

 AS "memory", root: system

 AS "cpu-memory-0", root: system

 AS "piix3-ide", root: bus master container

 AS "virtio-net-pci", root: bus master container

 Root memory region: system

  0000000000000000-00000000000bffff (prio 0, ram): pc.ram kvm

  00000000000c0000-00000000000c0fff (prio 0, rom): pc.ram
@00000000000c0000 kvm
  00000000000c1000-00000000000c3fff (prio 0, ram): pc.ram
@00000000000c1000 kvm
  00000000000c4000-00000000000e7fff (prio 0, rom): pc.ram
@00000000000c4000 kvm
  00000000000e8000-00000000000effff (prio 0, ram): pc.ram
@00000000000e8000 kvm
  00000000000f0000-00000000000fffff (prio 0, rom): pc.ram
@00000000000f0000 kvm
  0000000000100000-000000007fffffff (prio 0, ram): pc.ram
@0000000000100000 kvm
  00000000febc0000-00000000febc002f (prio 0, i/o): msix-table

  00000000febc0800-00000000febc0807 (prio 0, i/o): msix-pba

  00000000febfc000-00000000febfcfff (prio 0, i/o): virtio-pci-common

  00000000febfd000-00000000febfdfff (prio 0, i/o): virtio-pci-isr

  00000000febfe000-00000000febfefff (prio 0, i/o): virtio-pci-device

  00000000febff000-00000000febfffff (prio 0, i/o): virtio-pci-notify

  00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic

  00000000fed00000-00000000fed003ff (prio 0, i/o): hpet

  00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi

  00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios kvm



-- 
Alexey

