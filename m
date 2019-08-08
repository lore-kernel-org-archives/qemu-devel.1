Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D3CC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D1C214C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oj6WRXbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D1C214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvmeM-0006zt-01
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 13:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38395)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvmdX-0006UV-0C
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvmdW-0005O6-2d
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:55:38 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvmdV-0005N4-Rt
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:55:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id f17so40523213pfn.6
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LgPx9zGCboOmqbxdrl+DYL0sxkqYQhvgue6jj9v/tjQ=;
 b=Oj6WRXbvQbv35QCv8uqRel3E0KtSacXt8TTHfkGVZj5pn2m7339teiJ3V2x2sUL2zw
 g1QrUqkYmlhNeZhCPQ/gWD6vOxXcHVVaSnwbXUCl80siCTlS4c2+/4I8BjziiV/dGmXi
 LTn8CneczJlzpOBf/aM4vwpS5oa7FzUvn5agyqr/tzkWQDfP18ULZsg4nrurD5lEXs42
 zzPiom0uRF3ul9dLXTzRe3QWafYk1iQ8kJjGpPO2z9Bju0FUdxyNdvA0ZcVPwLaNQnfU
 CuTrHCK6jP1TnJ7pYotQaXds9t4Re76DGkUU0QHfR2fgPEO9UAeoLdZy0Vz/iKiD7a+E
 3vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LgPx9zGCboOmqbxdrl+DYL0sxkqYQhvgue6jj9v/tjQ=;
 b=beu1hwumWocPi5DTuKcfYpFIptlTeRmpgeQtDWYkHnXn979tVuJIA7PVpWpyvApGe3
 vmisg+2eb5yf3M55nK+gEEQa4rDmnv5e+8NvaBkAQTM5KyhicLe5MrSGx57+ZnjDejwe
 2XXy8aeiP3ibQ+NguXGnQHH5gflUWkU8c18/3w7OyvuLwSDZg244yZEBIxu57ZBriyke
 eB6TVWe3OWn5iTp+C9z1X8ADIpizsSwuGCNB7orUJzfNDvil+MICpEnmxPNL4slftmT3
 x3s76/O4T+RPk0oT6I6kA2JTvkE/4QPjNmEEK4EHRHDOldtaQ9Pt0P3Yzcr2ofh0eUwN
 X53Q==
X-Gm-Message-State: APjAAAXmLWlV/ZXacfDWXECxryNQZY6uPqy0YoITVjKuPirzRSKpKqAU
 QsGu5SjwGgahnF54A3P4K/GBAQ==
X-Google-Smtp-Source: APXvYqwLCB0lCLAXkwZo/L//gSat0Z9AHuyuAzt9HhKUyIqCojPUHZ/YjOB3OzXbkSn5LJOrsCiZrA==
X-Received: by 2002:a62:1616:: with SMTP id 22mr17123835pfw.120.1565286936903; 
 Thu, 08 Aug 2019 10:55:36 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a12sm21916895pgv.48.2019.08.08.10.55.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 10:55:36 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190808164117.23348-1-alex.bennee@linaro.org>
 <20190808164117.23348-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0dd4b130-dfe2-6a0b-fdd1-e265e9004ec9@linaro.org>
Date: Thu, 8 Aug 2019 10:55:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808164117.23348-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 5/7] target/mips: rationalise softfloat
 includes
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, armbru@redhat.com,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 9:41 AM, Alex Bennée wrote:
> index 21c0615e020..f146924623c 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -5,7 +5,8 @@
>  
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat-types.h"
> +#include "fpu/softfloat-helpers.h"

Do you really need softfloat-helpers.h here?
It appears as if this is only needed by target/mips/internal.h


r~

