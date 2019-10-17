Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9712FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D212054F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eX1uVHA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D212054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5pW-0005fS-8g
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL5c9-0006B8-P1
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL5c8-0004DY-Hj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:14:49 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL5c8-0004D6-84
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:14:48 -0400
Received: by mail-pf1-x444.google.com with SMTP id q21so1630566pfn.11
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dn83gHvM3nMKtNzlv0os0mKG52vDYd0vFTRLtSbc8tY=;
 b=eX1uVHA3jaBmqXzes+jfqXB1FC4NWiKJBWtmFAMMR68MX91YL8CiAkvwTMCa0mQ1hD
 XENqOIE31JJotyXM29b75WUn4Mz3oYtDxDqL5MAOo0a/fYb2mH41vPqLY8sho/NeYbMH
 zAX2zbQ+FXpweerkRbROJEPxh+9/N/i3yzyKKE1W6UCl/iQ8kedhDMrhB1dXMZP6yeTx
 xuROqi1F7Y84zwFdXcQNGgG0jPDBc7lhNuz6+mZ1HxUcNfPjRVa0I5hA2GDCrHzIKED2
 DauPeq5eDaYZWW6EYmmXVDmVQgcncZvTMhALVJA1JKFPL0cB9g4IyRyIOOt1PzqqaBe7
 GQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dn83gHvM3nMKtNzlv0os0mKG52vDYd0vFTRLtSbc8tY=;
 b=MPEJ96j0wllLHEfbfWbcMJHSRXMOldiQpxWbxnFVGZadOh+i2teYyHgtLtOIU755MP
 5yLyIOQeD90wRKlIa+Da4o44TbgoHAX04Bcqt/xTqcOgNLBL2Sx3ljKSixQh4x6LexmV
 HoB6zqG7/NHeokUFvb2ajvkT1ewK9jPvhfftfg2p/bcaXUKMCdwBTOGpbenmxBfx9ln7
 4gB3Fvymz/R+2t5R9rKE2HbX/jVpLY02Q+M0nsc1P+286FjO8hsxukw0/U4aCfo/fu3Z
 OZsP8oOZfUug8ZgIgtWGC0E48a7GqNQIv5BL4qNSMPxVgT6aYen52khoo8sXRjLRZhNw
 pVgQ==
X-Gm-Message-State: APjAAAXhK7olCDVyGHeqkLG5lOYgBusQBGUtNiHnhPyrKolZJdGGiCDI
 xCKaIBeQVHRg+ekSpBj+Tgkntw==
X-Google-Smtp-Source: APXvYqyFVBKLN8ssbY651iHm6ykYQ+Fy9wy5/LzkKzwysXMTmg0UQkF75k3M0uWYf2EHSUc5jp2mUw==
X-Received: by 2002:a17:90a:7142:: with SMTP id
 g2mr4338757pjs.36.1571318086812; 
 Thu, 17 Oct 2019 06:14:46 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id j126sm2804360pfb.186.2019.10.17.06.14.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 06:14:46 -0700 (PDT)
Subject: Re: [PATCH v1] s390x/mmu: Remove duplicate check for MMU_DATA_STORE
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191017121922.18840-1-david@redhat.com>
 <5ad7023f-310b-eb7b-2e2e-b5cab073bb61@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <eed4302e-e84e-7e04-df41-62870263a985@linaro.org>
Date: Thu, 17 Oct 2019 06:14:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5ad7023f-310b-eb7b-2e2e-b5cab073bb61@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 5:20 AM, David Hildenbrand wrote:
> On 17.10.19 14:19, David Hildenbrand wrote:
>> No need to double-check if we have a write.
>>
>> Found by Coverity (CID: 1381016).
> 
> Copy and past error, it's 1406404.
> 
>>
>> Fixes: 31b59419069e ("target/s390x: Return exception from mmu_translate_real")
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

