Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60265C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B60C20663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXZLL4A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B60C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT3BO-0000fN-9K
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3A4-0007jl-K5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3A3-0005Tp-SJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:47:00 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT3A3-0005TV-Ek
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:46:59 -0400
Received: by mail-ot1-x343.google.com with SMTP id e20so25841539otk.12
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V4dbXREGTsXV/7UlX8RXwxH6IjStovz6VATZ4V2tEG0=;
 b=aXZLL4A+iBNAqsTeLDJFHp6mI1VzMEbj3Ngh4hMn6nNzzBbMLyc9pX7zO3Bq4xzrBz
 4EQLntq5WEk6shX7uJqLUdN/1RZQoD47KEHuQbijsV/nJJdOwZ3ZrAyOm60X6OokV9Ia
 tR+tX5cn+rdJZMYyrbYCB+HIwoPvoofMlG4C8pqCEurLT2Gt3XfYifiyp/W+tTSzutxR
 DZHcj6suuukyJOLyTtY30avZR2TweIhalsftMZhpb4P5KtXgPzA9/XfFIKgH/1hTNG69
 fdZCSfqmhcbhzOlL3OCsr4nIzff2ox5iSqQoGqDT4p0uSAzP9JqR4oEEEu3XFgpIxsZJ
 mvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V4dbXREGTsXV/7UlX8RXwxH6IjStovz6VATZ4V2tEG0=;
 b=o2k+zsIACB2Sjpw7UHXhDZ3TLyN6P3ig0S5i5WSfBQN89BQYVbWTzdRmGGkUqdSd7V
 SVCCY1IRYLGdaGkabmsfish5Xm4lZZSSI8RKy7ZJoyE8knXcanY8R/8x6nU2skN0GYfx
 ANbG4RuPkEH20Fhq4sGLDINNrWCuL6qjpgjF65TYk/vB/V6cQLw8lhj/KaYy59p8Lz9i
 o42hImzvmNNTMrZ957aQ0Qae1boJ8+BQe8H5ZZRJ3VlxEtoQ0HDbM9sXCc3V7jLAoudp
 pXMWUIrWBaYswqdchbv0mbmRLUTxhrYC19izR8kCVj6J8IM5RcB4Fv0RpsLpQgvofJd9
 Db8A==
X-Gm-Message-State: AGi0Pua0sfU7yIkU8AMfHxiOE8avl6pZx/SBpC+uhcrlGIjSSWx+jxPh
 BLlwxeWtz6oiJfGOfZunutsHotgJI01D72jd8/3ixA==
X-Google-Smtp-Source: APiQypIT7D67CnWAqO4OhE94eOm6gckW8NM9UkNs3l+UyP1VnRKn/+axoCePWBDfPYcCKAjG6oLHnbX/mYO4QP/6KnQ=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr18543334otb.135.1587991618156; 
 Mon, 27 Apr 2020 05:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200422172351.26583-1-pbonzini@redhat.com>
 <20200422172351.26583-6-pbonzini@redhat.com>
In-Reply-To: <20200422172351.26583-6-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 13:46:47 +0100
Message-ID: <CAFEAcA_YZ+OoARe=-q6L1b_+wLcmPHG50Nz5Mzkrdo2PrpMC-g@mail.gmail.com>
Subject: Re: [PATCH 5/8] run-coverity-scan: add --no-update-tools option
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Apr 2020 at 18:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Provide a quick way to skip building the container while we figure out how
> to get caching right.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/coverity-scan/run-coverity-scan | 37 +++++++++++++++----------
>  1 file changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
> index ae1fc7ae76..9403429849 100755
> --- a/scripts/coverity-scan/run-coverity-scan
> +++ b/scripts/coverity-scan/run-coverity-scan
> @@ -31,6 +31,7 @@
>  #   --dry-run : run the tools, but don't actually do the upload
>  #   --docker : create and work inside a docker container
>  #   --update-tools-only : update the cached copy of the tools, but don't run them
> +#   --no-update-tools : do not update the cached copy of the tools
>  #   --tokenfile : file to read Coverity token from
>  #   --version ver : specify version being analyzed (default: ask git)
>  #   --description desc : specify description of this version (default: ask git)
> @@ -128,7 +129,7 @@ update_coverity_tools () {
>
>  # Check user-provided environment variables and arguments
>  DRYRUN=no
> -UPDATE_ONLY=no
> +UPDATE=yes
>  DOCKER=no
>
>  while [ "$#" -ge 1 ]; do
> @@ -137,9 +138,13 @@ while [ "$#" -ge 1 ]; do
>              shift
>              DRYRUN=yes
>              ;;
> +        --no-update-tools)
> +            shift
> +            UPDATE=no
> +            ;;
>          --update-tools-only)
>              shift
> -            UPDATE_ONLY=yes
> +            UPDATE=only
>              ;;
>          --version)
>              shift
> @@ -238,12 +243,12 @@ fi
>  PROJNAME=QEMU
>  TARBALL=cov-int.tar.xz
>
> -if [ "$UPDATE_ONLY" = yes ] && [ "$DOCKER" = yes ]; then
> +if [ "$UPDATE" = only ] && [ "$DOCKER" = yes ]; then
>      echo "Combining --docker and --update-only is not supported"

Pre-existing bug,but this error message should say
"--update-tools-only".

>      exit 1
>  fi

> @@ -343,7 +350,9 @@ fi
>
>  check_upload_permissions
>
> -update_coverity_tools
> +if [ "$UPDATE" != no ]; then
> +    update_coverity_tools
> +fi
>
>  TOOLBIN="$(cd "$COVERITY_TOOL_BASE" && echo $PWD/coverity_tool/cov-analysis-*/bin)"

Do we fail in a confusing or a clean way if you try --no-update-tools
and you didn't actually have a pre-existing cached copy of them?
I guess it doesn't matter much since this isn't intended to be
used by a lot of people.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

