Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75492C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1FE2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkNCMsSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1FE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inGeQ-000702-2B
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 01:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1inGcK-00057W-Cy
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:39:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1inGcI-0000Tj-5X
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:39:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23526
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1inGcH-0000N9-Kg
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578033564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HO9RLhtwIIyQR4FFzIUqOddlqFWl6JdL+vs0Oe2+rVI=;
 b=MkNCMsSGGdBjjw2GTuy751wBvWVC1b+RH5r1CtHU5nB40iCWreZ6NOLioE9WytGvWPMlh2
 7tu3LSoUA501fM2jsNq7Z3MdH3Ta/2RX1gZVPiYemZcbs5A28OiEdxawrARy6KKpq2J1rQ
 8upQ9bQuuOYmb/DlIrJUTNn1BXcFPyM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-ePqugwd4P_Sqr1I-stXiBA-1; Fri, 03 Jan 2020 01:39:19 -0500
Received: by mail-ot1-f70.google.com with SMTP id l13so17249984otn.18
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 22:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HO9RLhtwIIyQR4FFzIUqOddlqFWl6JdL+vs0Oe2+rVI=;
 b=ItzDQF7qfZkwKLrhHuR7vx7tA7rZpks3QbmXmPOoNuWeG4DOEpHTmSQad/6XP8HA4b
 37/W3D0dInntuRsdrE+/2ClyvLg5jjFJc50+XJvkwEDMSspKAIsrEBLeUXp7qYizILDG
 Uej/r/oGj5DxJSZf0abeqj9gB1I/tfOz2hpC3Cyf7Vw8KY2rAfxHOwMH/TCE3vlZ59Mp
 cAD7TYgdGC+ibopzNL1+/y+pYQEgOQgdKifqS9RpErl5Bq6l/XZaxivIX4XObu2viRGK
 FtcNnBNfAmwpGAv3Xg3jjBofG2Lox/nMgahid8HdhTN45XvsMgAjv5POkRyxbFtOSYH6
 WA8A==
X-Gm-Message-State: APjAAAULAKvHmKPNWBvAUfYuX1PKMlqdfV6dyUGUaWe5nmvNeIS/v+Cb
 1+jEWBX53M0lgqRH051bCaahdUsJO3mODHx02lUbnjhbLUs2fsJo5KcHjDZHE/J6+zHjwnuXvFg
 s+4W22zTJQ7a28DuNBLzSELE1mruSTqQ=
X-Received: by 2002:a9d:4706:: with SMTP id a6mr90141530otf.331.1578033558719; 
 Thu, 02 Jan 2020 22:39:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1BTRb+jDUrG4qBKf1DsWDFJuTx99QF5H6uJ//B6csTLjVJutHhbqhcAeuKMcUOX0wxtMnHf1WVvWE5LyKL1Y=
X-Received: by 2002:a9d:4706:: with SMTP id a6mr90141517otf.331.1578033558546; 
 Thu, 02 Jan 2020 22:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20200102210149.926077-1-marcandre.lureau@redhat.com>
 <20200102210149.926077-2-marcandre.lureau@redhat.com>
 <926dcf48-e309-55a5-cfcd-bd1343c17f27@redhat.com>
In-Reply-To: <926dcf48-e309-55a5-cfcd-bd1343c17f27@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 3 Jan 2020 10:39:07 +0400
Message-ID: <CAMxuvawHor3Lf--XY8q=SCBKq0Ad3wYquaXhj4OYPjaQSp2hQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] RFC: savevm: check RAM is page_size aligned
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: ePqugwd4P_Sqr1I-stXiBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Jan 3, 2020 at 9:06 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> On 1/2/20 10:01 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Check the host pointer is correctly aligned, otherwise we may fail
> > during migration in ram_block_discard_range().
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   migration/savevm.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index a71b930b91..ab6e02011f 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2910,6 +2910,11 @@ err_drain:
> >
> >   void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
> >   {
> > +    RAMBlock *rb =3D mr->ram_block;
> > +    uintptr_t hostaddr =3D (uintptr_t)qemu_ram_get_host_addr(rb);
> > +
> > +    assert((hostaddr & (qemu_ram_pagesize(rb) - 1)) =3D=3D 0);
>
> Can we use the QEMU_PTR_IS_ALIGNED() macro instead?
>
>         assert(QEMU_PTR_IS_ALIGNED(qemu_ram_get_host_addr(rb),
>                                    qemu_ram_pagesize(rb)));
>

nice, good idea

> >       qemu_ram_set_idstr(mr->ram_block,
> >                          memory_region_name(mr), dev);
> >       qemu_ram_set_migratable(mr->ram_block);
> >
>


