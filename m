Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0259C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFC5206C2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/eccXb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFC5206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iI17K-0000yt-Nl
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 21:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI15O-0007oY-8O
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI15N-0007Sk-17
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:48:18 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:38983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI15M-0007SU-Ru
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:48:16 -0400
Received: by mail-yw1-xc42.google.com with SMTP id n11so228452ywn.6
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VNDAkVsTwUnuIZghDZOLRxF38RbItL8I5pyWWyyoipk=;
 b=m/eccXb4nzRViAeBQKZTQMDAvclE+ZKdMo734zjkcmsO4veeWdQkkn/uncGGlElxlM
 UnFq/PFmhpD480cq9X+cbu648Pwx9bPr9e5LwsdzLW9vbccFqNSknO6noVq2Ub/Do0Ws
 xvLWYNpHVpUSRH3QBP5ck7ENTKJGWDGajEofvMVNSUa8s5pwzoGJf9DDlznqW3/r3aNx
 mIXuJ7nF0T31KWQIhWLjf8W/RhmyCAWmaA/lyq6/gLyzvx6qObL2dsWa9pNkKDDrd3ey
 4O/xrdQJ4niRFRkRcjFwmlgNtnmFMq61LSlh/oj3Lene2XlIWA87tgq/AyfVdX+2DRc1
 5hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VNDAkVsTwUnuIZghDZOLRxF38RbItL8I5pyWWyyoipk=;
 b=VapHMtIxKhPEyj3RBp156SG6s7Zo+9tfTfFONGm9iZfbl0oofX1rDCNDCbgqrTWIoO
 K/PNvNwwkWqGMWj+01YFnoSoUd6B+/eT7/aHmqGe6Zo8wMqwB5rMEuFRCfwTSAniKTyz
 5kN9dkI4WZ6t9RI5WrXSN536rbWYPP6OYK67fBHcZsf1SeGfympInqRrWZqC7pQUwa0n
 evTaB53sQoiFelRz1UOQmwZcT1F3ycc8ItMeqY92idb1rdo+W+fLd/A9wX46Xn+kS+Qg
 Wsq00C4a3dDtNSZcCTLFXYNanH2aySTyYbGnpwlE2rn6uJwHdHiw3+ogxgYNtGePIekS
 xxOw==
X-Gm-Message-State: APjAAAXFaZqU2PsJrKvC1F1V22KK5yMKgjAAfU7BDWH8orMVI/BOVdoN
 Nl8mWFLfndd16EsWybmxs9PGUw==
X-Google-Smtp-Source: APXvYqzIN2qRcdJ1WVRq458/ZPk0+axUdeGO0tpcJG3K7g6fm2ya5nmtv9XvY6SemGb2q83dfFLrUw==
X-Received: by 2002:a81:284d:: with SMTP id o74mr979995ywo.45.1570585696067;
 Tue, 08 Oct 2019 18:48:16 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id t82sm216076ywc.26.2019.10.08.18.48.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:48:15 -0700 (PDT)
Subject: Re: [PATCH v2 04/21] hw/timer/arm_timer.c: Switch to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9540c7bc-b394-fc61-d59c-7273d726c3d0@linaro.org>
Date: Tue, 8 Oct 2019 21:47:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
> Switch the arm_timer.c code away from bottom-half based ptimers
> to the new transaction-based ptimer API. This just requires
> adding begin/commit calls around the various arms of
> arm_timer_write() that modify the ptimer state, and using the
> new ptimer_init() function to create the timer.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1777777
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/arm_timer.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

