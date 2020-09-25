Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE8C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A89520758
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zc/0e65N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A89520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvE7-0001bo-5H
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvDP-0000mQ-71
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:25:15 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvDL-0002Ut-C2
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:25:14 -0400
Received: by mail-pj1-x1044.google.com with SMTP id v14so155389pjd.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ivkrB/cxKJCxK9MIn7K1uU/pyfr1ikYjv8TaJ2LcRPs=;
 b=zc/0e65NY7N+J01w4tWEpbj/IlS4iG0ahLfOBfw4kohH6q9SYd+oIYyE6ehr0q0eHX
 4j6Ze49v+tHAkoa6OJPlVo5w6a119uqJPXYQcUzIhs0Mj4hYcabcwTOLk/y3WwlHFpA2
 O3Tyh3q/f4aX3nKPSrfCbqRXuYb4IVvVu9aKJ68s8wEeJTROV3QscwOHRPrXKW+Qz/5x
 P2K4pxFN1oIz3Iuy5awvPfY/Y91fZv64FpETj7r2/9UWprQAMPtVvN1+xzXyDGUWwY8n
 cRPQUaggvRLn4+dD6MS9a9ckt8tvLzApNm9kkrnRYiSUYTOLWwyruayya+FomYjK2Aoc
 2knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ivkrB/cxKJCxK9MIn7K1uU/pyfr1ikYjv8TaJ2LcRPs=;
 b=XeQRTSU6OdoBN0VuPsbvZ8rREt/6qn1HOJG9wegJ5nLPVf0UxgOBFVfRd2Z/A9TEir
 x8znuhj4taZIzZsciEvOGhejeN4fGo/KpdBXleeJ52AuCrUSQH+yZHcXnXbQJlvwv6kg
 LQoNJKrPZCopkdBkWLYcuCQ3IRfum9KcY56LgL0yhG3e35xr4qTCB0o8w9T6qJprUj3N
 Vl73ZQbVAc8IrwUfobQJ5pOsyYxYpsg45q2D+TzjcQfNcVYN4sIApEI4CpR0VKBinOCB
 PzTfubDPJX+AJ5JivNcl5GYHGuLSjReTKDAz6i61lxO7DL2aUf+vnSWVwPQZgYm95GJk
 ZjgQ==
X-Gm-Message-State: AOAM530iBsTGeyvMA0RSGsvG//CkBxrJLcW9pAejRBku8+ScYhHriF33
 kkPT/L0ShjX4T3M/3rmbWd2ciQ==
X-Google-Smtp-Source: ABdhPJxkoULFNKHgUeLF8fyYZDZLMH8d9vxUcYaNT4mpCfCyG6jrdxvvermdme0WcgHpl3uR3qxoHQ==
X-Received: by 2002:a17:90b:364c:: with SMTP id
 nh12mr431623pjb.182.1601069109837; 
 Fri, 25 Sep 2020 14:25:09 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s66sm3494894pfc.159.2020.09.25.14.25.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 14:25:09 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] s390x/tcg: Implement ADD HALFWORD (AGH)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200922103129.12824-1-david@redhat.com>
 <20200922103129.12824-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f8f98e9c-6541-883d-2df5-c9d221bec674@linaro.org>
Date: Fri, 25 Sep 2020 14:25:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922103129.12824-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
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

On 9/22/20 3:31 AM, David Hildenbrand wrote:
> Easy, just like ADD HALFWORD IMMEDIATE (AGHI).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 1 +
>  target/s390x/translate.c   | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

