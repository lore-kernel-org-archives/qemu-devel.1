Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025FAC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF019206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdI1M6Ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF019206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictUL-0002GS-SU
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ictQG-0006if-MX
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ictQC-0002tF-Pl
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:52:06 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ictQA-0002rS-OU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:52:03 -0500
Received: by mail-pl1-x642.google.com with SMTP id g6so1407437plp.7
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 07:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vp6IECNYbmFMZhSe3qFoSRQMt7kWAPycvZCpZa2VjJ0=;
 b=wdI1M6NegcTAg3H+hjHE6mNVAT/0kOe0Xstw2CcPrvrKEi8WJtdOGYYTv8nrGM6i4f
 fVrQjYb+w8/W8DxS6OutYtWCXN4X1S2LEJgZeZtft3SdfkdF2WCx4A7V8crmvw3Q9y3c
 oSA01O0E0PxJUrP23zBT9Z/fCOr1wSzkq7WRe2xHPoBiQE77+nS9JC3f5Kp1GKpGQPxz
 vKI66uajE8War3odBc8lQ1OAlNoYmt8u0ETUV6j1xZpOp1cTVBYcFh8m5KpWsbQ6fyVb
 2XdYns3j1/GY967In/I1rckQDCF7WScF21eY21gs+xE5Gn3jo8rVkqhBaV/ULQsRfHyz
 bBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vp6IECNYbmFMZhSe3qFoSRQMt7kWAPycvZCpZa2VjJ0=;
 b=MiTgHOnHcnyyaJBwVzjcveJMcs8MjV9fd83hE7AxsD1Z+UyAsoePc1u2/Es3Ayti1f
 RwIM3ItsZ9tLTFrkeqMojYwXzuNS7YRZzC+/Pbo8wtIgJp5bpbLSfqjUcQ+1Vb5zKxb4
 0QWBSRpbhcq+e0eo+qioOvOBXWgjqS7dpJqrherLJrj783z+UMKyw9ndLVTJktId4+mN
 KL7CW2gxh9RD6ifGAwUEjz3/2zMvUsi2Rf0FsQug+9yb1uqj3BVu4c1gYdMTm2opACiZ
 IBed8ikyzhHXta/xCFHSvQGpZKe7Nk934xknaP7ekxKE0yGgqhTIcneT6pfPrbIU6kGJ
 1QZw==
X-Gm-Message-State: APjAAAUq9nlrtPL30BWJd36Xl3KinZD4eg5XtOhbv0guKtWoiJZeOSQn
 qQpzle+i5UuM2vK8l6GiunRC/TY3kUI=
X-Google-Smtp-Source: APXvYqzmQRAq0itw3C57TEJ40rRWUSczMIwUo39mm5GC8I53h0TLySa9vEhU5/bJt5syclDtye++2w==
X-Received: by 2002:a17:90a:d145:: with SMTP id
 t5mr10235973pjw.57.1575561120500; 
 Thu, 05 Dec 2019 07:52:00 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e5sm137084pjv.29.2019.12.05.07.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 07:51:59 -0800 (PST)
Subject: Re: [PATCH v2 2/6] linux-user: convert target_mmap debug to tracepoint
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191205122518.10010-1-alex.bennee@linaro.org>
 <20191205122518.10010-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b4279ae3-682e-45a2-130e-d7eaf3f2b398@linaro.org>
Date: Thu, 5 Dec 2019 07:44:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205122518.10010-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 4:25 AM, Alex Bennée wrote:
> It is a pain to re-compile when you need to debug and tracepoints are
> a fairly low impact way to instrument QEMU.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/mmap.c       | 27 +--------------------------
>  linux-user/trace-events |  1 +
>  2 files changed, 2 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

