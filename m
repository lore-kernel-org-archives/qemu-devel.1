Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A9FC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819172072A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPd6TayJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819172072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7tK-0006ab-FK
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jO7sg-00064J-FJ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jO7sf-0000UW-FB
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:48:42 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:45395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jO7sf-0000U0-8r
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:48:41 -0400
Received: by mail-io1-xd43.google.com with SMTP id i19so11152484ioh.12
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HLDQ0NrzEhLYYF0w9Lr52B+hZGoVyQif9DBJcKAuyLc=;
 b=bPd6TayJbn4t58WslP5GD0nKbFRS+xYcZXU94E8FGdPTnIT7mezkl3DMR5FHhXLhLv
 tUIbQ1LqEWxyQTXZScEAWBOTbP3jhHAkmrjxsFBzBUbnZGThHQJl9GRM5XLhWk1UMnS9
 IYWdrZ0XbQ5z5lyRZ1C9V33t3bruX0IXxRJ1LqZKT5uVuhr1Sml/n60/WkxicxLKIG43
 gdyKVlxiIRy8f+L539UQDUqgdUBMZFVZipiA0hodlLQzdeM27RTBJLdSbaoiPkqwNlRT
 MAL1BM6unoVyY1uGGu5U++BezIhvD/dkcw5Zh7H50ot7evoSHH0NOA+T7hXfPUOvsbCh
 No6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HLDQ0NrzEhLYYF0w9Lr52B+hZGoVyQif9DBJcKAuyLc=;
 b=R+okEToA173nC/wqGve/cvXBNhrreNWhCpFzFTi5auHs4qSE0ejkCKH10qWIaJC5bk
 pcHuLQogFMEj6O9qUPFKq8xj9nRQeTQKtCsF770chRytSgymVv0BnczaDsFgw03VblQL
 9CYbOGheO2fioBC0cx9XBO9A4Kxhf0i7CH2NcrYbQENc1HcIIjouA4Ormf9VkdSIWUis
 xM3x+YgUG4SrANGeE9cWKupYMfiBYmSA6AaG8z0xoXls5Bq6Qr2MGvdcvVkVQFjfuKi3
 imbF9M6tCdOo3zhtQEzZbN1Q+oU//daaCqAdXNTSrPZ2lRf8RqQbA96T7O3HdAH16Jr6
 x9Lg==
X-Gm-Message-State: AGi0PubnKHbMpeHURK9lOr2SevqltYhNZXy0Wp6BUmbwXaHjQhPVLjkj
 ppyh3eFcuts6avZclIHdfH9WjQpyW7bCfBQqRTA=
X-Google-Smtp-Source: APiQypK18IMnak8xHHmQupKd/8EMGx2m0pHJF5VpYtJoAKpDHlcQuiRJ0RclvUMvKPd+DvWASCFwFIURAL6+tswcDT4=
X-Received: by 2002:a02:90cd:: with SMTP id c13mr490069jag.83.1586818120139;
 Mon, 13 Apr 2020 15:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
 <20200410034150.24738.98143.stgit@localhost.localdomain>
 <c9b60224-e280-7351-33df-bbb3e25f6cfd@redhat.com>
In-Reply-To: <c9b60224-e280-7351-33df-bbb3e25f6cfd@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 13 Apr 2020 15:48:29 -0700
Message-ID: <CAKgT0UcLfpyGOmaOk9zYT6mfgR2E=Ra-1ViMN3gAeTX2r9CCag@mail.gmail.com>
Subject: Re: [PATCH v19 QEMU 4/4] memory: Do not allow direct write access to
 rom_device regions
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 10, 2020 at 3:50 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/04/20 05:41, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > According to the documentation in memory.h a ROM memory region will be
> > backed by RAM for reads, but is supposed to go through a callback for
> > writes. Currently we were not checking for the existence of the rom_device
> > flag when determining if we could perform a direct write or not.
> >
> > To correct that add a check to memory_region_is_direct so that if the
> > memory region has the rom_device flag set we will return false for all
> > checks where is_write is set.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  include/exec/memory.h |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 1614d9a02c0c..e000bd2f97b2 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -2351,8 +2351,8 @@ void address_space_write_cached_slow(MemoryRegionCache *cache,
> >  static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
> >  {
> >      if (is_write) {
> > -        return memory_region_is_ram(mr) &&
> > -               !mr->readonly && !memory_region_is_ram_device(mr);
> > +        return memory_region_is_ram(mr) && !mr->readonly &&
> > +               !mr->rom_device && !memory_region_is_ram_device(mr);
> >      } else {
> >          return (memory_region_is_ram(mr) && !memory_region_is_ram_device(mr)) ||
> >                 memory_region_is_romd(mr);
> >
>
> Good catch.  I queued this up for 5.0.
>
> Thanks,
>
> Paolo

Thanks Paolo,

It looks like you only pulled this patch correct?

If so, David & Michael, do I need to resubmit the first 3 in this
series or can those be pulled separately?

Thanks.

Alex

