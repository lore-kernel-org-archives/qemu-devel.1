Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D53ACA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9BC420650
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="tVtACwLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BC420650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQZ4w-0003ih-Fv
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 11:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1iQZ2X-00038M-74
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1iQZ2W-0002uX-06
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:40:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1iQZ2V-0002Ys-QW
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:40:39 -0400
Received: by mail-wm1-x344.google.com with SMTP id c17so2369076wmk.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PnyrLnNYEiZ0VCSsEhmvl+u74qow2KUegd4JUtRWIWk=;
 b=tVtACwLHj+qxRWiAqXGB2HJXrke2qTLCH3m1EuzS/+AskV3tcFxONlCCziwD9tEh29
 DlYABa8Lxp95Gb6jHa/jC/qajNjykgzOSg54vMpCiN5vbzuBZkUh2n2fYEQrcQEeFE+K
 7j9sWnSU37ixDQ1f0yE3PbhW54tTyo+ay6bz0P1rPdtBcsR+obWWn9VQ+SxzQvhAt8QL
 d8ncWRjpHleJW8YHoksOOD5jEPbNfHirhslGzmkOcMF2aLItgjiyRS/+fPejt/eEdnD1
 b8WlnUrY0Fl7x650alv7JEqAZvST2rhons4+wx8BRc80RSOCLx296guNcxARHBxlWX7z
 Rn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PnyrLnNYEiZ0VCSsEhmvl+u74qow2KUegd4JUtRWIWk=;
 b=R6rlzKSwxzuKKVoskfd/XFAHOVb7yU8TsGXZNOPXWXM/hCbMvVDa8p7OqxiCxOVEBu
 vqeYKEc4Xf/4+p45jITTzgZ4iNX0mIpU7hamZZHaC4Bn2yvqtiq236+WXGDjDd640phR
 HD4YEaeQBMmJH0rEwcnMgqdnSamEnfhk9p7pznv2WzaUXCyU2m/t62R4EnaTPTy/VHTU
 CLmoNEyFmvaCH9zUyZYk6ea/x8kOl818U/doMIbxFzmQo6OGwKkTvefD5KV55sJUgeUg
 sNEl/vqogYbQ6r9LDYYSI+rx7NRUoNn3YuD6yWCOKNeXRNigZF2SZI/QA8OSWAiqd7X5
 33Ew==
X-Gm-Message-State: APjAAAWYChQ4gQvI+QaT8WbBGD1TKffYuzp6rhSXRTYKvEm9pgkBU3Rg
 f4ZOHltib8FZewiHjGAx22HdxYX6zVuKoaaaWZWoSg==
X-Google-Smtp-Source: APXvYqzEpqJU31nE+PcSBF0U/yI/nLRGdJQrnuHDJpPYoq1kBlHWsYFmYMJzGS96gMY68kHNghTRZwwr1rbmbGeH+mA=
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr10444612wml.177.1572622834966; 
 Fri, 01 Nov 2019 08:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191025042734.69244-1-anup.patel@wdc.com>
 <CAKmqyKMQz-OMFQRTdmpBpGMLiZ_ZM+UL5T5aAWZ5F1fC6vddOQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMQz-OMFQRTdmpBpGMLiZ_ZM+UL5T5aAWZ5F1fC6vddOQ@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 1 Nov 2019 21:10:24 +0530
Message-ID: <CAAhSdy3sUb_r77NBvEQEAQ0EQB99=4jgAbH3ADOqvJ_iX+o8pg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] RTC support for QEMU RISC-V virt machine
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 29, 2019 at 6:55 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Fri, Oct 25, 2019 at 6:28 AM Anup Patel <Anup.Patel@wdc.com> wrote:
> >
> > This series adds RTC device to QEMU RISC-V virt machine. We have
> > selected Goldfish RTC device model for this. It's a pretty simple
> > synthetic device with few MMIO registers and no dependency external
> > clock. The driver for Goldfish RTC is already available in Linux so
> > we just need to enable it in Kconfig for RISCV and also update Linux
> > defconfigs.
> >
> > We have tested this series with Linux-5.4-rc4 plus defconfig changes
> > available in 'goldfish_rtc_v2' branch of:
> > https://github.com/avpatel/linux.git
>
> @Peter Maydell this has been reviewed, do you mind taking this in you
> next PR? I don't see a maintainer for hw/rtc.

It would be great if this series can be taken for QEMU-4.2

Regards,
Anup

>
> Alistair
>
> >
> > Changes since v4:
> >  - Fixed typo in trace event usage
> >  - Moved goldfish_rtc.h to correct location
> >
> > Changes since v3:
> >  - Address all nit comments from Alistair
> >
> > Changes since v2:
> >  - Rebased on RTC code refactoring
> >
> > Changes since v1:
> >  - Implemented VMState save/restore callbacks
> >
> > Anup Patel (2):
> >   hw: rtc: Add Goldfish RTC device
> >   riscv: virt: Use Goldfish RTC device
> >
> >  hw/riscv/Kconfig              |   1 +
> >  hw/riscv/virt.c               |  15 ++
> >  hw/rtc/Kconfig                |   3 +
> >  hw/rtc/Makefile.objs          |   1 +
> >  hw/rtc/goldfish_rtc.c         | 288 ++++++++++++++++++++++++++++++++++
> >  hw/rtc/trace-events           |   4 +
> >  include/hw/riscv/virt.h       |   2 +
> >  include/hw/rtc/goldfish_rtc.h |  46 ++++++
> >  8 files changed, 360 insertions(+)
> >  create mode 100644 hw/rtc/goldfish_rtc.c
> >  create mode 100644 include/hw/rtc/goldfish_rtc.h
> >
> > --
> > 2.17.1
> >

