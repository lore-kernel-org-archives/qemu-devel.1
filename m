Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88711C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3728321479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KN22IN/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3728321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7dQ-0001mQ-H4
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47270)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <leif.lindholm@linaro.org>) id 1hi3xf-0000uL-9V
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leif.lindholm@linaro.org>) id 1hi3xb-0002Wi-2e
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:35:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <leif.lindholm@linaro.org>)
 id 1hi3xX-0002Rj-2A
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:35:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so4179629wro.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=r//KTEG5DAhvwYFBTCLmyijNq18FbJoDajikMBX1evY=;
 b=KN22IN/iOPsTuk10q3naJITrrLvOky/+WFerjD4n6MswNFEHx1ew8wfRnfA4GjmzvL
 xD6s/J2Ud3oVKKVT/NjKGVgqieZu6TR1ptDisTDrGAIZJtCPOAPHH/wSVkB05FvuJQ7X
 orPeW5gg9Qwg7i/N1DPVyjrRaAwFs6a7w6XExykwS55MK92GFNm/HkJMIncbD5CFDmpG
 Z9TdkBWRoqFE1PcUNqVaipsZtF348fmCJ2SGNfNRGBAwyCbR/pn4OxvPzfWLnE3KAnSJ
 D54MjrkLrBnrSr2IOPe8kAm9Vd3SUmrJkHhJkPhiTy16zTivJMhu+EJb4p/yttv/u4Gu
 avNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=r//KTEG5DAhvwYFBTCLmyijNq18FbJoDajikMBX1evY=;
 b=olojOjuPMSeYLqcHGMdTK+ykRoKghMjSv+MlzgddxpyA/GFxllv3G8Zf7dY5Nz4sWI
 Xw5tR7n2XrlIfwVoQB8xnV19KvZBzo+mNiXMnYxSwhVWwnNoM+hg9HvzrXEKCC223/Rl
 OZk3jQ5rszr+nOVqL+M6nhu+zifklkcqUP04Y5cM2dxqtQ+kyStTIgdT/8pFF2oxOIgJ
 moaMsoUCzXTs4QoZI6IHASwQSeA+eOfpz1Cac5aXclzOPrDIYr4q5S0XkkxdYPu/4cUy
 YOqyMpRgx9TeiiMqN7P0PUwuMFcoh/5tX7BBTwKNn84o+MK9+RlqC/OHnnCDzgZKE1s3
 ccdA==
X-Gm-Message-State: APjAAAU2T9ghR7aEPUQQvd+l6NSWDWe2IFLnd+KL4SxiAaop7ug4bG/3
 3OOkWnGk4VVFK4mKke2GIF+h56nN9zQ=
X-Google-Smtp-Source: APXvYqwD1w/NuA1kbB0mvYqNY6oMzXfUxktT3RGnus5qc9C/zWu9oPJ1HgNN++cOwgFKOSJs4GhjQA==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr12932178wrm.100.1561997329047; 
 Mon, 01 Jul 2019 09:08:49 -0700 (PDT)
Received: from bivouac.eciton.net (bivouac.eciton.net.
 [2a00:1098:0:86:1000:23:0:2])
 by smtp.gmail.com with ESMTPSA id q10sm11370665wrf.32.2019.07.01.09.08.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 01 Jul 2019 09:08:48 -0700 (PDT)
Date: Mon, 1 Jul 2019 17:08:46 +0100
From: Leif Lindholm <leif.lindholm@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190701160846.fwjeco3zuobn3pgv@bivouac.eciton.net>
References: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
 <CAFEAcA8P-=mbQ4__9OXB078GnrGfm9afH1YBDLkv88mUXmm=PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8P-=mbQ4__9OXB078GnrGfm9afH1YBDLkv88mUXmm=PQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v9 0/2] Add Arm SBSA Reference Machine
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
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On Mon, Jul 01, 2019 at 03:54:24PM +0100, Peter Maydell wrote:
> I've pointed out a number of issues with these patches, but they
> all turn out to be very minor (mostly fixable by moving code between
> patch 1 and 2). The other thing we need is a MAINTAINERS section for
> the new board:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cad58b94879..0bf3739f06a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -728,6 +728,13 @@ F: include/hw/arm/fsl-imx6.h
>  F: include/hw/misc/imx6_*.h
>  F: include/hw/ssi/imx_spi.h
> 
> +SBSA-REF
> +M: Hongbo Zhang <hongbo.zhang@linaro.org>
> +M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/arm/sbsa-ref.c
> +

Sadly, Hongbo is no longer in Linaro (but has generously helped keep
working on this platform being upstreamed since he left). It is my
understanding that in his new role, Hongbo does not have the bandwidth
to keep maintaining this platform once it's in.

Unless I have misunderstood this (Hongbo, please confirm - we would
certainly love to have your help if you feel that you do have the
banwidth), could we please add Radek as a maintainer instead?:

M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

If you think it could be useful, feel free to add me as a designated
reviewer:

R: Leif Lindholm <leif.lindholm@linaro.org>

(I would not be offended if you don't, I have plenty to keep me busy :)

>  Sharp SL-5500 (Collie) PDA
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> 
> 
> So rather than making you do another respin, I'm planning to
> make the fixes in my target-arm.next tree as I apply the patches.
> That way we can get this in before softfreeze (which is tomorrow).

Many thanks!

Best Regards,

Leif

