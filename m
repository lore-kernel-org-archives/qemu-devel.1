Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD00C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E913E206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BO2tg+uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E913E206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hW5-0007s9-38
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7gyj-0003O0-8L
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:23:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7gyg-0004Rc-W9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597677794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmr0Se4UaipgvvwraZvdIMN7HLzH8ZPFwPQn/+QtySQ=;
 b=BO2tg+uKlYzOqRFLvJDX2FH78uByYsJ/QUed57s8REn6ORMfRzDnZVabsNVvQegmNRrjKk
 DdVcT7SJrawcVFZ21avRRwkM7mW/9VoNtsHDA2XbeWkyRX3u1Xtb4e5JpkXKqSUXbqMR/n
 VUDhEZgWnBeIT9rcyBUJYtarYZKUdy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-hwjY2-fcMViohD9NweeuDQ-1; Mon, 17 Aug 2020 11:23:02 -0400
X-MC-Unique: hwjY2-fcMViohD9NweeuDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7346E1DDED;
 Mon, 17 Aug 2020 15:23:01 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79E40100AE59;
 Mon, 17 Aug 2020 15:23:00 +0000 (UTC)
Date: Mon, 17 Aug 2020 17:22:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 14/22] block/export: Move AioContext from NBDExport
 to BlockExport
Message-ID: <20200817152259.GP11402@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-15-kwolf@redhat.com>
 <2851aef1-176c-1b81-4941-dc4b08b6bfec@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2851aef1-176c-1b81-4941-dc4b08b6bfec@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MP5ln1Rcf9Bvi+ZW"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.08.2020 um 16:56 hat Max Reitz geschrieben:
> On 13.08.20 18:29, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/export.h |  6 ++++++
> >  nbd/server.c           | 26 +++++++++++++-------------
> >  2 files changed, 19 insertions(+), 13 deletions(-)
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> > diff --git a/include/block/export.h b/include/block/export.h
> > index f44290a4a2..5459f79469 100644
> > --- a/include/block/export.h
> > +++ b/include/block/export.h
> > @@ -33,6 +33,12 @@ struct BlockExport {
> >       * the export.
> >       */
> >      int refcount;
> > +
> > +    /*
> > +     * The AioContex whose lock needs to be held while calling
>=20
> *AioContext
>=20
> > +     * BlockExportDriver callbacks.
>=20
> Hm.  But other blk_exp_* functions (i.e. the refcount manipulation
> functions) are fair game?

Hmm... The assumption was the ref/unref are only called from the main
thread, but maybe that's not true? So maybe blk_exp_*() shouldn't lock
the AioContext internally, but require that the lock is already held, so
that they can be called both from within the AioContext (where we don't
want to lock a second tim) and from the main context.

I also guess we need a separate mutex to protect the exports list if
unref can be called from different threads.

And probably the existing NBD server code has already the same problems
with respect to different AioContexts.

> > +     */
> > +    AioContext *ctx;
> >  };
> > =20
> >  extern const BlockExportDriver blk_exp_nbd;
> > diff --git a/nbd/server.c b/nbd/server.c
> > index 2bf30bb731..b735a68429 100644
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
>=20
> [...]
>=20
> > @@ -1466,7 +1464,7 @@ static void blk_aio_attached(AioContext *ctx, voi=
d *opaque)
> > =20
> >      trace_nbd_blk_aio_attached(exp->name, ctx);
> > =20
> > -    exp->ctx =3D ctx;
> > +    exp->common.ctx =3D ctx;
>=20
> (Not sure if I=CD=84=E2=80=99m missing anything to that regard), but perh=
aps after
> patch 21 we can move this part to the common block export code, and
> maybe make it call a BlockExportDriver callback (that handles the rest
> of this function).

Could probably be done. Not every export driver may support switching
AioContexts, but we can make it conditional on having the callback.

So do I understand right from your comments to the series in general
that you would prefer to make this series more complete, even if that
means that it becomes quite a bit longer?

Kevin

--MP5ln1Rcf9Bvi+ZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl86oNIACgkQfwmycsiP
L9bpyhAAllmLAtWzdwpb55Q5lmawdnF99AFT5b7mhYQXsXaAY1kBKP8bV67REIev
/cwmZNqLr0KGDoMHzrUA9uk4aMtIHvE2OmtsUSfXMdGXObw4ZvDoCyh6V/sJ3zsq
TOjdOnxNd7K2ilGtuSYmNBuFvrc778Kx4sohMT3Cv0JB3F0HiP7Ia+28II57ii7N
PBDmiDynPNMIjsqiqGPa4T6Nl4H5VtVu8e/BHPOeX59CjPsx6wWb7mpIuo1B19F+
yL0ZZCMpz5NAybIDiCHohinqcv99eeRflUqutcZRyKEmY/HcJlnIwMqjApJR345O
iCE9ENXzW2PXQBDSks0Qzee0bz/ny0dj7sv0g706SPv4ZKUbl/Mjb3x+jZBG3rDO
qgP0r8HPNDRZ21+LUgmLjnVYoDQFEfDjK0VW5FkVXCWDRAHwJ6f+9bgbv5qol72J
Fo07ZkhSWCe4tU1tAvjkwEFeirihu7zrdSUdqD0X7nEAfhVqLMna2zfYHMjxNiNp
ck1m8OdKoTjUsKXY2xXZ/mED+chkfvjt4G+PQ/HtSnLUMcLkc67DkbVf1/XC5B3q
PmQccRi6TJCY4qrd7FeKEGi4CyY9gmSdvxICgj3nDTF3Yn8+RlwQIuOuLoJR94XU
s1s5Jzt3U6bFK8qRX7G/4KOt7pMERxJYR9wFvbRWsrFpP29HtDQ=
=91gw
-----END PGP SIGNATURE-----

--MP5ln1Rcf9Bvi+ZW--


