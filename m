Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E1AC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C500214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yl4pqh5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C500214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJiq-0007KH-DR
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 16:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJhe-0006bh-31
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJhc-0003uZ-Sc
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:03:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAJhc-0003u1-MB
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:03:56 -0400
Received: by mail-pf1-x442.google.com with SMTP id a2so2763375pfo.10
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+df72MlPh/bsle/Hkjaka4ATZ0XmeOHlFzSrh5/Q1Z8=;
 b=Yl4pqh5+aj8gByBvBJgR1Ak7vhrflWGlM1d56tLyFa20W6zF5DvN/dC5UpaitbOQL1
 Z5h5ILCi5BFSLO8Aau95Thnx6+UsvdeibvYMKAhiRem8OPkR3/BapJnhxrQW9s7F34u/
 aBelwdcLUON8HH4VGPrrPS/GWmDnn1dT2tIE2uu3p2L4/aMnOoDnxMvmZrnogv/Tewz1
 gAvYPras27tXkvmcYPSfgREQWLu38vxhERIwSy4ouOiHbHFhMITghX4E914YBN7yfTnZ
 S2Sdis2evbhxjQFg8eeh5q4QTKVqedFftk1FTQN9POSMZQLTDwizHlWe2D4coTgMZdqh
 gA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+df72MlPh/bsle/Hkjaka4ATZ0XmeOHlFzSrh5/Q1Z8=;
 b=ZaVAxP+zmTWBpQVBUnlMAitQcD0bs46V/A77AL4F1HQmU5nGIBgCOoBwqQv6SetzIu
 UAPUx6QMOFrvtiWYmEDXJAARQ7YtbVGzxaT7smsVbCqvVluhQX/glML8sOkp2G25iDVh
 c9VesZrDLb/q3yXRIPWJATZJ4oZmbwM89i5Ib7tQ7kxhNnvr3vNXJhQmvQOf9R6cH3i/
 bIRlo201k5zr0BePQYCF3UMbZQEUz4A0pHRcyYLXuWRcUc/iN0wi9EQaxcTzJKmJMax6
 +mZqHzf9kCd8tyPkkA2eSXGH9xoVmjkcGnriFcsZXIJMJk07JY3l0QTUpSScZb26Ft9E
 Y8OA==
X-Gm-Message-State: APjAAAUaTqNnTvvwESAM1E+XowXTK1IeebRBROqgUXokdkm5AzMwiLCa
 qbHdsKpQo62iQbkHXLcujwWKTA==
X-Google-Smtp-Source: APXvYqwm6aqnwWeSLFQrmSOoQ2ElljMYS6TA6LE54kdyaoIUvfEklHy6oqw+ZOl51c5V8lMZaGWrsQ==
X-Received: by 2002:a63:114b:: with SMTP id 11mr605647pgr.42.1568750635363;
 Tue, 17 Sep 2019 13:03:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q71sm5026045pjb.26.2019.09.17.13.03.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 13:03:54 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190916135806.1269-1-david@redhat.com>
 <20190916135806.1269-12-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d675607d-e44a-53c4-11b8-042dcbe95bbc@linaro.org>
Date: Tue, 17 Sep 2019 13:03:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916135806.1269-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 11/29] s390x/tcg: MVCOS: Lengths are 32
 bit in 24/31-bit mode
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
 =?UTF-8?Q?Dan_Hor=c3=a1k?= <dan@danny.cz>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Cole Robinson <crobinso@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 9:57 AM, David Hildenbrand wrote:
> Triggered by a review comment from Richard, also MVCOS has a 32-bit
> length in 24/31-bit addressing mode. Add a new helper.
> 
> Rename wrap_length() to wrap_length31().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

