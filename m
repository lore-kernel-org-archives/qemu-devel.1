Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADDBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6FD22522
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGj6+lnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6FD22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwUre-0005U2-2H
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iwUqe-0004mN-Ou
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:40:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iwUqc-0005ro-Mz
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:40:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iwUqc-0005qY-Ip
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580233221;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28J5A+Tgwe/KJZYvCdFUG1rKjFvJJi3lhF2m+PzYAww=;
 b=iGj6+lnpekMBfC6k2AgnCVeXkOvQgQ8oQE/gDc4qA4lg2UG/UVTqMvuabgtwRPZfytOPcc
 GhRK+lFpFCJ4gAwt6Y8zEFz/2iL6W/iL2ARxlktRAFHXOBTvV9Uzx+xj/ttVL1RRtscOgE
 ycHor8q91Y1lYvRaq4fD7KCREf1rohY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-w1_VvT_bPo2yYmO49uKvdA-1; Tue, 28 Jan 2020 12:40:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2DBD107ACC4;
 Tue, 28 Jan 2020 17:40:16 +0000 (UTC)
Received: from redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 855C319C58;
 Tue, 28 Jan 2020 17:40:11 +0000 (UTC)
Date: Tue, 28 Jan 2020 17:40:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 11/13] block/crypto: implement blockdev-amend
Message-ID: <20200128174008.GB1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-12-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200114193350.10830-12-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: w1_VvT_bPo2yYmO49uKvdA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 09:33:48PM +0200, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/crypto.c       | 70 ++++++++++++++++++++++++++++++++------------
>  qapi/block-core.json | 14 ++++++++-
>  2 files changed, 64 insertions(+), 20 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 081880bced..6836337863 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c


> =20
> +static int
> +coroutine_fn block_crypto_co_amend(BlockDriverState *bs,
> +                                   BlockdevAmendOptions *opts,
> +                                   bool force,
> +                                   Error **errp)

This should have a _luks suffix given...

> +{
> +    QCryptoBlockAmendOptions amend_opts;
> +
> +    amend_opts =3D (QCryptoBlockAmendOptions) {
> +        .format =3D Q_CRYPTO_BLOCK_FORMAT_LUKS,
> +        .u.luks =3D *qapi_BlockdevAmendOptionsLUKS_base(&opts->u.luks),

...this is hardcoded to luks

> +    };
> +    return block_crypto_amend_options_generic(bs, &amend_opts, force, er=
rp);
> +}
> =20
>  static void
>  block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
> @@ -812,6 +843,7 @@ static BlockDriver bdrv_crypto_luks =3D {
>      .bdrv_get_info      =3D block_crypto_get_info_luks,
>      .bdrv_get_specific_info =3D block_crypto_get_specific_info_luks,
>      .bdrv_amend_options =3D block_crypto_amend_options,
> +    .bdrv_co_amend      =3D block_crypto_co_amend,
> =20
>      .strong_runtime_opts =3D block_crypto_strong_runtime_opts,
>  };

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


