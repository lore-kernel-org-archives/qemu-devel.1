Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D0EFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC1020854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZwiViVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC1020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5D0-00070Z-9n
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5Bm-0006Gj-UQ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5Bj-0002OI-Rz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:47:34 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5Bj-0002Nr-Ji
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:47:31 -0400
Received: by mail-oi1-x243.google.com with SMTP id k9so2004258oib.7
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0lnNRYmX4oZQoNtlYcwmEpfp6gY49DYWNQDO6djXtnY=;
 b=XZwiViVE33Z50pQmYgl6sYTpD0ytamd3VEv9h6idlOlbkcMEvX9JVL1vksQETXJ9N0
 4bzAwBh3NITMpPRSC0RCxWJv21YZ3hHAznrUA25JVUFUTi5bQsRbYDhnlxowFbzkIC+r
 ubVfTAJzSI/ngyTL2DlwydN2N5Z1sMlwDOgUs8GStExm4/1DGSWtzrp1VKrUjpo7Wy7C
 c8q1hp2eiN8C5YQ1Zj+lgWxnLAAWLmoZB4LAKf40SAO8Q2jCEZnv8ehH0s68RT6scaGv
 WdS/eE+Dzj8K3/WAF70QZZst0E8Zea5jyXI5NovKMp7T60Kj36TE9dHO4xjXOhkcBLy4
 qhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0lnNRYmX4oZQoNtlYcwmEpfp6gY49DYWNQDO6djXtnY=;
 b=JE62/hvkYBzowB5+NdPPC+ttBqSLr5Ghs3nxg0Pa1zRNlfivr1LweUKTJR3eHuhsrF
 GoCVTl+XcftVHxH9UEBu/ul1PhZirZunZE3kfeod9elxzgDsnCUI8kxl1cZYVkY5daYy
 JfkTWGfJrEFQ6hb1RYzWrgMMU4bpinTyfHCtAijIaHEPJ4dcFeYFx2CtkUx/flS4C6fL
 TmK8H8VPfjdqy25IqbGevB2T/PzihRCsDxyMOEQBPbo1/Q01zC+2zE3VeBNprIvuyj5F
 QqDRl0WAjngPTW/Q9FoRL1ObA0RRCxnyWUSmzu1pVVAa8wKZ9M8SQDDGOKLcEBBf4TCo
 7cfA==
X-Gm-Message-State: APjAAAUF7nIX3mK+jeMfw5g2DDNK7qNnJNol8HAx7B5aoM9APADqUJfk
 H/afGOgeivnmySqVg9OZsOgS2A9yHj0DO8PBDubM3Q==
X-Google-Smtp-Source: APXvYqxcm+7c9tYvv8Vdbw4ZCqpDfS5TKh2N2CtPQsyrVW+u/KrqUXOfZWtzd2yJKdTK5QgmexMQfeLm/nY8PuTB+Ts=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr2931910oia.48.1571316450457; 
 Thu, 17 Oct 2019 05:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191017123713.30192-1-casantos@redhat.com>
In-Reply-To: <20191017123713.30192-1-casantos@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 13:47:18 +0100
Message-ID: <CAFEAcA9dMRBtDs6QSXGVv_bNhtu5wnGKLvMxr2YuoWM=yomGDg@mail.gmail.com>
Subject: Re: [PATCH] util/cacheinfo: fix crash when compiling with uClibc
To: casantos@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 13:39, <casantos@redhat.com> wrote:
>
> From: Carlos Santos <casantos@redhat.com>
>
> uClibc defines _SC_LEVEL1_ICACHE_LINESIZE and _SC_LEVEL1_DCACHE_LINESIZE
> but the corresponding sysconf calls returns -1, which is a valid result,
> meaning that the limit is indeterminate.
>
> Handle this situation using the fallback values instead of crashing due
> to an assertion failure.
>
> Signed-off-by: Carlos Santos <casantos@redhat.com>
> ---
>  util/cacheinfo.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> index ea6f3e99bf..d94dc6adc8 100644
> --- a/util/cacheinfo.c
> +++ b/util/cacheinfo.c
> @@ -93,10 +93,16 @@ static void sys_cache_info(int *isize, int *dsize)
>  static void sys_cache_info(int *isize, int *dsize)
>  {
>  # ifdef _SC_LEVEL1_ICACHE_LINESIZE
> -    *isize = sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
> +    int tmp_isize = (int) sysconf(_SC_LEVEL1_ICACHE_LINESIZE);

Do we need the cast here ?

> +    if (tmp_isize > 0) {
> +        *isize = tmp_isize;
> +    }
>  # endif
>  # ifdef _SC_LEVEL1_DCACHE_LINESIZE
> -    *dsize = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
> +    int tmp_dsize = (int) sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
> +    if (tmp_dsize > 0) {
> +        *dsize = tmp_dsize;
> +    }
>  # endif
>  }
>  #endif /* sys_cache_info */
> --

thanks
-- PMM

