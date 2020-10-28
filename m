Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A70C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6068B2474F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7n4EWj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6068B2474F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnRl-0000bh-Pv
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXnPw-0007gs-Or
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:31:18 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXnPq-0008Hs-Rm
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:31:15 -0400
Received: by mail-pl1-x641.google.com with SMTP id 1so2649355ple.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uHekAQPQf1cFTngoq7ZWMI1V3FXJujdAXNxZYCBxfDA=;
 b=h7n4EWj7vMCtzKMhjUy6KE12xFxNBxtYbxENyxxPkMWmzmRLqZX+o4smUsm7tGUEYf
 2rCxbJLP3YYHiqsnqzf8JH1EXMrAboQCsgtqls1Cev/Q59rOBAxOhf8Lmqt4UVYIKTP4
 ND5r4CV4Qd8lLsmhr4x82JJpVgfOba+zTJfhfpet/n/QnlGF5N+aWI7HEXPRnPcOurIZ
 //nMaxTR910AmYrddHo50qk42oSetbeiLlCNlwN3pobg+SnVCKPaW4S64q67OgYUI5Yj
 Q8VVoOBFZ6AxqhyWypBxeVEA4iXuR3AQ2hJA4OkGDXAm5c1eqPuwmy7GEffJ75Tp4ZkO
 H+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uHekAQPQf1cFTngoq7ZWMI1V3FXJujdAXNxZYCBxfDA=;
 b=TUQC4GuF4uken1KC5BOyBkMu/KTK+MzZb6qbxsf/fXWf90O54y/e73kI0uoZVQhI0Y
 ZZLRrTB2xL89VNZy5J/4M8TVgbhGh7NTkQAkdt3UhZ5/0+UaXEEiegciHaXLS8mO0Icy
 hp/V8UnZdqkfB3NgQr4W2GHu2zTG9VT4cwwelIVzeAARY5vdUUwI4T28Ag68MQS2VmnV
 mUxgZlpmaG0u8vy/hoLchAf6qFW0d+7oRf2cALD+nXkO/9MNiX0tZ5CGMlkGNjND3Q2C
 5klMllGtTK8KMAxqTWW0PRyhhwZiLGnNltJfTLRJ3VcLkneVL6gCoiiEjKclKXx9qp1E
 7RFQ==
X-Gm-Message-State: AOAM531di2Y1rz/Ed46U1i9rJLj3LKnGON5dZFb+0uhxWujg2fDHBx64
 w+1xdjQw+6wk/PPqerhyQOMpPA==
X-Google-Smtp-Source: ABdhPJwShpw1VPvOd9S84ejRXyM4MZM/e0M07Wy6WnhrjJ2OukTpfWxUuQ0oqj/w3AwNdxdvKo3VZg==
X-Received: by 2002:a17:902:74ca:b029:d6:7963:5bae with SMTP id
 f10-20020a17090274cab02900d679635baemr2203469plt.4.1603899067158; 
 Wed, 28 Oct 2020 08:31:07 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n12sm5666178pjt.16.2020.10.28.08.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 08:31:06 -0700 (PDT)
Subject: Re: [PATCH 1/9] target/i386: silence the compiler warnings in
 gen_shiftd_rm_T1
To: Thomas Huth <thuth@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-2-kuhn.chenqun@huawei.com>
 <30ca9af0-dfc2-e236-5575-068cec679508@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d1d59436-1a8a-7aa3-7983-4344e16ab881@linaro.org>
Date: Wed, 28 Oct 2020 08:31:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <30ca9af0-dfc2-e236-5575-068cec679508@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, zhang.zhanghailiang@huawei.com,
 ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 5:57 AM, Thomas Huth wrote:
> On 28/10/2020 05.18, Chen Qun wrote:
>> The current "#ifdef TARGET_X86_64" statement affects
>> the compiler's determination of fall through.
>>
>> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
>> target/i386/translate.c: In function ‘gen_shiftd_rm_T1’:
>> target/i386/translate.c:1773:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>          if (is_right) {
>>             ^
>> target/i386/translate.c:1782:5: note: here
>>      case MO_32:
>>      ^~~~
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>> ---
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  target/i386/translate.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index caea6f5fb1..4c353427d7 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
>> @@ -1777,9 +1777,9 @@ static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot, int op1,
>>          } else {
>>              tcg_gen_deposit_tl(s->T1, s->T0, s->T1, 16, 16);
>>          }
>> -        /* FALLTHRU */
>> -#ifdef TARGET_X86_64
>> +        /* fall through */
>>      case MO_32:
>> +#ifdef TARGET_X86_64
>>          /* Concatenate the two 32-bit values and use a 64-bit shift.  */
>>          tcg_gen_subi_tl(s->tmp0, count, 1);
>>          if (is_right) {
> 
> The whole code here looks a little bit fishy to me ... in case TARGET_X86_64
> is defined, the MO_16 code falls through to MO_32 ... but in case it is not
> defined, it falls through to the default case that comes after the #ifdef
> block? Is this really the right thing here? If so, I think there should be
> some additional comments explaining this behavior.
> 
> Richard, maybe you could help to judge what is right here...?

It could definitely be rewritten, but it's not wrong as is.


r~

