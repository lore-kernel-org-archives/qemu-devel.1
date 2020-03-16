Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551C8C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F78420663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9BhK2J/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F78420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDzT6-0008UZ-B3
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 19:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1jDzRi-0007k6-1h
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1jDzRg-0006JV-Qk
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:46:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>)
 id 1jDzRd-0005sb-Vb; Mon, 16 Mar 2020 19:46:54 -0400
Received: by mail-pf1-x444.google.com with SMTP id x2so10481150pfn.9;
 Mon, 16 Mar 2020 16:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bPEoHKCTJw+MAHcfLmqEzWLLM8Bt/AKZ5RUUCQBJ8js=;
 b=P9BhK2J/HeDsIl4RUCoxcSXirkLqfoMfYjlbzbHEBvosy44Bj3A7oFQWgNyUo5jD4r
 UQVGMD4rqeFRjWnfIcKxXeDUwGAAt25NIY2zvd5R6rcliQ6oQsmHheM/EuByuyi7NlQv
 YeaXz06Na+vyuag6c5Ddz4CNONsT3NmAix2ul02oU018HRlagbN/QKJnzOrbkJ0V8SL/
 T0zyLS+04XYhSSIJ6Ma+GFS8qcstFQgFhDD6Skg/pkrqq5fu0DkqyExbfzJxpo+zvI9H
 QoffKUKVFFTfjXiUeKYStCfOPPMiqnQd9lXCn5OWSM/uHk+xq7g70ia90FiyWLU3WtZg
 h5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bPEoHKCTJw+MAHcfLmqEzWLLM8Bt/AKZ5RUUCQBJ8js=;
 b=RGGC7J1irHk6o6xfl9ZtA3dq4fYP3qicWOjoVaJOy4QZFOotmOUVnfUQeZUB54NJZU
 2y9zflS+km1Onc44BaMJNMkkvFUQ7G1XqZSsbJGKkjShZDzAw44QpMqsa240Kkz0nQXz
 JbnaTQriwRAimEXacQ/ZTLsi69d4qfPQ3iDupk/XTnIDq0pHGIz5LnzQM8fvGzamaPXI
 scCiK8pnZb73cnZB6IABCJNKUDpYOS8lfhoC0fr7DpwmYwd9T1OhHogNNcCfdZgUFUIw
 H6QkExQwwYZ5JH0Ec0bi2cjNKpPPfhi0RhR4YRRBa4f3WSCzK86IOSGLyjUbl2Z9YE52
 BVMQ==
X-Gm-Message-State: ANhLgQ2U1HrGoFtD9fZFrUWTM2cmSEZEpa/4Am3kNJFPVn21FQsktd6I
 fODHrXJPgVGFKn6kkQyt9sFjROTc
X-Google-Smtp-Source: ADFU+vuyXhfuI1IeIlq6uQuba4gExsCpYX2+C+O/bu+xzoM1HzsNQdo9Yl9hBhZmQcYLp7MbsCTWNQ==
X-Received: by 2002:a63:2323:: with SMTP id j35mr2224391pgj.440.1584402412143; 
 Mon, 16 Mar 2020 16:46:52 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.googlemail.com with ESMTPSA id
 gc16sm789305pjb.8.2020.03.16.16.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 16:46:51 -0700 (PDT)
Subject: Re: [PATCH v2] MAINTAINERS: Mark the LatticeMico32 target as orphan
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?=
 <akoskovacs@gmx.com>, qemu-devel@nongnu.org
References: <20200316142827.20867-1-philmd@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFYBBMBAgBCAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAIZARYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweUY
 BQkP1h/pAAoJEK0ScMxN0CebqDsH/0YyfnXk+Dc++H37VCEKgRet2i1ATFzxRnifkvmdxha0
 V+PVptQ2fwSe+w3KxoFecD8W75nysmUjrU/FicW9yU5YRlGONPZjruG02/KzmhA5PzWJdYO3
 i/t0qRayvWIcX2qA/flsXEbmb/BbAFM05LQIdcOu74eiBFe5CBCOWBDJeneE1urIE0hSYxoh
 nCcG60ULrNj13ohZ4zAEluoY32qIo7/OPWmtR88cPrEbZT8k+RqgZbsotzaPT1/RlL74fL8k
 ofYfTgKAFH7eEy6fF2nzDp2GThVn+3sA62xtpSXUf/X1m75B40KOcq1EQbHypNTmBc1wt13e
 ibhPNEVX2am5AQ0EUa4sLwEIALITHfH3gciRNfQIe7awDTDvn6H3C6gDyCAnv5LiuLTLZiyK
 NZp3lNO3rPowyKrGT2RIDlumlqPgdeHzqEEX91YK0yk2vdFvwU04rJ4D+qRgdUPoeICLD1zo
 PwOv2FaY6Tf8dKYas1RHF5QU5yQNey8j7IYYoE2yGPn2PtBmvtmK4iLataUEvx0U385Zr+jf
 HscqwTiToryeDC8Io/9BsMvAssE5Yf5URS2nJ7LFOvc4njsQJPF1i9egBXaIloqv7p2hVCKJ
 Hl5UWIxitQ9QQIl6iU4LCpz8mVYTXwv48IAVpbUf7+ak9V9Kk3jCeQnlxCJBUHjUhoIzinbS
 JHPHtkkAEQEAAYkBPAQYAQIAJgIbDBYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweVIBQkP
 1iAZAAoJEK0ScMxN0CebGHUH/RtouOlWl6To97tQsTJUq/2YwmRpFOsvV0/zCX4fKBGAbeZi
 VaELSt2+3UEErA+n8HwbQmjJ6IrdhA9GustOpOyCcbLVSMwql/OlAwBtDzCcC8dTU4zcuY2a
 rGG2A8i5krU85G9r1wowVcWZBsdmW7/dKiNoadLQiig4bHNiSaV4ograas5efyEjqTxiY+yG
 hzPw5DK2kbp2co8iDF1vW0LWPeLFBinCgItcI9LvgHWaB3rwjOfvNpMn5m64SoQYHB8wbnid
 erAjOzkBzmqnfS1tAUr8mtESStEwrEmNv0ZoA6S0Wt+c9pyTr+BpG4OFlhj7ZI+Eh7zOrr33
 q9OBIdA=
Message-ID: <951471ce-8110-c110-3414-4387d92b864d@twiddle.net>
Date: Mon, 16 Mar 2020 16:46:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316142827.20867-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 7:28 AM, Philippe Mathieu-Daudé wrote:
> Michael Walle expressed his desire to orphan the lm32 target [*]:
> 
>   I guess it is time to pull the plug. Mainly, because I have
>   no time for this anymore. I've always worked on this on my
>   spare time and life changed. And secondly, I guess RISC-V is
>   taking over ;) It has a far better ecosystem. Also, to my
>   knowledge the only (public) user of LM32 is milkymist and this
>   project is dead for years now..
> 
>   So time to say goodbye. It was fun and I've learned a lot -
>   technically and also how a huge open source project works.
>   Thank you everyone for that :)
> 
>   Basically everything still works and there are even TCG test
>   cases which covers all instructions the processor has.
> 
> Many thanks to Michael for his substantial contributions to QEMU,
> and for maintaining the LM32 target for various years!
> 
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html
> 
> Acked-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Also orphan machines, added Michael A-b tag
> ---
>  MAINTAINERS | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

