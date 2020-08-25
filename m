Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34DAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956A42076C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/ttGUfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956A42076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAcwI-0001Vh-Tf
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 13:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAcvb-0000pr-Ja
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:40:11 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:36929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAcvZ-0000v8-Rn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:40:11 -0400
Received: by mail-il1-x143.google.com with SMTP id v2so11152979ilq.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9ZcFLiin5cTi7A6p4hhWdoY2yjOWJyW/2e2mlQiZT3Y=;
 b=D/ttGUfvYILYRyi6sP9XLjDRppsfzxNF8B1fS3xl8ubaWLMFZp2Mplz+OrKyOHDYQi
 REUenpHSTNiEORDkp9riEkEXRPPVekV6xQTJ0iXNzhUmH54S0EAscLBSc66ubE9/t8pk
 1Hdjwg3E12x+gKDINl5y3Skgbd7DYGkl7IPH1DcyNpIWjnY6tW750ZzzLun+bSDjKAzH
 UGKccmcD5g4wIE6Q3iqkVzKrcPsx9dTmd6e9+doigHfsGfK+XJ3FJeh/fqpm+dCNNJXL
 ySqEqACGW1TchkAOCisN1KBFT7TbUE8o7CLgEj25GJGEhRqpG+Z14rkDMLodDvevCZS0
 eq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9ZcFLiin5cTi7A6p4hhWdoY2yjOWJyW/2e2mlQiZT3Y=;
 b=t9obCDJCyOOhi5H7xyVBKaUFtZ+6DSKKgqZzuAI8rVIIHQNeTDT12guUMm/wObUvrk
 Q0jtl4eMUpuZQYdXTQhlCGmDl72WDV4Ekj0AVFqI8AaMYDa0qxX9PNDmbh9+o/E5iZh8
 FJREDZBuaCvz8a9FuB4+6Jpl3Hpl3fnhsIWR/k0y9jK6f4THguP9BLrgRTnpPeGE0cwt
 iFKEG5xo9nb61VOxCz07AYQ6o8EKQVIXjmzgyOSvqfnlelyncOgjJ3VQJdh5Mc/lLFP/
 AAWAqPV95Cgmp4+pqG7qLe2wgfow2gYS7L/ruBVxXnZOW/TxSiIh9TCIzxbTLtQJvBZ5
 qSqQ==
X-Gm-Message-State: AOAM532x2AUGbuFMxKlM3Kv5VhwygGODS3GaOHtksAvZG+MbufV4Xgv5
 s2j6/BwvJwEGhMAuEWE3nIgGIO2KCuP0oW2bVOw=
X-Google-Smtp-Source: ABdhPJyl75oYdDc4Wu0aY032rXQMqOs4hAzwftnfVWn4r9x4qccILYUNFiUncJ7LrBDyY3krFwlLTEY8ref+8Z4y4RA=
X-Received: by 2002:a05:6e02:13f1:: with SMTP id
 w17mr10346314ilj.131.1598377208123; 
 Tue, 25 Aug 2020 10:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <87a2da602785bce972a6a6b4502769f4fee58a2d.1598074333.git.alistair.francis@wdc.com>
 <63024ede-9d19-7292-29d6-a33da6a7177e@amsat.org>
In-Reply-To: <63024ede-9d19-7292-29d6-a33da6a7177e@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Aug 2020 10:29:25 -0700
Message-ID: <CAKmqyKPEcVj98S_Jg3xc8-QAhEj_HOOZq1+VaibmGqkbe1H8-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] core/register: Specify instance_size in the
 TypeInfo
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: ehabkost@redhat.comg, Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 22, 2020 at 3:25 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Hi Alistair,
>
> On 8/22/20 7:33 AM, Alistair Francis wrote:
> > Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/core/register.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/core/register.c b/hw/core/register.c
> > index ddf91eb445..5e8e8199d0 100644
> > --- a/hw/core/register.c
> > +++ b/hw/core/register.c
> > @@ -180,11 +180,7 @@ void register_init(RegisterInfo *reg)
> >  {
> >      assert(reg);
> >
> > -    if (!reg->data || !reg->access) {
> > -        return;
> > -    }
> >
> > -    object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);
>
> Can we remove register_init()? Are concerned is it is declared
> publicly in "hw/register.h"?

Argh, I just missed this. Fixed in v2.

Alistair

>
> >  }
> >
> >  void register_write_memory(void *opaque, hwaddr addr,
> > @@ -269,13 +265,20 @@ static RegisterInfoArray *register_init_block(Dev=
iceState *owner,
> >          int index =3D rae[i].addr / data_size;
> >          RegisterInfo *r =3D &ri[index];
> >
> > +        if (data + data_size * index =3D=3D 0 || !&rae[i]) {
> > +            continue;
> > +        }
> > +
> > +        /* Init the register, this will zero it. */
> > +        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
> > +
> > +        /* Set the properties of the register */
> >          *r =3D (RegisterInfo) {
> >              .data =3D data + data_size * index,
> >              .data_size =3D data_size,
> >              .access =3D &rae[i],
> >              .opaque =3D owner,
> >          };
> > -        register_init(r);
> >
> >          r_array->r[i] =3D r;
> >      }
> > @@ -329,6 +332,7 @@ static const TypeInfo register_info =3D {
> >      .name  =3D TYPE_REGISTER,
> >      .parent =3D TYPE_DEVICE,
> >      .class_init =3D register_class_init,
> > +    .instance_size =3D sizeof(RegisterInfo),
> >  };
> >
> >  static void register_register_types(void)
> >
>

