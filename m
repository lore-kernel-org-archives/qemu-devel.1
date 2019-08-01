Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F55C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173342087E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5pPLXaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173342087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htCVL-0004cV-D4
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 10:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59868)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htCTH-0003Um-8H
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htCTD-0002qV-OH
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:54:20 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htCTD-0002qC-IK
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:54:19 -0400
Received: by mail-pf1-x444.google.com with SMTP id 19so34213459pfa.4
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kFCjhxTGbOWf2krvGJS1xb2MF6IG5S6M3NB1ajDUNCc=;
 b=n5pPLXazZD5J2kcPrvnafq+64FPtcBc2hwo61s6TZOnmQ9xgR/rcZIiwiyk4Aa0wv/
 kOx0lbvhnoohcX5wsM09Fu7YlaEfpnnrfampJUArbXOyzKVUaNEF1da6GmlTiWO0y+74
 itR0tave+SBd+nrdI5CAeRArQZJf972zv03PnHA+mN3vTFeENTJ/YeBO48IROsfKqsJe
 nrP/eOnw9W8h6dUecmNpJA74RdyPPqmBXQmHZGLRPAA+MW8Bz+IyfQMgfR7VuQ0zLT7a
 j2XdxprwCcqW6N2Pc+6Fv2WR4h9H83l448AyhwIBlEO8E3889sWG7XRWGnWo8flTNTRA
 Lt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kFCjhxTGbOWf2krvGJS1xb2MF6IG5S6M3NB1ajDUNCc=;
 b=e55cPcBrUuYPlc0fwHt42swt70fZj2EzADqZalNTPBa59yvRrTQfxQhrj3FtyjUL0J
 ubiHjk71avSG7MtRh0bxvYGjktSW9dh+rhGJNBhiKJma5adgVCtMCSDX8wMAYPraPuyZ
 ReNaXPTM9I2g/N9XC3BCohctBLDf1imPLi1QTAHk8jXikLuaN8tZJ+EPeGjNBHKCxQji
 p9gQTWX1jcq0WnRGhf6oqeE83tPgdRhQWGlDVTZPs7x+07QI7DerIXnuk0XuKkrCM+AW
 p2WWL8RPZ7LY+3B+ScWzobxPMOtuuEeYjRYwjpObFRM1XGaB2wE7JiaCj+zfIuGpuxQ7
 TlRw==
X-Gm-Message-State: APjAAAX8vmerso3w4VvzmoQ1PdgrgbNEmQ0zGpIrioZW+10LTJXfkbtO
 68uN3/bKFjqaI7ijgfCNWKhwnA==
X-Google-Smtp-Source: APXvYqxV2vNZtkGVy8IpNx8jsQIUyv/VMIdKZjLqP3rGe3sE3Av3MZjBKtxl+uJHOjXYGozEzT/giQ==
X-Received: by 2002:a17:90a:db52:: with SMTP id
 u18mr9222461pjx.107.1564671258601; 
 Thu, 01 Aug 2019 07:54:18 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v18sm70594123pgl.87.2019.08.01.07.54.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 07:54:18 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bd476586-ad3f-06ec-58f5-8b6b441bb9cc@linaro.org>
Date: Thu, 1 Aug 2019 07:54:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v4 05/54] includes: remove stale
 [smp|max]_cpus externs
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
Cc: bobby.prani@gmail.com, cota@braap.org, aaron@os.amperecomputing.com,
 Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> Commit a5e0b3311 removed these in favour of querying machine
> properties. Remove the extern declarations as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Like Xu <like.xu@linux.intel.com>
> Message-Id: <20190711130546.18578-1-alex.bennee@linaro.org>
> ---
>  include/sysemu/sysemu.h | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

