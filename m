Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FC1C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDB120693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i2MNGkww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDB120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsjhq-0004AJ-9O
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 04:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34676)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hsjhJ-0003k8-LE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hsjhI-0000XM-Ae
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:10:57 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hsjhI-0000Wi-4S
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:10:56 -0400
Received: by mail-io1-xd43.google.com with SMTP id i10so21024269iol.13
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G/K/PyX4B0akf076L0odxGe527aEzLjjI+CBAn8LeQU=;
 b=i2MNGkwwM/d5zNhKW4rviz6AqmaMdOEbW3ENeBBqq9YeaeXKUXo/cYF+T0jygDEiPJ
 5Zs3T3aFAA1ISmuQ4CfRqPkHJI9J5BUMOxxG24hhFH9clCPS7iaAehIC4dWSkQPLrqye
 CNU0UYqblTalnEK72tX+kCjMVY1tkvBZRz0n1vxc1CF/KLfiCtveyDyklHtcw37xhEw3
 MrqUx8APoF48oJd1OFcAshfqZhHHR3rWG3OfGcE/6M00Md4qw37TrKyh6S77icKInrjI
 0wUX0PZQRFfCbdifCYVmQ7HZnpxXdmqLYxWxIXRWnDAdfk7pmpmiZjdIOb5Lfmg8jPGU
 zazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G/K/PyX4B0akf076L0odxGe527aEzLjjI+CBAn8LeQU=;
 b=nqFI3awJoGl/zJN4n42+WIHsVWi+zKKxmmt4eQD5KNDMks1epLROixtF5jeEIyR2Mm
 UXFRfkTWHxloVrhrqR95KWwZjJe1Ht/EStV6mAbY3chQQZ+J6OLFJdsyOXxRdVmOxm2E
 k0+f1shav3LDgKD9G0dyG4zhZLy5CyoLC6k+otiw4dkJCIfAFk4ctEhH4k1wu7mrupih
 ezMub9i4e9wO+a0nHf+9A8/tX/6XGP2ehN7ULuUq2AA8l+bPUoaqxs4WR+Jp/rGAOzN1
 XupDLIImdcTHqHpih4KHCuR4rotBLENFsFzLhVONG8Kz3FeMbvshUInVVj7ciZrg1gL7
 SmqA==
X-Gm-Message-State: APjAAAUqIQwBx1OQjE+z9tJhRb1JuwbRlCRaciqj/Q5r/CSO87KDwCSc
 ygs+pNhFYVpl8tm8FumDVBdNPjIL2z0JJa/TqKIs+w==
X-Google-Smtp-Source: APXvYqy+WKIGvNqyBfj9iCu9dls2jndTPCHMErVBs1d+YGOoDiuVKDQCcfP49bHJpo9kXyq11GUDj3dr0zFdulNQp70=
X-Received: by 2002:a5d:91d7:: with SMTP id
 k23mr108858690ior.163.1564560654789; 
 Wed, 31 Jul 2019 01:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <4116c27c037b5e7f4822cfd7199724450dc6b5da.1564080680.git.alistair.francis@wdc.com>
 <CAEiOBXUcwp5rZbdH7VuQjnM3Xq5-ONTWmcDp1Da+C1n_-w95Uw@mail.gmail.com>
 <CAKmqyKMJ-Kji0n_HjBX_73T2PerxOF5XWK7mhguegXJ6BztL_A@mail.gmail.com>
In-Reply-To: <CAKmqyKMJ-Kji0n_HjBX_73T2PerxOF5XWK7mhguegXJ6BztL_A@mail.gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Wed, 31 Jul 2019 16:10:42 +0800
Message-ID: <CAEiOBXXSHojFUtkvTXYrhQQcjmqnDSoMAQHqRhvQz_0g=K_SZw@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH-4.2 v1 6/6] target/riscv: Fix Floating
 Point register names
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

On Wed, Jul 31, 2019 at 2:41 AM Alistair Francis <alistair23@gmail.com>
wrote:

> On Mon, Jul 29, 2019 at 8:19 AM Chih-Min Chao <chihmin.chao@sifive.com>
> wrote:
> >
> >
> > On Fri, Jul 26, 2019 at 2:56 AM Alistair Francis <
> alistair.francis@wdc.com> wrote:
> >>
> >> From: Atish Patra <atish.patra@wdc.com>
> >>
> >> As per the RISC-V spec, Floating Point registers are named as f0..f31
> >> so lets fix the register names accordingly.
> >>
> >> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> ---
> >>  target/riscv/cpu.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >> index f8d07bd20a..af1e9b7690 100644
> >> --- a/target/riscv/cpu.c
> >> +++ b/target/riscv/cpu.c
> >> @@ -40,10 +40,10 @@ const char * const riscv_int_regnames[] =3D {
> >>  };
> >>
> >>  const char * const riscv_fpr_regnames[] =3D {
> >> -  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
> >> -  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
> >> -  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
> >> -  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
> >> +  "f0", "f1", "f2",  "f3",  "f4", "f5", "f6", "f7",
> >> +  "f8", "f9", "f10",  "f11",  "f12", "f13", "f14", "f15",
> >> +  "f16", "f17", "f18",  "f19",  "f20", "f21", "f22", "f23",
> >> +  "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31"
> >>  };
> >
> >
> > Could you indicate the section of the spec ?
>
> Chapter 11: "=E2=80=9CF=E2=80=9D Standard Extension for Single-Precision
> Floating-Point, Version 2.2", section 11.1, Figure 11.1 shows f0 -
> f32.
>
> > By chapter 20 of user spec, the patch changes the floating register nam=
e
> to architecture name but leave the integer register use the ABI name.
>
> You mean the Packed-SIMD extension?
>
> Alistair
>

I means  "Chapter 20RISC-V Assembly Programmer=E2=80=99s Handbook".
There is an table, "Table 20.1: Assembler mnemonics for RISC-V integer and
=EF=AC=82oating-point registers.",  describes
the architecture name and ABI name for integer and floating-point register.

By the way,  I reference the riscv-spec-2.2

chihmin



> >
> > chihmin
> >>
> >>  const char * const riscv_excp_names[] =3D {
> >> --
> >> 2.22.0
> >>
> >>
>
