Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB57C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2681B21845
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sh/EKgqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2681B21845
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRfh-0000lF-AN
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXRf1-0000DJ-Cc
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXRf0-0001pG-2r
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:12:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXRez-0001oo-VZ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574262769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Juwgx5jb11YO3gwMyiPbq3gLPpGtAEAuCmIn6eUx7k=;
 b=Sh/EKgqbCRUCtayOB+x7RY8WNdHCpUQrwtvNcjN1vpe6nEcU5w+rx7ggcXNPrWPofoFNza
 87QxIzJnq8QC55nRS6dUg1A1XxMHaE/5FM6Yu+Iej6ctLjfGItDdB8jbPwmTjR1t0/Wfeu
 ng89lVQUsvaVYQtGds/+dCvbKvI/dHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-kfdm0NizPW-FAD7n757ORA-1; Wed, 20 Nov 2019 10:12:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48B7E1005502;
 Wed, 20 Nov 2019 15:12:41 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 944672AA8A;
 Wed, 20 Nov 2019 15:12:36 +0000 (UTC)
Date: Wed, 20 Nov 2019 16:12:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 2/6] block: truncate: Don't make backing file data visible
Message-ID: <20191120151235.GD5779@linux.fritz.box>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-3-kwolf@redhat.com>
 <5f37eeef-2a2c-dcdc-0e2c-b1d49bc9a3d7@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <5f37eeef-2a2c-dcdc-0e2c-b1d49bc9a3d7@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: kfdm0NizPW-FAD7n757ORA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.11.2019 um 15:47 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 20.11.2019 17:03, Kevin Wolf wrote:
> > When extending the size of an image that has a backing file larger than
> > its old size, make sure that the backing file data doesn't become
> > visible in the guest, but the added area is properly zeroed out.
> >=20
> > The old behaviour made a difference in 'block_resize' (where showing th=
e
> > backing file data from an old snapshot rather than zeros is
> > questionable) as well as in commit block jobs (both from active and
> > intermediate nodes) and HMP 'commit', where committing to a short
> > backing file would incorrectly omit writing zeroes for unallocated
> > blocks on the top layer after the EOF of the short backing file.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/io.c | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >=20
> > diff --git a/block/io.c b/block/io.c
> > index 003f4ea38c..8683f7a4bd 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -3382,6 +3382,31 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *chi=
ld, int64_t offset, bool exact,
> >           goto out;
> >       }
> >  =20
> > +    /*
> > +     * If the image has a backing file that is large enough that it wo=
uld
> > +     * provide data for the new area, we cannot leave it unallocated b=
ecause
> > +     * then the backing file content would become visible. Instead, ze=
ro-fill
> > +     * the area where backing file and new area overlap.
> > +     */
>=20
> Should we mention that, still, we don't care if user for some reason will=
 change
> backing file in future?

This should be obvious, but I can add something.

> > +    if (new_bytes && bs->backing && prealloc =3D=3D PREALLOC_MODE_OFF)=
 {
> > +        int64_t backing_len;
> > +
> > +        backing_len =3D bdrv_getlength(backing_bs(bs));
> > +        if (backing_len < 0) {
> > +            ret =3D backing_len;
> > +            goto out;
> > +        }
> > +
> > +        if (backing_len > old_size) {
> > +            ret =3D bdrv_co_do_pwrite_zeroes(bs, old_size,
> > +                                           MIN(new_bytes, backing_len =
- old_size),
> > +                                           BDRV_REQ_ZERO_WRITE | BDRV_=
REQ_MAY_UNMAP);
>=20
> two over-80 lines

Will fix.

> > +            if (ret < 0) {
> > +                goto out;
> > +            }
> > +        }
> > +    }
>=20
> should we improve "off" mode specification in qapi?

I don't think we're changing the semantics of "off". We're merely fixing
a bug that happens not to exist with preallocation.

> > +
> >       ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
> >       if (ret < 0) {
> >           error_setg_errno(errp, -ret, "Could not refresh total sector =
count");
> >=20
>=20
> Hmm. is it correct to call write_zeroes before refresh_total_sectors?
> Note that qcow2_co_pwrite_zeroes rely on bs->total_sectors...

Hm... I placed the code where I did because I didn't want to make the
new area valid before it isn't zeroed. But you're probably right that
we shouldn't run requests with inconsistent bs->total_sectors, so I'll
switch the order.

Kevin


