Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D19C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0880214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DE11XLIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0880214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwUm8-0000wy-3d
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iwUjg-0006fw-M6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:33:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iwUje-0002mS-7h
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:33:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iwUja-0002h4-1B
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580232783;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKs91koXvRHhuchystOq4ZoZQfcupWaFG38wVLLiB6g=;
 b=DE11XLILEx0QvWBTg6j9PClNPznQ37vvHvKVx9bRB2PMhDQbr8xxfSSBdKA2NhgXMGkH0E
 kS0HILCm3Vi5rvzVqrrSA9Jzrn6pTb2dO04DXFj8lCEPBkmIrPJ7jncnLj4Ve+61INl+Tx
 n+jA6UEE6ROdu6nLfJl7qYxrxPr811E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-DzjmXy4pOOKsaEas3kOYvA-1; Tue, 28 Jan 2020 12:33:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3716013E5;
 Tue, 28 Jan 2020 17:33:00 +0000 (UTC)
Received: from redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F76480A5C;
 Tue, 28 Jan 2020 17:32:54 +0000 (UTC)
Date: Tue, 28 Jan 2020 17:32:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
Message-ID: <20200128173251.GZ1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87r1zti6r8.fsf@dusky.pond.sub.org>
 <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
 <20200128171116.GU1446339@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200128171116.GU1446339@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: DzjmXy4pOOKsaEas3kOYvA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 28, 2020 at 05:11:16PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 21, 2020 at 03:13:01PM +0200, Maxim Levitsky wrote:
> > On Tue, 2020-01-21 at 08:54 +0100, Markus Armbruster wrote:
> >=20
> > <trimmed>
> >=20
> > > > +##
> > > > +# @LUKSKeyslotUpdate:
> > > > +#
> > > > +# @keyslot:         If specified, will update only keyslot with th=
is index
> > > > +#
> > > > +# @old-secret:      If specified, will only update keyslots that
> > > > +#                   can be opened with password which is contained=
 in
> > > > +#                   QCryptoSecret with @old-secret ID
> > > > +#
> > > > +#                   If neither @keyslot nor @old-secret is specifi=
ed,
> > > > +#                   first empty keyslot is selected for the update
> > > > +#
> > > > +# @new-secret:      The ID of a QCryptoSecret object providing a n=
ew decryption
> > > > +#                   key to place in all matching keyslots.
> > > > +#                   null/empty string erases all matching keyslots
> > >=20
> > > I hate making the empty string do something completely different than=
 a
> > > non-empty string.
> > >=20
> > > What about making @new-secret optional, and have absent @new-secret
> > > erase?
> >=20
> > I don't remember already why I and Keven Wolf decided to do this this w=
ay, but I think that you are right here.
> > I don't mind personally to do this this way.
> > empty string though is my addition, since its not possible to pass null=
 on command line.
>=20
> IIUC this a result of using  "StrOrNull" for this one field...
>=20
>=20
> > > > +# Since: 5.0
> > > > +##
> > > > +{ 'struct': 'LUKSKeyslotUpdate',
> > > > +  'data': {
> > > > +           '*keyslot': 'int',
> > > > +           '*old-secret': 'str',
> > > > +           'new-secret' : 'StrOrNull',
> > > > +           '*iter-time' : 'int' } }
>=20
> It looks wierd here to be special casing "new-secret" to "StrOrNull"
> instead of just marking it as an optional string field
>=20
>    "*new-secret": "str"
>=20
> which would be possible to use from the command line, as you simply
> omit the field.
>=20
> I guess the main danger here is that we're using this as a trigger
> to erase keyslots. So simply omitting "new-secret" can result
> in damage to the volume by accident which is not an attractive
> mode.

Thinking about this again, I really believe we ought to be moire
explicit about disabling the keyslot by having the "active" field.
eg

{ 'struct': 'LUKSKeyslotUpdate',
  'data': {
          'active': 'bool',
          '*keyslot': 'int',
          '*old-secret': 'str',
          '*new-secret' : 'str',
          '*iter-time' : 'int' } }

"new-secret" is thus only needed when "active" =3D=3D true.

This avoids the problem with being unable to specify a
null for StrOrNull on the command line too.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


