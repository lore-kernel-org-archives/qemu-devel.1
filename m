Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF13C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 23:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8B422203
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 23:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SmvA2ixJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8B422203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTZTz-0007Gs-Gd
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 19:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTZTE-0006Mw-Uy
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 19:49:12 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTZTD-0007lF-B8
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 19:49:12 -0400
Received: by mail-pj1-x1041.google.com with SMTP id u3so2341256pjr.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4lQ6WBBIyDAhkbiuynrgQyIpW3MC2noTeG/qZKigPys=;
 b=SmvA2ixJGq273NoqDfss6GKr6yTuR4/EDiMucacjlTGScEwjgpG2HbnOrtZlwGSaC5
 SnbTWQ2iemR3v/u4rYGtbc6JE1LuTwh+DaCRjgu90TsAffuSDvEEkcvXec5UWc+JyoRT
 G8bTRzzlgyvbzBpqBd8zpyBvu4q69MuBqSu5X9HhG9KidobS7JQegNHxMgNiUDNv4D4l
 tCqFkLcrOWI8C80CBUNQMnD/3wc50UTjgRBCfqoA+AP+qAys5lVd93TNKBF9+CTi55VR
 nr0NqYjOorSHOqtABc5bpeJSQhPqH3HnKd/V7aVHTj41ulJ5292TVf9Rdg0/X6blGNec
 gnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4lQ6WBBIyDAhkbiuynrgQyIpW3MC2noTeG/qZKigPys=;
 b=CtVX0HmInheZaPv/huGISoNR9XH7NyWZ86QrmYmePrDaN/sFXtqGhFXj33RGW1ZKxK
 gnZJo/IKt0cxhvr4cS1ABuEFG7UocjYwELKf67zChRPuenGqhUjrj2Vy28PMlQORVUnW
 RvDTUdlcgITNHn6aRdp/hGPR/ST3AziDZ8X7mxR01R1J48kLTSVEzIkqMT/c6ib2g7bk
 Zn3FcVOl5MoVNCpBcNe19+rph58L5SMlRTuyk1hisTr57thuP21vWl1j7MHQvw4HBsCd
 yXbyeyOlQ/q1HKlwUTZSrmfUiEIbG3VAjUewXi5UQiAXEmUMLCnvKMOOtyD0iggPXlo9
 6V8w==
X-Gm-Message-State: AOAM530p1IWdY1r9LufhFtPH4p5of0u5MFLb9b6a5sRW0CbQVxqSKlB4
 +w/lpcXqGUTXt4nBjqIWck09Pw==
X-Google-Smtp-Source: ABdhPJwHfDjHP70yiY/dRUhX4B8FAiHhebq2IXnyi/9qosc+lxrqVJ/UYeEPa8ZDxGrqthr4lwnCgA==
X-Received: by 2002:a17:90a:cb92:: with SMTP id
 a18mr6346915pju.136.1602892150038; 
 Fri, 16 Oct 2020 16:49:10 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q24sm3666472pgb.12.2020.10.16.16.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 16:49:09 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] [RISCV_PM] Support pointer masking for RISC-V for
 i/c/f/d/a types of instructions
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201016221138.10371-1-space.monkey.delivers@gmail.com>
 <20201016221138.10371-5-space.monkey.delivers@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03c43a23-8418-a7af-fca2-2860f5433ee8@linaro.org>
Date: Fri, 16 Oct 2020 16:49:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016221138.10371-5-space.monkey.delivers@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, GAPPY_SUBJECT=0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 space.monkey.delivers@gmail.com, Alistair.Francis@wdc.com,
 kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 3:11 PM, Alexey Baturo wrote:
> Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
> ---
>  target/riscv/insn_trans/trans_rva.c.inc |  3 +++
>  target/riscv/insn_trans/trans_rvd.c.inc |  2 ++
>  target/riscv/insn_trans/trans_rvf.c.inc |  2 ++
>  target/riscv/insn_trans/trans_rvi.c.inc |  2 ++
>  target/riscv/translate.c                | 14 ++++++++++++++
>  5 files changed, 23 insertions(+)

This will need changes for RVV, but let's omit that for now, so as not to race
with the in-flight update to rvv-1.0.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


