Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3075BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBAE207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCG+Zy9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBAE207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeVr-0000YA-89
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBeV4-00007B-IJ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:33:02 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBeV2-0006Vt-Tl
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:33:02 -0400
Received: by mail-pj1-x1042.google.com with SMTP id z18so507238pjr.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7jrp/+CflktUpsSem1ifhJKZ4HJ3PGa/Oczs8rY5dxI=;
 b=lCG+Zy9wQZXrw38XfWfhzOXoN/Bq8N9Hcz134ywcrC4aUL0M+Z1VBOAy+slR/7BqNl
 9ZJASQoJlfF1cX0R6nvtO1QE0DBHvE+JJy+/NAYNp9jWObLeuXlGnf1VXR9Hi9AmPyUD
 EkShY7nKLErFqAAjhMBnDbpUTUfpfPlpgrHMbMV0uA7rl2zoykOjPKwwPaiuOyY2nE5l
 fBA5m8YGjmZig7JhXcewvBbo0bm2Pkeo8Hty6kTf+/ZZd8SR6Q7JvcHKo8iaYAfINcFz
 QbJZsDUlo+fDw/5wnEEKaJYv1HSI68RFNrmLCdx4Q1q0TMfQ8kW85BNGYUd6PsAAfjjx
 1+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7jrp/+CflktUpsSem1ifhJKZ4HJ3PGa/Oczs8rY5dxI=;
 b=P7EHezx3ohk6MAEIY+8iV5CLUzCCbHAbsU9M0VD6GGYXI/muFcEPiR6Z16piYmeRLS
 WDw9sk1p3GTm/c/S2LJh2P0WxIVd1A3v1ZL1iomgiLuZqRlu1jzw2m8ZV9stGb7vPYz1
 kqQb229h1Bzhol8UDcDWqAkCRRMAmoOKYcvkVomU6xbovT9Q61HAgZVS1AuDN74EpPNq
 N6DduHrwpvMoJhUUc8DtwPgtboIEjkl/v+c2+smOZjpPjgY8l5DEGnbMsppP147p5T5w
 D7N00ijuu8HdbvU+P/7esA10QwFAFjimtmWd2HSoh10kV94fmg/5DAULlE+T5v1msKhh
 TR0g==
X-Gm-Message-State: AOAM531rF9AEzmnrDaPzbXsW4V0Hx/8LFjEXL1bVyyARD/0Huz6KXi6T
 fNbDOx8EbNRP0OdNrwGSNwkefg7ecZQ7dA==
X-Google-Smtp-Source: ABdhPJyHoUZ97X4CXXK/m68RMj1cpkTsS+NC0yrf0/4QfRdyCpZmAl9Va1Dqak6jhp+Z9A5Zn4nqMw==
X-Received: by 2002:a17:902:ab96:: with SMTP id
 f22mr1356367plr.292.1598621578599; 
 Fri, 28 Aug 2020 06:32:58 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q17sm1797291pfh.32.2020.08.28.06.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 06:32:57 -0700 (PDT)
Subject: Re: [PATCH 66/77] target/microblaze: Use tcg_gen_lookup_and_goto_ptr
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-67-richard.henderson@linaro.org>
 <20200828063350.GR2954729@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e3c97b4e-e78b-5e66-bda7-9d9da03990b6@linaro.org>
Date: Fri, 28 Aug 2020 06:32:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828063350.GR2954729@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 11:33 PM, Edgar E. Iglesias wrote:
> On Tue, Aug 25, 2020 at 01:59:39PM -0700, Richard Henderson wrote:
>> When goto_tb cannot be used due to branch page crossing,
>> or due to indirect jumping, tcg_gen_lookup_and_goto_ptr
>> can be used instead.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Hi Richard,
> 
> This patch is for some reason causing some of our tests to fail.
> The PMU Firmware on the ZynqMP gets stuck.
> Looking at logs nothing obvious shows up, it just gets stuck.
> Bisected it to this patch, any ideas?

Failure to raise an exception properly, I think.  This patch makes it much less
likely to return to the main cpu loop.

The problem with the bisection, I think, is that this patch is in the middle.
It might be worthwhile to apply it directly to master and see what happens.

That said, I don't see what we could have missed in translate, setting
cpustate_changed...


r~

