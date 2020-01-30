Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B722AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81390206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aal+Xfa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81390206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCfh-0000fw-Kv
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:28:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ixCcI-0003XW-8X
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ixCcH-0004Sw-79
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:24:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57067
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ixCcH-0004RZ-1j
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580401468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LyMUHV/lq0z4ysTjfpPoak59tssXUYb+BoTtmfQXyCo=;
 b=Aal+Xfa1Xeq/PPIbCLwi3KwDHEQYRsvUbx3Qjzdc1+v95fRcy5feumRFiaoFqvoVWLgEE1
 KKgduPfpmloLDfXUiz8YZujg0Yn9aBYHCHYCb+I10lzN9Oxja2ZQ4WRm3AeuQvNazC3d5I
 DHvS4eLAl8L9+IAIgz+fFP3Xa/+/kAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-7mImUWOpN2Cm9gVwxOkyOQ-1; Thu, 30 Jan 2020 11:24:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D9741902EB3;
 Thu, 30 Jan 2020 16:24:25 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF266CFCC;
 Thu, 30 Jan 2020 16:24:20 +0000 (UTC)
Message-ID: <3ae12c75db4ce389ad3c355bc112593d86e7a256.camel@redhat.com>
Subject: Re: [PATCH 11/13] block/crypto: implement blockdev-amend
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 30 Jan 2020 18:24:19 +0200
In-Reply-To: <20200128174008.GB1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-12-mlevitsk@redhat.com>
 <20200128174008.GB1446339@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 7mImUWOpN2Cm9gVwxOkyOQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-28 at 17:40 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 14, 2020 at 09:33:48PM +0200, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c       | 70 ++++++++++++++++++++++++++++++++------------
> >  qapi/block-core.json | 14 ++++++++-
> >  2 files changed, 64 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 081880bced..6836337863 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
>=20
>=20
> > =20
> > +static int
> > +coroutine_fn block_crypto_co_amend(BlockDriverState *bs,
> > +                                   BlockdevAmendOptions *opts,
> > +                                   bool force,
> > +                                   Error **errp)
>=20
> This should have a _luks suffix given...

100% agree. Fixed now.

> > +{
> > +    QCryptoBlockAmendOptions amend_opts;
> > +
> > +    amend_opts =3D (QCryptoBlockAmendOptions) {
> > +        .format =3D Q_CRYPTO_BLOCK_FORMAT_LUKS,
> > +        .u.luks =3D *qapi_BlockdevAmendOptionsLUKS_base(&opts->u.luks)=
,
>=20
> ...this is hardcoded to luks
>=20
> > +    };
> > +    return block_crypto_amend_options_generic(bs, &amend_opts, force, =
errp);
> > +}
> > =20
> >  static void
> >  block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
> > @@ -812,6 +843,7 @@ static BlockDriver bdrv_crypto_luks =3D {
> >      .bdrv_get_info      =3D block_crypto_get_info_luks,
> >      .bdrv_get_specific_info =3D block_crypto_get_specific_info_luks,
> >      .bdrv_amend_options =3D block_crypto_amend_options,
> > +    .bdrv_co_amend      =3D block_crypto_co_amend,
> > =20
> >      .strong_runtime_opts =3D block_crypto_strong_runtime_opts,
> >  };
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks for the review,
=09Best regards,
=09=09Maxim Levitsky
>=20
>=20
>=20
> Regards,
> Daniel



