Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD91BC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2072173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Su/a/pJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2072173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvizW-000749-Qc
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 10:02:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58798)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvixo-0005RL-Ei
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvixm-0001dt-Es
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:00:20 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hvixk-0001d4-Pm
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:00:17 -0400
Received: by mail-ot1-x343.google.com with SMTP id n5so119011867otk.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5Hw9bxFD9i04O5ml4rRUZAdxoo9EgWI9Gk4h6e91qJg=;
 b=Su/a/pJl2Ks582G6RhTVv5ullfWsYcVpnYhBc2V9WSBpTU0RBEn7uIicIQLU+sGY9h
 dAw4qC2026A2U6Ow4o4RRm+YmM7D2x1qgy8pKzwWghDPKIi1l5iMe+EZogGZbsC5sp8o
 SKgLbXNVHy5+TqdjdSCerWa8qmkgXaGvJgRZbLr4s9WXwNLhEvjgyWppPEBf86Ouadq+
 y9+Avox+8HK68J3SGU2arFkL8eZIf1ahVoDh6EMixe/mbSnl8dGtMvlWYwzn74h9rAxw
 +O5QK4RGFkIJl0/heVhQQ39BenxPfYHsAFa+IGKYkY11Kgvh+tELObZGTxPukA0RXUWS
 aTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Hw9bxFD9i04O5ml4rRUZAdxoo9EgWI9Gk4h6e91qJg=;
 b=VfaUy02i0wViXu54cEq4nXnY1zPm5yVb6LFEYIJxj56RXbHb0+y4ob2ck0ZzANybGc
 3KydtKpZuGDMhvx91W04ySFUGy121+V1reWtgK34u5eFlB2T+xx4aXOCn0G+bbjQQ8Ba
 g4x+dfI0BfveemGlgVrDEFydRnb/4obN0qf1dEPjGwhnCDocFCd/NdK6r9BMI0SydGPp
 H+u1teR6OaiQr+nLnSFWTPB5MrUM88fyJKjZsoKAOOmnfqwHiHt8rCDyrECF0bqam1kQ
 EW2ViPEcX5M1s3UoLuHlPZIEusegBwTpo6OIHCpz3RfIEkSCIa6RLWYMh36WMXjIoBBo
 r8fA==
X-Gm-Message-State: APjAAAXdJNtXR8nzXbyXAS/3+QQeGDERCIbjkTFPfwiulIFkYh74jnwp
 S3F4cOACwyfXVrU8KwvxhKk5xqnBIiunjOGBzumRoQ==
X-Google-Smtp-Source: APXvYqyL3zCC/3M1DScoVoVO9kI3pBLHLLFvvSWcnCDDN2eTucNEdfKwxry+sEjRl8YPqJCxpxKh95DOl6ZuHoIJXrs=
X-Received: by 2002:a5e:a70b:: with SMTP id b11mr11256434iod.286.1565272815632; 
 Thu, 08 Aug 2019 07:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-12-git-send-email-bmeng.cn@gmail.com>
 <CAEiOBXU9UXEGYjEDP-LJ5mEY-bF+OtMKt4O+LGJh9qQt3OPaew@mail.gmail.com>
 <CAEUhbmUO2aFrGXbZDB4uXAKe9kq5NJuwS9mMM6-Pwvn_8h++aA@mail.gmail.com>
In-Reply-To: <CAEUhbmUO2aFrGXbZDB4uXAKe9kq5NJuwS9mMM6-Pwvn_8h++aA@mail.gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Thu, 8 Aug 2019 22:00:04 +0800
Message-ID: <CAEiOBXXAvxSbDN-vLiwK2dtK_s8wm08MLb5yD7dVWvQpz-5=Yw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 11/28] riscv: sifive: Rename
 sifive_prci.{c, h} to sifive_e_prci.{c, h}
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 6:11 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> On Wed, Aug 7, 2019 at 4:54 PM Chih-Min Chao <chihmin.chao@sifive.com>
> wrote:
> >
> >
> >
> > On Wed, Aug 7, 2019 at 3:49 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>
> >> Current SiFive PRCI model only works with sifive_e machine, as it
> >> only emulates registers or PRCI block in the FE310 SoC.
> >>
> >> Rename the file name to make it clear that it is for sifive_e.
> >>
> >> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >> ---
> >>
> >> Changes in v2: None
> >>
> >>  hw/riscv/Makefile.objs                              |  2 +-
> >>  hw/riscv/sifive_e.c                                 |  4 ++--
> >>  hw/riscv/{sifive_prci.c => sifive_e_prci.c}         | 14 +++++++-------
> >>  include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} | 14 +++++++-------
> >>  4 files changed, 17 insertions(+), 17 deletions(-)
> >>  rename hw/riscv/{sifive_prci.c => sifive_e_prci.c} (90%)
> >>  rename include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} (82%)
> >>
> >> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> >> index eb9d4f9..c859697 100644
> >> --- a/hw/riscv/Makefile.objs
> >> +++ b/hw/riscv/Makefile.objs
> >> @@ -2,9 +2,9 @@ obj-y += boot.o
> >>  obj-$(CONFIG_SPIKE) += riscv_htif.o
> >>  obj-$(CONFIG_HART) += riscv_hart.o
> >>  obj-$(CONFIG_SIFIVE_E) += sifive_e.o
> >> +obj-$(CONFIG_SIFIVE_E) += sifive_e_prci.o
> >>  obj-$(CONFIG_SIFIVE) += sifive_clint.o
> >>  obj-$(CONFIG_SIFIVE) += sifive_gpio.o
> >> -obj-$(CONFIG_SIFIVE) += sifive_prci.o
> >>  obj-$(CONFIG_SIFIVE) += sifive_plic.o
> >>  obj-$(CONFIG_SIFIVE) += sifive_test.o
> >>  obj-$(CONFIG_SIFIVE_U) += sifive_u.o
> >> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> >> index 2a499d8..2d67670 100644
> >> --- a/hw/riscv/sifive_e.c
> >> +++ b/hw/riscv/sifive_e.c
> >> @@ -41,9 +41,9 @@
> >>  #include "hw/riscv/riscv_hart.h"
> >>  #include "hw/riscv/sifive_plic.h"
> >>  #include "hw/riscv/sifive_clint.h"
> >> -#include "hw/riscv/sifive_prci.h"
> >>  #include "hw/riscv/sifive_uart.h"
> >>  #include "hw/riscv/sifive_e.h"
> >> +#include "hw/riscv/sifive_e_prci.h"
> >>  #include "hw/riscv/boot.h"
> >>  #include "chardev/char.h"
> >>  #include "sysemu/arch_init.h"
> >> @@ -174,7 +174,7 @@ static void riscv_sifive_e_soc_realize(DeviceState
> *dev, Error **errp)
> >>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
> >>      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
> >>          memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
> >> -    sifive_prci_create(memmap[SIFIVE_E_PRCI].base);
> >> +    sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
> >>
> >>      /* GPIO */
> >>
> >
> > I  think adding infix to function name is sufficient and keeping the
> filename the same may be better.
> > The U board PRCI or variant implementation in future could be included
> in the same files with different create function
> >
>
> I considered such approach when working on this one, but later I chose
> to implement a new file for SiFive U machine.
>
> The SiFive U and E PRCI blocks have different register blocks so if we
> put two variants into one file, their functions don't have much in
> common and we end up just merely physically put them into one file
> which does not bring too much benefit IMHO.
>
> Regards,
> Bin
>

agree that the difference between u and e prci are  a lot and it make sense
to separate it

Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
