Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9C4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0695320734
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVAoAg3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0695320734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgj8L-0001M1-5l
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgj6X-0008OG-1k
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:11:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46109
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgj6W-0002fH-0J
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591251110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dVGWfeilJLHk4ZaSUKByFXutMoVnGC7rf3UMq4xi/ec=;
 b=IVAoAg3Ufn7Cr+JRqhxK2cJpCNB8dFR8SieFwDcoOJwtTHEhckESTtMeL958+iXlQILEgK
 1Uwgxtwqw2cjaDeE8XZr+jdDNNcXffpKUi+E5Yw/4CY7Hr7TGxRQBbHy8QxDQwWjUscaf7
 bkz4hqsN74Wr3SYNl71tlysgmOjvAEo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-58g2x98JNdeYW_TTYwAUqg-1; Thu, 04 Jun 2020 02:11:47 -0400
X-MC-Unique: 58g2x98JNdeYW_TTYwAUqg-1
Received: by mail-wm1-f69.google.com with SMTP id s15so1596402wmc.8
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 23:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=dVGWfeilJLHk4ZaSUKByFXutMoVnGC7rf3UMq4xi/ec=;
 b=tzYznd7o5TXyFh+1w2eXS/rcx/gYmzihpf3sW5Cl/K9YtxK5dmR59zvEbolnxoceFb
 VDbmhdXTB542AchtSfYp4BuLttZJYBiRVBci3SP76jdvglys93b7PfchRQWnkTPrGbNR
 IZ91Bh7F/bYh0YIFnEl2ssAljgC0klHnb173CSch6Qjlp+ttJwPB2iOgyPavE2MkfmQI
 8Rwg78Gp9WWKy88vBHGihcyAI7fmN4TqaNUn8BV4T+r5/Vd24I7bf6rOSDYdgP9qkxFC
 oZqjgGIOYkCgAHuu1Cv7Lk5EWZGCjZOZxbbEGgDU9dFkNjevHIforqfBwmCr0cxKXdK4
 P6SA==
X-Gm-Message-State: AOAM532ZOpRbZAJbWOvdpy+PCF15hAPqlrICbO2qn3oI7jae6xMMWWSl
 eX5YPOC0Jxp1uajF8GljmTe1Xiaz0sB+696ogGleqnOHNI4t2tZR06n+QbzteXt/ArrEKtlKAyZ
 DVhxXlAbYPyz16eg=
X-Received: by 2002:a1c:c1:: with SMTP id 184mr2396869wma.74.1591251106015;
 Wed, 03 Jun 2020 23:11:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZBMBp8dqt/+mAwmJ0tozLys4fHiyWg7EqL2XVsosHggP1Lum2oFGtUmheNAjQfnNOQ2nxCg==
X-Received: by 2002:a1c:c1:: with SMTP id 184mr2396853wma.74.1591251105816;
 Wed, 03 Jun 2020 23:11:45 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q5sm6439744wrm.62.2020.06.03.23.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 23:11:45 -0700 (PDT)
Subject: Re: [PATCH] configure: Disable -Wtautological-type-limit-compare
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200604034513.75103-1-richard.henderson@linaro.org>
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
Message-ID: <f5bc0532-e731-b56f-df7f-55da2585e955@redhat.com>
Date: Thu, 4 Jun 2020 08:11:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200604034513.75103-1-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 5:45 AM, Richard Henderson wrote:
> Clang 10 enables this by default with -Wtype-limit.
> 
> All of the instances flagged by this Werror so far have been
> cases in which we really do want the compiler to optimize away
> the test completely.  Disabling the warning will avoid having
> to add ifdefs to work around this.
> 

Fixes: https://bugs.launchpad.net/qemu/+bug/1878628

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I dare to add:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configure b/configure
> index f087d2bcd1..693f01327f 100755
> --- a/configure
> +++ b/configure
> @@ -2009,6 +2009,8 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
>  gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>  gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
>  gcc_flags="-Wno-string-plus-int -Wno-typedef-redefinition $gcc_flags"
> +gcc_flags="$gcc_flags -Wno-tautological-type-limit-compare"
> +
>  # Note that we do not add -Werror to gcc_flags here, because that would
>  # enable it for all configure tests. If a configure test failed due
>  # to -Werror this would just silently disable some features,
> 


