Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA00C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F0B2085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECqc2aqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F0B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNvmi-0000Qt-5U
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 06:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNvkt-00081v-I0
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNvkr-0000M3-05
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601547842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4zdrZ95qTMqjyDQ7NmIEXDiSPD0rjBNhZXraWN8m/w0=;
 b=ECqc2aqD2/szA5ZQsRzszhqwndL7hIpUKi9JZx30zX5tORP7z9rx8f7EQLQnDJF/kbF7QA
 F+kwytVg/VES2nYFIyVsRecBVVxZTFkSYkFKjuWGgZctREbSu5HWVQuMzQPhXXgzpPYW5h
 i9LVBV/dxSONhBkLHrkOvEqJpvYLYN4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-AyWm9-qTNq-LLJnSG9OIgg-1; Thu, 01 Oct 2020 06:23:59 -0400
X-MC-Unique: AyWm9-qTNq-LLJnSG9OIgg-1
Received: by mail-wr1-f70.google.com with SMTP id b2so1844707wrs.7
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 03:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4zdrZ95qTMqjyDQ7NmIEXDiSPD0rjBNhZXraWN8m/w0=;
 b=EUu0dYbbeLHm3Qi1GMXJ7upy9w52lT/6lvMpl8bci/yEDukV4Xtq5WBcHpMvecDef2
 bhLu7rbrB8ZXMu+9rbyDIL0eGih6O1fRpyJLDmYa4Ba258cMUEnyZmap0X+IQtVmCFzo
 ugkHR8RhegW2p0l6ROrZL0uQg/IIkdec/7o3usdZK0GlfGRYQ6Y7monAZJE6Uo+T+bHH
 jsuMt2GusDWtPVHQiSCwaCseGPkrecwXuwDHsR8TR0hKodufNg0y2JLWJ2izJiODekmd
 UyEA9eS3Evw4VDFb6kjcuJ6xndLN5tQAccUBApMF/obmSWstIwC5XPtLaxcHichQBdV8
 1Nlg==
X-Gm-Message-State: AOAM533HWtvcsJLpl/TrSvu9gwY4aeoZqd0HJOqcPtmDcsMWJNkG9kt1
 6bY5OFYD8hxkNYv4jXautKzXXReZxVmGJwc6ylYVC2gUeOUtKEBU4XtzC4AVoJk3TeB34wd7fXZ
 Z86YfckU0RucgGSc=
X-Received: by 2002:a1c:1f87:: with SMTP id f129mr6895045wmf.182.1601547838698; 
 Thu, 01 Oct 2020 03:23:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWQOkMtKLqSe56Pj8VY8Poh2h0StrS0bpo9vhDFkU5e4Dw31dTdF38UeeXMEmWwfPXeQYpZg==
X-Received: by 2002:a1c:1f87:: with SMTP id f129mr6895008wmf.182.1601547838383; 
 Thu, 01 Oct 2020 03:23:58 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id m12sm7419813wml.38.2020.10.01.03.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 03:23:57 -0700 (PDT)
Subject: Re: [PATCH v3 11/11] qapi: Restrict code generated for user-mode
To: Markus Armbruster <armbru@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
 <20200930164949.1425294-12-philmd@redhat.com>
 <87mu164jnr.fsf@dusky.pond.sub.org>
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
Message-ID: <8bdc109f-bbd1-fe8c-905d-039f5b4dea0f@redhat.com>
Date: Thu, 1 Oct 2020 12:23:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87mu164jnr.fsf@dusky.pond.sub.org>
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
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 7:09 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> A lot of QAPI generated code is never used by user-mode.
>>
>> Split out qapi_system_modules and qapi_system_or_tools_modules
>> from the qapi_all_modules array. We now have 3 groups:
>> - always used
>> - use by system-mode or tools (usually by the block layer)
>> - only used by system-mode
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> Resetting due to Meson update:
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  qapi/meson.build | 51 ++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 36 insertions(+), 15 deletions(-)
>>
>> diff --git a/qapi/meson.build b/qapi/meson.build
>> index 7c4a89a882..ba9677ba97 100644
>> --- a/qapi/meson.build
>> +++ b/qapi/meson.build
>> @@ -14,39 +14,60 @@ util_ss.add(files(
>>  ))
>>  
>>  qapi_all_modules = [
>> +  'common',
>> +  'introspect',
>> +  'misc',
>> +]
>> +
>> +qapi_system_modules = [
>>    'acpi',
>>    'audio',
>> +  'dump',
>> +  'machine-target',
>> +  'machine',
>> +  'migration',
>> +  'misc-target',
>> +  'net',
>> +  'pci',
>> +  'qdev',
>> +  'rdma',
>> +  'rocker',
>> +  'tpm',
>> +  'trace',
>> +]
>> +
>> +# system or tools
>> +qapi_block_modules = [
>>    'authz',
>>    'block-core',
>>    'block',
>>    'char',
>> -  'common',
>>    'control',
>>    'crypto',
>> -  'dump',
>>    'error',
>> -  'introspect',
>>    'job',
>> -  'machine',
>> -  'machine-target',
>> -  'migration',
>> -  'misc',
>> -  'misc-target',
>> -  'net',
>>    'pragma',
>> -  'qdev',
>> -  'pci',
>>    'qom',
>> -  'rdma',
>> -  'rocker',
>>    'run-state',
>>    'sockets',
>> -  'tpm',
>> -  'trace',
>>    'transaction',
>>    'ui',
>>  ]
> 
> Most of these aren't "block modules".  Name the thing
> qapi_system_or_tools_modules?

This is why I used first, then realized this is defined
as:
  have_block = have_system or have_tools

> 
>> +if have_system
>> +  qapi_all_modules += qapi_system_modules
>> +elif have_user
>> +  # Temporary kludge because X86CPUFeatureWordInfo is not
>> +  # restricted to system-mode. This should be removed (along
>> +  # with target/i386/feature-stub.c) once target/i386/cpu.c
>> +  # has been cleaned.
>> +  qapi_all_modules += ['machine-target']
>> +endif
>> +
>> +if have_block
> 
> Aha, precedence for using "block" as an abbreviation of "system or
> tools".  I find that confusing.

I'll use qapi_system_or_tools_modules back, it is clearer, thanks.

> 
>> +  qapi_all_modules += qapi_block_modules
>> +endif
>> +
>>  qapi_storage_daemon_modules = [
>>    'block-core',
>>    'char',
> 


