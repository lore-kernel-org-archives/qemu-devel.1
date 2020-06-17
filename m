Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7153C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935E6206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qk+WpFRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935E6206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSE9-0006Ip-SB
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlSDN-0005XM-Jm
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:10:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlSDK-0000HY-Ty
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592377825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=137Z9tOGjHfBmjSzUcWbWz28Qb37PLWVPUV/26a1rek=;
 b=Qk+WpFRe7NQKOYMCsf+eFK8LOE+yCln47RxfDnMRqjnY2NxRCf28cKMZKC3O8PRJBiTQN1
 iFdDh5UkWB8acaJxPqavG+s8vCDoTHTKbzK6fz0zcguCL/jUzHSgGUjspVtCRZ29kRe7VA
 Pkz3YzgSKnN89BRQNU73bb7lRBn5OSE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-C3ZGEQ_NNoiindlE7I-CCQ-1; Wed, 17 Jun 2020 03:10:20 -0400
X-MC-Unique: C3ZGEQ_NNoiindlE7I-CCQ-1
Received: by mail-wr1-f70.google.com with SMTP id s7so585399wrm.16
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 00:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=137Z9tOGjHfBmjSzUcWbWz28Qb37PLWVPUV/26a1rek=;
 b=itYQAKi8WdSVDz0XgcEYR8No/W7etMas93iTCdG2xbaMfgMb6JBc6QwYgdxcod5Ebl
 T10//7py5myrW8/dlqf27owea5Yy+PqaxlD9lhrunsDJJmih6SOY+yW2M9JmA59wvBLa
 TKObTbSwQoeVQYy/2UvUC1QQwcPS7TGCtxQAY71agyserY+Wj8bubNPG/Y+CR/Mi0bBA
 G/EaZGKXmqIyG+9DOhc6anDTdXinqeXjVhjXa6zCKcHqYgMv4VW7J9sM2HX8bB+ZkRjQ
 L0DHoSgGXxOBTKVjQJJ1RW5M7z3hlXv6xXoMOmZLVyjdnBu+D0ee+ACdPUMUIuDjrHEi
 nl5w==
X-Gm-Message-State: AOAM53003pyuiNL1EZqyNMzQvnhfvbdsmbcT8ADRYEY0PRWQ2jQ5DjJh
 1IRhOjQzbL7jbpGROokq7tfC7aLFOgsv8zrCyf9RIQlx5F55latz2YzYxFod1Jfgv5l1OAqoifF
 sDD7ZBwP3SEXO8ZI=
X-Received: by 2002:adf:91c2:: with SMTP id 60mr7356337wri.41.1592377819004;
 Wed, 17 Jun 2020 00:10:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTIswmUHdD0jdrEnwoEv7wLZjKNjY7ljWZcNBxgdi+kfvKbWVnrLjttWvAi+CXVEz8nH5bhg==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr7356320wri.41.1592377818791;
 Wed, 17 Jun 2020 00:10:18 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id c12sm6803153wml.39.2020.06.17.00.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 00:10:18 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] configure: Add -Wno-psabi
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200617043757.1623337-1-richard.henderson@linaro.org>
 <20200617043757.1623337-6-richard.henderson@linaro.org>
 <f552106e-30eb-950f-56da-2f6bf3f29279@redhat.com>
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
Message-ID: <47f955b4-a47a-881f-0071-5ce36eabf990@redhat.com>
Date: Wed, 17 Jun 2020 09:10:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f552106e-30eb-950f-56da-2f6bf3f29279@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 8:50 AM, Philippe Mathieu-Daudé wrote:
> On 6/17/20 6:37 AM, Richard Henderson wrote:
>> On aarch64, gcc 9.3 is generating
>>
>> qemu/exec.c: In function ‘address_space_translate_iommu’:
>> qemu/exec.c:431:28: note: parameter passing for argument of type \
>>   ‘MemTxAttrs’ {aka ‘struct MemTxAttrs’} changed in GCC 9.1
>>
>> and many other reptitions.  This structure, and the functions
> 
> Typo "repetitions".
> 
>> amongst which it is passed, are not part of a QEMU public API.
>> Therefore we do not care how the compiler passes the argument,
>> so long as the compiler is self-consistent.
>>
>> The only portion of QEMU which does have a public api, and so
>> must have a stable abi, is "qemu/plugin.h".  We test this by
>> forcing -Wpsabi in tests/plugin/Makefile.
>>
>> Cc: Alex Bennée <alex.bennee@linaro.org>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1881552
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Err I meant:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  configure             | 1 +
>>  tests/plugin/Makefile | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 5e27229f58..ba88fd1824 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2055,6 +2055,7 @@ add_to nowarn_flags -Wno-shift-negative-value
>>  add_to nowarn_flags -Wno-string-plus-int
>>  add_to nowarn_flags -Wno-typedef-redefinition
>>  add_to nowarn_flags -Wno-tautological-type-limit-compare
>> +add_to nowarn_flags -Wno-psabi
>>  
>>  gcc_flags="$warn_flags $nowarn_flags"
>>  
>> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
>> index b3250e2504..3a50451428 100644
>> --- a/tests/plugin/Makefile
>> +++ b/tests/plugin/Makefile
>> @@ -17,7 +17,7 @@ NAMES += lockstep
>>  
>>  SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
>>  
>> -QEMU_CFLAGS += -fPIC
>> +QEMU_CFLAGS += -fPIC -Wpsabi
>>  QEMU_CFLAGS += -I$(SRC_PATH)/include/qemu
>>  
>>  all: $(SONAMES)
>>
> 


