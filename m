Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD98C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 18:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A782080C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 18:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJ7pVVLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A782080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkv8J-0001kc-RI
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 14:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkv5I-0008Bx-Gg
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkv5H-00011a-HS
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:43:24 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkv5H-0000zQ-0P
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:43:23 -0400
Received: by mail-pl1-x644.google.com with SMTP id az7so3077496plb.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 11:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EzIJCTIfOvUcUKRuwJ6VSmEfLIUyL5Ykcy5iPCJGFmo=;
 b=WJ7pVVLR3yRfBlbjDd/KKJfa+9odUCya+eqDokaR9KJGoMtLNCMY1JiJEn8/fw9G8M
 M/USJiM0ykinFvFAorZICBnrd9wh9RC4+3M8MJRWIGVRQthszKnE0KFPY8FrTjsp/SI3
 YzgLiQcAIMnN9goNOhT7SUMwfNEsgpWo3oflpkAvp7BCVRmR5KP7ems7+y92JeSX9037
 2MoqnK4E9SY8wW6h9l0r0XLAA//XXctjkM36/ZiDU6cxZ7JazeQ7hQNIV18RhCt128RD
 Fg/u4CckSo/k261DhVyoz+KzSUCwDe/rsiNiA4Vv8OSV8mAhhbG0UIejYpsRS/Shd+uX
 Gdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EzIJCTIfOvUcUKRuwJ6VSmEfLIUyL5Ykcy5iPCJGFmo=;
 b=slr63SWtnU686f3CmPSdxXba2bZdHWeFgiNlX5FHzoV01tQ9aFvbrSYhfI1xSQadOs
 YTzEUAuUpqfgRKCUcLpyIBkOCwZWQ/WyPMu608cIuvJUBbvFozVib+Q8ScV/zFk2BTHo
 nc/EDz994UW6ELXLESnhyKcvkq7nFTr24jfm0b9gPNsWWyne4WJzq3OE0y1vUWrJkrNl
 +0HsyZMB55TKRGCw2NcN+lPxSdJRRcmUi5hm9jB5k/eSRJDanc84ki0Rzeoyqs/wbiZt
 skf16f2+Q/B2/zyAolEVjDFh3GrexHm9rb2oKzD7VoCP9p5s+pPx2nWe12PqBnAxqOMB
 VQ/Q==
X-Gm-Message-State: APjAAAWk+dQtZkPpauUxaRaJTURk+eALNYb+f9o52dB1gYBTMJcZkUIf
 u2JeEFZx7K+Ed98PjVl2qPOv2g==
X-Google-Smtp-Source: APXvYqx1vns8uSLKvOF2OSj5bmj9KcM+2oOaq+kTOyjMlYBP6c8yzdEFhFHaVpxpLUb+HnclEjY7gQ==
X-Received: by 2002:a17:902:8b88:: with SMTP id
 ay8mr32845014plb.139.1562697800637; 
 Tue, 09 Jul 2019 11:43:20 -0700 (PDT)
Received: from [192.168.43.94] ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id h9sm8689793pgk.10.2019.07.09.11.43.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 11:43:19 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190514011129.11330-1-richard.henderson@linaro.org>
 <20190514011129.11330-2-richard.henderson@linaro.org>
 <CAFEAcA8k9+XW9uPujk3Zp3CxvYm6Qj6kVEig+KuNO2ywOK0tTA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <11edb5b4-c72f-387d-3a5e-412a546ee902@linaro.org>
Date: Tue, 9 Jul 2019 20:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8k9+XW9uPujk3Zp3CxvYm6Qj6kVEig+KuNO2ywOK0tTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: Use extract2 for EXTR
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beata Michalska <beata.michalska@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 6:40 PM, Peter Maydell wrote:
> On Tue, 14 May 2019 at 02:11, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This is, after all, how we implement extract2 in tcg/aarch64.
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-a64.c | 38 ++++++++++++++++++++------------------
>>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> It turns out that we have a regression in booting at least
> some Linux kernels with TCG on aarch64 hosts (the same
> config works fine on x86-64 hosts). Git bisect points to
> this commit (80ac954c369e7e61bd1ed0) as the cause...

Bisect would finger that one, since this second commit is the only method by
which an extract2 operation would be emitted by the aarch64 target + aarch64
host combination.

(The other place that extract2 might be used are deposits, but aarch64 host has
all of those covered with the bfi instruction.)

Fix for tcg/aarch64 coming up...


r~

