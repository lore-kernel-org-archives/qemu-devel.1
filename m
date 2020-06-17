Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E57FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5A92080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1SX40Aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5A92080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlRvK-000813-43
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 02:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlRuj-0007c6-9K
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:51:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlRue-0005XG-IT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592376667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HrQ1UaKliPz1cTvhrIRYC6ytwhotaF/nysfkgINR73k=;
 b=E1SX40AqrLtcbcJ6zjyqC4hwpWSz0PxW6g6ta51rlJ4UfAHD+w4mSNNCwcYpSTF9ichulF
 15MiNnKriqgh1xYqFQyM4AsgI7oq7MHukJZSund+PAfjb7ock+MzmRFdru050npThmm2Yl
 4ydXbTTKRpGFSoIEZ+9N7JAYPbtxGB8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-SbH4HoZ1OyiQ_mnmCAUv-g-1; Wed, 17 Jun 2020 02:51:02 -0400
X-MC-Unique: SbH4HoZ1OyiQ_mnmCAUv-g-1
Received: by mail-wm1-f72.google.com with SMTP id y15so273436wmi.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 23:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HrQ1UaKliPz1cTvhrIRYC6ytwhotaF/nysfkgINR73k=;
 b=c7bAbB0713yARwwVaA3E2anG6UIMA5FbrC440Hf/8Un3ueQ8mR+ihcr73RAGqlYcAw
 by18htD/vmlKSHkT7kXKY7PtxvuLiHY5AQWX0ggHHriYjeUmLP6VReK5BqnjftCNDLka
 smBFh/000+lvvb4gyHzgGKwPbCPJvXPnowxj0ZecmUXe58eqvUH0cXezPrWi6/7obZYw
 370KZWjVsgDPC7blOuAyy26OGKhN4GqW0bdFWLFXkC4IJFkRvwW/4Tz4hCKtVnKGnBzt
 H3LA3e8R1pKk+YhOc1hqL4Evv+JEA6+j8B63sGuf3OnaGypzy3W9U5596XvmGw+F5rTA
 8Tew==
X-Gm-Message-State: AOAM530x9KtppCuoZsBR0qCcOG3F4H4B110TlaWhaIt/xXAn1GtoPa/m
 gyqLBg0NwMOOZwzIUtAikAIl2psnwy6Zq3z+MFu+gPGhoPu6QTM5P/tHAAkPwsiw7aZMX3pGk3/
 5QfbqHvGvNfD8Fe4=
X-Received: by 2002:a1c:2506:: with SMTP id l6mr7062613wml.34.1592376661618;
 Tue, 16 Jun 2020 23:51:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQepyx5LQbFt7Q4YIat1X1Mz3NJqyulWjmLQbiZi2qzHstKEfpqg2rWHt+6oRRhdP9t7CL2g==
X-Received: by 2002:a1c:2506:: with SMTP id l6mr7062596wml.34.1592376661369;
 Tue, 16 Jun 2020 23:51:01 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id o20sm33796263wra.29.2020.06.16.23.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 23:51:00 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] configure: Add -Wno-psabi
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200617043757.1623337-1-richard.henderson@linaro.org>
 <20200617043757.1623337-6-richard.henderson@linaro.org>
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
Message-ID: <f552106e-30eb-950f-56da-2f6bf3f29279@redhat.com>
Date: Wed, 17 Jun 2020 08:50:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200617043757.1623337-6-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
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

On 6/17/20 6:37 AM, Richard Henderson wrote:
> On aarch64, gcc 9.3 is generating
> 
> qemu/exec.c: In function ‘address_space_translate_iommu’:
> qemu/exec.c:431:28: note: parameter passing for argument of type \
>   ‘MemTxAttrs’ {aka ‘struct MemTxAttrs’} changed in GCC 9.1
> 
> and many other reptitions.  This structure, and the functions

Typo "repetitions".

> amongst which it is passed, are not part of a QEMU public API.
> Therefore we do not care how the compiler passes the argument,
> so long as the compiler is self-consistent.
> 
> The only portion of QEMU which does have a public api, and so
> must have a stable abi, is "qemu/plugin.h".  We test this by
> forcing -Wpsabi in tests/plugin/Makefile.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>

Buglink: https://bugs.launchpad.net/qemu/+bug/1881552

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure             | 1 +
>  tests/plugin/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 5e27229f58..ba88fd1824 100755
> --- a/configure
> +++ b/configure
> @@ -2055,6 +2055,7 @@ add_to nowarn_flags -Wno-shift-negative-value
>  add_to nowarn_flags -Wno-string-plus-int
>  add_to nowarn_flags -Wno-typedef-redefinition
>  add_to nowarn_flags -Wno-tautological-type-limit-compare
> +add_to nowarn_flags -Wno-psabi
>  
>  gcc_flags="$warn_flags $nowarn_flags"
>  
> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
> index b3250e2504..3a50451428 100644
> --- a/tests/plugin/Makefile
> +++ b/tests/plugin/Makefile
> @@ -17,7 +17,7 @@ NAMES += lockstep
>  
>  SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
>  
> -QEMU_CFLAGS += -fPIC
> +QEMU_CFLAGS += -fPIC -Wpsabi
>  QEMU_CFLAGS += -I$(SRC_PATH)/include/qemu
>  
>  all: $(SONAMES)
> 


