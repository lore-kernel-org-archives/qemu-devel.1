Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9907BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7378D20842
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxZjrdBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7378D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k312O-0001YG-I8
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k311N-0000VO-QZ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:46:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54908
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k311L-0003Od-56
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596563196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bKjAfbJmAwUkarfRQDziIeme9uZbnos7hOSKdwNKhz8=;
 b=RxZjrdBmeKf4yVIMytlZydmYwXuWcIODfTzLmX6GVvNQ93HvCeeUgXgrDV0mDinqa3A3nc
 WxOD9FCBVbyOHL5sBs0LE2xGsUkxuOW3tcOkQ1dnbibi1UrsI39o7Ie2wFfpf6MTHICgtv
 QkBke0+UfjFkMqa7qWJPXPjJ4yE9yYQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-o-ts-ud9POyrqHgQqtmwgQ-1; Tue, 04 Aug 2020 13:46:35 -0400
X-MC-Unique: o-ts-ud9POyrqHgQqtmwgQ-1
Received: by mail-ed1-f72.google.com with SMTP id v11so11278333edr.13
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 10:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bKjAfbJmAwUkarfRQDziIeme9uZbnos7hOSKdwNKhz8=;
 b=L5EIpUx5EpPpjgrxXWLYhXMsv2H7m0iwxBpH32hY1s+5xrLUds6lQpVfkmz+Bom31p
 DNSO6c8hmVYzkwzFHRdKfDJp6xBE2grm2yOY4/HKOq7zN1iEUouLipUBfTgTWBHtHlwH
 VEirMGOQDmZHDrh0Eie5ZvmWIU5QgPWqZJL/j1NlplWY5jB9Wo2zBMkHl2mT2sjAx1kt
 kO9Qo1MZTO9TSe2d2+ysCSSKnmZ9Mb+T0Q8DwXwvBZS09FhQM9uX126Eo5HLNk2Rrz/m
 1yp2XjIjmFy0EKWUVvcC4Dv7Ow1tpoRcpqOJiBrG6RTkgydR4v1QiG1UKCxuz+oyln4U
 L+DA==
X-Gm-Message-State: AOAM530Xd4dsOD33imp1nq6sANW3LTa8+r8l7st+etE2Vdq0MkSBsNN1
 vwss38HCIiHkcg0VeFVor16R1a8z3LGP3A6GNHez5pLF212SoB1Aq4do2pVe4WvJmVtLIa1meiX
 Kt1NxqhTWk26sTm0=
X-Received: by 2002:a17:906:840c:: with SMTP id
 n12mr21671372ejx.246.1596563193952; 
 Tue, 04 Aug 2020 10:46:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaLXZ2TkNYmMFoy1bQCBW0RGUslIld7c8HBvC3+DyNKQXtMViVMa+1vUwg4e9G/9UfKQPyhA==
X-Received: by 2002:a17:906:840c:: with SMTP id
 n12mr21671352ejx.246.1596563193706; 
 Tue, 04 Aug 2020 10:46:33 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id ec20sm17338143ejb.61.2020.08.04.10.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 10:46:33 -0700 (PDT)
Subject: Re: [PATCH 02/11] target/riscv/vector_helper: Fix build on 32-bit big
 endian targets
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-3-thuth@redhat.com>
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
Message-ID: <d5425284-1c12-ca0a-51b9-aecd592b0cbe@redhat.com>
Date: Tue, 4 Aug 2020 19:46:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200804170055.2851-3-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 7:00 PM, Thomas Huth wrote:
> The code currently fails to compile on 32-bit big endian targets:

s/target/host/ here and in subject?

> 
>  target/riscv/vector_helper.c: In function 'vext_clear':
>  target/riscv/vector_helper.c:154:16: error: cast to pointer from integer
>  of different size [-Werror=int-to-pointer-cast]
>          memset((void *)((uintptr_t)tail & ~(7ULL)), 0, part1);
>                 ^
>  target/riscv/vector_helper.c:155:16: error: cast to pointer from integer
>  of different size [-Werror=int-to-pointer-cast]
>          memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 0, part2);
>                 ^
>  cc1: all warnings being treated as errors
> 
> We should not use "long long" (i.e. 64-bit) values here to avoid the
> problem. Switch to our QEMU_ALIGN_PTR_DOWN/UP macros instead.
> 
> Fixes: 751538d5da ("add vector stride load and store instructions")
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/riscv/vector_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 39f44d1029..793af99067 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -151,8 +151,8 @@ static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
>      if (cnt % 8) {
>          part1 = 8 - (cnt % 8);
>          part2 = tot - cnt - part1;
> -        memset((void *)((uintptr_t)tail & ~(7ULL)), 0, part1);
> -        memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 0, part2);
> +        memset(QEMU_ALIGN_PTR_DOWN(tail, 8), 0, part1);
> +        memset(QEMU_ALIGN_PTR_UP(tail, 8), 0, part2);
>      } else {
>          memset(tail, 0, part2);
>      }
> 


