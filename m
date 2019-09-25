Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE518C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB05320640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDHemyV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB05320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCu2-0007eD-Gr
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCh5-0002uC-UT
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCh4-0003Hv-Gp
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:11:19 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCh4-0003GR-5y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:11:18 -0400
Received: by mail-pf1-x444.google.com with SMTP id y72so4189285pfb.12
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NrvxIoSZn3iMFt31BLl6sHkqT+brRn0cyDIE8O5hTfw=;
 b=FDHemyV9zLl5qt8I2JekJmxnvhLsF1kTXcHs2Cjhw/GpUBn3U2JuowWXu6APb055G/
 zdm71fX1Rd1qDKR18elalNQALTkWYAPzw0nx037nwALO5tbujLqLdMLbBu4eSsJFAoTU
 P0X7XWFq/31d3PDtDbl5P+PonlLnFXpIQhiC2uGIDOzCEovZ9dHsF/fl3rR3nPtBPb2Z
 bOi57C86q/ko4rDHojUqgImoUyoeX6rxsl4bEim1oSb4YIwWtdEpJlYHIqFBlm/DmJcL
 yyaKagP0mipaC6zhvZQ+6RacBLKjT04kfStZx61VIvpfVtkCYrJYVgiFhVHlzRBaPZVT
 ii4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NrvxIoSZn3iMFt31BLl6sHkqT+brRn0cyDIE8O5hTfw=;
 b=oIN7DXRyYjY00PI6fzZy3fpb/6o4dgtJwxz4z0GBUp0a1IBrdZawRESujiSxZw4zP1
 YTAX2FFf4Ihd/zL7F5cjh8EZ12/OGXPnMbfNiuJbSNIl+hD900KAg/x3KQIbuFaNnlF8
 s9p0HSBRYMaz4ihE6tGk4GBTZhrd/WKJ2pF5z0uKbkmPZlHpb+r2dLpSXIz4LwGg3wUo
 njRUPPMU5Z10RNCKDoNOiKVd2B/dbFUw0PfXcKvjWERDzAiI3Rh7QwyarI6g9d+vyO6X
 aFvH586yv98i53nTFXqYaPghJsKO+4lqaFx6Srv4YfifCz37WYUOc8d0hktxnAfb9q4s
 +LHA==
X-Gm-Message-State: APjAAAW8avQF+BBegC5CGB8AdZdYuvOoJsd0TEhFE8c4VG9Dsuxwqn1a
 6v2vNyyxJR7jgUh30ImHPKVOnw==
X-Google-Smtp-Source: APXvYqzQXy77sdotChwbxx0B6O/efaZZhfdlyMOXn7UPyy6LdgGYbq1grdjd4qSV+DJCuCN4A6r5Ew==
X-Received: by 2002:a17:90a:f0d7:: with SMTP id
 fa23mr8029709pjb.120.1569438676272; 
 Wed, 25 Sep 2019 12:11:16 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id y2sm9013380pfe.126.2019.09.25.12.11.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Sep 2019 12:11:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] s390x/mmu: Drop debug logging from MMU code
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190925125236.4043-1-david@redhat.com>
 <20190925125236.4043-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <402c6cb2-2601-2443-4a6c-3f86bd7ffcea@linaro.org>
Date: Wed, 25 Sep 2019 12:11:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925125236.4043-2-david@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 5:52 AM, David Hildenbrand wrote:
> Let's get it out of the way to make some further refactorings easier.
> Personally, I've never used these debug statements at all. And if I had
> to debug issue, I used plain GDB instead (debug prints are just way too
> much noise in the MMU). We might want to introduce tracing at some point
> instead, so we can able selected events on demand.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mmu_helper.c | 51 ---------------------------------------
>  1 file changed, 51 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


