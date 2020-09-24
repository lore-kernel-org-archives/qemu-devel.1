Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FA3C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A56F221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hy7RcdcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A56F221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWtq-0008Pu-79
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLWsR-0007Xb-Eg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:26:02 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLWsJ-0006PK-OH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:25:57 -0400
Received: by mail-pf1-x441.google.com with SMTP id z19so338702pfn.8
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=sDQHIRZCze4g04cIzkr9BOUBB14Daq+7QU7dnPyeBGg=;
 b=Hy7RcdcKxHtGMNGJFtrejdnR25r+1PM47mDtVDb2MTdlt11JPBytt86BVuOZSvMJxS
 5UnvPbpLWC/lE1dBMp346WBiKV/A1Z03g9L+PSzTWN0iU3j6JEUZLGI+Hrrh+/PB4x3e
 WsjSp0vIMRvEGaynwGQKJHK02wyU0HnBIf/gw+TLrwRerrxTDSyOd0c4NfWGQQ+UWLGm
 AsbqV9iaiKYQatwshWZqMWlsFBa40Us84QwQ6bN7ac4N4a9MLiF9yLDXNS0nZnkNB6rJ
 4F5QFWWh9P1u4brtMEbpJ/sIC1SPPsviFaDGgwLY7AtPI61wpvj2nSA2wNj2Dp07PR26
 Okig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sDQHIRZCze4g04cIzkr9BOUBB14Daq+7QU7dnPyeBGg=;
 b=ZirTpA8eNy1t2nfnownl7zDn5slFI5096Hxwjptc+hIat4W/q8qgDOPNqGQrfOzzXH
 QKF1ecoJlf7qQfB2yT671cKlpCA8k4S3mNjJui7jSVPeaVJejfMIS2/A9QqmGIGnuBS1
 dEySQPfNBemkOG+Vpf4+kMlMh7683KZrTId6IzyOKbxo3nUt/edNJnpAL47S6WF2AHpt
 0D2rRL/9PNolILU99QJ3bR5M39Mqa7aCN6wYzIf34G2JUKLRCkJZ9bkbM0yTeUHoH0O5
 vT+Cq3xYTz6M8Iz1lT2fWlHoaVqUSX++kSxcKXcFc7EUZtlEFvlgQFsvHmLQGTKdPMIm
 6WMQ==
X-Gm-Message-State: AOAM533gduTf+PGzk74azRTNV6anYH66tznWKvmmcwAdhG3oI+Sb3YLS
 SZlTvA5xhHa4Y7fVGrMDe+I0Fy15ubMZsQ==
X-Google-Smtp-Source: ABdhPJypxFqO0DXzgPAIATqjs0QyYvmSCrHON7yXimt1hrMmDfVo/prhAjkjqx4ghyN3A7y71Wzb2A==
X-Received: by 2002:a63:ce17:: with SMTP id y23mr486725pgf.447.1600975548815; 
 Thu, 24 Sep 2020 12:25:48 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q23sm247693pfg.143.2020.09.24.12.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 12:25:48 -0700 (PDT)
Subject: Re: [PATCH 2/4] qemu/bswap: Replace bswapXX() by compiler
 __builtin_bswap()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200923100220.674903-1-philmd@redhat.com>
 <20200923100220.674903-3-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <97574632-6c90-7baf-00ac-e068f987e067@linaro.org>
Date: Thu, 24 Sep 2020 12:25:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923100220.674903-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On 9/23/20 3:02 AM, Philippe Mathieu-Daudé wrote:
> Use the compiler built-in function to byte swap values,
> as the compiler is clever and will fold constants.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/qemu/bswap.h | 30 ++++--------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

