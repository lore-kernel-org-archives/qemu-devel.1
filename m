Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC1EC5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F1C208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKSyTQVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F1C208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8L90-0000Pg-Cz
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1i8L88-0008LL-3c
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1i8L86-0001wC-46
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:11:07 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:41569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1i8L85-0001vf-PR
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:11:06 -0400
Received: by mail-io1-xd44.google.com with SMTP id r26so52675118ioh.8
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 02:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fjN5P0wM5n5cAbnTGz8QNFvuTGIcf+TJUZALuen0eKM=;
 b=yKSyTQVIwOlJB/pyXlaLU4BM2G61Bir//KZz/q1/m73pQ3sVrLDLK+zfNEEddBBNpE
 yah8Dvlhqp1ibsslZMkJQC2Scm21wdK8YqzZCzS9mzpA2eOveubXmNUo6UHWEit/U+hk
 OHuJSlm5uBT0hHTL6CRk3hJLuY7i2XC3rrdG5Hv9WVcJVpoe3T07jueRVfe+aRRX61DA
 0Ie/imUd3OZsobOA7y0uCRBQf7nGVZwncdEvbc93dANuzO1v/LDIUGF9Dl2zKvm8OGDX
 XwRjU+jw3DFTSKhSjRWTwSbIp/HBGAPupnLusyGD5S+vswbIC7mn/RmygrwULkQ7pKSa
 bBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fjN5P0wM5n5cAbnTGz8QNFvuTGIcf+TJUZALuen0eKM=;
 b=I6vyx0iL5/M9JkucSbOlovET+Z3kPBBTlC6mIN6hwPpoXdkq74KvoetdjJMFyhh69e
 y8Drr2MWgiRaxSr4BXcDcUuMuyVB4573QwlYLeoLoxBDbeWOEYiNhAgDnLoU/Jx2lxEm
 z+Mj9Z4kra1fn/4nIWRsvraPtS8VDSKWmCKRnrbYIAVckH+hRtoNc6CHEsNuIs1OqAk7
 K6EpfS4tIGTy4zXOfAEWLeebqDwjQ8BL0vjzvPP7SLZF/quC8ybQ4PJMv+p2pO73ahy4
 HBX9mihzs1frUoji0q5g/VQANnRvmVAudreSLMg8K7wd04pM4De0dFRHmCwLPP0lvB1N
 Gstw==
X-Gm-Message-State: APjAAAXRbL8DS4zSvedbvm1i/POJve1LaNYe1t0tdXwaZ/7zib/JbPQs
 85SS0KZgbCPd+ERYtOhNuBGhRU5tNB55sEbD69jbqA==
X-Google-Smtp-Source: APXvYqzE1ddEWZT5hqVWLd+jcuOhvC4c+e2nTyoMYl5BdBlHX7NIisNQow2HgAT2TY81vE2+RjSvxNb7XJMxjRTVhAE=
X-Received: by 2002:a6b:b714:: with SMTP id h20mr3199503iof.302.1568279463439; 
 Thu, 12 Sep 2019 02:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-4-beata.michalska@linaro.org>
 <20190910102601.GA2797@work-vm>
 <CADSWDzs_Cof-L8dGBeYVEY1dNx4Ot6sNcAKtCrvcxZW-3+KUvA@mail.gmail.com>
 <20190910131617.GC2797@work-vm>
 <CADSWDzuuWqBF9rP57Zv7jFPKUhFdVLq-O_uqs29i4dAFz+CgUA@mail.gmail.com>
 <20190911103645.GF2894@work-vm>
In-Reply-To: <20190911103645.GF2894@work-vm>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Thu, 12 Sep 2019 10:10:51 +0100
Message-ID: <CADSWDztimAoz_bjfOUPQH7t8vLuJWaqYFOJvQkc-rBHi8Mnyxw@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PATCH 3/4] migration: ram: Switch to ram block
 writeback
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
Cc: Peter Maydell <peter.maydell@linaro.org>, quintela@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 at 11:36, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Beata Michalska (beata.michalska@linaro.org) wrote:
> > On Tue, 10 Sep 2019 at 14:16, Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> > >
> > > * Beata Michalska (beata.michalska@linaro.org) wrote:
> > > > On Tue, 10 Sep 2019 at 12:26, Dr. David Alan Gilbert
> > > > <dgilbert@redhat.com> wrote:
> > > > >
> > > > > * Beata Michalska (beata.michalska@linaro.org) wrote:
> > > > > > Switch to ram block writeback for pmem migration.
> > > > > >
> > > > > > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > > > > > ---
> > > > > >  migration/ram.c | 5 +----
> > > > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > > > index b01a37e7ca..8ea0bd63fc 100644
> > > > > > --- a/migration/ram.c
> > > > > > +++ b/migration/ram.c
> > > > > > @@ -33,7 +33,6 @@
> > > > > >  #include "qemu/bitops.h"
> > > > > >  #include "qemu/bitmap.h"
> > > > > >  #include "qemu/main-loop.h"
> > > > > > -#include "qemu/pmem.h"
> > > > > >  #include "xbzrle.h"
> > > > > >  #include "ram.h"
> > > > > >  #include "migration.h"
> > > > > > @@ -4064,9 +4063,7 @@ static int ram_load_cleanup(void *opaque)
> > > > > >      RAMBlock *rb;
> > > > > >
> > > > > >      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> > > > > > -        if (ramblock_is_pmem(rb)) {
> > > > > > -            pmem_persist(rb->host, rb->used_length);
> > > > > > -        }
> > > > > > +        qemu_ram_block_writeback(rb);
> > > > >
> > > > > ACK for migration
> > > > >
> > > > > Although I do worry that if you really have pmem hardware, is it better
> > > > > to fail the migration if you don't have libpmem available?
> > > >
> > > > According to the PMDG man page, pmem_persist is supposed to be
> > > > equivalent for the msync.
> > >
> > > OK, but you do define qemu_ram_block_writeback to fall back to fdatasync;
> > > so that would be too little?
> >
> > Actually it shouldn't. All will end-up in vfs_fsync_range; msync will
> > narrow the range.
> > fdatasync will trigger the same call just that with a wider range. At
> > least for Linux.
> > fdatasync will also fallback to fsync if it is not available.
> > So it's going from the best case scenario (as of performance and range of mem
> > to be synced) towards the worst case one.
> >
> > I should probably double-check earlier versions of Linux.
> > I'll also try to verify that for other host variants.
>
> Well I guess it should probably follow whatever Posix says;  it's OK to
> make Linux specific assumptions for Linux specific bits - but you can't
> do it by code examination to guarantee it'll be right for other
> platforms, especially if this is in code ifdef'd for portability.
> Also it needs commenting to explain why it's safe to avoid someone else
> asking this question.
>
I will definitely address that in the next version.
Will just wait a bit to potentially gather more input
on the series.

> > BTW: Thank you for having a look at the changes.
>
> No problem.
>
Thanks again.

BR
Beata
> Dave
>
> > BR
> > Beata
> >
> > >
> > > > It's just more performant. So in case of real pmem hardware it should
> > > > be all good.
> > > >
> > > > [http://pmem.io/pmdk/manpages/linux/v1.2/libpmem.3.html]
> > >
> > > Dave
> > >
> > > >
> > > > BR
> > > > Beata
> > > > >
> > > > > Dave
> > > > >
> > > > > >      }
> > > > > >
> > > > > >      xbzrle_load_cleanup();
> > > > > > --
> > > > > > 2.17.1
> > > > > >
> > > > > --
> > > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

