Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E1FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65FF2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amIPd/uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65FF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCNG-0000GW-1A
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ixCMd-000810-Gn
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ixCMb-000519-Cg
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:08:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ixCMb-000502-8G
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580400496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P2vKpZwFAzTjNFr5HAlyqQ8NUrGjpGOYeiWUqQeE7Es=;
 b=amIPd/uoaYq0tm1g+5AVr4l5rONYv2zeNYZHv+zRPS37UgywaLpXk25SLD72qiFpj4YIqU
 xZSuhd5K7H/C1b615X2MDqLSrVzLknlhiQDZn+S+UsZBfriZMgzwS15anOHlYtowyN42gN
 CcFnO3fYSzGUcSULhHsvos/Al6TuyPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-BFxssG8lOXajZLNwmAjuog-1; Thu, 30 Jan 2020 11:08:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D3241851FDB;
 Thu, 30 Jan 2020 16:08:13 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EB5E10018FF;
 Thu, 30 Jan 2020 16:08:01 +0000 (UTC)
Message-ID: <b1e56de3c132786ab914cc7c1bea7c5d9c030a24.camel@redhat.com>
Subject: Re: [PATCH 06/13] block/crypto: implement the encryption key
 management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 30 Jan 2020 18:08:00 +0200
In-Reply-To: <20200128172751.GX1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-7-mlevitsk@redhat.com>
 <20200128172751.GX1446339@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: BFxssG8lOXajZLNwmAjuog-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-28 at 17:27 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 14, 2020 at 09:33:43PM +0200, Maxim Levitsky wrote:
> > This implements the encryption key management using the generic code in
> > qcrypto layer and exposes it to the user via qemu-img
> >=20
> > This code adds another 'write_func' because the initialization
> > write_func works directly on the underlying file, and amend
> > works on instance of luks device.
> >=20
> > This commit also adds a 'hack/workaround' I and Kevin Wolf (thanks)
> > made to make the driver both support write sharing (to avoid breaking t=
he users),
> > and be safe against concurrent  metadata update (the keyslots)
> >=20
> > Eventually the write sharing for luks driver will be deprecated
> > and removed together with this hack.
> >=20
> > The hack is that we ask (as a format driver) for BLK_PERM_CONSISTENT_RE=
AD
> > and then when we want to update the keys, we unshare that permission.
> > So if someone else has the image open, even readonly, encryption
> > key update will fail gracefully.
> >=20
> > Also thanks to Daniel Berrange for the idea of
> > unsharing read, rather that write permission which allows
> > to avoid cases when the other user had opened the image read-only.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  block/crypto.h |  31 ++++++++++++
> >  2 files changed, 158 insertions(+), 3 deletions(-)
> >=20
> > @@ -148,6 +167,22 @@ static QemuOptsList block_crypto_create_opts_luks =
=3D {
> >  };
> > =20
> > =20
> > +static QemuOptsList block_crypto_amend_opts_luks =3D {
> > +    .name =3D "crypto",
> > +    .head =3D QTAILQ_HEAD_INITIALIZER(block_crypto_create_opts_luks.he=
ad),
> > +    .desc =3D {
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("keys.0."),
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("keys.1."),
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("keys.2."),
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("keys.3."),
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("keys.4."),
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("keys.5."),
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("keys.6."),
> > +        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT_UPDATE("keys.7."),
>=20
> I'd probably suggest  "key.0" or "keyslot.0" as a name.
To be honest, I don't like either of these.=20

I don't like the 'keys'
array, because it is a bit misleading, as basically each 'key' is a command
that can add/erase an arbitrary keyslot.

I would call this 'command' or cmd at least.

Also note that the 'keys' here is passed as is to qmp parser so if I change=
 it here, I will have probably
to update the qmp version as well and there the 'keys' name is more or less=
 agreed upon.
Thoughts?


>=20
> > +        { /* end of list */ }
> > +    },
> > +};
> > +
>=20
>=20
> > @@ -661,6 +696,95 @@ block_crypto_get_specific_info_luks(BlockDriverSta=
te *bs, Error **errp)
> >      return spec_info;
> >  }
> > =20
> > +static int
> > +block_crypto_amend_options(BlockDriverState *bs,
> > +                           QemuOpts *opts,
> > +                           BlockDriverAmendStatusCB *status_cb,
> > +                           void *cb_opaque,
> > +                           bool force,
> > +                           Error **errp)
>=20
> This method should have a "_luks" suffix since...

Oops, thanks!
>=20
> > +{
> > +    BlockCrypto *crypto =3D bs->opaque;
> > +    QDict *cryptoopts =3D NULL;
> > +    QCryptoBlockAmendOptions *amend_options =3D NULL;
> > +    int ret;
> > +
> > +    assert(crypto);
> > +    assert(crypto->block);
> > +    crypto->updating_keys =3D true;
> > +
> > +    ret =3D bdrv_child_refresh_perms(bs, bs->file, errp);
> > +    if (ret < 0) {
> > +        goto cleanup;
> > +    }
> > +
> > +    cryptoopts =3D qemu_opts_to_qdict(opts, NULL);
> > +    qdict_put_str(cryptoopts, "format", "luks");
>=20
> ...it is hardcoded here to assume luks.
>=20
> > +    amend_options =3D block_crypto_amend_opts_init(cryptoopts, errp);
> > +    if (!amend_options) {
> > +        ret =3D -EINVAL;
> > +        goto cleanup;
> > +    }
> > +
> > +    ret =3D qcrypto_block_amend_options(crypto->block,
> > +                                      block_crypto_read_func,
> > +                                      block_crypto_write_func,
> > +                                      bs,
> > +                                      amend_options,
> > +                                      force,
> > +                                      errp);
> > +cleanup:
> > +    crypto->updating_keys =3D false;
> > +    bdrv_child_refresh_perms(bs, bs->file, errp);
> > +    qapi_free_QCryptoBlockAmendOptions(amend_options);
> > +    qobject_unref(cryptoopts);
> > +    return ret;
> > +}
>=20
> With the minor changes above
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Best regards,
=09Thanks for the review,
=09=09Maxim Levitsky


>=20
>=20
> Regards,
> Daniel



