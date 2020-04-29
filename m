Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E20C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17E220661
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4wek8El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17E220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrl4-0000Tp-TN
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTrcZ-0004vS-MR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTrcY-0005nv-Kd
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:39:47 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTrcY-0005nT-3Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:39:46 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a31so1105578pje.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=sT7xYNB/pNhcIuB1QH4lh70g3ycEbYWObZyq67d7YwU=;
 b=c4wek8El4w1AEgivaAGRfz3u6ScZoySujT/D5mkOnCJREBVg3sYDw8B2mZvjF3kdPO
 m55gWDBGu0bfrSi/vdC0GvrM1xDEi+Bi0pwDkkrbRsHehSjNIxIEePYTe8xnzNJ+1Us7
 nbzIWAzk4ytQX6p+DheI+wKmoPOTwnfHuJ4r2Hm33gV0zuVXlcu+wJYx/4D9jD8+C69A
 9g680g9CSDc4ENybsRatUe0fcuyZnGi/xKYkl3jgUf/JhNFl05nhTvLIGsABmvqu4TNY
 fTgvWGyE8UPs1C9E5kccaYdUlNRocUU64bDJe3DzTQSMKkImJpZpUeUGRgXUU3DkNS8e
 iN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sT7xYNB/pNhcIuB1QH4lh70g3ycEbYWObZyq67d7YwU=;
 b=acLv4do+c1sJipSwB6r62INacwgckM7axRQuPjFbSQ6WYNfOkwjGxeQtqakCBveVik
 PruYkq/BxGQD+CkCf1sydazh93gNBMRkZYGtZzhta4e+GlGNrSpJNLWBwf04vPlWENnp
 545f1mcmUeVOyfvcei5r6efnkAgWEkpWqBUKlWvPwIsnSa7RFQb2t1nisSfRZcI/VWms
 5UoRdgRQWV/Ri21gzoSIGkkoT9lPX0s7nYONsHbj5lCA0gr5EgQimVopJH4lBclEok17
 NAjh9CqPkonmV1yUZZt2AjFebnBJ4P7TtnoZL2udjXHn1dEe+i//fOWoa86/fYbYdCSS
 r9/A==
X-Gm-Message-State: AGi0PuZcMFXbLanNN710snr7PnfbtPZ9NRtCJAGOexxWGi+dF8pD0o3X
 0kizeZf+linG1ildZj5i04E88FZGqdE=
X-Google-Smtp-Source: APiQypKSw6ZBQlsS2IP4FdiZkKRDDHBhlCzl9JJo+SJuQLFSP5KL6WY12JkQLRCPuug/vjQmkvqm6w==
X-Received: by 2002:a17:902:207:: with SMTP id
 7mr34159461plc.331.1588185583675; 
 Wed, 29 Apr 2020 11:39:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b1sm1560094pfa.202.2020.04.29.11.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 11:39:42 -0700 (PDT)
Subject: Re: [PATCH 1/4] target/arm: Don't use a TLB for ARMMMUIdx_Stage2
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200330210400.11724-1-peter.maydell@linaro.org>
 <20200330210400.11724-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <771268c8-6971-e6ff-3970-ee911d1413af@linaro.org>
Date: Wed, 29 Apr 2020 11:39:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200330210400.11724-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1042
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

On 3/30/20 2:03 PM, Peter Maydell wrote:
> We define ARMMMUIdx_Stage2 as being an MMU index which uses a QEMU
> TLB.  However we never actually use the TLB -- all stage 2 lookups
> are done by direct calls to get_phys_addr_lpae() followed by a
> physical address load via address_space_ld*().
> 
> Remove Stage2 from the list of ARM MMU indexes which correspond to
> real core MMU indexes, and instead put it in the set of "NOTLB" ARM
> MMU indexes.
> 
> This allows us to drop NB_MMU_MODES to 11.  It also means we can
> safely add support for the ARMv8.3-TTS2UXN extension, which adds
> permission bits to the stage 2 descriptors which define execute
> permission separatel for EL0 and EL1; supporting that while keeping
> Stage2 in a QEMU TLB would require us to use separate TLBs for
> "Stage2 for an EL0 access" and "Stage2 for an EL1 access", which is a
> lot of extra complication given we aren't even using the QEMU TLB.
> 
> In the process of updating the comment on our MMU index use,
> fix a couple of other minor errors:
>  * NS EL2 EL2&0 was missing from the list in the comment
>  * some text hadn't been updated from when we bumped NB_MMU_MODES
>    above 8
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu-param.h |   2 +-
>  target/arm/cpu.h       |  21 +++++---
>  target/arm/helper.c    | 112 ++++-------------------------------------
>  3 files changed, 27 insertions(+), 108 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

