Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46125C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13020206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNKLb1qR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13020206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEyk-0000ET-Ca
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhExm-0007lY-7V
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:12:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42603
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhExl-0000L1-EN
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591373576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lsPCF9t/JSjvN9+xQhUJX2aZmSeSX1j89GMWuvY2IQU=;
 b=PNKLb1qR5JpE8Q08s4af+pxi+xoBOkppH+ewoiw0gySbEKt3DSkT8L57O/ykPc+ceYaoVq
 0r7Fla69dkg9JiO76caCRFQ46Q5NR+q5u9fpnRT6AqEO8bWbRgWK1CUOTpBSQ30rJG/S5c
 PypRIXBYM2Z4QwH+6of9KebXh06Ypww=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-LFS87EgGNkmIfAs_8XNoIw-1; Fri, 05 Jun 2020 12:12:54 -0400
X-MC-Unique: LFS87EgGNkmIfAs_8XNoIw-1
Received: by mail-wr1-f69.google.com with SMTP id l18so3988425wrm.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=lsPCF9t/JSjvN9+xQhUJX2aZmSeSX1j89GMWuvY2IQU=;
 b=KPpWk4E0epZnuuMcCIJrAOjp1/1PT+w0+8T0LEsfuojk2hLp6Bwq90NKR71s3ev1lY
 p+jNK3rhI9K8uTMYOlYPE3xSYWX6io5TQbxRalNEq87BG3BamzdgDmAfT4706MLSMf+C
 4q5ba//0f0Pld5q3RVEOD18DuoZDd3yl5+VyECBDKUvbjk2UuHIssuA8LvcQb3Xlw0ox
 VRzmZ6LwOACeGPTBG8Uk0eNdp7xTMTDiy+0xt5dze8DZ7A/102wCcnCGyA579PEGYsTq
 iC2iYDileaYlp/oEAJ+qup+m0UcbtOJRCnJ0vMtmIe3CiKvgBFwoClV1p1C9X+DkzrGs
 6U3Q==
X-Gm-Message-State: AOAM532YDIql4tBhzGlY++Ctv6AHm5GBAh6cl5Xvvh1WUjBssApf5BlI
 rTStzl2SMKtxIUiAuasGUtEm5hl5j0WVnERVprsLbnYia6F14bPzLkjyqW1MPeECE8LalOOPf6I
 YE9HczKyXmqm2UF4=
X-Received: by 2002:adf:f0c6:: with SMTP id x6mr11200902wro.301.1591373573773; 
 Fri, 05 Jun 2020 09:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu1AMGqi5CnvUfRLctJQ8H21jwX7W0sJzQFlOuQItQFV4w0ONhdRndJKcLTvSsqkaZ+vTEUA==
X-Received: by 2002:adf:f0c6:: with SMTP id x6mr11200875wro.301.1591373573563; 
 Fri, 05 Jun 2020 09:12:53 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id d16sm12043010wmd.42.2020.06.05.09.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 09:12:53 -0700 (PDT)
Subject: Re: [PATCH v1 06/14] .shippable: temporaily disable some cross builds
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200605154929.26910-1-alex.bennee@linaro.org>
 <20200605154929.26910-7-alex.bennee@linaro.org>
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
Message-ID: <d1e09568-71bf-ecb3-515b-0c2b08fdb86b@redhat.com>
Date: Fri, 5 Jun 2020 18:12:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605154929.26910-7-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 5:49 PM, Alex Bennée wrote:
> These currently fail due to Debian bug #960271 as the
> linux-libc-library has a user-space build breaking symbol in it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .shippable.yml | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/.shippable.yml b/.shippable.yml
> index 2cce7b56890..10cf219bff4 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -5,8 +5,8 @@ env:
>    global:
>      - LC_ALL=C
>    matrix:
> -    - IMAGE=debian-amd64
> -      TARGET_LIST=x86_64-softmmu,x86_64-linux-user
> +    # - IMAGE=debian-amd64
> +    #   TARGET_LIST=x86_64-softmmu,x86_64-linux-user
>      - IMAGE=debian-win32-cross
>        TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
>      - IMAGE=debian-win64-cross
> @@ -19,10 +19,10 @@ env:
>        TARGET_LIST=aarch64-softmmu,aarch64-linux-user
>      - IMAGE=debian-s390x-cross
>        TARGET_LIST=s390x-softmmu,s390x-linux-user
> -    - IMAGE=debian-mips-cross
> -      TARGET_LIST=mips-softmmu,mipsel-linux-user
> -    - IMAGE=debian-mips64el-cross
> -      TARGET_LIST=mips64el-softmmu,mips64el-linux-user
> +    # - IMAGE=debian-mips-cross
> +    #   TARGET_LIST=mips-softmmu,mipsel-linux-user
> +    # - IMAGE=debian-mips64el-cross
> +    #   TARGET_LIST=mips64el-softmmu,mips64el-linux-user
>      - IMAGE=debian-ppc64el-cross
>        TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
>  build:
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


