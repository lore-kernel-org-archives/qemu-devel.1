Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46091C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC90206A2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="csguGd7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC90206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3mU-0008O4-8K
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:24:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44702)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3DZ-0001Sn-0l
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3DU-0001Ae-H5
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3DU-0001A4-BH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id x21so14875820otq.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QJs+wnP7c3BpRJI+8igklFziS6QGCIHoT3iDWYUKOyA=;
 b=csguGd7kk8DWw7OoY2fZ/gwKDwN5XOwl1Ib7+RiLqkWgxzNfy8e/so15aWFOEWlFw4
 2pvf2tn/5f2gZX0R0rg1ODSKVQ3Vwf6bb58dQiEtVPD17/jKG1oY/2IU77R6WoA0shUJ
 QMJsF/Virm46bRxopQZGXe5KBJzqlsTUvoEbVE20BlrtTN5iJzPTLR+7sBjKc0aVR8P6
 Bkv6yLUGTFviGw7wp41JWET224Pbj5Nwzo7Gf6JSAvUlwP/WKwb0sNYwxIMaEgA5vhpL
 FAk9+BjXM4WgWNHYeYyU0tR/aW4QkWN6xZ3VCvKp5g35FYfXmexVygzJP61H0tzymSp2
 S0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QJs+wnP7c3BpRJI+8igklFziS6QGCIHoT3iDWYUKOyA=;
 b=gZygXaVj6WVYfIxjgkbvFiz5YUHwNxWZYDMCl48Hr1zRlt5fIi8EOXhcBqw4Ku2uHj
 kO8yBAAycsfBus38YaavptELPzwtYtFm+L17hFr8RTWKK+x2k4FYrPPRAd9dZxnn7AAX
 hVFr4fwOI9uFRwZ1cyT5huwkzgVXXoP9/WqSgzKjXW+mRAzYyx60Q+mr0LVjNK6V4bNO
 3UO3LdDxBhBcPn+MLy27ZgvOQPja7bxlgTPqOUNJrHHh3sZGXPmRkJkaSLf1jV+Dz1Tk
 dRCU55XanNyaV8fDXjk+yX7GNDUoJUOSq60BkpqMr2s0YGqFzYxEgU2a8c0g59IF/diu
 Qg4g==
X-Gm-Message-State: APjAAAVTQTxaEERs17BlIZtZyt4g+04K6ja8UY/cd36fKVQiu3jCesaF
 YujLwpV5ZWQSHK+/T4cRxRW1IscPkW329dwgHmrO2mdMYxY=
X-Google-Smtp-Source: APXvYqzBWH0IDKpEyD8cyyebd2LnOM4k88OtEINRLqENYiaC4zRic/a7SPUS89ipGLWka9p4qgy05CkyR41qaQokOMc=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr21588198otk.232.1562004083150; 
 Mon, 01 Jul 2019 11:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <CAFEAcA8sscJQ2GCwL1gM+EcRtfHQb1v0BwORt6ncH54x51TCVg@mail.gmail.com>
 <5896113812cd914308e5b617377f8e8205224cfe.camel@wdc.com>
In-Reply-To: <5896113812cd914308e5b617377f8e8205224cfe.camel@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 19:01:12 +0100
Message-ID: <CAFEAcA_-h6b_f1fuWh7NkGo+FT0xSyCDXgd3b4pwEvNDN8HcJw@mail.gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.67
Subject: Re: [Qemu-devel] [PULL 33/34] roms: Add OpenSBI version 0.3
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Jeff Cody <codyprime@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 18:50, Alistair Francis <Alistair.Francis@wdc.com> wrote:
>
> On Mon, 2019-07-01 at 17:54 +0100, Peter Maydell wrote:
> > On Thu, 27 Jun 2019 at 16:24, Palmer Dabbelt <palmer@sifive.com>
> > wrote:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Add OpenSBI version 0.3 as a git submodule and as a prebult binary.
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > Tested-by: Bin Meng <bmeng.cn@gmail.com>
> > > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > > ---
> > >  .gitmodules                                  |   3 ++
> > >  Makefile                                     |   5 +-
> > >  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 0 -> 28848
> > > bytes
> > >  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 0 -> 28904
> > > bytes
> > >  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 0 -> 28904
> > > bytes
> > >  roms/Makefile                                |  48 ++++++++++++++-
> > > ----
> > >  roms/opensbi                                 |   1 +
> > >  7 files changed, 44 insertions(+), 13 deletions(-)
> > >  create mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
> > >  create mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> > >  create mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
> > >  create mode 160000 roms/opensbi
> > >
> > > diff --git a/.gitmodules b/.gitmodules
> > > index 2857eec76377..7a10e72e09cd 100644
> > > --- a/.gitmodules
> > > +++ b/.gitmodules
> > > @@ -55,3 +55,6 @@
> > >  [submodule "slirp"]
> > >         path = slirp
> > >         url = https://git.qemu.org/git/libslirp.git
> > > +[submodule "roms/opensbi"]
> > > +       path = roms/opensbi
> > > +       url = https://github.com/riscv/opensbi.git
> >
> > It would be nice to state the license for new blobs we're
> > adding to the source tree... In particular, I find the
> > readme at https://github.com/riscv/opensbi a bit confusing
> > because it says it's 2-BSD but also that some parts are Apache-2.0;
> > the latter is *not* GPL-2.0 compatible. That makes it not completely
> > obvious to me that we can ship this with QEMU.
>
> Ah, I didn't realise there is Apache-2.0 code in there.
>
> In this case all of the code we are using (we aren't using the Kendryte
> code with QEMU) is BSD-2-Clause. Even then though does it matter if it
> is GPL compatible? This isn't being linked with QEMU it is just being
> included with QEMU.

Yeah, if we're not building the apache-2.0 parts then I think
we're OK, and as you say there's the question of whether QEMU's
GPL affects what we ship as mere bios blobs to run as guest
code anyway. But it's sufficiently not a "really obviously ok"
that I'd like a second opinion; cc'd some people who might have
second opinions.

> I can add details of the license in the source tree, where should it be
> added?

I was thinking in the commit message. We also seem to
have human-readable information in pc-bios/README for
the various blobs, which seems to be a good place for a brief
one-para summary of what OpenSBI is, a URL for its upstream,
and a brief note of the license.

> >
> > Also, new git modules in .gitmodules should be qemu.org
> > URLs, not random external ones. (ie, we should set up
> > mirroring of any new external repo we start shipping
> > code and binaries for). We can set this up and fix up the
> > gitmodules file after the fact, but the ideal is to do
> > it in advance rather than afterwards.
>
> Ok, who can setup a git mirror for the QEMU repo?

That would be Jeff or Stefan (cc'd).

> PS: It seems like there are still some issues with this patch so maybe
> it's worth dropping this patch from the PR so that we can get
> everything else merged.

Yeah, that would be my suggestion.

thanks
-- PMM

