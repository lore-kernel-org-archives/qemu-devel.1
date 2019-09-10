Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82BAC4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F44120863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycqOOqAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F44120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7h2H-00039K-QM
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1i7h1W-0002bM-LK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1i7h1V-0002QU-7H
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:21:38 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:43667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1i7h1U-0002OL-Vc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:21:37 -0400
Received: by mail-io1-xd44.google.com with SMTP id r8so12927740iol.10
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wfRraz2ruSHapGr6bfmzq/GsC2dcKbWra3/cK+B22II=;
 b=ycqOOqACfAnPjwma5p/hFLiJ9hRtspl83x4g17PdzWEu4Nlu3Zx47AKGg1nyXy2lGd
 pJ6hlpxb58VE260bfd4za4ZBXasiHEw6YBUlzjXqH1W+pJq+zbDYpevVGT8XrpVlwV0y
 VuIIQN96avX3KL64eqd25D2KI6O1ojlEu9hLjB1ybIcsull7NKQttpEh6Tr3/W+nlSyv
 Al9odGL09637Lu/263IRRzsMY4++5c50Y1oQtppJr16x2qahmCLurQnvwZKwvKfVUPFD
 TTIiBHyLN445Vga5jhjn9p02qvhkk9K80VzgW+U7oYW1jczWHCz/3lDQWxLgJ9jWhUZk
 ZO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wfRraz2ruSHapGr6bfmzq/GsC2dcKbWra3/cK+B22II=;
 b=RNIQwMDQuy6b5VCK+gKOMkBNuNyGioeXTyYxEh1CRZeyVUOiQ3Sh09jimLz/i8EALK
 5rUvRY8GzLhFM1BuP46Rl9qhJZ7VleiX5hkCuCWuoEfOquK914nMfR+GiP0TfER2BDsA
 N+sa9Q8tOkQmwsgxu42mO50K9WWda+ANN/47KZcFiNZo+uut4LTU6nTL0/c+K3zTxKWq
 jVxSI1jZFeeV7KjzuiCFrNpUfRW/Z89jH1ObMkz/pxqeosdTuJHivOipEqKKezRl5veq
 iGLzHjS1G+LHuIauJU5EdUUqiag6GT/6FuyCry+uC/w7gtHn0ufyLTHgC+Gdz2b10lTP
 0ZAg==
X-Gm-Message-State: APjAAAWUwAcbEGLUj/RwffKkvKVAXTW/h/zMvJ0BIjxuoIat14H10ch/
 KLOD2fOSaozv+K85xMH4lfk93LDcnzgbZIw3eRIGzg==
X-Google-Smtp-Source: APXvYqyQ+hbN9xc9VZJz9epFO3q3EH8WTCP57Ba53poX/bweiwiP45mzU1/4aok5EFZ+fUFBk7GrJjAjN9E1FFM2szs=
X-Received: by 2002:a6b:7709:: with SMTP id n9mr28108266iom.187.1568125295788; 
 Tue, 10 Sep 2019 07:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-4-beata.michalska@linaro.org>
 <20190910102601.GA2797@work-vm>
 <CADSWDzs_Cof-L8dGBeYVEY1dNx4Ot6sNcAKtCrvcxZW-3+KUvA@mail.gmail.com>
 <20190910131617.GC2797@work-vm>
In-Reply-To: <20190910131617.GC2797@work-vm>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 10 Sep 2019 15:21:24 +0100
Message-ID: <CADSWDzuuWqBF9rP57Zv7jFPKUhFdVLq-O_uqs29i4dAFz+CgUA@mail.gmail.com>
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

On Tue, 10 Sep 2019 at 14:16, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Beata Michalska (beata.michalska@linaro.org) wrote:
> > On Tue, 10 Sep 2019 at 12:26, Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> > >
> > > * Beata Michalska (beata.michalska@linaro.org) wrote:
> > > > Switch to ram block writeback for pmem migration.
> > > >
> > > > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > > > ---
> > > >  migration/ram.c | 5 +----
> > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > >
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index b01a37e7ca..8ea0bd63fc 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -33,7 +33,6 @@
> > > >  #include "qemu/bitops.h"
> > > >  #include "qemu/bitmap.h"
> > > >  #include "qemu/main-loop.h"
> > > > -#include "qemu/pmem.h"
> > > >  #include "xbzrle.h"
> > > >  #include "ram.h"
> > > >  #include "migration.h"
> > > > @@ -4064,9 +4063,7 @@ static int ram_load_cleanup(void *opaque)
> > > >      RAMBlock *rb;
> > > >
> > > >      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> > > > -        if (ramblock_is_pmem(rb)) {
> > > > -            pmem_persist(rb->host, rb->used_length);
> > > > -        }
> > > > +        qemu_ram_block_writeback(rb);
> > >
> > > ACK for migration
> > >
> > > Although I do worry that if you really have pmem hardware, is it better
> > > to fail the migration if you don't have libpmem available?
> >
> > According to the PMDG man page, pmem_persist is supposed to be
> > equivalent for the msync.
>
> OK, but you do define qemu_ram_block_writeback to fall back to fdatasync;
> so that would be too little?

Actually it shouldn't. All will end-up in vfs_fsync_range; msync will
narrow the range.
fdatasync will trigger the same call just that with a wider range. At
least for Linux.
fdatasync will also fallback to fsync if it is not available.
So it's going from the best case scenario (as of performance and range of mem
to be synced) towards the worst case one.

I should probably double-check earlier versions of Linux.
I'll also try to verify that for other host variants.

BTW: Thank you for having a look at the changes.

BR
Beata

>
> > It's just more performant. So in case of real pmem hardware it should
> > be all good.
> >
> > [http://pmem.io/pmdk/manpages/linux/v1.2/libpmem.3.html]
>
> Dave
>
> >
> > BR
> > Beata
> > >
> > > Dave
> > >
> > > >      }
> > > >
> > > >      xbzrle_load_cleanup();
> > > > --
> > > > 2.17.1
> > > >
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

