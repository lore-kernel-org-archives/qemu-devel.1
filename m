Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FE6ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248D12064B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeITxR16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248D12064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7G2-0000PE-MP
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL6au-0005SI-R5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL6at-0003ns-SJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:17:36 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL6at-0003nI-NR
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:17:35 -0400
Received: by mail-pf1-x443.google.com with SMTP id v4so1754260pff.6
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9yQ/BR5AE5KRDQdD7zvq4OVNk5mn+Sha2hM/Ld11IEQ=;
 b=jeITxR165kEiv1EC13+7t2DXybNHzq/I18N2PH3vo18ewiNr0tI4+tKOqHa0/0K2n/
 WtvLCHAb1ZjwwgdtQKH1F5FUWq2xplUQqW9/E8BRK7BxwacBb72Pps83rpbpM0jfHJlE
 B9koNwI/s/cvqi/+1JqTMw75P+B6HaH7EflXybkVvPDHiS6ezmL6s4NE+yQCdntJZ/j4
 hAKQpC8kCNq7p2PHtSiG97DQacbAOFy+55+ZUWugOJGYrctqmGU5x4+9V4p5USgHrzFw
 VdUYGerPpjlVqhJl59XXkKjZ4q/vbKRlQ3SCra18UpVTw8XjWKgSGhZ9n5DJU6WvLrwu
 kVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9yQ/BR5AE5KRDQdD7zvq4OVNk5mn+Sha2hM/Ld11IEQ=;
 b=iNf+bZzQ+gkqXUbSuMuvO80GEGm2jNdu3qDENpOXS5f0Rw7vhSteNnlTwo5VlI/o5x
 /Ir6+Ti2qDnLv3wTG8PYXEZVEcjrBsQyelAtC1NpNvkWk76hdDwXPH90KAAyclPze4EC
 q80PqQMp45OJbmzHLoPRIBYAJ/j1iCan9o3lUE5ogqvKLosMhV8f7k+5LJh0ZA6kp8X9
 Ju76Iph5TXRPVNeafONk6kuV7G2soVYKAG5CK9spSN9G1ogpYOWAw5p+bnPapvluxLjw
 BX2IL4te3yxxy9LbEnVDRnLQHECbRGixZjubrraosb7HCdBX7dqcjxQJerk1NEq/8cAI
 5W9A==
X-Gm-Message-State: APjAAAXUu8TjxHtBWHn2LqHigOxQB8XGAZlXY5eIXY5i4Lj7GxdYBQR4
 Aojzh0DWlktT8H61dylzVfyGrHYF7/8=
X-Google-Smtp-Source: APXvYqzEg4hh+ApAlihEe3aBE+4ocmiEWuV0PfNvSO+QKvBBUu86j1o5Aa9MKxRYK2ODQBhUXNPP1A==
X-Received: by 2002:a17:90a:bf09:: with SMTP id c9mr4765148pjs.9.1571321854439; 
 Thu, 17 Oct 2019 07:17:34 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s191sm2543454pgc.94.2019.10.17.07.17.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 07:17:33 -0700 (PDT)
Subject: Re: [PATCH] hw/timer/arm_mptimer.c: Undo accidental rename of
 arm_mptimer_init()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191017133331.5901-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6491b350-7fa3-4877-c8e3-d0e633d1bf2f@linaro.org>
Date: Thu, 17 Oct 2019 07:17:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017133331.5901-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

On 10/17/19 6:33 AM, Peter Maydell wrote:
> In commit b01422622b we did an automated rename of the ptimer_init()
> function to ptimer_init_with_bh().  Unfortunately this caught the
> unrelated arm_mptimer_init() function.  Undo that accidental
> renaming.
> 
> Fixes: b01422622b7c7293196fdaf1dbb4f495af44ecf9
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/arm_mptimer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

