Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF18C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9B121739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2Qdgs7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9B121739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwUPT-0002Vl-PV
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iwUOf-0001lW-TA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:11:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iwUOe-0008Tv-KT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:11:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48777
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iwUOe-0008TT-Fs
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580231488;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWdm63lPMuZWQtJ0tqNsHhKTsM98q/xiw5TAlY3QbM4=;
 b=I2Qdgs7Nkmfo5xC01aX0MSLZX/65kdlTIKhY4o2O8I//XoHt7CE5SCzTRWlAxYXR6HpYFT
 8LLOVRQJqED8a66dqbfbbynkr1n80BEgnK8AEXeduoM1rBIReN+SL02sGzFs0RnHfDoGNh
 oV0n9Hf/xdHPg0ITJlTY33v+QqVzRUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-60muBxmeMQ6efd1SE05TZQ-1; Tue, 28 Jan 2020 12:11:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E5CB477;
 Tue, 28 Jan 2020 17:11:24 +0000 (UTC)
Received: from redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 022335C1D8;
 Tue, 28 Jan 2020 17:11:19 +0000 (UTC)
Date: Tue, 28 Jan 2020 17:11:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
Message-ID: <20200128171116.GU1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87r1zti6r8.fsf@dusky.pond.sub.org>
 <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 60muBxmeMQ6efd1SE05TZQ-1
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
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 03:13:01PM +0200, Maxim Levitsky wrote:
> On Tue, 2020-01-21 at 08:54 +0100, Markus Armbruster wrote:
>=20
> <trimmed>
>=20
> > > +##
> > > +# @LUKSKeyslotUpdate:
> > > +#
> > > +# @keyslot:         If specified, will update only keyslot with this=
 index
> > > +#
> > > +# @old-secret:      If specified, will only update keyslots that
> > > +#                   can be opened with password which is contained i=
n
> > > +#                   QCryptoSecret with @old-secret ID
> > > +#
> > > +#                   If neither @keyslot nor @old-secret is specified=
,
> > > +#                   first empty keyslot is selected for the update
> > > +#
> > > +# @new-secret:      The ID of a QCryptoSecret object providing a new=
 decryption
> > > +#                   key to place in all matching keyslots.
> > > +#                   null/empty string erases all matching keyslots
> >=20
> > I hate making the empty string do something completely different than a
> > non-empty string.
> >=20
> > What about making @new-secret optional, and have absent @new-secret
> > erase?
>=20
> I don't remember already why I and Keven Wolf decided to do this this way=
, but I think that you are right here.
> I don't mind personally to do this this way.
> empty string though is my addition, since its not possible to pass null o=
n command line.

IIUC this a result of using  "StrOrNull" for this one field...


> > > +# Since: 5.0
> > > +##
> > > +{ 'struct': 'LUKSKeyslotUpdate',
> > > +  'data': {
> > > +           '*keyslot': 'int',
> > > +           '*old-secret': 'str',
> > > +           'new-secret' : 'StrOrNull',
> > > +           '*iter-time' : 'int' } }

It looks wierd here to be special casing "new-secret" to "StrOrNull"
instead of just marking it as an optional string field

   "*new-secret": "str"

which would be possible to use from the command line, as you simply
omit the field.

I guess the main danger here is that we're using this as a trigger
to erase keyslots. So simply omitting "new-secret" can result
in damage to the volume by accident which is not an attractive
mode.=20


> > > +
> > > +##
> > > +# @QCryptoBlockAmendOptionsLUKS:
> > > +#
> > > +# The options that can be changed on existing luks encrypted device
> > > +# @keys:           list of keyslot updates to perform
> > > +#                  (updates are performed in order)
> > > +# @unlock-secret:  use this secret to retrieve the current master ke=
y
> > > +#                  if not given will use the same secret as one
> >=20
> > "as the one"?
> Yea, this is wrong wording, I'll drop those words. Thanks.
>=20
> >=20
> > > +#                  that was used to open the image
> > > +#
> > > +# Since: 5.0
> > > +##
> > > +{ 'struct': 'QCryptoBlockAmendOptionsLUKS',
> > > +  'data' : {
> > > +            'keys': ['LUKSKeyslotUpdate'],
> > > +             '*unlock-secret' : 'str' } }
> > > +
> > >  =20
> > >  =20
> > >   ##
> > > @@ -324,4 +372,4 @@
> > >     'base': 'QCryptoBlockOptionsBase',
> > >     'discriminator': 'format',
> > >     'data': {
> > > -            } }
> > > +          'luks': 'QCryptoBlockAmendOptionsLUKS' } }
>=20
>=20
> Thanks for review,
> =09Best regards,
> =09=09Maxim Levitsky
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


