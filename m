Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A28C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131F3206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFG0l96j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131F3206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh6m8-0004gz-9x
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6lG-0003e3-Of
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:27:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6lE-0002oI-GE
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tybi2ZVwmh88PyJ0AkN/Q0poJQghP28md8ybzIXTuRg=;
 b=XFG0l96jlt5jzStbrA03lvVL4Q5FxUsP56R6yTrw2+GaoErh9CvNqC8a4ZbbIX5eGHsaiU
 PcGLfCokh0thfXaJtpxgBgksvDSURGiMpXKkF0UPlLlm2+ddQmFPsN7z7goKNWK9ivB4wm
 8LlUpWug81Vv5izJY+CM1d2YVMTnIPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-8vST0Bl2Pcq-a-eL1FoI8A-1; Fri, 05 Jun 2020 03:27:24 -0400
X-MC-Unique: 8vST0Bl2Pcq-a-eL1FoI8A-1
Received: by mail-wm1-f72.google.com with SMTP id v23so2685454wmj.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tybi2ZVwmh88PyJ0AkN/Q0poJQghP28md8ybzIXTuRg=;
 b=XrIBEmOgReY2gXD86HcKFBSVsKuBvhcyBB5VjX/recG2S2TU5RtC87m+S5vYZKgEv/
 nLigaigtCwuaavnRHFu5OnS3dfpyoBtrSsG9DEjuQzwggJ1T3JZG/3KnazFuWdfheXUC
 teBRuSLD71oWUR0EU9K9EzNVrAxIKiHMgGo1+unY3SWFkCYYXLCUhabldKJmLeXOnfSQ
 pvQSbAsGIRCNXF0gRBC1HzCS5SaMRvYpuhhNdzRb/4RMLYL/M8hdKpugmOod4cTjG5Rf
 2NyS7mIKEqjMyFSgaBoME/dx5YrafQmfkeCAcOY/KYa/U+yUFo+f4NhIwKvFJU9hVcu2
 tmNg==
X-Gm-Message-State: AOAM531qy9DUObpbdszo0ewh55CHVawg+Df4tkvf96yD/79usGjb27i/
 CbS1ly6NgJAyCbVay7H1zIjv2mqfXLk6G/RyZoQlYM3OcZBd0ifl5P3v8A5tR+nNiUmXo/4pRSM
 J0nVZcvKAaGvL8T4=
X-Received: by 2002:a05:6000:1192:: with SMTP id
 g18mr8546714wrx.326.1591342043503; 
 Fri, 05 Jun 2020 00:27:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrBWKJ+BIpZU1TEyuUgCPhs2O6SmzhMBvvkPkY/DMeUBH6nejr8N03WFuEBMAkCX+BUaJ4ew==
X-Received: by 2002:a05:6000:1192:: with SMTP id
 g18mr8546692wrx.326.1591342043245; 
 Fri, 05 Jun 2020 00:27:23 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id b201sm10154829wmb.36.2020.06.05.00.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 00:27:22 -0700 (PDT)
Subject: Re: [PATCH v4 05/11] rules.mak: Add base-arch() rule
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200522163759.11480-1-philmd@redhat.com>
 <20200522163759.11480-6-philmd@redhat.com>
 <9e83f0de-871b-9fc7-6489-d4a94ff0066c@linaro.org>
 <8ed29bf2-4687-9ee7-c209-fd03faac555e@redhat.com>
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
Message-ID: <e338f759-7a68-92a3-17f1-0181a79db362@redhat.com>
Date: Fri, 5 Jun 2020 09:27:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8ed29bf2-4687-9ee7-c209-fd03faac555e@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 9:26 AM, Philippe Mathieu-Daudé wrote:
> On 6/1/20 4:13 AM, Richard Henderson wrote:
>> On 5/22/20 9:37 AM, Philippe Mathieu-Daudé wrote:
>>> +		      $(if $(call startwith,risc,$1),risc,\
>>
>> Should be "riscv" not "risc".  Especially the substitution.
> 
> Indeed.
> 
>>
>>> +		        $(if $(call startwith,aarch64,$1),arm,\
>>> +		          $(if $(call startwith,x86_64,$1),i386,\
>>
>> We don't have an exact equality function?

For aarch64_be we want to use startwith(). I'll update x86_64.

> 
> There is this one which returns y/n:
> 
>   # String testing functions: inputs to these can be any string;
>   # the output is always either "y" or "n". Leading and trailing whitespace
>   # is ignored when comparing strings.
>   # String equality
>   eq = $(if $(subst $2,,$1)$(subst $1,,$2),n,y)
> 
> I'll add a simpler strequal().
> 


