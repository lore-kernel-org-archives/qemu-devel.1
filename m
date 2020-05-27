Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857442084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZTWoYlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857442084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsAo-0007R7-PI
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdsAE-00071k-8q
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:15:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44444
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdsAD-00077Z-1T
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590570951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m3I/Hpf7vR/w9E30qxcEWUpL3xlOG9KSxOfemQq2g5Q=;
 b=JZTWoYlfYzrReq73K670HQ6NliWD98HOIpzlwXdOppcfWWIl/P1MmIrQRLdntg6nRT/56Q
 fonsDGbkr0Pi4yU+i7mhxGYwD7fdnXfwos+IDi4Ke0R1nwwR2WN4ydbtr4fHLEKHHY3dBB
 WK4kmBYjlp30SvL/n2pBY/2scUUFdbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-8HogX4juM7y6qjFfM_bS4w-1; Wed, 27 May 2020 05:15:48 -0400
X-MC-Unique: 8HogX4juM7y6qjFfM_bS4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9789800688;
 Wed, 27 May 2020 09:15:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD4D65C1B0;
 Wed, 27 May 2020 09:15:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4E42B16E16; Wed, 27 May 2020 11:15:44 +0200 (CEST)
Date: Wed, 27 May 2020 11:15:44 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v2 5/7] sm501: Replace hand written implementation with
 pixman where possible
Message-ID: <20200527091544.j6uvyyxsbhin5viy@sirius.home.kraxel.org>
References: <cover.1590089984.git.balaton@eik.bme.hu>
 <58666389b6cae256e4e972a32c05cf8aa51bffc0.1590089984.git.balaton@eik.bme.hu>
 <20200526104318.wmsqqtia3h52l454@sirius.home.kraxel.org>
 <alpine.BSF.2.22.395.2005261434540.87757@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2005261434540.87757@zero.eik.bme.hu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > Well, the advantage of *not* using pixman is that you can easily switch
> > the code to use offsets instead of pointers, then apply the mask to the
> > *final* offset to avoid oob data access:
> 
> The mask applied to src_base is not to prevent overflow but to implement
> register limits.

Yea, that was just a quick sketch to outline the idea without checking
all details.

> This patch basically does
> that by changing parameters to unsigned to prevent them being negative,
> checking values we multiply by to prevent them to be zero and then
> calculating first and last offset and check if they are within vram.

Well.  With cirrus this proved to be fragile.  The checks missed corner
cases and we've got a series of CVEs in the blitter code.  Switching to
offsets + masking every vram access (see commit ffaf85777828) stopped
that.

> (Unless
> of course I've made a mistake somewhere.)

Exactly ...

> This should prevent overflow with
> one check and does not need to apply a mask at every step. The vram size can
> also be different so it's not a fixed mask anyway.
> 
> If not using pixman then I'd need to reimplement optimised 2D ops that will
> likely never be as good as pixman and no point in doing it several times for
> every device model so I'd rather try to use pixman where possible unless a
> better library is available.

Yes, performance-wise pixman is clearly the better choice.  At the end
of the day it is a security vs performance trade off.

> > > +            if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
> > > +                /* regions may overlap: copy via temporary */
> > 
> > The usual way for a hardware blitter is to have a direction bit, i.e.
> > the guest os can ask to blit in top->bottom or bottom->top scanline
> > ordering.  The guest can use that to make sure the blit does not
> 
> Yes, this is the rtl above (right to left) and AmigaOS sets this most of the
> time so only relying on that to detect overlaps is not efficient.

Hmm, checking rtl like that doesn't look correct to me then.  When using
the blitter to move a window you have to set/clear rtl depending on
whenever you move the window up or down on the screen, and src+dst
regions can overlap in both cases ...

> > overwrite things.  But note the guest can also intentionally use
> > overlapping regions, i.e. memset(0) the first scanline, then use a blit
> > with overlap to clear the whole screen.  The later will surely break if
> > you blit via temporary image ...
> 
> Fortunately no guest code seems to do that so unless we find one needing it
> I don't worry much about such rare cases.

Ok.

> > > +                pixman_blt((uint32_t *)&s->local_mem[src_base],
> > > +                           (uint32_t *)&s->local_mem[dst_base],
> > > +                           src_pitch * (1 << format) / sizeof(uint32_t),
> > > +                           dst_pitch * (1 << format) / sizeof(uint32_t),
> > > +                           8 * (1 << format), 8 * (1 << format),
> > > +                           src_x, src_y, dst_x, dst_y, width, height);
> > 
> > See above, i'm not convinced pixman is the best way here.
> > When using pixman I'd suggest:
> > 
> >  (1) src = pixman_image_create_bits_no_clear(...);
> >  (2) dst = pixman_image_create_bits_no_clear(...);
> >  (3) pixman_image_composite(PIXMAN_OP_SRC, src, NULL, dst, ...);
> >  (4) pixman_image_unref(src);
> >  (5) pixman_image_unref(dst);
> > 
> > pixman_blt() is probably doing basically the same.
> 
> Actually not the same, pixman_blt is faster operating directly on pointers
> while we need all the pixman_image overhead to use pixman_image_composite.

Ok (I didn't check the pixman code).

Given the use case (run a computer museum ;) I think we can live with
the flaws of the pixman approach.  Security shouldn't be that much of an
issue here.  The behavior and blitter use pattern of the guests is known
too and unlikely to change.

take care,
  Gerd


