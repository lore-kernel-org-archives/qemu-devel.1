Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327DAC2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0761D206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0761D206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNkGv-0006ZN-58
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 17:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkGD-0005zr-0E
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkGB-0001FP-TN
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:35:24 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkGB-0001F8-Pw; Sun, 12 Apr 2020 17:35:23 -0400
Received: by mail-yb1-f193.google.com with SMTP id 204so4323990ybw.5;
 Sun, 12 Apr 2020 14:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QNT3AIhp/itkqzgtWLeKv59/O5Y26lD7M4R9C9j+XD4=;
 b=FIYTqO19Lhya0RNzFSuxMxa2IqH9n8OeTXRmQYw9lG3VG7LM2fQhssM3z7uCok/09G
 Kl3smUM7eC6MsTaw82td4tFETSghDWVxzlZMv95qagUKntf9zePwehRLwMRSwpgecROf
 HL68UYZllDYb60BifkkbfcGbFu14s3yPcDHwKUk1aBFrQhoqi21pmf57Sj2i1bdNS+ma
 0QADj3oPWuBMNKo4yARXUu+Wxt0zLeiltuJ9kr4CPwDrQ3Cttmu7PltRkkjJ2gL3xNZT
 5jQzN2X1P8wOS+73qyr95npNNDl293c4YA3vg/ef2t4YebkqormyBNMxEXucYwGLguVz
 76uA==
X-Gm-Message-State: AGi0PuZuQoQ7pO9+u8E3qNg0FfhLZD3rp/VJwif7zI/PngAkSGG833EY
 3c7cbpRcna99nYlTRmonx+YDofbFa87VsgwQT1I=
X-Google-Smtp-Source: APiQypLUN220WWmMqcjquuFevpQzpJRVzJaPGAV7ew/3L6vuG4R+txj5/3ef/sr9/dOpsfVM4X+V8DyRKAcHHQ1rdtg=
X-Received: by 2002:a25:ba88:: with SMTP id s8mr21777521ybg.312.1586727322903; 
 Sun, 12 Apr 2020 14:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200408003552.58095-1-mansourweb@gmail.com>
 <34044154-1982-6f43-d124-bc4bc3924136@redhat.com>
In-Reply-To: <34044154-1982-6f43-d124-bc4bc3924136@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 12 Apr 2020 23:35:11 +0200
Message-ID: <CAAdtpL5hdLW_Svck+NTRssn6=463m7HhxzoiD+jf6UuYA_APeg@mail.gmail.com>
Subject: Re: [PATCH] When updating the PFLASH file contents, we should check
 for a possible failure of blk_pwrite(). Similar to 3a68829 commit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Mansour Ahmadi <mansourweb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.193
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping? rc3 is in 2 days.

On Wed, Apr 8, 2020 at 10:10 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Mansour,
>
> On 4/8/20 2:35 AM, Mansour Ahmadi wrote:
> > Signed-off-by: Mansour Ahmadi <mansourweb@gmail.com>
> > ---
> >   hw/block/pflash_cfi01.c | 6 +++++-
> >   hw/block/pflash_cfi02.c | 6 +++++-
> >   2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> > index 24f3bce7ef..31319cfd07 100644
> > --- a/hw/block/pflash_cfi01.c
> > +++ b/hw/block/pflash_cfi01.c
> > @@ -399,13 +399,17 @@ static void pflash_update(PFlashCFI01 *pfl, int o=
ffset,
> >                             int size)
> >   {
> >       int offset_end;
> > +    int ret;
> >       if (pfl->blk) {
> >           offset_end =3D offset + size;
> >           /* widen to sector boundaries */
> >           offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
> >           offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
> > -        blk_pwrite(pfl->blk, offset, pfl->storage + offset,
> > +        ret =3D blk_pwrite(pfl->blk, offset, pfl->storage + offset,
> >                      offset_end - offset, 0);
> > +     if (ret < 0) {
> > +            error_report("Could not update PFLASH: %s", strerror(-ret)=
);
>
> Thanks for your patch. Note that it doesn't compile:
>
> hw/block/pflash_cfi01.c:411:6: error: implicit declaration of function
> 'error_report' [-Werror=3Dimplicit-function-declaration]
>        error_report("Could not update PFLASH: %s", strerror(-ret));
>        ^
>
> Better than reporting the error is to set the error flag in the status
> register.
>
> > +        }
> >       }
> >   }
> >
> > diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> > index 12f18d401a..fee5b3497c 100644
> > --- a/hw/block/pflash_cfi02.c
> > +++ b/hw/block/pflash_cfi02.c
> > @@ -393,13 +393,17 @@ static uint64_t pflash_read(void *opaque, hwaddr =
offset, unsigned int width)
> >   static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
> >   {
> >       int offset_end;
> > +    int ret;
> >       if (pfl->blk) {
> >           offset_end =3D offset + size;
> >           /* widen to sector boundaries */
> >           offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
> >           offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
> > -        blk_pwrite(pfl->blk, offset, pfl->storage + offset,
> > +        ret =3D blk_pwrite(pfl->blk, offset, pfl->storage + offset,
> >                      offset_end - offset, 0);
> > +     if (ret < 0) {
> > +         error_report("Could not update PFLASH: %s", strerror(-ret));
> > +        }
>
> Similar comments (does not compile, set error status register).
>
> >       }
> >   }
> >
> >
>
>

