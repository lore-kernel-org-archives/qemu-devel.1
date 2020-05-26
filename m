Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C25CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF382070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6EiYYly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF382070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdU9B-000485-4o
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdU8J-0002iR-Vr
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:36:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43234
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdU8I-0007FV-KT
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590478577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NckSVK2i2KrSyFF4wMYzH2E8+Nb8QuArcFuEct8EzQk=;
 b=F6EiYYlyNfmT/Fx2mLFSI6llGVVkzLv/RblnjrK9iTtWwP02WlRx6sBEXMQM2gLsgAZwZ2
 JDupMCJf5fxGEPqtcbg82CymKmkmLENqmhqt64kq0WgfqSNnC9FW7wqjYflp/LI/qOQ3Mj
 QEkWByRm+ofNcSLDlrZdzc+rOrSjxpU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-W_eoVCWYNmimrrwkORK9xA-1; Tue, 26 May 2020 03:36:15 -0400
X-MC-Unique: W_eoVCWYNmimrrwkORK9xA-1
Received: by mail-wm1-f72.google.com with SMTP id f62so737536wme.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 00:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NckSVK2i2KrSyFF4wMYzH2E8+Nb8QuArcFuEct8EzQk=;
 b=VSR47KfXPl9jElmr4NvMaSQkMEMDOECaRMyj3Fbhn7MwEkR73POtReW0nvOFr/bneB
 t9tsikl51xjKBdfenn3CEtos90aF5qJ7q/99muimmD31XLADT4Dms+FJRQOppoq8zIbx
 pVOP3Y5QJfw6PC2yI0vWnFafMp2O/YPzhjMah9urZmtaEqywevlISDMr9fbJSG6JFp43
 2ZaaNKWls+mvOhOaFNTvE9tDRvvHQGQKnxHEw6Ql4qO9rQByInXOyx6bG8gUJBzebDIg
 fkYVV1brk6H8FkZ0i4d/+IyRlHk+tOGU1NOeerDizaPtWE3/a58XfdRxhPWP5i61pgyj
 WG9Q==
X-Gm-Message-State: AOAM533jrHZAteQFAdHMujnOhBqCw3i8LTOhbrrMeRiUh+K4wS2MfRZq
 btkZnFvAiXMdyBKs/1FCa33LMsMXfVI/xDr91hgYUxN0hKvNHUj6/rvCfL8y6vpE0eBpiUPdCwk
 4sYTZcnO1fs6NKZs=
X-Received: by 2002:a05:600c:29c2:: with SMTP id s2mr92003wmd.33.1590478574627; 
 Tue, 26 May 2020 00:36:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4aVLiKiozbZ6/Iclx+VB+9XhguWvwmCt7zFnD7ozcF1z6JVATEPFlPG4tGNeRgwRuLip+GA==
X-Received: by 2002:a05:600c:29c2:: with SMTP id s2mr91958wmd.33.1590478574327; 
 Tue, 26 May 2020 00:36:14 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id g10sm20584765wrx.4.2020.05.26.00.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 00:36:13 -0700 (PDT)
Subject: Re: [PATCH v3 1/9] target/i386: Restrict X86CPUFeatureWord to X86
 targets
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
References: <20200525150640.30879-1-philmd@redhat.com>
 <20200525150640.30879-2-philmd@redhat.com>
 <87o8qb8aab.fsf@dusky.pond.sub.org>
 <8590aa71-d8a5-4aa8-3672-e1ccfa96bcbd@redhat.com>
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
Message-ID: <1f75c8d8-1e4d-a64d-9911-bdc747fd6475@redhat.com>
Date: Tue, 26 May 2020 09:36:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8590aa71-d8a5-4aa8-3672-e1ccfa96bcbd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 9:23 AM, Philippe Mathieu-Daudé wrote:
> On 5/26/20 8:45 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>
>>> Move out x86-specific structures from generic machine code.
>>>
>>> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  qapi/machine-target.json   | 45 ++++++++++++++++++++++++++++++++++++++
>>>  qapi/machine.json          | 42 -----------------------------------
>>>  target/i386/cpu.c          |  2 +-
>>>  target/i386/machine-stub.c | 22 +++++++++++++++++++
>>>  target/i386/Makefile.objs  |  3 ++-
>>>  5 files changed, 70 insertions(+), 44 deletions(-)
>>>  create mode 100644 target/i386/machine-stub.c
>>>
>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>> index f2c82949d8..fb7a4b7850 100644
>>> --- a/qapi/machine-target.json
>>> +++ b/qapi/machine-target.json
>>> @@ -3,6 +3,51 @@
>>>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
>>>  # See the COPYING file in the top-level directory.
>>>  
>>> +##
>>> +# @X86CPURegister32:
>>> +#
>>> +# A X86 32-bit register
>>> +#
>>> +# Since: 1.5
>>> +##
>>> +{ 'enum': 'X86CPURegister32',
>>> +  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ],
>>> +  'if': 'defined(TARGET_I386)' }
>>> +
>>> +##
>>> +# @X86CPUFeatureWordInfo:
>>> +#
>>> +# Information about a X86 CPU feature word
>>> +#
>>> +# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
>>> +#
>>> +# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
>>> +#                   feature word
>>> +#
>>> +# @cpuid-register: Output register containing the feature bits
>>> +#
>>> +# @features: value of output register, containing the feature bits
>>> +#
>>> +# Since: 1.5
>>> +##
>>> +{ 'struct': 'X86CPUFeatureWordInfo',
>>> +  'data': { 'cpuid-input-eax': 'int',
>>> +            '*cpuid-input-ecx': 'int',
>>> +            'cpuid-register': 'X86CPURegister32',
>>> +            'features': 'int' },
>>> +  'if': 'defined(TARGET_I386)' }
>>> +
>>> +##
>>> +# @DummyForceArrays:
>>> +#
>>> +# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
>>> +#
>>> +# Since: 2.5
>>> +##
>>> +{ 'struct': 'DummyForceArrays',
>>> +  'data': { 'unused': ['X86CPUFeatureWordInfo'] },
>>> +  'if': 'defined(TARGET_I386)' }
>>> +
>>>  ##
>>>  # @CpuModelInfo:
>>>  #
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index ff7b5032e3..1fe31d374c 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -511,48 +511,6 @@
>>>     'dst': 'uint16',
>>>     'val': 'uint8' }}
>>>  
>>> -##
>>> -# @X86CPURegister32:
>>> -#
>>> -# A X86 32-bit register
>>> -#
>>> -# Since: 1.5
>>> -##
>>> -{ 'enum': 'X86CPURegister32',
>>> -  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
>>> -
>>> -##
>>> -# @X86CPUFeatureWordInfo:
>>> -#
>>> -# Information about a X86 CPU feature word
>>> -#
>>> -# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
>>> -#
>>> -# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
>>> -#                   feature word
>>> -#
>>> -# @cpuid-register: Output register containing the feature bits
>>> -#
>>> -# @features: value of output register, containing the feature bits
>>> -#
>>> -# Since: 1.5
>>> -##
>>> -{ 'struct': 'X86CPUFeatureWordInfo',
>>> -  'data': { 'cpuid-input-eax': 'int',
>>> -            '*cpuid-input-ecx': 'int',
>>> -            'cpuid-register': 'X86CPURegister32',
>>> -            'features': 'int' } }
>>> -
>>> -##
>>> -# @DummyForceArrays:
>>> -#
>>> -# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
>>> -#
>>> -# Since: 2.5
>>> -##
>>> -{ 'struct': 'DummyForceArrays',
>>> -  'data': { 'unused': ['X86CPUFeatureWordInfo'] } }
>>> -
>>>  ##
>>>  # @NumaCpuOptions:
>>>  #
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 7a4a8e3847..832498c723 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -37,7 +37,7 @@
>>>  #include "qemu/option.h"
>>>  #include "qemu/config-file.h"
>>>  #include "qapi/error.h"
>>> -#include "qapi/qapi-visit-machine.h"
>>> +#include "qapi/qapi-visit-machine-target.h"
>>>  #include "qapi/qapi-visit-run-state.h"
>>>  #include "qapi/qmp/qdict.h"
>>>  #include "qapi/qmp/qerror.h"
>>> diff --git a/target/i386/machine-stub.c b/target/i386/machine-stub.c
>>> new file mode 100644
>>> index 0000000000..cb301af057
>>> --- /dev/null
>>> +++ b/target/i386/machine-stub.c
>>> @@ -0,0 +1,22 @@
>>> +/*
>>> + * QAPI x86 CPU features stub
>>> + *
>>> + * Copyright (c) 2020 Red Hat, Inc.
>>> + *
>>> + * Author:
>>> + *   Philippe Mathieu-Daudé <philmd@redhat.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>> + * See the COPYING file in the top-level directory.
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "qapi/qapi-visit-machine-target.h"
>>> +
>>> +void visit_type_X86CPUFeatureWordInfoList(Visitor *v, const char *name,
>>> +                                      X86CPUFeatureWordInfoList **obj,
>>> +                                      Error **errp)
>>
>> Unusual indentation.
>>
>>> +{
>>> +}
>>
>> Two kinds of stubs: stubs that can get called, and stubs that exist only
>> to satisfy the linker.  Which kind is this one?
> 
> I suppose "stubs that exist only to satisfy the linker" must abort if
> ever called...

Link problem when building linux-user:

  LINK    i386-linux-user/qemu-i386
/usr/bin/ld: target/i386/cpu.o: in function `x86_cpu_get_feature_words':
target/i386/cpu.c:4627: undefined reference to
`visit_type_X86CPUFeatureWordInfoList'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:208: qemu-i386] Error 1
make: *** [Makefile:527: i386-linux-user/all] Error 2

Various properties from x86_cpu_initfn() should be removed from
user-mode (tsc/stepping/kvm/...) but I'll let that to some x86 specialist.

> 
>>
>>> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
>>> index 48e0c28434..1cdfc9f50c 100644
>>> --- a/target/i386/Makefile.objs
>>> +++ b/target/i386/Makefile.objs
>>> @@ -17,6 +17,7 @@ obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-posix.o
>>>  endif
>>>  obj-$(CONFIG_HVF) += hvf/
>>>  obj-$(CONFIG_WHPX) += whpx-all.o
>>> -endif
>>> +endif # CONFIG_SOFTMMU
>>>  obj-$(CONFIG_SEV) += sev.o
>>>  obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
>>> +obj-$(call lnot,$(CONFIG_SOFTMMU)) += machine-stub.o
>>
>> Suggest
>>
>>    ifeq ($(CONFIG_SOFTMMU),y)
>>    ...
>>    else
>>    obj-y += machine-stub.o
>>    endif
>>
>> Matter of taste.
>>
> 
> OK
> 


