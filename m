Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3ABC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B40920781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtnNpA9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B40920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5unP-00044K-Gk
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5umb-0002UL-Eb
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:43:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:39663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5umZ-00045N-QJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:43:25 -0400
Received: by mail-pf1-x42f.google.com with SMTP id u128so1380739pfb.6
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+wNpViLAkYMf98naGe+1Mxwmrcii0DHNfNpoFkrd0E0=;
 b=QtnNpA9hOloAIYKwB2biZyuoBYiGvp2AIdfnTob/rP9+dmzEqNCAlLhAsMUeHBFPLv
 B6YBjIaI4C5up7FvYmnxzxQ3r9IjpkYVwVJ+66hF8RW33eJ1E4Dgu54Ej4FjAnZYa64B
 hX69cAJJGGxGP8IcJVoUUptgNwblrUXHq51giHvpKgUVtLiCNZ1rYxw8RiDXAMF5ET5+
 mWcW7XN4Fp3WcxJ8ivXugJhu7liPB1h8AbsRU92CP3h3HyYdVRJ533cvDK0ufBDAONS6
 4q0oU+9a1VyXVSKlM1DzoFmBOJ7UCT3wMCZ9/2ZdR272/X71xJ9KGr23glrHcqmlm88I
 fZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+wNpViLAkYMf98naGe+1Mxwmrcii0DHNfNpoFkrd0E0=;
 b=N79C28NjJInrGVsV/jnakyhPLOfGKmf/d90DydtVf2N0GflF8coZsQ2yLqgDs9xG0M
 FVV6VAvWhI0P9oYy6uKClWFbacUH0fEO54CJKUZmf6i6reDDi6ihhb1cu23L9jDzBwsX
 OqRsjxMTVnL1DyYUGEjnKYmKLhaaGkm+sVG7CAW/1L+h1GlJnEq9AAJ+0DjD81tP8lZP
 bwB6tqHgY2LFyGD12qk3VgkjqWOKIlJvnN6BKYATHme/p6LukfmVi0WnYsVsoKyYjlrf
 PIzAb0o5mTL0ecWGpGiboW5Z61PAZsntIBX8z5PjijIz59/6phLNJD3VIy+4khA0PjWQ
 JaYA==
X-Gm-Message-State: AOAM532rKwqBmNV7CXh3Vx1HYmiVa0t6ach7T8x8G32WTce0uEad+wpv
 fwVhx0KAuuMB7xGMSennKLH8bQ==
X-Google-Smtp-Source: ABdhPJwgwWcZLN8v/M2uIMeCccg4qkHwUEdmiAqA1zKPGIvQWTQspt+nz430X30DwsyzZfyKqY5+Yg==
X-Received: by 2002:a62:aa07:: with SMTP id e7mr581085pff.71.1597254202313;
 Wed, 12 Aug 2020 10:43:22 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id cc23sm2654359pjb.48.2020.08.12.10.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 10:43:21 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 3/4] hw/char/serial: Let SerialState have an 'id'
 field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200806130340.17316-1-f4bug@amsat.org>
 <20200806130340.17316-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0dd337be-267d-e9db-0ec9-dd62d7fb4cce@linaro.org>
Date: Wed, 12 Aug 2020 10:43:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806130340.17316-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 6:03 AM, Philippe Mathieu-Daudé wrote:
> When a SoC has multiple UARTs (some configured differently),
> it is hard to associate events to their UART.
> 
> To be able to distinct trace events between various instances,
> add an 'id' field. Update the trace format accordingly.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/char/serial.h | 1 +
>  hw/char/serial.c         | 7 ++++---
>  hw/char/trace-events     | 6 +++---
>  3 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

