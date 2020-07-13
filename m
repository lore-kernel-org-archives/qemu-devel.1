Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F404C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CDE2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCIEeGK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CDE2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwdH-0007WU-JU
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1juwcI-0006c1-1B
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:27:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45355
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1juwcF-0000Y3-JR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594639642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cZITXWrl5jpH3CtdAB4/85yeRRg98FkpSpdUkmueBDY=;
 b=FCIEeGK/TMGqmz0fuLE62MlX7/CrYlUUo1TW25rHdZVr6aIhn9Ml7En3cryRuUgYgUGxOZ
 urfHHmduxQA90cMFI62YDISirrYMJyD3vt6hijD0H74x2ptKRg5gbDDWPxyQRyPNwCF0tz
 K+p8OkUZ8X7T2fbAU1XCV6wGEoaE+i8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-IrXl-ZiQNgatb4Z5VglVtg-1; Mon, 13 Jul 2020 07:27:18 -0400
X-MC-Unique: IrXl-ZiQNgatb4Z5VglVtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78AD1100CCC1;
 Mon, 13 Jul 2020 11:27:17 +0000 (UTC)
Received: from localhost (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC6EB1001B0B;
 Mon, 13 Jul 2020 11:27:16 +0000 (UTC)
Date: Mon, 13 Jul 2020 12:27:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 3/5] block: introduce preallocate filter
Message-ID: <20200713112715.GJ28639@stefanha-x1.localdomain>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
 <20200620143649.225852-4-vsementsov@virtuozzo.com>
 <20200708120726.GC459887@stefanha-x1.localdomain>
 <9a351987-6532-65d8-d144-defd04b5bba4@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <9a351987-6532-65d8-d144-defd04b5bba4@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SLfjTIIQuAzj8yil"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 07:17:52PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 08.07.2020 15:07, Stefan Hajnoczi wrote:
> > On Sat, Jun 20, 2020 at 05:36:47PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
> > > It may be used for file-systems with slow allocation.
> > >=20
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
> > > ---
> > >   qapi/block-core.json |   3 +-
> > >   block/preallocate.c  | 255 ++++++++++++++++++++++++++++++++++++++++=
+++
> > >   block/Makefile.objs  |   1 +
> > >   3 files changed, 258 insertions(+), 1 deletion(-)
> > >   create mode 100644 block/preallocate.c
> >=20
> > Please add documentation to docs/system/qemu-block-drivers.rst.inc
> > describing the purpose of this block driver and how to use it.
>=20
> This implies adding new section "Filters", yes?

Yes, please.

> >=20
> > Since this filter grows the file I guess it's intended to be below an
> > image format?
>=20
> Yes, between format and protocol nodes.

Thanks for confirming. Please include this in the documentation. While
reading the code I was thinking about how this can work if the guest is
directly exposed to the filter. Users might wonder about the same thing.

> > > +    /* Length should not have changed */
> > > +    assert(len =3D=3D bdrv_getlength(bs->file->bs));
> > > +
> > > +    start =3D write_zero ? MIN(offset, len) : len;
> > > +    end =3D QEMU_ALIGN_UP(offset + bytes + s->prealloc_size, s->prea=
lloc_align);
> > > +
> > > +    ret =3D bdrv_co_pwrite_zeroes_locked(bs->file, start, end - star=
t,
> > > +                                       BDRV_REQ_NO_FALLBACK, lock);
> > > +
> > > +    bdrv_co_range_unlock(lock);
> >=20
> > Hmm...if this piece of code is the only user of bdrv_co_range_try_lock(=
)
> > then a BDRV_REQ_NO_WAIT flag might be a simpler API.
> >=20
> > I thought the lock request would be used to perform multiple operations=
,
> > but if it's just for a single operation then I think it's less code and
> > easier to understand without the lock request.
>=20
> Hmm, again, I don't remember exact reasons. Firstly, I was afraid of leng=
th
> change during try_lock and have a double check for bdrv_getlength(). Then
> I decided that it's impossible and change the check to an assertion.
> Probably, the only reason to leave locked range was "I already have the c=
ode,
> it will help with copy-on-read, why not to use it".. OK, I'll try rewrite=
 it
> with help of new flag.

Thanks!

Stefan

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8MRRMACgkQnKSrs4Gr
c8iXpwgAkBxPft2TThw0BGX4YYFlgU2e2kIJZSFMUM8BZsIDTosjthq19vNBwXsx
BzxyYwRQBDIpEiin60clkSr70iKLVQrNetY0hX0LmhhGgotsv65Vw6f+L4bvzoxc
0QP0MctBTA2W+H1XB9Qk4jtmasd/MBtceactvlMPF/tMP7e7yM5GeVlPaI1K5GCf
DQVU0PP8L+7pNo/Ts65vSqA2JRzQ6xnp0zYqM/xoGE3gYoKv9PYRog8inVwsFXsJ
RFlzzIEMRpYITL/mSH2zcNUvSxzFmAmksGiVF+BlIvtH9g3wybpV99Icn6hqPYJs
3lPyHqT0mBtUTp9NYHHaiWFTg2NYTg==
=TTAl
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--


