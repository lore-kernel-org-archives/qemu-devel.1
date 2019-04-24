Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FD7C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0144B206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="MSIrIjQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0144B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36093 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJAY1-00030w-2h
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 01:34:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hJAWR-0002AD-SQ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hJAWQ-0007L1-3h
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:32:43 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hJAWP-0007I3-GI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:32:42 -0400
Received: by mail-pl1-x642.google.com with SMTP id w24so8685532plp.2
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 22:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
	h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=31TmjL03TbYloDISWkgZsp0aydq9/W/WxpJUo6R/zEU=;
	b=MSIrIjQ+Wz0UuvStI3lTIhkcFm4EqfC4jqBm+YGU4M6j5tgfL+wSG+JemwkBhBc13s
	otfUfj66N7Edz+ZfmbJY/nc8uQr3O1xsj+FETCdoQBBT/AZQ8oNj/zHxi+267ZWWCHli
	yzHY5HlMxxZfpLyRKyEuAqMP1us7oDVJc8womaGLynorwrRUshF49sf7ppiZTH7Zc1F2
	ws3dc1TDDPrr9iOrY0NQr4dtV7/O4/BIGbfyw+MhcntaMHD7eupffLhC/XTiRdba0FTj
	vgL+W9OzsRj6rQV7Kh3KQdnSbWSi5V83RZNq2wEXXe7w0wM1kMgUkxwHJGHgzvDZ17nw
	AyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=31TmjL03TbYloDISWkgZsp0aydq9/W/WxpJUo6R/zEU=;
	b=oouDK4srXanB9Yqug1GhlTjKVHPAjK1BK5NBfsGdf9v2ZKA58TIumwZbZy2GGcfaxv
	zckMatmVULUwYJeQoUBkuRF7JLhIg9BSep61sDWRwiu73sTC5jq7ellg/kG2g5qSQNKt
	7jaJf8+jtyTttvMTHmlwUFOxB6w6j+7yFt6arI3dsuYN/VilE5R4vqHP06e32wl+uKFc
	J4DGCdiu47IO5KH16XHk5TDZ8LjyFVLGEiU8tFEbgAGKLRUx4OBscUM5oiDzANr/BhC5
	muIxaRg0T7o3sX2d2CKef7/l9gexaP75mF1kbnpC4eLZm4blyc73b5McKzYF/BYpfGAI
	NkOw==
X-Gm-Message-State: APjAAAVNyZx4/7WR7sToUC3IoQCeM1/WRPwgUtoCcNOFj+Vp3yyw8PmM
	skk7Eo4xyJBqcqAwfPR4yTOABw==
X-Google-Smtp-Source: APXvYqwyRGMyfhHSoOr33YiO6ppCR2fP/25yGB3Ym5czRGuBJ6Uh70pqxfJvnJndkQ+LfJtqZoeqrQ==
X-Received: by 2002:a17:902:9302:: with SMTP id
	bc2mr14217749plb.108.1556083959636; 
	Tue, 23 Apr 2019 22:32:39 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10]) by smtp.gmail.com with ESMTPSA id
	j32sm1382377pgi.73.2019.04.23.22.32.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 22:32:38 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20181214025849.84274-1-aik@ozlabs.ru>
	<8727c6e5-006c-20e5-cb6b-be525154e184@redhat.com>
	<bda42f7c-9068-3c4d-d839-7f6c52561cc9@ozlabs.ru>
	<69a29694-b777-721a-eafd-4ff38c457f6d@redhat.com>
	<db36d006-3bdc-47fe-9987-519440446c4e@ozlabs.ru>
	<20190103173753.GJ2316@work-vm>
	<d4b8695c-3d37-ba92-d62b-e067b77274c8@ozlabs.ru>
	<20190207114953.GB2773@work-vm>
	<16486ff4-eb62-b4f2-78f8-a1ec7e3fbb0b@redhat.com>
	<30a5a208-249f-106e-f885-94caf9b82970@ozlabs.ru>
	<f346fdcb-1849-3397-7f4c-2d6ee07fcd7c@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
	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
Message-ID: <aca6d2ae-806f-55b3-d9d5-f5a2cfd760b9@ozlabs.ru>
Date: Wed, 24 Apr 2019 15:32:34 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f346fdcb-1849-3397-7f4c-2d6ee07fcd7c@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH qemu v2] hmp: Print if memory section is
 registered with an accelerator
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424053234.j_fEQlDW_ihbEk_c0W0lxydbwNVp0Rbti4eIEYWAVXA@z>

Paolo, ping?


On 19/03/2019 18:05, Alexey Kardashevskiy wrote:
> 
> 
> On 11/02/2019 15:56, Alexey Kardashevskiy wrote:
>>
>>
>> On 09/02/2019 04:26, Paolo Bonzini wrote:
>>> On 07/02/19 12:49, Dr. David Alan Gilbert wrote:
>>>>  //#define DEBUG_UNASSIGNED
>>>> @@ -2924,6 +2926,8 @@ struct FlatViewInfo {
>>>>      int counter;
>>>>      bool dispatch_tree;
>>>>      bool owner;
>>>> +    AccelClass *ac;
>>>> +    const char *ac_name;
>>>>  };
>>>>  
>>>>  static void mtree_print_flatview(gpointer key, gpointer value,
>>>> @@ -2939,6 +2943,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>>      int n = view->nr;
>>>>      int i;
>>>>      AddressSpace *as;
>>>> +    bool system_as = false;
>>>>  
>>>>      p(f, "FlatView #%d\n", fvi->counter);
>>>>      ++fvi->counter;
>>>> @@ -2950,6 +2955,9 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>>              p(f, ", alias %s", memory_region_name(as->root->alias));
>>>>          }
>>>>          p(f, "\n");
>>>> +        if (as == &address_space_memory) {
>>>> +            system_as = true;
>>>> +        }
>>>>      }
>>>>  
>>>>      p(f, " Root memory region: %s\n",
>>>> @@ -2985,6 +2993,13 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>>          if (fvi->owner) {
>>>>              mtree_print_mr_owner(p, f, mr);
>>>>          }
>>>> +
>>>> +        if (system_as && fvi->ac &&
>>>> +            fvi->ac->has_memory(current_machine,
>>>> +                                int128_get64(range->addr.start),
>>>> +                                MR_SIZE(range->addr.size) + 1)) {
>>>> +            p(f, " %s", fvi->ac_name);
>>>
>>> I don't understand this.  This doesn't check that the memory range
>>> actually matches the memory registered with the accelerator, only that
>>> there is something in that range. 
>>
>>
>> It is checking that a flat range (i.e. what actually works) has a
>> corresponding KVM slot:
>> https://git.qemu.org/?p=qemu.git;a=blob;f=accel/kvm/kvm-all.c;h=4e1de942ce554c734ac2673030031c228a752ac9;hb=HEAD#l201
>>
>>
>>> Why isn't it enough to use "info
>>> mtree" and look at the KVM address space?
>>
>>
>> There is no such thing in my QEMU, did you mean "KVM-SMRAM" (which is
>> missing on spapr)? I am not sure I understand its purpose for the task -
>> it prints all same ranges on my x86 laptop, not just ones which we told
>> KVM about.
>>
>> My task is that if let's say "0000:00:1a.0 BAR 0 mmaps[0]" is split into
>> several sections because MSIX happens to be in a middle of that BAR and
>> it is not system page size aligned, then it is going to be several
>> ranges with no clear indication whether or not these were registered as
>> KVM slots. A memory chunk can be "ram" and not a KVM slot if it is 4K on
>> PPC with 64K system pages, for example.
>>
>>
>> FlatView #0
>>  AS "memory", root: system
>>  AS "cpu-memory-0", root: system
>>  AS "cpu-memory-1", root: system
>>  AS "cpu-memory-2", root: system
>>  AS "cpu-memory-3", root: system
>>  AS "piix3-ide", root: bus master container
>>  AS "virtio-net-pci", root: bus master container
>>  AS "vfio-pci", root: bus master container
>>  Root memory region: system
>>   0000000000000000-00000000000bffff (prio 0, ram): pc.ram kvm
>>   00000000000c0000-00000000000c0fff (prio 0, rom): pc.ram
>> @00000000000c0000 kvm
>>   00000000000c1000-00000000000c3fff (prio 0, ram): pc.ram
>> @00000000000c1000 kvm
>>   00000000000c4000-00000000000e7fff (prio 0, rom): pc.ram
>> @00000000000c4000 kvm
>>   00000000000e8000-00000000000effff (prio 0, ram): pc.ram
>> @00000000000e8000 kvm
>>   00000000000f0000-00000000000fffff (prio 0, rom): pc.ram
>> @00000000000f0000 kvm
>>   0000000000100000-00000000bfffffff (prio 0, ram): pc.ram
>> @0000000000100000 kvm
>>   00000000febc0000-00000000febc0fff (prio 0, ramd): 0000:00:1a.0 BAR 0
>> mmaps[0] kvm
>>   00000000febc1000-00000000febc102f (prio 0, i/o): msix-table
>>   00000000febc1800-00000000febc1807 (prio 0, i/o): msix-pba
>>   00000000febfc000-00000000febfcfff (prio 0, i/o): virtio-pci-common
>>   00000000febfd000-00000000febfdfff (prio 0, i/o): virtio-pci-isr
>>   00000000febfe000-00000000febfefff (prio 0, i/o): virtio-pci-device
>>   00000000febff000-00000000febfffff (prio 0, i/o): virtio-pci-notify
>>   00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>>   00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
>>   00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>>   00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios kvm
>>   0000000100000000-000000013fffffff (prio 0, ram): pc.ram
>> @00000000c0000000 kvm
>>
>>
>>
>> FlatView #3
>>  AS "KVM-SMRAM", root: mem-container-smram
>>  Root memory region: mem-container-smram
>>   0000000000000000-00000000000bffff (prio 0, ram): pc.ram
>>   00000000000c0000-00000000000c0fff (prio 0, rom): pc.ram @00000000000c0000
>>   00000000000c1000-00000000000c3fff (prio 0, ram): pc.ram @00000000000c1000
>>   00000000000c4000-00000000000e7fff (prio 0, rom): pc.ram @00000000000c4000
>>   00000000000e8000-00000000000effff (prio 0, ram): pc.ram @00000000000e8000
>>   00000000000f0000-00000000000fffff (prio 0, rom): pc.ram @00000000000f0000
>>   0000000000100000-00000000bfffffff (prio 0, ram): pc.ram @0000000000100000
>>   00000000febc0000-00000000febc0fff (prio 0, ramd): 0000:00:1a.0 BAR 0
>> mmaps[0]
>>   00000000febc1000-00000000febc102f (prio 0, i/o): msix-table
>>   00000000febc1800-00000000febc1807 (prio 0, i/o): msix-pba
>>   00000000febfc000-00000000febfcfff (prio 0, i/o): virtio-pci-common
>>   00000000febfd000-00000000febfdfff (prio 0, i/o): virtio-pci-isr
>>   00000000febfe000-00000000febfefff (prio 0, i/o): virtio-pci-device
>>   00000000febff000-00000000febfffff (prio 0, i/o): virtio-pci-notify
>>   00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>>   00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
>>   00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>>   00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>   0000000100000000-000000013fffffff (prio 0, ram): pc.ram @00000000c0000000
>>
>>
>>
>>
>>> Perhaps you could add instead an argument to "info mtree" that prints
>>> only the AddressSpace with a given name?
>>
>> Nah, this is not what it is about.
> 
> 
> 
> Still a nack? :)



-- 
Alexey

