Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5BBC73C6D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 06:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F282064A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 06:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVVMsmhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F282064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl6Jt-0004CM-I1
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 02:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47762)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hl6JB-0003fc-O1
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hl6J9-0007vy-Rh
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:42:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hl6J7-0007pp-W4
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:42:27 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so1032844otq.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 23:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pTCwkQwfTaoa4SWphSJQOAblwJpi5VF7yxRVP6i7yqU=;
 b=qVVMsmhHn/vWGhwsPKGNhUiWog8UvRBjF9Qm2eO450CLOO0VVzqFUPCPLgDbtceo+S
 rXGXyvob7gtJ3DurAbycFFSepyqY1s4jP+tRQpDww81UdZrLOj6IQcY8R3WPYbOetEln
 yr1OQYQzFfx4irzptzj17W/be9v82wKKlXwFZVH4IAYKnsY/RZ56fiapEug6lsrry7I1
 QltXMpzkxGrZNq8mTrhpAI5/4u+XrwSX6gk/jJoMrslWfYjFUBMZ+8gDAtN0EX+207xA
 NxohlhO6DUhTcz99v3P89fc5u/xMVlHeWR4MUM6YFd1AAeAVOrnnWgpxB3ug/d8/+hME
 wrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pTCwkQwfTaoa4SWphSJQOAblwJpi5VF7yxRVP6i7yqU=;
 b=G4CzXFybOzkKwL15fKe61k5LL6YV6pzO/W+DePisJaEIP7vmTtaCvL5B89xq/1ci/W
 HvxgCjHQ+kP2/rnk+8p+SxC8IeCFlwmVwXEL2vtoppVlQK5aIwWm7StK2QouTYQLYigR
 HW75Q4TFtMyHE7rJ7SLygVeQwsTZI0TJEJwkyYTBSrHCEmJY/1t/IBGGrq2xlvwv+xBf
 WRPpu/dm62ECGdqvRkkQxdhVIbkDj8zROTZLtWdOcyzsiaVG7tvBSY5XlQSwbOCMuNEc
 JHqYwCaq4Vy5urvANu4ilnKtPUXiiJFoZJzJ9sXifOoHRINZoNCu9w/mLlDOXrPMfCLZ
 ramA==
X-Gm-Message-State: APjAAAUaPcn8PWMktNq+vgdTbPS32fvZDBRwjBvRoTfB8vBHuRixjARr
 vg7cfepAZboXb65TxTW/uroYkw==
X-Google-Smtp-Source: APXvYqwO+dIl32nafWlt7psuu8kpqTuOBaZQRFGBYQVeMYNZzFLxxDwxqxLCpH38tVfsHiOmzqOj5Q==
X-Received: by 2002:a9d:6e6:: with SMTP id 93mr9890331otx.273.1562740940798;
 Tue, 09 Jul 2019 23:42:20 -0700 (PDT)
Received: from [192.168.43.94] ([172.56.7.82])
 by smtp.gmail.com with ESMTPSA id w13sm459826oih.17.2019.07.09.23.42.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 23:42:20 -0700 (PDT)
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
 qemu-devel@nongnu.org
References: <20190709234330.89699-1-carenas@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8cc72ac3-bb28-5f48-61ed-860a1740cf6f@linaro.org>
Date: Wed, 10 Jul 2019 08:42:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190709234330.89699-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] configure: remove obsoleted $sparc_cpu
 variable
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
Cc: qemu-trivial@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/19 1:43 AM, Carlo Marcelo Arenas Belón wrote:
> 9b9c37c364 ("tcg-sparc: Assume v9 cpu always, i.e. force v8plus in
> 32-bit mode.", 2012-09-21) removed the need for this variable and
> most of the references to it, but this one.
> 
> Remove defunct code, no effect or functionality change expected.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  configure | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

