Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73796C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E04C207ED
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tebi0EaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E04C207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jad2e-0000xz-EJ
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jad1e-0000H3-Um
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:29:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jad1d-00022o-U3
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589797776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1PvqMRAvREXTZfVKUEA/ExkPZRKlvoc3OlbhbEOqax8=;
 b=Tebi0EaGqJ8/hkwR3sYs7f5PXTgz5VlqV53/ZkQjR3M160K/exo2YCFm/BOHkcqunj3R0+
 hBIIfgslQWQmIEgphplkZK0zEq1Py5BE0gIEMhIrN1AKdXHGSdvK1TWD98BXhEzayiB5Sr
 +PRYHFdauT0sdN+MGlF0cEBjOgYXa+Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-hD7ezu1vOoOkt7yXkqlUCw-1; Mon, 18 May 2020 06:29:35 -0400
X-MC-Unique: hD7ezu1vOoOkt7yXkqlUCw-1
Received: by mail-wm1-f69.google.com with SMTP id 202so645341wmb.8
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 03:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1PvqMRAvREXTZfVKUEA/ExkPZRKlvoc3OlbhbEOqax8=;
 b=eKFe8rUR+6+q5HWBNTvdkWnN6SbfMkSztT+INDNY8CA3ZgBAYWnT+HjkZjv76OF6MI
 K/6ZM5+cEHxFnEjN3oqilEW5DEskE+BCjx+HimQX0WkpVBuKGQzEYqt2qUcyTepRRmLW
 lz5pB9oHKkYjLmdSoqd56C2VrXD39XaAJg7xANZ7jMB1lsbL95rqs21Sn43RK1S0QWMt
 GlBsiM5EXzpQSPlqYJQZ4b7ikhJ1TvPbqer6Tr4hvkk8NMi7FIQUzvB+WGTHFLIwveK2
 UHP7QaFlNd/BFmtfHY1Tbzbtfvwof9r3ERjyBNAfP6mDKZ8NHuogTgEVM1cWFpR2+qUy
 rjzA==
X-Gm-Message-State: AOAM530MEKoOlrmb2OWxAPF510kYBqTVe/zsPxq07kyi3xlaVG2+be1Y
 FQrIiUdx8eDbpXOnrPmsDV96RatxgH5E4zGAyCkNnTihtorzQ+IrplrMq9/3pKKmTRfU7JZ15Gu
 0ULtHRzyO5Du5wBo=
X-Received: by 2002:a5d:530b:: with SMTP id e11mr13465080wrv.85.1589797773782; 
 Mon, 18 May 2020 03:29:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZL+29hBT3h1AlnYWjr2rAIWaiVmk78E29mmt6UZFwaorKX1lArrpnUGGocHDDKY0Rg1E46g==
X-Received: by 2002:a5d:530b:: with SMTP id e11mr13465053wrv.85.1589797773445; 
 Mon, 18 May 2020 03:29:33 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v126sm16872663wma.9.2020.05.18.03.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 03:29:32 -0700 (PDT)
Subject: Re: [RFC PATCH] hw/i386/vmport: Allow QTest use without crashing
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200518102551.8516-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f9d3b8c2-5504-2537-6846-a441cf4f3cdd@redhat.com>
Date: Mon, 18 May 2020 12:29:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518102551.8516-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 12:25 PM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>

Bah, wrong cherry-pick, as it was done during hobby time ¯\_(ツ)_/¯

> 
> Trying libFuzzer on the vmport device, we get:
> 
>    AddressSanitizer:DEADLYSIGNAL
>    =================================================================
>    ==29476==ERROR: AddressSanitizer: SEGV on unknown address 0x000000008840 (pc 0x56448bec4d79 bp 0x7ffeec9741b0 sp 0x7ffeec9740e0 T0)
>    ==29476==The signal is caused by a READ memory access.
>      #0 0x56448bec4d78 in vmport_ioport_read (qemu-fuzz-i386+0x1260d78)
>      #1 0x56448bb5f175 in memory_region_read_accessor (qemu-fuzz-i386+0xefb175)
>      #2 0x56448bb30c13 in access_with_adjusted_size (qemu-fuzz-i386+0xeccc13)
>      #3 0x56448bb2ea27 in memory_region_dispatch_read1 (qemu-fuzz-i386+0xecaa27)
>      #4 0x56448bb2e443 in memory_region_dispatch_read (qemu-fuzz-i386+0xeca443)
>      #5 0x56448b961ab1 in flatview_read_continue (qemu-fuzz-i386+0xcfdab1)
>      #6 0x56448b96336d in flatview_read (qemu-fuzz-i386+0xcff36d)
>      #7 0x56448b962ec4 in address_space_read_full (qemu-fuzz-i386+0xcfeec4)
> 
> This is easily reproducible using:
> 
>    $ echo inb 0x5658 | qemu-system-i386 -M isapc,accel=qtest -qtest stdio
>    [I 1589796572.009763] OPENED
>    [R +0.008069] inb 0x5658
>    Segmentation fault (core dumped)
> 
>    $ coredumpctl gdb -q
>    Program terminated with signal SIGSEGV, Segmentation fault.
>    #0  0x00005605b54d0f21 in vmport_ioport_read (opaque=0x5605b7531ce0, addr=0, size=4) at hw/i386/vmport.c:77
>    77          eax = env->regs[R_EAX];
>    (gdb) p cpu
>    $1 = (X86CPU *) 0x0
>    (gdb) bt
>    #0  0x00005605b54d0f21 in vmport_ioport_read (opaque=0x5605b7531ce0, addr=0, size=4) at hw/i386/vmport.c:77
>    #1  0x00005605b53db114 in memory_region_read_accessor (mr=0x5605b7531d80, addr=0, value=0x7ffc9d261a30, size=4, shift=0, mask=4294967295, attrs=...) at memory.c:434
>    #2  0x00005605b53db5d4 in access_with_adjusted_size (addr=0, value=0x7ffc9d261a30, size=1, access_size_min=4, access_size_max=4, access_fn=
>        0x5605b53db0d2 <memory_region_read_accessor>, mr=0x5605b7531d80, attrs=...) at memory.c:544
>    #3  0x00005605b53de156 in memory_region_dispatch_read1 (mr=0x5605b7531d80, addr=0, pval=0x7ffc9d261a30, size=1, attrs=...) at memory.c:1396
>    #4  0x00005605b53de228 in memory_region_dispatch_read (mr=0x5605b7531d80, addr=0, pval=0x7ffc9d261a30, op=MO_8, attrs=...) at memory.c:1424
>    #5  0x00005605b537c80a in flatview_read_continue (fv=0x5605b7650290, addr=22104, attrs=..., ptr=0x7ffc9d261b4b, len=1, addr1=0, l=1, mr=0x5605b7531d80) at exec.c:3200
>    #6  0x00005605b537c95d in flatview_read (fv=0x5605b7650290, addr=22104, attrs=..., buf=0x7ffc9d261b4b, len=1) at exec.c:3239
>    #7  0x00005605b537c9e6 in address_space_read_full (as=0x5605b5f74ac0 <address_space_io>, addr=22104, attrs=..., buf=0x7ffc9d261b4b, len=1) at exec.c:3252
>    #8  0x00005605b53d5a5d in address_space_read (len=1, buf=0x7ffc9d261b4b, attrs=..., addr=22104, as=0x5605b5f74ac0 <address_space_io>) at include/exec/memory.h:2401
>    #9  0x00005605b53d5a5d in cpu_inb (addr=22104) at ioport.c:88
> 
> X86CPU is NULL because QTest accelerator does not use CPU.
> Fix by returning default values when QTest accelerator is used.
> 
> Reported-by: Clang AddressSanitizer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/i386/vmport.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index 1aaaab691a..4ec95f8778 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -24,6 +24,7 @@
>   #include "qemu/osdep.h"
>   #include "hw/isa/isa.h"
>   #include "sysemu/hw_accel.h"
> +#include "sysemu/qtest.h"
>   #include "qemu/log.h"
>   #include "vmport.h"
>   #include "cpu.h"
> @@ -64,10 +65,14 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
>       VMPortState *s = opaque;
>       CPUState *cs = current_cpu;
>       X86CPU *cpu = X86_CPU(cs);
> -    CPUX86State *env = &cpu->env;
> +    CPUX86State *env;
>       unsigned char command;
>       uint32_t eax;
>   
> +    if (qtest_enabled()) {
> +        return -1;
> +    }
> +    env = &cpu->env;
>       cpu_synchronize_state(cs);
>   
>       eax = env->regs[R_EAX];
> @@ -90,6 +95,9 @@ static void vmport_ioport_write(void *opaque, hwaddr addr,
>   {
>       X86CPU *cpu = X86_CPU(current_cpu);
>   
> +    if (qtest_enabled()) {
> +        return;
> +    }
>       cpu->env.regs[R_EAX] = vmport_ioport_read(opaque, addr, 4);
>   }
>   
> @@ -97,6 +105,9 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
>   {
>       X86CPU *cpu = X86_CPU(current_cpu);
>   
> +    if (qtest_enabled()) {
> +        return -1;
> +    }
>       cpu->env.regs[R_EBX] = VMPORT_MAGIC;
>       return 6;
>   }
> @@ -105,6 +116,9 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
>   {
>       X86CPU *cpu = X86_CPU(current_cpu);
>   
> +    if (qtest_enabled()) {
> +        return -1;
> +    }
>       cpu->env.regs[R_EBX] = 0x1177;
>       return ram_size;
>   }
> 


