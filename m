Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CF2C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBA920767
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvlWGLvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBA920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxHz-0002fJ-6k
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRxGj-0001Im-Cp
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRxGi-0003Zw-4s
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:17:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30207
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRxGh-0003L5-Mh
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587730638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=go82LpnOoOuw7l7TNaGFuD3zvMzMosyWE7VGpHwF5+4=;
 b=MvlWGLvZ1v2ZA+TfbQ8zIR1sxRELAkgzs5qdk+7JpEtoUuPXHcMcqlh6+VrKy6T+c5qnCD
 KChGOovlsVwwTz8gi/N69diR2hTwQvZjRUJDCpaHNB56k36WjkCnmQMCQNoqMYqRqxeva4
 /mGWFp6SOgoq5GSzWaKc2EFpvLfCmJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371--pmpIzW_PVCYIEdoOVxpHA-1; Fri, 24 Apr 2020 08:17:17 -0400
X-MC-Unique: -pmpIzW_PVCYIEdoOVxpHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4EE11895A29;
 Fri, 24 Apr 2020 12:17:15 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-114.ams2.redhat.com [10.36.114.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 647325C1D0;
 Fri, 24 Apr 2020 12:17:14 +0000 (UTC)
Date: Fri, 24 Apr 2020 14:17:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6 04/10] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
Message-ID: <20200424121712.GA4921@linux.fritz.box>
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-5-kwolf@redhat.com>
 <436f15ce-da79-7016-6478-c5ab8642ee25@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <436f15ce-da79-7016-6478-c5ab8642ee25@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.04.2020 um 08:16 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 23.04.2020 18:01, Kevin Wolf wrote:
> > If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
> > qcow2_cluster_zeroize() with flags=3D0 does the right thing: It doesn't
> > undo any previous preallocation, but just adds the zero flag to all
> > relevant L2 entries. If an external data file is in use, a write_zeroes
> > request to the data file is made instead.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > ---
> >   block/qcow2-cluster.c |  2 +-
> >   block/qcow2.c         | 33 +++++++++++++++++++++++++++++++++
> >   2 files changed, 34 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> > index 17f1363279..4b5fc8c4a7 100644
> > --- a/block/qcow2-cluster.c
> > +++ b/block/qcow2-cluster.c
> > @@ -1795,7 +1795,7 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, u=
int64_t offset,
> >       /* Caller must pass aligned values, except at image end */
> >       assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
> >       assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
> > -           end_offset =3D=3D bs->total_sectors << BDRV_SECTOR_BITS);
> > +           end_offset >=3D bs->total_sectors << BDRV_SECTOR_BITS);
> >       /* The zero flag is only supported by version 3 and newer */
> >       if (s->qcow_version < 3) {
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 9cfbdfc939..ad621fe404 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -1726,6 +1726,7 @@ static int coroutine_fn qcow2_do_open(BlockDriver=
State *bs, QDict *options,
> >       bs->supported_zero_flags =3D header.version >=3D 3 ?
> >                                  BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLB=
ACK : 0;
> > +    bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
> >       /* Repair image if dirty */
> >       if (!(flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) && !bs->read_only=
 &&
> > @@ -4214,6 +4215,38 @@ static int coroutine_fn qcow2_co_truncate(BlockD=
riverState *bs, int64_t offset,
> >           g_assert_not_reached();
> >       }
> > +    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
> > +        uint64_t zero_start =3D QEMU_ALIGN_UP(old_length, s->cluster_s=
ize);
> > +
> > +        /*
> > +         * Use zero clusters as much as we can. qcow2_cluster_zeroize(=
)
> > +         * requires a cluster-aligned start. The end may be unaligned =
if it is
> > +         * at the end of the image (which it is here).
> > +         */
> > +        ret =3D qcow2_cluster_zeroize(bs, zero_start, offset - zero_st=
art, 0);
> > +        if (ret < 0) {
> > +            error_setg_errno(errp, -ret, "Failed to zero out new clust=
ers");
> > +            goto fail;
> > +        }
> > +
> > +        /* Write explicit zeros for the unaligned head */
> > +        if (zero_start > old_length) {
> > +            uint8_t *buf =3D qemu_blockalign0(bs, s->cluster_size);
>=20
> Why not s/s->cluster_size/zero_start - old_length/? We may save a lot
> of pages if cluster_size is large.

Ok.

> > +            QEMUIOVector qiov;
> > +            qemu_iovec_init_buf(&qiov, buf, zero_start - old_length);
> > +
> > +            qemu_co_mutex_unlock(&s->lock);
>=20
> We are in intermediate state here. Is it safe to unlock? Anything may
> happen, up to another truncate..

I don't think it's worse than unlocking during normal writes, which we
have been doing for a long time. I don't see anything that would corrupt
any internal state.

Of course, doing truncate in parallel with other operations around EOF
has somewhat undefined semantics because the order could be anything.
But if you don't want to get undefined results, you just shouldn't make
such requests. It's similar to reading and writing the same area at the
same time.

> > +            ret =3D qcow2_co_pwritev_part(bs, old_length, qiov.size, &=
qiov, 0, 0);
>=20
> Better not do it if this cluster is already ZERO.. But it may be a
> later patch to improve that.

I doubt it's worth writing code to optimise a corner case inside a
corner case.

> > +            qemu_co_mutex_lock(&s->lock);
> > +
> > +            qemu_vfree(buf);
> > +            if (ret < 0) {
> > +                error_setg_errno(errp, -ret, "Failed to zero out the n=
ew area");
> > +                goto fail;
> > +            }
> > +        }
> > +    }
> > +
> >       if (prealloc !=3D PREALLOC_MODE_OFF) {
> >           /* Flush metadata before actually changing the image size */
> >           ret =3D qcow2_write_caches(bs);

Kevin


