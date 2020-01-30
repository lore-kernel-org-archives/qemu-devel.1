Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5263BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7022051A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGLOPTxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7022051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBKl-0007tR-92
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ixBJs-0007Fd-Ho
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ixBJq-0006IX-FD
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:01:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48156
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ixBJp-0006I5-PN
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580396481;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=43e6/2Os/YwlrrfEHMY0c+1A7g89zjHPj8Lk/iqwXt0=;
 b=jGLOPTxSmoYwWTQpcaE2za4z2cntxw46UohYwvljmbgKb9fk+dtzsU3TqpUKPPMybKNXK9
 6ESuZBGyx9kfaiNuiQqJqJbzWoenLMUt8ilALgfjwsvK6DYv9CZ2vuvv+SPIAWAZtkyyPI
 VW8xHp2DbHDD9syvHjHcSRRAWyf9YY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-4nrLpPS4NWaBWZBG3t4Gsw-1; Thu, 30 Jan 2020 10:01:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29FB510509AB;
 Thu, 30 Jan 2020 15:01:16 +0000 (UTC)
Received: from redhat.com (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A4FE1C947;
 Thu, 30 Jan 2020 15:01:11 +0000 (UTC)
Date: Thu, 30 Jan 2020 15:01:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
Message-ID: <20200130150108.GM1891831@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87r1zti6r8.fsf@dusky.pond.sub.org>
 <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
 <20200128171116.GU1446339@redhat.com>
 <20200128173251.GZ1446339@redhat.com>
 <20200130123847.GE6438@linux.fritz.box>
 <20200130125319.GD1891831@redhat.com>
 <87zhe5ovbv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87zhe5ovbv.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4nrLpPS4NWaBWZBG3t4Gsw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 03:47:00PM +0100, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Thu, Jan 30, 2020 at 01:38:47PM +0100, Kevin Wolf wrote:
> >> Am 28.01.2020 um 18:32 hat Daniel P. Berrang=C3=A9 geschrieben:
> >> > On Tue, Jan 28, 2020 at 05:11:16PM +0000, Daniel P. Berrang=C3=A9 wr=
ote:
> >> > > On Tue, Jan 21, 2020 at 03:13:01PM +0200, Maxim Levitsky wrote:
> >> > > > On Tue, 2020-01-21 at 08:54 +0100, Markus Armbruster wrote:
> >> > > >=20
> >> > > > <trimmed>
> >> > > >=20
> >> > > > > > +##
> >> > > > > > +# @LUKSKeyslotUpdate:
> >> > > > > > +#
> >> > > > > > +# @keyslot:         If specified, will update only keyslot =
with this index
> >> > > > > > +#
> >> > > > > > +# @old-secret:      If specified, will only update keyslots=
 that
> >> > > > > > +#                   can be opened with password which is co=
ntained in
> >> > > > > > +#                   QCryptoSecret with @old-secret ID
> >> > > > > > +#
> >> > > > > > +#                   If neither @keyslot nor @old-secret is =
specified,
> >> > > > > > +#                   first empty keyslot is selected for the=
 update
> >> > > > > > +#
> >> > > > > > +# @new-secret:      The ID of a QCryptoSecret object provid=
ing a new decryption
> >> > > > > > +#                   key to place in all matching keyslots.
> >> > > > > > +#                   null/empty string erases all matching k=
eyslots
> >> > > > >=20
> >> > > > > I hate making the empty string do something completely differe=
nt than a
> >> > > > > non-empty string.
> >> > > > >=20
> >> > > > > What about making @new-secret optional, and have absent @new-s=
ecret
> >> > > > > erase?
> >> > > >=20
> >> > > > I don't remember already why I and Keven Wolf decided to do this=
 this way, but I think that you are right here.
> >> > > > I don't mind personally to do this this way.
> >> > > > empty string though is my addition, since its not possible to pa=
ss null on command line.
> >> > >=20
> >> > > IIUC this a result of using  "StrOrNull" for this one field...
> >> > >=20
> >> > >=20
> >> > > > > > +# Since: 5.0
> >> > > > > > +##
> >> > > > > > +{ 'struct': 'LUKSKeyslotUpdate',
> >> > > > > > +  'data': {
> >> > > > > > +           '*keyslot': 'int',
> >> > > > > > +           '*old-secret': 'str',
> >> > > > > > +           'new-secret' : 'StrOrNull',
> >> > > > > > +           '*iter-time' : 'int' } }
> >> > >=20
> >> > > It looks wierd here to be special casing "new-secret" to "StrOrNul=
l"
> >> > > instead of just marking it as an optional string field
> >> > >=20
> >> > >    "*new-secret": "str"
> >> > >=20
> >> > > which would be possible to use from the command line, as you simpl=
y
> >> > > omit the field.
> >> > >=20
> >> > > I guess the main danger here is that we're using this as a trigger
> >> > > to erase keyslots. So simply omitting "new-secret" can result
> >> > > in damage to the volume by accident which is not an attractive
> >> > > mode.
> >>=20
> >> Right. It's been a while since I discussed this with Maxim, but I thin=
k
> >> this was the motivation for me to suggest an explicit null value.
>=20
> A bit of redundancy to guard against catastrophic accidents makes sense.
> We can discuss its shape.
>=20
> >> As long as we don't support passing null from the command line, I see
> >> the problem with it, though. Empty string (which I think we didn't
> >> discuss before) looks like a reasonable enough workaround to me, but i=
f
> >> you think this is too much magic, then maybe not.
> >>=20
> >> > Thinking about this again, I really believe we ought to be moire
> >> > explicit about disabling the keyslot by having the "active" field.
> >> > eg
> >> >=20
> >> > { 'struct': 'LUKSKeyslotUpdate',
> >> >   'data': {
> >> >           'active': 'bool',
> >> >           '*keyslot': 'int',
> >> >           '*old-secret': 'str',
> >> >           '*new-secret' : 'str',
> >> >           '*iter-time' : 'int' } }
> >> >=20
> >> > "new-secret" is thus only needed when "active" =3D=3D true.
>=20
> I figure @iter-time, too.
>=20
> >> Hm. At the very least, I would make 'active' optional and default to
> >> true, so that for adding or updating you must only specify 'new-secret=
'
> >> and for deleting only 'active'.
> >
> > Is that asymmetry really worth while ? It merely saves a few
> > characters of typing by omitting "active: true", so I'm not
> > really convinced.
> >
> >> > This avoids the problem with being unable to specify a null for
> >> > StrOrNull on the command line too.
> >>=20
> >> If we ever get a way to pass null on the command line, how would we
> >> think about a struct like this? Will it still feel right, or will it
> >> feel like we feel about simple unions today (they exist, we would like
> >> to get rid of them, but we can't because compatibility)?
> >
> > Personally I really don't like the idea of using "new-secret:null"
> > as a way to request deletion of a keyslot. That's too magical
> > for an action that is so dangerous to data IMhO.
>=20
> I tend to agree.  Expressing "zap the secret" as '"new-secret": null' is
> clever and kind of cute, but "clever" and "cute" have no place next to
> "irrevocably destroy data".
>=20
> > I think of these operations as activating & deactivating keyslots,
> > hence my suggestion to use an explicit "active: true|false" to
> > associate the core action being performed, instead of inferring
> > the action indirectly from the secret.
> >
> > I think this could lend itself better to future extensions too.
> > eg currently we're just activating or deactivating a keyslot.
> > it is conceivable in future (LUKS2) we might want to modify an
> > existing keyslot in some way. In that scenario, "active" can
> > be updated to be allowed to be optional such that:
> >
> >  - active: true ->  activate a currently inactive keyslot
> >  - active: false -> deactivate a currently active keyslot
> >  - active omitted -> modify a currently active keyslot
>=20
> A boolean provides two actions.  By making it optional, we can squeeze
> out a third, at the price of making the interface unintuitive: how would
> you know what "@active absent" means without looking it up?
>=20
> Why not have an @action of enum type instead?  Values "add" and "delete"
> now (or "activate" and "deactivate", whatever makes the most sense when
> writing the docs), leaving us room to later add whatever comes up.

I probably worded my suggestion badly - "active" should not be
thought of as expressing an operation type; it should be considered
a direct reflection of the "active" metadat field in a LUKS keyslot
on disk.

So I should have described it as:

 - active: true|false ->  set the keyslot active state to this value
 - active omitted -> don't change the keyslot active state

The three possible states of the "active" field then happen to
provide the way to express the desired operations.

>=20
> This also lets us turn LUKSKeyslotUpdate into a union.
>=20
> Brief detour before I sketch that: update safety.
>=20
> Unless writing a keyslot is atomic, i.e. always either succeeds
> completely, or fails without changing anything, updating a slot in place
> is dangerous: you may destroy the old key without getting your new one
> in place.
>=20
> To safely replace an existing secret, you first write the new secret to
> a free slot, and only when that succeeded, you delete the old one.
>=20
> This leads to the following safe operations:
>=20
> * "Activate": write a secret to a free keyslot (chosen by the system)
>=20
> * "Deactivate": delete an existing secret from all keyslots containing
>   it (commonly just one)
>=20
> Dangerous and unwanted:
>=20
> * Replace existing secret in place
>=20
> Low-level operations we may or may not want to support:
>=20
> * Write a secret to specific keyslot (dangerous unless it's free)
>=20
> * Zap a specific keyslot (hope it contains the secret you think it does)
>=20
> Now let me sketch LUKSKeyslotUpdate as union.  First without support for
> the low-level operations:
>=20
>     { state: 'LUKSKeyslotUpdateAction',
>       'data': [ 'add', 'delete' ] }
>     { 'struct': 'LUKSKeyslotAdd',
>       'data': { 'secret': 'str',
>                 '*iter-time': 'int' } }
>     { 'struct': 'LUKSKeyslotDelete',
>       'data': { 'secret': 'str' }
>     { 'union: 'LUKSKeyslotUpdate',
>       'base': { 'action': 'LUKSKeyslotUpdateAction' }
>       'discriminator': 'action',
>       'data': { 'add': 'LUKSKeyslotAdd' },
>               { 'delete': 'LUKSKeyslotDelete' } }
>=20
> Since @secret occurs in all variants, we could also put it in @base
> instead.  Matter of taste.  I think this way is clearer.  Lets us easily
> add a variant that doesn't want @secret later on (although moving it
> from @base to variants then would be possible).


This kind of approach is what I originally believed we
should do, but it is contrary to the design expectations
of the "amend" operation. That is not supposed to be
expressing operations, rather expressing the desired
state of the resulting disk.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


