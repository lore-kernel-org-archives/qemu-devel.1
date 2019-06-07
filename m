Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECFFC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B95208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceqOtyql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B95208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50376 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJdh-0004Tw-LL
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZHBK-000291-FZ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZHBJ-0007iX-JF
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:53:30 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZHBJ-0007hD-DY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:53:29 -0400
Received: by mail-oi1-x242.google.com with SMTP id b21so1754579oic.8
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jUGCXopUqagwavwf6nXHRMMQXU0j12H1RCQMa4QmlHM=;
 b=ceqOtyqlf+sEIKxkR3Dd7LYDTwX+eVf5igHVNxHt8c6Q11CQMkQ5fdXj4WKxiNsr7g
 ESuZO/zAsE9FVMa+c/TuVKu0DnL3nth7NAYSChvYv66tgeAaNcz7mO1wZrBvxpkcAEAW
 TJ57XTEsmQOmWO/W/iAq7Jepz0LaQZO8kkGSPy4Tl/dzGd2lndwLEAtfgJ4QfcbFJ4Ue
 7Bp3Epeip+l7Z+WXlcKdMFft+zIdgYcWHz7sg65Udt6vB8Di1PBu6oC4ALR5n96tv2OC
 0Lk0Q4onJPwJVnQ3Th782/+TUb+Sq0LdguoLPw+hPuOEwnDvQUPt+3jX+GNBd6a4GaM9
 /hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jUGCXopUqagwavwf6nXHRMMQXU0j12H1RCQMa4QmlHM=;
 b=aiUD9n4WW22HCvnjYbWAbiWC6BmqyciNgM9/wgbvCia68EK9TDUljo6Zd+wHLCMalN
 o4CF9hBv1LQT/CSbN51uWQAaIaT5GGjp6DuJ1v+6WCWsBgGq3se78wqtN9ZYpZY1ikDb
 pRUpojofmDyiVmj9smzP/2TI3fh7iFQzaPZ7a/uLimj+9+oq90AsOHogfxBs33TQPDAF
 JVGPJm2axkH9QFQ0xBG9FH/JxYbyFuiin+jSIyfNEpSfxBuAXOxbMHIfB8kWS0GwqQJa
 Lr71Qksc/5a6zp5d4nqWW4UT3pXXpf1DEDRNX8y5wjS3geGND3DSxnrdvT3J8Cv9yeCs
 6xow==
X-Gm-Message-State: APjAAAVtSF5Gv2eQxYucB7z6lpwIoKf+dXI0F3AY+vftucSPc7NAo2ms
 f3c673gKZg1q1n+ysNT3dPIxiZGYGjqfmA==
X-Google-Smtp-Source: APXvYqyuQLAnpnumH1BjX5HxJM4uCh46JvDco93Cr5dtuVy/00a5MZ1hEhZIEP4siE5Zn3zbxH0Ldg==
X-Received: by 2002:a54:4686:: with SMTP id k6mr4301232oic.112.1559922808328; 
 Fri, 07 Jun 2019 08:53:28 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id e4sm860962oti.64.2019.06.07.08.53.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 08:53:27 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d18a03bb-e1c7-dacc-df52-45db40044eb6@linaro.org>
Date: Fri, 7 Jun 2019 10:53:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 10/42] target/arm: Move the VFP trans_*
 functions to translate-vfp.inc.c
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
> Move the trans_*() functions we've just created from translate.c
> to translate-vfp.inc.c. This is pure code motion with no textual
> changes (this can be checked with 'git show --color-moved').
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 337 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c         | 337 ---------------------------------
>  2 files changed, 337 insertions(+), 337 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



