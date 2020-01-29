Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4068C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C34206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHYA1YhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C34206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwrYw-0004yK-NL
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 12:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iwrYK-0004TD-Uj
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iwrYJ-0004jT-QD
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:55:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23609
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iwrYJ-0004i9-NJ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580320499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvIzOX0Yw80+z0pYsXRC0xLvUDSAZx/WSJ7KlRyWrTU=;
 b=KHYA1YhP9KtN9eJKaXJlMeaFAt7RckZr4W0UGmcW39bacpzquclsSyn1/XEABaNQd30pId
 JU5CjcXEQph5XcWeVP8E1y4gjDRodbLAnXNgwIC0yx5LjbHA9DmrnE+yaxzKFi3/sdezdO
 n3RkX+P9PUKGLuOKU60/9JF1ZzUQJ9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-euRrtytWNxes6Hp6pHCFaA-1; Wed, 29 Jan 2020 12:54:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FE92189F765;
 Wed, 29 Jan 2020 17:54:54 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3317B1C957;
 Wed, 29 Jan 2020 17:54:49 +0000 (UTC)
Message-ID: <fb9d7ef0dc1d2413d0cff656bc9fa33c32094eec.camel@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Wed, 29 Jan 2020 19:54:47 +0200
In-Reply-To: <20200128173251.GZ1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87r1zti6r8.fsf@dusky.pond.sub.org>
 <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
 <20200128171116.GU1446339@redhat.com> <20200128173251.GZ1446339@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: euRrtytWNxes6Hp6pHCFaA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-28 at 17:32 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 28, 2020 at 05:11:16PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Jan 21, 2020 at 03:13:01PM +0200, Maxim Levitsky wrote:
> > > On Tue, 2020-01-21 at 08:54 +0100, Markus Armbruster wrote:
> > >=20
> > > <trimmed>
> > >=20
> > > > > +##
> > > > > +# @LUKSKeyslotUpdate:
> > > > > +#
> > > > > +# @keyslot:         If specified, will update only keyslot with =
this index
> > > > > +#
> > > > > +# @old-secret:      If specified, will only update keyslots that
> > > > > +#                   can be opened with password which is contain=
ed in
> > > > > +#                   QCryptoSecret with @old-secret ID
> > > > > +#
> > > > > +#                   If neither @keyslot nor @old-secret is speci=
fied,
> > > > > +#                   first empty keyslot is selected for the upda=
te
> > > > > +#
> > > > > +# @new-secret:      The ID of a QCryptoSecret object providing a=
 new decryption
> > > > > +#                   key to place in all matching keyslots.
> > > > > +#                   null/empty string erases all matching keyslo=
ts
> > > >=20
> > > > I hate making the empty string do something completely different th=
an a
> > > > non-empty string.
> > > >=20
> > > > What about making @new-secret optional, and have absent @new-secret
> > > > erase?
> > >=20
> > > I don't remember already why I and Keven Wolf decided to do this this=
 way, but I think that you are right here.
> > > I don't mind personally to do this this way.
> > > empty string though is my addition, since its not possible to pass nu=
ll on command line.
> >=20
> > IIUC this a result of using  "StrOrNull" for this one field...
> >=20
> >=20
> > > > > +# Since: 5.0
> > > > > +##
> > > > > +{ 'struct': 'LUKSKeyslotUpdate',
> > > > > +  'data': {
> > > > > +           '*keyslot': 'int',
> > > > > +           '*old-secret': 'str',
> > > > > +           'new-secret' : 'StrOrNull',
> > > > > +           '*iter-time' : 'int' } }
> >=20
> > It looks wierd here to be special casing "new-secret" to "StrOrNull"
> > instead of just marking it as an optional string field
> >=20
> >    "*new-secret": "str"
> >=20
> > which would be possible to use from the command line, as you simply
> > omit the field.
> >=20
> > I guess the main danger here is that we're using this as a trigger
> > to erase keyslots. So simply omitting "new-secret" can result
> > in damage to the volume by accident which is not an attractive
> > mode.
>=20
> Thinking about this again, I really believe we ought to be moire
> explicit about disabling the keyslot by having the "active" field.
> eg
>=20
> { 'struct': 'LUKSKeyslotUpdate',
>   'data': {
>           'active': 'bool',
>           '*keyslot': 'int',
>           '*old-secret': 'str',
>           '*new-secret' : 'str',
>           '*iter-time' : 'int' } }
>=20
> "new-secret" is thus only needed when "active" =3D=3D true.
>=20
> This avoids the problem with being unable to specify a
> null for StrOrNull on the command line too.
I fully support this idea.
If no objections from anybody else, I'll do it this way.

Best regards,
=09Maxim Levitsky

>=20
> Regards,
> Daniel


