Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12DAC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E432083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nP3XzhS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E432083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrpx-0007BC-42
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTrcg-0005B2-5m
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTrcf-000665-ES
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:39:53 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTrcf-00065o-1V
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:39:53 -0400
Received: by mail-pj1-x1042.google.com with SMTP id hi11so1127031pjb.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=3K/InUpK7f86tjBXoYHGLn76j5rS8Ttrm5bufUlB+bM=;
 b=nP3XzhS5+cPQuYjQRTwid3+VwiixqMXrb+B5C/Ofl5Xz/DzZDMY91nYxuzL0u9Agd5
 z2pQdo6At4l/zx3CUrJzQtK5qAUgtwrFjaH81DA4dPQSoC+wZMEP3I9+Nd/tu8c51ThG
 OSRcXMfRsvmd02GrCf+W1SPGew0DI5pc6PWk9wPgKT2QPq7eMBrNlaR7ZWV0Rh8HEELG
 kTSkvb9zwyoe2rX2DiMOLBL427PxGwtt2Pje4/1j2Oni3Kb1evR+cy1UFdRsi+UdNIfh
 Spkw45s4fLt6OdWj+PwaUULPgMnXyDf+X0h7L2Na8lYrOavklr5aNH0mQYdi9Oo05O2n
 LKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3K/InUpK7f86tjBXoYHGLn76j5rS8Ttrm5bufUlB+bM=;
 b=VLYNgEeWH98cONR2M4fhtPppj7398nISzV9Em2lvykzWNPi8iry25Z6Cc3Ma4v7yXv
 bw0sIZpt8nrDY9Kmpk7uzqXFRilq2RvMovotDNoq9fru+A5QBVGN2fspkzjy+gz4NnS8
 RwGhLysYxje5W8QGavIq1fOixFYKrP2rxodFwXiw9yhgx7HZJaz2jFpr5OC4TCUWXAHC
 P9H4U6VMsV2e2p382w3NIoA7ju/8foLsf/5MgGqoJA5pAme26KvFP8oRLmPbFMqRJ7Zl
 PW9TaxcJOyUe10wonAGVJEdFKCcgVVSTinUV3/D7sYtDlu9VjvfRTLg5wmDAbg6ZMIV7
 0ewA==
X-Gm-Message-State: AGi0PuYFaxAYWRoRaoixAEtb+uq3D83v8YE2pxVbs/cFU5d79l1LrEL0
 ShU/kLqK+aWpb7OfH4oV0x18vgcEKsU=
X-Google-Smtp-Source: APiQypIP7yb1bMuUDJYrPqJtP1LatyxB6tR46BbXCRewkQ3J7RiXvY27dLGws9nNiMxS4uURK8T+vQ==
X-Received: by 2002:a17:90a:ae12:: with SMTP id
 t18mr4819677pjq.26.1588185591483; 
 Wed, 29 Apr 2020 11:39:51 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id v64sm1645746pfb.20.2020.04.29.11.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 11:39:50 -0700 (PDT)
Subject: Re: [PATCH 2/4] target/arm: Use enum constant in get_phys_addr_lpae()
 call
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200330210400.11724-1-peter.maydell@linaro.org>
 <20200330210400.11724-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aabd163b-4783-3f4d-a260-ba06fa021d2d@linaro.org>
Date: Wed, 29 Apr 2020 11:39:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200330210400.11724-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1042
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

On 3/30/20 2:03 PM, Peter Maydell wrote:
> The access_type argument to get_phys_addr_lpae() is an MMUAccessType;
> use the enum constant MMU_DATA_LOAD rather than a literal 0 when we
> call it in S1_ptw_translate().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

