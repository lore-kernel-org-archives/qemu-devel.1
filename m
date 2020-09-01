Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B30C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C20206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doomOpgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C20206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDAS3-00055e-V0
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAQE-00035i-IJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:50:18 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAQB-0002Z6-Si
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:50:18 -0400
Received: by mail-pf1-x443.google.com with SMTP id o68so1238026pfg.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iJn/yZuTvtlfrDCaKJZyfnG198ldJ/I47rjZTHt+fLQ=;
 b=doomOpgBlUtVvUPch5YdQwj7eI+cc7KRwbQd8lIlMTi9wVgMQktCI7yzmgUdUDI9nv
 E1lJi1Icm3aFRw4/ULEGn+yeu2I0K+H9DId7CFNWvvqNniZNY1BlacoN0BHW+2Mk6NOP
 anndXakvcQpru1oZSd7XZkUATGpknbZq0tTPp4wkfg1WP2AZ+XXpKhv2W7MD8drcNs5n
 6ItPRTWNAJQLO8gqrD48fjSCnDAjbtwAkDtkmybbR2/Pc5Olz4mZMki2xlbiHqcB3csF
 /B5DjTBJV3FwfHfCaXk7rq4AxHdYJXJzkQDJBimrO9dizZKR7WvYKtOkfXE8gSmbZEtV
 bf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iJn/yZuTvtlfrDCaKJZyfnG198ldJ/I47rjZTHt+fLQ=;
 b=mEmEoLS66LiNyu3ACRadteD8aM0EiQPAYPVij2l+o83lWhvLItafG9ymiOwvXS8GJW
 87AaOJpvG7B3R1BVfBaF85/fkSUz9L4mgEsgJZEOqK+4U1OueLMg2p+qvfSNSJ4db9WJ
 gJSp/UDuGoErNlbgQgzpxU3u3pbMFLqqDI/Dlcnc+5m7l31lRX/yCsGW+/LYJfdiHinY
 pFGIVBI0eChtI+PkijLpwAgHNEvsWt3CaHI4vVk1yZfdpYT0VOytNB1yu0LDtjKrQaRb
 z5hBUumhwXQHFYf20Ij7ZGt7pLmU/i5MiMs7xfwNam7QCxJIsfWGhqG49BWFFRUeGMEb
 yX7A==
X-Gm-Message-State: AOAM533ryUgT+TNYJbLlDLCb3onlbdODgH4oDiGEJwdBru1nbE2VzHDI
 3WWjeav/ToXG7sZXHiZFYsEjQg==
X-Google-Smtp-Source: ABdhPJyfHA3/ZqfRw7jLAoaTWfPc+XAh7pgja2Drsuz4aljc2DWg+HyYvvAilCJtGNF01wtp7ERA7g==
X-Received: by 2002:a63:4405:: with SMTP id r5mr2470508pga.382.1598982614591; 
 Tue, 01 Sep 2020 10:50:14 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n2sm2656496pfe.208.2020.09.01.10.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:50:13 -0700 (PDT)
Subject: Re: [PATCH 3/5] hw/ppc/ppc4xx_pci: Use ARRAY_SIZE() instead of magic
 value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200901104043.91383-1-f4bug@amsat.org>
 <20200901104043.91383-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <69fde22f-6a2e-dfe7-20de-3ad7c5ef36a3@linaro.org>
Date: Tue, 1 Sep 2020 10:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901104043.91383-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:40 AM, Philippe Mathieu-Daudé wrote:
> Replace the magic '4' by ARRAY_SIZE(s->irq) which is more explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/ppc/ppc4xx_pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



