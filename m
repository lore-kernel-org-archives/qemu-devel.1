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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E8C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9653621D20
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbdKNHpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9653621D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYiL-0002S1-Cl
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFYhd-0001lf-Ev
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFYha-0008Pu-NC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599552604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vj7Wuu0XCcl5ww9S+7h9r0xl+4QKDM7UrMzf+jMEvBs=;
 b=cbdKNHpkcc66X7yzHQGV8xF7VjWbqL9EJuRZA9rWrkUJr0WemyvCow6JxVwpvJExyVe8DQ
 JNO034qshTQwU2vW9ZhSBndFfYMePLAWADbSdScCX090z6Ogtfh+tyAjTkSKttEc/Zrg3w
 a9D/EnAjaSnWblQdY//kf6xgYTA5Ncc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-1csDFoigOGqUbyvu8YESZA-1; Tue, 08 Sep 2020 04:10:01 -0400
X-MC-Unique: 1csDFoigOGqUbyvu8YESZA-1
Received: by mail-wr1-f70.google.com with SMTP id k13so5096959wrw.16
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vj7Wuu0XCcl5ww9S+7h9r0xl+4QKDM7UrMzf+jMEvBs=;
 b=RdOvTJzg3N2wEjiBBWRYAYaH7uha/KVxJ1CiI3FFujFbjDWFfu/5OAeCrym1o4zPP2
 k/Sjuqq2PK6ctRaTuCpMguYezoBkYRO3VxNtr6nL/4QLo1p+s7YYuf+3BwsUZzrr0a/Z
 cLN975ig6temOPX2bR7wbsJ8HZ0/t6v8m/8PAqWY7H0n/OjeoZ3Djj/p84XLbT2Cqpo/
 3pRgVGnK8yFlA/BNNsoOeqoHS9xt8AjD0GZJ5xyARYEZ0wAVXeGNEGQxA/4heGnoZIFG
 214y0M8upN4Ald5ial0gUTlLOhQh1nsOM+YIGwUfXaoN9MOSv915GvqlaOl9kmnZLANS
 PXLg==
X-Gm-Message-State: AOAM533Mc5fQAzGGlx24RLp3YM+/q9/rp1EJhi4ga5F0WyCAPSOJr67x
 C2T1nmy3dtYfiC6cr8z6t2t9PozxjNzxXLJUIfvHwoPkHx+GAHzD0ynbPOqvBsJG8koC8DE1D3Y
 iJeBByYzgGYh4d1s=
X-Received: by 2002:a05:600c:24cc:: with SMTP id
 12mr3227773wmu.126.1599552600065; 
 Tue, 08 Sep 2020 01:10:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgA8DoEzLApdhw/8Np9pvaFvck7E+hRaH+henv/zMPlVVVhOTi+B8Da4B8mSzn4xM20TnoRA==
X-Received: by 2002:a05:600c:24cc:: with SMTP id
 12mr3227751wmu.126.1599552599813; 
 Tue, 08 Sep 2020 01:09:59 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v128sm29875753wme.2.2020.09.08.01.09.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 01:09:59 -0700 (PDT)
Subject: Re: [PATCH 03/10] roms/Makefile.edk2: prepare for replacing
 TPM2*_ENABLE macros
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list
 <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-4-lersek@redhat.com>
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
Message-ID: <7fd35b66-a2a1-8900-c17d-2fcff19746d8@redhat.com>
Date: Tue, 8 Sep 2020 10:09:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908072939.30178-4-lersek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 9:29 AM, Laszlo Ersek wrote:
> Ekd2 commit 07952a962a40 ("OvmfPkg: rename TPM2 config prefix to TPM",
> 2020-03-04), part of edk2-stable202005, renamed OVMF's TPM2*_ENABLE build
> flags to TPM*_ENABLE. Going forward, the TPM*_ENABLE flags would activate
> both TPM1.2 and TPM2.0 support.
> 
> In order to build OVMF at edk2-stable202008 without losing currently
> enabled functionality, insert the new flags as no-ops now. We'll remove
> the old flags after advancing with the edk2 submodule.
> 
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Ref: https://bugs.launchpad.net/qemu/+bug/1852196
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  roms/Makefile.edk2 | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
> index 33a074d3a4c2..7c06645c95ca 100644
> --- a/roms/Makefile.edk2
> +++ b/roms/Makefile.edk2
> @@ -88,6 +88,8 @@ submodules:
>  		-D NETWORK_IP6_ENABLE \
>  		-D NETWORK_HTTP_BOOT_ENABLE \
>  		-D NETWORK_TLS_ENABLE \
> +		-D TPM_ENABLE \
> +		-D TPM_CONFIG_ENABLE \
>  		-D TPM2_ENABLE \
>  		-D TPM2_CONFIG_ENABLE
>  	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
> @@ -100,6 +102,8 @@ submodules:
>  		-D NETWORK_IP6_ENABLE \
>  		-D NETWORK_HTTP_BOOT_ENABLE \
>  		-D NETWORK_TLS_ENABLE \
> +		-D TPM_ENABLE \
> +		-D TPM_CONFIG_ENABLE \
>  		-D TPM2_ENABLE \
>  		-D TPM2_CONFIG_ENABLE \
>  		-D SECURE_BOOT_ENABLE \
> @@ -114,6 +118,8 @@ submodules:
>  		-D NETWORK_IP6_ENABLE \
>  		-D NETWORK_HTTP_BOOT_ENABLE \
>  		-D NETWORK_TLS_ENABLE \
> +		-D TPM_ENABLE \
> +		-D TPM_CONFIG_ENABLE \
>  		-D TPM2_ENABLE \
>  		-D TPM2_CONFIG_ENABLE
>  	cp edk2/Build/OvmfX64/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@
> @@ -127,6 +133,8 @@ submodules:
>  		-D NETWORK_IP6_ENABLE \
>  		-D NETWORK_HTTP_BOOT_ENABLE \
>  		-D NETWORK_TLS_ENABLE \
> +		-D TPM_ENABLE \
> +		-D TPM_CONFIG_ENABLE \
>  		-D TPM2_ENABLE \
>  		-D TPM2_CONFIG_ENABLE \
>  		-D SECURE_BOOT_ENABLE \
> 


