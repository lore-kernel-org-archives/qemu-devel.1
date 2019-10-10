Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290B2C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 00:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8666206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 00:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfuaHf1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8666206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIMfP-0004oR-4w
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 20:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIMed-0004F4-7q
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIMec-0005Hr-6i
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:50:07 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:45292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIMec-0005HU-2a
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:50:06 -0400
Received: by mail-yw1-xc44.google.com with SMTP id x65so1518043ywf.12
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 17:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TyY81SRlFFLzBC8zGurA01QzhPfmOfze6LH6hXxOGHI=;
 b=MfuaHf1YPszzjHTmkJZkVn5DhaN3+67xPHWEiIHvMrY55Hi+Xq1g/0Kdrbf3N3ZH/j
 0HtTgjqB5EzZMfVeefycG0VKg0eP3k+JXa9xyTGoLUNuQ5Bd84/uXXR0IOA1qAmFn7GR
 12pDGtQ2muwhVmqA/6Loozfuv3acKBHYYgPRmfqgHKLr8GQtZVpaZEW3YY3TQzluBQ1T
 brI7ggslO3AeLY6bftFFpPdqLPtvtAhuBt2T+zUXBzU1v522JK78pVDxPrMthpU33mxM
 IdEk7TElWa2stX+w5KCeaizhqURV/uLITWlB6npmEBMX7WJg7cMx4gCRT7xF3l2fpBY6
 jxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TyY81SRlFFLzBC8zGurA01QzhPfmOfze6LH6hXxOGHI=;
 b=dNZb+hNKBqk7PhmzqoK2MqvkQhbpBL9i0SmILUEu2HVovathyQOiqGOeEfLkWUR4mI
 58/+K2A5HWCtCTTd1K45ZoqENSETqp3aP47g/VXMJ+mBE3oCRE94cUlisrzM4PFjVJ/2
 KBxEV2qfa1YCMlkPPFbRZPyAUEbGjeOfWmMSEzGi1TBcxc1sqQL1xGlE4B4ge77Ggt7o
 ClBWzOopyaIJ2oJZv6amIoM6M8Qq45wthDAH+dN4Q/nxJS8wDXZjcYPPva8hF7673iMg
 xXifxPxeT/K6A57CntQWarBm7q9NyirC24TrebDBbRqhNMhGt2TWJy3wkcPf+qqDukxp
 BFuA==
X-Gm-Message-State: APjAAAX7TM6AbBgH6tNVlYGLrydGfhjUPTZEWM8fY6CGEHcPeT/H8kkr
 6/qf7Dq6K9nk81EP53z66UDXZQ==
X-Google-Smtp-Source: APXvYqy3r2PPrGvOYctnr8s8Fyjaoi8A/cbNlLcVisciHCan0gRY04ei+NiN838m//4Cb/GugGrmZg==
X-Received: by 2002:a81:1058:: with SMTP id 85mr4794026ywq.110.1570668605317; 
 Wed, 09 Oct 2019 17:50:05 -0700 (PDT)
Received: from [192.168.1.44] (67.216.151.25.pool.hargray.net. [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id 12sm1070482ywu.59.2019.10.09.17.50.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Oct 2019 17:50:04 -0700 (PDT)
Subject: Re: [RFC PATCH 3/5] target/arm/kvm: Implement cpu feature kvm-adjvtime
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191007170622.1814-1-drjones@redhat.com>
 <20191007170622.1814-4-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <892976b9-0e43-940d-1d36-046749d652c9@linaro.org>
Date: Wed, 9 Oct 2019 20:50:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007170622.1814-4-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 1:06 PM, Andrew Jones wrote:
> +static void kvm_arm_vm_state_change(void *opaque, int running, RunState state)
> +{
> +    CPUState *cs = opaque;
> +    ARMCPU *cpu = ARM_CPU(cs);
> +
> +    if (running) {
> +        if (cpu->kvm_adjvtime) {
> +            kvm_arm_set_virtual_time(cs);
> +        }
> +    }
> +}

Worth putting this in kvm.c too, so you don't have to duplicate it?  You can
always split it apart later if you ever do need a different hook for 32 vs 64.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

