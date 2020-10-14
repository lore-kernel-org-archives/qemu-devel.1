Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA47C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD3D2222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xv0KusxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD3D2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmTt-0000YF-Qx
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSmOR-0003B4-RD
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:24:59 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSmOM-0002Ay-1b
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:24:58 -0400
Received: by mail-pj1-x1044.google.com with SMTP id u3so325967pjr.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lJ3MUk4XiwUmGOaJ2/MMkFRS69j7zY8jRy6+QfRAbdE=;
 b=Xv0KusxJnk1Neg4RWEKzTlPxb3OsAVhoiqmqyiAg1niKzD0oA/d4JeqPvHx9Gvn6oe
 OaXA/d5H50Ib9gyzbb3pj+Djikg1Y8NmcODREz106buvLXkuwh15rD2LKcVNbtEViRyj
 FOvo6jlr+VUuSrKdh4PnTjoo39Env2kAtl+D6timo7dWnITDs88OGDU65f+VYSP/cXXH
 Sw2/va4J8YlUxn/QP8no4mqR4T5tNB/DT8OEIqv6GQgGzWbkZm64+D6QufNlQkvIz42l
 FJGYlruxc67azlkY0/5nI+a83lCWWTBZy2QK3HKClbliSU3yUYawjQ45DbJtOI8Kj2b9
 cgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lJ3MUk4XiwUmGOaJ2/MMkFRS69j7zY8jRy6+QfRAbdE=;
 b=kGjlI7LjBahE3m7ZSBzmf1EQXgd49/yQRJ/bi9qQYNze6Ea1G5QqcASAuDCXVzv+ej
 KeIb+PxsOVEJ559wIDKFU9QuJ76xsVvL3KgjU3T6Bs7c/jVvfzAt16AKR0FQwOerlFpE
 iaNPXHYL8E4dj1YjqWDWHeqRN2lHpZ7kGKAhYCmWZ9L20dZupu7SSj0vru5ZjHbHLH4C
 q0RLnhevyIPH2ARhA00psqQABdiU2OirybU/ujLkb+ndK81l5hodKW7bauiTg+p4bM3c
 qfWYFxRnUfaKCfV9SrGiuAouGWGQidZp4InG3NuzvLWqEigkYjfxPg/uVtGWD3gqqmCQ
 zldA==
X-Gm-Message-State: AOAM532AtdTB5Z8qrY9ZYT9FsfTuo5+XYsmLMZZSYkDJR+f11aaanSBc
 n6n/eaQ+UnCmqLjyWhxfAEbIoQ==
X-Google-Smtp-Source: ABdhPJzRbP6L7ntePK7YIMpa+MqL5LyVfND6AUlp4jB/0Lxd/tj2XpTSZH01bzKhLgS8fZoGwqnU/Q==
X-Received: by 2002:a17:90b:ecb:: with SMTP id
 gz11mr701602pjb.25.1602703492345; 
 Wed, 14 Oct 2020 12:24:52 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k3sm375606pff.71.2020.10.14.12.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 12:24:51 -0700 (PDT)
Subject: Re: [PATCH 5/5] [RISCV_PM] Support pointer masking for RISC-V for
 i/c/f/d/a types of instructions
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
 <20201014170159.26932-6-space.monkey.delivers@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a4c7ff19-0b5b-263b-51da-80b5caea8f27@linaro.org>
Date: Wed, 14 Oct 2020 12:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014170159.26932-6-space.monkey.delivers@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, GAPPY_SUBJECT=0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 space.monkey.delivers@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 10:01 AM, Alexey Baturo wrote:
> +    if (has_ext(ctx, RVJ)) {
> +        src1 = apply_pointer_masking(ctx, src1);
> +    }

The if is redundant, since that will have been done in cpu_get_tb_cpu_state
while assigning pm_enabled.

The test for pm_enabled is in gen_pm_adjust_address.

The final thing is that the API for apply_pointer_masking is misleading.  Here,
it appears as if you are allocating a new temporary and assigning it to src1.
Which is not the case.

I suggest you drop apply_pointer_masking and just use gen_pm_adjust_address.


r~

