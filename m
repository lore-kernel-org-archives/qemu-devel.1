Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AF5C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFE32067B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ubtARVdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFE32067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEdv-0005tq-Bp
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1tX-0001lf-OA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1GK-0005NE-OS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:59:37 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:38631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI1GK-0005MQ-Gy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:59:36 -0400
Received: by mail-yw1-xc43.google.com with SMTP id s6so237446ywe.5
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5B5PokirAcyvVdxU0wyuXSRG4YX397KLy+gkaIxmrUA=;
 b=ubtARVdqRaFmcMQ2ybqqEWddOtqFrX8mOhuXf+wh5ZY4ABo+bqCa9hB2tirZo560GL
 R2tDw38t9lCN6VdLpClGi/pDhjFJuAYTMTGOpgL7oo9UxSPn1O+YRqL1Mfk8jADXfhfJ
 nlMq0ZjKC/tXJ07nQ5FulL8dydbbjwKXhnAkbnvF5CJaEXH5CvzwNRsRygUUnYDcajSo
 yRBKsCs7pWWHNIS/abrTVm3tYV01YBtp+V3d2nPDRgZUSuDl2Vp6yiovJLR9hm2BpdIb
 nRckk13xnzcm0qi7JCOmXbMCVn/+aPd5BdtpYGSn03TGJYvSLb0xjvmeU1wghP6TfC5U
 Yjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5B5PokirAcyvVdxU0wyuXSRG4YX397KLy+gkaIxmrUA=;
 b=ph5a57YuUKNmupXWpLNdykI2WHnMDoWEHiDWJBN1GSWvEem3YNjNXsMtLnaKopSkk/
 OD90dRRDbmUYnfKsuga4gqQi1eNd0ZoKp7LEfwBEiVVp9m6aTST4XRH9yF5IsrU+vdHi
 5dl2dnOi/u3FdOGOW2qJ/2k2TLBB7xoF/FiUh7Hx1kLRazv93Yk1pldNXTSyHo9adsxJ
 lCjaym4LobpqHWukS8epXnJcV6PpUdwS8x2Ru9jvGOzA1iHml8hOs2mfmKSYeTABC2Qk
 tCy2zWGwLXqTcP6+Y82OdcKb8wuO/ZrOPi/hz4sQjaykYGXsEHiJYuBlMLFAZl/ms23E
 rSIw==
X-Gm-Message-State: APjAAAWKAySptc5i1bQOObzNPkBoyLmJa3wRWO2XiJZTrYlDlvQWOc31
 5LZ6rz5J9A99cGs8yAF9uQawWA==
X-Google-Smtp-Source: APXvYqwEAdzkBaj1Q1AnNDbHrjLHzeLbtm5XgrDAXO3k/bQ8GEKGix+ld7Co2/ar/bDQdpTYRFma9Q==
X-Received: by 2002:a81:6f85:: with SMTP id k127mr1024783ywc.363.1570586375801; 
 Tue, 08 Oct 2019 18:59:35 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id z137sm225758ywd.18.2019.10.08.18.59.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:59:35 -0700 (PDT)
Subject: Re: [PATCH v2 13/21] hw/timer/exynos4210_mct.c: Switch ltick to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <977ac2b8-c2b0-286d-e4a2-d262aeec32c8@linaro.org>
Date: Tue, 8 Oct 2019 21:59:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:17 PM, Peter Maydell wrote:
> Switch the ltick ptimer over to the ptimer transaction API.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/exynos4210_mct.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

