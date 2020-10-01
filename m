Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6168BC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B2420780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXr52+JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B2420780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO06D-0005wx-99
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kNzz3-0005Xl-G0
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:55:01 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kNzz1-0003so-3P
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:55:01 -0400
Received: by mail-oi1-x241.google.com with SMTP id u126so5824779oif.13
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=chIpvnOJ9GqCVXP7N22LNRA9r//HjN8pKJCFVZKqYZY=;
 b=yXr52+JQZmU+oFP2NdrXO1OkCtJOnWboZVSbfSmDYx6FYg8NnzGn3eg1+pKSt27wu4
 EFDS/KA7dQNA5s8oN9wjLuy52XPRJqygOOWcuUUbj73udcZf18hbJXf66vAd67ff+0re
 3kfx+Z6NtEc3oKS0TQGpq9SWqf380aZK45cH9uvlQ4zWedJd2TNTSgVUKmZIQ1Qyy8Q3
 rDHntKZbhgnT6Tk/huRx8FMvh6FEjSkcJODdlskpCsfC6u2RD9Azh3JNEcI/GqkLIJHm
 5GidTFg7o31qVhfPr7lqm9pIcjYFRJubeFcB9n81X9xEtBxZwLTeyOKl6RAZhH8RHyGN
 lVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=chIpvnOJ9GqCVXP7N22LNRA9r//HjN8pKJCFVZKqYZY=;
 b=AuOpcraqqcGQJr0iItbKTwFHu2l/jXbHABYsO8Ah+rroAn1yG/3iIcRorlJMQ8GisU
 TQ3WXvfcFq0ZdZ0fpJO+S+FXOPcDOLVyigg9whT5OzMk3lq32uN4uyzvqy1pswHnryD+
 SjrTAE4yUQmKZJ0XTyR8MPk5gTYlTwEzVKtXALJBiXSPXqlFWr7WYo6YjM3ZdDgk2oVT
 qAdKKf1k3X7PhEhnXFP1gYPOZDv6bjsNCCr8w6dsg2wlFBcZZZdaRttxTeTr9iGkOuq9
 wkV6y7gNrj0wJPppq+IksJ40LksOf0Exi4UaYShsSPK/b6dlH2/+smzdrKnC3cegk0hB
 OSQg==
X-Gm-Message-State: AOAM533FYIVGgpH+vrpJCndaeOOYN0Gi7fTlecg+1kRXZyoiX7P7/oaw
 OQBIUtPqnhzkhLKdQZNQhB2quQ==
X-Google-Smtp-Source: ABdhPJw+rDP2RkWD/7UuRx9nhuIAfHDwOYcN8ur/VbkKZL1xlqBHmiyyGo+Z0Qyv2EH2EVJJUrOQMg==
X-Received: by 2002:aca:55c5:: with SMTP id j188mr230018oib.138.1601564097948; 
 Thu, 01 Oct 2020 07:54:57 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id l25sm1254832otb.4.2020.10.01.07.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 07:54:57 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] s390x/tcg: Implement MULTIPLY SINGLE (MSC, MSGC,
 MSGRKC, MSRKC)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200928122717.30586-1-david@redhat.com>
 <20200928122717.30586-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13e5607d-77cc-4e18-a2fa-0cfe07322806@linaro.org>
Date: Thu, 1 Oct 2020 09:54:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928122717.30586-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 7:27 AM, David Hildenbrand wrote:
> We need new CC handling, determining the CC based on the intermediate
> result (64bit for MSC and MSRKC, 128bit for MSGC and MSGRKC).
> 
> We want to store out2 ("low") after muls128 to r1, so add
> "wout_out2_r1".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cc_helper.c   | 32 ++++++++++++++++++++++++++++++++
>  target/s390x/helper.c      |  2 ++
>  target/s390x/insn-data.def |  4 ++++
>  target/s390x/internal.h    |  2 ++
>  target/s390x/translate.c   | 19 +++++++++++++++++++
>  5 files changed, 59 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

