Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A027C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DCA216C4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EseCbotW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DCA216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlXXp-0004Jb-Kw
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 07:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39536)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hlXWE-0003r4-7z
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hlXW7-0005ia-5m
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:45:42 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hlXW5-0005WZ-4z
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:45:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id s20so5517472otp.4
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 04:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dJfFZP3bg4pM90L/c2Nl2J7Ii52GtDYmQSGRpgrzDTo=;
 b=EseCbotWV1KZtWbQYSfU89bW4h+GNf498W57gjM6i8/NkOTH2bW6qgs/EH4RyWOF/N
 3XcjnLzsgnYARAv7cEBWpaElLTGNdQ8Jqe1QVl+GHZE6SBHyUWWq+zEyCJrkF0WzmNjC
 Mwm8v3lWs5CuX9Yb5khEBUa7+zKd4/SQuRo5tlaR6OuAhZEd88EVguEVmmHgd+/4Wxz+
 OI70Zs+lj7pRD/etinBC2KGsXEiHNDLJ2Vo3NIQtdjUC65k+RaxsMhK+tLgn+lYUX38f
 YrUhf8wBV6/YDvdct2y5QYOae/9pYhJJ6az4Rkl6/XnmANDX44XvAvl7v9M3HGfZK2FG
 xrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dJfFZP3bg4pM90L/c2Nl2J7Ii52GtDYmQSGRpgrzDTo=;
 b=Uem/ip2zdTJeR67ilKQCd00KHXpMM935uEqPKn3YCZA1YJqjCbedwN+H0Hioe+x1bJ
 FcUUM/E9BXQdY2X0Ru2tSeniR9UqiPwWEZQ2Z6sJeBU7T+JqRGh/rc7KFqwxX9IMUoir
 5u4EMRLDHrQZNv13rnoGMEKYy3T0KdjuDd1M37a/kdsQG3kGtM/9uM1/RWC+Finfc+/B
 /d4A6TH+Gm4fzSn2t75+GIbpmsmab53M0LfExclgsTqgwD01vEtBPRfPASO5fK2QloYQ
 WzTUoBjgNRIFpRNABTZr9n3u6ohzAetNwi8lezmU+WygdEcdkXVbso3AnlVdcG6qkKHs
 wiWQ==
X-Gm-Message-State: APjAAAVLNYqLoXD/DL+DpOvs/j2BPTHDp082ha2XuIjdExMNAbBfUWya
 pDjxIqRyRqPX/AO8DtsJPsZUcg==
X-Google-Smtp-Source: APXvYqzE+S+fcH2dm8FZqyzJJ4C09yEM0ko5Sf4g8/gbZ0r6RGerCpx6hmZ+vhrohZe+HXXPcaH1tg==
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr3127942otk.190.1562845530078; 
 Thu, 11 Jul 2019 04:45:30 -0700 (PDT)
Received: from [192.168.43.94] ([208.54.86.238])
 by smtp.gmail.com with ESMTPSA id u16sm1775144otk.46.2019.07.11.04.45.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 04:45:29 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190709184823.4135-1-richard.henderson@linaro.org>
 <CAL1e-=j8J0WLUjhaOvecSU3VtRf5W+zP-Ydi_kZth4BYV_cXtg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d92c85b6-f7a4-71b8-9601-03d8975b5212@linaro.org>
Date: Thu, 11 Jul 2019 13:45:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=j8J0WLUjhaOvecSU3VtRf5W+zP-Ydi_kZth4BYV_cXtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] tcg/aarch64: Fix output of extract2 opcodes
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beata Michalska <beata.michalska@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/19 8:12 PM, Aleksandar Markovic wrote:
> On Tue, Jul 9, 2019 at 8:56 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The aarch64 argument ordering for the operands is big-endian,
>> whereas the tcg argument ordering is little-endian.  Use REG0
>> so that we honor the rZ constraints.
> 
> Hello, Richard.
> 
> If endian and rZ constraints are unrelated problems, then I think the
> commit message
> should be:
> 
> "This patch fixes two problem:
> 
> - endianness: the aarch64 argument ordering for the operands is
> big-endian, whereas the tcg argument ordering is little-endian.
> 
> - rZ constrains: REG0() macro should be applied to the affected
> arguments."

That's fair.

> One could argue that in this case the patch this should be actually two patches.
> This is better because of bisectability. The number of line in the
> patch doesn't matter.

Well, nothing between the faulty commit (Fixes: 464c2969d5d) and the second of
the two prospective patches is really bisectable.  For the given test case, all
points in between will fail at runtime, even if each point compiles.

Therefore I don't see the point in separating the two changes.

> Would you be so kind to consider my opinion?

Yes.  Thanks for the expanded opinion.

I plan to change the commit message to:

---
tcg/aarch64: Fix output of extract2 opcodes

This patch fixes two problems:
(1) The inputs to the EXTR insn were reversed,
(2) The input constraints use rZ, which means that we need to use
    the REG0 macro in order to supply XZR for a constant 0 input.

r-b, s-o-b, etc
---

Does that seem sufficient to you?


r~

