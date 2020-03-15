Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4047C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 07:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526F5206BE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 07:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmXZmc4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526F5206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDNJI-000384-Bd
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 03:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDNG4-0001YX-Fp
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 03:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDNG3-0008Eb-9X
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 03:00:24 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:39192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDNG3-00084J-2R
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 03:00:23 -0400
Received: by mail-pl1-x62b.google.com with SMTP id j20so6359477pll.6
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 00:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1nJn24+xsUDqNvK7aXvJw5zcGpxmeT7eNgNxiW7ww4E=;
 b=xmXZmc4tUTOFWuvm3iwsXzQIS7RN55vq8umZcS0ACazunPX/aZWLwbINIMyYWQg7Co
 ylQQCk6ju+EfQEBuj8QBxKHH9nSTyPOJIofJF+CEFR9/Nk6PicBPucagFdUzy8RApCTQ
 hW8K3OD7esRWMRES0TUFz/lU4epj7ai7XphVQxN0hvYePRVZMOJfuIKopjFKDaVXRRJE
 0K/Plgwp66YYaK+WhN1nqza2+enu/CMtxqyy4zf3hG3QsTQqZxvf4gG/m6y8Nx/AlUfM
 3m9znaJRFjykGWyF1RMxUfc3t2Q5+mR/ickVAuGlyiePuX68uLsbyKf7JSokvekhetUj
 KuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1nJn24+xsUDqNvK7aXvJw5zcGpxmeT7eNgNxiW7ww4E=;
 b=F/4B6hLqmKVDNO/tz5Y2e7wiqkG8+dIhKxzeoYKlLNT8rhLGmN0R+J4WabL2DZeZ1y
 av5nEeUF5WK5NdWjvc3LmAIKXTryZf9bULNYtFvHXKSJ0GOedah/wtfeIK+j6m0Lc31L
 Umqw+Rxq8Onb+RKNcioMTESlzjizcOew3J8PlqviYC+QEzTzD8JiIpu6Gl0d99oMWh/V
 Nw8xnP0VCVaL7LC3kHGB42R9fm2VJQ2MHF5dtQZKH+au8TFxAC0BbJuCMOvPzQONqQYk
 hJ79hWdLy+Iwvt3O1dnvcf4DR80yY+iWDDm7SUVlbnmRLwDd4s6fTH0gznVUNfjLJQMx
 XHIw==
X-Gm-Message-State: ANhLgQ0W5kykiA7Sceez27g0KGwOCA59buVC4knOlghdWgPGFZ3aL0wx
 oz+/RJj6tZAdDOTKADVDEdQXrQOit4Y=
X-Google-Smtp-Source: ADFU+vtiGWYQCjD3LsCYqnKBjHO3i1Sq5k8BZoWsGv3xejfjjk23SdkdMzUL1kKh03EWjP45yGkooQ==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr21180824pla.17.1584255621554; 
 Sun, 15 Mar 2020 00:00:21 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q13sm61036799pgh.30.2020.03.15.00.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 00:00:20 -0700 (PDT)
Subject: Re: [PATCH v5 35/60] target/riscv: vector floating-point square-root
 instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8a88db4f-983a-6b79-2c1a-0c55b93aad61@linaro.org>
Date: Sun, 15 Mar 2020 00:00:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62b
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[ Patch didn't make it to the list, so reviewing

https://github.com/romanheros/qemu/commit/c77bef489c5517951077679ec9228438d05f1e1a
]

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

