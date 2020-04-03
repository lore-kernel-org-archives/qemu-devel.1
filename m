Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2CDC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F353206E9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZTTd6FR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F353206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKPUf-0000b4-QH
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 12:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1jKPTs-000094-0m
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1jKPTq-0001Yu-Sb
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:47:43 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:37132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1jKPTq-0001Y0-Ms
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:47:42 -0400
Received: by mail-pj1-x102f.google.com with SMTP id k3so3185303pjj.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0BQb5Ra4Luy35outzXhP8PIzC9UQuHMiVYTGm4+EBJY=;
 b=hZTTd6FRuZ9WYfKre9q0RBvEZ0yAqHoKkWa4LpQrJfArjo+WPRYzNgJtGupzg0Wpep
 TMv31+sN4PM873vm+a2WB7SHBQXPp+bI8cYsBKJM71Ese25wzXP0YrNZdNSwLNwPmAUd
 t4D9avU0p96v+B4r8Bwl0ZcbHlhtvvcLJ2kCT79ZHiwz1pva9fa+gc0IL6tYNMzUNsHU
 xf2GUlKfpOAyLXQVYHhvsYXhNdeTSkX2PBJx47pqRDzoQpKnROewsGv45MtP/KlYOv9F
 Mq51bRSnCjgZ9lEv8CIv7sNsDc3MMjr1we12Ow8dBzLqq8/ZkRvCDK51veJRAsp9uE5N
 HS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0BQb5Ra4Luy35outzXhP8PIzC9UQuHMiVYTGm4+EBJY=;
 b=N9eA0JMmuLzfkQ4HsPyrECUabX2OEqU2BdOc0Hq6DHSuBrm090PuCxXOCKUxciCrHo
 D738GHsI6CbEuZILmAHIkEtqXQ1IWevYrDglD7tEvzeGgJ7M6VmMcUISBfheueQs5WM1
 0B7tv+eUKCAqy+dcsNfA7utFf+OOD7rzAypeXaFi1WJ6V8Ba7EhEQ+B0QgezN+al6agi
 oiD+iBpf98z65ujZeVg99viqC65HaXuQ0EmCXWVB3wHn2m26cdzSDWqD1Dw6+cMIJ6t/
 RpyY+LuShYFHPEvXuJn/kNcC48gD51EDQRPKJFV07YriYYFt20BahOqjgJQz1W2LSXNY
 3Wpg==
X-Gm-Message-State: AGi0PuZwOV8Wynhr8RnB6W9lYjYQNQy3OfB5cJX8PfGDMKT/Mehk5QQ3
 lgikl7rWGfnfJAly341OwkI=
X-Google-Smtp-Source: APiQypKosm/aDQwqZYtUuLsk4ewYcDDSQND3YrDMZkhXcsNEwytSCJxeoqWfAdBMchHlnCf42j5DJA==
X-Received: by 2002:a17:90a:6fe2:: with SMTP id
 e89mr10869445pjk.12.1585932461310; 
 Fri, 03 Apr 2020 09:47:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.googlemail.com with ESMTPSA id d3sm6119189pfq.126.2020.04.03.09.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 09:47:40 -0700 (PDT)
Subject: Re: [PULL 03/13] target/rx: TCG translation
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200317163616.30027-1-f4bug@amsat.org>
 <20200317163616.30027-4-f4bug@amsat.org>
 <CAFEAcA_zu+TXPyGiv9aeszY2s4uhxb=9HisKD1TipM4yj=e_Sw@mail.gmail.com>
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
Message-ID: <a3e8008e-6f62-a672-9c40-ccc1f1b238ba@twiddle.net>
Date: Fri, 3 Apr 2020 09:47:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_zu+TXPyGiv9aeszY2s4uhxb=9HisKD1TipM4yj=e_Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102f
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 9:41 AM, Peter Maydell wrote:
> On Tue, 17 Mar 2020 at 16:52, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>>
>> This part only supported RXv1 instructions.
>>
>> Instruction manual:
>>   https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01us0032ej0120_rxsm.pdf
> 
> Hi; Coverity points out a possible missing 'break' here
> (CID 1422222):
> 
>> +static void rx_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>> +{
>> +    DisasContext *ctx = container_of(dcbase, DisasContext, base);
>> +
>> +    switch (ctx->base.is_jmp) {
>> +    case DISAS_NEXT:
>> +    case DISAS_TOO_MANY:
>> +        gen_goto_tb(ctx, 0, dcbase->pc_next);
>> +        break;
>> +    case DISAS_JUMP:
>> +        if (ctx->base.singlestep_enabled) {
>> +            gen_helper_debug(cpu_env);
>> +        } else {
>> +            tcg_gen_lookup_and_goto_ptr();
>> +        }
>> +        break;
>> +    case DISAS_UPDATE:
>> +        tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
> 
> Should this have a "break" or a "/* fall through */" comment ?
> 
>> +    case DISAS_EXIT:
>> +        tcg_gen_exit_tb(NULL, 0);
>> +        break;

This one should be a fall through.


r~

