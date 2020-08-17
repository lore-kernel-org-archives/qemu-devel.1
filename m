Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7813C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830CC20825
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bil0Qtbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830CC20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ebF-0006zE-R3
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 08:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7eaO-00062z-1b
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:50:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52339
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7eaM-00019w-Da
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597668596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tgpbTXMCtMz0hKncr7yXSkAO0qiKqNnjnsQBhIOjc+c=;
 b=Bil0QtbnXZ3NxYMbpeH1WjHOUX2ZE9utgLA6qxj8BtvJNRhj1m/5PiAUlm8Ki8wuoGclES
 7M2uXvfBNiPkun8QhmhQcoJ5QNaJeN6skiq6K6+5n8pz893BPWsJjofxFMnUnj4tYM15UZ
 vZlgq3+7fD1UBVy9s18y7DbCuGcTHBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-io5oDuYMOKi-sfVKs0xVbw-1; Mon, 17 Aug 2020 08:49:54 -0400
X-MC-Unique: io5oDuYMOKi-sfVKs0xVbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 721A0800463;
 Mon, 17 Aug 2020 12:49:53 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78B945C5FD;
 Mon, 17 Aug 2020 12:49:52 +0000 (UTC)
Date: Mon, 17 Aug 2020 14:49:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 07/22] block/export: Remove magic from block-export-add
Message-ID: <20200817124951.GJ11402@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-8-kwolf@redhat.com>
 <2a6528d8-1792-ec1e-287b-a9b9e2f20eef@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2a6528d8-1792-ec1e-287b-a9b9e2f20eef@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.08.2020 um 13:41 hat Max Reitz geschrieben:
> On 13.08.20 18:29, Kevin Wolf wrote:
> > nbd-server-add tries to be convenient and adds two questionable
> > features that we don't want to share in block-export-add, even for NBD
> > exports:
> >=20
> > 1. When requesting a writable export of a read-only device, the export
> >    is silently downgraded to read-only. This should be an error in the
> >    context of block-export-add.
> >=20
> > 2. When using a BlockBackend name, unplugging the device from the guest
> >    will automatically stop the NBD server, too. This may sometimes be
> >    what you want, but it could also be very surprising. Let's keep
> >    things explicit with block-export-add. If the user wants to stop the
> >    export, they should tell us so.
> >=20
> > Move these things into the nbd-server-add QMP command handler so that
> > they apply only there.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/nbd.h   |  3 ++-
> >  block/export/export.c | 44 ++++++++++++++++++++++++++++++++++++++-----
> >  blockdev-nbd.c        | 10 ++++------
> >  nbd/server.c          | 19 ++++++++++++-------
> >  qemu-nbd.c            |  3 +--
> >  5 files changed, 58 insertions(+), 21 deletions(-)
>=20
> [...]
>=20
> > diff --git a/block/export/export.c b/block/export/export.c
> > index 3d0dacb3f2..2d5f92861c 100644
> > --- a/block/export/export.c
> > +++ b/block/export/export.c
>=20
> [...]
>=20
> > @@ -34,24 +36,56 @@ static const BlockExportDriver *blk_exp_find_driver=
(BlockExportType type)
> >      return NULL;
> >  }
> > =20
> > -void qmp_block_export_add(BlockExportOptions *export, Error **errp)
> > +static BlockExport *blk_exp_add(BlockExportOptions *export, Error **er=
rp)
> >  {
> >      const BlockExportDriver *drv;
> > =20
> >      drv =3D blk_exp_find_driver(export->type);
> >      if (!drv) {
> >          error_setg(errp, "No driver found for the requested export typ=
e");
> > -        return;
> > +        return NULL;
> >      }
> > =20
> > -    drv->create(export, errp);
> > +    return drv->create(export, errp);
> > +}
> > +
> > +void qmp_block_export_add(BlockExportOptions *export, Error **errp)
> > +{
> > +    blk_exp_add(export, errp);
> >  }
>=20
> Interesting.  I would have added it this way from the start then (with a
> note that we=E2=80=99ll need it later).
>=20
> >  void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
> >  {
> > -    BlockExportOptions export =3D {
> > +    BlockExport *export;
> > +    BlockDriverState *bs;
> > +    BlockBackend *on_eject_blk;
> > +
> > +    BlockExportOptions export_opts =3D {
> >          .type =3D BLOCK_EXPORT_TYPE_NBD,
> >          .u.nbd =3D *arg,
>=20
> This copies *arg=E2=80=99s contents...
>=20
> >      };
> > -    qmp_block_export_add(&export, errp);
> > +
> > +    /*
> > +     * nbd-server-add doesn't complain when a read-only device should =
be
> > +     * exported as writable, but simply downgrades it. This is an erro=
r with
> > +     * block-export-add.
> > +     */
> > +    bs =3D bdrv_lookup_bs(arg->device, arg->device, NULL);
> > +    if (bs && bdrv_is_read_only(bs)) {
> > +        arg->writable =3D false;
>=20
> ...and here you only modify the original *arg, but not
> export_opts.u.nbd.  So I don=E2=80=99t think this will have any effect.

I thought I had tested this... Well, good catch, thanks.

> > +    }
> > +
> > +    export =3D blk_exp_add(&export_opts, errp);
> > +    if (!export) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * nbd-server-add removes the export when the named BlockBackend u=
sed for
> > +     * @device goes away.
> > +     */
> > +    on_eject_blk =3D blk_by_name(arg->device);
> > +    if (on_eject_blk) {
> > +        nbd_export_set_on_eject_blk(export, on_eject_blk);
> > +    }
> >  }
>=20
> The longer it gets, the more I think maybe it should be in some NBD file
> like blockdev-nbd.c after all.

Fair enough. Though I think blockdev-nbd.c in the root directory is
something that shouldn't even exist.

But I guess I can just leave the functions where they are and we can
move the file another day.

> [...]
>=20
> > diff --git a/nbd/server.c b/nbd/server.c
> > index 92360d1f08..0b84fd30e2 100644
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
> > @@ -1506,11 +1506,22 @@ static void nbd_eject_notifier(Notifier *n, voi=
d *data)
> >      aio_context_release(aio_context);
> >  }
> > =20
> > +void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk)
> > +{
> > +    NBDExport *nbd_exp =3D container_of(exp, NBDExport, common);
> > +    assert(exp->drv =3D=3D &blk_exp_nbd);
> > +
>=20
> I think asserting that the nbd_exp->eject_notifier is unused so far
> would make sense (e.g. just checking that eject_notifier_blk is NULL).

Makes sense.

Kevin

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl86fO4ACgkQfwmycsiP
L9ZzgRAAs8PH71I1ta5+Uvtnp4XBGHwDnotDfATGIhPOFBLQcFVfZs96wHh3oFaH
ah4/KSzeqMj4pbwMxG/brcULsJTJp5DIHvYYcKYMlSUj4WovaQB2c84Sv5PZIJ5I
xnUMTcQ9UabgSa8gGfnIIXzLPj8Byfa25jdJQdvGsgRBciXGWf++Muz1B1HMqRk5
aJKXDc1SsWouRIvX3Aa2V0v9bbbq58Qbryezj4tOZdWENjYT/QsECXHBF4TGiMRv
H0EFkln4TH1ulagXb4mhU+tIf1na336tJUpQ7MBbfFwVNt1vjpOJkFBawgqkWDFp
tqZQTpeh3DTCNGQGSCGox0QqflH66QpP/LEKpAuh1ilC9qFsbPJruEvJ1lpKYvm/
DH08M/UzrLIPzgEKVieyezY9wYGQKjQRVts6L9lO12M2fxnmJgXB9ZUCL0SDAMok
HG/4pHdioNVTt4BhTGQu5ZMPrALVNwOwl9iAfFvFbyT7SORnxpuTIs2QIa5/wM6O
blU1z/9agdRwNKz8l1fmfW0aa7oP9ZWfG4h60TMadPA9/0mRt3CWB1pmsPoiEfSe
cajyasfqgB038JAc3cYs93jnZdoIPnnrA6u+nw3tA1SMndJLtnQRKEhaMHz8DRyx
lP/wWh98pIeomaFK/FB749Yj7uQvsUlkcNzjFVd7HMg6gZsUlzc=
=NXF5
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--


