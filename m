Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0555FC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 15:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26C7206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 15:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOqFYwGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26C7206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEFc-0006PM-PX
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 11:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI16e-0000ml-Dw
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI16d-0007ww-17
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:49:36 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:47074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI16c-0007wj-RE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:49:34 -0400
Received: by mail-yw1-xc44.google.com with SMTP id l64so109091ywe.13
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BFCCKE5ASZGFfjr8QJ8YZ/4YPUpMGrMmDgk5WxUiwek=;
 b=cOqFYwGrMecaLsWI3IYiA2T1FLiUB8JmnlewdxW23L2xfnL3FMnIkr6mH1Jb2ZwYrM
 ygy1tgAeXxqZqCa3PXMG6J2nKtYtZ+HBgOW8mctJEPlVSANwkK46mawKx6iwxq9NJVBV
 mHRjGONAPLtMEMPN3dsqRiX6ingR83FugC7QGnC+o075tn/j8QnJOt5dFXdDmy4XHWq2
 JXd1cIar0AEo1OQYSqYH8qvt8RSgqK6d86iHpVbExQsaVxuzI3NgxQ/czCWHwyM56/Un
 HeaU1amAUwUEVtOmY6aZnYPy/TgcGIQf0e32vfpa7Jw6ytQT5Ga0M2j6Wx8TO9FJDLPP
 mC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BFCCKE5ASZGFfjr8QJ8YZ/4YPUpMGrMmDgk5WxUiwek=;
 b=C14wiPsrnZL0xpfuTGYJOKbFPdi60d1GRBKPwwJ99mcZNy9KzSmcIp86JWXgC/1kAU
 IcbkjceWgcrps81PF25ZQxX9RIZoNkOKQ0nfSeHYXr/dp4PaoqjyembrDOSwiOZu9M6k
 w75qFVwqDKgfAcTuZ5Au51QEteBTR1qwoMkbJsoVUDrq7yvabkxHVcB3P78mi4W9/Ac5
 uxJ1KFALHNVMKyWG5i5+KlAZyFHz7raHreZvcz1z0IJSQYiHg4DWaDtAWaniFWG4SZ6t
 ghBCxc0uinJUyGlBzKln5pYz8HF1uSdCRtavgUjTXt9Z3cdgWlnwLWpsE89knMgzW3lE
 x/sw==
X-Gm-Message-State: APjAAAXGOmQAGfzjS7jBUBxrfj6MGNxQf4MjYq+rlP3tBZphnC6hH9q4
 GEgoGIMTWlaxKKY9Uf/2QX6GH13F7/I=
X-Google-Smtp-Source: APXvYqz3FhaPaFkxd2ab0qTDAuWgdmfBRaadOrXwGtro0P9zzYwG5rsjFzSqFnii0mHQBcQwBiG43w==
X-Received: by 2002:a81:7c0b:: with SMTP id x11mr948443ywc.385.1570585773994; 
 Tue, 08 Oct 2019 18:49:33 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id e142sm209382ywe.101.2019.10.08.18.49.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:49:33 -0700 (PDT)
Subject: Re: [PATCH v2 06/21] hw/timer/allwinner-a10-pit.c: Switch to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <039314b0-62e4-e119-1bd7-c4ecb76c7616@linaro.org>
Date: Tue, 8 Oct 2019 21:49:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
> Switch the allwinner-a10-pit code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/allwinner-a10-pit.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

