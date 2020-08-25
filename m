Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7AAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1403A2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbLwQXhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1403A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeuS-0002dR-Be
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAedS-0006Et-ND
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:29:34 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAedR-00078u-02
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:29:34 -0400
Received: by mail-pj1-x1041.google.com with SMTP id j13so3996pjd.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=+/P7QJvPvgwPmPuqawkAWI/JesMR0w1aiFyilNYkSbI=;
 b=sbLwQXhekuiqAqEc3sHZnamf/hYojs0QyZY4tM1hOBtWwRRHM776bf+gHA+95ycwEy
 6OsBbD0YKLqzZdRDJfLxwq2Ln2zDVvEF3O6PpBia2N2zJTNEIwspT0UCEF/TwRyMqsh1
 WKqqsZ77BrlUKEeLl2qFC1jM6MTz3FQUv4WJOzeVVL6CK6ywP5/8voPx2p0BHM3A6gy8
 JRXelxGXXPeYNMFEuyvuIPflZldwSsKNgJDcy5PcR1qGnGlyuHrTwdk/zTG5Nmug82SI
 xynWlj1AsJ8Ci2D4UrYcqbmf3X1E/u2uOilBqo7xujOGNwgWf9K3HOcdo7qFPKvbdyuk
 RT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+/P7QJvPvgwPmPuqawkAWI/JesMR0w1aiFyilNYkSbI=;
 b=Ht0eRIDgIWtFt29602qwf5buZ1meikFRX4sqaMaWM7rIIbxcNZpBGdHU5bCDwQeR4O
 n8m/gpKTWIXnWNzrvA59+UJe9sIADGtBt6gYqXqm+o1oDx64LG5ue0U3GWANvERztZFU
 c6c/Ae5Lhp0r79qpMBVLeDtwY5YH9jUDvoxgsJKQFduN+yLorVkrZy6SgcDXkB27YG/W
 2LiXFsNw1CioJ8rZq7lKVWcNsbW+3mBahuq4/HmaYuDOyiwAMSJkOZcu8d4V790so16o
 I9urbEuYgAuiXwEWeU0+4l1h2zkzw85E3irdHGJ2MdA0Mv91SIJX5bqL3YXs/BMcHSqa
 oNhw==
X-Gm-Message-State: AOAM532qAUs1sZQnt8Do1TOKahcyjukJjdU8KnI50Ej+5BT9IkzFvF1Z
 QkU0Fm+VpvVldPsmsYQLs17BM/g8ixHPPw==
X-Google-Smtp-Source: ABdhPJxI23Kb3TbRIF9EhyvMuQIrdGGS3oNBYOx3S7xMlPWeAH0srVWmxHJVpRwjEqhXbcCxo+RrHw==
X-Received: by 2002:a17:90b:4a0a:: with SMTP id
 kk10mr2836352pjb.30.1598383771011; 
 Tue, 25 Aug 2020 12:29:31 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id fv21sm13172pjb.16.2020.08.25.12.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 12:29:30 -0700 (PDT)
Subject: Re: [PATCH 21/22] target/arm: Implement VFP fp16 VMOV between gp and
 halfprec registers
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-22-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <18ecf3fd-0100-7fc4-18d5-631e62a3b4dc@linaro.org>
Date: Tue, 25 Aug 2020 12:29:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/24/20 7:29 AM, Peter Maydell wrote:
> Implement the VFP fp16 variant of VMOV that transfers a 16-bit
> value between a general purpose register and a VFP register.
> 
> Note that Rt == 15 is UNPREDICTABLE; since this insn is v8 and later
> only we have no need to replicate the old "updates CPSR.NZCV"
> behaviour that the singleprec version of this insn does.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/vfp.decode          |  1 +
>  target/arm/translate-vfp.c.inc | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

