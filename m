Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A25C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C098D206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="On7I+Ji/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C098D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictS7-0007xi-Ij
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ictQ8-0006gy-U1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ictQ7-0002kb-H7
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:52:00 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:42070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ictQ6-0002i1-SG
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:51:59 -0500
Received: by mail-pj1-x1041.google.com with SMTP id o11so1447329pjp.9
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 07:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0nAmMXcMif7HiwcjaWfHAaBfG6xW3mZL8xo/lH1GaYw=;
 b=On7I+Ji/eT04Nt7pMveCaEVl4CGf2dBNb73CDDbpuey5HuYWbnGqqv7wg8gqilqb9g
 riPXWHhn7FNIKvxqTUmJL6/8i+N5dzPeARPpEHQuBc7Qe8gbn73e3pQDmejcIx2x/YSz
 NfR5W+qgX6gwRlw4MFc9fQxXmwj0+ik3POP8koJJ6ZlO1RYlazW5Uyxd0X3puejxsiTf
 4D+Kh+XaHUvD1RSKVelP2W4TNKv0FsnS8BITBb6+MiqLtByDmzPbGHYMu3KrlQIdSq8d
 mlxZTqbwk1x/0tjzvRWRkrqxROgjBkeiCvw05wYUbGmcE+3oKEp5c+7iKiudg93AwXRJ
 r/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0nAmMXcMif7HiwcjaWfHAaBfG6xW3mZL8xo/lH1GaYw=;
 b=MPZ8TxybfsjTzoqyAOJ37b2IaCOPeWOt4R0FgPvcqELhHEIUPgPf8JO2lcvFOECIxH
 tR7aWkbg5T/Dsbz0zTarFDLAFXreisiKk8zZBUt8vy9x0ocuqfAEc23/rJQUSJ4EX869
 WJOA4fg4uTSQK76lqfpQB5FWzp/If1Y4uTqHSiI3uZcHdrlTpY6AHSslYiv7F++MeRyV
 dPtvvH+vD0weHxiv96HNbo/c/hHXqVmlfb/iZTBT0XLTVAmEsAhr/En20LU64MRs9mOy
 NPh0+g0SCnpokZbyzBnNMmMM4cM17cy1CSYRtYFYqCeJx+UfKjLTp6sWt6yJohk6wALO
 yxSg==
X-Gm-Message-State: APjAAAWhFLBRE0UL2pAsch/iRHJPJknDrX/hNGN3r3gIsOLn2y8mLuqL
 NIUymIh06Bir6L6kUEC9OqPsfg==
X-Google-Smtp-Source: APXvYqwDrxrHvnLhKOBFRPV6tmZSZE89gic4jcOBqKXWo3gLSgBYKDEkWKxv8xBp0RjVmiRqFzWsvg==
X-Received: by 2002:a17:902:9a8d:: with SMTP id
 w13mr9584634plp.330.1575561117062; 
 Thu, 05 Dec 2019 07:51:57 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h68sm13685194pfe.162.2019.12.05.07.51.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 07:51:56 -0800 (PST)
Subject: Re: [PATCH v2 1/6] linux-user: convert target_mprotect debug to
 tracepoint
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191205122518.10010-1-alex.bennee@linaro.org>
 <20191205122518.10010-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1ef8ce99-cc16-fb87-44e9-4755137132f9@linaro.org>
Date: Thu, 5 Dec 2019 07:43:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205122518.10010-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 4:25 AM, Alex Bennée wrote:
> It is a pain to re-compile when you need to debug and tracepoints are
> a fairly low impact way to instrument QEMU.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - don't both with ascii conversion
> ---
>  linux-user/mmap.c       | 10 ++--------
>  linux-user/trace-events |  3 +++
>  2 files changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

