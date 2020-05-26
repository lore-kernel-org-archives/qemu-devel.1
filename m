Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A20BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB2C2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/f69nGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB2C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdX4D-0004KW-2y
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdX3R-0003aw-Ej
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:43:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50751
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdX3P-0001E6-Rj
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590489806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gt6ck0J0yEML7ZbgUZ3X+4VmrS0fz/8h77uIdf6Pcr8=;
 b=U/f69nGBQz6+BGcTKaLZ5i4QOGwPolcDB7kVMA1SsksoalwomuKxMcYVomdP6QdB+nQY/y
 xNS9wN64kTWgoKz82Mn1MZX+JxXwi+tEoBmt6JhLJE6Ji6RRJDXKsWatD5X16sutunV6DY
 6i+IeCnpnQ1I6qOrKPvnEXrsmWWUM0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-L0zLwgAGMMOAc7WhhwfYiA-1; Tue, 26 May 2020 06:43:22 -0400
X-MC-Unique: L0zLwgAGMMOAc7WhhwfYiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E784B800053;
 Tue, 26 May 2020 10:43:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2739C648DB;
 Tue, 26 May 2020 10:43:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E3C3D17444; Tue, 26 May 2020 12:43:18 +0200 (CEST)
Date: Tue, 26 May 2020 12:43:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v2 5/7] sm501: Replace hand written implementation with
 pixman where possible
Message-ID: <20200526104318.wmsqqtia3h52l454@sirius.home.kraxel.org>
References: <cover.1590089984.git.balaton@eik.bme.hu>
 <58666389b6cae256e4e972a32c05cf8aa51bffc0.1590089984.git.balaton@eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <58666389b6cae256e4e972a32c05cf8aa51bffc0.1590089984.git.balaton@eik.bme.hu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
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

On Thu, May 21, 2020 at 09:39:44PM +0200, BALATON Zoltan wrote:
> Besides being faster this should also prevent malicious guests to
> abuse 2D engine to overwrite data or cause a crash.

>          uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
> -        uint8_t *src = s->local_mem + src_base;

> -                    val = *(_pixel_type *)&src[index_s];                      \

Well, the advantage of *not* using pixman is that you can easily switch
the code to use offsets instead of pointers, then apply the mask to the
*final* offset to avoid oob data access:

    val = *(_pixel_type*)(&s->local_mem[(s->twoD_source_base + index_s) & 0x03FFFFFF]);

> +        if ((rop_mode && rop == 0x5) || (!rop_mode && rop == 0x55)) {
> +            /* Invert dest, is there a way to do this with pixman? */

PIXMAN_OP_XOR maybe?

> +            if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
> +                /* regions may overlap: copy via temporary */

The usual way for a hardware blitter is to have a direction bit, i.e.
the guest os can ask to blit in top->bottom or bottom->top scanline
ordering.  The guest can use that to make sure the blit does not
overwrite things.  But note the guest can also intentionally use
overlapping regions, i.e. memset(0) the first scanline, then use a blit
with overlap to clear the whole screen.  The later will surely break if
you blit via temporary image ...

> +                pixman_blt((uint32_t *)&s->local_mem[src_base],
> +                           (uint32_t *)&s->local_mem[dst_base],
> +                           src_pitch * (1 << format) / sizeof(uint32_t),
> +                           dst_pitch * (1 << format) / sizeof(uint32_t),
> +                           8 * (1 << format), 8 * (1 << format),
> +                           src_x, src_y, dst_x, dst_y, width, height);

See above, i'm not convinced pixman is the best way here.
When using pixman I'd suggest:

  (1) src = pixman_image_create_bits_no_clear(...);
  (2) dst = pixman_image_create_bits_no_clear(...);
  (3) pixman_image_composite(PIXMAN_OP_SRC, src, NULL, dst, ...);
  (4) pixman_image_unref(src);
  (5) pixman_image_unref(dst);

pixman_blt() is probably doing basically the same.  The advantage of not
using pixman_blt() is that

  (a) you can also use pixman ops other than PIXMAN_OP_SRC, and
  (b) you can have a helper function for (1)+(2) which very carefully
      applies sanity checks to make sure the pixman image created stays
      completely inside s->local_mem.
  (c) you have the option to completely rearrange the code flow, for
      example update the src pixman image whenever the guest touches
      src_base or src_pitch or format instead of having a
      create/op/unref cycle on every blitter op.

> +        pixman_fill((uint32_t *)&s->local_mem[dst_base],
> +                    dst_pitch * (1 << format) / sizeof(uint32_t),
> +                    8 * (1 << format), dst_x, dst_y, width, height, color);

  (1) src = pixman_image_create_solid(...), otherwise same as above ;)

take care,
  Gerd


