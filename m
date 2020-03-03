Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01544C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49C42072D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2GzHesZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49C42072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9CRA-0001Tn-1t
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 13:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j9CQO-0000Q1-Ji
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j9CQN-0002bE-Ji
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:37:48 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j9CQN-0002b2-EN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:37:47 -0500
Received: by mail-pg1-x544.google.com with SMTP id x7so1939246pgh.5
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=63rBGK/nMEIBUdxAll+/vgkzGgNNpLA2XYVed4iWRxM=;
 b=k2GzHesZ9swofwqeIqdsRxFDrp1tbpJR/vURrwN8gd67dFXNLBZY3elN0y/yxTImZo
 NRgBL0dXJ/MUnmPavSmuPDWefJP1bLNaoy9RJK6G9BzjvoG9P2zIURJ0GFYvgh69UKf7
 6IjroUcj6+e1Dpa7JgvQW/HT7ecOsy5qS3hGipsJwFKekwcdwNSKAMwfEM19hPnsR0HL
 UNrQu5QF7uUk6fFcrSZrpfbK6cEw2owh9wu0TcYob9NHTZkIwSwT/PS4ZicbLTtC7gWK
 aFnmJmHOZyxNPTKsXCUAqBJx55xACO5IYTzI7qmedfCICblI9sAWNTIm4eaBSWxwrijw
 Zq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=63rBGK/nMEIBUdxAll+/vgkzGgNNpLA2XYVed4iWRxM=;
 b=RkMFxAaft91VjFHMvVO//W9nQNO4ZnUMY4ik0DCIIXIugXI2XkE0rbFsKOtDVi+bzm
 q/6+v3r9J0LInxhOgvdz42WvcRLcJNZZ5Dlp2u3evn2f3YmK/gqS11atDm1BQZasgoPB
 PMxfs/SLf7NLrMQeemdgHjofuDk39a6j1OmfocxMILGxyue9PgIVgRKj/5l9ULaDQZEV
 ovuQNytUJoAQSF5DdT02Hm+gyZHMQ7vS3YiFeuox6+W4/HUh9W2hZUo1zns12VnlO0aC
 08Zj0VhwFZerTI4XuEEBYTzvpSJhObQeZvJJky5pWIPuq5gOZ8hN/1bv4HbhWht4BeO9
 x5AA==
X-Gm-Message-State: ANhLgQ3GYDMxvEfRJgwIVTLcWEXuEknBrBKU61erHbMvrSwOQLvY/Bto
 i93TzddPsMflyYp+UwDShF10Ncn0iP0=
X-Google-Smtp-Source: ADFU+vtXEjJupNL1ETtE18CDvE79GOjUFGYn4TBWgviI95uE2CQBgKfcowVeUX+Pguf6Q6yltSSkOw==
X-Received: by 2002:a63:f10c:: with SMTP id f12mr5404609pgi.386.1583260666094; 
 Tue, 03 Mar 2020 10:37:46 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 g12sm24659413pfh.170.2020.03.03.10.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 10:37:45 -0800 (PST)
Subject: Re: [PATCH 3/4] target/arm: Recalculate hflags correctly after writes
 to CONTROL
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200303174950.3298-1-peter.maydell@linaro.org>
 <20200303174950.3298-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b4d0700a-8a51-41cd-6e5a-486e30c1e5de@linaro.org>
Date: Tue, 3 Mar 2020 10:37:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303174950.3298-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

On 3/3/20 9:49 AM, Peter Maydell wrote:
> A write to the CONTROL register can change our current EL (by
> writing to the nPRIV bit). That means that we can't assume
> that s->current_el is still valid in trans_MSR_v7m() when
> we try to rebuild the hflags.
> 
> Add a new helper rebuild_hflags_m32_newel() which, like the
> existing rebuild_hflags_a32_newel(), recalculates the current
> EL from scratch, and use it in trans_MSR_v7m().
> 
> This fixes an assertion about an hflags mismatch when the
> guest changes privilege by writing to CONTROL.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h    |  1 +
>  target/arm/helper.c    | 12 ++++++++++++
>  target/arm/translate.c |  7 +++----
>  3 files changed, 16 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

