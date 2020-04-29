Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E486C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3682064C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+QfwR4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3682064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrjO-0005xh-8J
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTrh4-00040w-OB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTrg3-0006qs-6e
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:44:26 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTrg2-0006mR-N4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:43:22 -0400
Received: by mail-pl1-x642.google.com with SMTP id t16so1156705plo.7
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=kp0zvv03JXhADP/c8bAM6urg6EvCkhydXj2S8B/j2zQ=;
 b=y+QfwR4JmWzYZM+dhE3iBO7ZUquBE/X5ujlH6U0MytpBhhKyPf/W1r3ZcFlp5Yy5DJ
 JTm3/MlmRMbN3aINedEHhqCett2HPh95III6zbI/FwYHwhEQFZL2E8uSZU+S6r2IuxBA
 eQR0c7VkB40QPqjiNdEzvgpbf7aF5eG4sNDxpz/MPu3L+B3wDxdyJcHw25/OW/ivcajW
 QO8ANItSLLDX1Z7TJuWEDhlo1FaCR7xy0/H6zR3oQaZVynSv2rv/1wZxjD3QEjUVLsny
 +y1C65qWxfjXplmVNINX1tFwqEvgZe4wrL17pXlgPusSMG3ssSsiXpWp0m8CoN+oJ8w6
 gRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kp0zvv03JXhADP/c8bAM6urg6EvCkhydXj2S8B/j2zQ=;
 b=FdjKCOZPgPpCSTBW8SQtNieJ9zyBiGYyIt2DoQSHmvUflPlc5PueXaG/K+qXpWlxnh
 dKkiEFv1PmzfXMWdtWzLcmswxEyZN4RHOpPJWb5Neds4LPbErnaApZ+yP+frzNHQnBxS
 S3WTWm4arFJE208QzTYLcP3trjufZrtgKLbVSIPSrV73Ox5oP9HTPJ7ac2f4VVo8URWc
 d3GeFaIC5rS1W2Y9/t4FTblkzXwphmsj4sDG0ejKn7MtGuOFHBOlssAKI/A0v745SCEt
 mQk6gp5PvBaNtwfHo4lE90HbEeUuaSIpdnedYLfs/D59URZZQRsymjXsiioAVyTpQQM1
 h7Pg==
X-Gm-Message-State: AGi0PuYx4lQERN81DF9aSM3zAR+9IGtBcMeL9GM1JFMEAE5ZM5/LDKIR
 YKZuepJOrNsOJrL7BMjup8QTTPN4Tcs=
X-Google-Smtp-Source: APiQypIlgFfNxUlm3w1KuxHoF7PeseLXS6LhNjC6WhvwzgRCFFsvD/LWUCvnCfz4wBVZp9WPJk6K6Q==
X-Received: by 2002:a17:90a:5a:: with SMTP id 26mr4904684pjb.74.1588185801035; 
 Wed, 29 Apr 2020 11:43:21 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b1sm1588632pfi.140.2020.04.29.11.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 11:43:20 -0700 (PDT)
Subject: Re: [PATCH 4/4] target/arm: Implement ARMv8.2-TTS2UXN
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200330210400.11724-1-peter.maydell@linaro.org>
 <20200330210400.11724-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <98a9cb27-0a9c-b9c7-f683-968e01202343@linaro.org>
Date: Wed, 29 Apr 2020 11:43:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200330210400.11724-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/30/20 2:04 PM, Peter Maydell wrote:
> The ARMv8.2-TTS2UXN feature extends the XN field in stage 2
> translation table descriptors from just bit [54] to bits [54:53],
> allowing stage 2 to control execution permissions separately for EL0
> and EL1. Implement the new semantics of the XN field and enable
> the feature for our 'max' CPU.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h    | 15 +++++++++++++++
>  target/arm/cpu.c    |  1 +
>  target/arm/cpu64.c  |  2 ++
>  target/arm/helper.c | 37 +++++++++++++++++++++++++++++++------
>  4 files changed, 49 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

