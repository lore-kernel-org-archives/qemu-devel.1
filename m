Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3ABC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 19:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C46207DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 19:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJZVDo4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C46207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxbgY-0008IS-Rq
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 15:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jxbf6-0006cD-VV
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 15:41:20 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:35612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jxbf4-000679-JF
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 15:41:20 -0400
Received: by mail-pg1-x52a.google.com with SMTP id k27so10790539pgm.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r4sGXluqaQYpHz2gJjWcC8JR1QPkpaZ+jeOR6K+cGJE=;
 b=JJZVDo4Qd6agZQUomlVsTZvHv9Cq8eZz1tr853twMMzoZj8SjsebQ/rq44GHObEcqC
 CDoZ5QejU6j7psxFZDoQfXLxrBAeMnSa9rFIBgar7z4DszUKYFQHkm7sWq5m3nYPQgXu
 00dTPOHlM0fHgEKMvnZVDTgS1qNFYPaaBAxL6pDVWhenWAZxAG13Grd9/4ddS044jipj
 5ZHv9uKdmxm9EVAohQMfRIqIip36e62zhYd3zU6XrxAhGM07DPCbXT2qymvgoN3EJJbw
 jBFESCCZwd12eNCE9owINMkRvK+TUDC9PUjLUJwHEp329q79luO6LgBbOzjf8M0cxqQa
 kQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r4sGXluqaQYpHz2gJjWcC8JR1QPkpaZ+jeOR6K+cGJE=;
 b=UVGLvWcspiuFJ/KujellFsc3YVUuvPez8RxVbpWjwrLlKz/wSwVZZjStZxAFz0/swF
 lMRdIARyLo7XwpQN8Z4MHwDS0UA7CmLzP/tjubde39YteJeBWIbmR1IABaWRepc7vUqL
 MHJlQBj5huueJezUfj5FQs4B6tCjP3n8tsi/0t7K0FFQEUSl1HxW94kq/Td4SLfawI7J
 jNJX48v4tqhKN/5EQ9e2GQbnPA5wnpJjz2BiYJS8XC+WyinW4uPfU5eFNs6+wGNlM1VU
 0g4lTQCmkfPmY9Nw5HeSryQFzarhpYRDcqP2vNMQZmsHH42bMEcXC+SCA7p5NRRMQR5V
 L6Cw==
X-Gm-Message-State: AOAM531kNhNB24Ll9KrWj/uqvYYIk3+E7P2s7DgGDkWMXhHSegC/FbrH
 ejLGAG8Zy/JZkSfkZvutG9zfmA==
X-Google-Smtp-Source: ABdhPJx62rwAP40lM8vcRXnDNdmuoC7Qtyayn5vSLnWPVJB4bY2dGZQsThWIYmoSebKu66GCqikIVg==
X-Received: by 2002:a62:fcca:: with SMTP id
 e193mr21532902pfh.307.1595274076862; 
 Mon, 20 Jul 2020 12:41:16 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 17sm377442pjl.30.2020.07.20.12.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 12:41:16 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] hw/isa/isa-superio: Fix IDE controller realization
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200720172348.23465-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <28b40409-5094-137e-a1e3-60dd502633e3@linaro.org>
Date: Mon, 20 Jul 2020 12:41:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720172348.23465-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 10:23 AM, Philippe Mathieu-Daudé wrote:
> When realizing a Super I/O with IDE controller [*], we get:
> 
>   qom/object.c:1684: object_property_try_add_child: Assertion `!child->parent' failed.
>   Aborted (core dumped)
> 
> This is because the device is already realized when we try to
> add the QOM property to the parent. Fix by realizing *after*
> adding the QOM relationship.
> 
> [*] Set ISASuperIOClass::ide.count = N with N not zero
> 
> Fixes: e508430619 ("hw/isa/superio: Make the components QOM children")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/isa/isa-superio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

