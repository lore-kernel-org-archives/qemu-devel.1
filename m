Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F85C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 08:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525FE20781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 08:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdcpUp4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525FE20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k68CE-0005hL-Fn
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 04:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k68AA-0003UD-JD
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 04:00:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k68A8-0004Zw-Tq
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 04:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597305634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1F0XFjUEO1ENmnOtiDE8Y6OjvYI9hKO/fGZo7X1xEMM=;
 b=FdcpUp4TM9L5WdcMWhRP17SdMjwSDaBQ8X2riINU7iy0lzpFKa04ICau3PTWMRvlPVOnvj
 lESH5OoLZ/5Ln/s0CXjXWc6Sp1U3hLTqPkG8ooSGSEEow95S6HbCTAP7lQrGGajyL+84YW
 PUxeIAtgjp5xvSVOp1oDoNkYK1Nj8Z0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-W2VfSErTMgGSClN4WWIfmw-1; Thu, 13 Aug 2020 04:00:32 -0400
X-MC-Unique: W2VfSErTMgGSClN4WWIfmw-1
Received: by mail-wr1-f72.google.com with SMTP id j2so1748941wrr.14
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 01:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1F0XFjUEO1ENmnOtiDE8Y6OjvYI9hKO/fGZo7X1xEMM=;
 b=cNBB2bIbP4bFbfHdeBJ6gp2qShrrz7zYWbitreWyxOM+vDC/bxGUrmek5vWuk9YAmc
 u/KAXqneNt7mRENrEVMxnS37p3KvBvTqBc1YikMAIi8tqP6tF++XcJ2C9IxbpJRntQGh
 E/QoPw1kQnK/tFRpoBQeZ61OJqyijcb3t71uIamtCzUHGk4ln5V+al2vgnvFavEyPQ4X
 siPxnFXp378LBf08RQWVEbSxSSpuOECDTZwgZeZUIO2YVnUe2/QNSB7yJzOT5QmCH4xX
 D1jCaQcTpuompSLkTdqhIqx+cBWh8Kr8g1nQNYgzNAnE+O5oko7wSIm+BpdJ8PF3XkbY
 eDCA==
X-Gm-Message-State: AOAM532+3kpKOjPFjIEvgbUnRNkbfh0h1ePFdMN+BzZBQ/ovQ+MFlAJK
 yIWPNBdiDulhgkIQ51MlM8GdSxm5t9C13rnGEO8mF9u6wTWZ/a3yad7KHP1jOC0EiilcIt411KW
 H+mr5jl2z26JQ6GM=
X-Received: by 2002:adf:82f6:: with SMTP id 109mr3036411wrc.25.1597305631020; 
 Thu, 13 Aug 2020 01:00:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOG+ACss71R3y+n/+c6GsL83s4F0UU05QHggYs95iyLVyYMf1MsymrV4vBuQQSpDpnuujJ+Q==
X-Received: by 2002:adf:82f6:: with SMTP id 109mr3036402wrc.25.1597305630795; 
 Thu, 13 Aug 2020 01:00:30 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id a11sm9266224wrq.0.2020.08.13.01.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 01:00:30 -0700 (PDT)
Subject: Re: [PATCH 04/17] crypto: Rename cipher include files to .inc.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
 <20200813032537.2888593-5-richard.henderson@linaro.org>
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
Message-ID: <5f63fcf7-2170-6671-f086-36716147ae3a@redhat.com>
Date: Thu, 13 Aug 2020 10:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813032537.2888593-5-richard.henderson@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:21
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 5:25 AM, Richard Henderson wrote:
> QEMU standard procedure for included c files is to use *.inc.c.
> E.g. there are a different set of checks that are applied.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  crypto/{cipher-builtin.c => cipher-builtin.inc.c} | 0
>  crypto/{cipher-gcrypt.c => cipher-gcrypt.inc.c}   | 0
>  crypto/{cipher-nettle.c => cipher-nettle.inc.c}   | 0
>  crypto/cipher.c                                   | 6 +++---
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename crypto/{cipher-builtin.c => cipher-builtin.inc.c} (100%)
>  rename crypto/{cipher-gcrypt.c => cipher-gcrypt.inc.c} (100%)
>  rename crypto/{cipher-nettle.c => cipher-nettle.inc.c} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
(This clashes with Paolo's Meson series renaming them to .c.inc).


