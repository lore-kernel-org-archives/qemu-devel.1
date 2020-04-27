Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C0FC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA052063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWBGqHDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA052063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1hb-0002jX-SV
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jT1g3-0000D2-5Z
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jT1g2-0003Gg-3M
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:11:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jT1g1-0003D9-K5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587985911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44fC40IZNzUKfwrlo3x7vHgiSYm1evcK90FAaDkBx60=;
 b=KWBGqHDWBWj5gRGJ/UqUjfpAZa/jExiKoFad+kbPUnYEzZZ9tJx2fVbivFxF4eeS1FkXk9
 HvdfMmQ6dTJJdyPk7Pri8ccfuUof2JLLTU3/w6UMSE84gSK7ocrH8uRah9hpw3SXVOyLoV
 kL3SZs+/fNXIPueI0heuS8rCthQ6Y2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-nxxI4_u1OTqGDuYxcOSnFQ-1; Mon, 27 Apr 2020 07:11:49 -0400
X-MC-Unique: nxxI4_u1OTqGDuYxcOSnFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DB8680B722;
 Mon, 27 Apr 2020 11:11:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33A8B605CB;
 Mon, 27 Apr 2020 11:11:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 14EFC1753B; Mon, 27 Apr 2020 13:11:44 +0200 (CEST)
Date: Mon, 27 Apr 2020 13:11:44 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH 4/5] ramfb: add sanity checks to
 ramfb_create_display_surface
Message-ID: <20200427111144.iphotoyrq65yrjd7@sirius.home.kraxel.org>
References: <20200422100211.30614-1-kraxel@redhat.com>
 <20200422100211.30614-5-kraxel@redhat.com>
 <b4af9628-1585-9dc5-214d-b55db4760da1@redhat.com>
 <20200423114129.lil77p4iqy3jc5v7@sirius.home.kraxel.org>
 <7eb38a07-a50c-2695-2ca7-822f5c1408eb@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7eb38a07-a50c-2695-2ca7-822f5c1408eb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > -    size =3D (hwaddr)linesize * height;
> > -    data =3D cpu_physical_memory_map(addr, &size, false);
> > -    if (size !=3D (hwaddr)linesize * height) {
> > -        cpu_physical_memory_unmap(data, size, 0, 0);
> > +    mapsize =3D size =3D stride * (height - 1) + linesize;
> > +    data =3D cpu_physical_memory_map(addr, &mapsize, false);
> > +    if (size !=3D mapsize) {
> > +        cpu_physical_memory_unmap(data, mapsize, 0, 0);
> >          return NULL;
> >      }
> > =20
> >      surface =3D qemu_create_displaysurface_from(width, height,
> > -                                              format, linesize, data);
> > +                                              format, stride, data);
> >      pixman_image_set_destroy_function(surface->image,
> >                                        ramfb_unmap_display_surface, NUL=
L);
> > =20
> >=20
>=20
> I don't understand two things about this patch:
>=20
> - "stride" can still be smaller than "linesize" (scanlines can still
> overlap). Why is that not a problem?

Why it should be?  It is the guests choice.  Not a very useful one, but
hey, if the guest prefers it that way we are at your service ...

We only must make sure our size calculations are correct.  The patch
does that.  I think we can also outlaw stride < linesize if you are
happier with that alternative approach.  I doubt we have any guests
relying on this working.

> - assuming "stride > linesize" (i.e., strictly larger), we don't seem to
> map the last complete stride, and that seems to be intentional. Is that
> safe with regard to qemu_create_displaysurface_from()? Ultimately the
> stride is passed to pixman_image_create_bits(), and the underlying
> "data" may not be large enough for that. What am I missing?

Lets take a real-world example.  Wayland rounds up width and height to
multiples of 64 (probably for tiling on modern GPUs).  So with 800x600
you get an allocation of 832x640, like this:

     ###########**   <- y 0
     ###########**
     ###########**
     ###########**
     ###########**   <- y 600
     *************   <- y 640

     ^         ^ ^----- x 832
     |         +------- x 800
     +----------------- x 0

where "#" is image data and "*" is unused padding space.  Pixman will
access all "#", so we are mapping the region from the first "#" to the
last "#", including the unused padding on each scanline, except for the
last scanline.  Any unused scanlines at the bottom are excluded too
(ramfb doesn't even know whenever they exist).

The unused padding is only mapped because it is the easiest way to
handle things, not because we need it.  Also the padding is typically
*alot* smaller than PAGE_SIZE, so we couldn't exclude it from the
mapping even if we would like to ;)

> Hm... bonus question: qemu_create_displaysurface_from() still accepts
> "linesize" as a signed int. (Not sure about pixman_image_create_bits().)
> Should we do something specific to prevent that value from being
> negative? The guest gives us a uint32_t.

Not fully sure we can do that without breaking something, might be a
negative stride is used for upside down images (last scanline comes
first in memory).

take care,
  Gerd


