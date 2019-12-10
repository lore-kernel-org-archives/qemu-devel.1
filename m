Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF47AC2D0C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD184206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMctcl63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD184206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iehlU-00065p-Fl
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 10:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iehjs-00050p-G0
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iehjr-0003rQ-Ey
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:47:52 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iehjr-0003qB-88
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:47:51 -0500
Received: by mail-oi1-x242.google.com with SMTP id i1so10187339oie.8
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 07:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XPpi0vWeudD6eliQvYxFheqKFj6RhBHkYhtXnEujgKU=;
 b=ZMctcl6378t/GTgCTqQheHWa40RYt9BQRLQFkr3hs7KrhmWKUnIRwlRQ85I+g2sXKr
 8KNkl/UEDjq1vBZf3lN7J/cpPcgsYZqdhfb5sxgeu3mpTtHgGbeVaTWctrtSqvU1hUFu
 GSL/h4jvj/Lk0dhgVWk936q0Ggly9hj8G0R1rWdcg3uliWT2P0OSG1sAPS4LlQZUZ6zP
 9R2bLQXUkOVb1tAFtHP/6QcRHp+ynmfs+vxmSaG1elnh5EXKJ6lqXmS+Pai22xzoygWr
 shzMPwpfUYpiNCM1Ziy6FrIaEaTR5pjv0RWHNRqSNtSpinfumFMOL1UWGIpzI3e8d93h
 /HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XPpi0vWeudD6eliQvYxFheqKFj6RhBHkYhtXnEujgKU=;
 b=SRBFJQlYJuKNNUdJ5nNL1XQcfk7K4hHzGkDNMq9WkcCvmrkAHQnGgfQfyDcZLziwJY
 9opGGqVPfJPjz2C/T+omp5JsOUu3Zt+I01sdvyL8/wE8bJlBBJ4m8SfiRv6a/qeKCWpL
 NpGYM6t74ory4YhFMC6qEjqNEmP9lcWbzhIgw3PBtn/bqy67Y3EQ/TUsVdrSq11JW2jr
 XVWg0JtzndDBG7ojZNMdRagDXqS2jLW1QmvHzU9b4yabEkYjVr+jXpR03Ex+B2md98GT
 ka5kqWNPGU70wvpiLOfTkglA93CPJ/Q+bfUUHHAdBl/j45+2d89LoBuLHRUYjNh/VdQ/
 SZQA==
X-Gm-Message-State: APjAAAXOW8WWcnjc1lbLy9abLegu/TYrkBeLlfvOU4FqTxJUha4Zr0c2
 ywngXK4KcXr2akAh2XwXCyTDSZ4HV8xWrdw5MfTMtA==
X-Google-Smtp-Source: APXvYqzjzjCGxfqhWqUxs527OoEU8tYHKNRXvPQyjvdNKQD7l5ahY5zXiPjh20bYvn/5Y6BM31prx2/EUuht7mOo6aE=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr4257367oic.146.1575992870184; 
 Tue, 10 Dec 2019 07:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20191016143410.5023-1-drjones@redhat.com>
 <20191016143410.5023-3-drjones@redhat.com>
In-Reply-To: <20191016143410.5023-3-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2019 15:47:39 +0000
Message-ID: <CAFEAcA-a9O88EbKqSNxb_7GLVZzC+dx0daEWyAAe9SS4SRa1oQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] timer: arm: Introduce functions to get the host
 cntfrq
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, bijan.mottahedeh@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wrote:
>
> When acceleration like KVM is in use it's necessary to use the host's
> counter frequency when converting ticks to or from time units.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/timer.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 85bc6eb00b21..8941ddea8242 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -1006,6 +1006,22 @@ static inline int64_t cpu_get_host_ticks(void)
>  }
>  #endif
>
> +#if defined(__aarch64__)
> +static inline uint32_t cpu_get_host_tick_frequency(void)
> +{
> +    uint64_t frq;
> +    asm volatile("mrs %0, cntfrq_el0" : "=r" (frq));
> +    return frq;
> +}
> +#elif defined(__arm__)
> +static inline uint32_t cpu_get_host_tick_frequency(void)
> +{
> +    uint32_t frq;
> +    asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=r" (frq));
> +    return frq;
> +}
> +#endif

Don't we want to know what the guest counter frequency
is, not the host counter frequency? That is, I would have
expected that we get this value via doing a KVM ONE_REG ioctl
to ask the kernel what the guest cntfrq is. Are we using
the host value on the assumption that the guest might have
misprogrammed their copy of the register?

thanks
-- PMM

