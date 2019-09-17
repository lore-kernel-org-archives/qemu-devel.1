Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDCFC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D4820862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIDQWDZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D4820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJz2-00077J-Bh
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 16:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJxh-00061l-Np
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJxf-0006Xp-Mv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:20:33 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAJxf-0006WF-CQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:20:31 -0400
Received: by mail-pf1-x442.google.com with SMTP id x127so2795076pfb.7
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r1ig+4y8qG02/Avrzw7uN/b0j7nz34s9Meh7FXM/D68=;
 b=kIDQWDZoJZmHJ0RVBXM43YSFqwTKe+N4ZuRhOGjfVoQFrac1vl09juKd8TsYppkUQf
 rATu1bVqPB8vu+UXW4BheqQedpMRHs47RX/EK3Oj88ObPN2Q/Dn7yHlZzB64Soinwl5y
 NaHOnYX+ylGTPiRohzY5OEd6LOkGmIMNXIMC/cyCCXmoXwspIEjg3FvSklCTXl2SI9Qf
 78sW4qgnC3mN1A06KH6MpEhFrNpoQK8PGecRy5ZIQwsqL82AmUqpFSr29iA922OjTb9S
 C7kL4QEgrZR0gzmaCAOfMqyMWwCjFfQZvvIBPS+IFucNRIsglUKOn4cYbud+smpC03DM
 XY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r1ig+4y8qG02/Avrzw7uN/b0j7nz34s9Meh7FXM/D68=;
 b=TZE/VMJILrR8QEsJDSupzSU6QDw6ulG55ZqTyXhIwHbifrBe/pXxijj/yxBZhW/VkZ
 dLVkGwIUU02jjb/f8/Yh+j46MQ7bgcO8FSCZiRaAADKp3Y7gihj13iqM1jO/jVA5wrOD
 jBGPF8ZPz9ZjabHsUG0ARMEsU58cIRwvMlc8J7wTFzCPqKWMEiYz7nv8NRG1kn8Dhhr2
 mWhzyWrPlAqwqBVapsMboGIKJMbBofTCPRqBnMGMzJkT4xLIO1LquZ885cwJU7yYVvwu
 NHmtGLO8rbvVBrYFYRbN8Bs4yYPKF+1VcHoR1azW/BaaUuy5HP6cqPhDGx/vQgpp5N8T
 nHow==
X-Gm-Message-State: APjAAAWdKwO5tXtTIo+RboTnt3zU9tOjM9O5rjklGlwATevwy9gHZEd0
 ShYfPzwCXV8rf8QVg7gUEJmNnA==
X-Google-Smtp-Source: APXvYqydoMUvAYQiOi9ajb7IOU35AWgQQswYle/UBzsMEYC0cRxN8HhmmHuVXg+Qdap/YBX8zfO48A==
X-Received: by 2002:a63:ed08:: with SMTP id d8mr631609pgi.239.1568751630268;
 Tue, 17 Sep 2019 13:20:30 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id o4sm2898497pjt.17.2019.09.17.13.20.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 13:20:29 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190916135806.1269-1-david@redhat.com>
 <20190916135806.1269-20-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <742393ad-4ec5-7d3e-0488-7114295d2544@linaro.org>
Date: Tue, 17 Sep 2019 13:20:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916135806.1269-20-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 19/29] s390x/tcg: MVC: Fault-safe
 handling on destructive overlaps
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
> The last remaining bit for MVC is handling destructive overlaps in a
> fault-safe way.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

