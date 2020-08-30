Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8D6C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 23:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6C4208A9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 23:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meFQju+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6C4208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCWit-0007Sb-9W
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 19:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCWiN-00073m-Aj
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 19:26:23 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCWiL-0004px-BR
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 19:26:22 -0400
Received: by mail-pl1-x641.google.com with SMTP id y6so2168837plk.10
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sscLqnKXwWKjziiWKuQhtHpmGeXoreIAiHKNRsEi5DQ=;
 b=meFQju+ZjQH9mtTcv4KiA7yEvJYp1+WwbzkEUQTVOCGlxs0VsFMbd79TUThnHTznHq
 amqOoncrnc+YJ9s+SwqEN1VqIEsbYrDuUe8OHHPkRHwuROIs5GUjMpHkwPQJ3m4EE5yi
 5bz7oDmlpvx/5RV8nYUAjG15VzRKOj/8bhVGk5ZDSk1qO1roesasep+HmK8kf/7fWIah
 vXoYl0tfWQzLRLY/GiYmNVamyPttJcyIGHbXgbNRyG+xUHUwITyBTTN2SESiWubTiot9
 19OM6sQFf9fDE27lYrBaQ17Nccvzhe91ti9xUTLJk2ZFRyahNZ3MrE2a/a66Cd8BUF+N
 H0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sscLqnKXwWKjziiWKuQhtHpmGeXoreIAiHKNRsEi5DQ=;
 b=bCas0Pk11tq1z4iA9nk65CD1BYuhl6t81NjpcyFbsjkz49za6LvMUcP45Xt5MW/c/h
 nojfHC+BiqJDINWnD4Oo5K2Ev4bO6KjSNNQiDH/KGVONVcdLZhkppKg7+eAiZ2XcSwg8
 obG+1nGAX47qTNybtjb8S0kvzIYHKHhJVsTxf7TKQoHNu5rNQqG4n5kQ2ot44bXp/UqP
 KHmJKb/H/rPTl/wAel1CXbAi/sIX/EEGZbI80LmJJb2kWA5hwWkdkwxmAiDuGumZG0QD
 PPqAXO7AYqAPJdcHenxUgQ1OHOa+l/MZRNMBIrLec+JKt0aEDPsbg/ckqd7DpNkXt85q
 knzQ==
X-Gm-Message-State: AOAM532MYNkIiNhW7CHtSuJ3U/d/OH/D4JgFI2Fr2OthXVSNoJC0fDth
 uV26KF1w3IYeQIR92EoanzY7tA==
X-Google-Smtp-Source: ABdhPJwVHkmhY5uehcwL1cIP3WjErFS4s9QYCnGMEt4vsIQOfVXxYmfRw42Ft+LygNbBjXAG/GWFag==
X-Received: by 2002:a17:902:7c07:: with SMTP id
 x7mr6509112pll.119.1598829979473; 
 Sun, 30 Aug 2020 16:26:19 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y3sm5242978pjg.8.2020.08.30.16.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 16:26:18 -0700 (PDT)
Subject: Re: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-31-git-send-email-tsimpson@quicinc.com>
 <10127f7e-a2df-2f19-e897-9a874f9a5d82@linaro.org>
 <BYAPR02MB488691F539AD3A2BFA1C819DDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a0987bce-409b-cd14-7559-c63413ff2b6f@linaro.org>
 <BYAPR02MB4886985CC5CBF78F7D5DBFE5DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fca34122-160d-8c13-d237-a87a917f341b@linaro.org>
Date: Sun, 30 Aug 2020 16:26:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886985CC5CBF78F7D5DBFE5DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.207,
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/20 2:30 PM, Taylor Simpson wrote:
> 
> 
>> -----Original Message-----
>> From: Richard Henderson <richard.henderson@linaro.org>
>> Sent: Sunday, August 30, 2020 3:13 PM
>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>> Cc: philmd@redhat.com; laurent@vivier.eu; riku.voipio@iki.fi;
>> aleksandar.m.mail@gmail.com; ale@rev.ng
>> Subject: Re: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
>> instructions with multiple definitions
>>
>> On 8/30/20 12:48 PM, Taylor Simpson wrote:
>>> I'll add the following comment to indicate what's going on
>>>
>>> /*
>>>   * Each of the generated helpers is wrapped with #ifndef
>> fGEN_TCG_<tag>.
>>>   * For example
>>>    *     #ifndef fGEN_TCG_A2_add
>>>    *     DEF_HELPER_3(A2_add, s32, env, s32, s32)
>>>    *     #endif
>>>   * We include gen_tcg.h here to provide definitions of fGEN_TCG for any
>> instructions that
>>>   * are overridden.
>>>   *
>>>   * This prevents unused helpers from taking up space in the executable.
>>>   */
>>
>> Ah, hum.  Well.
>>
>> How about we figure out a way to communicate to the generator scripts
>> which
>> functions have been implemented "directly", and don't need to be
>> generated at all?
>>
>> I don't see why we have to wait until the c preprocessor to remove this
>> unused
>> code, and the less we have of it, the better.
>>
> 
> A few reasons
> - Makes it easy to override instruction helpers.  All one has to do is #define fGEN_TCG_<tag>.

If the generator can examine, say, genptr_override.c.inc, then you don't even
have to add a #define.  Just add the code.

Perhaps something like

DEFINE_FGEN(tag)
{
    // some code
}

where DEFINE_FGEN expands to the appropriate function declaration.  The
generator then need only grep '^DEFINE_FGEN' and extract the list of overridden
tags.


> - When debugging the override, sometimes you want to quickly revert back to the helper.  Or if you've written a bunch of overrides in one shot and then find that a test case is failing, you can binary search which one to turn off and get the test to pass.  This is the one with the bug to fix.

No difference there, just binary searching on different text.

> - Reduces time for an incremental build.  When we add or delete an override, we don't have to re-run the generator.

About this I care not at all.  I can't imagine that more than fractions of a
second are at stake.


r~

