Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC11C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A97D2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwmCj1ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A97D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCxT-0003Q6-PJ
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCv5-0000Bx-Dm
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:12:51 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCv4-0005aF-68
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:12:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id f15so4265445plr.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NT/aLfLoOCRtNpgIvsIkYEBo0ow9a07lcEgBz0zY5b0=;
 b=iwmCj1eaHbxF8e9OtYVD8BA1PO8Geh1znvWMStS810lztexYhLyuOgyB4CGTqe98TC
 5L/OZLdyd8oDs/5TFj7oyJ3BWBlY/3nmS7uQqqTpXX5r0d9+PwzLbLkCGjw86EaJ+URq
 nebNF/8+P+v9hRnf1vlX/A/kkdqDvD4bKSOD6O82Kz7qyMFJ/PsJPNe7Ea9vmdf5MuDY
 eHPS3y+mimr2klcEIHSIyuWwaBY1Vu33RmSqQas4aveKlAFd/6GUztFoexx9ygrNhfYV
 DC9LrMss6QIKG7XCxSR1vU8u/5cdpe3clFub5OzHEQnbakK1/mU8T9vzNtOaBOOziGMq
 ZTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NT/aLfLoOCRtNpgIvsIkYEBo0ow9a07lcEgBz0zY5b0=;
 b=mTgtKejnXB5HX2CUAcTOIlCsRVostvCGC/Ao8TOMeZeEUqetFMf8wMFk2z+J+8iCYR
 8V/N1Rdtytiw9Budecqvq4srQZqOZUSK1N5JcFJBqURi4yNNPHj/cN9XTjNStx+JehKc
 AUZX7WqTr1HfpoAe0OUC+YGlV6o+1a7Bt59dba9yx9bTKgiTiCBnhNaUajScGLZW8QL2
 QoeXmtRQd1LfCn03ZCGcpL0N7VsR80sPRPKs+JNrsjZUcMdIUn52fT3rRLWVejvRjuTA
 lPraHQ0WUxrfW2HQ7wDr7xGGL9PDMKqyHHRpbYwL+PcvJl486tIJxVQFe9TOn1lLk+AH
 mvQw==
X-Gm-Message-State: AGi0PuZOdZ02FxG3AoSU2cOZ3gwA/1Wbn74IE8Sow6g8C7LZBs3OH7Ik
 dF5nRVTYKrDvzavsz+ZqkWhflQ==
X-Google-Smtp-Source: APiQypIeVjrGkYJx0mwwTzQdj+USyBwf8NVNG+52hgNFf/PG+M24HuRfi9is8g1rICT7v28kUKCW1Q==
X-Received: by 2002:a17:90a:930c:: with SMTP id
 p12mr26400277pjo.64.1589220768511; 
 Mon, 11 May 2020 11:12:48 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm11020705pjf.0.2020.05.11.11.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 11:12:47 -0700 (PDT)
Subject: Re: [RFC PATCH 7/8] riscv: Add RV64M instructions description
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-8-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9038b89-5f9f-d4c9-66d8-4333382b7b2a@linaro.org>
Date: Mon, 11 May 2020 11:12:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430072139.4602-8-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:21 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  riscv64.risu | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/riscv64.risu b/riscv64.risu
> index 98141ab..f006dc8 100644
> --- a/riscv64.risu
> +++ b/riscv64.risu
> @@ -139,3 +139,46 @@ SRLW RISCV 0000000 rs2:5 rs1:5 101 rd:5 0011011 \
>  
>  SRAW RISCV 0100000 rs2:5 rs1:5 101 rd:5 0011011 \
>  !constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
> +
> +@RV64M
> +
> +MUL RISCV 0000001 rs2:5 rs1:5 000 rd:5 0110011 \
> +!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 && $rs2 != 2 }
> +

Modulo the use of a helper function,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

