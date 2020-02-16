Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DB4C7114E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 02:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2F62073A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 02:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ef0q0ZHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2F62073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j39TM-0006jX-RN
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 21:15:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j39SV-0005Td-Kp
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j39SU-0007Uh-OA
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:14:59 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j39SU-0007Te-IV
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:14:58 -0500
Received: by mail-pg1-x543.google.com with SMTP id j4so7187971pgi.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 18:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uLRXzJ3wVwvLGfLwYoC7inD/Pvgfhi6RKZr9wxM26bY=;
 b=Ef0q0ZHruOMwqGIaQ8KQ4BkjspcRX/mJW4qY2cLFwSnQaqtlMfwjCCvQscNuMcaj63
 YZPrTFb73pfI2MTcvylo0efT0KLl/OQcrUpiUz43AVvLR3cw5RK3ZJbDr4bNV/SK5ATy
 yfLH8jBbpQAImCg66ppoN1PVnVRWoQibiE1j/nfUFupCIUW3RwNjA2/KjAwhQR057/RP
 pBb+zObIWvBv3g0HRga2q88MK7VLvjOvIOM7BLqwaXTn/nIceOodn/nGFeV5WsYPSovH
 OtqKTdx5Wn++iQp3UhlG2rz0fzLVTHejkOXRP1P/jcMrqb+wEdIMQznlYhaI3NlA3fx6
 UnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uLRXzJ3wVwvLGfLwYoC7inD/Pvgfhi6RKZr9wxM26bY=;
 b=LaQOXP9QgYG1S9pgGU9KVFrIxsdkyqDIRX/nzrkV9ity4SVQTgudMHrgdeMJl/dYvK
 LHYbWbUWitVPWTuZXbRL48SjNcyEi5qXVaVb7PqtBy+vlCpqtra4IUR38VAiggj7oS3y
 tIbabRrZOyZ5kfte/0wECcE3NWtHyxPrZG2Jyj6uyZ4fAezjrF8kv4/y7hqVE0PTjKty
 7Gp3R+6VlDdGuMSfGPu0fUx95mQiQsHkpqvWznVPreVBQrXojEyZSHvA88CzG3zvaCJz
 oh5HokAbyWiZtLSsVmnEbQWJudFZSC0JIPIaEOCji07xOPEH3odiqL9GMBwD8OXf/PpG
 IzlA==
X-Gm-Message-State: APjAAAUJ0xl63U4EIHTKDQFimfiR/XKZB6jyDKWaLO1L70scEv1MjXpI
 X4+RMTgWvkdorYU9fbujmNFsGw==
X-Google-Smtp-Source: APXvYqyUVS5fEYZf8PZHZSs4gBnma3HpNVe+05kjRXBT4Jo/7h+JkgS6MCs20+exUvEBxYM0HsYpHw==
X-Received: by 2002:aa7:9562:: with SMTP id x2mr10486801pfq.147.1581819297509; 
 Sat, 15 Feb 2020 18:14:57 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 t11sm11529050pjo.21.2020.02.15.18.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 18:14:56 -0800 (PST)
Subject: Re: [PATCH] configure: Avoid compiling system tools on user build by
 default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200215162337.5809-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6038466c-6a78-1d8a-db01-7082ad86d7aa@linaro.org>
Date: Sat, 15 Feb 2020 18:14:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200215162337.5809-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/15/20 8:23 AM, Philippe Mathieu-Daudé wrote:
> User-mode does not need the sytem tools. Do not build them by
> default if user specified --disable-system.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  configure | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

