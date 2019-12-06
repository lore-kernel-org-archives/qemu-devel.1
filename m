Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6CBC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2C224673
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrtWG3af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2C224673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idInO-0005b4-38
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idICk-0001rO-Cr
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idICj-0004YD-5Q
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:19:50 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idICi-0004U7-PS
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:19:49 -0500
Received: by mail-ot1-x341.google.com with SMTP id x3so6550554oto.11
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a7iFGDNmOYAA9dOYKmbmOnb4PW7CEEq6Dh2sdZNZyq8=;
 b=zrtWG3afJHMHSaf06bbhFWsks46pJZlyyNvGSYPWO5obAZV2k28x5n33G+2epvzPz3
 JoqDbKmF3dl8EeQabQjPZCgd7IO1hEWqvUuIKoJZZ3rS1JAFHkUB/4Rf0caX0tL10W/y
 CqoZf9yy59QzTsfRsUGWzS0tX1WiRGstGMJo+hRrKABTfcwrLzKFUCUC9L0GzOy5XQsN
 kH8yrb97ay5M+3pKF+ZXvrsgcsJgRnda7Kc2Is/1uV2dt2m8JR4XFfCbWBeIrWkfWfSD
 UXPd7eNXa/QR8guKtxW2DQl9BrGWeXHv4mV07KERC5MFDwWE7DDmeBUTi/ZuxLCrGPcW
 dRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a7iFGDNmOYAA9dOYKmbmOnb4PW7CEEq6Dh2sdZNZyq8=;
 b=VDtSM2asr4ETZkFCf3g/dx5X1rLOJa7e1HP4ZeCM0ZDo0Kfj0rIvtULmsKZjSn01VO
 af5SJn537kiOtAEhGGUgAZBNKnwCjmbHtfqju8cayAM5NpIcGlRM+NK2KzapRl7UwzQ7
 KUvfgcg8wcz5k8agaifsgpCRhpC9pZTNj/dFBZWbQzxDOrrj2KdEEtWfwgyssyytsj+t
 /LVyGzvpjoN2NJJjaTkYyOrdBgicxY8yT72YiAfIas+Q1d1m4Yw5qoNFD5JMrcQeeubR
 sE7N/3AMaecRxnMjp9R5H91ySA1GYmF/ITr/gUNWKy3BxcmM0etVcym69CCCqDSiAbyc
 Czhg==
X-Gm-Message-State: APjAAAV97s5+4JFi3Q16tx3QSBAgA7RRx4oaameTpsukP7k6VeU3n1g1
 OkI5qKMSDylWqKd9Fk3zRpdxcjh9aAzwnP8mQUocvw==
X-Google-Smtp-Source: APXvYqzD2UhV+ya4YFfliucZgWOBfspVNE6QI9eWrQOTAkm2YblPZ17yIsEkCb8mNc4aXcNBCRd+Fz2oYyGoVS+Bq4Y=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr11630115otm.221.1575656387810; 
 Fri, 06 Dec 2019 10:19:47 -0800 (PST)
MIME-Version: 1.0
References: <20191203234244.9124-1-richard.henderson@linaro.org>
 <20191203234244.9124-2-richard.henderson@linaro.org>
In-Reply-To: <20191203234244.9124-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 18:19:36 +0000
Message-ID: <CAFEAcA9wOmOdddzr+5RfBsTJ+nHF4bqTVs0C1Uj228f28U_SMA@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/arm: Add ID_AA64MMFR2_EL1
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 23:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add definitions for all of the fields, up to ARMv8.5.
> Convert the existing RESERVED register to a full register.
> Query KVM for the value of the register for the host.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    | 17 +++++++++++++++++
>  target/arm/helper.c |  4 ++--
>  target/arm/kvm64.c  |  2 ++
>  3 files changed, 21 insertions(+), 2 deletions(-)

> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 876184b8fe..482e7fdfbb 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -549,6 +549,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>                                ARM64_SYS_REG(3, 0, 0, 7, 0));
>          err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
>                                ARM64_SYS_REG(3, 0, 0, 7, 1));
> +        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
> +                              ARM64_SYS_REG(3, 0, 0, 7, 2));

Do current KVM kernels definitely handle the request for this
new register (ie don't return an error)?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

