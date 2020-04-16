Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22B9C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 12:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885AD20767
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 12:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="exqQa5S5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885AD20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP3Kr-0003uX-MP
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 08:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP3K8-0003N3-Tj
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP3K7-0006aK-QF
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:08:52 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP3K7-0006ZW-Et
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:08:51 -0400
Received: by mail-oi1-x243.google.com with SMTP id x10so6930643oie.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NywJugj7NuJi7HibrnT8U9f5/OVGMNdGm4E4uzj/oyw=;
 b=exqQa5S5zMSWUHSxgEYAKzc6pslHS1Fv10xbFdKK0q1hCcqoq35edsLVuDzIu/gjn7
 Kb7QLi7hcpzHcrVLcGZuUIP4QKncxFOHZamXdSYqJMVQt6tU3PElX0gfYA4Qu2USfxFP
 zadPywPjvK3g/Cqu3aoYpScb3WD5Z4cPI62UmEuSa40nypViBV1BDPmjDi24MkuDE/wH
 J/9TQlUStr+937I5rbhpAhCRzZ5C+fSzeTXFjsBHeV2bBVYTNe21R33xcUdvq1GD6ypL
 Is+Nm9h9u4bDhpJGNl4d1N1qos2LP9Eo/M44hbOsRAhOqTsfTwap8wSJZctjTzjZ9DFc
 kliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NywJugj7NuJi7HibrnT8U9f5/OVGMNdGm4E4uzj/oyw=;
 b=mgdUXbCAAegzK86FOFKm2GBp04nCBXWo43MoPh+vTNr2xFpGEcHWwIJy5ZGjI9x2A8
 RqMIuZ4g7tg8RD1d7DJfp1pBpJa9I9Pcr5ifL8WMp8sXc3FbgMOVeTivdzSXIgRZwEdz
 0QOKlWtNcoRyR+M1tmjJxiXynL8x+aRhuzX0pwLSR+Nw1dzx54k8Xz2VUEGzuPNH8CYC
 sNQHmtbHaxz/iuN+/Y87d0dtX+WA/oeUXUa2hcU4ijaMRfzebLwJpgypH4GrrokExZA2
 0CogWopOT59GBN/3sD+J3JMKmIZNMteOZiXLEJCXx/aJ6QZnlHN7B5vyezAq3i5an0Nq
 x27g==
X-Gm-Message-State: AGi0PuY85fcX9P2SLnFCywtxWT2DtKVpxJw2yWCde4yAqC1TPFQjdzmg
 sLhsRsrf1a9DbZ0rvThmngw15JnxchquCadllIe8TA==
X-Google-Smtp-Source: APiQypJeq5i2M+MIc4qZNNOOJ0bFNN1R96utJmVJF5e603TA47sCL+OVytTkGVoaJA35ozFXEfTkl2pDYInjLMaROcg=
X-Received: by 2002:aca:3a8a:: with SMTP id h132mr2508446oia.146.1587038929881; 
 Thu, 16 Apr 2020 05:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-4-richard.henderson@linaro.org>
In-Reply-To: <20200311064420.30606-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 13:08:38 +0100
Message-ID: <CAFEAcA97saZB=8qbHxfJiNWXN4F916-ZqjaLt=-fzUzKcNmUFg@mail.gmail.com>
Subject: Re: [PATCH 03/16] exec: Add cpu_probe_watchpoint
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 06:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Allow probing of a watchpoint *without* raising an exception.
> This is of most use for no-fault loads, which should indicate
> via some architectural means that the load did not occur.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/hw/core/cpu.h |  7 +++++++
>  exec.c                | 19 +++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 73e9a869a4..8ec44267a4 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1090,6 +1090,12 @@ static inline void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>  {
>  }
>
> +static inline bool cpu_probe_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
> +                                        int flags)
> +{
> +    return false;
> +}
> +
>  static inline int cpu_watchpoint_address_matches(CPUState *cpu,
>                                                   vaddr addr, vaddr len)
>  {
> @@ -1104,6 +1110,7 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
>  void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
>  void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>                            MemTxAttrs attrs, int flags, uintptr_t ra);
> +bool cpu_probe_watchpoint(CPUState *cpu, vaddr addr, vaddr len, int flags);

Could we have a doc comment for the new function?

>  int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
>  #endif
>
> diff --git a/exec.c b/exec.c
> index 0cc500d53a..2b8f601b9e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2735,6 +2735,25 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>      }
>  }
>
> +bool cpu_probe_watchpoint(CPUState *cpu, vaddr addr, vaddr len, int flags)
> +{
> +    CPUClass *cc = CPU_GET_CLASS(cpu);
> +    CPUWatchpoint *wp;
> +
> +    assert(tcg_enabled());
> +
> +    addr = cc->adjust_watchpoint_address(cpu, addr, len);
> +    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
> +        if (watchpoint_address_matches(wp, addr, len) &&
> +            (wp->flags & flags) &&
> +            (!(wp->flags & BP_CPU) ||
> +             !cc->debug_check_watchpoint(cpu, wp))) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}

Clearly the insn emulation needs to do the right thing for
guest architectural watchpoints, but should a gdb watchpoint
also affect no-fault-load behaviour? I suppose making them
both behave the same way is probably the least-surprising choice.

thanks
-- PMM

