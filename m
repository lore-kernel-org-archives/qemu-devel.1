Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FE6C0650F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D62F2173B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKXY2s9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D62F2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hunDC-0005qI-TE
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 20:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hunCp-0005N5-S3
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hunCp-00041Y-13
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:19:59 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hunCn-000411-3g; Mon, 05 Aug 2019 20:19:57 -0400
Received: by mail-lf1-x142.google.com with SMTP id b17so59478033lff.7;
 Mon, 05 Aug 2019 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G1ADZ7xZeqdDgNsll+f9xpstmMYBMPgBsF27016AAVY=;
 b=aKXY2s9Cx/xE7vxetSztNDy+hYE9uFpb/hEot/TRsIxtkT/E8zJfR2z+oaqKZYt7wH
 OJ6cj77tVtCHaVySBReRcoNr4WzKvbXCnvGFoBHLdL5Pvwc8LKKONkEXSD2P54WTUY8Q
 4L8u0lpSrriAwA+vHSz4D46UOYASxjmsjMoYRe3xRwpQA3wCMMrDVcgtqnpHpxgWQit0
 92vYA/6resrYUI5bus3SbaWrYq1d/EpKzVgZJnRcbpwY7Sw4exWDQoT+cRSziNCq3bdW
 jdBhr81MFv8tmf2n4TbGldVgyxzcnf3UrTGdfC5kIq96geOJJQO/YSl6PNFkyUnZJweR
 8W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G1ADZ7xZeqdDgNsll+f9xpstmMYBMPgBsF27016AAVY=;
 b=kbbAkodLpZ0Qk82lKuwKC8QE18gn7wXWTtW6drbnmNen60t6+9ZGS2duA6SUQQY8Qs
 CONd8O+prUfi2R5rBpYpiX7NdtljaFiSS5zVW4amKc6rDUcYrMcIiTHJxV8GPgHLsrbi
 i+rEUrTLHmVUGoe+A926qKzwHs8AVc4OPpsZH5EiPx68Fhs1uB2G3XPco3K3SD6OdMch
 xD1c1VkG3dvGQUOO/cu8wP/VeSj9hVnEPqRM79B8QxxNlszT53eNGWgaYckYX35dtHNi
 ruEV0Xw6FKhBzVhGSuwfKUBi0oDTXBRxq9ScLbkt4CxBUZ4PN5Ez2/p4zCDF2F7FvjM3
 pP6w==
X-Gm-Message-State: APjAAAW47rOUg3J7GGRL3MTMOUzz4ezVr+fml/vXnjebqSdWHvyGFWWV
 0jtMlb9qth5a/VWSQS1XpcQi9uYkyNKfxsOoUS+zFMZt
X-Google-Smtp-Source: APXvYqz1ovigNOHOuoFZzp1uLMVz0x1gvQM+0fOeDcbBZezEkzjBw3ymfHFsiRjBo8uYCl3RJQS4uR2YWesUyQc7NpE=
X-Received: by 2002:a19:7006:: with SMTP id h6mr241577lfc.5.1565050795819;
 Mon, 05 Aug 2019 17:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
 <1565020823-24223-8-git-send-email-bmeng.cn@gmail.com>
 <CANnJOVHeoqJ9pxVur3tTzEHf2kPBw4zHaiEzaUxgOvnTQJEVjQ@mail.gmail.com>
In-Reply-To: <CANnJOVHeoqJ9pxVur3tTzEHf2kPBw4zHaiEzaUxgOvnTQJEVjQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2019 17:16:14 -0700
Message-ID: <CAKmqyKOeY0h6t6i-OvXgoPTWNK7xRRky+SLJaj56Otmrb6c0PQ@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH 07/28] riscv: sifive_u: Set
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 5, 2019 at 9:42 AM Jonathan Behrens <fintelia@gmail.com> wrote:
>
> I'm not familiar with QEMU conventions on this, but would it make sense to
> require having exactly 5 CPUs to match the real board?

SMP can sometimes cause failures, so I think it makes some sense to
keep the default low.

Alistair

>
> Jonathan
>
>
> On Mon, Aug 5, 2019 at 12:05 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> > It is not useful if we only have one management CPU.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> >  hw/riscv/sifive_u.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index 08d406f..206eccc 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -428,6 +428,8 @@ static void riscv_sifive_u_machine_init(MachineClass
> > *mc)
> >       * management CPU.
> >       */
> >      mc->max_cpus = 5;
> > +    /* It is not useful if we only have one management CPU */
> > +    mc->min_cpus = 2;
> >  }
> >
> >  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
> > --
> > 2.7.4
> >
> >
> >

