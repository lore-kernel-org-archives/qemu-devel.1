Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F2EC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B058521848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntvmX040"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B058521848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEpF-0008Mp-FZ
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1tm-0001nN-3D
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI18m-0008Rl-4l
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:51:49 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:36780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI18l-0008Rc-TA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:51:48 -0400
Received: by mail-yb1-xb42.google.com with SMTP id r2so216352ybg.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vx31jXZ/tj4LV0ilcA62gi46ZF9JCRg+IALX3wC4EsY=;
 b=ntvmX040gC2y8fflXBCDRhu0vZdVLN4yh3Z7WKGzlGvLijdcNzKImDH2zftXSVRG9q
 BVkNIAc+qqJEZu6yxUcjeLp90AAl7glPrUzcPBlVjEEssEG6uBQwu6S03q9MEU110/+b
 4dg/irc18ZJxEiXeBLpC3XXwJFXfb24U8XCW4sJDWfkoIFCEeFPAZ7Oy2qOTdvE3MNDx
 RPzh7lqQyDAG4gRJbDm0YaZ2/GHTacm5Z7RzrTyFhAvl6rE7szx/FB/v4iw5khZWQwO0
 n4Qo5+/cEIxPR7P3nWcZf0F41DGReGtVMEaBZ1WLg2HS3qlhHGFwHVg8avHuH7+j/ydN
 mHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vx31jXZ/tj4LV0ilcA62gi46ZF9JCRg+IALX3wC4EsY=;
 b=CbQJx19zpQlGvnoEw3FMi3FWWK/zmqLRVncF3PRv1FVxTysNHRnLYAANmFNyCq64bS
 e9Zkb+S/1JbQtBNX2g4r1lXVMHvAE8Oq99KyGPc3YMG4Xjyyi2djTXgYQbXiL3XeOiy6
 iSyzg5RVpeFpeFEi6R0MbEYc03Gjj7rrGY+E8ud/ge64OjLA7CC+rqmZNhDaYXjMyYMI
 CjfPFI8lRo3PAAJ7Qyqt5XLPpgGVr5LyIl/D2jO+NwoUzATtH0nEu/E0bGTv3B3zC2tN
 6JrVNnSbIQUuxyei/LIv7CruXYtjp6gmmrjOZ6bKUd86/1kpUGBxWkJhB72GgYozN/lU
 JiHw==
X-Gm-Message-State: APjAAAVBwKq8u/AkeU5OKkCtrJ0+uoJnYk3GRGT3vgHenkseMEZg5pNN
 zoN9KU6ROBhcDtrKhPDu6dj2hQ==
X-Google-Smtp-Source: APXvYqwpP1WZqyw9kTdi+QO0zY7cwW65JkUV8YbW5eHpjrxFpISOj6it6v2pRM1/oGhZkGwdBmPrGg==
X-Received: by 2002:a5b:582:: with SMTP id l2mr512454ybp.72.1570585907100;
 Tue, 08 Oct 2019 18:51:47 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id l40sm213827ywk.79.2019.10.08.18.51.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:51:46 -0700 (PDT)
Subject: Re: [PATCH v2 08/21] hw/timer/cmsdk-apb-dualtimer.c: Switch to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9505434b-99f4-9b9f-d0c4-20fcb0255b02@linaro.org>
Date: Tue, 8 Oct 2019 21:51:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:17 PM, Peter Maydell wrote:
> Switch the cmsdk-apb-dualtimer code away from bottom-half based
> ptimers to the new transaction-based ptimer API.  This just requires
> adding begin/commit calls around the various places that modify the
> ptimer state, and using the new ptimer_init() function to create the
> timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/cmsdk-apb-dualtimer.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

