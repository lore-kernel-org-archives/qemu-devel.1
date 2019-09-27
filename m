Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B975C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 18:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E985820872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 18:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sc2N7zAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E985820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDucF-0000o0-Db
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 14:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDuXg-0006Fw-2N
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 14:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDuXe-0003yA-Sk
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 14:00:31 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDuXe-0003wF-Gh
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 14:00:30 -0400
Received: by mail-pl1-x642.google.com with SMTP id t10so1380666plr.8
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=O6eEfUq+3wwkD74HvPQH+3Iq3EP/79LUTvcU7bH7HK8=;
 b=sc2N7zAY6pdy52m3sz/Ih8QgaobupX/5fj+bvSk40nVTRHlZhMpoYgT2n2NzyLldiR
 ognRG1rBRSp1dTrlNuc5dFgRE5FSCTXUDxsM7D3WmRlLht6u59XSqKq+pcF2aTM99GTC
 Z91gbOlMdi7AF/UpFxUrknbH8y8daClXSyNcGDooKPjXwxkvTZoyM2hSRBYEVhBactTB
 myZZ+fM9HwZxpyYugMSqqRrkrX2RR+P5e54qPv5CnejiL9m+kqpelMVMe1+xMd3YQYQd
 cdpkQ968rAqNeKrUaRI77kp0bfwcJBSmiIra3flqGaLFH2BVXNspQaAh51Fl8XdI7H0W
 7CFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O6eEfUq+3wwkD74HvPQH+3Iq3EP/79LUTvcU7bH7HK8=;
 b=SDZbppjnFALHLDR/Q928Ms4eHupHrAUTqy1r6597Eq8zq3oLtD30lkftsLUZ1/O2Cs
 CXlB6dbbfj1ahx9EmdSlr1rYFShOjYrnj1FMUiLFxI+B6qZpIx5lSbpvQXpCQ1r8iP50
 Qt8jteG89ps2JHQYj5EHGCDq2DbjIpN4bBHGo9t0WoUyuBJnRCRmp6Q98MJnUJVXyqyx
 Xc0/vOnj0IVTKOj0YVjvoMJBn4mUMLnNURVbg/CO81QFMt/gSYEC+4olQBX6ZWi7ah9t
 dspkHqoX0BGp/QLpVfw763FuvR9va3FxyiYrHtr2jZmBd1x9Iu03DZpJ8XysZIv8seHC
 kI4w==
X-Gm-Message-State: APjAAAUQjkgKU5uPB+wvGsUGbbRVbk3gTUAXPp3r+S628PCj1r0SqG6r
 sUEQJOVTyl3Z4xDHHPJRIWJIug==
X-Google-Smtp-Source: APXvYqxwDVvvWdTi4xPsYgWaNFpnIrnJwEaL6slsD8mT53nDfNUi77n6coJO7ydgpPKgTGlhkEk1Ww==
X-Received: by 2002:a17:902:bb84:: with SMTP id
 m4mr6306729pls.10.1569607229532; 
 Fri, 27 Sep 2019 11:00:29 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.118])
 by smtp.gmail.com with ESMTPSA id 8sm5861788pgd.87.2019.09.27.11.00.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Sep 2019 11:00:28 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] s390x/mmu: Convert to non-recursive page table walk
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190927095831.23543-1-david@redhat.com>
 <20190927095831.23543-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3540591d-8033-2596-812e-2a4fc0b67518@linaro.org>
Date: Fri, 27 Sep 2019 11:00:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927095831.23543-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 2:58 AM, David Hildenbrand wrote:
> A non-recursive implementation allows to make better use of the
> branch predictor, avoids function calls, and makes the implementation of
> new features only for a subset of region table levels easier.
> 
> We can now directly compare our implementation to the KVM gaccess
> implementation in arch/s390/kvm/gaccess.c:guest_translate().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mmu_helper.c | 212 ++++++++++++++++++++------------------
>  1 file changed, 112 insertions(+), 100 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

