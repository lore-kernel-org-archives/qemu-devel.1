Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D5AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 04:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E20B20702
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 04:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="As9/lk81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E20B20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsfH6-0002Ms-90
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 00:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsfG3-0001NO-Uw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 00:31:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42280
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsfG1-0005IO-MQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 00:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594096260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1TnSmrWA0rZ3Wpl+6vADU1PoMVVL8Dtu3+g0Sw3GKxc=;
 b=As9/lk81pAZQu6sFpDN4tw5VVs8ZTtj1/vPx5EDbX30AxoZI/NxYYwYZYUX/UykSrSlIMx
 Utf0kMDsmydLeQhOJztnUXT65mK2Mm/jjobOS1JivShZn/+JtsDFTxDg7yBUS5ZksuV1Fp
 AzBzHeZDf78zBJVTN2jyQ91BqIDsmes=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-DKYHCEfLMEK96jTzNUkoWg-1; Tue, 07 Jul 2020 00:30:57 -0400
X-MC-Unique: DKYHCEfLMEK96jTzNUkoWg-1
Received: by mail-wr1-f69.google.com with SMTP id c6so28153051wru.7
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 21:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1TnSmrWA0rZ3Wpl+6vADU1PoMVVL8Dtu3+g0Sw3GKxc=;
 b=jYXlA040N8JPSUaq3SCF2u/Pi0/f0vFpyxbtL0e3gSKG0qvTDSEJLJrKuqub3b7DA6
 Fkfzjp6S7ea+pcIdLOWqC2ppUHTwj8bdnNz9DS/X7fraTY4tzQBKV4Rb9MxCCaiHFxNI
 dQ+E8avuIgaTQEsBD4ND2OCYhuSqPkYRpHBzOk1bXXGHApCo+BwFnVA9Baf/7J/UTGGS
 ThLa9ACf4VHyHsCCoQs4/fbs2YUHHyZs+YElu4cHGt583DSdoFH/x+5DlKfqWe/zJuaY
 eIAX0EYULwRSqnYmdKhXwjc3ZRoD8JBVwuc6EPbRp2dSQAGz5y/iFlMjWVzMoe1Akzuu
 4X3g==
X-Gm-Message-State: AOAM533dDAd1dliMVpP4VE3r+Flg0wX14lcGyl1YAZfOSUiVhXl216La
 Nmvgu1co7ibkG7eLmWeV31yh5jM/IQnIdpS8HtopfaL0xaxywMnFAd4d0NQDDVskRX8ttu2ubXI
 YQ4y6w+cAwYtdu5o=
X-Received: by 2002:a1c:9994:: with SMTP id b142mr2035797wme.141.1594096256277; 
 Mon, 06 Jul 2020 21:30:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFeoIToXXTxshmxAiWzZ1myQPZKOWzF2QW9ajs3Kgpdu3uuznYKuAmvfxURl455kPNyUzFKg==
X-Received: by 2002:a1c:9994:: with SMTP id b142mr2035784wme.141.1594096256090; 
 Mon, 06 Jul 2020 21:30:56 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a22sm1744039wmj.9.2020.07.06.21.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 21:30:55 -0700 (PDT)
Subject: Re: [PATCH 1/4] fuzz: build without AddressSanitizer, by default
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200706195534.14962-1-alxndr@bu.edu>
 <20200706195534.14962-2-alxndr@bu.edu>
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
Message-ID: <aeda1483-5aca-02fb-3cea-5f9e7f448033@redhat.com>
Date: Tue, 7 Jul 2020 06:30:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200706195534.14962-2-alxndr@bu.edu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
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
Cc: bsd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 9:55 PM, Alexander Bulekov wrote:
> We already have a nice --enable-sanitizers option to enable
> AddressSanitizer. There is no reason to duplicate and force this
> functionality in --enable-fuzzing. In the future, if more sanitizers are
> added to --enable-sanitizers, it might be impossible to build with both
> --enable-sanitizers and --enable-fuzzing, since not all sanitizers are
> compatible with libFuzzer. In that case, we could enable ASAN with
> --extra-cflags="-fsanitize=address"
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/configure b/configure
> index 8a65240d4a..010c0ca479 100755
> --- a/configure
> +++ b/configure
> @@ -6319,7 +6319,7 @@ fi
>  # checks for fuzzer
>  if test "$fuzzing" = "yes" ; then
>    write_c_fuzzer_skeleton
> -  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=address,fuzzer" ""; then
> +  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=fuzzer" ""; then
>        have_fuzzer=yes
>    fi
>  fi
> @@ -7858,11 +7858,11 @@ if test "$sheepdog" = "yes" ; then
>  fi
>  if test "$fuzzing" = "yes" ; then
>    if test "$have_fuzzer" = "yes"; then
> -    FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
> -    FUZZ_CFLAGS=" -fsanitize=address,fuzzer"
> -    CFLAGS=" -fsanitize=address,fuzzer-no-link"
> +    FUZZ_LDFLAGS=" -fsanitize=fuzzer"
> +    FUZZ_CFLAGS=" -fsanitize=fuzzer"
> +    CFLAGS=" -fsanitize=fuzzer-no-link"
>    else
> -    error_exit "Your compiler doesn't support -fsanitize=address,fuzzer"
> +    error_exit "Your compiler doesn't support -fsanitize=fuzzer"
>      exit 1
>    fi
>  fi
> 


