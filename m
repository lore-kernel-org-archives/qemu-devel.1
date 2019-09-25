Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD879C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EF421D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEk02Nfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EF421D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCbb-0004wO-Dz
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCRq-0002nU-Pu
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCRo-0004bX-Hy
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:55:34 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCRm-0004Y5-Ho
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:55:30 -0400
Received: by mail-pf1-x441.google.com with SMTP id y72so4153248pfb.12
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pC+yy8U4yiitwpzuiF/dcwcXRdxCYf5tg+gT7SMoVII=;
 b=DEk02NfyO5nwJKwPUj6zH99VPZ14wop2ApdTk4jqPg1KBneOd2D1shOHwyRZp0q5rJ
 u8ZX+kfW++Dd1rX5UG5R9qeGKZs88XdkHqsA2pm13uOLoYDlQzmWC1QkLL/CvcIMM3am
 zjFGnQogLKdkwguXyFw2+Qj1JOXD6nbIGdR0S1IXqgnIPhf6JISkg2n8cf7sWl0w5MeD
 CZxikEnfrJjFAg1vw97+yLHPesw6R45cr6ofmvPW/qm1KqwFdQ4pTGE1PdzCaNU9LUXm
 KYUB6aDrN67JnGV29zVZtqvsbF2elbBW1SBgKsRrDUe8gfzaDKhnNdHtuz8uI4Xhuns1
 1gzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pC+yy8U4yiitwpzuiF/dcwcXRdxCYf5tg+gT7SMoVII=;
 b=Z1Iv3e3FPQYq03+7KhvQWyAkzcUl0Kq5yqzFeM4xeFZItag1Y7Kn++IHEO4Maxr1UV
 yz+BARuopPJp+/sQly5KtVUNs7D+CosVS+KtnUKDAQA3bqjmuSMPVmfK3+I6pRRdbEC5
 7oijR7Qu8sPQv+EDUV8qOlW4ZOzDSzt/hF4rRf4ubGf2GPghRDcXI0oTqsZnhi4pbThU
 UXll2twEWFYYfVRQivL09eXdwfGb6k/ZmSTQVWd6mhBJpHSeUHPop2q3Vif1ZGagzsCU
 wIWIXjiGn7byMvG+MIBt2n3L8B5Gk1j7aw/gx/e3a+ZzZEWYg/LjAh52C93gQ1UU2swI
 Csbg==
X-Gm-Message-State: APjAAAXhrUhsVqL7gjESiWuqlKBbGlT3E5Pk7rScqEmZ9bW2DZwm+ZEX
 fRK+eAjOWqEx89FmU5A+GEXZ3A==
X-Google-Smtp-Source: APXvYqyjiaAGhklxtB8PVF35M6fND91npAsAEOUpLKWAn3kvpA0sZ9rG/czkt1uUBKgkwIB7GHBqGA==
X-Received: by 2002:a17:90a:310:: with SMTP id
 16mr8315200pje.100.1569437729090; 
 Wed, 25 Sep 2019 11:55:29 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id m2sm322364pgc.19.2019.09.25.11.55.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Sep 2019 11:55:28 -0700 (PDT)
Subject: Re: [PATCH v3 15/33] tests/docker: reduce scary warnings by cleaning
 up clean up
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <629ccb70-f323-4474-2d34-94467630c598@linaro.org>
Date: Wed, 25 Sep 2019 11:55:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, jsnow@redhat.com,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 2:00 PM, Alex Bennée wrote:
> There was in the clean-up code caused by attempting to inspect images
> which finished before we got there. Clean up the clean up code by:
> 
>   - only track the one instance at a time
>   - use --filter for docker ps instead of doing it by hand
>   - just call docker rm -f to be done with it
>   - use uuid.uuid4() for a random uid
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - drop the try/except approach and be smarter
>   - use uuid4 as uuid1 can generate clashes in parallel builds
> 
> fixup! tests/docker: reduce scary warnings by cleaning up clean up
> ---
>  tests/docker/docker.py | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


