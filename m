Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8354C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9845320665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTR8P9ux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9845320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htcRE-00049a-SJ
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 14:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33326)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htcAL-00055b-8c
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htcAH-0007rJ-H7
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:20:31 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htcA9-0007fR-Bx
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:20:23 -0400
Received: by mail-pg1-x542.google.com with SMTP id w10so36461114pgj.7
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CEab7MRD4OmSqSGMXpwBnnpVmCxOKxwkGPRss1ZomKc=;
 b=RTR8P9ux6IXYHU5wLo6HuiAaeb9PWkfAta+qQrd6QDk6wGsP8brtoEAa3yk9ZEbYeZ
 OuXzBJNiKr07fRt7aNmC3iJrWjxlQg/u7LgrQvk8tP/zrDrlvNianQFf0qALKiv1dk4v
 /FuPf9sT0XfJd2EI16cESn4Bbz7pOiDNF6oV4CdEu3376QRiE7ZiSLddWe1pX/kWXqJL
 khL0JUaNPNCUYzPggjYbr58NVmn5nF8KwQGre3f1YuWPLxRcxXLoHX2uCeL2W6Hcxt3n
 SSl5ht1Al00os0AgAoPwj8CguVim9e53ac22Oqvgd2b14/kC2N/orfwH5dPEvarKT+oa
 goiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CEab7MRD4OmSqSGMXpwBnnpVmCxOKxwkGPRss1ZomKc=;
 b=uTrYbzgcvsVI/Zu1B0i430HgULrEmtiVWqxZm5bpAKt7We7UJoixGRr9sVilNkIr3J
 iPMpCUglOUROPM3Vzdb5qfm7qHAvrOzsAthTsx5OVK1+yaOtWuQrVduTlj/9bNEqBIwB
 mPvuhQckjq1vYyY88ULQ9RQBbfvEdgTn1UKVqNnJxRLwqNSJWsqFHJudxMiYnk2jlnSL
 6mbk8vQgwQ9g0dec4KH1lNK0bRTOe7Fblv/Wz5iDRDa4Zf5uRTCrfuwbUnREHmrhLO1D
 hAqcmEzizEgbrQcRNGkCxmjwtSg/fDFAYD1sGPW6p5fPBkzOoUkBLcKvmS7n4QScyZ+U
 2Fig==
X-Gm-Message-State: APjAAAXJDJDfhsK3KulqWBsokbxQpSrlqfYeB7oGXddmmmcdrHWxC++r
 fZ4Q6zKUBYgpVw8rjyY+aIM1GQ==
X-Google-Smtp-Source: APXvYqzUbxhtJiSkF6cOoK2u7Az6Knj8kqLQx0pjBFs2ekefIcHESdT9SlD6aqVOBWeLuAHH0gogpA==
X-Received: by 2002:aa7:8817:: with SMTP id c23mr61774976pfo.146.1564770004672; 
 Fri, 02 Aug 2019 11:20:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q23sm6288041pgb.68.2019.08.02.11.20.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 11:20:04 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-13-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <34039f42-3810-0149-4575-a03509c84884@linaro.org>
Date: Fri, 2 Aug 2019 11:20:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802122540.26385-13-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v3 12/15] target/arm/kvm64: max cpu: Enable
 SVE when available
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/2/19 5:25 AM, Andrew Jones wrote:
> Enable SVE in the KVM guest when the 'max' cpu type is configured
> and KVM supports it. KVM SVE requires use of the new finalize
> vcpu ioctl, so we add that now too. For starters SVE can only be
> turned on or off, getting all vector lengths the host CPU supports
> when on. We'll add the other SVE CPU properties in later patches.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu64.c       | 17 ++++++++++++++---
>  target/arm/kvm.c         |  5 +++++
>  target/arm/kvm64.c       | 20 +++++++++++++++++++-
>  target/arm/kvm_arm.h     | 27 +++++++++++++++++++++++++++
>  tests/arm-cpu-features.c |  1 +
>  5 files changed, 66 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

