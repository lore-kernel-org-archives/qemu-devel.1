Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008BCC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF0E2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlpB28nF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF0E2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hPq-0001aI-Nn
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7gdc-0001RE-Fy
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7gda-0000sH-Cz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597676485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LjOuXSAskq9pjifl295fJdMk9wAR+MVeB3QfDm5pT2E=;
 b=UlpB28nFOunsz671yB0CoB0yrfomuKtWl/HEat0Ng0BGC8DC3nArA9gFgXzMB3zdrpEIQJ
 FCwb/ytlKMz9pCtGdNhppYP00/bR1cz/q972etaUuYkqg+naDJSQnV9JF9CNu9Yh+Lo5tM
 SCiAnmOc+2GezlfujLa8wON8ETiZci8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-t8JRBUjPMge0MsRyK5dO4g-1; Mon, 17 Aug 2020 11:01:20 -0400
X-MC-Unique: t8JRBUjPMge0MsRyK5dO4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0DDE807354;
 Mon, 17 Aug 2020 15:01:19 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B5737DFC0;
 Mon, 17 Aug 2020 15:01:18 +0000 (UTC)
Date: Mon, 17 Aug 2020 17:01:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 11/22] qemu-nbd: Use blk_exp_add() to create the export
Message-ID: <20200817150117.GO11402@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-12-kwolf@redhat.com>
 <d9d9ce92-291b-7e25-bc32-c0d899e73842@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d9d9ce92-291b-7e25-bc32-c0d899e73842@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.08.2020 um 16:27 hat Max Reitz geschrieben:
> On 13.08.20 18:29, Kevin Wolf wrote:
> > With this change, NBD exports are only created through the BlockExport
> > interface any more. This allows us finally to move things from the NBD
> > layer to the BlockExport layer if they make sense for other export
> > types, too.
>=20
> I see.
>=20
> > blk_exp_add() returns only a weak reference, so the explicit
> > nbd_export_put() goes away.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/export.h |  2 ++
> >  include/block/nbd.h    |  1 +
> >  block/export/export.c  |  2 +-
> >  blockdev-nbd.c         |  8 +++++++-
> >  qemu-nbd.c             | 28 ++++++++++++++++++++++------
> >  5 files changed, 33 insertions(+), 8 deletions(-)
>=20
> [...]
>=20
> > diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> > index d5b084acc2..8dd127af52 100644
> > --- a/blockdev-nbd.c
> > +++ b/blockdev-nbd.c
>=20
> [...]
>=20
> > @@ -176,7 +182,7 @@ BlockExport *nbd_export_create(BlockExportOptions *=
exp_args, Error **errp)
> > =20
> >      assert(exp_args->type =3D=3D BLOCK_EXPORT_TYPE_NBD);
> > =20
> > -    if (!nbd_server) {
> > +    if (!nbd_server && !is_qemu_nbd) {
>=20
> (This begs the question of how difficult it would be to let qemu-nbd use
> QMP=E2=80=99s nbd-server-start, but I will not ask it, for I fear the ans=
wer.)

(It would probably include something along the lines of "patches
welcome". (I initially wanted to do this, but came to the conclusion
that it wasn't for this series when I noticed the socket activation
code and discussed with danpb on IRC how to integrate it in
SocketAddress.))

> >          error_setg(errp, "NBD server not running");
> >          return NULL;
> >      }
> > diff --git a/qemu-nbd.c b/qemu-nbd.c
> > index 48aa8a9d46..d967b8fcb9 100644
> > --- a/qemu-nbd.c
> > +++ b/qemu-nbd.c
>=20
> [...]
>=20
> > @@ -1050,9 +1050,27 @@ int main(int argc, char **argv)
> > =20
> >      bs->detect_zeroes =3D detect_zeroes;
> > =20
> > -    export =3D nbd_export_new(bs, export_name,
> > -                            export_description, bitmap, readonly, shar=
ed > 1,
> > -                            writethrough, &error_fatal);
> > +    nbd_server_is_qemu_nbd(true);
> > +
> > +    export_opts =3D g_new(BlockExportOptions, 1);
> > +    *export_opts =3D (BlockExportOptions) {
> > +        .type               =3D BLOCK_EXPORT_TYPE_NBD,
> > +        .has_writethrough   =3D true,
> > +        .writethrough       =3D writethrough,
> > +        .u.nbd =3D {
> > +            .device             =3D g_strdup(bdrv_get_node_name(bs)),
> > +            .has_name           =3D true,
> > +            .name               =3D g_strdup(export_name),
> > +            .has_description    =3D !!export_description,
> > +            .description        =3D g_strdup(export_description),
> > +            .has_writable       =3D true,
> > +            .writable           =3D !readonly,
> > +            .has_bitmap         =3D !!bitmap,
> > +            .bitmap             =3D g_strdup(bitmap),
> > +        },
> > +    };
> > +    blk_exp_add(export_opts, &error_fatal);
>=20
> Why not use the already-global qmp_block_export_add(), if we don=E2=80=99=
t need
> the return value here?  (Will we require it at some point?)

I can do that. I needed the return value originally, but after some
reshuffling of the series it magically disappeared.

Kevin

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl86m70ACgkQfwmycsiP
L9YxLBAAvZ7QZS1UuClNIIxFQHuOr7edVUpClwo5aYJ6/RF+/6u2n79IPapKfKMn
TymAMOXBED9raHF3lfdGyOkL0gvV/PsxqotZwui5X+1OolK2MUe7if7TjvgIREe+
bLc+n+EKC2LzBZa751rPwIlvtpNT53apBgSVjQK82AuhN8K+kfgIYrqZ8WnCPOLJ
Hfh1Hv5xLat9LQW35e9xnPvbAd2rAkzaWT05qvGg/+agXJVFGqfB+30xEUoEOIF7
TyR58pik187V9lnC6sTqJx+Cq+6lKJhPhMnL3DfT054SrE4n2/9lymZiw5CDEZrW
Q4lmn6uMoe/KbsDLL1UoQF0aL6MvDdcLA4DxD9leavpWe2/yy1enytQ+s6//lbqo
pKPtspH0h/LV9bE0JODI/Xp9p5YnwsLAx3ikSg6WPbPA3dU/38imqYigG7WKbZSb
hmgIbFulRCob1koH3DQTIsOyn4DHbNtk9HCdKeQcvgZf57EGgZHgNdxAC8UGKm5w
B4BqKjOyBtPR8oQdfVXmoJBpb0xvA6Je2LdSGHfn0qBHxycR7MMRcZnApJnZXRST
5VuGSGPaYK+B9V8n7yS6a2RlfkkZan2C/6Wd70Nos+69dfA3ZzbhAa9NXr9qZWmw
4xdaNXrx4m1Ly1kBWaP6aH2vIHPstx/lSCehNkJlSV22NSxF6ys=
=07py
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--


