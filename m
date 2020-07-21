Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6C3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED42C20684
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJzMK5dL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED42C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxntt-0000hy-8g
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxnsU-0007vo-Tb
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:43:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40481
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxnsT-0001VK-8z
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595321036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GlG9i2J+IEjX6x7IfODje7F40/8JRikm7iAc4Im5ybQ=;
 b=eJzMK5dLAkrkCXP5FL8jJQZZERqQh9Es6dBCErWXZdsl/lIavFx5kzxC3zsTQmRsgiNRPB
 cFMwx41/liv25AtrGpOlJy32j6kgmmHQc3+XBZEM4/tboWOmU0txoKyQtibAFNBUi4sidV
 eRlBObo8qjQEXzKK4oX6eQJgDmslqCQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-xo2IwQGfODS4-JuZeHtUtA-1; Tue, 21 Jul 2020 04:43:53 -0400
X-MC-Unique: xo2IwQGfODS4-JuZeHtUtA-1
Received: by mail-wr1-f71.google.com with SMTP id y18so12896128wrq.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 01:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GlG9i2J+IEjX6x7IfODje7F40/8JRikm7iAc4Im5ybQ=;
 b=HooDQ+rjzEadPqT4a7Mgs9GAHX5BN2cxHNVnW/fPFn9e98jJrvHTNfwFgm/T1cLjGw
 QAACrsxsToUyaEr4pF2bDWHOGxtvN/axE33GCloInHt0cCy8lD4SZGBbB8gARjKGgukk
 30yg5tU2R68GOwTjjM/AoHlpbrXc4iiHeXvk2600vuMTQu0cUDyEvnZUslj4d3tHwXZP
 Ew6yW0aJc4tOooQrpe4d4AepELoXtxgTgBri8dDvrzpeLPZkFcIzhEHw1KFJVxlr9gqW
 dWQ4uxeosbBaNbFjZHay/OHZZvMkXovTT5Db/kX/CBcyP/fYio09nmfZAGs67JduHrP/
 4gbQ==
X-Gm-Message-State: AOAM530fuQfB/GJsraVHhTXlhVadfNAn4M24YQyPGX0iYsk+aNWeNRMl
 /KdBnFyI/k4LYv9QH2bz8h4daUpBjYNOlmkm/kMWysuvfOjxKqJxjpMeYOa9rWYntCzzHOFyyc8
 9votMvtgF56iGwS4=
X-Received: by 2002:a5d:440e:: with SMTP id z14mr7730735wrq.422.1595321032429; 
 Tue, 21 Jul 2020 01:43:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmWCZ3qlpeiNwo+HgrErUAM1ojJoxtN6EFFcYfDP26aP9zKRfV8M9x02HdmOJVWIRdrG7rfA==
X-Received: by 2002:a5d:440e:: with SMTP id z14mr7730715wrq.422.1595321032198; 
 Tue, 21 Jul 2020 01:43:52 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id r8sm36287958wrp.40.2020.07.21.01.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 01:43:51 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Extend the device fuzzing section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>
References: <20200721053926.17197-1-thuth@redhat.com>
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
Message-ID: <8ee0ccf9-1389-c1e5-eeb3-e754df5f50c9@redhat.com>
Date: Tue, 21 Jul 2020 10:43:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200721053926.17197-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 7:39 AM, Thomas Huth wrote:
> The file docs/devel/fuzzing.txt should be in this section, too, and add
> myself as a reviewer (since I often take the fuzzer patches through the
> qtest-next tree, I should be notified on patches, too).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 030faf0249..6118fd0b60 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2445,9 +2445,11 @@ M: Alexander Bulekov <alxndr@bu.edu>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  R: Bandan Das <bsd@redhat.com>
>  R: Stefan Hajnoczi <stefanha@redhat.com>
> +R: Thomas Huth <thuth@redhat.com>
>  S: Maintained
>  F: tests/qtest/fuzz/
>  F: scripts/oss-fuzz/
> +F: docs/devel/fuzzing.txt
>  
>  Register API
>  M: Alistair Francis <alistair@alistair23.me>
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


