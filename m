Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B0FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2861E20756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UdsHU+Hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2861E20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzZQ-0008Ks-89
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzYU-0007Av-5o
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:53:10 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzYR-0005FC-So
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:53:09 -0500
Received: by mail-pf1-x441.google.com with SMTP id z3so8347683pfz.6
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B589FvnXtpMWbeAhQjtZHt3WqH6PPw9vab82qCgueJk=;
 b=UdsHU+Hc9d7g246hQ49u++95yhAb7xoQ72fGzdms5FMc/XEpi8aW2ThZ2X8uJEwdW0
 dMeV/SY+2nQd8ug+4nLt+BOm+xn8pRPQeRmEXfeTj6Q4Hgjx2H1oR4+K8RlvP/cWD6EK
 tRFKdhZP9qMuOg+N57T8o3qQ9ej/lv3X4qo2Z0TdEyZFczQAbVG+hKFdYxDfsmxPqu0k
 TIx4rY6Idxh/kOVYqx8oimg0QG5Qe8LsRnZnpp1figewWua2ZxZlivgPY8BKgRYjnVYb
 kHKccd2wgWoJ9QHfJUAXja3BTgFVwiqTje8RHLSsuCAdSB2xihM2u0yupX9E2PqEpRSY
 WU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B589FvnXtpMWbeAhQjtZHt3WqH6PPw9vab82qCgueJk=;
 b=S/tjtjkKTuuruA10mTprmLIW4vBUOkb41Fb3SBDngY6JAehdAhaciaKj4sOYJMUH+Q
 niTn4MvLJn3JZKJZNMKn5ZooTKQtPe4TGlvpV5SYr5mBQ4lj6sXBiUjzHZ4IiHDWi6FL
 nlPQoSyU+97KfoP5TUo+hxHG4++VfVpwOTecZwONj1rflS8Drcpq+ZuBhQBNxSeRpv/U
 swmfk7kUUzUp/+BtMV1hN4RzlnKRdQibNunKwBr9luPYkbqgJqz7N2bwy5z6IWslAemq
 obF7PLlO8RrNHYvgnLNlAal8x+yMiE4UdJ3+IT79ZHYBmX8XrDzZ/1MxGNQN7m8qWuyI
 10cg==
X-Gm-Message-State: AOAM532qTlInef6bwF5W/W9B2A++5QO9EHC9KjyELXIwPq6CtJ4oMv8c
 wASOV4cKMlRapnz8ctPAAgEoZQWHAjNg9Q==
X-Google-Smtp-Source: ABdhPJwAEJGoK9w9R1vhz2o2RZ1J7BH4zOhq7GecyPBB+tlYcMSOyBUsu+0ackpMXd/FAp7aVTHRJQ==
X-Received: by 2002:a17:90a:134b:: with SMTP id
 y11mr68719pjf.182.1604422386120; 
 Tue, 03 Nov 2020 08:53:06 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id 145sm1711396pga.11.2020.11.03.08.53.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 08:53:05 -0800 (PST)
Subject: Re: [PATCH 02/14] target/arm: use arm_is_el2_enabled() where
 applicable
To: remi.denis.courmont@huawei.com, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-2-remi.denis.courmont@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f7fecf2b-1aef-ae0c-66b1-2dbbd7cfde18@linaro.org>
Date: Tue, 3 Nov 2020 08:53:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102105802.39332-2-remi.denis.courmont@huawei.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> Do not assume that EL2 is available in non-secure context.
> That equivalence is broken by ARMv8.4-SEL2.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu.h        |  4 ++--
>  target/arm/helper-a64.c |  8 +-------
>  target/arm/helper.c     | 33 +++++++++++++--------------------
>  3 files changed, 16 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

