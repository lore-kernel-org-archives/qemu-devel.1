Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F758C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186CB21655
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpnHg/fM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186CB21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDyCC-0001v1-TR
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 17:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDy9j-0008OR-Bu
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDy9f-000126-T1
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:52:02 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDy9b-0000tH-Bw; Fri, 27 Sep 2019 17:51:59 -0400
Received: by mail-lf1-x143.google.com with SMTP id r2so2965852lfn.8;
 Fri, 27 Sep 2019 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BLBr7qiWAfyYl/v8+1LEkv7+EHsq3wG4rWqEdWOyVVc=;
 b=UpnHg/fM814d+qRvJDmmYAtzTbvz/aI2wP9H2PNG8Q5GNfIM5HJdmhR20aTuq4byCa
 JA/aBTEgA5uHcUb6zZYcVXlVZTLbKj8hPZGjUBJD6Hf6EYfoUL15Ae/tEyVAthQCM4s3
 hz8GPGAuGl+F/PlI2od22POjinDuihHLGHfY1hWxkX36msLBFL6VLixn1SRnOU3plZpH
 gYw46Pu3czH9hA6iCq2ovrw8ADuJIDjKOzBHN1QSJJI/DRSbi9v/aOYV8hvCeU7PsldQ
 iqgr6+yViSRHC8f5LPEa46E3aR++7uv3/lkiQ/xTElk9Y1MncNG/YGI3q2LrHBtMvK2U
 GQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BLBr7qiWAfyYl/v8+1LEkv7+EHsq3wG4rWqEdWOyVVc=;
 b=rrg8d90wBCzAfXG4MSpI1MygDAXb6YGKxZOoazycKHbhVnz0fzyB8Y+1cZ2X/5iI52
 9WFcnIazCM9UdhT+pFK2cP1wAKbU03cKp8iVXTNKYb13AGcoN5ZMq1ZO27GvvqX9yVpP
 8q3wBwAqSd7oThBkn/BGZl9/cjhsXOQ/BgzVbCAZmH3nD1ow4wI3wrQb/dQ4eAwW/vLB
 4p+DNXj0Lsj0U1xd8rt2H5Ww0MHLKZ8uwIEICmwn1uGwMQ30dCZHLuFp13/K9OgFDcgm
 lx/Nr7iaFPEu68jEFwlS/g+b0g6tLRGjgV2TNdrUl6AhbP9wMN6B/BAR+em7MvpYhpRJ
 pTGg==
X-Gm-Message-State: APjAAAU0NzmP6anbEoUF+kOKAPQe2glLHAk9z1l+Fdrb5SETr382/4VG
 v4VtfFC9Lok65nK2fatEP0MLV2cu85l1n4Bsngc=
X-Google-Smtp-Source: APXvYqys1PzcQ0RXjf19NdGe/VFEyKwjB1ruDI/i7FPiNrI8itTEZEEI8CVWsGiyfFGxOHnFIzxeVZWzpmA6u7XnGDk=
X-Received: by 2002:a19:4912:: with SMTP id w18mr4049708lfa.93.1569621111014; 
 Fri, 27 Sep 2019 14:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569545046.git.alistair.francis@wdc.com>
 <bf4f869cab915364855a1c9ffadfeac16b151e4b.1569545046.git.alistair.francis@wdc.com>
 <CAEUhbmVBDs5dNH06BjA=Xsa_AEtqoaA6Nm04VtY9-nxJUhmkPQ@mail.gmail.com>
In-Reply-To: <CAEUhbmVBDs5dNH06BjA=Xsa_AEtqoaA6Nm04VtY9-nxJUhmkPQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Sep 2019 14:47:04 -0700
Message-ID: <CAKmqyKMiZ6gNn6rgABfa=QWL_X4oXVN1Pd4itFzFoR66=hgQhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] riscv/sifive_u: Add L2-LIM cache memory
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 12:57 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Fri, Sep 27, 2019 at 8:52 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > On reset only a single L2 cache way is enabled, the others are exposed
> > as memory that can be used by early boot firmware. This L2 region is
> > generally disabled using the WayEnable register at a later stage in the
> > boot process. To allow firmware to target QEMU and the HiFive Unleashed
> > let's add the L2 LIM (LooselyIntegrated Memory).
> >
> > Ideally we would want to adjust the size of this chunk of memory as the
> > L2 Cache Controller WayEnable register is incremented. Unfortunately I
> > don't see a nice way to handle reducing or blocking out the L2 LIM while
> > still allowing it be re returned to all enabled from a reset.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
>
> Please include a changelog in the future. otherwise it's hard to track
> what is changed between patch versions.

I normally just include one in the cover letter, individual patch
change logs can be a bit of a pain to maintain. I'll try to do a
better job in the future.

Alistair

>
> >  hw/riscv/sifive_u.c         | 16 ++++++++++++++++
> >  include/hw/riscv/sifive_u.h |  1 +
> >  2 files changed, 17 insertions(+)
> >
>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

