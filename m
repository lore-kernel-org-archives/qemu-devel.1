Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D74CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EDF20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfW4NgO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EDF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDw12-00011C-CO
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 16:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDw0M-0000OG-1F
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDw0K-00087A-Tf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:06:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDw0K-00082K-MA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:06:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id t3so10350104pgn.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oMoLpNdfwPj3BjJ9X6DM9wITDjEHBSTuqrQmlwfNSjU=;
 b=mfW4NgO9PmedbXOTkBJ2p4fnyqH+PaQYFFXkpEl0+hkas2oi5vm/Ucr8lrSCnzFctx
 6wBrvoaeMeZBG2bQRqO6mw68s4MtCafwnw1Acq3IC/kOQ/oZvCX1QOkyT1nv8l5yR9f7
 nL8bzh5vOlxijwjQmhJX60n3loAmx6odX8iqdxxUKlOyqsvAUvJZGVcUty0Jq2YYVuHW
 ciMsmsWm/7We+5mY6F/srwuqqKqIvZJ3LWnx4LWa6xvmfGDrBi1V+BdAJm3E8Mi8khy7
 N49rccakpTBvzDNoqeIEZhtiDJQhZr1MR+mYhDE+Yea4FztXp6MFREA8EZUCaWd+HufS
 NvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oMoLpNdfwPj3BjJ9X6DM9wITDjEHBSTuqrQmlwfNSjU=;
 b=ZBkGyJz8Z2K8ljMlxvg4AjmfjIehlkh7PQ4OYoNSiSLAZCrCj4xQK3qTv82gPgFKJ0
 MGWe9iOFKQeKXiiMo+gxbfWKSNATpmYDwbkMgC8H9e3sa/f5X4Jv/OMPCem1LdZ7aSMG
 jh1uEnvKEsY2Tqc9lu6TkKncsxvaG18ymmU9T3oNAOCO+765nMYW8HzlGJT/vtDzFDSF
 t94QNmEVedh2K6Lno0CGAb/FUtP7QbMa6rCZv2HRzcdpp2TaJnWUNGnVWbPXpmLGqSin
 OZ2uGljT2bh1cvxwRUk5K/b6Jur9VzOccqTycoqPGqlboup12uGDuryILa2F5JN7kplv
 dDOQ==
X-Gm-Message-State: ANhLgQ0xYOZ7oNHOe0NNVnlIKP6jNeDQH9ydfy4JQJTWYXZwDEyanmjj
 eKwSy/jjYZu4D5P/V5YVz54VuA==
X-Google-Smtp-Source: ADFU+vvSFbuSg/ZfRlESkgsCOFoCSgmG5iPCyQlDq0W9IFjOrCmIyWHQSdbKHKIkdWBjoEo1wl9mPA==
X-Received: by 2002:a63:790e:: with SMTP id u14mr1340697pgc.361.1584389187593; 
 Mon, 16 Mar 2020 13:06:27 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a71sm687824pfa.162.2020.03.16.13.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 13:06:26 -0700 (PDT)
Subject: Re: [PATCH v3 17/19] hw/arm: Automatically select the 'virt' machine
 on KVM
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-18-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d0842e82-8640-5903-e59b-99963584b89a@linaro.org>
Date: Mon, 16 Mar 2020 13:06:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-18-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> When building a KVM-only QEMU, the 'virt' machine is a good
> default :)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index d0903d8544..8e801cd15f 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -1,5 +1,6 @@
>  config ARM_VIRT
>      bool
> +    default y if KVM
>      imply PCI_DEVICES
>      imply TEST_DEVICES
>      imply VFIO_AMD_XGBE
> 

Likewise SBSA_REF?  Otherwise, what is this for?
Did you remove ARM_VIRT from default-config/*?


r~

