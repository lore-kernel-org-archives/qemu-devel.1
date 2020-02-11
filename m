Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFC7C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6969B20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRaNl0vD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6969B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1XvQ-0005Yw-JP
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j1Xuc-0004WL-2F
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j1Xua-0007LO-RV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:57:21 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:39954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j1Xua-0007KR-NT; Tue, 11 Feb 2020 10:57:20 -0500
Received: by mail-yb1-xb42.google.com with SMTP id f130so3687470ybc.7;
 Tue, 11 Feb 2020 07:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cycEn2geULASHbi0E1x8o7VfiYWuePvwwltYWBZYG5U=;
 b=CRaNl0vDwGEglF1KfsPr8qQ7IV3W5dp6O9sH5Y+9dSq3q2rRzjQnrH9yjWetbbbZSn
 QjnP73F7/thRxZJFJ9vj90O5bG1PuYl4MNxSHGco6qLpGEl4UnBWu7hsIwci9QV8Ue6z
 cGNM8u26boSyaJMLjRFxAadANgX9hixyUGXjzO0rZooh57naTa/d40EmkNRtAOLN8rda
 NI/5WrqRhgUY+XbzmUBLN9FoUMYfntovmHmz2EJkthU6EHur3wMhtM+y9DzR1Coe7ZbO
 SnWvJohZ9B9FqfcT0eArR3nl+NZKl0Dq+u9x5zbQjZh4UXKOkqNENXDU2hdWiA8rLnH3
 9KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cycEn2geULASHbi0E1x8o7VfiYWuePvwwltYWBZYG5U=;
 b=St2qrXDDhfmWgtLPIR6f2fmXA3cKw7pIRWVSZ1ZmiPw05APGitwGipx880AHjKZtoP
 a2oJLw3tAwNHrvwNyPr4t+iXRfP0fBJjjXUAPdVt6AtU/u4PPK98rg+y8w9Cqh3DmWOf
 i5X29YfZneDzexrD6ea4cPUVWRgeRdTAwwuYWpBHupmvNgee+e5rpHEHDk9HYU0cYj1l
 yOq9FSr0yIH5Ww20uqWNLjAUTLJpvbBkK8kGiwRMfxZKqQVEAkiTOiRmWzWkuuCdxeig
 PmZCajDpFPf+b2hsXgCRgFieLbp/TFE2iz/z48JPN9MNp9WGvsyH/77UZVxprHfni7Dd
 20tg==
X-Gm-Message-State: APjAAAVYYr1H6bV2/l01uMX356nX+NIRjTb4knk6hXEeAC+3Qb+itjEb
 DtWBTR7rP/JVNzaF3P2+wjmyHOJHkp7k6fw583U=
X-Google-Smtp-Source: APXvYqz12j8kOzZdq1I8pHzIjJ1IjbJN8N/f/UEOO3LCamend3NvxGppHQb3b/vDikkhBemI8g2Wixj1KAJnT+KHr94=
X-Received: by 2002:a25:d348:: with SMTP id e69mr1219390ybf.203.1581436639865; 
 Tue, 11 Feb 2020 07:57:19 -0800 (PST)
MIME-Version: 1.0
References: <mhng-e3089574-e78c-4b6c-961e-cac55f0f23d4@palmerdabbelt-glaptop1>
 <mhng-3370fb0c-3076-4a05-8bcd-ac7fce08d408@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-3370fb0c-3076-4a05-8bcd-ac7fce08d408@palmerdabbelt-glaptop1>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 11 Feb 2020 23:57:08 +0800
Message-ID: <CAEUhbmXbJUdk7VBvwh=-B1MkS=++2v=VEBNuS9x7rrndsHBT-A@mail.gmail.com>
Subject: Re: [PATCH] riscv: sifive_u: Add a "serial" property for board serial
 number
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Palmer,

On Tue, Feb 11, 2020 at 3:55 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Wed, 29 Jan 2020 07:29:11 PST (-0800), Palmer Dabbelt wrote:
> > On Fri, 10 Jan 2020 07:52:05 GMT (+0000), bmeng.cn@gmail.com wrote:
> >> Hi Palmer,
> >>
> >> On Fri, Nov 22, 2019 at 10:38 AM Palmer Dabbelt
> >> <palmerdabbelt@google.com> wrote:
> >>>
> >>> On Thu, 21 Nov 2019 17:10:18 PST (-0800), bmeng.cn@gmail.com wrote:
> >>> > On Sat, Nov 16, 2019 at 11:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>> >>
> >>> >> At present the board serial number is hard-coded to 1, and passed
> >>> >> to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> >>> >> the serial number to generate a unique MAC address for the on-chip
> >>> >> ethernet controller. When multiple QEMU 'sifive_u' instances are
> >>> >> created and connected to the same subnet, they all have the same
> >>> >> MAC address hence it creates a unusable network.
> >>> >>
> >>> >> A new "serial" property is introduced to specify the board serial
> >>> >> number. When not given, the default serial number 1 is used.
> >>> >>
> >>> >> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >>> >> ---
> >>> >>
> >>> >>  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
> >>> >>  include/hw/riscv/sifive_u.h |  1 +
> >>> >>  2 files changed, 21 insertions(+), 1 deletion(-)
> >>> >>
> >>> >
> >>> > ping?
> >>>
> >>> Sorry, it looks like I dropped this one.  I've put it in the queue for 5.0,
> >>> with a
> >>>
> >>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> >>
> >> Has this been applied somewhere?
> >
> > Weird, not sure how I managed to screw this up again.  It's actually on for-master as
> >
> >     * a828041ba6 - riscv: sifive_u: Add a "serial" property for board serial number (50 seconds ago) <Bin Meng>
> >
> > with any luck I'll manage to avoid screwing it up a third time.
>
> Ah, OK -- the issue here is that this fails "make check", specifically
>
>     $ make check-qtest-riscv64
>     make[1]: Entering directory '/home/palmerdabbelt/life/riscv/qemu/slirp'
>     make[1]: Nothing to be done for 'all'.
>     make[1]: Leaving directory '/home/palmerdabbelt/life/riscv/qemu/slirp'
>             CHK version_gen.h
>       TEST    check-qtest-riscv64: tests/qtest/cdrom-test
>       TEST    check-qtest-riscv64: tests/qtest/device-introspect-test
>     /home/palmerdabbelt/life/riscv/qemu/hw/riscv/sifive_u.c:406:riscv_sifive_u_soc_init: Object 0x55baf3feea00 is not an instance of type sifive_u-machine
>     Broken pipe
>     tests/qtest/libqtest.c:149: kill_qemu() detected QEMU death from signal 6 (Aborted)
>     ERROR - too few tests run (expected 6, got 5)
>     make: *** [/home/palmerdabbelt/life/riscv/qemu/tests/Makefile.include:630: check-qtest-riscv64] Error 1
>
> which is probably how it kept getting disappeared -- I just forgot to reply on
> the list.  I'm going to hold it back from the PR I'm staging right now, LMK if
> you have a fix.

OK, I will take a look. I remember I did run "make check" but it did
not report any issue before. Is 'make check-qtest-riscv64' not part of
'make check'?

Regards,
Bin

