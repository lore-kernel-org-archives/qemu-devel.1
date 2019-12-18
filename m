Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5645C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7912120715
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxB7crqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7912120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihQTj-0005rt-Hr
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihQT1-0005I1-LY
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihQT0-0004lv-Gu
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:57:43 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihQT0-0004kZ-AV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:57:42 -0500
Received: by mail-pj1-x1043.google.com with SMTP id s7so238801pjc.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 19:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=a9L2IvHq3lvHENt4BJuUXxmzubNR9R5kCR+Q0ZyNE0E=;
 b=OxB7crqDw7G7jgcja/rWjajqtEfYWMDYoCB/nRXWwLOk1i1ch3fpfEHgbhoZepXFWY
 hLIR85QCq4OKW2hu/pGXB/7K43lwA9bJ1SdK4tLZ1MM8/ek/htsltUgkHouRwPMCRGDF
 EMiJlRFVUXkfsX+jd9IKipqarMjWRUbFgCHmcq70ORz9sbQjOeosQNQsUHZCAiieXMQ5
 XKbhdxcEqIbdyrrD6NuHh5TGblE5d9ab5MzYBwr3wWC70Kmlu2f/mpFYl6vDX8DosHjz
 COEKaBJp93Rybv40XaZnX5ZPZtgLn+PMYdZG5zTtpn6Kf4h/1Ciq03dNGsWWO9FnZpnl
 J3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a9L2IvHq3lvHENt4BJuUXxmzubNR9R5kCR+Q0ZyNE0E=;
 b=J2XJ/93kqEleWn1/vS3eynGaiHGALwkfJ+nJVTdbgS2Xe6Rm3/WpFTthr3rexL/EAv
 YEl4oxlQvHSJy3xcUPGjge2iAlxmNUR91S5vC3PYPeJrtXeMC+BMivbGYXMqE16RaKFm
 qGu3ohMqaZigGTqNr40ktk7fq8TVfkp+QboZk8tQfN0at8TIyc01Wx9gM4A5eC0trjNk
 QyE81d3xA++hyBkvjaoFaV7zEIFk/y2KaYYvfzruGH81C0yuOsl7ftG5gN/nc59TwA02
 vwY++4EFjeC+7ojaEcye8WykTX2mdKJ5tMRBDe7vmva/BR8f8k2/XQxDUjgqDHXzjnx0
 AhoA==
X-Gm-Message-State: APjAAAVJ3GnpYO/9x91QxvKMLOsCr/wZSAAss2rfWEJZpbgowaKGyPP1
 FFCeY5b8Fbu9Qi9tnk4m/haEoA==
X-Google-Smtp-Source: APXvYqxY5FnOrHByhsz6NB3Byi1IJ4oVWVYb2yVR2aEYE2LfQmvwi/TEnr4LjIBdvwbqc/2xBWIXvQ==
X-Received: by 2002:a17:902:7484:: with SMTP id
 h4mr299494pll.206.1576641461001; 
 Tue, 17 Dec 2019 19:57:41 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id l8sm484706pjy.24.2019.12.17.19.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 19:57:40 -0800 (PST)
Subject: Re: [PATCH 2/6] hw/display/tcx: Add missing fall through comments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-3-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <be844995-0bdd-9273-75e9-47f20b25c6ec@linaro.org>
Date: Tue, 17 Dec 2019 17:57:36 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217173425.5082-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Olivier Danet <odanet@caramail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 7:34 AM, Philippe Mathieu-Daudé wrote:
> GCC9 is confused by this comment when building with
> CFLAG -Wimplicit-fallthrough=2:
> 
>   hw/display/tcx.c: In function ‘tcx_dac_writel’:
>   hw/display/tcx.c:453:26: error: this statement may fall through [-Werror=implicit-fallthrough=]
>     453 |             s->dac_index = (s->dac_index + 1) & 0xff; /* Index autoincrement */
>         |             ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/display/tcx.c:454:9: note: here
>     454 |         default:
>         |         ^~~~~~~
>   hw/display/tcx.c: In function ‘tcx_dac_readl’:
>   hw/display/tcx.c:412:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
>     412 |         s->dac_index = (s->dac_index + 1) & 0xff; /* Index autoincrement */
>         |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/display/tcx.c:413:5: note: here
>     413 |     default:
>         |     ^~~~~~~
>   cc1: all warnings being treated as errors
> 
> Add the missing fall through comments.
> 
> Fixes: 55d7bfe22
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Olivier Danet <odanet@caramail.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/display/tcx.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

