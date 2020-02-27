Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E03C3F340
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DF9246BA
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iA1E9AJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DF9246BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JfA-0006bQ-CU
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7JeQ-0006A8-0v
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7JeP-0005lT-59
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:56:29 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7JeO-0005lB-Uf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:56:29 -0500
Received: by mail-pl1-x642.google.com with SMTP id p11so1175487plq.10
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aQm0C4tX5jVT1uADHwJXrKSuUEzVDd0yYSTELI/9H2s=;
 b=iA1E9AJfob+SGucpPW2IpncDP2BFPUW6iyLmCjTW1+vIMUfOQXdKK51r50R0fS6Qmr
 zgOU5qzbgvU/U4KAZxbRJOpM/B7eBFGo5PDLSz3Q0I3k+BJae8FJbHXo6Ih+p5e9Lcj+
 dXet9N4KFPh2+ZNzN9W9rxm9vx5mB6bzO8yjRtzlxrlBFd9jyWvqB7YOX607bcZuTToA
 siPRKWG15zBYn9DcbDEoCzh7qHRfQMQ3y16i+Ao4uKA2X0W5sNoEap45pDLYwIwKdrde
 iKx58D2gCIKREO8hr4FZM70hv7AQ50+58SGAIoHKlzGMm+oZEIRLQaFQreSjFPkSv3Sx
 VqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aQm0C4tX5jVT1uADHwJXrKSuUEzVDd0yYSTELI/9H2s=;
 b=FwPZCM2ZgY22hatGNhrE05z4KXVtsG/DngMioBW0+1pBZwBbT0nNXvhXEho2VSiIgz
 7hEccKOa8m1RaTayFrkqylFYDA14q1dMaytPOeil0z8FvXUZhjwYoXTRnDk6Nszg3u5K
 Teiu4//EgUvHl+lYQ6k+gy+JqrYZnHuj3Uslbdw7HCTzPE7vZXSlO9+ozlDi7Yajx65R
 LishjK7pYag7TE2qTyIZUKUhYLJP5/Cjh/2GM8kJRNFOfxHl/mCPAQuEIMcOUZyZwEZA
 esWXRsTRaG3IVo/JJxOjo1VD1NPAfP/lXN+WaiMrHilrAlmI3MfmLBLCBkSbAAOR4eug
 1aMg==
X-Gm-Message-State: APjAAAWJOrx946MFBBIEIHfJa28kEQjWk4nFSBOCkyyhPUJV5z7Sy9yN
 oyCGmoe4CcWHr+6LI/x61E/LWA==
X-Google-Smtp-Source: APXvYqxxNYMafZejf4YzlvAxgO7M271rBryxuGVSeAlriPWqvbUNFYMq7DilgimUlzmbvcAovIxCtQ==
X-Received: by 2002:a17:902:9342:: with SMTP id
 g2mr4514232plp.339.1582811787725; 
 Thu, 27 Feb 2020 05:56:27 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w11sm6852055pgh.5.2020.02.27.05.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:56:26 -0800 (PST)
Subject: Re: [PATCH v3 02/12] qapi/machine.json: Escape a literal '*' in doc
 comment
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200225140437.20609-1-peter.maydell@linaro.org>
 <20200225140437.20609-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f4d4d8ea-a1c3-0298-c826-6cf77e5fe929@linaro.org>
Date: Thu, 27 Feb 2020 05:56:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225140437.20609-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 6:04 AM, Peter Maydell wrote:
> For rST, '*' is a kind of inline markup (for emphasis), so
> "*-softmmu" is a syntax error because of the missing closing '*'.
> Escape the '*' with a '\'.
> 
> The texinfo document generator will leave the '\' in the
> output, which is not ideal, but that generator is going to
> go away in a subsequent commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/machine.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

