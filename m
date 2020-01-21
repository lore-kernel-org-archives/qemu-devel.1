Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09D0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBA12253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAVE4zbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBA12253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrWp-0001pG-Ly
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itrSG-0005E3-SO
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itrSF-0007Bj-Q0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:12:20 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itrSF-0007AA-Id; Tue, 21 Jan 2020 06:12:19 -0500
Received: by mail-lj1-x244.google.com with SMTP id z22so2342891ljg.1;
 Tue, 21 Jan 2020 03:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oHNfXYrd5E2i4VOR/N+QLPpL2lHjMO45q+YebeyI6f4=;
 b=lAVE4zbjL3DRoic1n3UeQEnhZQDFSK0MOPKMw9lMYR9eVEOv12k1AZ8SAvcl5yKSDf
 KdaVZvyE+1ITN5lG3I02oeEnXefcG7qGO3vgklAZIMEzs3FRb08EXz+wzI8eaSbNaE67
 xjsOc/eJpPNgiIKclFmMuRhppPlgUGpc2jKSjD8sxATbLDtk/vr2AR64wVJPtfZFjin3
 JZsnC2Kntzdi18EdBvNCdw4moVlAvL3ukumKNZFMAuusJsAYmWLxk9yyEzRa7PtrFji6
 0PyXIR42KS/GN6MBFVqrdEHW+oj0ARgA/R/RmwBNu3oFCO14oDGtR21ZHH+FV5JWJzK4
 yonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oHNfXYrd5E2i4VOR/N+QLPpL2lHjMO45q+YebeyI6f4=;
 b=qmbd5JvLtuDQp6GbYBtuRDAWH6ksGjJ0Z4QP3LTz1JXw6APp7+COmuDaFdCPG3OjOs
 IENcjHH/fmHQ6VvyOucW79WQLtykt7jHjaanP3Qoz1VewxohX6p/kmKRZ8xP3dnVs33i
 a5WD8m8fcEqvVt1HSRWrIpvEMNLN0FayxZPaEVuTS4BVJMYrsqJn3UVnqdHThsKUBSER
 AVvpuT9Lj35ETeQ5IXDOe04edV9VY8fPn1a7CTGmlcgkQjt1EVPBYouLKxrwLPAW/Aku
 GQO7uLjXFmJ1Prq4/J9fLq6b09/GkSeR86qKsCz5bs5Nb9m1M+uIV0y6O3Crcwklx+1E
 DpNQ==
X-Gm-Message-State: APjAAAUhznAjAjWenBZWEhfQPfQ2aR05jyP06jDbfpUY4wvVNyEPnCo9
 igXOK61IwiTIIUNml/4VcrHFGX/dvzs2luqq2Bw=
X-Google-Smtp-Source: APXvYqyjp5SwbjfKshMa3KFNtXrltX/vKUEciulStmjFvzh/FvMf5Sr619dT2+J8NvodaHfNJJCPxB2WkYA/VQ9N9BM=
X-Received: by 2002:a2e:8946:: with SMTP id b6mr2236524ljk.1.1579605138123;
 Tue, 21 Jan 2020 03:12:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575914822.git.alistair.francis@wdc.com>
 <b1313a76928acfe101247e33248f000e1f82f558.1575914822.git.alistair.francis@wdc.com>
 <mhng-1d91cb12-dd7c-4160-9e39-a1d5a9f5023a@palmerdabbelt-glaptop>
In-Reply-To: <mhng-1d91cb12-dd7c-4160-9e39-a1d5a9f5023a@palmerdabbelt-glaptop>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 21:11:51 +1000
Message-ID: <CAKmqyKOfqHn9PBsDeb65JSovszT4qF_3eNRUGA5AaG4_zhyiTA@mail.gmail.com>
Subject: Re: [PATCH v1 17/36] target/riscv: Set VS bits in mideleg for Hyp
 extension
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 8, 2020 at 12:07 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Mon, 09 Dec 2019 10:11:24 PST (-0800), Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/csr.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index a4b598d49a..fc38c45a7e 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -449,6 +449,9 @@ static int read_mideleg(CPURISCVState *env, int csrno, target_ulong *val)
> >  static int write_mideleg(CPURISCVState *env, int csrno, target_ulong val)
> >  {
> >      env->mideleg = (env->mideleg & ~delegable_ints) | (val & delegable_ints);
> > +    if (riscv_has_ext(env, RVH)) {
> > +        env->mideleg |= VS_MODE_INTERRUPTS;
> > +    }
> >      return 0;
> >  }
>
> Do you have any idea why?  The spec is explicit that this is the case, but I'm
> surprised.

I'm not sure why, maybe to simplfy hardware design?

Alistair

>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

