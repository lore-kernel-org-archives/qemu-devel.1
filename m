Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6B520773
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouH4U7bR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6B520773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqaf-0000qx-Mx
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsqZX-0007jC-Ru
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:35:55 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsqZV-0004A9-5I
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:35:55 -0400
Received: by mail-pf1-x441.google.com with SMTP id x72so9221264pfc.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1Re9LrorOXJPnhE/oGULN87WO94EEprh+xl+5te3Kvo=;
 b=ouH4U7bR9FHsgvGZbBDWNV/bj9BZcLYqwnY5pwrkZMtpCWtrDcgBQs51kN9Fd7VB85
 SRCWCEihwPF77Nf8QYmJNdOovWntOwECBh2UGD+ZJGHXBkfcNJTjBXZVZrOu5txK7lS8
 4t52GvV/Ym0WgKl5hfsdfG/ElXVVG1sar0YHrTsF5nNWrKHwflvnC12CgwdsIvRiG/MD
 FfLKoaUi6QtMAXzH0/D0e3otLUHpdiNqXVKD+ISHqUBdK1Kq/x+udrgGplMClo4KQtK1
 bY4e/5wAKcPgvC1GiQU1wnAzNTOviv2i4jlrhP5PJseMirImRJfBgMU1jeLiwYbkpKTc
 Izsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Re9LrorOXJPnhE/oGULN87WO94EEprh+xl+5te3Kvo=;
 b=ZsuukI80THqk1Oa3LquGYfMOOIMjU4CPla9z/mMMxwRnG/ozu5SfuqKTbmcmsCJ5ZY
 67y6HjlY+sBqezhC4xaXKQSON1ntNy2tclU4L9+FYKWnmegGb4PPuxN9BijVJJSF806u
 HuAgCD4V+jxCDb2bzil2JCpwJIZ5SeICrwhXGaWLq6sDF/JK2foTwmtGTwi1ZjhtGvYb
 3/km4GARMe8x5WSockqVPKPH3Oj06UpD8zX69uJRkhytAxHYGVFAaOStfZ9PmFj1KW1o
 xJc2wihv7ItQ2/DgPhebvMFy9Ht+Ulzuz4LR3uTGNwlYOybr3lgtsPrgxfX39bXSJFVB
 SO4g==
X-Gm-Message-State: AOAM530ElD/cV9bUS/0qKQ2HRkjj1c7b62FCiUzzAH+XiP+0jWikaRE0
 HmxLkoUxb3YvludPB3PSjqEMIA==
X-Google-Smtp-Source: ABdhPJw4tc4DNzOLsUdw1ZckIbxeRNVq7AedYX6DGo4TVOhQsy3+fCB9Thgdke9ivT1Y7rkXFNs2Ag==
X-Received: by 2002:a65:52c2:: with SMTP id z2mr46999168pgp.419.1594139751763; 
 Tue, 07 Jul 2020 09:35:51 -0700 (PDT)
Received: from [192.168.149.206] (097-090-106-114.biz.spectrum.com.
 [97.90.106.114])
 by smtp.gmail.com with ESMTPSA id m17sm22160584pfo.182.2020.07.07.09.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 09:35:51 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] target/avr/disas: Fix store instructions display
 order
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200707070021.10031-1-f4bug@amsat.org>
 <20200707070021.10031-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5925dc7a-38dc-4e3f-a43e-70dfaf873c13@linaro.org>
Date: Tue, 7 Jul 2020 09:35:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707070021.10031-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, Michael Rolnik <mrolnik@gmail.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 12:00 AM, Philippe Mathieu-Daudé wrote:
> While LOAD instructions use the target register as first
> argument, STORE instructions use it as second argument:
> 
>   LD Rd, X        // Rd <- (X)
> 
>   ST Y, Rd        // (Y) <- Rr
> 
> Reported-by: Joaquin de Andres <me@xcancerberox.com.ar>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/avr/disas.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


