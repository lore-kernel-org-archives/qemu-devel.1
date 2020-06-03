Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683A2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323E7206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXOpSbgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323E7206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWTx-0002Ld-D6
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgWTL-0001mc-Mr
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:42:35 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgWTK-000273-6B
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:42:35 -0400
Received: by mail-pf1-x441.google.com with SMTP id b16so1940988pfi.13
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yf+FwYGZzrj2oDOkOcE87gRGAj9CGikroKUdlU8+o9Y=;
 b=DXOpSbgT3PbtgBP5CyPrRE4ciMi1M0Izm5mwPLVy6CgVdaXQPO0VDd4t02f7M9JxvZ
 TiqdcO+4H5GprbdWxpB32t6FHpE3zWf4a9JFmpkFa6eNiI3w6KE8BXEEPfH9+Ob2QVgB
 an3n1mpsOlpnmMoi/geTc+1oDHbgtCn5TjKUrgnq4FAAEF3lGWn/ELuzcGFoFlPwUk7m
 WPNYNuz94GbtY0q9IM/xbc4ZkN22r965Zll4f+e3akarfAag4LaC8rjRINfRHg9QKIwE
 p54zHKGA2avqyDP7ma9DNmwe7mwH3uB867W9+J2k+vrgQEikDtpUbDXsJfHZC1umzHai
 Y6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yf+FwYGZzrj2oDOkOcE87gRGAj9CGikroKUdlU8+o9Y=;
 b=asinLJv7vbgF/nEonxo4kPWbvAdYlm5W28zlDxhFjGAMdmNdaicm1pNT1Sw6I/nFHD
 /XuifcZFdyi/ghf3nP/zlxa7Vk/0l9A3g1PZCbNgdM4i2XF4LPv4h2Gbvnr+/ILbQpyk
 2sq8FSEwn/xHZEQVCMePF7DTv6f5a0mVi8cVhklqWAmTf+MLyI9dSYrsTsKgOutjIvQp
 w42NtqB0IC5ZcIHZ+ON/FHSCbhUPND/uqlSglr/CUa+moEw6F0fzLZb8sj8/X90PJ/pf
 mS13gQGKMigy/8elyftJ2Qd9ZBxzFN0tpW+ZOEEyv9tLfCvzptMlfYytIBryJAi39XtO
 8tqg==
X-Gm-Message-State: AOAM531hPY1EPzUjwWx6kgjvMOLyz7SQ70R0tBT0pb9oPkYE49+mMYXU
 WdKbQ9DwVJoMOROyWl6gOIO4jQ==
X-Google-Smtp-Source: ABdhPJxY6ptV0h3UnCwuQymzffpNNuBpa+0QTTa9q4XVGJNL0bohzjBRMU1x/Kaemre7sbfrKDA3lQ==
X-Received: by 2002:a17:90b:3005:: with SMTP id
 hg5mr658505pjb.215.1591202552307; 
 Wed, 03 Jun 2020 09:42:32 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p19sm2321258pff.116.2020.06.03.09.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 09:42:31 -0700 (PDT)
Subject: Re: [PATCH] hw/isa/apm: Convert debug printf()s to trace events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200524164806.12658-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dd9ddaab-7d5a-4473-7103-de7ebcd369eb@linaro.org>
Date: Wed, 3 Jun 2020 09:42:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200524164806.12658-1-f4bug@amsat.org>
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
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/20 9:48 AM, Philippe Mathieu-Daudé wrote:
> Convert APM_DPRINTF() to trace events and remove ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/isa/apm.c        | 15 +++++----------
>  hw/isa/trace-events |  4 ++++
>  2 files changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

