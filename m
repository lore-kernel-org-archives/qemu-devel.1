Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85573C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5230F208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOgg6EEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5230F208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47L9-0005JP-J3
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j47KO-0004mj-BK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j47KN-0006Nw-3M
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:10:36 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j47KM-0006Mt-U4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:10:35 -0500
Received: by mail-oi1-x244.google.com with SMTP id q81so21079294oig.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 10:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J+VIy0O5XdXZKn07jkrMRNJeMKYOXzruO3DBnEKwlT8=;
 b=DOgg6EEq9cwk+Jtm3QnUh9xUgFN7XzRfx1Y+RLplYTPOEJsX620wD2C4VShobOQ/dA
 FZwft3HHGX2hdh8mIKps6W1Hh+86wCJ2NmcxOo2P0FKM7jHDGu5MWW4Qyo+Mp8kuLSAp
 SFMhn/qa+mBipYRDlWfzXhcy4YW5hZaHsfVtJogDf+PypSIkrTfh7VmPENfJ42Uv2Mqd
 2xso3YHBnCu32qvvvLjyK+GoxDpfChQWSveVY8YxUY15YwnSbzARO46/fygVfJFGZ26g
 dFCyCauBsXrULr4J3QvFphS285mLlH6/0xAr6SKJ7lTbrU/caoVKrcdU6SK697Dm16Ol
 V6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J+VIy0O5XdXZKn07jkrMRNJeMKYOXzruO3DBnEKwlT8=;
 b=pEx2rvu/2MVobmZa6W+UQRyNaAc87gnnMVZ/xwR3WgCdFzktFvF6q/9KJ+ihieKgQ+
 W3CE+BMYYKPaejN0SjOY1Kh4FsqIGqN7g6EhA2K82zUq2ZoDzVBXcAqX2e4wjnoX6yjJ
 Gh+txn2XS5r/1z/LxWz+et78tjs/XYDwY3ggiF74JRS1gknqV22SeI6yK0GeQSdry8OY
 uJOLKgL02R7QX+mDiuxKAT1upFcyVWL1B/7aWPn77gisk8I5xU3SnsrkHjxMK4MU+63y
 aN7XNljf6Hi2C0d/RJz/hXQLLdfVJUFOAhnL7cWfNGp5HNE9hAzkaWsLPAUYKeUKNBOt
 BfHw==
X-Gm-Message-State: APjAAAUskZn+lyRYcE7QrX5U8DARpmBejsZSxJybKQNWyusHCqbe6L7l
 frOS6E/wUFvJghkaL9NLt6vKB+eqle0TzGlA+Dri1w==
X-Google-Smtp-Source: APXvYqwoiRYzdhhJm6piXnv1ajLUsZNybzWgOD76ArK3fYwTguTTlCzNOhDLfXXN1AxAnDCPpL1Rtma4GiipD4pb3pU=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr2092130oid.98.1582049434017;
 Tue, 18 Feb 2020 10:10:34 -0800 (PST)
MIME-Version: 1.0
References: <1581686212-9625-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1581686212-9625-2-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1581686212-9625-2-git-send-email-sai.pavan.boddu@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 18:10:22 +0000
Message-ID: <CAFEAcA-+=DrPkRE1sGNSNEBhaXYsUNi=-tOy58cZ3f1OiV2QVA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm_gic: Mask the un-supported priority bits
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Fri, 14 Feb 2020 at 13:21, Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
>
> Priority bits implemented in arm-gic can 8 to 4, un-implemented bits
> are read as zeros(RAZ).

This is nice to see -- I've known our GIC was a bit out-of-spec
in this area but it's good to see it's less painful to
retrofit than I thought it might be.

> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/intc/arm_gic.c                | 9 ++++++---
>  hw/intc/arm_gic_common.c         | 1 +
>  include/hw/intc/arm_gic_common.h | 1 +
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 1d7da7b..8875330 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -43,6 +43,9 @@
>          }                                                               \
>      } while (0)
>
> +#define UMASK(n) \
> +    ((((1 << n) - 1) << (8 - n)) & 0xFF)

This is a bit confusingly named (usually 'umask' is the file-permission
mask on unix). I think it's worth following the pattern used
in hw/intc/arm_gicv3_cpuif.c for icv_fullprio_mask(), and using
a function with a comment describing it. Also, you've not considered
the virtualization parts of the GIC, which also use these
codepaths. In those cases, the value of the mask is always
based on GIC_VIRT_MAX_GROUP_PRIO_BITS of priority (a GICv2
has 5 bits of priority in the VGIC, always). So:

static uint32_t gic_fullprio_mask(GICState *s, int cpu)
{
    /*
     * Return a mask word which clears the unimplemented priority
     * bits from a priority value for an interrupt. (Not to be
     * confused with the group priority, whose mask depends on BPR.)
     */
    int pribits;

    if (gic_is_vcpu(cpu)) {
        pribits = GIC_VIRT_MAX_GROUP_PRIO_BITS;
    } else {
        pribits = s->n_prio_bits;
    }
    return ~0U << (8 - s->n_prio_bits);
}

> +
>  static const uint8_t gic_id_11mpcore[] = {
>      0x00, 0x00, 0x00, 0x00, 0x90, 0x13, 0x04, 0x00, 0x0d, 0xf0, 0x05, 0xb1
>  };
> @@ -652,9 +655,9 @@ void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
>      }
>
>      if (irq < GIC_INTERNAL) {
> -        s->priority1[irq][cpu] = val;
> +        s->priority1[irq][cpu] = val & UMASK(s->n_prio_bits) ;
>      } else {
> -        s->priority2[(irq) - GIC_INTERNAL] = val;
> +        s->priority2[(irq) - GIC_INTERNAL] = val & UMASK(s->n_prio_bits);
>      }
>  }

Slightly cleaner to just put
   val &= gic_fullprio_mask(s);
before the if() rather than doing the same thing in both branches.

>
> @@ -684,7 +687,7 @@ static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
>              return;
>          }
>      }
> -    s->priority_mask[cpu] = pmask;
> +    s->priority_mask[cpu] = pmask & UMASK(s->n_prio_bits);
>  }
>
>  static uint32_t gic_get_priority_mask(GICState *s, int cpu, MemTxAttrs attrs)
> diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
> index e6c4fe7..e4668c7 100644
> --- a/hw/intc/arm_gic_common.c
> +++ b/hw/intc/arm_gic_common.c
> @@ -357,6 +357,7 @@ static Property arm_gic_common_properties[] = {
>      DEFINE_PROP_BOOL("has-security-extensions", GICState, security_extn, 0),
>      /* True if the GIC should implement the virtualization extensions */
>      DEFINE_PROP_BOOL("has-virtualization-extensions", GICState, virt_extn, 0),
> +    DEFINE_PROP_UINT32("num-prio-bits", GICState, n_prio_bits, 8),

In patch 2 you use "num-priority-bits" for the proprety name
on the a9mpcore object. I like that better, and I think we
should name the property the same thing on both devices.

You should have some code in the realize method which sanity
checks the n_prio_bits value we are passed. It can't be
more than 8, and I'm not sure what the lowest valid value
is. Your commit message says 4. I'm pretty sure that if the
GIC has the virt extensions then it can't be less than
GIC_VIRT_MAX_GROUP_PRIO_BITS (ie 5).

thanks
-- PMM

