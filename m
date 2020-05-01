Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C27C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 04:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504F72073E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 04:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKZidy7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504F72073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUMzl-0007Ts-Ge
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 00:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMz9-0006hr-1U
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMz7-0005EO-HR
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:09:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUMz7-0005A5-1I
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:09:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id 145so1070738pfw.13
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 21:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Hh8nHTJ6UzCPx2NiIk0I2VjvMuRz5RX364GJS4ow66s=;
 b=kKZidy7p8Q7REp2L9SF8KK9nEgscOjt7PlMmNmXky6pewdduSSnhVQ6YnXvyYQmG4Z
 +iQtLXzHsbRd7pyDq9JcDJxFtNePym0rPyONfdW7UI4yZpI6wR8WPl8/fXFojcBicgt/
 84ZBOK1cToTez2OXnQOB/7YIGbwySbr2V7H5wXhu/LoWXRDCqWoHAzgvCcglZzcldF7L
 JMlPuACy7eoq+QzrlUL3KNU6wJCcb/uHtcSnLpYernJWrF67A5C6Yf1N2ebv+8ByBJu0
 JKclPA/1aU0aCuld3VEKqzp/Xx/MKkTP4mUpey00X1X1yK0Ewl0kIOeTmXPx8OhYD6c3
 2OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hh8nHTJ6UzCPx2NiIk0I2VjvMuRz5RX364GJS4ow66s=;
 b=nE2Cu/jkL2TsUHeWNNKu/xRCgwnr58m4sYlK5fe21d8uIhbQPP50ck/6imWl8g9BCs
 FF1xh0syR0N2A5HKSg/kGwJh/CwAJ2B0EMEFKpaYDhWb409ZQ91DbrzysanirHajJTnv
 AOZ6pmF/IcN9alBrKHEfOZrcgufdPTmErgubpqERCTl1BcqfnGtBqKm+6keu7M/PBL4n
 krXkQ2bXeLOqR3KaLeAZUm7EkyvEObodCXMA+jHJ6tvE3soyceLzck26VkraZxXitWpj
 3cL0qDoidaRMZ+QlnkQR54WIPYLRstOSyfIr07KPwyuFULQC/iBNqAuDF8Hn/4g5AP8S
 kWSQ==
X-Gm-Message-State: AGi0PuaY3zEfgSKJB3QatMSqJCkogKvkTRm+NzTgWu2DuMjHRPRj1fvZ
 6N5JsbiUEPuEwMg36seoza9Pe7dUsdk=
X-Google-Smtp-Source: APiQypK4MUAAs52FU8/hu4oMnBTDJ2CYKzJHryM+pTyVYEF5VpEbsezUI9Rp8RIl8x3Y5s7QGkR9yQ==
X-Received: by 2002:a63:1361:: with SMTP id 33mr2224598pgt.265.1588306147006; 
 Thu, 30 Apr 2020 21:09:07 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id c4sm161776pga.73.2020.04.30.21.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 21:09:06 -0700 (PDT)
Subject: Re: [PATCH 34/36] target/arm: Convert Neon 3-reg-same compare insns
 to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-35-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <318ea83f-1d2b-e79a-d8e4-385f0ce8084b@linaro.org>
Date: Thu, 30 Apr 2020 21:09:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-35-peter.maydell@linaro.org>
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

On 4/30/20 11:10 AM, Peter Maydell wrote:
> Convert the Neon integer 3-reg-same compare insns VCGE, VCGT,
> VCEQ, VACGE and VACGT to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c |  5 +++++
>  target/arm/translate.c          | 39 ++-------------------------------
>  target/arm/neon-dp.decode       |  5 +++++
>  3 files changed, 12 insertions(+), 37 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

