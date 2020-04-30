Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0034C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3D52054F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1xyF7qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3D52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEaR-00060u-Hj
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUERM-0006Sh-I6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUERL-0003EQ-6C
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:44 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUERK-0003DP-N2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:42 -0400
Received: by mail-pf1-x443.google.com with SMTP id r14so293837pfg.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=W2LvCywvrLt5PdfgutWQGzZb+F5g9vTbkhLOkEDmYYE=;
 b=C1xyF7qgf6b13SwtILCZ396ARWspluKMAfYaoES9Y+TNYCXjw0Hd04pnRYywqw+SVl
 zLlzY4XiXc4/mfE4CtgsVDI9FS4+YF4rn6BFi7XG5JNgHaf43PdnjBVGTNN7MAT8AAnO
 VeYhiFKOXEE76Y1uBeLm/Zv4jyYxdetEvQghRUH2JD5HMk7UFvnyz/l/n3G1jJ4BCT1P
 ShStKNnyGWq4dE/LNGjX4RkFrqZK0TPVPKwKGmQWb+Se0wcqJNRn/oP7nQzbY/BZv0up
 tkrXcfkMhCr7DPOn2svXlXlEAQgSqKU/GXnM/DNZqmLULAxzvMwgdzWzpgwix+mcds35
 GiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W2LvCywvrLt5PdfgutWQGzZb+F5g9vTbkhLOkEDmYYE=;
 b=bjQBAHzfyRJC1ayOnjQNnXChE5N2ZuaTrmf/P0FyjgFVtKaPzPBxdCijiJzxdenOcC
 paGtLM3CkJuPxlUQlIdUdqwitESV3S7uKEeHobjbxCwICmJUarDIsIwVHi/huUKL4qIt
 q8ax8hu8GYOQLG+2XkQvfF60VMonm996yIpJEwH9gJ47l7q8iiU9rxbZ3QTUoi32d1tz
 9a+H6fIVM2DgXmSm9XPnWe+l9zyB8FT5HEFaBK99jvKSotMHXf1z80dW9K2LuOb0PJiU
 Gprr/8Sp+m0I2nROh2Bl88EwVUBTC2V3wqAKwe+hf2OjCOPN5amhbCpaWvknv0+o8nAj
 pLJQ==
X-Gm-Message-State: AGi0PubZKFgkvv3FBfwxvkWFp+e0IbYsfH9+KXyhBFobl2lTUQzYQPbI
 3sQrOtaN0qhYzPekLBzV9jh6zgvtYP8=
X-Google-Smtp-Source: APiQypLi+SwV/xLcLQQpVgrQ9POiPff/fmjHVPsZWpJcLDP/gaYuHUIbNhSyzkrr9JY9nR6JI+pMng==
X-Received: by 2002:a63:cf02:: with SMTP id j2mr405039pgg.130.1588273300023;
 Thu, 30 Apr 2020 12:01:40 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id c10sm469803pfm.50.2020.04.30.12.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 12:01:38 -0700 (PDT)
Subject: Re: [PATCH 09/36] target/arm: Convert V[US]DOT (scalar) to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1031894b-486a-a38d-25b2-9888d75d5471@linaro.org>
Date: Thu, 30 Apr 2020 12:01:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::443
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
> Convert the V[US]DOT (scalar) insns in the 2reg-scalar-ext group
> to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 35 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 13 +-----------
>  target/arm/neon-shared.decode   |  3 +++
>  3 files changed, 39 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

