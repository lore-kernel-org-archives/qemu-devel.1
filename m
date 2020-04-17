Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839E8C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 17:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E312076A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc8m90lQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E312076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPUdS-0003pa-9W
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 13:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rfried.dev@gmail.com>) id 1jPUbi-0001rh-ID
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 13:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1jPUbh-0007k7-EK
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 13:16:50 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1jPUbe-0007e7-PL; Fri, 17 Apr 2020 13:16:46 -0400
Received: by mail-ot1-x342.google.com with SMTP id m13so2032587otf.6;
 Fri, 17 Apr 2020 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UXOT4fIQLTNKO3KnjOAhEgisjvvpsRFqoC0kHskjYTU=;
 b=cc8m90lQENCbov7TSAi//xM2vnkZkMq9ha7IfByi87QxUuLvP10LtGU7prGJ+8+hch
 +X+og4XUvMqmZ+BGDGjZMGQw5IBelAQ7VPGRVZl2BmKL0+4+WGuq5p/n4ugSRQIxE3gF
 gJnRqOC3il9gsRqYuuCAt4hw+rTRlOy0cFqYzvb6etJH0NyetZ5zyeSS9AQTJqvGR+qJ
 slA6bIYIZL5EBkWdcHC3RyvbOl1X2MvB/vRhfkRIj45PR/eIYApmJcPBGbhWv0Xqq3O/
 6aXVfdPCYtRwOLBt8nCrQE2G3tATp40OSs5F9rRjouUBvN74KtYi5pWY4Z4SAWRVF5nb
 K2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UXOT4fIQLTNKO3KnjOAhEgisjvvpsRFqoC0kHskjYTU=;
 b=pgfNh2KJ4SMaYqD0bOCSsV03MUOQMvUFfmMCf7yYeCvNq402PdxBQy/+3mmBwKh6Sv
 2AieEymwnr0z83GsmUBZEnFXH6zZAzRELW2yaBlziTid7Ug+RIZW5CuXwLlIuWhSVNH4
 gJRY/X4hKAXjdUR2crxQAzTOA8VPYdjSP6ol/pszBSCoL0f8u4WnaO7KXC1gwDfYq5gn
 yJRKAgtVYrzo45NABHw6qFMRD4EVJ+vOBnDn85ap40MUjoXx2cCBMa8NMj4geiQN/7IL
 z0e3pz7s8toqyKQfEesJG5xcboBusseHKLaKbjBcCeOGVH1N28XIlFDWDjBqD+NEi/b5
 c98Q==
X-Gm-Message-State: AGi0PuY4BpA8tsuWuK8UlqRdJG2cSl4sXGHPDgFGi7n2vpbEPY+MnM/w
 C1tpISRW7VJAAPc4bXf6RfGIOlwuailJS6e2JCs=
X-Google-Smtp-Source: APiQypJ11B5FHdz1+x5tSn1NnBluil0/L5hqnoVdzHfot8OlT/lQIA6Sxtds7Gcql5E+Wc9JbzzxohOLL1scrkolV9U=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr3483811otr.49.1587143805624; 
 Fri, 17 Apr 2020 10:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200416090247.353414-1-rfried.dev@gmail.com>
 <CAFEAcA8kZw_xd-Snogxavyxpo5nyjoExV6DPfyTa3=4RqpTJVA@mail.gmail.com>
In-Reply-To: <CAFEAcA8kZw_xd-Snogxavyxpo5nyjoExV6DPfyTa3=4RqpTJVA@mail.gmail.com>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 17 Apr 2020 20:16:34 +0300
Message-ID: <CAGi-RU+GWKX0PugLYMH1mYLMFDFdyN1jv30-VRTBm1EvRFBhng@mail.gmail.com>
Subject: Re: [PATCH] Cadence: gem: fix wraparound in 64bit descriptors
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 4:37 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 16 Apr 2020 at 10:02, Ramon Fried <rfried.dev@gmail.com> wrote:
> >
> > Wraparound of TX descriptor cyclic buffer only updated
> > the low 32 bits of the descriptor.
> > Fix that by checking if we're working with 64bit descriptors.
> >
> > Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> > ---
> >  hw/net/cadence_gem.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index 51ec5a072d..b8ae21cc0d 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -1238,7 +1238,14 @@ static void gem_transmit(CadenceGEMState *s)
> >              /* read next descriptor */
> >              if (tx_desc_get_wrap(desc)) {
> >                  tx_desc_set_last(desc);
> > -                packet_desc_addr = s->regs[GEM_TXQBASE];
> > +
> > +            if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
> > +                packet_desc_addr = s->regs[GEM_TBQPH];
> > +                packet_desc_addr <<= 32;
> > +            } else {
> > +                packet_desc_addr = 0;
> > +            }
> > +                packet_desc_addr |= s->regs[GEM_TXQBASE];
>
> The indentation seems to be off here.
Right, fixing.
>
> You could write this as:
>
>     packet_desc_addr = s->regs[GEM_TXQBASE];
>     if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
>         packet_desc_addr |= (uint64_t)s->regs[GEM_TBQPH] << 32;
>     }
>
Actually, I used the same method used somewhere else in the file:
static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q) {
hwaddr desc_addr = 0;

if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
         desc_addr = s->regs[tx ? GEM_TBQPH : GEM_RBQPH];
     }
     desc_addr <<= 32;
     desc_addr |= tx ? s->tx_desc_addr[q] : s->rx_desc_addr[q];
}
> which ends up as the same thing but matches the code used
> in tx_desc_get_buffer() to assemble an address that's
> 32 or 64 bits depending on the ADDR_64B flag.
>
> >              } else {
> >                  packet_desc_addr += 4 * gem_get_desc_len(s, false);
> >              }
> > --
> > 2.26.0
>
> thanks
> -- PMM

Thanks,
Ramon.

