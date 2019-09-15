Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43247C4CECC
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 17:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08903214AF
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 17:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxGHQykH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08903214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9YWh-0003K1-1v
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 13:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fintelia@gmail.com>) id 1i9YVQ-0002ie-2X
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 13:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1i9YVO-0003xX-Gf
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 13:40:12 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1i9YVK-0003sC-UL; Sun, 15 Sep 2019 13:40:07 -0400
Received: by mail-lj1-x244.google.com with SMTP id d5so31597673lja.10;
 Sun, 15 Sep 2019 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ykrlz5Ss0wo0TxQhnZN46fo579cWIF2oGYskM8E/4ks=;
 b=AxGHQykHERo1IxeYiBazYZ/Mf1KOTRO0X9OcaVKS6m0EsTFmjBTb/cohpFZwWGfCeO
 zfZQWK1MMzLnLJs8pqnCx4LZum1s/T9dMOUCYEvRXPyLxPIjGaqjnnkW4fPkJOTmqigt
 BIlBvI5kU7lc03DGC0BwT3S44DJ1kVteRwKhv16TUTdqPKUu0Mpy2sI1eBHWE+r5JoC8
 a57yyr3W/8FwUUDimeTUZCbPtogj3u519WbOZ53Xaeep0V73e/ewE7X8MtMn2WBBKBen
 WtuVlLuLxIgq58e+/c6ZvTtAdsmYMMxFHTY9xyR9+Q2xftDjkKP6u+qMfUJUNN0hu3ul
 aHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ykrlz5Ss0wo0TxQhnZN46fo579cWIF2oGYskM8E/4ks=;
 b=R9XmWifiVHwM+QYAplZG+JKswGUyKwes91KTIq3920KdO2XHLZbJE2Ikg2w1hmkjSs
 oIRM467b7tI1KaZ2Uf4DQIZ8xUrN+1r2csfc0lXddUJgfGM/AFhoV1Ltv85ECdb5cI2k
 dKFv00LoReNdE5SSPJvnT+qOl/63j5B1wGgE6OY3WuJaPUxqO7rn/KuT/AHdOUj2Zedw
 TX39YvHaFlMS+W70hPMy5Y86XEtD2WvcsXOkbRCulGmJPe2Qn6KXoyRMC/5Ls5Kttvso
 8P4x3C68yYB2S6N86JCYHOlAwvbn79jwJ/SwVHCjFJZI6SZPQifEoq3ALF8CY8jhnMZ1
 vUdQ==
X-Gm-Message-State: APjAAAV0P8t8hEZYQUxK2ogKg8M4iStEt6SOo9jMM6zc+6akjbFl5Uwy
 1gn5Qq0FfCPYePXllypiRtYujN0VU7WPjjPxSlo=
X-Google-Smtp-Source: APXvYqy+38xGgiDuReot++Wdn5KPdY7XVOkfl7sE8e/JPfudsOmJFxp16ITAAJdxF6nb1i59J6V6zv72TR+8ir0bX3I=
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr14508610lja.161.1568569204781; 
 Sun, 15 Sep 2019 10:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmV=v62a0CAHe2mt1Qzz0n+fESgVYDtjdoXfyhH6_j5zFw@mail.gmail.com>
 <mhng-da766f03-2535-4a8c-97aa-1f85f986bee3@palmer-si-x1e>
In-Reply-To: <mhng-da766f03-2535-4a8c-97aa-1f85f986bee3@palmer-si-x1e>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Sun, 15 Sep 2019 13:39:38 -0400
Message-ID: <CANnJOVGRWepwwZPyOmF1O7azqKVYgB2ZSqLrh5qnye10Oi_M7Q@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH v8 18/32] riscv: sifive_u: Set
 the minimum number of cpus to 2
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Has there been testing with "-smp 2"? A while back I thought I read that
the included uboot firmware was using a hard-coded device tree that
indicated 4+1 CPUs, which I would have expected to cause Linux boot issues?

Jonathan

On Sun, Sep 15, 2019 at 1:31 PM Palmer Dabbelt <palmer@sifive.com> wrote:

> On Sun, 15 Sep 2019 06:07:18 PDT (-0700), bmeng.cn@gmail.com wrote:
> > Hi Palmer,
> >
> > On Sun, Sep 15, 2019 at 3:00 AM Palmer Dabbelt <palmer@sifive.com>
> wrote:
> >>
> >> On Fri, 13 Sep 2019 08:25:21 PDT (-0700), bmeng.cn@gmail.com wrote:
> >> > Hi Palmer,
> >> >
> >> > On Fri, Sep 13, 2019 at 10:33 PM Palmer Dabbelt <palmer@sifive.com>
> wrote:
> >> >>
> >> >> On Fri, 06 Sep 2019 09:20:05 PDT (-0700), bmeng.cn@gmail.com wrote:
> >> >> > It is not useful if we only have one management CPU.
> >> >> >
> >> >> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >> >> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >> >> >
> >> >> > ---
> >> >> >
> >> >> > Changes in v8: None
> >> >> > Changes in v7: None
> >> >> > Changes in v6: None
> >> >> > Changes in v5: None
> >> >> > Changes in v4: None
> >> >> > Changes in v3:
> >> >> > - use management cpu count + 1 for the min_cpus
> >> >> >
> >> >> > Changes in v2:
> >> >> > - update the file header to indicate at least 2 harts are created
> >> >> >
> >> >> >  hw/riscv/sifive_u.c         | 4 +++-
> >> >> >  include/hw/riscv/sifive_u.h | 2 ++
> >> >> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> >> >> > index 2947e06..2023b71 100644
> >> >> > --- a/hw/riscv/sifive_u.c
> >> >> > +++ b/hw/riscv/sifive_u.c
> >> >> > @@ -10,7 +10,8 @@
> >> >> >   * 1) CLINT (Core Level Interruptor)
> >> >> >   * 2) PLIC (Platform Level Interrupt Controller)
> >> >> >   *
> >> >> > - * This board currently uses a hardcoded devicetree that
> indicates one hart.
> >> >> > + * This board currently generates devicetree dynamically that
> indicates at least
> >> >> > + * two harts.
> >> >> >   *
> >> >> >   * This program is free software; you can redistribute it and/or
> modify it
> >> >> >   * under the terms and conditions of the GNU General Public
> License,
> >> >> > @@ -433,6 +434,7 @@ static void
> riscv_sifive_u_machine_init(MachineClass *mc)
> >> >> >       * management CPU.
> >> >> >       */
> >> >> >      mc->max_cpus = 4;
> >> >> > +    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
> >> >> >  }
> >> >> >
> >> >> >  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
> >> >> > diff --git a/include/hw/riscv/sifive_u.h
> b/include/hw/riscv/sifive_u.h
> >> >> > index f25bad8..6d22741 100644
> >> >> > --- a/include/hw/riscv/sifive_u.h
> >> >> > +++ b/include/hw/riscv/sifive_u.h
> >> >> > @@ -69,6 +69,8 @@ enum {
> >> >> >      SIFIVE_U_GEM_CLOCK_FREQ = 125000000
> >> >> >  };
> >> >> >
> >> >> > +#define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
> >> >> > +
> >> >> >  #define SIFIVE_U_PLIC_HART_CONFIG "MS"
> >> >> >  #define SIFIVE_U_PLIC_NUM_SOURCES 54
> >> >> >  #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
> >> >>
> >> >> This fails "make check", so I'm going to squash in this
> >> >>
> >> >> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> >> >> index ca9f7fea41..adecbf1dd9 100644
> >> >> --- a/hw/riscv/sifive_u.c
> >> >> +++ b/hw/riscv/sifive_u.c
> >> >> @@ -528,6 +528,7 @@ static void
> riscv_sifive_u_machine_init(MachineClass *mc)
> >> >>      mc->init = riscv_sifive_u_init;
> >> >>      mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT +
> SIFIVE_U_COMPUTE_CPU_COUNT;
> >> >>      mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
> >> >> +    mc->default_cpus = mc->max_cpus;
> >> >
> >> > Thank you for fixing the 'make check'. Shouldn't it be:
> >> >
> >> > mc->default_cpus = mc->min_cpus;
> >>
> >> We have 5 harts on the board that this matches, so I figured that'd be
> the
> >> better default.
> >>
> >
> > Per my understanding mc->default_cpus is used when invoking QEMU
> > without passing '-smp n' (that's what 'make check' uses), and with the
> > updated sifive_u machine, '-smp 2' is the actual useful configuration
> > to boot Linux. For consistency with user experience on other machines,
> > without '-smp' means we want a uni-processor machine hence I would
> > suggest we set "mc->default_cpus = mc->min_cpus".
>
> OK, I've spun a v3.  I never sent out v2 but I had tagged it, unless
> there's
> any opposition I'll send this out when I'm back on normal internet.
>
>
