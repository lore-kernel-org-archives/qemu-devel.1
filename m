Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7213C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36FC2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3rX95LL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36FC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydEs-0007Op-Rn
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iydDX-00066j-QM
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iydDV-0000nS-SX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:00:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36559
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iydDV-0000lw-O0
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580742049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBYUY6FCpihXVOf//N1USUc/P2ScePKnpQUohHiQW+k=;
 b=b3rX95LLwtNyGHzZcfx33sAMenzCV1tuGPOV27b1fK6XuYgZoU6HcN4k3c0W99IGt6qCR9
 aeEhjNNpKiKyDcsYxxlpDw11vKgjMYE/X1AdUBgxT++xFYlpek5JDu+SSsvTRzyJvQcAMT
 W5XhpHAlsgUfS0vn7EI4zwij72CPceE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-TsG1YN9lMJOWabVvKkgF-Q-1; Mon, 03 Feb 2020 10:00:47 -0500
Received: by mail-wr1-f71.google.com with SMTP id u18so8326430wrn.11
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 07:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qbZA2YYV970/XdG/y2/WPu3nS30WZHJ2TOSrXzDNDrc=;
 b=NPVQmKwC69aclj+JNyjBPIL/YmRh7hu7vep/7FyUsICQ3Ew3QmfnjKEcRZRGd9vSfM
 7qR3x1ApQxj1l3U0MwZZp1H6not7FTqsMe3SF0vCgReF7pTqcWSkXxhR/1tKJRAklsLA
 8/cdOW3Aukq1DW7qfJYe4h4dBMZ+tEk2LdHhEHHzktL6HxUqvs1d1ug+eym3ESBgrhjL
 0h8ojg05TZjdoktnrTBtkmoLbtOB0Xdfu3lfTFa8k9o1PArJynq9kMxFWRSySB6CA+zo
 twcLiM0U3dzaGt0x08WwbzuZO/MZs/MHxqC0Eo4ukemYtxyfMjIdhC9EmJbrSjTqpAdb
 Qs0A==
X-Gm-Message-State: APjAAAWrJgoeDrSLmrQ+A1D0etpXBYTPRrcyClOJ42GOf+xgbJCCcydv
 PzB47ayTXfV7k+XhdaYyU94OPM39TvmdvZ4Xn1SM9OVtCAHEOd1f1nWfTDelSH6Ug6SzIbGWUmg
 8DJviXzi4gvvBmdk=
X-Received: by 2002:a05:600c:292:: with SMTP id
 18mr31396332wmk.128.1580742046241; 
 Mon, 03 Feb 2020 07:00:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqylmKkGuWkh++rYIKELcdDAAc72wiisfPrylMuk1Irnt9EGU0PRD9aLJIN2zy0GpOChnsuBLw==
X-Received: by 2002:a05:600c:292:: with SMTP id
 18mr31396285wmk.128.1580742045836; 
 Mon, 03 Feb 2020 07:00:45 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id l15sm25303661wrv.39.2020.02.03.07.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 07:00:45 -0800 (PST)
Subject: Re: [PATCH v3 14/17] .travis.yml: introduce TEST_BUILD_CMD and use it
 for check-tcg
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200203090932.19147-1-alex.bennee@linaro.org>
 <20200203090932.19147-15-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6cedc012-c4b0-f198-f87a-60f77ffdf806@redhat.com>
Date: Mon, 3 Feb 2020 16:00:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203090932.19147-15-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: TsG1YN9lMJOWabVvKkgF-Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 10:09 AM, Alex Benn=C3=A9e wrote:
> At least for check-tcg we can split the build phase from the test
> phase and do the former in parallel. While we are at it drop the V=3D1
> for the check-tcg part as it just generates a lot more noise in the
> logs.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index a600f508b0a..022462f6981 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -71,6 +71,7 @@ env:
>       - SRC_DIR=3D".."
>       - BUILD_DIR=3D"build"
>       - BASE_CONFIG=3D"--disable-docs --disable-tools"
> +    - TEST_BUILD_CMD=3D""
>       - TEST_CMD=3D"make check V=3D1"
>       # This is broadly a list of "mainline" softmmu targets which have s=
upport across the major distros
>       - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,mips64-softmmu,ppc64-soft=
mmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
> @@ -96,6 +97,12 @@ before_script:
>   # Main build & test - rarely overridden - controlled by TEST_CMD
>   script:
>     - BUILD_RC=3D0 && make -j${JOBS} || BUILD_RC=3D$?
> +  - |
> +    if [ "$BUILD_RC" -eq 0 ] && [ -n "$TEST_BUILD_CMD" ]; then
> +        ${TEST_BUILD_CMD} || BUILD_RC=3D$?
> +    else
> +        $(exit $BUILD_RC);
> +    fi
>     - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(e=
xit $BUILD_RC); fi
>   after_script:
>     - if command -v ccache ; then ccache --show-stats ; fi
> @@ -368,7 +375,8 @@ matrix:
>       - name: "GCC check-tcg (user)"
>         env:
>           - CONFIG=3D"--disable-system --enable-debug-tcg"
> -        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
> +        - TEST_BUILD_CMD=3D"make -j${JOBS} build-tcg"
> +        - TEST_CMD=3D"make check-tcg"

Good, I had some similar patch, but this one is simpler.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>  =20
> @@ -377,7 +385,8 @@ matrix:
>       - name: "GCC plugins check-tcg (user)"
>         env:
>           - CONFIG=3D"--disable-system --enable-plugins --enable-debug-tc=
g --target-list-exclude=3Dsparc64-linux-user"
> -        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
> +        - TEST_BUILD_CMD=3D"make -j${JOBS} build-tcg"
> +        - TEST_CMD=3D"make check-tcg"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>  =20
> @@ -385,7 +394,8 @@ matrix:
>       - name: "GCC check-tcg (some-softmmu)"
>         env:
>           - CONFIG=3D"--enable-debug-tcg --target-list=3Dxtensa-softmmu,a=
rm-softmmu,aarch64-softmmu,alpha-softmmu"
> -        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
> +        - TEST_BUILD_CMD=3D"make -j${JOBS} build-tcg"
> +        - TEST_CMD=3D"make check-tcg"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>  =20
> @@ -393,7 +403,8 @@ matrix:
>       - name: "GCC plugins check-tcg (some-softmmu)"
>         env:
>           - CONFIG=3D"--enable-plugins --enable-debug-tcg --target-list=
=3Dxtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
> -        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
> +        - TEST_BUILD_CMD=3D"make -j${JOBS} build-tcg"
> +        - TEST_CMD=3D"make check-tcg"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>       - name: "[aarch64] GCC check-tcg"
>=20


