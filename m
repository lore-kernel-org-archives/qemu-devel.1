Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56904C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22879205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyj1mdNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22879205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVyp-0006jC-E2
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>) id 1jgVxk-0005jC-VR
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:09:56 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>) id 1jgVxj-0002cj-7e
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:09:56 -0400
Received: by mail-pf1-x441.google.com with SMTP id a127so1884394pfa.12
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8kmu3fAGxFICwHFOiAl1ae/oaoBQGZ73mqhLUV86aRE=;
 b=lyj1mdNCM1poV6sgfcFiohHohNdMskxso2BWwfMdYN1msw0bwOYiMkpactfOm7Pfw4
 OAyXJlYbth7wZ4WPAddzrVw89HmBzRJCsst6uHEnb7Sice2lqGLYKi+lRI18gh8Pekcb
 aNbeEVB/hXlhz43ZNa0G57RrzrN+aUVpR0+5rJ+1cwRMNPZ6DXgfGQ9WdTs5BOC9Qgrp
 FIyAR6fADg96COgb2/QCLi5uG5naMkTFTcVNFDZpQEaxF8/sG1+JOvqBJNQOXQq9X9r1
 zCXwpRGoKm6KeXAUS24I5SLjfcCKXkJxKoaqcZAyuliEOpnqIyUigT0YRneaBDfaVhFB
 f/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8kmu3fAGxFICwHFOiAl1ae/oaoBQGZ73mqhLUV86aRE=;
 b=gMXQtBNkm3HJcRkM0LVI1R7k4MWm+GfjtF5qgvi3cRW1zo0E+2FIP6owef31fYYlZ8
 u7N8oOfhuou8bkAy3R0dma4BIWliWiTjMUru1OvlkoYpuG/qp/5E0sN3P0v00mi956Oc
 YVsJBSiKd3Ml0M8iMMKXMbM++m0ABdAYEsqVcgG7nVsJH22kHuZ7tgu4I43mDlnHajsn
 0QG5x0rAlwyccKkUpDQ+bTGVJo+08ZkkhSbZTWoZ3qaryjJlK7LCklwba339mes7pt3r
 lMoh7g7YXmdHQHAwDOIaKk0nj5/DPj6dKP9k+rM0vZ/lHAKbGmYFV+OrvgMrhpev9wZ8
 NdDw==
X-Gm-Message-State: AOAM531m1JkHY9o2eqbx3rzYogAEvdjpCpfnG0PBkjJuFA+TN9ZDbmOY
 rAebT/k4PfvSMT5Jb1P8Qyc=
X-Google-Smtp-Source: ABdhPJwu2zZKlcj3aS1V1iDR06Z4L81K83e+z7hoYUpgbQsJkDvZexHiXOyKR77fpNVxcV7VyYH+ag==
X-Received: by 2002:a63:214d:: with SMTP id s13mr100061pgm.277.1591200593145; 
 Wed, 03 Jun 2020 09:09:53 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.googlemail.com with ESMTPSA id m18sm2803067pjl.14.2020.06.03.09.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 09:09:52 -0700 (PDT)
Subject: Re: [PATCH] tcg: Sanitize shift constants on ppc64le so that shift
 operations with large constants don't generate invalid instructions.
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 agrecascino123@gmail.com, qemu-devel@nongnu.org
References: <20200603052308.11744-1-agrecascino123@gmail.com>
 <2a0fa3cb-9527-ae8b-e89b-2af08e2f54f4@amsat.org>
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
Message-ID: <a28b37f0-b071-9e3e-2663-778c4491b03b@twiddle.net>
Date: Wed, 3 Jun 2020 09:09:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2a0fa3cb-9527-ae8b-e89b-2af08e2f54f4@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=rth7680@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Catherine A. Frederick" <chocola@animebitch.es>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 11:43 PM, Philippe Mathieu-Daudé wrote:
> 
> Hi Catherine,
> 
> On 6/3/20 7:23 AM, agrecascino123@gmail.com wrote:
>> From: "Catherine A. Frederick" <chocola@animebitch.es>
>>
>> Signed-off-by: "Catherine A. Frederick" <chocola@animebitch.es>
>> ---
>>  tcg/ppc/tcg-target.inc.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
>> index ee1f9227c1..a5450a5e67 100644
>> --- a/tcg/ppc/tcg-target.inc.c
>> +++ b/tcg/ppc/tcg-target.inc.c
>> @@ -790,21 +790,25 @@ static inline void tcg_out_ext32u(TCGContext *s, TCGReg dst, TCGReg src)
>>  
>>  static inline void tcg_out_shli32(TCGContext *s, TCGReg dst, TCGReg src, int c)
>>  {
>> +    c = ((unsigned)c > 32) ? 32 : c;
>>      tcg_out_rlw(s, RLWINM, dst, src, c, 0, 31 - c);
>>  }
>>  
>>  static inline void tcg_out_shli64(TCGContext *s, TCGReg dst, TCGReg src, int c)
>>  {
>> +    c = ((unsigned)c > 64) ? 64 : c;
>>      tcg_out_rld(s, RLDICR, dst, src, c, 63 - c);
>>  }
>>  
>>  static inline void tcg_out_shri32(TCGContext *s, TCGReg dst, TCGReg src, int c)
>>  {
>> +    c = ((unsigned)c > 32) ? 32 : c;
>>      tcg_out_rlw(s, RLWINM, dst, src, 32 - c, c, 31);
>>  }
>>  
>>  static inline void tcg_out_shri64(TCGContext *s, TCGReg dst, TCGReg src, int c)
>>  {
>> +    c = ((unsigned)c > 64) ? 64 : c;
>>      tcg_out_rld(s, RLDICL, dst, src, 64 - c, c);
>>  }
> 
> I agree there is a bug, but I am not sure we should silently cap the
> value this way. I'd rather see the caller provide a value in range, and
> maybe the callee use 'tcg_debug_assert(c <= RANGE);' to catch future new
> caller added missing the range check.

We have done this before: see 1fd95946657.

In tcg/README, we note that out-of-range shifts produce undefined results, but
should not trap with illegal instruction.

I would like to know more about where these out-of-range shifts are being
generated, but I do know that there are innocent ways by which this can happen.

For instance, one way in which we can translate a guest in which out-of-range
shifts produce zero is

  x = (shift < 32 ? y << shift : 0)

using INDEX_op_movcond_i32 for the ?: operator.  Which means that
we use the original (out-of-range) shift and subsequently discard the undefined
result.

Catherine, I think it would be more appropriate to mask C rather than bound it
to another out-of-range value: c &= 31 or c &= 64, with a comment about
avoiding an illegal instruction, just as in the tcg/sparc patch I reference above.


r~

