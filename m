Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B153CC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC7F206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3ITc092"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC7F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsGT4-0005O3-Rc
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 20:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34459)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsGSR-0004qq-Ij
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsGSP-0004Vt-S2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:57:39 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsGSN-0004Tq-Ti
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:57:37 -0400
Received: by mail-pf1-x443.google.com with SMTP id g2so28890371pfq.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 17:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=esrCG6HfxpWpYhrk5c7Xqz0WWHxzjIRuUMh3KVljiLY=;
 b=t3ITc092eLc6++yaikhVL3DVwWbdIrLGhMNQ0JlTCZHd1p9pA4PbWw8l/9QTwmArcI
 GWoVturtvh7o7eVENk7L58Zs/VSGXDeFL4bhenP+NEh28EHM4y8z4Sq4XbG6aNmom452
 2Nt9mnuDbcGMI5RLmJRoWfTqmap0mZ1itfweiLqVkpm2lp9eSBEeiao7ZlLbLke8iRRS
 3Ux42cy7b3cAD3mQgxzKuloCzkrj8nXrS7uVCVA6/aXHvFUQQF/ZGzhuiF1bGEd03Unn
 Z23h7ikx/snVByURRAYkxBEy95eXfxS5kWOVhnan9LAHQwMA22F/b+mH0rlR2N1SBbEh
 hpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=esrCG6HfxpWpYhrk5c7Xqz0WWHxzjIRuUMh3KVljiLY=;
 b=Gt0olGD3USni7nHXW9mXJM+DWIMixGnxplKO3Mf5uifSFEmPWhFDZvSEUkMwLgckog
 wpkP+iicpBtY+5ThqWhcPY8Asgv6jHPxCXvhmilQjAd+Z5fNRTlVhBI1qPILG5dCWTxT
 3yrtx1b7BcTf6Wdq1Z2YjotH/eBEIfPTOXch707haVvPCXjRO5qsNZvh9iNtvDHv7XEm
 7n+5TFnixAAPqT4IHUOrc2tWWlUlN8Gk3muQEDVIlJAt9ywzgsRR+E/og0F6FFX/eGhV
 ec5wpMEh16O2omwPD5HxUAieU8ysSFmmn1XPrq+DwzgEu4Tq/pnJJ2cvUhdQHfzhEK7R
 24Fw==
X-Gm-Message-State: APjAAAU3IQ/ES0D6bidg03xtZVVM/DnFKDjty4S+ynl8z/FKRbW6UJ33
 0MGjpEEvWqPaRSbVGcAoe8KT6Q==
X-Google-Smtp-Source: APXvYqxLMpRzsoexi6Tu0g5PXjmE6TMWpnvjQLMeCFmVe73bznFElY419zg9aLx7Zv92GtwxNgR3bA==
X-Received: by 2002:a63:2252:: with SMTP id t18mr106902673pgm.5.1564448254072; 
 Mon, 29 Jul 2019 17:57:34 -0700 (PDT)
Received: from [192.168.101.105] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id j12sm54558458pff.4.2019.07.29.17.57.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 17:57:33 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-11-richard.henderson@linaro.org>
 <CAFEAcA83GM6wgWs1xGygmqCoir=CXtFXYkzPBMdUeb638kCzmw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <28a5710a-37a7-2d6a-1609-5218d5e8e931@linaro.org>
Date: Mon, 29 Jul 2019 17:57:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA83GM6wgWs1xGygmqCoir=CXtFXYkzPBMdUeb638kCzmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 10/67] target/arm: Move test for AL into
 arm_skip_unless
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/19 7:32 AM, Peter Maydell wrote:
> On Fri, 26 Jul 2019 at 18:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We will shortly be calling this function much more often.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate.c | 28 ++++++++++++----------------
>>  1 file changed, 12 insertions(+), 16 deletions(-)
>>
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index 53c46fcdc4..36419025db 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -7705,8 +7705,14 @@ static void arm_gen_condlabel(DisasContext *s)
>>  /* Skip this instruction if the ARM condition is false */
>>  static void arm_skip_unless(DisasContext *s, uint32_t cond)
>>  {
>> -    arm_gen_condlabel(s);
>> -    arm_gen_test_cc(cond ^ 1, s->condlabel);
>> +    /*
>> +     * Conditionally skip the insn. Note that both 0xe and 0xf mean
>> +     * "always"; 0xf is not "never".
>> +     */
>> +    if (cond < 0xe) {
>> +        arm_gen_condlabel(s);
>> +        arm_gen_test_cc(cond ^ 1, s->condlabel);
>> +    }
>>  }
>>
>>  static void disas_arm_insn(DisasContext *s, unsigned int insn)
>> @@ -7944,11 +7950,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>>          }
>>          goto illegal_op;
>>      }
>> -    if (cond != 0xe) {
>> -        /* if not always execute, we generate a conditional jump to
>> -           next instruction */
>> -        arm_skip_unless(s, cond);
>> -    }
>> +
>> +    arm_skip_unless(s, cond);
>> +
>>      if ((insn & 0x0f900000) == 0x03000000) {
>>          if ((insn & (1 << 21)) == 0) {
>>              ARCH(6T2);
>> @@ -12095,15 +12099,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>>      dc->insn = insn;
>>
>>      if (dc->condexec_mask && !thumb_insn_is_unconditional(dc, insn)) {
>> -        uint32_t cond = dc->condexec_cond;
>> -
>> -        /*
>> -         * Conditionally skip the insn. Note that both 0xe and 0xf mean
>> -         * "always"; 0xf is not "never".
>> -         */
>> -        if (cond < 0x0e) {
>> -            arm_skip_unless(dc, cond);
>> -        }
>> +        arm_skip_unless(dc, dc->condexec_cond);
>>      }
> 
> In the other callsites for arm_skip_unless() the cond argument
> can never be 0xe or 0xf.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

In my original version I included cond in the fields collected by decodetree,
and so every single trans_* function called arm_skip_unless, so that would not
be the case there.

I discarded that in the version posted here, but I still think it might be a
cleaner design overall.

In the short term, maybe I should just discard this patch?


r~

