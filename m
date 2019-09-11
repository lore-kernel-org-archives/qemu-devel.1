Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75EBC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8306C2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kbb6vkNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8306C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84dQ-0002MB-B3
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i84EV-0007Gq-GV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i84EU-0007bf-68
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:08:35 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i84EI-0007Y1-Dt
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:08:22 -0400
Received: by mail-qk1-x742.google.com with SMTP id p10so3120565qkg.8
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V0wS7vDOtwQ0JAEDg5cRNhWhvCAfAAPTKn6GNzVSIok=;
 b=Kbb6vkNox1jabB++/XN9knaTci9j9D0viNK+opJYVa7eCtKT+oXaemwANDdKFpwmQD
 Ea2/uPtShFBzDP8LxFRHhXTsTFAd+4DDlUmdUArNf1tN3rBVvs7XRSYIHXbeR8UmKhJN
 L0Madn6/SlMaVARmEGx+H2RNrfUuy9xFytF3avUENpVhFCi6nkjpPxZWp8T+54SOgmYU
 +YFGHiyHyv2k4PsVjSsz9m6FAwh2cmFCp/BcWSU2NvGSL4n7nv76cuhRI51ip/EPyhw8
 icIAMagw0F+XAOtf696OVCvZDFytUJt0oZHQkK0QMQ36GtCp9c6D8PVoKx6XKR0IVgIf
 O+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V0wS7vDOtwQ0JAEDg5cRNhWhvCAfAAPTKn6GNzVSIok=;
 b=N/1oqGU5IOxnnIjboLusdymQfKgLKgOhaqOqhydPSvklg3QeuiB9FPiGHsftnw0j4w
 M+rlVtrvwaGi2Vz/lI/TNkM0BDzhQnKX25Olb//sYX7Ae27EmqLP5O+jhztbAwmzupk4
 bwDsLQWgK7f4+t3XuNIh5JqIS6tHnT0uW/Bj4WVmjhAj/kd/LdPxNrn32NAoDAfFO206
 VwnPfMionPz5JOnLyShBxDFGmXpunyPanAUQk3seu6H6YQkTHN6Hdv/9fBK+ScTAflaA
 Z2I+H41QEhbg/iyBv+fsaCiW9YWwHSu9BSzzZe464wYU2KSM/ivVr77PbIPZoNOvJtKX
 U3GQ==
X-Gm-Message-State: APjAAAXpu8j1tbxJ5Zy+dLtfkvqkIpUVKBgOM1OHubebT2an1Xor+JJd
 YGgYjX2o95qk2Md/sEU1aAJXJA==
X-Google-Smtp-Source: APXvYqwlBax0NrvaYR5eoiH4YRnsackPTw9d5FvUD4qSzhWJXS81hNM1P0QnRDAXkBZgrm90wLvZKQ==
X-Received: by 2002:ae9:f305:: with SMTP id p5mr34192873qkg.439.1568214500792; 
 Wed, 11 Sep 2019 08:08:20 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id a11sm10747107qkc.123.2019.09.11.08.08.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 08:08:20 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-11-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <de1d26a8-0d4b-cfa9-bb6e-3f6c3ae03a05@linaro.org>
Date: Wed, 11 Sep 2019 11:08:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: Re: [Qemu-devel] [PATCH v2 10/28] s390x/tcg: MVCS/MVCP: Check for
 special operation exceptions
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> Let's perform the documented checks.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


