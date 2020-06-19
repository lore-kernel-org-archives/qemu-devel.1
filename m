Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D48CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18212214DB
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJyVgnkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18212214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmQlv-0005rf-C1
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 19:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQkz-00049f-7m
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:49:13 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQkw-0003AA-Jn
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:49:12 -0400
Received: by mail-pl1-x641.google.com with SMTP id d8so4583856plo.12
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ZrUb4mVZ7oNyan2Iv1NaJOSPYluolnMx4WvDAxpWFss=;
 b=eJyVgnkLPsz2+Y7WPmqySAQs0Lsw3Pl2yH1lTJMNl69neBxn+At9DMb9w9Iu34fSka
 WpK7Y4KzJr9rRmk4+G/HKSBVRo0R9h+eGE5uG4WOM1/nLx92QNS6WRwK+xttA+6u1RVl
 Nu9oFmYbvmLMvA2+BkQf3ikqxBTKMqZIKV/YNuLZIUNq6A5t7TDt/F4W5q0oiLwv4x/G
 gsJ0vuT3Tu43vWsOgs6qYzEXNKteIK4vDeX43Acod1tgq7nU/w71BWtY2wyXWXpRxN6/
 3mZqq5BhYI+qczb6RzfZ+FuNTwOr6xcqMvydll9pBVgekWh8DIQCEt8xeoHZKGeFR0KH
 3xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZrUb4mVZ7oNyan2Iv1NaJOSPYluolnMx4WvDAxpWFss=;
 b=RDuuenqHffktLrpIuYFg3BfsiaAtFdln0ltIfZ9OsLWeILCvCr9I6V/W8ZV8UX4+0o
 bi7ovwOA9xrhw7sgBq9A8M0jBe/JbzggbeG+sJWfYdB1I7xhtPhp/3/2fziQUDZdXS+e
 50HSxxxU42YVEtYSWu0UaEW5PH74NUHySiJ8qH22AwzB/8/iN5jNPQBfRadt75jBa+SB
 8L4Y9psFAO5jgVBp5iq7Nt2fSoLEfCOG4LxRYskXduecTZ8ESGOrUJX4O/bG6Ji52Qr7
 f5TgAS2jEfpe1po59QCRSQ8OZIgO25iT+F+/JwKkWOBuj3qA1jzQmG8Zmnu7dUZWRl/R
 qnNQ==
X-Gm-Message-State: AOAM533+Vv7RYz6GEwyQAcoL8lS+tGt0OzHtp0VlJY9ZgsSKjs3Vt93X
 dwYT7nxH9gZro2wLUcO6sldRYZ8b9Xo=
X-Google-Smtp-Source: ABdhPJz+ZBl/IHDlK8ulea3wpQ0ylNEYkXcsglFDVDiY6JBj7emygTfnVL8OENfKEyfR4bDTdGwwIw==
X-Received: by 2002:a17:90b:ed5:: with SMTP id
 gz21mr5719564pjb.214.1592610549157; 
 Fri, 19 Jun 2020 16:49:09 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id z1sm5799139pgk.89.2020.06.19.16.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 16:49:08 -0700 (PDT)
Subject: Re: [PATCH 17/21] target/arm: Convert Neon 2-reg-misc VRINT insns to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9021c24e-052c-3138-7dae-f45ceb5b147e@linaro.org>
Date: Fri, 19 Jun 2020 16:49:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 10:08 AM, Peter Maydell wrote:
> Convert the Neon 2-reg-misc VRINT insns to decodetree.
> Giving these insns their own do_vrint() function allows us
> to change the rounding mode just once at the start and end
> rather than doing it for every element in the vector.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  8 +++++
>  target/arm/translate-neon.inc.c | 61 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 31 +++--------------
>  3 files changed, 74 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


