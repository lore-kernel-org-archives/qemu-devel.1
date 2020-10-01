Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4299BC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B397E206A1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6Zz5lJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B397E206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0or-0001rU-LJ
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO0eK-0007Td-DU
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO0eI-0003Dj-5u
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601566655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ylEXgl4yUI/EHL23DZ/WWkmoo/HeckrVbLG15QKKjvY=;
 b=F6Zz5lJyOI0w7Jdjm84jK18yj00eTvg7M5h1QcOw1jqQOUB+vBZANU2ud6rQqyp6ozd8Pq
 yYc9aPEi37/EHNVMXl7N5D1XhVLtSD25WMWO4EVwrH9CwkCYMxYG2vSJufFpZKnhsfFPTz
 F69lilU0VB4Rg82guaSy6KCfd51DEH0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-BwZogFrwOb6l2fzUGiIwYg-1; Thu, 01 Oct 2020 11:37:33 -0400
X-MC-Unique: BwZogFrwOb6l2fzUGiIwYg-1
Received: by mail-wm1-f71.google.com with SMTP id 13so85600wmf.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ylEXgl4yUI/EHL23DZ/WWkmoo/HeckrVbLG15QKKjvY=;
 b=GSvWFQIkHAOLhWE3siaPeoY4GcfeRdqeQEWhQQZJhQ1UY25SvdoXSskUiR4TsXHUeh
 76+1nIoNljpifJOn2mPuUHqNwng1VzQMLCG3QiCrW6UHOrU/JJUgmuhbjo4VbI/dRLMh
 DhpotyushuM/ZY4XqMIER5GunFhtvxgAp4rj0TJLvoJLFcrPFxjQUisqdrBgDoZ1qXON
 vxySriSd0QWwPZmJrrhTc+blOmLYax/fNn9tvKFcYYQXLSPPASt+ddnyoOJ2zUurSJaJ
 dWoYRd2mJRQYgANoBdtpBU5ken8dlgXjo3YVXqkIZbDeOprFRZ0a5chVj7D1E5BV/FBi
 M1AQ==
X-Gm-Message-State: AOAM530x5z+tofoiKBFPzbBUS5pdxAid0EUqjtzNdNp6CSKUrrWXITvx
 ibBergIRQkPr5JYPXJLYz9bLi1Pf6T6ve8lvaklgiTkrNzTqdZO92LlagCzU2IoEReQp2GZimXi
 v5T2YULKARZgeDMw=
X-Received: by 2002:a7b:c305:: with SMTP id k5mr86294wmj.102.1601566649208;
 Thu, 01 Oct 2020 08:37:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxGOmvJpHy6noxCLyoKiY5ycaQj0o47Ou88Tfl4CAsrCPyjLpsy19rmBMoLusSFJfkDhBZnQ==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr86254wmj.102.1601566648883;
 Thu, 01 Oct 2020 08:37:28 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z15sm8376143wrv.94.2020.10.01.08.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 08:37:28 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] target/i386: Restrict X86CPUFeatureWord to X86
 targets
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201001144152.1555659-1-philmd@redhat.com>
 <20201001144152.1555659-4-philmd@redhat.com>
 <20201001152905.GC3717385@habkost.net>
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
Message-ID: <27bf4922-545e-e7e5-29fa-1dd80283e41a@redhat.com>
Date: Thu, 1 Oct 2020 17:37:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201001152905.GC3717385@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 5:29 PM, Eduardo Habkost wrote:
> On Thu, Oct 01, 2020 at 04:41:52PM +0200, Philippe Mathieu-Daudé wrote:
>> Only qemu-system-FOO and qemu-storage-daemon provide QMP
>> monitors, therefore such declarations and definitions are
>> irrelevant for user-mode emulation.
>>
>> Restricting the x86-specific commands to machine-target.json
>> pulls less QAPI-generated code into user-mode.
> 
> Is this still true without "qapi: Restrict code generated for
> user-mode"?

The correct description so far is:

"Restricting the x86-specific commands to machine-target.json
pulls less QAPI-generated code into non-x86 targets.", as of
this commit the X86CPURegister32 definitions are not built in
the other ARM/S390/PPC/... targets.

I still have some hope "qapi: Restrict code generated for user-mode"
get merged some day.

> 
> Markus, Eric: what's the difference between machine.json and
> machine-target.json? commit 7f7b4e7abef4 ("qapi: Split
> machine-target.json off target.json and misc.json") explains what
> but not why.
> 
>>
>> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Why the visit_type_X86CPUFeatureWordInfoList() stub was required
> in v3, but not in this version?

Because it is ifdef'ed out in the previous (new) patch:
"target/i386/cpu: Restrict some of feature-words uses to system-mode".

> 
> 
>> ---
>>  qapi/machine-target.json | 45 ++++++++++++++++++++++++++++++++++++++++
>>  qapi/machine.json        | 42 -------------------------------------
>>  target/i386/cpu.c        |  2 +-
>>  3 files changed, 46 insertions(+), 43 deletions(-)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index 698850cc78..b4d769a53b 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -4,6 +4,51 @@
>>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
>>  # See the COPYING file in the top-level directory.
>>  
>> +##
>> +# @X86CPURegister32:
>> +#
>> +# A X86 32-bit register
>> +#
>> +# Since: 1.5
>> +##
>> +{ 'enum': 'X86CPURegister32',
>> +  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ],
>> +  'if': 'defined(TARGET_I386)' }
>> +
>> +##
>> +# @X86CPUFeatureWordInfo:
>> +#
>> +# Information about a X86 CPU feature word
>> +#
>> +# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
>> +#
>> +# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
>> +#                   feature word
>> +#
>> +# @cpuid-register: Output register containing the feature bits
>> +#
>> +# @features: value of output register, containing the feature bits
>> +#
>> +# Since: 1.5
>> +##
>> +{ 'struct': 'X86CPUFeatureWordInfo',
>> +  'data': { 'cpuid-input-eax': 'int',
>> +            '*cpuid-input-ecx': 'int',
>> +            'cpuid-register': 'X86CPURegister32',
>> +            'features': 'int' },
>> +  'if': 'defined(TARGET_I386)' }
>> +
>> +##
>> +# @DummyForceArrays:
>> +#
>> +# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
>> +#
>> +# Since: 2.5
>> +##
>> +{ 'struct': 'DummyForceArrays',
>> +  'data': { 'unused': ['X86CPUFeatureWordInfo'] },
>> +  'if': 'defined(TARGET_I386)' }
>> +
>>  ##
>>  # @CpuModelInfo:
>>  #
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 756dacb06f..995e972858 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -574,48 +574,6 @@
>>     'dst': 'uint16',
>>     'val': 'uint8' }}
>>  
>> -##
>> -# @X86CPURegister32:
>> -#
>> -# A X86 32-bit register
>> -#
>> -# Since: 1.5
>> -##
>> -{ 'enum': 'X86CPURegister32',
>> -  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
>> -
>> -##
>> -# @X86CPUFeatureWordInfo:
>> -#
>> -# Information about a X86 CPU feature word
>> -#
>> -# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
>> -#
>> -# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
>> -#                   feature word
>> -#
>> -# @cpuid-register: Output register containing the feature bits
>> -#
>> -# @features: value of output register, containing the feature bits
>> -#
>> -# Since: 1.5
>> -##
>> -{ 'struct': 'X86CPUFeatureWordInfo',
>> -  'data': { 'cpuid-input-eax': 'int',
>> -            '*cpuid-input-ecx': 'int',
>> -            'cpuid-register': 'X86CPURegister32',
>> -            'features': 'int' } }
>> -
>> -##
>> -# @DummyForceArrays:
>> -#
>> -# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
>> -#
>> -# Since: 2.5
>> -##
>> -{ 'struct': 'DummyForceArrays',
>> -  'data': { 'unused': ['X86CPUFeatureWordInfo'] } }
>> -
>>  ##
>>  # @NumaCpuOptions:
>>  #
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 9f72342506..848a65ded2 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -38,7 +38,7 @@
>>  #include "qemu/option.h"
>>  #include "qemu/config-file.h"
>>  #include "qapi/error.h"
>> -#include "qapi/qapi-visit-machine.h"
>> +#include "qapi/qapi-visit-machine-target.h"
>>  #include "qapi/qapi-visit-run-state.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "qapi/qmp/qerror.h"
>> -- 
>> 2.26.2
>>
> 


