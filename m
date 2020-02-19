Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0090C34050
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE0721D56
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ienNrOax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE0721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4LVk-0004xy-LJ
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 04:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j4LVC-0004YU-Dx
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j4LVB-0006n5-8D
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:18:42 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43793)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j4LVB-0006mm-2F
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:18:41 -0500
Received: by mail-qk1-x742.google.com with SMTP id p7so22352087qkh.10
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 01:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JWgmwK5mR1u0nx49uuhBMDASkAZT+Y/fF9AkZToGheA=;
 b=ienNrOaxOt/GZrQUdTp5FBCXl/+MADgrWu8aLlovlEhch9mu/w7WybzCzTYeE1bJRh
 wPVudotZpJg5umIJJYDcdW0fQiNyjGOLxtaBLDMqMn4FZ0izGxt/5dXXg72Y92+C3LO8
 hSrpX4dSzX4n0otBukCrsJRx40HzGFD7Asr6budPLHUGz+o0JrQS5PLWfzPi1UQRzBni
 1BC6FJTWNDvYHePQ16b72Ig6c8ZAMZJrv1hqh5aRXTDYcC0v+7qLB/H2gQtX0yWpIy9Q
 31cWxHSgFYnLK1jn2ErPj/9gm7uBuHm/Yzpcq5yQhUvuE+eNFGTb1JoSzT3VQb6Ubzqj
 ofGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JWgmwK5mR1u0nx49uuhBMDASkAZT+Y/fF9AkZToGheA=;
 b=OTsv8ixLRiSO7sKnq20cdXDAZek8DFi7ur7Prk4hb7GL5eKXCh+QfAF5Jmxm73Y3CI
 1vI0R+GX1m95hgYR/fxohzRWwRkVGwfA1UWQ00b9yZ3W4GvphtdCWgVd6jw6lOQk2d2u
 aIosHNTrjMvCV7PxmMvpDw2uOEs8a5Vc7Nn6eUnFrdg5l09n24unvx8xwhgjNVV6zsnq
 zGzndcMatUv2TGzHNgWZOmOQYFfTdPE54+6X6y5K56H3BCHPtPavXkQ/0PaKKM21hJkK
 KX1QfpoEciMdH+0RrLBgGVgy4y2bM+ul2VGIb2IOCieaoAsb4qWQdOS4ClkX9Zr7yI31
 W39g==
X-Gm-Message-State: APjAAAXHXYn4NSX7gNbTzqTGkLXUqVmWUpJdH5KRJuxY0l2pyHW2xrGT
 gjbbF1DT8vbdBmhtDhJJMOFL3o7Cr/xRWkC1b/s=
X-Google-Smtp-Source: APXvYqzhsYCYQ8Y3W6EE5Sve+T7+TtgHNMUzUvtyi519ai6ohwZ3X1/4zpLJ5xwvM5oPQt0+ajTLRBn+tdGUWDhNjk8=
X-Received: by 2002:a05:620a:1014:: with SMTP id
 z20mr21757299qkj.196.1582103920065; 
 Wed, 19 Feb 2020 01:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20200218182226.913977-1-stefanha@redhat.com>
 <20200218214932.GD7090@xz-x1>
In-Reply-To: <20200218214932.GD7090@xz-x1>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 19 Feb 2020 09:18:29 +0000
Message-ID: <CAJSP0QV2+w0SNq+FtuYUfpAp_xcqg1rP8zdsYhfNxW49M3ANQg@mail.gmail.com>
Subject: Re: [PATCH] memory: batch allocate ioeventfds[] in
 address_space_update_ioeventfds()
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 9:50 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Feb 18, 2020 at 06:22:26PM +0000, Stefan Hajnoczi wrote:
> > Reallocing the ioeventfds[] array each time an element is added is very
> > expensive as the number of ioeventfds increases.  Batch allocate instead
> > to amortize the cost of realloc.
> >
> > This patch reduces Linux guest boot times from 362s to 140s when there
> > are 2 virtio-blk devices with 1 virtqueue and 99 virtio-blk devices with
> > 32 virtqueues.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  memory.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/memory.c b/memory.c
> > index aeaa8dcc9e..2d6f931f8c 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -794,10 +794,18 @@ static void address_space_update_ioeventfds(AddressSpace *as)
> >      FlatView *view;
> >      FlatRange *fr;
> >      unsigned ioeventfd_nb = 0;
> > -    MemoryRegionIoeventfd *ioeventfds = NULL;
> > +    unsigned ioeventfd_max;
> > +    MemoryRegionIoeventfd *ioeventfds;
> >      AddrRange tmp;
> >      unsigned i;
> >
> > +    /*
> > +     * It is likely that the number of ioeventfds hasn't changed much, so use
> > +     * the previous size as the starting value.
> > +     */
> > +    ioeventfd_max = as->ioeventfd_nb;
> > +    ioeventfds = g_new(MemoryRegionIoeventfd, ioeventfd_max);
>
> Would the ioeventfd_max being cached and never goes down but it can
> only keep or increase?

No, it will decrease but only the next time
address_space_update_ioeventfds() is called.  That's when we'll use
the next ioeventfds_nb as the starting point.

> I'm not sure if that's a big problem, but
> considering the commit message mentioned 99 virtio-blk with 32 queues
> each, I'm not sure... :)
>
> I'm thinking maybe start with a relative big number but always under
> control (e.g., 64), then...

I also considered doing a final g_realloc() at the end of the function
to get rid of the excess allocation but I'm not sure it's worth it...

> > +
> >      view = address_space_get_flatview(as);
> >      FOR_EACH_FLAT_RANGE(fr, view) {
> >          for (i = 0; i < fr->mr->ioeventfd_nb; ++i) {
> > @@ -806,8 +814,11 @@ static void address_space_update_ioeventfds(AddressSpace *as)
> >                                               int128_make64(fr->offset_in_region)));
> >              if (addrrange_intersects(fr->addr, tmp)) {
> >                  ++ioeventfd_nb;
> > -                ioeventfds = g_realloc(ioeventfds,
> > -                                          ioeventfd_nb * sizeof(*ioeventfds));
> > +                if (ioeventfd_nb > ioeventfd_max) {
> > +                    ioeventfd_max += 64;
>
> ... do exponential increase here (max*=2) instead so still easy to
> converge?

I'm happy to tweak the policy.  Let's see what Paolo thinks.

Stefan

