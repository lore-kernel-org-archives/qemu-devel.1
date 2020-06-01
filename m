Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82B0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C78207D5
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmPTUV7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C78207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jftcG-0000L9-Q6
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 19:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftbE-0008El-6T
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:12:08 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftbC-0005HX-Ok
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:12:07 -0400
Received: by mail-pl1-x641.google.com with SMTP id g12so531253pll.10
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=u2/Vj0j1EEKQPznyFyx0ehES/i7oODuV1pAlFlwOYic=;
 b=BmPTUV7yUkyOroADapH8Tsf0bAHn+k9qXMmKq6nH+ZZb3e7hiO71Rm52dkx3nGkxoJ
 fReiSUp5/jKnx7Rqj2DWZxm0kv6T886y3FUpRC2W98h5N5iWc+PHxC/oLPnfJ4GaTmFu
 HfgbrT94BUyfS2OGjuSaoS5AKz2PRMglV8XysGFtLOwRBIZV3W5DaSezc3mqAIzQ0R6I
 tz6w9066Jt+PhMP40WrISJFg1WrNoAd69ZrIaDO7V6BbVuX+a7eXiiqs4Y/oii/1eRJr
 NsmGvWy+PB6pbbsVfMQ/v+NcmDjMbGDUuGLAyqYC0NHoyNK8d+1NDqXVxmRLuqMwB+ed
 1BXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u2/Vj0j1EEKQPznyFyx0ehES/i7oODuV1pAlFlwOYic=;
 b=uTWwdDKYMeiLZgqHZ8EvQUo0+YvcEDzp8dQS8UHxgkUoQEXt9eVOnBLmiK+j9Yx7EF
 qwaR8XxAycD5rNfXobHAA5CQrGZ+KKKCANcJxmP8kilfLWIZJOjYTzEe4KtoAGftcmm8
 FoOhCgVe/pOpC6Rr0uRJ1RWG10xJUwoOZWUvEg1UlxoBfkHwJK6Z2979jCI7Hq6Uf3W8
 CHvmFS1TW1URmbRVnjfHZm5HkbQCtTdh5AIOGogFOvtDvD/Ycg+SI2TZApeeEyGeoUhi
 QtJhOvTa90Vu1ZmvJkEtrMrMEvPco0Cf90Fa9tEfBBHJ+7uAvI5ZRmAfNoYlJxOrWC+n
 dfrA==
X-Gm-Message-State: AOAM533a0Fbf8xyMg/ju8mvPKd1GfWF1AC29y+Hwd0xixQ50y4IdnnPg
 fpoZOtlfwujBg9/p5lZ5RJ5UZmOSRKY=
X-Google-Smtp-Source: ABdhPJxvpFjtmGfoeq1Yb4K3h2HdMb5r9ciWzMWH3g2XUR3EqvIDbA+NKXiRo6KT3LFHyi9uOzjDPw==
X-Received: by 2002:a17:902:301:: with SMTP id 1mr19899643pld.65.1591053124595; 
 Mon, 01 Jun 2020 16:12:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p4sm385046pff.159.2020.06.01.16.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 16:12:03 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] target/arm: Convert VQSHLU, VQSHL 2-reg-shift
 insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200522145520.6778-1-peter.maydell@linaro.org>
 <20200522145520.6778-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8bbddda5-3474-38cb-5a7f-0663586f645f@linaro.org>
Date: Mon, 1 Jun 2020 16:12:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522145520.6778-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/22/20 7:55 AM, Peter Maydell wrote:
> Convert the VQSHLU and QVSHL 2-reg-shift insns to decodetree.
> These are the last of the simple shift-by-immediate insns.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  15 +++++
>  target/arm/translate-neon.inc.c | 108 +++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 110 +-------------------------------
>  3 files changed, 126 insertions(+), 107 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


