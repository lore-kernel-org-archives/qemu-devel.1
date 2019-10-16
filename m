Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF3FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 21:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D734220872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 21:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrQpHVqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D734220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKqWo-0000EX-1A
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 17:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iKqVU-0007a2-8U
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 17:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iKqVS-0002DT-LG
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 17:06:56 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iKqVS-0002D2-Dy; Wed, 16 Oct 2019 17:06:54 -0400
Received: by mail-lf1-x144.google.com with SMTP id r22so106320lfm.1;
 Wed, 16 Oct 2019 14:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FdYyDn3e1Wc+a4KwR+aMKokH53sNQeScNRGO46Uwegw=;
 b=OrQpHVqsIaCsU/KQMhYy3yPzj9akaOnYZDXoK56GTYYgq+HZihpU824Hei9sB+rWYh
 bXAl5K3ab4JP+XbBAkiq7HzPzOtC2gVghwzK0aBY4bAxM3M4JM9++AhPOsveJdTAESxV
 VKzic3MxjRlCIuqo9N8y6lO9ZovmDV2C2hwJgZr2RN1TrCgT6nVZrdpr8ag2MtAZie61
 BBBOg3gZ2TaotmiJnlW5hC71eUx62W4eQn0X5U748FZ1GlOPMyPJSxGnj320HPphv182
 X9yasemiqKsVpQPpM7F4R3BKshmHP0AgrO4Nf/TB5GBpO3m8HdWzpkt70AkG3ZJZAUQ7
 svBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FdYyDn3e1Wc+a4KwR+aMKokH53sNQeScNRGO46Uwegw=;
 b=PKdxr0mKLCO/d4jgie19KkP4VXzjmvfpixRqL94+xsSa+uDisJVytrZWIvWooF0z9o
 M9Amm0UjnilOEQOqexYCkk8vKOznZkVAgyAy3D6L8k33Cy51NnSQFVI+41Whmx66dG1M
 sXh3rnCipN22j+3FKTm3KP3ngZO49wSFxNKrxFQ2x2o4RXCggvbrIVnCJyyjzRFwKApu
 N2pXuALRmHF4SrWCqxafOPFJ5z8qHTpxCX6ZrgnMXJzWHc71jJvErfFSIL8qgTd0Az1g
 3xLGPpG+GDClRtUhwh5tkZxLB6qjpZ7EgpUmO0ato56HUmrFqzhFl7Wr7LVcztczG9Ht
 vjxA==
X-Gm-Message-State: APjAAAXpzhZWbVxG2gG2lxKNiOV/vmpbbTQp8SI4L3/2h+85rjiPbSEE
 jOIjOliLwdrBASOm9eMyzwLmmxu09LzA4GLWYUw=
X-Google-Smtp-Source: APXvYqxXRRK1x1zdq67KU5wHPlOG5bcY7d5YFYA6GYZZ8DueULY2StYJYdZZxXBVA4cmw3vj25o7aMMJ6s/aTAsHEJU=
X-Received: by 2002:ac2:5610:: with SMTP id v16mr25743133lfd.93.1571260012217; 
 Wed, 16 Oct 2019 14:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <8a628d1542d547b6d639cdba51db67590d0b56de.1566603412.git.alistair.francis@wdc.com>
 <mhng-7c045b6d-544e-40df-95a6-e46c479e41c8@palmer-si-x1c4>
In-Reply-To: <mhng-7c045b6d-544e-40df-95a6-e46c479e41c8@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 Oct 2019 14:01:44 -0700
Message-ID: <CAKmqyKMUX=BLJa1sXVGwSP8Rx1HNrg6MGghvNQZMPFNbWHftoQ@mail.gmail.com>
Subject: Re: [PATCH v1 21/28] target/riscv: Respect MPRV and SPRV for floating
 point ops
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 2, 2019 at 4:52 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 23 Aug 2019 16:38:44 PDT (-0700), Alistair Francis wrote:
> > Respect the contents of MSTATUS.MPRV and HSTATUS.SPRV when performing
> > floating point operations when V=0.
>
> I'm confused as to what this has to do with floating point.

virt_enabled is only checked in mark_fs_dirty() for floating point support.

Alistair

>
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/translate.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index 19771904f4..ea19ba9c5d 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -750,7 +750,21 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
> >      ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
> >      ctx->priv_ver = env->priv_ver;
> >  #if !defined(CONFIG_USER_ONLY)
> > -    ctx->virt_enabled = riscv_cpu_virt_enabled(env);
> > +    if (riscv_has_ext(env, RVH)) {
> > +        ctx->virt_enabled = riscv_cpu_virt_enabled(env);
> > +        if (env->priv_ver == PRV_M &&
> > +            get_field(*env->mstatus, MSTATUS_MPRV) &&
> > +            get_field(*env->mstatus, MSTATUS_MPV)) {
> > +            ctx->virt_enabled = true;
> > +        } else if (env->priv == PRV_S &&
> > +                   !riscv_cpu_virt_enabled(env) &&
> > +                   get_field(env->hstatus, HSTATUS_SPRV) &&
> > +                   get_field(env->hstatus, HSTATUS_SPV)) {
> > +            ctx->virt_enabled = true;
> > +        }
> > +    } else {
> > +        ctx->virt_enabled = false;
> > +    }
> >  #else
> >      ctx->virt_enabled = false;
> >  #endif

