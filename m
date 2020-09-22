Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9889DC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0582396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLpCPDOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0582396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKi7Q-0006rU-It
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 09:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKi6K-0005lJ-P5
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:12:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48275
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKi6I-00060T-O4
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600780373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/TghKXzrmyNIxTlDsLm2X+l1yh1S8gPVfiAbcTmtFao=;
 b=QLpCPDOLq0X4rttk2bKVcH8whQRhC8Vl4/EmPSz20oiTuSQp93PxgvKgwptDVICj3MbekW
 9IosPAEnpscQD8IdU5XtJbDqFORKIWSPhZmAqqkYfUg1s3VLubTFvp5LniSmgJdgYCrfj2
 glkbn2tzs0fjehbtJPzvFkRHvo2EcVU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-j-ilyqStOmCXmFD6XmoC5g-1; Tue, 22 Sep 2020 09:12:51 -0400
X-MC-Unique: j-ilyqStOmCXmFD6XmoC5g-1
Received: by mail-wr1-f70.google.com with SMTP id b7so7404611wrn.6
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 06:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/TghKXzrmyNIxTlDsLm2X+l1yh1S8gPVfiAbcTmtFao=;
 b=K7TmFdU7cWoIjfB93qJagYbmDPljc+xe3bO4QHml7IPOUFDQD8lErp5HSjnfB5neMx
 MBD5OWSVVmZymr/lceCumb4SkjTVtX2LmUOTno02/yE25UENki+QyVxOYkH7r72dX+UO
 RsB05+HB+bvX62hPm4CJ6s72SZ1RrnabPzt9FxwKDjw2vjtmo2/tWxRBPupcalCkuYa2
 uJ8eJXXWZ6MI/I6GhK6lJ7NEcI6+vGSFoOZTlGK5rVS6hBldTmsnP1JGctzy0Dd3eVPy
 owl3WJ5f5aWPacnuxW3CMrU8TNeDctrO8MIW6MTr+O3td1CinWCg/DcCsuZ/O3UVDuME
 a94Q==
X-Gm-Message-State: AOAM531rtGHEq4WeydH2yn0swPoaSRxbwVTEJuXyi+Qvsb6FrSVn7MPm
 7UZ/4+ZVptqVuaY5mLCQ756zsvjG/6/BagCxr4aViEcwOCWMj7WeMryuOagFWhUH4P/+E1PtDLW
 0zPYWhtCQZMXpz6Y=
X-Received: by 2002:adf:e407:: with SMTP id g7mr5255114wrm.349.1600780370560; 
 Tue, 22 Sep 2020 06:12:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIDZ+wMtk7TL+6Ta2Sf9LlsweXIAe7tVUWO+e9BiUDpSNA55tWxeYqfhMFq/o1pDgzCKg06Q==
X-Received: by 2002:adf:e407:: with SMTP id g7mr5255081wrm.349.1600780370301; 
 Tue, 22 Sep 2020 06:12:50 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h17sm27493998wro.27.2020.09.22.06.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 06:12:49 -0700 (PDT)
Subject: Re: [PATCH] coverity_scan: switch to vpath build
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200922130806.1506324-1-pbonzini@redhat.com>
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
Message-ID: <eda9690c-51dc-d21c-e675-56fdb8d04ba2@redhat.com>
Date: Tue, 22 Sep 2020 15:12:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922130806.1506324-1-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:27:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 3:08 PM, Paolo Bonzini wrote:
> This is the patch that has been running on the coverity cronjob
> for a few weeks now.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/coverity-scan/run-coverity-scan | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
> index 6eefb4b558..7395bbfad4 100755
> --- a/scripts/coverity-scan/run-coverity-scan
> +++ b/scripts/coverity-scan/run-coverity-scan
> @@ -380,15 +380,17 @@ export PATH="$TOOLBIN:$PATH"
>  
>  cd "$SRCDIR"
>  
> -echo "Doing make distclean..."
> -make distclean
> +echo "Nuking build directory..."
> +rm -rf +build

^ OK

v Why prepend '+' to the dirname?

> +mkdir +build
> +cd +build
>  
>  echo "Configuring..."
>  # We configure with a fixed set of enables here to ensure that we don't
>  # accidentally reduce the scope of the analysis by doing the build on
>  # the system that's missing a dependency that we need to build part of
>  # the codebase.
> -./configure --disable-modules --enable-sdl --enable-gtk \
> +../configure --disable-modules --enable-sdl --enable-gtk \
>      --enable-opengl --enable-vte --enable-gnutls \
>      --enable-nettle --enable-curses --enable-curl \
>      --audio-drv-list=oss,alsa,sdl,pa --enable-virtfs \
> 


