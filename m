Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61540C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 11:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0002075C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 11:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KODw0LSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0002075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZCDl-00014p-8H
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 06:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iZCCj-0000dW-7y
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 06:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iZCCf-00085t-TV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 06:06:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iZCCf-00085F-KC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 06:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574680008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vUcO2L2hKif3/d/aWvnj5KylosX0CML9UDy15L44Mvs=;
 b=KODw0LSt1zlmi0XY3uf7WATLoEOEAqU6jzuDvgDabV89sQaF/VxIrsNTOorgdvt9nSN7g5
 Sx/c9+nOYEfLUEKyJRHNKyEaG59VOZy1uSrMKH1x0VV3EZwpZNFw8Z/ThA4EcJ9pzfg7un
 XHfhmkEkR0NdzJ7phPshjZ9MWW8k3yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-j-55jt_rPlelxwUi_aS8Gg-1; Mon, 25 Nov 2019 06:06:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A113C800592;
 Mon, 25 Nov 2019 11:06:45 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 079AB60870;
 Mon, 25 Nov 2019 11:06:40 +0000 (UTC)
Date: Mon, 25 Nov 2019 12:06:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 2/6] block: truncate: Don't make backing file data visible
Message-ID: <20191125110639.GB4638@linux.fritz.box>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-3-kwolf@redhat.com>
 <57c28fd7-4949-3da3-37c5-e2db0914ccae@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <57c28fd7-4949-3da3-37c5-e2db0914ccae@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: j-55jt_rPlelxwUi_aS8Gg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.11.2019 um 19:01 hat Vladimir Sementsov-Ogievskiy geschrieben:
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
> > +            if (ret < 0) {
> > +                goto out;
> > +            }
> > +        }
> > +    }
> > +
> >       ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
> >       if (ret < 0) {
> >           error_setg_errno(errp, -ret, "Could not refresh total sector =
count");
>=20
> Hmmmm. I'm think that for commit, we also should zero truncated area
> if !bdrv_has_zero_init_truncate(bs). But we should not do it here, as
> it should not be done if we just resizing disk..

Hm, yes, we need to do this for METADATA and FALLOC preallocation at
least. I think we already guarantee zeros for FULL, do we?

Resize needs zero init in the opposite case: When you are resizing a
short backing file, the longer overlay still needs to read the same
zeros it read before after EOF of the backing file. This one sounds
actually even nastier to fix than what this series does. :-/

Anyway, maybe instead of the no_fallback parameter I introduced in v3,
what we really want is a need_zero_init parameter that only commit jobs
set for now? Or actually add a new preallocation mode like you suggested
that would add a zero write and pass OFF to the driver implementations.
Then we wouldn't have to add a new parameter everywhere.

We'd still unconditionally write zeros where it's necessary to allocate
blocks to cover the backing file (and to provide correct data to the
overlay if we ever figure out how to check this condition). I think I've
come to the conclusion that blocking on block_resize is better than
failing.

> What formats are that bad?

You mean that they don't have zero init? The usual suspect for bad image
formats is raw, but fortunately that doesn't support backing files. So
maybe it's not a problem we would see in practice.

Kevin


