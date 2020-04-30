Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30318C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14352076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjiEHbPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14352076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUF6Q-0007Ql-6H
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUF4D-00051t-OJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUF2F-0000FS-EP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:41:53 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:52975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUF2F-0000F9-2O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:39:51 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a5so1274865pjh.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=oWrO9ljQZLDUAdkjQzfBtUjgd0I08wqyuqLOQI1dRC8=;
 b=JjiEHbPng+P3c8OEDnFJnmAkPEcWsT2E3TnmOHaKVNyFbCLgqhBKpChQOEjGkYCu6A
 VlrwUAoHVWXcOEvcKfsnEkvruaAsckzwXKBt9OYZAHN+itLGQunA5yV3EST4mozf9Pnf
 MYJAuu2TmwE3v4FuLImDN95xR/oyujZkq3N/ttYqSkZ98VqaGltEmsVXhhZPbHs7W1vU
 UOP9gQZ4sFA4H4g8pLns1T5gBJSgFopZh9mhXxcrjCQZxLuGQIpEwYyACD8+aYDbH0OS
 c5M3QFKX7BvktxhXfm1yD3yWJvMwvWFoWqWRc6D3HmAhXS8JU5YfihFfJdrHH14bOP9O
 GW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oWrO9ljQZLDUAdkjQzfBtUjgd0I08wqyuqLOQI1dRC8=;
 b=dj2V++yIJHxJmMbdzfI8PhnF85MAJxV8MHZakCCaBmOdKtA1rn3eSLCGBx2Xw3KUGm
 oxcFXg0zbTpAbFNmhpVFaI6vN5/tS1OLF8NKX6IkBg+2HPKxbWel/38KHeh2Tk5JxPET
 RsW2e3sOOA0sbDm3fvtRmZEdPVbj2zRDPAWNbVVGNUkNVRBvXNd0tWk+dGSZjWdJ1Y2f
 pOH6R3+Vvw2vrIuEQ23isIPI4O7n/JttwiOqbZhc4gWEKiygG/80bicK+f0SQuKCec16
 kQFQctaEscRRpb35NUeE/1IQVHvIl8qW9XXWo0lPzLjfgcCqX4R8xX3b7l8joQzKnb9L
 ErZw==
X-Gm-Message-State: AGi0PuadAguje9jdXq6CXZY4fNrr04ZbMR2wIAwme2p1ODPI/21SERW9
 vktvo7SkS0YFbZXLxIcxXDMdZodoW80=
X-Google-Smtp-Source: APiQypKB3vlZN6xTfP5d2raPDspI38lE7liHNYUaNg3QGtRG3UMshfLhukEUjih5WNx1qTSX4QH2gQ==
X-Received: by 2002:a17:902:c3c3:: with SMTP id
 j3mr580190plj.284.1588275589398; 
 Thu, 30 Apr 2020 12:39:49 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b1sm482172pfi.140.2020.04.30.12.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 12:39:48 -0700 (PDT)
Subject: Re: [PATCH 15/36] target/arm: Convert Neon 3-reg-same logic ops to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <529b6455-be2f-5baf-82a4-bcf8998c7801@linaro.org>
Date: Thu, 30 Apr 2020 12:39:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1044
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

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert the Neon logic ops in the 3-reg-same grouping to decodetree.
> Note that for the logic ops the 'size' field forms part of their
> decode and the actual operations are always bitwise.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 19 +++++++++++++++++
>  target/arm/translate.c          | 38 +--------------------------------
>  target/arm/neon-dp.decode       | 12 +++++++++++
>  3 files changed, 32 insertions(+), 37 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

