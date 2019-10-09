Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C91C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE7020679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOTlWRPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE7020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEQp-0002dT-Qp
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1ta-0001lf-Sa
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1F2-0004Kj-ER
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:58:17 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:35401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI1F2-0004HR-5z
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:58:16 -0400
Received: by mail-yw1-xc44.google.com with SMTP id r134so244061ywg.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kLjxtmfzmglbrExGmBtYEiAkfZ47H/12eqRlwI8tbCc=;
 b=aOTlWRPj9JfFxjNmQkAzGOri1pg9kxaaxnV7jotbDhH258Xs0H6rFja7AVOxACnG/h
 0Apx4KPMF6xPIBmfzzDQpVFaE+WuvA9n62AfyJ8hA4Rp2h26O85AdXiWXBCPzqrJfe/1
 2XnRHw32GhuJuEpfvtm4RqzzgUGAJo+7m8cz5m0lvib7200ezhUOijGcL36RW7LznZwt
 pDy20wK5CBov+5comGRtPRr3D5lv8wasEg7UAtHdOWtwg8Q5lArs6YNJAono7oh4p5Bn
 yK3n5cLkEoigUvyow7sEGftCRG3wFg1rOJEzj+cYfVH50sWGkT6G8YcGEW2n/kM5Y+11
 Jh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kLjxtmfzmglbrExGmBtYEiAkfZ47H/12eqRlwI8tbCc=;
 b=KVeIheAheL15xzuKcqv/3dh1skUV6pxppx4cJWwklIMRdCthiqmeT+QbplpxlgGIs3
 kge0LhIRQye4AaDQCdn9OqnS9fVpKyxrDKBO8rKPlieKNPi+fQekyuI8VGu8fYv5wzaa
 rcVNL+wx71kflSeD23LEE3Suoz5CPCvqwkeWVhTDt6KPQFJkg6S01u+EndsTMhP1Gl5H
 OpxxYpC8fNayqWTjb7E+9fDZ3dW6qJVpXN/3XNtJ8Na1lm4jP8OlM1BfoFWaxq+fZhTL
 20gsGwk0iao7lVIfGRWAJ7CCQ/9j/5mSnAaV6CAoQgKeAZriq4t8eAfRRk0vIiw9lt7q
 kN9Q==
X-Gm-Message-State: APjAAAXZ9TDTefMskFVoD12gLLUckZtBgL8V3XblN33RkWnIhBcBU89o
 oZZJd7M9qGwYKHoQYf6dGuwmAg==
X-Google-Smtp-Source: APXvYqzFI1VvsRtVvUPnva/rb39nYKPgi8Kh/lkfSP8xdp3xGF6mlfeK8rFR6RxveuUptCW0S7XErQ==
X-Received: by 2002:a81:784e:: with SMTP id t75mr1067252ywc.328.1570586291821; 
 Tue, 08 Oct 2019 18:58:11 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id e82sm254783ywc.43.2019.10.08.18.58.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:58:11 -0700 (PDT)
Subject: Re: [PATCH v2 11/21] hw/timer/exynos4210_mct.c: Switch GFRC to
 transaction-based ptimer API
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-12-peter.maydell@linaro.org>
 <09f5a1b0-8750-eaa4-c6a3-c395ded3167c@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4fb18f38-eef3-281b-f414-d257e3dfa2b1@linaro.org>
Date: Tue, 8 Oct 2019 21:58:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <09f5a1b0-8750-eaa4-c6a3-c395ded3167c@linaro.org>
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

On 10/8/19 9:56 PM, Richard Henderson wrote:
> On 10/8/19 1:17 PM, Peter Maydell wrote:
>> @@ -945,7 +977,7 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
>>          DPRINTF("freq=%dHz\n", s->freq);
>>  
>>          /* global timer */
>> -        ptimer_set_freq(s->g_timer.ptimer_frc, s->freq);
>> +        tx_ptimer_set_freq(s->g_timer.ptimer_frc, s->freq);
>>  
>>          /* local timer */
>>          ptimer_set_freq(s->l_timer[0].tick_timer.ptimer_tick, s->freq);
> 
> Failed to update them all, it would appear.

Ho hum.  Done in a subsequent patch.
I didn't realize that you weren't converting the entire file at once.


r~

