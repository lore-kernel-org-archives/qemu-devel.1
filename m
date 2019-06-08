Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A09C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 14:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92F3206C3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 14:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guztzd+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92F3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58650 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZbzU-0004cV-4L
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 10:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZbye-0003MT-KV
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 10:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZbyd-0002Vt-Lh
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 10:05:48 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZbyc-0002Li-Dg
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 10:05:47 -0400
Received: by mail-ot1-x342.google.com with SMTP id i8so4454828oth.10
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+gNt5nsd+prMl1XgTZvIDAQT308e1Ir0MqfROFSwDQA=;
 b=guztzd+Pm/SzXrcJnJC9u1rx3gyflutdtpPi/4n7Wp3IQdGG2VBbDbvGq0t5LmBYf8
 ZUUEcobWZlnLV8hxU0FXXaM7dJXkJ0EcovWWBYX2xSBUPslfeEh/lbasiWyCGYAi0bwP
 PBSjBZa/eLkDzlqPUg3Pw7QklU46bzPeQ1h5PR/Y/VDQ2enpwjzcy0pceBbj+zQAI+j9
 5s+Xn2LZ4Zbewq8evJx49XMzG2pE9i2HjKLFH9cM8qtJ8YoIYMzgrQCxI1yzUOMVd8nV
 2QhXgWS3rndhQeYrqOayyBNZ7HDwzzD+Quxj3S2aFTZszK+0GfRgRW/Lmro3+8ZFDyUn
 QP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+gNt5nsd+prMl1XgTZvIDAQT308e1Ir0MqfROFSwDQA=;
 b=OfukLWPsUgqLPa8t6r1WZtnRdj/ASsY1aOGoYNHKp6dhHThdl/4nJYQ0TvGqFZHA9t
 5Fe7SyvlIvLmH9bFRkd2YbmcYDuHR44kxVFLd7BxgM7k5o260iCY0xGtuj6mc9Wfq6z7
 NbZCV9ftRF3boxQRBwSAQSJwlAyR3Dsqe3lWix8IbnKPpUSZZMWYECVCyEjsHmBSHH0P
 NwL5tyYH9l1IeTH6NY/TpKE+nR4hLrKqSOTgWHmX1zIo7yRG2eJgw4QYyWE+l4Q59dnU
 /uifckl50Nz0Ol3EShdMY/4NntQe0xaQ7HljfWiyop5+jB/i+szwRZFFWiuDSDoZIqV8
 IYpQ==
X-Gm-Message-State: APjAAAU7KLwozyqpNjnBtikaCA+ITe7loNz1MXhh+7sLDFsobXZIv3ZN
 okkXt6EKf/3fwsFmzPnLivPjEWiiS0TQKg==
X-Google-Smtp-Source: APXvYqyvU6VDIOmUthWaNrgB9dL1VwetBhOWBhleU2jfQ2/5ToOyUtz7NbWgnJUpXyyV3hh84hBx3g==
X-Received: by 2002:a9d:5907:: with SMTP id t7mr7740661oth.163.1560002737454; 
 Sat, 08 Jun 2019 07:05:37 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id n95sm1344410otn.65.2019.06.08.07.05.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 07:05:36 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2bd7f1c1-eb97-2cfb-fc6b-29ff52e189a0@linaro.org>
Date: Sat, 8 Jun 2019 09:05:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 17/42] target/arm: Remove
 VLDR/VSTR/VLDM/VSTM use of cpu_F0s and cpu_F0d
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

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Expand out the sequences in the new decoder VLDR/VSTR/VLDM/VSTM trans
> functions which perform the memory accesses by going via the TCG
> globals cpu_F0s and cpu_F0d, to use local TCG temps instead.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 46 +++++++++++++++++++++-------------
>  target/arm/translate.c         | 18 -------------
>  2 files changed, 28 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


