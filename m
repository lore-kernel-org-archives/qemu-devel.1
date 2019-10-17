Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9FCFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADB421835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZ7NZrWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADB421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL87d-0002yk-1G
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL7Gr-0001tq-QZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL7Gq-00057w-BO
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:00:57 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL7Gq-000579-5w
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:00:56 -0400
Received: by mail-oi1-x243.google.com with SMTP id k25so2380290oiw.13
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IsaDImg1iWjxY0xe9YeJsmhuk7gmS80rLExZgryFhNk=;
 b=vZ7NZrWdNbRdqSRGTdUaMesaRfDG9i7A2MP5GUlVlsc5rdo5AiDGRAGhBEPNAYwDdJ
 TRZujaCKBISbunl+KFNY/esEPybQMV0kjCnfSzh7vDrhqbNkjpiw6sm3D5GdHJTqevhB
 0z1vaOKqTPZtNtCEkxlpY8NRig3LKv3QvCqkqVJBO2OxK3iAP1ttBqfQ+vuq3I6eAdT8
 IwY+HMJcsjUKaFh0nqL1yOpu6qveZWIhs4O6NqxT8nktWyoSzHbfxV4Sk0yVOgruW2gR
 4PW0Pfx2cbl/8hGARMKz+uin+6mYeXXpFcTHGI/zcqdKQ4AsUflav3RaHYyIAp/uEauV
 1IHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IsaDImg1iWjxY0xe9YeJsmhuk7gmS80rLExZgryFhNk=;
 b=M/BGXXnSUR7ylLnYZVyUcFaLv2CuBTU092h9YoT2sTqoueruZlmRUyFsk70bMq0ake
 19yMcv95k9/MkaDy6uBfDcW9eavRauWA+6yVRR4mksin4u47NHKGrII6GOJVrre49/wp
 vheFF2WQndx2HJgI4/EJWBl0iZZO7Ix+9r2v1KJykrBvxd/Ha8wALMrnB8dSBg7zmtnV
 8W6Kw6+5IKF6vos+alUSs8S6B5DcgKTvErYdwbYY5ZLQSKWSQ7dqRnjwMpONwNKu9XEf
 uLfCeXHxpbmOseh/bgOI5pzF1PlH9F9cHVWTeea/dw3szwE+eZk66ByapXxmybY7hqoO
 6NGw==
X-Gm-Message-State: APjAAAUGLPfJ9nBPllrK/rsbm+lyfhDTydzI8OskrCmJ1fxfHHTeqokf
 A0C7qsBAepepsWXEYUqbGndleMiIVecgGytqelCZt6ObtEo=
X-Google-Smtp-Source: APXvYqx8JLmvXJ5k87dBM1jD7PlQy6Yu3WYzxJFN8zB3gGFJP4rNdmgROXXhsO2QOYVYqUpHSNynPoZ+pVueYmv1LNE=
X-Received: by 2002:a54:4e83:: with SMTP id c3mr3654746oiy.170.1571324455212; 
 Thu, 17 Oct 2019 08:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191017132351.4762-1-peter.maydell@linaro.org>
 <20191017132351.4762-3-peter.maydell@linaro.org>
 <2210f783-1159-1263-dfff-3bd84111e2f5@redhat.com>
In-Reply-To: <2210f783-1159-1263-dfff-3bd84111e2f5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 16:00:43 +0100
Message-ID: <CAFEAcA_jYjN=pQ719kbrRGXF2f8uDg_uj1r_dO0320qqB1Nppg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/timer/slavio_timer.c: Switch to transaction-based
 ptimer API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 15:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 10/17/19 3:23 PM, Peter Maydell wrote:
> > Switch the slavio_timer code away from bottom-half based ptimers to
> > the new transaction-based ptimer API.  This just requires adding
> > begin/commit calls around the various places that modify the ptimer
> > state, and using the new ptimer_init() function to create the timer.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/timer/slavio_timer.c | 20 ++++++++++++++++----
> >   1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
> > index 692d213897d..0e2efe6fe89 100644
> > --- a/hw/timer/slavio_timer.c
> > +++ b/hw/timer/slavio_timer.c
> > @@ -30,7 +30,6 @@
> >   #include "hw/sysbus.h"
> >   #include "migration/vmstate.h"
> >   #include "trace.h"
> > -#include "qemu/main-loop.h"
> >   #include "qemu/module.h"
> >
> >   /*
> > @@ -213,6 +212,7 @@ static void slavio_timer_mem_writel(void *opaque, h=
waddr addr,
> >       saddr =3D addr >> 2;
> >       switch (saddr) {
> >       case TIMER_LIMIT:
> > +        ptimer_transaction_begin(t->timer);
> >           if (slavio_timer_is_user(tc)) {
> >               uint64_t count;
>
>
> This part is odd since there is a check on t->timer !=3D NULL later, and
> ptimer_transaction_commit() can't take NULL.

Hmm, I hadn't noticed that. I think the bug is the check
for NULL, though, beacuse the slavio_timer_init() function
always initializes all the timer pointers, so there's
no situation where the pointer can be non-NULL as far
as I can see. So I think I'd rather fix this by removing
the NULL pointer check...


> > @@ -255,13 +258,16 @@ static void slavio_timer_mem_writel(void *opaque,=
 hwaddr addr,
> >       case TIMER_COUNTER_NORST:
> >           // set limit without resetting counter
> >           t->limit =3D val & TIMER_MAX_COUNT32;
> > +        ptimer_transaction_begin(t->timer);
> >           if (t->limit =3D=3D 0) { /* free-run */
> >               ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(TIMER_MAX_COU=
NT32), 0);
> >           } else {
> >               ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 0)=
;
> >           }
> > +        ptimer_transaction_commit(t->timer);
> >           break;
> >       case TIMER_STATUS:
> > +        ptimer_transaction_begin(t->timer);
> >           if (slavio_timer_is_user(tc)) {
>
> I'd move the begin() here.

This would be awkward because then it won't neatly nest with
the commit call unless you add an extra if() for the
commit or otherwise rearrange/duplicate code...

> >               // start/stop user counter
> >               if (val & 1) {
> > @@ -273,6 +279,7 @@ static void slavio_timer_mem_writel(void *opaque, h=
waddr addr,
> >               }
> >           }
> >           t->run =3D val & 1;
> > +        ptimer_transaction_commit(t->timer);

...because the commit should come after we have finished
updating the timer state (t->run in this case), because
the trigger callback slavio_timer_irq() otherwise sees
inconsistent half-updated state if commit() calls it.

thanks
-- PMM

