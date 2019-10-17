Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5122BECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BF420872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNcKwAxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BF420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8N9-00073w-Lj
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL7MM-0000Po-1n
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL7MF-0008DC-QD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:06:37 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL7MF-0008Cd-M0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:06:31 -0400
Received: by mail-ot1-x344.google.com with SMTP id z6so2193857otb.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fNuiZxDXxKW4b1rxU5MwVhy7UslYOkpsYFLTQrIrZh4=;
 b=cNcKwAxhUgNDOJvCTtgAtWQA3K+GQsbTih5kA8Nc/NPKcXN9yn76d8w7pyn4U4ZR8j
 by8ZQjjZ9TE8VFnKMCwrbnXlWO+atjUVoWlj56UvE2pcuyvkyUpKfsJP1gG90jLR7LoX
 6pf6R0TxSJGMXZcZ1U0SV7EwrotSxkT1KSTco+fODHwBoUSAIENrN8mk7LIJToSEq5m4
 YjLRb1skeHGFuTpHMrPwCJ74KtX1dNZwHAXYZx7DOnzWYMbSdOLsurRlF4mFJmDtxXxq
 eGndFYEQgnVEAAW0OVt1WZFHabtRBSnzHt41/KJG0yKs5pfLBbpJ4eUpDbAHh6cqTpXP
 yp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fNuiZxDXxKW4b1rxU5MwVhy7UslYOkpsYFLTQrIrZh4=;
 b=KmLlpQ0RlW58roMAUVxWX8TdMdp+m4S+2STpW3aqa1Xox97hbPHgB6+oTIZhmvl6zc
 bk8LC/uKAhbgzdSinObTwyydFL7nbGjlDJCkMLLvceQLeV4Y/xYyEK5IlMnFz6nFyKo9
 0+uL3ukASD9HotAVO86LUDoyTvUNUMUeOImNEEsXA8rQ7X0dr7XVeEEpF0t7xVI8Vpz4
 DR/HLqLx0Pzs1nqQRAhRpmkvmd3TZBsjxdbi1WXPSgf5izvWlsUyYIFkYTukfEXcvVwe
 hdDDIP9jUl6xlPpf50fZRFCTpnIZdwgjDYWuJC4yp4H5XnWVU+mIfx5okgPYVUoDcbdH
 u3iQ==
X-Gm-Message-State: APjAAAVX61gG92XlKSSW9STlIRQhjgvQZEPw0SCvwijPQxrZXuk0WDkF
 6PtGUu9a+C+um9xrJStSYvjyjq+brYeQ//oyijiF0g==
X-Google-Smtp-Source: APXvYqyNFqn0sFI+yjtXobDaL5PEcPhhpURwvVCojvljibhuKZ1pbHBPLmU1jQzH6h4dLYEVhK6eTd5EEmkSdIaBgPU=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr3507111otg.91.1571324790733;
 Thu, 17 Oct 2019 08:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191017132122.4402-1-peter.maydell@linaro.org>
 <20191017132122.4402-4-peter.maydell@linaro.org>
 <d9e7dd55-01e5-d852-bbab-84f5209abb6f@redhat.com>
In-Reply-To: <d9e7dd55-01e5-d852-bbab-84f5209abb6f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 16:06:19 +0100
Message-ID: <CAFEAcA_zz=SYwD=iDgwVZcvPF4seZW9qdvfGKfmK_UaaUDF7Vg@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/dma/xilinx_axidma.c: Switch to transaction-based
 ptimer API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 16:01, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 10/17/19 3:21 PM, Peter Maydell wrote:
> > Switch the xilinx_axidma code away from bottom-half based ptimers to
> > the new transaction-based ptimer API.  This just requires adding
> > begin/commit calls around the various places that modify the ptimer
> > state, and using the new ptimer_init() function to create the timer.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/dma/xilinx_axidma.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> > index e035d1f7504..fb3a978e282 100644
> > --- a/hw/dma/xilinx_axidma.c
> > +++ b/hw/dma/xilinx_axidma.c
> > @@ -31,7 +31,6 @@
> >   #include "hw/ptimer.h"
> >   #include "hw/qdev-properties.h"
> >   #include "qemu/log.h"
> > -#include "qemu/main-loop.h"
> >   #include "qemu/module.h"
> >
> >   #include "hw/stream.h"
> > @@ -104,7 +103,6 @@ enum {
> >   };
> >
> >   struct Stream {
> > -    QEMUBH *bh;
> >       ptimer_state *ptimer;
> >       qemu_irq irq;
> >
> > @@ -242,6 +240,7 @@ static void stream_complete(struct Stream *s)
> >       unsigned int comp_delay;
> >
> >       /* Start the delayed timer.  */
> > +    ptimer_transaction_begin(s->ptimer);
> >       comp_delay =3D s->regs[R_DMACR] >> 24;
> >       if (comp_delay) {
> >           ptimer_stop(s->ptimer);
> > @@ -255,6 +254,7 @@ static void stream_complete(struct Stream *s)
> >           s->regs[R_DMASR] |=3D DMASR_IOC_IRQ;
> >           stream_reload_complete_cnt(s);
> >       }
> > +    ptimer_transaction_commit(s->ptimer);
>
> I'd restrict the transaction here within the if() statement:
>
> -- >8 --
> @@ -244,9 +244,11 @@ static void stream_complete(struct Stream *s)
>       /* Start the delayed timer.  */
>       comp_delay =3D s->regs[R_DMACR] >> 24;
>       if (comp_delay) {
> +        ptimer_transaction_begin(s->ptimer);
>           ptimer_stop(s->ptimer);
>           ptimer_set_count(s->ptimer, comp_delay);
>           ptimer_run(s->ptimer, 1);
> +        ptimer_transaction_commit(s->ptimer);
>       }
>
>       s->complete_cnt--;

The timer_hit callback function itself writes to
s->complete_cnt, so we don't want to allow it to
be called (via the commit()) before stream_complete()
is done with changing that state.

thanks
-- PMM

