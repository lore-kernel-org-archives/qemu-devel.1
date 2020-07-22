Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A595EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D58F20787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="leUSnBs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D58F20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHOA-0001kM-No
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHNC-0000vP-3J
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:13:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:32920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHNA-0003Lu-II
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:13:37 -0400
Received: by mail-pf1-x42b.google.com with SMTP id m9so1544255pfh.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Re2PK0LJsagIgr6c5yITwnXVNSmcxrZuYOW7wUFVdU4=;
 b=leUSnBs3HcLfwGEVs66IHc6kcTgNimQa8ATf/L8Gs1KyNxctQh8IH4vXa+GyKbur2E
 tErgWE/7ZRxlbMwdl+RY6zcUhRIn3p3XIVVduNLLSATWhePWJx0ymHnMB5VlMClgNM73
 pKjgAhyONNY5ybqwjx8eCf84uRVSlDHejJSJNVBhQoymL8dEL2oSnu87dPLctZbkoFbm
 rmk0yzDHlgUVACRHHYb9PYj2Ahuosk5b1NP5uwfv/dsboqiBjixS6/IPvqs9TiQ2mFdh
 0uh6TYna4OLu7TMXJA/m7BXNUPI+XxoV8XVSIFh/AlrwP0x00+GWSafIyJIgPB6a9Uas
 Vq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Re2PK0LJsagIgr6c5yITwnXVNSmcxrZuYOW7wUFVdU4=;
 b=Ce9s6r/nt2mKpq/EenOekHUNLShGmrH5M7MnaO04LlrYgDTRN/BVU92L9ezoina6T7
 DiXh2k5uEJz31tW7hDh2FTfciHuez0DMK+xckgrPcHAwlA25ClF5rQUggZfKaK91N16D
 gQrdRHe8yCWU+xkHedAPRoHPRWWGvvV4i+20SmaR8hqYxvUtH6558c99Vvcrj2wXp3aW
 29awt2xBwWZ6c1x1ISN7huC5nvrGvYGnUT472H2HqgwlxUewsyHFbMk2IzZQ9GL+QIJ9
 IGiiDfZrJWvts3HN2HxqYDn7p5saM3LoxORqyQakgEUm+U1EjiBOkT1bwdOFAA5tgrlV
 aJPw==
X-Gm-Message-State: AOAM531BN0dUjVU96v4zusjwfK67iWWb/qfEnUIoBkrpVDe2mrL849+r
 ZmCDCRwz1sb+Pe+0O2HtRfIRpQ==
X-Google-Smtp-Source: ABdhPJwL/QCh4Yr2vyNbk7Y1ic+zVK0k9/kfInodsWAxRxTtf9jrnNFbEIM5Esfkf7ds/AJB1coZNw==
X-Received: by 2002:a62:8603:: with SMTP id x3mr374290pfd.268.1595434414764;
 Wed, 22 Jul 2020 09:13:34 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 gv16sm159966pjb.5.2020.07.22.09.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:13:34 -0700 (PDT)
Subject: Re: [RFC v2 02/76] target/riscv: rvv-0.9: support vector 0.9
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-3-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <172338a7-1553-dd19-c6c0-f02f4c538b39@linaro.org>
Date: Wed, 22 Jul 2020 09:13:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-3-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/cpu.c | 24 ++++++++++++++++++------
>  target/riscv/cpu.h |  2 ++
>  2 files changed, 20 insertions(+), 6 deletions(-)

I think you can squash this with patch 1, just so you don't have to churn
functions like set_vext_version.  Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

