Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601EFC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5D520838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N60lTsGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5D520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02Xs-0008QD-Bd
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j02X2-0007qB-Q0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j02X0-00045v-JF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:14:48 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j02X0-0003yp-C2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:14:46 -0500
Received: by mail-wr1-x442.google.com with SMTP id w15so2433726wru.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 04:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=APm48nMhAJgM8zcNPhtqFc9m7bcvmldxhTeWjUTfYsM=;
 b=N60lTsGEHHHD1JsCxLhBwx6Ew0A+L5c51VQxxgbfFhrxSvno6bQFdwxMyIMSINUIa4
 7bCdoO4kDBFDufA0avRXaubQywc4Zg9OoxROwRooxHxxWnIqoeiFa7J3A1R9MmE865SA
 vUBIC1clz89ChxpVUiZr36F0bcK9hqYSfjnVIffuEqMr7DhsayW1KjCg/96WjAEq33V1
 dO+NF9+/hJeZR9645Fm6s2xpxxkh8ef4Lzw/1ivXxbOBYn0T1IZHo8Ag0ON0RxIDj6OA
 S8LmS/edom/e8htCkBBW+oM3Tk01UvmhboVmfvHo9GQtKS7Yimqdr01hZBK6vANZwhZe
 eg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=APm48nMhAJgM8zcNPhtqFc9m7bcvmldxhTeWjUTfYsM=;
 b=bNzIUQXSq7kEMY/x7NQ/EqmszvLdm7IJxjNgXFWeMcYAf3z1mU/apAPBKcOBcS7CI8
 sprtlBGSvxDNLFQl8zLQFOb1kXjsqMXnooeUy/X4whxQXwNVrJ4oZ6ratt1WyxN3wZ30
 4m8wYpdVAIFhvzHS7TVzhEUcZbpTq6ZvxsoIkIyIQcRbIisMpV3jH5rNf05B45xotq5V
 H8dKQukd87x+NHcKV8+Aj5k8lRQ+uwS516pK2Iok0d/erOVg5A2yzVgNNZDvxKL3FMiM
 YxyFkz7EXIS4IahK+tsLY5WNCddgg/eeShBJ5RAFIUG3zLvYCW/AURKLTRvlQwzww2Ka
 xeaA==
X-Gm-Message-State: APjAAAXxbPuc62PAbaD/wukAkkDFe37eudXnec6DmBmPLW3YjzvTQy8J
 pGc3lq8Jk7/7wh63j0hyVPXLyg==
X-Google-Smtp-Source: APXvYqwc2dNNNnc2MjU62c4p+oqwCYYxMBrIr0qbX0izmO3yQ1YHqrDdzhRKx20p13+wNSoF3CGOOA==
X-Received: by 2002:adf:f707:: with SMTP id r7mr4355556wrp.194.1581077682530; 
 Fri, 07 Feb 2020 04:14:42 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id s19sm3147586wmj.33.2020.02.07.04.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 04:14:42 -0800 (PST)
Subject: Re: [PATCH] Add support for a helper with 7 arguments
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b308434a-1ee8-4fb5-0e60-4dfdd047c959@linaro.org>
Date: Fri, 7 Feb 2020 12:14:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 10:41 PM, Taylor Simpson wrote:
> Currently, helpers can only take up to 6 arguments.  This patch adds the
> capability for up to 7 arguments.  I have tested it with the Hexagon port
> that I am preparing for submission.
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  include/exec/helper-gen.h   | 13 +++++++++++++
>  include/exec/helper-head.h  |  2 ++
>  include/exec/helper-proto.h |  6 ++++++
>  include/exec/helper-tcg.h   |  7 +++++++
>  4 files changed, 28 insertions(+)

Applied to tcg-next, since this is correct, and it does work.

But I encourage you to re-think your purely mechanical approach to the hexagon
port.  It seems to me that you should be doing much more during the translation
phase so that you can minimize the number of helpers that you require.


r~

