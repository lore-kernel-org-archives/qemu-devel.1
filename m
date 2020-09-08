Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6333C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CD921D20
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kv44HW+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CD921D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYih-0002wM-CO
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFYhv-00022B-Dg
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:10:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44519
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFYht-0008QR-4B
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599552624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3SC+kRPCxll5JJBMJK4Mnob3wDvslDt4fWB6v+fVllk=;
 b=Kv44HW+sA1rkkwvY0v7smn5ir1DOLLWObsbuxWfxjgkPu422J5IuGR+RbCm6seTmDt3jAa
 iNyHfrdNYiADXuIvk7wpsXiZjcRVAg4mDYKRxouFMZd6eG8Bew6WvFskDY0D31ewjOvpRT
 X6BpogCnFrXtE2xfwv/feIb3UkUE5h8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-bLatNbscNMuIjjewlo0eYg-1; Tue, 08 Sep 2020 04:10:22 -0400
X-MC-Unique: bLatNbscNMuIjjewlo0eYg-1
Received: by mail-wr1-f69.google.com with SMTP id g6so6696476wrv.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3SC+kRPCxll5JJBMJK4Mnob3wDvslDt4fWB6v+fVllk=;
 b=ABS/2oOH91PGyedofEl3uFAdgZLFczNXdF1Xd4Gir7nAmuEAvB3fgUDx6NNENCtr3B
 QYKXSVK6y17AOOdIzfwhyFFHkL54ABNyVauxWE3CwpDe6coBT3oSLqYlHVyOVhF2xq6j
 QixZfNAfI2cLKmvO+URM/TcY7J5HP1pQgEkC7uwnAWhS2TX6a6ZT5VlGTer4Wpp3IDCS
 xB8osBEzZnj9rqZbL6Xhqjyv/5ouBL7kMFrzJE7IYFfUNmL6jgS7BYjvUNdVmWgAhUBK
 KVBEoeWdnH57SCwun0ApCqaw6c9GmOMDNyIrRMZYDUGE+Aa0zwQG8F9J6+KcyiwZd1fh
 5ycg==
X-Gm-Message-State: AOAM533fvLKLD7e+UefuTNQ3pIr0DjvBR2i2HtC99axuBPSr045Fue3s
 PirmElX+Q1xlB9jSm8D7kh0cMXifEWAXYFKPigyWegOPbLz8fADfhGczjLeHxR4x5X4Qcd1LJby
 CyQGJ8lIJlOPUv0Q=
X-Received: by 2002:a5d:4811:: with SMTP id l17mr26386885wrq.252.1599552621728; 
 Tue, 08 Sep 2020 01:10:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtCH3LhseKUX2G/yX0K94+SiI6wF5MRymX97uz36/Im2jpj3nXrZsSJAQw7Ddx6WoZAPCMbQ==
X-Received: by 2002:a5d:4811:: with SMTP id l17mr26386875wrq.252.1599552621571; 
 Tue, 08 Sep 2020 01:10:21 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m125sm33127161wme.35.2020.09.08.01.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 01:10:21 -0700 (PDT)
Subject: Re: [PATCH 06/10] roms/Makefile.edk2: complete replacing TPM2*_ENABLE
 macros
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list
 <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-7-lersek@redhat.com>
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
Message-ID: <afc5ab07-441e-0752-7331-928f0889b537@redhat.com>
Date: Tue, 8 Sep 2020 10:10:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908072939.30178-7-lersek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 9:29 AM, Laszlo Ersek wrote:
> At tag "edk2-stable202008", the TPM2_ENABLE and TPM2_CONFIG_ENABLE macros
> are useless (for IA32 and X64). Their roles have been absorbed by
> TPM_ENABLE and TPM_CONFIG_ENABLE, respectively. Remove the old build
> flags.
> 
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Ref: https://bugs.launchpad.net/qemu/+bug/1852196
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  roms/Makefile.edk2 | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
> index 7c06645c95ca..8cdf337fc1e9 100644
> --- a/roms/Makefile.edk2
> +++ b/roms/Makefile.edk2
> @@ -89,9 +89,7 @@ submodules:
>  		-D NETWORK_HTTP_BOOT_ENABLE \
>  		-D NETWORK_TLS_ENABLE \
>  		-D TPM_ENABLE \
> -		-D TPM_CONFIG_ENABLE \
> -		-D TPM2_ENABLE \
> -		-D TPM2_CONFIG_ENABLE
> +		-D TPM_CONFIG_ENABLE
>  	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
>  
>  ../pc-bios/edk2-i386-secure-code.fd: submodules
> @@ -104,8 +102,6 @@ submodules:
>  		-D NETWORK_TLS_ENABLE \
>  		-D TPM_ENABLE \
>  		-D TPM_CONFIG_ENABLE \
> -		-D TPM2_ENABLE \
> -		-D TPM2_CONFIG_ENABLE \
>  		-D SECURE_BOOT_ENABLE \
>  		-D SMM_REQUIRE
>  	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
> @@ -119,9 +115,7 @@ submodules:
>  		-D NETWORK_HTTP_BOOT_ENABLE \
>  		-D NETWORK_TLS_ENABLE \
>  		-D TPM_ENABLE \
> -		-D TPM_CONFIG_ENABLE \
> -		-D TPM2_ENABLE \
> -		-D TPM2_CONFIG_ENABLE
> +		-D TPM_CONFIG_ENABLE
>  	cp edk2/Build/OvmfX64/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@
>  
>  ../pc-bios/edk2-x86_64-secure-code.fd: submodules
> @@ -135,8 +129,6 @@ submodules:
>  		-D NETWORK_TLS_ENABLE \
>  		-D TPM_ENABLE \
>  		-D TPM_CONFIG_ENABLE \
> -		-D TPM2_ENABLE \
> -		-D TPM2_CONFIG_ENABLE \
>  		-D SECURE_BOOT_ENABLE \
>  		-D SMM_REQUIRE
>  	cp edk2/Build/Ovmf3264/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@
> 


