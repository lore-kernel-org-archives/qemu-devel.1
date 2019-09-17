Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0993C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8837920862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzz1NopZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8837920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAK2k-0000RT-Oq
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 16:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAK22-0008Kq-RS
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAK21-0001cr-Pi
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:25:02 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAK21-0001cD-Iw
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:25:01 -0400
Received: by mail-pl1-x642.google.com with SMTP id b10so2020449plr.4
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2Tj5y1Kgcq7PEN5YiuLXVKuDyF8gc6MEkkwcJvlIpy4=;
 b=mzz1NopZWPA1RB/E1HMVaI0cxYo0bQjjPZuDLLMyn9gEt22+IOFKjCvGxocc4h2xuy
 wX7mn4XRelvkt8dbm2TdrJ3CI3DVPbW60czwK+/91HIxogf4TJhs2OtSK5MKoOL8mo3K
 qq+7NT+arrgFlef/VDe4E7fhaU82m1wLCPn5AXmiOBXFjbbwj2qlAFqoDxystupdTxFK
 RmiwS6xEqjAy/q+2I7csgweRw+6zjdKjIojuBLS0Q0vT5Vo9I6l0sdMmORFYaP0NKbvd
 gap2RQ/V8iNlFPp1CXprnoMkKW34F1cctQEygWQDSHMu6m1MAe9OYcGIX6wdGkdn8w/G
 /8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2Tj5y1Kgcq7PEN5YiuLXVKuDyF8gc6MEkkwcJvlIpy4=;
 b=BD+3WQe/gasSjWz9rIPSSi9DS1ljYvOWGFiweXgOfCASwGqGVyw3VaKQ9xBSd+wxSl
 usKhbXtTJwteQefp+pT9tDJ/P9TiKHtEou/uq966mSlHTZ4NPDvaYZuoDJ4fbS+isPca
 u9ceQkowf2crb5rgi2GVGA/1merS0B2blGQrJF9WoBitiRgrpefuuoK+Z61Sj11aa16b
 RYT42qOzqQ3pJzTrer4qOcI76a//KWgS4679QNYN8+LmQUKz4OMzFzTOF0q21kus4hrF
 T1JK3TDY4X4StoL9azaI8Pp8mKYaQGmdDBWQKmJ4ZxaarajI/0p5m5lgC0QUF4VUo31K
 0J9g==
X-Gm-Message-State: APjAAAVhgvC9LlvsAHwTUhpphib1iqYJjdwFOnLdDamg3u76tGUzvByw
 eGUXyhuMew7kjjMSzyGkx9c38A==
X-Google-Smtp-Source: APXvYqwqRgK53uj//+T3Dux9NwIELCtwJ6TfJZscn59u++AUFzZTEuPpuaoFxoTWDCA9A+uuLTnXDw==
X-Received: by 2002:a17:902:7282:: with SMTP id d2mr559034pll.88.1568751900519; 
 Tue, 17 Sep 2019 13:25:00 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d10sm6083880pfn.50.2019.09.17.13.24.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 13:24:59 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190916135806.1269-1-david@redhat.com>
 <20190916135806.1269-30-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <96078e8e-e6d7-1a20-b875-5390e02befcb@linaro.org>
Date: Tue, 17 Sep 2019 13:24:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916135806.1269-30-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v3 29/29] tests/tcg: target/s390x: Test MVO
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

On 9/16/19 9:58 AM, David Hildenbrand wrote:
> Let's add the simple test based on the example from the PoP.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tests/tcg/s390x/Makefile.target |  1 +
>  tests/tcg/s390x/mvo.c           | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 tests/tcg/s390x/mvo.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

