Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30C4C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 02:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B42206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 02:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxNdq4ZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B42206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAPWY-0001VE-Kz
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 22:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAPVU-0000gQ-4F
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 22:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAPVS-0002zB-TA
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 22:15:47 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAPVS-0002yX-M1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 22:15:46 -0400
Received: by mail-pl1-x641.google.com with SMTP id q15so67115pll.11
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 19:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=j5Qdb4MVg4K9KoBnRSLFjcWGZY7Kl5JniJEtWO44C8s=;
 b=pxNdq4ZN7lvRqSihs8FpZKRPkV6CpL3mmPvC44ULQzVNsnhr28Ix6H/KyKUq5uCphm
 OEOGpVdONFggB0kshy8Cf3sT305lR64E2lQQqW5U0j+VlxZHF3OQg3IKJw8UZI+1f3LT
 BqOkFaCN2GnjVSYfLI+MEHwD29Hdj5/UFnggj5JnvnC3aTI10/vMidiiD2n9Wk7yKndV
 5E+v0h60Ev08tAtvYd4v5C6g1M9jkshqmXM4ujd3OyigAYCv06IBlziWTzp0Sz54g6N9
 lD3PubhRbo84ni0K1VfMpHKo5oNbYUTezEdPJY67XIA3uJKGKSO4FxJM8yCa61t8f2fu
 BXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j5Qdb4MVg4K9KoBnRSLFjcWGZY7Kl5JniJEtWO44C8s=;
 b=VzTRysGhQqxvYSwq9k5AziWpSidBKQzWWGmob9NbhQGPSJpxemjSefhEG/D+XrYzEf
 cZGtNiKIUF88Bgv+ClbK4DO08pa/EfMz5RJciBZLUn2mSOHj45XQfelGfC1mcnn+tx2D
 /0VH+P3REXxKQYvjJ8LjozJk82SUx+5km0WWrCFwTW37RKFnLHcRK6nktqgL9zC4FFOE
 JwDi2eOnQk3E6Msvjkx9ehhJvI0Esoay79wDd0MxnRffKQTjIGbEgN6MyK8065k4zFWJ
 mnFxur4CRWeaA3xsLWb3k4Pd4KG7/5eL78bJGH0Ibcq1c8tgnLxTzpVkHCOcTTBQAoMl
 /DrA==
X-Gm-Message-State: APjAAAU968BburUb6j7vW3cytHoYnd0VIuWM2yhl3o5XyJNq8toonNSq
 kpp4ULhfB7Zida/GPGLxP/4hgA==
X-Google-Smtp-Source: APXvYqxDw8ItyD4mbkSpwjK4/aE51dhapmiI8FW7RgcAgcajSiDUaTX3PrJe4ZP89IJUtPFglEFuyw==
X-Received: by 2002:a17:902:d685:: with SMTP id
 v5mr1728593ply.15.1568772945061; 
 Tue, 17 Sep 2019 19:15:45 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k1sm4112442pfi.132.2019.09.17.19.15.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 19:15:44 -0700 (PDT)
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1568762497.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d9e037ec-828a-29df-de8d-723198cd96ff@linaro.org>
Date: Tue, 17 Sep 2019 19:15:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1568762497.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v1 0/2] RISC-V: Convert to
 do_transaction_failed hook
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
Cc: peter.maydell@linaro.org, palmer@sifive.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 4:22 PM, Alistair Francis wrote:
> Palmer Dabbelt (2):
>   RISC-V: Handle bus errors in the page table walker
>   RISC-V: Implement cpu_do_transaction_failed

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

