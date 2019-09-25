Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30BCC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A254021D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcZ9hhKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A254021D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDD3v-0008C0-KJ
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCvh-0001KP-LI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCvg-0000A3-MH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:26:25 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCvc-00007n-FM
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:26:22 -0400
Received: by mail-pf1-x443.google.com with SMTP id 205so4256492pfw.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uKEROfpHrTB7CW9NKBeMtkk0xWVKZG9r3PnrMWDVpjw=;
 b=AcZ9hhKPvbN++H0obrNwR85mPWk+9BMyHyW/ibwl4FrekI1kewvZ13pZjx2GzkL660
 Sknfvud1rUa6otR3GMS+hPm8qWvOWYO3enmiaZjOj5i5Y6frGmvSEtm8L/qKWVOGQYSi
 j9CiR+WQoTk/XEequGOR9PaikILUJ4UHjq/T5wD0EDGQf8/w79k5BzKsOvQqZuvSqhCI
 aNvVoHxIwKPLVcuZhSEz1kh4KRnPZh5Z5e4hLRS079SKW91enlo/V71pjKU0g48J0gmm
 kLA2+03dKdlnOVSCip9C9xDWnpmZYhSlD08wf6x003jpmoKb3n/BwTehVor4q1UXQjGi
 wXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uKEROfpHrTB7CW9NKBeMtkk0xWVKZG9r3PnrMWDVpjw=;
 b=KEx1q+YSt+NkW0WFbuvTKHjUjreJHxmRwznXF/4t1btpxyM3qnpU3djKk2PmHz+BBq
 GXODbjG08fcFmXlGgM6MefMPfLCxtOjKup1V7qR3M90LRTIm2kZXeSjuNNO4T1vK4YU1
 jTxnBBf/gE/RVTWdTqFoItDDg90BVRbipfbiTLszfuD+pOno2E5xUcgSsAqbX3vwOdt2
 eT4WCrrQ15oehGMElaVpSDgCpT8L6YOst6aNm97M9Vv/GYNLj0coKn2rl5tRyEtyvrNH
 sds4r2PoPXWMn3BHQ2YvbVhtLJXCBcDaKCQFOzQnxT2hfUbwYT9GGiXbM5gpdy4yJDDj
 wh4g==
X-Gm-Message-State: APjAAAUKrAE0RJQawkOMfTI2rwPZOaXBazROXYGCta6hF0lh3MPE7CIn
 K4mKt2BZETFY8ZMz2U/icplEqA==
X-Google-Smtp-Source: APXvYqxQsFoPCjPGs4u7AceoHvgDGKshVr/Z0YCxlPIY0jWR7egsw+FLmWsoCFpMAX5xjzd4ToI0eQ==
X-Received: by 2002:a63:6b49:: with SMTP id g70mr936095pgc.92.1569439578095;
 Wed, 25 Sep 2019 12:26:18 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id t14sm353233pgb.33.2019.09.25.12.26.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Sep 2019 12:26:17 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] s390x/mmu: Use TARGET_PAGE_MASK in
 mmu_translate_pte()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190925125236.4043-1-david@redhat.com>
 <20190925125236.4043-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7e261e41-8b76-b93e-a0d5-fa269fc66124@linaro.org>
Date: Wed, 25 Sep 2019 12:26:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925125236.4043-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 5:52 AM, David Hildenbrand wrote:
> While ASCE_ORIGIN is not wrong, it is certainly confusing. We want a
> page frame address.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mmu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

