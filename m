Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3795DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E1421D91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/N8xGoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E1421D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWZP-0002WY-DO
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLWXj-000122-JA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:04:35 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLWXg-0003hr-CC
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:04:35 -0400
Received: by mail-pf1-x442.google.com with SMTP id x123so262514pfc.7
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=afxaCANzAkYhgT68z/vBr25c7T4kJTQy02kHhSi3G3c=;
 b=d/N8xGoEX334oCviSkuGjxsFMQVQL4Ve4QBpwHn3mQjEKykcwXSAvcZ/97Qor6ZgJK
 6hduevzubhQkPP+eFWNFG6evLEiYnTvYLbQ1iF7Ohu8QY3LbIe9R/Uqm0iffrNEjiKoV
 gK0Ts+p2RAHfExxfyK8Iz2YnsuAqR1OoL3K6cXIu/lz1mSfCuSEy16KSXwfbvu+7XKop
 R77LqVsSFplEtcL8cUhc2vpoRnWoLZYDsh4maKjH7xtBGSFmfK4xkkw7PzK7NtXmu1Y2
 waYC8MV8XTdlPq9pd6nohL+2kBLuu+EQP//qN1r9ToxvdYR2HPBV//tS/U4hlh1u3ROk
 iGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=afxaCANzAkYhgT68z/vBr25c7T4kJTQy02kHhSi3G3c=;
 b=m/JU/sUKv5ilDyEcaKu+qLM/aAk5UZL2NA59WQ1rsj/y9S8TN0xAfr4VNeDGTb2RXK
 9RQkqhVzKGGYBoJZm+oo+KqsIpeDYQ/A08BoDUvUzmw9/o9hRbCh8YP+H72fUkkaq/N6
 2mf10juM/2Pz7sFEqB5kSiYlxDqvshGthEN84DMO+YLVOCEJMqnnLIkAASYEUEV3i9lf
 eGI2dmRzbw5k4WVBOvaJW9TiSxiEoZ8VNscj3ylFz/p5QPEeowik+6neJBSDDSO3Kjie
 YemzpIAvsHoGE67jadWO+f/6A3qHdoxefKXM9/IoRvScNtFSQGu2tI1DajP51UoKnnbI
 LKhA==
X-Gm-Message-State: AOAM533KC60L3ZUtSxGToCSRhNSvTc2ktE5aV473B2v9vdj6sK2UaONs
 XVzBYl7Xyzs22q5V5vSG11UZCw==
X-Google-Smtp-Source: ABdhPJzXqJwmaQEtDJCbBVfBy54W7xl4kjYr2YXq4mCb04TK4u/M1QFtt1coTTgarYn/jaAbWOgL1A==
X-Received: by 2002:a65:5786:: with SMTP id b6mr446585pgr.114.1600974269760;
 Thu, 24 Sep 2020 12:04:29 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c186sm125209pga.61.2020.09.24.12.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 12:04:28 -0700 (PDT)
Subject: Re: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <a0987bce-409b-cd14-7559-c63413ff2b6f@linaro.org>
 <BYAPR02MB4886985CC5CBF78F7D5DBFE5DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <fca34122-160d-8c13-d237-a87a917f341b@linaro.org>
 <BYAPR02MB4886D48EDC604CEEF65FDAA7DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <1cf57f2b-a2c8-6fbc-2c1c-9945a5d77dd8@linaro.org>
 <BYAPR02MB4886F055CBD52DBEE5F269AEDE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <0241f731-61de-41bc-9f58-bc43725eef74@linaro.org>
 <BYAPR02MB4886B33025BE2B65D6F5F5A8DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <f0011ef6-014c-748b-7fc1-ea0f7878c281@linaro.org>
 <BYAPR02MB488667B684F8CEC755CBFD72DE2E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB48865179810F9248DE1280F8DE390@BYAPR02MB4886.namprd02.prod.outlook.com>
 <e279b41a-a815-ec0e-46e2-2adf8f0b3398@linaro.org>
 <BYAPR02MB4886EA66077760A6B43FC388DE390@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aff8ebf6-2c1d-f3d4-014a-421940fd72b5@linaro.org>
Date: Thu, 24 Sep 2020 12:04:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886EA66077760A6B43FC388DE390@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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

On 9/24/20 10:18 AM, Taylor Simpson wrote:
>> You've got a script generating stuff.  It can just as easily generate two
>> different lists.  You're trying to do too much with the C preprocessor and too
>> little with python.
> 
> Sure, generating two lists was also suggested by Alessandro (ale@rev.ng).  Although doing more in python and less with the C preprocessor would lead to the conclusion we shouldn't define the function prototype in a macro.  If we generate two lists, what is the advantage of putting the function signature in a macro vs generating?

None, because...

>> At some point in the v3 thread, I had suggested grepping for some macro in
>> order to indicate to the python script which tags are implemented manually.
>> My
>> definition above is easy to look for: exactly one thing on the line, easy
>> regexp.
> 
> This is already done as well.  As you may recall, we were previously generating
>     #ifdef fGEN_TCG_A2_add
>     fGEN_TCG_A2_add({ RdV=RsV+RtV;});
>     #else
>     do {
>     gen_helper_A2_add(RdV, cpu_env, RsV, RtV);
>     } while (0);
> 
> The generator now searches for "#define fGEN_TCG_<tag>" ...

... I'd forgotten that they were two different macros.

> Also, if it finds the override, it doesn't generate the DEF_HELPER or the helper function.  That means we don't include tcg_gen.h in helper.h as you suggested.

Excellent.


r~

