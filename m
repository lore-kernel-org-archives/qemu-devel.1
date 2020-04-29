Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467CFC83009
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182B220661
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZh+mZ+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182B220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrn5-00030E-6g
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTreC-0007cY-LY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTre0-0007yC-Bv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:41:28 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTrdz-0007xs-UX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:41:15 -0400
Received: by mail-pg1-x543.google.com with SMTP id s18so1412176pgl.12
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=xy56eoJUJWZN+BstVmu/0c9syXwVAf+2TuYgeFfXSx4=;
 b=yZh+mZ+P7Z6Gg7XAdJH1WpYreRP/Y8/UyGYuHA03soLYtXzH9h/hMrFmnuFeiYFBrj
 3sbDk5SPWnsjg81ikpZBLGeh7Pc9JRfBtoJX66U7bpfpy2D9Piw6T56FCuJ1jA3jocm9
 UQMW/QWyzCbqbTn/dQ2MF9epPf7Kct6GhFklmVKzl3av5ZPDbkPXDh8thdmi6kK0Fw7f
 kJO7BIDFRI5p5eggf3k47WNLNh8oIUa33V4ePSoMNVmoqwqciVKU4YYTMd2FM3Vzrf4s
 lTnJCPNNx8Mo+uhlhZ1tTGibNEO7lOg4WViJUwPQPuhiKrKmy7ERmijSjOWuA2Ecicze
 8TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xy56eoJUJWZN+BstVmu/0c9syXwVAf+2TuYgeFfXSx4=;
 b=FhlKdWJqGRK6086m3YA3MFsR4athUCbKiOxDKZqTZgU7TW0BS3gPIu48NRnLbVOZO3
 roHNCqNuajSA9xGE2b7sYDXqWwGW8FkeJQ6KdixFN1iirkt/tgtRhV5CIzIX729tGiam
 mJYK1sz/IogAPiyAxspJ1m/P5Wy2EUeK4WSzwko3wn0hKT+9EMQgE3HZDotp0OeyTTfa
 PLYz7EiXIJPvUx4Ic16AeFSo07JqGxYe3eoAM9Zan2wR3l1L55ZSph1j49I5vh8+cq60
 3jpBh8MCKAi30HfcxVxbMsuEVdU71kIEm+jw23DJieDYjhNR7Znnuq9oyvl0ezVsiUFT
 VGKA==
X-Gm-Message-State: AGi0Pual7cqCIlPKYdH+1S4mZXZddg4S3ZVpfzkZ+OUALVXsNc9G0J1b
 0dNNCEYOv5H0eTfRnTGoDun6jQiBLd4=
X-Google-Smtp-Source: APiQypJZ4XfC5PMfsSwK7MBR5tRADknxf8N2O3AkakcnAZlAkp3sMnWtKCypOXXgTtu6uzllI8Meow==
X-Received: by 2002:a63:ce4e:: with SMTP id r14mr14236395pgi.219.1588185674059; 
 Wed, 29 Apr 2020 11:41:14 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i15sm1550955pgj.30.2020.04.29.11.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 11:41:13 -0700 (PDT)
Subject: Re: [PATCH 3/4] target/arm: Add new 's1_is_el0' argument to
 get_phys_addr_lpae()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200330210400.11724-1-peter.maydell@linaro.org>
 <20200330210400.11724-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fd6a7e77-5eb7-2a22-ff9c-09d3d8196d80@linaro.org>
Date: Wed, 29 Apr 2020 11:41:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200330210400.11724-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/30/20 2:03 PM, Peter Maydell wrote:
> For ARMv8.2-TTS2UXN, the stage 2 page table walk wants to know
> whether the stage 1 access is for EL0 or not, because whether
> exec permission is given can depend on whether this is an EL0
> or EL1 access. Add a new argument to get_phys_addr_lpae() so
> the call sites can pass this information in.
> 
> Since get_phys_addr_lpae() doesn't already have a doc comment,
> add one so we have a place to put the documentation of the
> semantics of the new s1_is_el0 argument.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

