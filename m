Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A97BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FAF206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSMJbgPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FAF206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDATe-0008EO-A2
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDARP-0004me-IM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:51:31 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDARN-0002pJ-Sp
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:51:31 -0400
Received: by mail-pl1-x642.google.com with SMTP id q3so900222pls.11
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ro2Rl5wdBPD/kzu6hnJ6M6szkpWVmSdl7U6ElcaMpk0=;
 b=PSMJbgPQHLQcvU+f5h7VzHrAWet+QOAyJSohG3ov9Yjpo/bWVo8XDJorYgfn39roCs
 t8E7QohgbNe69CwTjrqqhkoFfyabdpFFJNA6y+bwwSD8JO4zpfmKIWgKnBv3BpU8Ln+c
 35XvFaURIcSnLQOOdq58k+gMVWmJcToaiNDbihY+0tSfPHOd0hX8VlDW9UcLg9jkGFZw
 DfmktkltK6fiyVefEsXmH33RswM+xnmXBagTh/+Jjc1QDOgGwnK9SyEuhapVlWDkiwkr
 Xo8ws4hvSRZv0+vdLtQFrKLwlkzqMxxQCtn6dF3RsXY9rButKnp/AiEOWgGqjQ8C9r0/
 3spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ro2Rl5wdBPD/kzu6hnJ6M6szkpWVmSdl7U6ElcaMpk0=;
 b=nwtN+C7NhIlqFXiLojdxczwEgInBrhoM5gNkpxrWkpa2KVbLjsCD2/erpZu4d2Mdmd
 F95PWopDX03bB7pquldhjNPWyK0cDg3K+dErMWWN5hBSe6iKwHaJb5tTGNrju4qpOFsf
 NDTZSXitySo89CX4J8mqvSwfOsfN56ZXmvlKRK1AwntPTX6lqjQTOhhoChY5V3yaWIEI
 HISRlKzYWIFvWAsX8T0V5mpJIs4PGA/bW9GU8wBvfoLG8Th7Qbzj1WjVW80BjFppE3Rf
 QR6KpUM3nWzPFuqGQDBTZDhkJyckXjf/0kS/egLsHJ6e4R/bAjxFXGJcAua7LCfkDHOF
 gl3A==
X-Gm-Message-State: AOAM532H5OqUZzQC8r6uyiN9D+xP8ii4y/OS146hP4IhOAf9B5o4r254
 TqY36Sk6nIMJt81TM8QaDX9IZQ==
X-Google-Smtp-Source: ABdhPJxJNsZyRTQoSSE8xzFMhmMqyaGCjtUm+g5Pe1RweDQJ72hyJbK9fiRqxUNJWeHyXp6SzMJfjA==
X-Received: by 2002:a17:902:7c01:: with SMTP id
 x1mr2357600pll.197.1598982688262; 
 Tue, 01 Sep 2020 10:51:28 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x4sm2740641pfm.86.2020.09.01.10.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:51:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] hw/sd/sdhci: Fix qemu_log_mask() format string
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200901140411.112150-1-f4bug@amsat.org>
 <20200901140411.112150-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7f33d2fc-3b14-290e-c51b-1ac8faa0ada5@linaro.org>
Date: Tue, 1 Sep 2020 10:51:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901140411.112150-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, bugs-syssec@rub.de,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 7:04 AM, Philippe Mathieu-Daudé wrote:
> Add missing newline character in qemu_log_mask() format.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



