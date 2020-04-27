Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D70C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D40206BF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ssgFKFOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D40206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT6ht-00057f-41
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 12:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT6h0-0004Hy-7i
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 12:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT6gk-0000mw-Sy
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 12:33:13 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT6gk-0000m6-Eq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 12:32:58 -0400
Received: by mail-ot1-x344.google.com with SMTP id j26so27248182ots.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p17cZDIwneO/U0CNmCdokYFNYwmtPokiq0K2zTokMzs=;
 b=ssgFKFOyD6Jrus/kvpqLgZLhrLkxHOSk6FjBfp2ksJNLMc6TTFlLoPZhzuPv7DIz+R
 NWjdgeUuh5UPg1pE9j5SPU4DFMXriID9ZnEx+/x0JN9FGRGf/sE/MsaXa1QdD6dzDpnF
 vuLANdPJTh3sWbI9u4oY6EtZjgdxnKn+HjVpCLN3twVzPgGXLuAdFQAn+kLcXsweG3SZ
 2tdFiIOGUlIW2en0ufTORxCRFOfZUKSWEfIZfA2NLffXAyb21IL94SBAsTBIx9iDHyjY
 Tpl4zWtwNcfXNmVCrlhWw+piJNrsbCtFOk1qPV81zFFPrGFGevzflHw/o/cLbAeY2Ib2
 /XkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p17cZDIwneO/U0CNmCdokYFNYwmtPokiq0K2zTokMzs=;
 b=r0P7nzXg7AvyNmCmWjsDj8F4z8jDRoQDQSugmJ/34zF/ZGuB6PQVLX+xENfEfQLGxz
 S0POKpdDsgTUNjSLWoU0WrR25B/GH+Mjly1gzCqkuUC/PeD7fog9aX2W/15DdvZghdIA
 DZPcECkbGA3VlltUQuAKf9I6hwWfjP7OJjyTswp801iiVTWt+r/3tgyHJJjbJL/y5tav
 K07UU8cNyDIWO8Ygsj1wmlFaRUHmmWwWAeI/h0BvGK9k37k6a/IXMklVCnztt3psZekn
 rR94uoBI8kC0A2A6tQWEocy97bmBvL1nt3gvoqDR5SkH3kzTHaBtIOJgfHBFOH2431pF
 XmmQ==
X-Gm-Message-State: AGi0PuaUAN91cOLPnnZxI7IqqdaxIHfENKngVY/QK39oVGpIZO3Y4yPc
 27/IpwEmvzMaq7XpcoXRqLslZKKqCP6hdO92RCAy5w==
X-Google-Smtp-Source: APiQypJl0+IPEFSJZsP5s0Bl8vNyb7ojHZgakKaZQj3/tftuBF1F/Y6z4BXcdst8vR1vTMgyrifaMz7op4Z+bdnW5bI=
X-Received: by 2002:aca:c751:: with SMTP id x78mr16510058oif.163.1588005174575; 
 Mon, 27 Apr 2020 09:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200422043309.18430-1-richard.henderson@linaro.org>
 <20200422043309.18430-14-richard.henderson@linaro.org>
 <CAFEAcA8oWP9XGzD+pb_VhDth8zx8j1Gz4vwiK+dArpw8x1BmqA@mail.gmail.com>
 <22c1fd55-7cd3-6320-1f90-40d1bd2cc883@linaro.org>
In-Reply-To: <22c1fd55-7cd3-6320-1f90-40d1bd2cc883@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 17:32:42 +0100
Message-ID: <CAFEAcA-iqrEi_wQ+mBN1NtrEKq3uDYPoDunqW5e9KV6ivz3-SQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/18] target/arm: Update contiguous first-fault and
 no-fault loads
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::344
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

On Mon, 27 Apr 2020 at 17:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/27/20 4:03 AM, Peter Maydell wrote:
> > On Wed, 22 Apr 2020 at 05:33, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> With sve_cont_ldst_pages, the differences between first-fault and no-fault
> >> are minimal, so unify the routines.  With cpu_probe_watchpoint, we are able
> >> to make progress through pages with TLB_WATCHPOINT set when the watchpoint
> >> does not actually fire.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >
> >
> >>      /*
> >> -     * Perform one normal read, which will fault or not.
> >> -     * But it is likely to bring the page into the tlb.
> >> +     * From this point on, all memory operations are MemSingleNF.
> >> +     *
> >> +     * Per the MemSingleNF pseudocode, a no-fault load from Device memory
> >> +     * must not actually hit the bus -- it returns (UNKNOWN, FAULT) instead.
> >> +     * If you map non-RAM with Normal memory attributes and do a NF
> >> +     * load then it should access the bus -- but doing so is illegal.
> >> +     *
> >> +     * While we do not have access to the memory attributes from the PTE
> >> +     * to tell Device memory from Normal memory, we can validly assume that
> >> +     * non-RAM has been mapped as Device memory.  Thus we indicate fault
> >> +     * on all MMIO.
> >
> > I still don't understand why this is right. All non-RAM is MMIO
> > but not all MMIO is non-RAM; so you might have something that's
> > MMIO (at least for the moment) and has been mapped Normal. That
> > shouldn't fault.
>
> Everything that must go through the slow path has TLB_MMIO set.

Yes. But not everything that goes through the slow path is Device memory.
We can (should) fault on all accesses to Device memory, but we can't
fault on all accesses that are slow-pathed, because some of them could
be entirely valid Normal memory.

> What you're thinking of, romd, has TLB_MMIO set on the write comparator but not
> the read comparator.

True when the romd device is in 'romd mode', ie mr->romd_mode is
true. Otherwise memory_region_is_romd() returns false and
tlb_set_page_with_attrs() treats it like normal MMIO, because
both read and write must take the slow path. (For flash this
happens when it is put into programming mode and reads from
the memory region are no longer simple reads from the backing
host RAM.)

thanks
-- PMM

