Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAED2ECE58D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997B620867
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8L8fO32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997B620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHSwA-0004FE-N3
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHSvC-0003Os-Vo
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHSvB-0000T0-JK
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:19:30 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34]:44877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHSvB-0000Sn-Ek
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:19:29 -0400
Received: by mail-yb1-xb34.google.com with SMTP id t1so2756752ybo.11
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M2wbmTW09cLhe0F90lYI664Rb0hnJ25k0iTYaapRfAc=;
 b=X8L8fO32BIdbyIF8F+EB6vHuN8Lqo/kQ8B9hPMP5i9A0eIJY4ntiKIhKgoKpcF5S+X
 z1i4thIarI0GZEs/wEw1ydHd9yAoBgkYfMaL8PIn14qxVAXTn4+5x9x3xK2sxRvttrah
 yL9Bpg8lhqF3RQeBGIhWhBoZ3VSSNUn2dLTEF5vUum65M3tMNGFCKNQdkxiu0fo20H70
 kYUL6UP/iQTz6ufueLFAyi0R0NaGadv0hXBgNK/6xQzEkx9AUsE1HCKasumYZxxTaYgp
 PuWseR7bI2MZMM582/4omWt3l2bEEFY7gZyB3R4eAVz4un4VAtghHhRrLh05RipKT4e6
 BRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M2wbmTW09cLhe0F90lYI664Rb0hnJ25k0iTYaapRfAc=;
 b=cAqOJyykSeDZdaEv4QNInNiKAVvuGwOQe/PvJNnwCMcLEeOVwYlKBZaAmchM+lEO4P
 rV9cAo6/cXoCnIAuKNmGh1kD5GsS2zuK1ypzhtSCnOWeZKC15MepYRjOoLFP5PR83stZ
 NLormGWyMK7ex8PD3LUIexvCQaXGT3mYiNF5UxaJYyXr8ZGFzbeWzs5981rf62YcTRSE
 88yGGXTSWnnswV5FVsEbo01EB6cZ8k3oCEyo07/KVKCZL8GWDZj3GREUFCpMZ89VcixU
 N1PCD1UlJzF36smUHzvCpuvhkCLEJpD+Qb7fK7NAGoF9GBLgc40lgsDl7Oknl12zs9iB
 ZGWA==
X-Gm-Message-State: APjAAAWtHJ/KiqYOg3FD4VGpRaElVDkKSBXa8pCFn/pSrtVgUuxnlKdZ
 zm1W+67K1iRunSf0sea6FVze3Q==
X-Google-Smtp-Source: APXvYqzTDpd6z+f45c5w8YW526NqykfaewkXNV1qnZPTwjOKkCvsjHhlTe3cjvannGyKGLghlDz/gw==
X-Received: by 2002:a25:8106:: with SMTP id o6mr11206478ybk.213.1570454368164; 
 Mon, 07 Oct 2019 06:19:28 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id p199sm3772836ywe.1.2019.10.07.06.19.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 06:19:27 -0700 (PDT)
Subject: Re: [RFC 1/4] hw/timer/arm_timer: Add trace events
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191004114848.16831-1-peter.maydell@linaro.org>
 <20191004114848.16831-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <eb9cd220-e43e-3519-c1e0-c2febc3c5ee6@linaro.org>
Date: Mon, 7 Oct 2019 09:19:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004114848.16831-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b34
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

On 10/4/19 4:48 AM, Peter Maydell wrote:
> Add some basic trace events to the arm_timer device.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/arm_timer.c  | 27 +++++++++++++++++++++------
>  hw/timer/trace-events |  7 +++++++
>  2 files changed, 28 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

