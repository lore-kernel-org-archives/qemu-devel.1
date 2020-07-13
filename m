Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8431C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837FF2065D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw+j+woi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837FF2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juthv-0008T6-Qf
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juthA-0007kv-G0
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:20:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juth8-0006CP-Qm
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594628413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sbmh9v/hChKBJOycm+B1Xp6giE+mRd5PmiuYtr1IKB0=;
 b=Zw+j+woiaeOh59UgOi5vTLH2zW/xkKA8XfoYERkbID76c+FF4MOomYDzjfbthkHRtScPq+
 XFuamzLbVnANs8fRG4gmWYZluxQC1jmab7UCHFEkeaAU2bYTHx/uz1tkn5y/VRybfel6PM
 2HRsckJp4ZEX3ObZyGVJ2bpmqC2xv0o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-JrAXKwG0Of2fnOOzq7GngQ-1; Mon, 13 Jul 2020 04:20:12 -0400
X-MC-Unique: JrAXKwG0Of2fnOOzq7GngQ-1
Received: by mail-wr1-f69.google.com with SMTP id 89so16859277wrr.15
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 01:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=sbmh9v/hChKBJOycm+B1Xp6giE+mRd5PmiuYtr1IKB0=;
 b=jmT3ifAGicgN3M0x8RejazsJW69F4aYT42U2VKN6mnNa+DO26dn3tqRGzkKIhiuug+
 jwa5JCw6zglmc0CBoi1/qVfes0ikQkLFPgAbExGIe9TsCZL4bBTxoP/Qae9y5sXA6ZlE
 8Hw0bfCcgI6OkgZMI+eFOLYE25nWkDHHM7ubxacarG9cF4cqC6BB+K3guyZd8YphLHQF
 6WVmWpqSvoZ3NcNRTK9SpvCLQCvACBDQSHh2QFltzjJ1EX8j4os6busZW8KIhmrzCQKq
 rwiKf38UvSYVig5hMhXRpuMqPiLILLtggx18czmEUoZeOMg5yZxAfCWwHHNexmDbZv8B
 dSgw==
X-Gm-Message-State: AOAM533uxtUtOR0lG8/HgMkI4Ug/sJ93Md1bosN9HCLzitfDr12/NMRE
 F0gys4xDUFJ/Ls+vLegSRL/srX/RLK4r1L9oqoYK8QnvMfM47MZwnnukKOlRmW+c3MZG4L2CpOD
 8Rurgh3yg5Nzd2Uo=
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr17432408wmd.86.1594628410942; 
 Mon, 13 Jul 2020 01:20:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2xDCKh35vtBm8A4Aiby//fYzxiIYercOCPi5ebDDWXKCnLhv3dfE5OBtKTob4w5TEKgBE5g==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr17432386wmd.86.1594628410754; 
 Mon, 13 Jul 2020 01:20:10 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t4sm22084034wmf.4.2020.07.13.01.20.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 01:20:10 -0700 (PDT)
Subject: Re: [PATCH] .cirrus.yml: add bash to the brew packages
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200710182238.10675-1-alex.bennee@linaro.org>
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
Message-ID: <eb8519e7-8a59-b18c-b9a6-2449f42d8f3f@redhat.com>
Date: Mon, 13 Jul 2020 10:20:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200710182238.10675-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
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
Cc: Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 8:22 PM, Alex Bennée wrote:
> Like the sed we include earlier we want something more recent for
> iotests to work.
> 
> Fixes: 57ee95ed
> Cc: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .cirrus.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 69342ae031bc..f287d23c5b9b 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -20,7 +20,7 @@ macos_task:
>    osx_instance:
>      image: mojave-base
>    install_script:
> -    - brew install pkg-config python gnu-sed glib pixman make sdl2
> +    - brew install pkg-config python gnu-sed glib pixman make sdl2 bash
>    script:
>      - mkdir build
>      - cd build
> @@ -33,7 +33,7 @@ macos_xcode_task:
>      # this is an alias for the latest Xcode
>      image: mojave-xcode
>    install_script:
> -    - brew install pkg-config gnu-sed glib pixman make sdl2
> +    - brew install pkg-config gnu-sed glib pixman make sdl2 bash
>    script:
>      - mkdir build
>      - cd build
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


