Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0999C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6869821882
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFsaWSxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6869821882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6GX-0003vA-6l
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT62U-0004pN-96
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT62T-0004Rb-3V
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:19:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26272
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT62S-0004RR-WA
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573226344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yQvCXqaXQpqGDQDvSsJrNYp9zR10FgvYfz0KngMpf4=;
 b=eFsaWSxcUrtoj0JMG0M61O0oINdYIWL18irji+aLkEaFGqKNPHgyxswMe+D5KwSIF2jhBS
 k7KE7RxEPoYZscxOV2uF4PlrnsNS1Zlm7DtLsGIW8k1bMiyOyZE0L8HlGyn4vGcB6ow5gQ
 0YZ0fnwqppqaIFCQkeu3EBggB4B7reg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-0e5w556uPWiqnc5tUFjKuA-1; Fri, 08 Nov 2019 10:19:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C007107ACC4;
 Fri,  8 Nov 2019 15:19:02 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8393E5DA7F;
 Fri,  8 Nov 2019 15:18:57 +0000 (UTC)
Message-ID: <0930193e0c9c82bc606037e464aed6a10559ff5d.camel@redhat.com>
Subject: Re: [PATCH v2 09/11] block/qcow2: implement blockdev-amend
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 08 Nov 2019 17:18:56 +0200
In-Reply-To: <c26f4f4a-2f2e-84d9-a516-36c7150b6332@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-10-mlevitsk@redhat.com>
 <c26f4f4a-2f2e-84d9-a516-36c7150b6332@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 0e5w556uPWiqnc5tUFjKuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel
 P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-10-04 at 21:03 +0200, Max Reitz wrote:
> On 13.09.19 00:30, Maxim Levitsky wrote:
> > Currently only for changing crypto parameters
>=20
> Yep, that elegantly avoids most of the problems we=E2=80=99d have otherwi=
se. :-)
>=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/qcow2.c        | 71 ++++++++++++++++++++++++++++++++++++++++++++
> >  qapi/block-core.json |  6 ++--
> >  2 files changed, 75 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 26f83aeb44..c8847ec6e2 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -3079,6 +3079,18 @@ qcow2_co_create(BlockdevCreateOptions *create_op=
tions, Error **errp)
> >      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_QCOW2);
> >      qcow2_opts =3D &create_options->u.qcow2;
> > =20
> > +    if (!qcow2_opts->has_size) {
> > +        error_setg(errp, "Size is manadatory for image creation");
> > +        return -EINVAL;
> > +
> > +    }
> > +
> > +    if (!qcow2_opts->has_file) {
> > +        error_setg(errp, "'file' is manadatory for image creation");
> > +        return -EINVAL;
> > +
> > +    }
> > +
> >      bs =3D bdrv_open_blockdev_ref(qcow2_opts->file, errp);
> >      if (bs =3D=3D NULL) {
> >          return -EIO;
> > @@ -5111,6 +5123,64 @@ static int qcow2_amend_options(BlockDriverState =
*bs, QemuOpts *opts,
> >      return 0;
> >  }
> > =20
> > +
> > +static int coroutine_fn qcow2_co_amend(BlockDriverState *bs,
> > +                                       BlockdevCreateOptions *opts,
> > +                                       bool force,
> > +                                       Error **errp)
> > +{
> > +    BlockdevCreateOptionsQcow2 *qopts =3D &opts->u.qcow2;
> > +    BDRVQcow2State *s =3D bs->opaque;
> > +    int ret;
> > +
> > +    /*
> > +     * This is ugly as hell, in later versions of this patch
> > +     * something has to be done about this
>=20
> Well, at least the language of the comment needs adjustment. :-)
Thats for sure :-)

BTW, if I opt for having a separate amend parameter struct,
this will fix this problem as well, as all unsupported
fields will just not be there.

[..]

Best regards,
=09Maxim Levitsky


