Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8A1C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D21120679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1RUERIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D21120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvBl-0008Qx-Ra
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuaL-0005bD-9E
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuaK-0003LL-23
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:35:33 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDuaJ-0003Ey-Rg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:35:31 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ca13so9160943pjb.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w5sQjorFuVomVm2LDzmTqpG8kws2SJE8A/zp/CLyggs=;
 b=T1RUERIwtJ6S22w5e4synIHyYh7z3z0cv0mjTD+gBRoEdbnfjtdpGAUX1Yco1AGnnU
 m5d7VpH7OHuyIF4OHO1B+CBUw12yKe4q9WFiv+54HA4Pi38gFcauhtIqMC6zxRBHDTcv
 UDb38XOCUpC2NjOFZ8s0PkUOlSaC99aI3Pwos8dVDgNYz3fM/zAQnZn8ZPXKb+EBCEa8
 D1Z6SgsI1AhweZ7evsy51i0MurR94NuQuaLc9XwUjNBbIXYM+HZRUQf0zDJMBsv2EEqk
 McSWxGAA9JUhz7rZulh46fSoFi5AjqMNf1EtMHJovLSAcxLrL6FHpaOP7vHCU5y802Xe
 TTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w5sQjorFuVomVm2LDzmTqpG8kws2SJE8A/zp/CLyggs=;
 b=WirCBuEp78sie3RhZ0T4v4KQ9SQEzgHumRjEFHe9QFWM5WPXfWOFwtr0RoNL5uwYgs
 roMaQbOjJ5L6bk2y2vKCVJU5on1VJBOi2CMrYAIqH+b1sScNv3obT+r6C0rFtO/WeTHb
 o8OKhQknUIrvflPhf7WPjkfJ5al25Tv2BKrGOKjoRR2CVGxfH4lzFJ8+Mf7dpm0ZmV9m
 j6D7h3Jc/iRHwCNBQeRKJZAg2YjxqeERgJb4WzfBhRMno5zueOh8o5WFsLrXNNoU92Hb
 SSVo7+eTtU8sB5bpbHkZMMf7dvJnfWC/Dmfv7wsUMfFY0QA6YlW55DVA/p5PeV4Pp9bc
 AqBA==
X-Gm-Message-State: ANhLgQ1pFY8YclWgj2xLz8gd2IGY87oGLnHfHjaL2ya8rRiYc5Y5sOWF
 4jHXdF7FivnrfEXt5NulV7QxnA==
X-Google-Smtp-Source: ADFU+vscsDVE5KlM1Z2cgrOJmYCBBZI+tTToeWEeGN2Qa3SMeJ8wdjI97PGt5707Q5xz9pQkwxP+kQ==
X-Received: by 2002:a17:902:7244:: with SMTP id c4mr528225pll.88.1584383730700; 
 Mon, 16 Mar 2020 11:35:30 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y207sm584834pfb.189.2020.03.16.11.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 11:35:30 -0700 (PDT)
Subject: Re: [PATCH 10/11] target/arm: Always enable CONFIG_SEMIHOSTING
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-11-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <79a88157-f3d4-5c69-fec0-bff6d2ba34a2@linaro.org>
Date: Mon, 16 Mar 2020 11:35:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316120049.11225-11-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 5:00 AM, Philippe Mathieu-Daudé wrote:
> On ARM, the semihosting feature is always required on user-space,
> and is also used by system emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  default-configs/aarch64-linux-user-common.mak | 4 ++++
>  default-configs/aarch64-linux-user.mak        | 2 ++
>  default-configs/aarch64_be-linux-user.mak     | 2 ++
>  default-configs/arm-linux-user-common.mak     | 4 ++++
>  default-configs/arm-linux-user.mak            | 2 ++
>  default-configs/arm-softmmu.mak               | 4 +++-
>  default-configs/armeb-linux-user.mak          | 2 ++
>  7 files changed, 19 insertions(+), 1 deletion(-)
>  create mode 100644 default-configs/aarch64-linux-user-common.mak
>  create mode 100644 default-configs/arm-linux-user-common.mak

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

