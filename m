Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351A6C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020BA2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoSCxBgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020BA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQc4M-0004FU-45
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQc2q-0003Hh-Cx
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQc2q-0000IZ-0r
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:25:28 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:38360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jQc2m-0000GF-GQ; Mon, 20 Apr 2020 15:25:24 -0400
Received: by mail-io1-xd44.google.com with SMTP id f19so12378358iog.5;
 Mon, 20 Apr 2020 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cn1+441SJgj6F7h5yPCegbnHuFnhd5lmWLOXJ3+cwRQ=;
 b=JoSCxBgWaZJ5zEIThzWY9f287y4tEXxn9mUX8C+8su/WDipY06nd1oByR49izUHy/b
 obl0I1+ueAvNMFumpKbjMY7lof+mLl00rDgzs7WGwwG8gshJKvTnhY3PYUDjFUm35ELa
 PxlJ+wTVMBzUH10AIVSvtbkbpnIlUz5uMIW1Rj4E2CqUte0QPC7FHpkSEVdtlG7ICuwR
 k6sggcs11RvkhNWkLCtTwuPrgaonMIX3FOsJQG95akQmOYhf+tG1fbm7gMrH6HP3UqJ9
 SVXka7Ai9Y/cGGzrwPRSW+PZW0Z5X4PzZ7/6XwfAHdA2xoZr/KNAhrLjAP2ybmWs6uyW
 405Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cn1+441SJgj6F7h5yPCegbnHuFnhd5lmWLOXJ3+cwRQ=;
 b=plQfAM2+tp57WAKND1El3xaX2hmr3QfuD3V7bQP0LkKBZD+8UKjMib7a4INfVvxtrH
 TebE19xzan/Q/yuvukRsg/9z6HsF2dzL5pG6cJLwEmN9QRIc66GcwRbldSxAqJe+NOQV
 VXqmgRIgOmTY8MnVh7xF/KEfY5qaYGAXsqNirZjZSBhpXU1UFEdx4tz770+r+CdB5skI
 kXc/RLSbAV1TTtoGQLvYaYazGqj16WKtheUgDO6dkjUQil3dkPe6bKLYTUA/zwFmemc5
 32ehTkRK7ou0hx/N6zHlrtjhvauMOWo/KnJBiF86YV9xH1GHK3enq2sMh7VYZCkuUC/w
 vHwg==
X-Gm-Message-State: AGi0PubuE10W359wl59bSMRYzR4C3dKtainF8wTJPpgxvbcM2HklqMHg
 q4m0+CylxnoFH4ALL11iWRBo1EyyZI6el7KG3zk=
X-Google-Smtp-Source: APiQypISBJHmcnVyi3PFKazNjnVnJzwMpNOAEPHlB9LEcJU1qL/Ssjbz76+hUl1ZccXMVj0v5dbLBRPfaoPzjns7xmQ=
X-Received: by 2002:a6b:bf83:: with SMTP id
 p125mr10828244iof.118.1587410722508; 
 Mon, 20 Apr 2020 12:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200330082724.120444-1-anup.patel@wdc.com>
 <CAKmqyKMwso5-O3kZVt2oBA9y1BAGNYttzKqWkoU2V5VXi63uHg@mail.gmail.com>
In-Reply-To: <CAKmqyKMwso5-O3kZVt2oBA9y1BAGNYttzKqWkoU2V5VXi63uHg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2020 12:16:55 -0700
Message-ID: <CAKmqyKOBz2=asvtgZ9skwC1CWxrU2Oj30j6RqJPj5N6Ms9R9Pw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix Stage2 SV32 page table walk
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 9:25 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Mon, Mar 30, 2020 at 1:28 AM Anup Patel <anup.patel@wdc.com> wrote:
> >
> > As-per RISC-V H-Extension v0.5 draft, the Stage2 SV32 page table has
> > 12bits of VPN[1] and 10bits of VPN[0]. The additional 2bits in VPN[1]
> > is required to handle the 34bit intermediate physical address coming
> > from Stage1 SV32 page table. The 12bits of VPN[1] implies that Stage2
> > SV32 level-0 page table will be 16KB in size with total 4096 enteries
> > where each entry maps 4MB of memory (same as Stage1 SV32 page table).
> >
> > The get_physical_address() function is broken for Stage2 SV32 level-0
> > page table because it incorrectly computes output physical address for
> > Stage2 SV32 level-0 page table entry.
> >
> > The root cause of the issue is that get_physical_address() uses the
> > "widened" variable to compute level-0 physical address mapping which
> > changes level-0 mapping size (instead of 4MB). We should use the
> > "widened" variable only for computing index of Stage2 SV32 level-0
> > page table.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Applied to the RISC-V tree for 5.1

Alistair

>
> Alistair
>
> > ---
> >  target/riscv/cpu_helper.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 50e13a064f..bc80aa87cf 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -559,12 +559,7 @@ restart:
> >              /* for superpage mappings, make a fake leaf PTE for the TLB's
> >                 benefit. */
> >              target_ulong vpn = addr >> PGSHIFT;
> > -            if (i == 0) {
> > -                *physical = (ppn | (vpn & ((1L << (ptshift + widened)) - 1))) <<
> > -                             PGSHIFT;
> > -            } else {
> > -                *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
> > -            }
> > +            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
> >
> >              /* set permissions on the TLB entry */
> >              if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
> > --
> > 2.17.1
> >
> >

