Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255E9C2D0EC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 20:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C772074B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 20:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zW5ARKjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C772074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLuqu-00023g-0B
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 16:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jLuqD-0001f4-TP
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 16:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jLuqC-00086f-Pt
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 16:29:01 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:56244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jLuqC-000867-Fi
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 16:29:00 -0400
Received: by mail-pj1-x1043.google.com with SMTP id fh8so228055pjb.5
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PS7unYNwt0PHKxTSIYsrLTinrdUEFG/zvP4WkLAi5fo=;
 b=zW5ARKjT1z5BTXbC2Ent+q9mq0OHCZYv+rWl8fW9ZeBJTIf4V3qQFkc49QJV5Mc9Xr
 J2pGzytAUKvF3Dx8VTClpdg3BmRvTNoqlsnPXtgdl261T2au7i7n/Y1mJFzVj8jeg0B7
 WHY5vJZE0vLz5bNYS5mx3rKUovvqW8MuF0dy6z4SvuxYV+/C7ilGMpQVG7gYdgolEX8e
 g0lNREGbgH79UKV0cYshGlZAmfUZndMvdG3gqVsgmubToin1NkZ86WFQjIWYiy1wQjN3
 b1cH6+SZ5ehJe++scLXVtEgOvNn1lihKSYuFHWIHsdxh84VcUL0pnQ1hxUnrk8nXAiK4
 za9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PS7unYNwt0PHKxTSIYsrLTinrdUEFG/zvP4WkLAi5fo=;
 b=VQVfl2zYiday3P27OvB+iA9/tBywSww3Qfixyn1nPz5gTPegloS2mQKPXfT4JO73nX
 79RK8r/WPQW2cCCqepFK80NvuiYUt8zwfPWMP0Yg51u9XhifMmM7csC0YwOOHxPUtYAy
 xDU2ENxV5U5tA7bPpNUSjfiWQOimoieXG7pEfqJi+oRJWx3wIIFtxXtjVCKb6QxxGW16
 zyW2PoRmz/+GlUpXJvYXFPX27rcA3oMcx02A8+CkMD0BXmWRCqtyOCxR1xPzk7uPWBUZ
 qgP+ryzz62LFyjaQVko4uS2ZPIp/g0Oya6LmTjpkUlOC8Kb4RR1aGlLZj2RDAJD7XyDP
 VRzA==
X-Gm-Message-State: AGi0Pua0D3zc6yPONOShcugh1JvuKSbKRTXvKpaKlDIDOGacywxsEfT8
 j+llP2V/+z2vKcjy381o2ew5DA==
X-Google-Smtp-Source: APiQypIPSsGfkvXTpBiqYIIc54CTyUKOXnIGvZ2Gb9HHCJyO95O6qP5nxFumOvUfCPe6xIvl1YXbiw==
X-Received: by 2002:a17:902:b210:: with SMTP id
 t16mr1756380plr.71.1586291339236; 
 Tue, 07 Apr 2020 13:28:59 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id t1sm2397440pjf.26.2020.04.07.13.28.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 13:28:58 -0700 (PDT)
Subject: Re: [PATCH for-5.0? v2] target/xtensa: Statically allocate
 xtensa_insnbufs in DisasContext
To: Max Filippov <jcmvbkbc@gmail.com>
References: <20200407190738.15162-1-richard.henderson@linaro.org>
 <CAMo8BfKzHNPNtRJEdkg4hDTVT5B+GhAQNn5PjOw5uShURqZxJw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0c7467ea-3ef0-f827-df3b-73be8a5d92f1@linaro.org>
Date: Tue, 7 Apr 2020 13:28:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMo8BfKzHNPNtRJEdkg4hDTVT5B+GhAQNn5PjOw5uShURqZxJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 12:17 PM, Max Filippov wrote:
> On Tue, Apr 7, 2020 at 12:07 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> From: Max Filippov <jcmvbkbc@gmail.com>
>>
>> Rather than dynamically allocate, and risk failing to free
>> when we longjmp out of the translator, allocate the maximum
>> buffer size from any of the supported cpus.
>>
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> [rth: Merged the fixup in Max's reply to his original]
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/xtensa/cpu.h       |  3 +++
>>  target/xtensa/helper.c    |  1 +
>>  target/xtensa/translate.c | 18 ++----------------
>>  3 files changed, 6 insertions(+), 16 deletions(-)
> 
> I've re-posted it almost at the same time (:
> Should I take it, or do you have another plan for it?

I'm happy for you to take it.


r~


