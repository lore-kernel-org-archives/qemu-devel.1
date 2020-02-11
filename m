Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66118C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9E524649
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKxsLUlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9E524649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1abz-0008Pq-Ay
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1ab9-0007nU-W1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1ab7-0000Qn-QG
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:49:26 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1ab5-0000Jz-GA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:49:25 -0500
Received: by mail-pg1-x542.google.com with SMTP id d6so6193940pgn.5
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Oxft3jtxJKwQ7Egx48zyh88CIRwoheucgSvHmE4yHPA=;
 b=YKxsLUlD9K20dR169Ol7Tvw9iMKmHH44pcjMsUNmmw8xEcMxJqDmhdFM0haAlKikG7
 ROKroaP06sBFZYbbFrD0axlibfiFG+dZsgxRIyrQAzMupgJ2/IlDGyKLLUoI9rbhvlpq
 WuiNZiajv36w++GvhVgAxC7IicebXcicOTAy/7Vqee1yU7SzuMrcvw1GRGvAdU4sUN4K
 gvUiJNV4uTSWcRIJ+a10kT7CLq4ZntWHKdZ4yNliO7Km3SveOyqkEWtkIZ7wnn5zt8Us
 D265jZld9F040rG0IiqWtNLN1IHVXN7kRW1z5hjjUx4ZkMcRcWqrtsxDKdTWSr00B/Xl
 hOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Oxft3jtxJKwQ7Egx48zyh88CIRwoheucgSvHmE4yHPA=;
 b=tWJMics/8OH92muSFhlgpOf9MsXnrLar+ifkLKpA4lxJc0OHjYsKmnISdRIBSYKTV4
 R2XlGQyxdCrtRi+6FXgBoOL78J+aOOdXPquM3GyVzwxZR5z4MQMTSUjbvE6bG71gKjit
 cPVU2D4dyiIjIXIMDMPKJPbG+455ZU4Odm99HSY/KPgdcBssvVxhO6pUQTXIWG0vC9qb
 tys8Qni417JzG8cUYAzBAi+CnuXGCSHx3+XhdWtj0ApX0hOB/Ao8I05TyfH6oxYF/m+a
 GSoJup8R5+WWjbV0g4qgpo666hwk3f48RfiZDDdFKWJwaoEKbg5MxSXzM+A9fQtoJB+Y
 rxZQ==
X-Gm-Message-State: APjAAAWJ++D2YGY69pB8CzNZmswOYYzvNS976KJzmLQ+bFkR/srBwTtN
 6kurs7pt6aNjfVT3zBNtf+fI1Ws+rj0=
X-Google-Smtp-Source: APXvYqxsQlC6IlNKI0wt+naKbKozMVCkBScidHPsv3lphoRFzoi/PNtjHGsSQRJhGtgVfrkrxvCuEQ==
X-Received: by 2002:a62:5447:: with SMTP id i68mr7872655pfb.44.1581446960421; 
 Tue, 11 Feb 2020 10:49:20 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a21sm4938456pgd.12.2020.02.11.10.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:49:19 -0800 (PST)
Subject: Re: [PATCH 10/13] target/arm: Implement ARMv8.4-PMU extension
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d8ece08f-f4f7-1425-7f4e-eb3af84807f5@linaro.org>
Date: Tue, 11 Feb 2020 10:49:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 9:37 AM, Peter Maydell wrote:
> The ARMv8.4-PMU extension adds:
>  * one new required event, STALL
>  * one new system register PMMIR_EL1
> 
> (There are also some more L1-cache related events, but since
> we don't implement any cache we don't provide these, in the
> same way we don't provide the base-PMUv3 cache events.)
> 
> The STALL event "counts every attributable cycle on which no
> attributable instruction or operation was sent for execution on this
> PE".  QEMU doesn't stall in this sense, so this is another
> always-reads-zero event.
> 
> The PMMIR_EL1 register is a read-only register providing
> implementation-specific information about the PMU; currently it has
> only one field, SLOTS, which defines behaviour of the STALL_SLOT PMU
> event.  Since QEMU doesn't implement the STALL_SLOT event, we can
> validly make the register read zero.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h    | 18 ++++++++++++++++++
>  target/arm/helper.c | 22 +++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


