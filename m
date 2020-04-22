Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17698C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE07020706
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/2YCEye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE07020706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR6rI-0002zq-2M
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR6ph-0001Rg-By
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR6pf-0007Ny-Qj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:17:57 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR6pe-000741-BC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:17:55 -0400
Received: by mail-pg1-x542.google.com with SMTP id h69so443027pgc.8
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ms2dMCxgzwYBAAxkHw1eJs6bOAGxrj5YZkd2zEbCOXQ=;
 b=K/2YCEye7ppf8wjJ0/BWBZuxzbuXlx5WJumuMG5dIEsK0nh6FJhDyhRdk4XrEsBqW0
 JD9fi92Su+VzZTaHETNNuBKvO7J4p4py1It7k9fET8CeVZvrJxzDF6Y7R2K+Z9LKzLou
 F+oi8WBYzMX/a0S1GRF9GcGPDooXiX+O2xRCEHwKSdgsFnp1cw8ZP03y/vUmsL22BjdI
 X1ZbnSXX2Yj1oz9foJ9+6M4ih01e7Y16yadMQ02Oswa7J780P4PEYPg3yBYWQHFxetPb
 VkW3TZcG+tXYtDWaRLlNtTNsDOFWghWva57WMXj4FXL3T++dNdQXR34uWnhweBPTVFlE
 6AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ms2dMCxgzwYBAAxkHw1eJs6bOAGxrj5YZkd2zEbCOXQ=;
 b=tBmBWIbRHbgdjo8ohwJgbvHsZp0cU8TXLv2Zv7SURfDwJniFSLK7uCoRfEh9c9+qJz
 RQxJIHYHScC4ocNP2Wj2HshM4ZZlGLVHleQhRfM/wtx4XGJXOop2qptSXvDC1+JtBa/w
 JmuNas4pdwe8e5EMaBOdi9n1tErsElLj1LtivQ0Btq3LEhjoH4qQ+bDCSZOF4k8bCaFc
 Kfs4CC3fv+OFnGYg2JMaoWe5QSRiZVjLpV7RjTah+38sSHTjAmjdpOcyS7R1zjgTB/Xd
 k8kqhqbtMbuKUewumxctNuv8w7hsPxyEh91ZrIKyBqpZzJqgbZ7rQOrVs3cskAnuutQ1
 7ZHA==
X-Gm-Message-State: AGi0Pua7S8dUZzR5weu7w9HtUhYTjLBljAoL/2yPtGiOWxfd3j/cPluE
 XUIKuB37+JzOLMTstTmPETFI0A==
X-Google-Smtp-Source: APiQypJNmLvK4iyipxBJmzP4F97YnK1lDsj7DTdd9pcjHbzQYd0qRf1Yxf/Sgzrnk+f654Dk3c0HbA==
X-Received: by 2002:a63:575f:: with SMTP id h31mr21526361pgm.200.1587529072423; 
 Tue, 21 Apr 2020 21:17:52 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 135sm3986601pfx.58.2020.04.21.21.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 21:17:51 -0700 (PDT)
Subject: Re: [PATCH 5/6] target/arm/cpu: Update coding style to make
 checkpatch.pl happy
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200421131926.12116-1-philmd@redhat.com>
 <20200421131926.12116-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91d0d94b-8133-53da-ed67-7c5fede8da49@linaro.org>
Date: Tue, 21 Apr 2020 21:17:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421131926.12116-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 6:19 AM, Philippe Mathieu-Daudé wrote:
> We will move this code in the next commit. Clean it up
> first to avoid checkpatch.pl errors.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/arm/cpu.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

