Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D312C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CD0206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NB8uBapd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CD0206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCT3-0004ZN-8N
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgCS9-0003zv-Sd
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:20:01 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgCS8-00035y-C4
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:20:01 -0400
Received: by mail-pf1-x442.google.com with SMTP id a127so3549560pfa.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1Snt2MuRNtA8FjEWhTYKly8HzdU4HIoXdYBdbSThMQ0=;
 b=NB8uBapd+UH+BAYMJsdx2lcqy4qbiD79Pv+mUmFv5gwYIbx86qw9vjW9EPYAJTD6Xq
 x3Akx7bq5e2m5fGa0IFMLC21ULwGELZe9tIEv0havDK28Fi3dk7bhZ2eW9yPCMUoVJor
 bnKicDrekKrrWe6GtS7nQo2a00cUKD1MeDzxG5zHosWlnOSULx+l/JLjStcQzQJWgwDg
 p9vM2VAawIRs5SkRfMNa0KgME+1pgRbeiXyM+gcYHvm9kH0U++V8781OwCHMt4VLjJqE
 cqt++T+WFIXa8Rgp40Tjw0zc7jh+tKyA+7+0ISGAsvATSqMvHgQ2/4nCFZ0MoMHPqvLu
 oOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Snt2MuRNtA8FjEWhTYKly8HzdU4HIoXdYBdbSThMQ0=;
 b=uBDTc0VAzYzsiDfUHZKUc+XWta0l7E40Cbm8fL7zP+/xqW7Wikf+BVvb6kq6p/+ggv
 SCRd1yAmHSnPugzqWn9NdC2RyOOXMJY1FuQ9HR/+tyPgZ2gV1dHVGDxYSIoPlL2hjUW3
 NDLLuj+I2en9SugEqB0Tq0hH2q6WufWEMFronA976EZj93mA2rPGbmADfp4qZ/Rq3UNZ
 tWDLkffYS+AugueGsFdJjPspq+6mH7HxQRIZxIwuGak8DVtpFTJFiLvBlYb9/0Sn8Uwl
 PRMTVNbqobMZWkGsYVZKa/zaec5cqxaKX0HQEgSRa5gp4N1A3CZMdkQJrFUXehAv6XWW
 xCfA==
X-Gm-Message-State: AOAM53254gx2SRk/VGv/DL2UZXEiZqaWCyRZofgqaXoXNLft9ShuQncP
 r9B2hzZ5z90Upzk510fBVUuvT7naX9E=
X-Google-Smtp-Source: ABdhPJy/4pUMMyuDpgLIBqWKFHMlt4FL0rzDE7B0xUI6zu2FVyuo1u61VAtfbEjbGrSbFfQ15rfNYA==
X-Received: by 2002:a62:1d48:: with SMTP id d69mr27526190pfd.27.1591125598297; 
 Tue, 02 Jun 2020 12:19:58 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id w12sm3249403pjb.11.2020.06.02.12.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 12:19:57 -0700 (PDT)
Subject: Re: [PATCH 7/8] decodetree: Implement non-overlapping groups
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-8-richard.henderson@linaro.org>
 <CAFEAcA9goz6quKG7zEGtOkYEUhfX10PB_MNMr6Vzvfz1OCZgSw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e52bbe8e-8da3-8527-ea08-3f895e8fba77@linaro.org>
Date: Tue, 2 Jun 2020 12:19:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9goz6quKG7zEGtOkYEUhfX10PB_MNMr6Vzvfz1OCZgSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 12:13 PM, Peter Maydell wrote:
> On Mon, 18 May 2020 at 17:41, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Intended to be nested within overlapping groups.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  scripts/decodetree.py | 21 ++++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
>> index 0ba01e049c..a9739f671d 100755
>> --- a/scripts/decodetree.py
>> +++ b/scripts/decodetree.py
>> @@ -1021,21 +1021,22 @@ def parse_file(f, parent_pat):
>>          del toks[0]
>>
>>          # End nesting?
>> -        if name == '}':
>> +        if name == '}' or name == ']':
>>              if len(toks) != 0:
>>                  error(start_lineno, 'extra tokens after close brace')
>>              if len(parent_pat.pats) < 2:
>>                  error(lineno, 'less than two patterns within braces')
>>
>> +            # Make sure { } and [ ] nest properly.
>> +            if (name == '}') != isinstance(parent_pat, IncMultiPattern):
>> +                error(lineno, 'mismatched close brace')
>> +
>>              try:
>>                  parent_pat = nesting_pats.pop()
>>              except:
>> -                error(lineno, 'mismatched close brace')
>> +                error(lineno, 'extra close brace')
>>
>>              nesting -= 2
>> -            if indent != nesting:
>> -                error(lineno, 'indentation ', indent, ' != ', nesting)
>> -
> 
> Why do we lose this error check ?

Hmm, wasn't supposed to.  Will fix.


r~

