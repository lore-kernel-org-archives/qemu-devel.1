Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCD4C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C14208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prw/lj0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C14208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AHA-0001fc-2N
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AG0-0000PP-IX
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AFz-0002ft-5Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:30:24 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5AFy-0002f0-Un
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:30:23 -0500
Received: by mail-ot1-x342.google.com with SMTP id h9so2295779otj.11
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 07:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8q1sawrAR7L0CtEGCE+s9tKiGKo+ZNnF45eMhlEP5bk=;
 b=prw/lj0MFL1ohYfunJmvfyt8+yw1W2KsB0Dkb0yrTyiVqOL1aknpqtDry7n1OmCrVA
 DKHZjjC4V3wje41lNWrObHfuH4zowyxjvilsMENtjAdvJaL/71w1glKUwM5oG7fobItf
 vtCR5sH/O7AsDWzJYlKXvZzntbEBhJJqFwmcG9JUf+2aZZsYmFET8xTtudRJLaAQFrPP
 /QMaxkGKElvbCGLCgvzvIHSqn2x1cL/2cIAslJkH0naFJKQzkqzAyGP5G1MjW/8dU/CU
 nmrXYVL2z9xlods4Q4e+uhdchgI/C+7lXrHzCC4yKFmKvPTYPjnBiY/TnJUsWfGyb8LY
 tKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8q1sawrAR7L0CtEGCE+s9tKiGKo+ZNnF45eMhlEP5bk=;
 b=CYtjdiaOYVoPxPJU17HFRHFVLQiDuC/IqYJKVh4XDhjEvNjwrj55aYl0J9bj8muvmv
 9WP88E5Ii8nRaMn9OvSUbXSI+BW6TUbtPPyD/nsv5GrqeNCe0Vv8AA2LIE8oD48gB7y8
 JiPWS31dNhPj/CLxi//HWld2MvCy9nkiT2MHYK4a6x5nLOXERk6Dv07zSE6w/Ayi8t9c
 c6P5zECngGGgbZw4na3XOHOBOq8Aija4sMMW97CgMtI0Ej/Q2G7SX+eBHOh4srkyzDyh
 1GzAGUYVdKdpe90macnEVIhNlESmzlao22DTLTjDW2dDPtgwGvnEbKnN/FMvCOiTTorB
 4Otg==
X-Gm-Message-State: APjAAAWmEOT3ByCeH7WFy0vFw1nMEb/ixQqimF3MU6/fK/GMmcxvWeno
 MS4y4M2Sxuq1H+K9iROTbEyAmskwiV9I+j8u0Om9AQ==
X-Google-Smtp-Source: APXvYqxvKMctwVhcPPp3ymAsEEgVNouQ1f6ZSyJLqu4vvtSGX+0sY304GPhEh7EfBcxeulUep0maq9mi0+v9ZWycpGs=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr28894585otd.91.1582299020896; 
 Fri, 21 Feb 2020 07:30:20 -0800 (PST)
MIME-Version: 1.0
References: <1582270927-2568-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1582270927-2568-2-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1582270927-2568-2-git-send-email-sai.pavan.boddu@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 15:30:10 +0000
Message-ID: <CAFEAcA-NYkaQuJq=0Ft7j0XEPqJQz=G=wwKTWTxdbCmSRUh6uA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm_gic: Mask the un-supported priority bits
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Anthony Liguori <anthony@codemonkey.ws>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 07:46, Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
>
> Priority bits implemented in arm-gic can be 8 to 4, un-implemented bits
> are read as zeros(RAZ).
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/intc/arm_gic.c                | 26 ++++++++++++++++++++++++--
>  hw/intc/arm_gic_common.c         |  1 +
>  include/hw/intc/arm_gic_common.h |  1 +
>  3 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 1d7da7b..dec8767 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -641,6 +641,23 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
>      return ret;
>  }
>
> +static uint32_t gic_fullprio_mask(GICState *s, int cpu)
> +{
> +    /*
> +     * Return a mask word which clears the unimplemented priority
> +     * bits from a priority value for an interrupt. (Not to be
> +     * confused with the group priority, whose mask depends on BPR.)
> +     */
> +    int unimpBits;
> +
> +    if (gic_is_vcpu(cpu)) {
> +        unimpBits = GIC_VIRT_MAX_GROUP_PRIO_BITS;
> +    } else {
> +        unimpBits = 8 - s->n_prio_bits;

This isn't right; GIC_VIRT_MAX_GROUP_PRIO_BITS should
be handled the same way as s->n_prio_bits. The expression
I suggested in my comment on your v1 should work:

    if (gic_is_vcpu(cpu)) {
        pribits = GIC_VIRT_MAX_GROUP_PRIO_BITS;
    } else {
        pribits = s->n_prio_bits;
    }
    return ~0U << (8 - s->n_prio_bits);

> +    }
> +    return ~0U << unimpBits;
> +}
> +
>  void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
>                        MemTxAttrs attrs)
>  {


You seem to have lost the part of the patch which applies
the mask in gic_dist_set_priority(). If the GIC only
has 5 bits of priority we should not allow the guest to
set more than that.

> @@ -669,7 +686,7 @@ static uint32_t gic_dist_get_priority(GICState *s, int cpu, int irq,
>          }
>          prio = (prio << 1) & 0xff; /* Non-secure view */
>      }
> -    return prio;
> +    return prio & gic_fullprio_mask(s, cpu);
>  }
>
>  static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
> @@ -684,7 +701,7 @@ static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
>              return;
>          }
>      }
> -    s->priority_mask[cpu] = pmask;
> +    s->priority_mask[cpu] = pmask & gic_fullprio_mask(s, cpu);
>  }
>
>  static uint32_t gic_get_priority_mask(GICState *s, int cpu, MemTxAttrs attrs)
> @@ -2055,6 +2072,11 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>
> +    if (s->n_prio_bits > 8) {
> +        error_setg(errp, "num-priority-bits cannot be greater than 8");
> +        return;
> +    }

You need to also check that the value is at least as large
as the lowest permitted value, as I suggested in my v1 comment.

thanks
-- PMM

