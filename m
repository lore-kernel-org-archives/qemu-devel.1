Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE15C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045B0206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJoAtD9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045B0206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQs1-0004e4-3g
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTQqC-0000Pn-Gu
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTQns-0001F9-Lt
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:03:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33622
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jTQns-000175-79
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588082499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9XojcR2WzAFRWPQei00xciuaekP126HvcOc8XWGBKE=;
 b=DJoAtD9dpR7oV3QFV/COaK4tRBp1XyF6y6hp6FsuXNgqbYQjkbA0q2UmrKOc1yq740HKMt
 qffVeDPO3DGShHLW96dbVhfJjB3NNRe9Pmvdq/SCSl4e46Et11qVUFeJKnCAgThJ75CvTQ
 L4bY2cP4vWYjDHJIp80zUgCg4sbG+HQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-Vn0xGMd1NLaozspoBlxb9w-1; Tue, 28 Apr 2020 10:01:37 -0400
X-MC-Unique: Vn0xGMd1NLaozspoBlxb9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8190F80572D;
 Tue, 28 Apr 2020 14:01:35 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-37.ams2.redhat.com [10.36.114.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 640BE1C950;
 Tue, 28 Apr 2020 14:01:33 +0000 (UTC)
Date: Tue, 28 Apr 2020 16:01:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] block: Add bdrv_make_empty()
Message-ID: <20200428140132.GF5789@linux.fritz.box>
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-2-mreitz@redhat.com>
 <bd4bb486-559a-58ff-dafb-f1e63908be4e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bd4bb486-559a-58ff-dafb-f1e63908be4e@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.04.2020 um 15:53 hat Eric Blake geschrieben:
> On 4/28/20 8:26 AM, Max Reitz wrote:
> > Right now, all users of bdrv_make_empty() call the BlockDriver method
> > directly.  That is not only bad style, it is also wrong, unless the
> > caller has a BdrvChild with a WRITE permission.
> >=20
> > Introduce bdrv_make_empty() that verifies that it does.
> >=20
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> >   include/block/block.h |  1 +
> >   block.c               | 23 +++++++++++++++++++++++
> >   2 files changed, 24 insertions(+)
> >=20
> > diff --git a/include/block/block.h b/include/block/block.h
> > index b05995fe9c..d947fb4080 100644
> > --- a/include/block/block.h
> > +++ b/include/block/block.h
> > @@ -351,6 +351,7 @@ BlockMeasureInfo *bdrv_measure(BlockDriver *drv, Qe=
muOpts *opts,
> >   void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr=
);
> >   void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
> >   int bdrv_commit(BlockDriverState *bs);
> > +int bdrv_make_empty(BdrvChild *c, Error **errp);
>=20
> Can we please fix this to take a flags parameter?  I want to make it easi=
er
> for callers to request BDRV_REQ_NO_FALLBACK for distinguishing between
> callers where the image must be made empty (read as all zeroes) regardles=
s
> of time spent, vs. made empty quickly (including if it is already all zer=
o)
> but where the caller is prepared for the operation to fail and will write
> zeroes itself if fast bulk zeroing was not possible.

bdrv_make_empty() is not for making an image read as all zeroes, but to
make it fully unallocated so that the backing file becomes visible.

Are you confusing it with bdrv_make_zero(), which is just a wrapper
around bdrv_pwrite_zeroes() and does take flags?

Kevin


