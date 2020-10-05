Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D287C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489B520665
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECg6LHc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489B520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLHr-0005tm-BQ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 03:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPLHC-0005TV-Pb
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPLH9-0003D3-U5
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601884273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nhMEVnT8zXdrjI8fI+XzlnX7XaDV5RMMBf3YJO6LyaE=;
 b=ECg6LHc6AYcyy5Py7ie7D7vy78sNDraIDPNrN+7yTgFxtyz4Yi3SY03TsGNHMwbfZeRdiL
 RbbeaShegX57N6sGe3LOFcztp6lbW2igSN6XikEoPH5azKB0Kq+jjSOkIXvMPo697eTUyS
 1st+lTpOpVZercjmjzuIJQ9u0vHtoW8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-p5kj6DDQPFmu2Vh9Ektfww-1; Mon, 05 Oct 2020 03:51:12 -0400
X-MC-Unique: p5kj6DDQPFmu2Vh9Ektfww-1
Received: by mail-wm1-f72.google.com with SMTP id y83so1448003wmc.8
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 00:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=nhMEVnT8zXdrjI8fI+XzlnX7XaDV5RMMBf3YJO6LyaE=;
 b=VMbKZybW3P3c9T2U9UlvQouEuP44dCVVihN5XIxeNhaHiZXRJZTMU+HlZ/q+Nnm36x
 Gh8jjOFOgJPoa02mcO2YGqqNwJhwPCrTuYFEQhS/OV8SpmdYpiXK3FixQ8c9gSYt3aFV
 347DhqDAbopT/1Nj6j4fTHLWVXrV0+w/npeJTQUvyr7BwrZcMbGCQ0MVpAIgqrkcVhoZ
 4VQovrUjobXZHov5DHS0bO7hhs8aWTEh8+BCrQr/75DT/YRZP3U542WXC+qbLRMG4WqK
 FPwzvqOsOfuTnFWt6KePN5G8nIV9/SN/rqiOg63IS+iTY9l3kNhnj+7+wzT5wxlieta6
 bymw==
X-Gm-Message-State: AOAM530jow00qw0fqveGyYyPK6Hs0Tjz5y7eqWaFv6NQwjqY64O+vuFx
 jwsDsqgdhMAsVtyrqKdnDJvvdUUTBB7Mn7pbrNlImWuWWeyK2NMFkOKDkTS55ekijaT48L+ocUR
 /PaChVTpECJ4vxUc=
X-Received: by 2002:a7b:c189:: with SMTP id y9mr1840906wmi.141.1601884270957; 
 Mon, 05 Oct 2020 00:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyVnhvLT9vBZRI8USXrcQuzhXgzGCVvAwjrLZTugklmGOSInur/y+F+BThs09GEw+UL4zV2A==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr1840882wmi.141.1601884270690; 
 Mon, 05 Oct 2020 00:51:10 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id m18sm12239939wmg.32.2020.10.05.00.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 00:51:09 -0700 (PDT)
Subject: Re: [PULL v2 00/92] Misc patches for 2020-09-24
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200925102257.1848666-1-pbonzini@redhat.com>
 <CAFEAcA-okvLfrjtvVVUWJWunzOSC8kgAEUuMM1JXciebfSJ0pg@mail.gmail.com>
 <CAFEAcA_6j7n5CvahUkxuQmWLfpq6L5ya+XTCMqnxaTqoB05QpA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <62f95614-b9b1-8a9f-a4e0-c825799b6958@redhat.com>
Date: Mon, 5 Oct 2020 09:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_6j7n5CvahUkxuQmWLfpq6L5ya+XTCMqnxaTqoB05QpA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 9/25/20 1:44 PM, Peter Maydell wrote:
> On Fri, 25 Sep 2020 at 11:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Fri, 25 Sep 2020 at 11:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>  Date: Fri Sep 25 11:41:22 2020 +0100
>>     Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
>> ERROR: pull request includes tag with UTF-8 error in person name
>>
>> (that's "configure: Do not intent to build WHPX on 32-bit host")
>>
>> (I will run the merge through the other tests to see if there's
>> any other issues with it.)
> 
> It also failed on the clang build: all the usermode binaries
> failed like this:
> 
> /usr/bin/ld: capstone/libcapstone.a(cs.o): relocation R_X86_64_32S
> against `.bss' can not be used when making a PIE object; recompile
> with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(utils.o): relocation R_X86_64_32S
> against symbol `cs_mem_malloc' can not be used when making a PIE
> object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(ARMModule.o): relocation
> R_X86_64_32S against symbol `arch_init' can not be used when making a
> PIE object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(AArch64Module.o): relocation
> R_X86_64_32S against symbol `arch_init' can not be used when making a
> PIE object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(PPCModule.o): relocation
> R_X86_64_32S against symbol `arch_init' can not be used when making a
> PIE object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(X86Module.o): relocation
> R_X86_64_32S against symbol `arch_init' can not be used when making a
> PIE object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(ARMDisassembler.o): relocation
> R_X86_64_32S against `.rodata' can not be used when making a PIE
> object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(ARMInstPrinter.o): relocation
> R_X86_64_32S against `.rodata' can not be used when making a PIE
> object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(ARMMapping.o): relocation
> R_X86_64_32S against `.rodata' can not be used when making a PIE
> object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(AArch64Disassembler.o): relocation
> R_X86_64_32S against `.rodata' can not be used when making a PIE
> object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(AArch64InstPrinter.o): relocation
> R_X86_64_32S against symbol `cs_mem_free' can not be used when making
> a PIE object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(AArch64Mapping.o): relocation
> R_X86_64_32S against `.rodata' can not be used when making a PIE
> object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(PPCDisassembler.o): relocation
> R_X86_64_32S against `.rodata' can not be used when making a PIE
> object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(PPCInstPrinter.o): relocation
> R_X86_64_32S against symbol `cs_mem_free' can not be used when making
> a PIE object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(PPCMapping.o): relocation
> R_X86_64_32S against `.rodata' can not be used when making a PIE
> object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(X86Disassembler.o): relocation
> R_X86_64_32S against `.rodata' can not be used when making a PIE
> object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(X86IntelInstPrinter.o): relocation
> R_X86_64_32S against symbol `cs_mem_free' can not be used when making
> a PIE object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(X86ATTInstPrinter.o): relocation
> R_X86_64_32S against symbol `cs_mem_free' can not be used when making
> a PIE object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(X86Mapping.o): relocation
> R_X86_64_32S against `.rodata' can not be used when making a PIE
> object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(AArch64BaseInfo.o): relocation
> R_X86_64_32S against symbol `cs_mem_free' can not be used when making
> a PIE object; recompile with -fPIC
> /usr/bin/ld: capstone/libcapstone.a(X86DisassemblerDecoder.o):
> relocation R_X86_64_32S against `.rodata' can not be used when making
> a PIE object; recompile with -fPIC
> /usr/bin/ld: final link failed: Nonrepresentable section on output

Is that why your "configure: fix performance regression due to PIC
objects" patch has been dropped from your pull request?

Thanks,

Phil.


