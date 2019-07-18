Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BFAC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03CF20873
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K65kMV0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03CF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho6fy-0005lc-KR
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 09:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37976)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1ho6fn-0005Jz-4R
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ho6fm-00073p-68
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:42:15 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ho6fm-00073B-0I
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:42:14 -0400
Received: by mail-oi1-x242.google.com with SMTP id v186so21503700oie.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qBJ+tQPGoSJPrqpsUNX1j4CLjRjV0/3St23wQmfd06c=;
 b=K65kMV0nyp0H331gnZrU9FNLpthKDP9SPfv06We1boOwIlRvPtrB7Ny/fRaCwxHxgk
 LvhMaOmt+YXK7xUESxtVFik+NdG6kSP/WBRQqGPVlEaCvNoKDaXaTvgC+ovW9K3y0xiU
 LIqucmJzVZXLVlDVQWNCQP+LDU+pivOWZ0TRGsv3+3g8T5UBKbgIHANYregT2Y+/Fk/q
 xwbyGAGYCI8Rk7s/Jyrd5QAOOAWJZnLDS/WPxkNSNfIIDHOlvXsLnmX9mT8bI/M1XTSR
 /AW+1s5AnZaGq9eA2wc8/B/5LGaRIZmpMDkrWcwUtMzZyMo2y5pxg/Hh7o4r+Sz1zbHs
 h+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qBJ+tQPGoSJPrqpsUNX1j4CLjRjV0/3St23wQmfd06c=;
 b=cTvwpqwYr5pDHQ8hmN8YiyZBFxT/MQ2qNiuvboByoviosigDl0OWJG9e0LJXzgRPsH
 I3lv9fcEI/c8z6mEY18xq4F9U3WpIO4uoPY3ggqOQe0JeYdL9594D9VUjl1zhrKC4NaG
 bnYBDXU6KN3N/xnmxqpAjDPISkUe+XHnDKAQqGGS/t1WkHQBOftktMSdPqJzuaMdVn3H
 gQzLIv7L4K0jiTv+2Va9/Kt42Opi+Pdjnrfh20sS9bPup2lW1UmgGjjhJ7LRBECYi1G+
 apQg2EG9ZUTfzo5k529MK6V7nvK4KLlWrlz69lgjh3/TB0M9dzU20KqM4Em75D/S8tcd
 vY5g==
X-Gm-Message-State: APjAAAWiY8G9abvk574cMp9h6rt3L+Dlq/QWFwfoFB6fq23QmMwzdT/X
 rH31W37dOTRBTZeDpldGaO8VE446eL4QEMQJ7PKN3Q==
X-Google-Smtp-Source: APXvYqxFyNASpEnj6MHRBC6zgl67t+LkL42fQl0QIYEII3o4lN71h3Atx8/OlPdGhZ3XUKK9UDi/JcqSgN2FiqrMixc=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr21114339oib.146.1563457332707; 
 Thu, 18 Jul 2019 06:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190718092219.20081-1-chen.zhang@intel.com>
In-Reply-To: <20190718092219.20081-1-chen.zhang@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2019 14:42:01 +0100
Message-ID: <CAFEAcA-HK_aSynZ2bEvg1W64L3U7amuDRLGr+8DVqcGujiOkgg@mail.gmail.com>
To: Zhang Chen <chen.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH V3] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jul 2019 at 10:27, Zhang Chen <chen.zhang@intel.com> wrote:
>
> From: Zhang Chen <chen.zhang@intel.com>
>
> This patch to fix the origin "char *data" menory leak, code style issue
> and add necessary check here.
> Reported-by: Coverity (CID 1402785)
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  net/colo-compare.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 909dd6c6eb..fcccb4c6f6 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -127,6 +127,17 @@ static int compare_chr_send(CompareState *s,
>                              uint32_t vnet_hdr_len,
>                              bool notify_remote_frame);
>
> +static bool packet_matches_str(const char *str,
> +                               uint8_t *buf,
> +                               uint32_t packet_len)
> +{
> +    if (packet_len != strlen(str)) {

Is '!=' definitely correct? (ie the incoming packet must
*not* contain a trailing '\0' or any other trailing data) ?

Is there a specification of the protocol somewhere? If
so, that presumably should say one way or the other.

> +        return false;
> +    }
> +
> +    return !memcmp(str, buf, strlen(str));
> +}

thanks
-- PMM

