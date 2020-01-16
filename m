Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA65C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191D22072B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gf9kufkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191D22072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2zK-0007B2-4c
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is2yb-00060M-La
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is2ya-0004Qc-7S
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:06:13 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:45496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is2yZ-0004PL-W9
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:06:12 -0500
Received: by mail-oi1-x230.google.com with SMTP id n16so18502878oie.12
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NXs9zejndSKn58taRfp3OhJmHFveZnbnUxGrW0n4mYc=;
 b=gf9kufkS8+lJ/lcLjzaXcj3peGPEkEW6oS+bGX78afCakKebr/kL1EvfJkaPOVzSER
 FU5jdxH3O8YypPTkiWigRiSWThCTO+7oATbkL9o1y8JFlhYoUZOGY/poEbka6xphHI3V
 4fU3oToPCu+z4+GPmf4lBkDAjeb05y53C5cYRLXtA7OBaVMIGhJfk3zGaq8VWweJKMkV
 8VtCHnkLsNG3qqBW4dVgqtXq0GpZnSI6AjjYk1eFJ+g/Rh/V7KmDKAPEtjPCMOjguc86
 1vhcJyIq60xWLRdfk0/VDvgqMy1tpbxEtYBco56amr/wRK0j4qTHfPyseGEHzxHc6iFo
 GC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NXs9zejndSKn58taRfp3OhJmHFveZnbnUxGrW0n4mYc=;
 b=r3w8pOscbVOmVNaWJlMFJrsrrHrpzdH6Q7o+FBFJGvorTtjxG9t9Q0+CRNRWpywY57
 PIbmynGRTIcTsyiaimEyS2jfTidjCyIe+4/hCxhpL42dPxz/hIrBxsT8/j6NhE4WqA5K
 8Au1n0poo8pRLpMlRWnkCXwiJDfX3kKP0qZSmdHRfeEuUQajXkvTtUKX8PuZR7InQs8u
 DNeJVQbNzN4CDh06Mi7SGseEub2KEELXpOxfn3DYE4437LtyWxtfquQXxpxBVpk50SMR
 mNd9NsyKKBtHybvEpHWSJ5dZpC3C0tJFTq9FygM8DzMNu1Ab05MERp+gDYIeSZExTIvq
 +OQw==
X-Gm-Message-State: APjAAAURg2qbCHdiVr+d+XkKFO7WKVV+V6AKDt9bRLjK877+rRT9pV7P
 d0T9tTcFPomFZVUkZcgMR6xs9592JzRos0Vkb0wq5gtTXvk=
X-Google-Smtp-Source: APXvYqxzU3UK5yklKHGc9cNeUWtTTJkyFo4NmjuEy5IbNUpk9JUoiScFdzGmVvrxrr1Nf/oVfxjqJMFIo7IsXefKmFw=
X-Received: by 2002:aca:f484:: with SMTP id s126mr3479891oih.48.1579172769658; 
 Thu, 16 Jan 2020 03:06:09 -0800 (PST)
MIME-Version: 1.0
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <CAFEAcA-A_caQgwi5DzExdZChoTg-Qa73hq7Ho7dPLiN633Yj1Q@mail.gmail.com>
 <3ab2ca1f7a9b37b201a58f3a817edc5193e8b1f4.camel@kernel.crashing.org>
 <CAFEAcA8mphBky9Q2HTdOpQHiizd+5-o=yRnBbd_k1y6Uk-h8dA@mail.gmail.com>
 <5dabf7d9e2af43d6c01d2e7e51e466616d84a8df.camel@kernel.crashing.org>
In-Reply-To: <5dabf7d9e2af43d6c01d2e7e51e466616d84a8df.camel@kernel.crashing.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 11:05:58 +0000
Message-ID: <CAFEAcA8yhB_POKJbXNykvyH+dx5Xb00GgT0qciNfCxLOQzuRuw@mail.gmail.com>
Subject: Re: Semihosting, arm, riscv, ppc and common code
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Packard <keithp@keithp.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 at 02:01, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2020-01-15 at 13:32 +0000, Peter Maydell wrote:
> > On Wed, 15 Jan 2020 at 01:17, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > > On Tue, 2020-01-14 at 09:59 +0000, Peter Maydell wrote:
> > > > Note that semihosting is not a "here's a handy QEMU feature"
> > > > thing. It's an architecture-specific API and ABI, which should
> > > > be defined somewhere in a standard external to QEMU.
> > >
> > > There is no such standard for powerpc today that I know of.
> >
> > So you need to write one down somewhere. You're proposing
> > an ABI which will be implemented by multiple implementors
> > and used by multiple consumers. That needs a spec, not
> > just code. I don't want to see more semihosting implementations
> > added to QEMU that don't have a specification written
> > down somewhere.
>
> That's ok, I can probably get openpower to put a link to the ARM one
> somewhere :-)

Minimally, you need to say:
 * this architecture follows version x of the Arm semihosting
   spec [and give URL]
 * specify the equivalent things to the 'The semihosting interface'
   part of the Arm spec:
    - instruction that causes the trap
    - what the OPERATION NUMBER REGISTER, PARAMETER REGISTER
      and RETURN REGISTER are for your architecture
    - what the data block field size is (32 or 64 bit)
 * say whether your SYS_EXIT is doing the silly 32-bit Arm
   thing or the more sensible allow-app-to-specify-exit-status
   64-bit Arm thing (you should choose the latter!)
 * if you want to make either of the 'semihosting extensions'
   (which fix missing features) mandatory, say so here
 * does your architecture need to define some SYS_EXIT
   codes? The Arm ones have a lot of arm-specific stuff
   like "stopped because of prefetch abort"...

> > The point about the mistakes is that you can't easily fix
> > them by adding extensions, because the core of the biggest
> > mistake is "we didn't provide a good way to allow extensions to
> > be added and probed for by the user". So we had to implement
> > an ugly and hard to implement mechanism instead.
> >  New
> > architectures could mandate providing the good way from the start
> > and avoid the painful-to-implement approach entirely.
> > (I think RISCV has already missed this window of opportunity,
> > which is a shame.)
>
> It is done and so now we have two architectures using that standard, I
> think the value in using the same overweight the value in fixing it but
> yes, we should try to agree on a method of extending at least. Is it
> really that hard ?

It's hard if you don't do it from the start. This is why the
Arm spec's feature-query API is "open a magic filename" --
we couldn't guarantee that existing implementations wouldn't
blow up/crash/etc if the guest code attempted a new "query
feature" semihosting call that didn't exist. If you can
reliably say "all implementations of semihosting for this
arch will fail ENOSYS on unknown semihosting calls", or if
you put in a get-feature-flags call from the start, you don't
have that problem. Otherwise you're stuck with doing it the
way the Arm version does (which requires your implementation
to actually track file handles so it can distinguish "magic
feature-flag file" from "normal host file"; it can't just
pass through host fds/handles to the guest).

Similarly, actually specifying errnos is only easy if you do it
before any implementations.

> IE. We could add a new call for capabilities that takes a pointer to
> a region which we pre-zero before calling in the client and if remains
> zero after the call, then the new stuff isn't there for example. That
> sort of stuff is easy, or am I missing something ?

The problem is if you do "call" and then the implementation
does "kill the VM" or "drop the user into the debugger"...

thanks
-- PMM

