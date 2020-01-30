Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB8A20674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uh3Ax9N3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB8A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixC1n-0003HY-P5
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ixC1A-0002mI-4n
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ixC17-0002b5-Qm
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:46:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55558
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ixC17-0002an-MW
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580399165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFL0ZpX+m6BpcwHmr3hKq9ZR+cnW5HqUyIcBQADjAN4=;
 b=Uh3Ax9N3iVDEUrk9Zh8TYkktR3z0kGmYPyrLCXyQIAKfu/3GQPpdTthonI4MX5A1zBiv2B
 s+e/NTRHV4Rnrg/7oZOdifoCVbGfyawxs2tAR5X3d/2VGBYLeMr5hVb9KN73bnBiLskQYf
 A+j+2AQflwmzf0q1GjY8GJK6QI/1cxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254--99AY5vdPrG7pAAfjrLecg-1; Thu, 30 Jan 2020 10:46:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 091841882CF3;
 Thu, 30 Jan 2020 15:46:00 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5394F77921;
 Thu, 30 Jan 2020 15:45:55 +0000 (UTC)
Message-ID: <9d4d2bbeab875b235900790b17b85bba9dda9262.camel@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Daniel
 =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>
Date: Thu, 30 Jan 2020 17:45:54 +0200
In-Reply-To: <87zhe5ovbv.fsf@dusky.pond.sub.org>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87r1zti6r8.fsf@dusky.pond.sub.org>
 <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
 <20200128171116.GU1446339@redhat.com> <20200128173251.GZ1446339@redhat.com>
 <20200130123847.GE6438@linux.fritz.box>
 <20200130125319.GD1891831@redhat.com> <87zhe5ovbv.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: -99AY5vdPrG7pAAfjrLecg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-01-30 at 15:47 +0100, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Thu, Jan 30, 2020 at 01:38:47PM +0100, Kevin Wolf wrote:
> > > Am 28.01.2020 um 18:32 hat Daniel P. Berrang=C3=A9 geschrieben:
> > > > On Tue, Jan 28, 2020 at 05:11:16PM +0000, Daniel P. Berrang=C3=A9 w=
rote:
> > > > > On Tue, Jan 21, 2020 at 03:13:01PM +0200, Maxim Levitsky wrote:
> > > > > > On Tue, 2020-01-21 at 08:54 +0100, Markus Armbruster wrote:
> > > > > >=20
> > > > > > <trimmed>
> > > > > >=20
> > > > > > > > +##
> > > > > > > > +# @LUKSKeyslotUpdate:
> > > > > > > > +#
> > > > > > > > +# @keyslot:         If specified, will update only keyslot=
 with this index
> > > > > > > > +#
> > > > > > > > +# @old-secret:      If specified, will only update keyslot=
s that
> > > > > > > > +#                   can be opened with password which is c=
ontained in
> > > > > > > > +#                   QCryptoSecret with @old-secret ID
> > > > > > > > +#
> > > > > > > > +#                   If neither @keyslot nor @old-secret is=
 specified,
> > > > > > > > +#                   first empty keyslot is selected for th=
e update
> > > > > > > > +#
> > > > > > > > +# @new-secret:      The ID of a QCryptoSecret object provi=
ding a new decryption
> > > > > > > > +#                   key to place in all matching keyslots.
> > > > > > > > +#                   null/empty string erases all matching =
keyslots
> > > > > > >=20
> > > > > > > I hate making the empty string do something completely differ=
ent than a
> > > > > > > non-empty string.
> > > > > > >=20
> > > > > > > What about making @new-secret optional, and have absent @new-=
secret
> > > > > > > erase?
> > > > > >=20
> > > > > > I don't remember already why I and Keven Wolf decided to do thi=
s this way, but I think that you are right here.
> > > > > > I don't mind personally to do this this way.
> > > > > > empty string though is my addition, since its not possible to p=
ass null on command line.
> > > > >=20
> > > > > IIUC this a result of using  "StrOrNull" for this one field...
> > > > >=20
> > > > >=20
> > > > > > > > +# Since: 5.0
> > > > > > > > +##
> > > > > > > > +{ 'struct': 'LUKSKeyslotUpdate',
> > > > > > > > +  'data': {
> > > > > > > > +           '*keyslot': 'int',
> > > > > > > > +           '*old-secret': 'str',
> > > > > > > > +           'new-secret' : 'StrOrNull',
> > > > > > > > +           '*iter-time' : 'int' } }
> > > > >=20
> > > > > It looks wierd here to be special casing "new-secret" to "StrOrNu=
ll"
> > > > > instead of just marking it as an optional string field
> > > > >=20
> > > > >    "*new-secret": "str"
> > > > >=20
> > > > > which would be possible to use from the command line, as you simp=
ly
> > > > > omit the field.
> > > > >=20
> > > > > I guess the main danger here is that we're using this as a trigge=
r
> > > > > to erase keyslots. So simply omitting "new-secret" can result
> > > > > in damage to the volume by accident which is not an attractive
> > > > > mode.
> > >=20
> > > Right. It's been a while since I discussed this with Maxim, but I thi=
nk
> > > this was the motivation for me to suggest an explicit null value.
>=20
> A bit of redundancy to guard against catastrophic accidents makes sense.
> We can discuss its shape.
>=20
> > > As long as we don't support passing null from the command line, I see
> > > the problem with it, though. Empty string (which I think we didn't
> > > discuss before) looks like a reasonable enough workaround to me, but =
if
> > > you think this is too much magic, then maybe not.
> > >=20
> > > > Thinking about this again, I really believe we ought to be moire
> > > > explicit about disabling the keyslot by having the "active" field.
> > > > eg
> > > >=20
> > > > { 'struct': 'LUKSKeyslotUpdate',
> > > >   'data': {
> > > >           'active': 'bool',
> > > >           '*keyslot': 'int',
> > > >           '*old-secret': 'str',
> > > >           '*new-secret' : 'str',
> > > >           '*iter-time' : 'int' } }
> > > >=20
> > > > "new-secret" is thus only needed when "active" =3D=3D true.
>=20
> I figure @iter-time, too.
>=20
> > > Hm. At the very least, I would make 'active' optional and default to
> > > true, so that for adding or updating you must only specify 'new-secre=
t'
> > > and for deleting only 'active'.
> >=20
> > Is that asymmetry really worth while ? It merely saves a few
> > characters of typing by omitting "active: true", so I'm not
> > really convinced.
> >=20
> > > > This avoids the problem with being unable to specify a null for
> > > > StrOrNull on the command line too.
> > >=20
> > > If we ever get a way to pass null on the command line, how would we
> > > think about a struct like this? Will it still feel right, or will it
> > > feel like we feel about simple unions today (they exist, we would lik=
e
> > > to get rid of them, but we can't because compatibility)?
> >=20
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
> >=20
> > I think this could lend itself better to future extensions too.
> > eg currently we're just activating or deactivating a keyslot.
> > it is conceivable in future (LUKS2) we might want to modify an
> > existing keyslot in some way. In that scenario, "active" can
> > be updated to be allowed to be optional such that:
> >=20
> >  - active: true ->  activate a currently inactive keyslot
> >  - active: false -> deactivate a currently active keyslot
> >  - active omitted -> modify a currently active keyslot
>=20
> A boolean provides two actions.  By making it optional, we can squeeze
> out a third, at the price of making the interface unintuitive: how would
> you know what "@active absent" means without looking it up?

Note that modifying a currently active keyslot is potentially dangerous
operation and thus not allowed at all by default unless user passes 'force'
parameter.

The right safe usage is always to add a new keyslot and then erase the old
one(s).

>=20
> Why not have an @action of enum type instead?  Values "add" and "delete"
> now (or "activate" and "deactivate", whatever makes the most sense when
> writing the docs), leaving us room to later add whatever comes up.
>=20
> This also lets us turn LUKSKeyslotUpdate into a union.
>=20
> Brief detour before I sketch that: update safety.
>=20
> Unless writing a keyslot is atomic, i.e. always either succeeds
> completely, or fails without changing anything, updating a slot in place
> is dangerous: you may destroy the old key without getting your new one
> in place.
Exactly. The keyslot is scattered on the disk. It partially resides
in 1st 512 bytes sector as part of 8 keyslot header table,
and partially resides in area after that header, where the encrypted
master key is stored. Due to anti-forensic algorithm used, that
area for each keyslot even takes itself several sectors.

Write can fail partially/fully and leave us with broken keyslot.
In theory you can restore the old values, but since write failure
usually means media error (e.g. bad disk sector), this won't help much.
In theory the code can try to write a other keyslot, but that is even uglie=
r.

Its best to leave this to user and thus user indeed is supposed to write fi=
rst to a free keyslot,
check that write succeeded and only then erase the old keyslot.


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
This can be dangerous too if last keyslot is erased since that basically
guarantees data loss, and therefore also needs 'force' option in my patchse=
t.


Exactly
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

^^ and the above is especially bad if erasing last keyslot as explained abo=
ve.

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
>=20
> Compare:
>=20
> * Activate free keyslot to hold a secret
>=20
>   { "new-secret": "CIA/GRU/MI6" }
>=20
>   vs.
>=20
>   { "active": true, "new-secret": "CIA/GRU/MI6" }
>=20
>   vs.
>=20
>   { "action": "add", "secret": "CIA/GRU/MI6" }
>=20
> * Deactivate keyslots holding a secret
>=20
>   { "old-secret": "CIA/GRU/MI6", "new-secret": null }
>=20
>   vs.
>=20
>   { "active": false, "old-secret": "CIA/GRU/MI6" }
>=20
>   vs.
>=20
>   { "action": "delete", "secret": "CIA/GRU/MI6" }
>=20
> * Replace existing secret in-place (unsafe!)
>=20
>   { "old-secret": "OSS/NKVD/MI6", "new-secret": "CIA/GRU/MI6" }
Note that my code doesn't support this currently, and user can do this
by first adding a secret and then erasing old one.
I can add this just for fun (but only when 'force' is used).

>=20
>   vs.
>=20
>   Can't do.
>=20
> Now let's add support for the low-level operations.  To "write specific
> slot" to "add", we add optional LUKSKeyslotAdd member @keyslot to direct
> the write to that keyslot instead of the first free one:
>=20
>     { 'struct': 'LUKSKeyslotAdd',
>       'data': { 'secret': 'str',
>                 '*keyslot': 'int',
>                 '*iter-time': 'int' } }
OK.

>=20
> To add "zap specific slot" to delete, we need to pass a slot number
> instead of the old secret.  We could add member @keyslot, make both
> optional, and require users to specify exactly one of them:
>=20
>     { 'struct': 'LUKSKeyslotDelete',
>       'data': { '*secret': 'str',       # must pass either @secret
>                 '*keyslot': 'int' } }   # or @keyslot
No problem with that.

>=20
> Or we use an alternate:
>=20
>     { 'alternate': 'LUKSKeyslotMatch',
>       'data': { 'secret': 'str',
>                 'keyslot': 'int' } }
>     { 'struct': 'LUKSKeyslotDelete',
>       'data': { 'match': 'LUKSKeyslotMatch' } }
>=20
> Hmm, that gets us into trouble with dotted keys, because match=3D1 could
> be keyslot#1 or the (truly bad) secret "1".  Nevermind.
>=20
> Or we add a separate "zap" action:
>=20
>     { state: 'LUKSKeyslotUpdateAction',
>       'data': [ 'add', 'delete', 'zap' ] }
>     { 'struct': 'LUKSKeyslotZap',
>       'data': { 'keyslot': 'int' } }
>     { 'union: 'LUKSKeyslotUpdate',
>       'base': { 'action': 'LUKSKeyslotUpdateAction' }
>       'discriminator': 'action',
>       'data': { 'add': 'LUKSKeyslotAdd' },
>               { 'delete': 'LUKSKeyslotDelete' },
>               { 'zap': 'LUKSKeyslotZap' } }

I am not sure I like the 'zap' action, but if this is agreed upon,
I won't argue about this.


>=20
> Compare:
>=20
> * Write to keyslot#1
>=20
>   { "new-secret": "CIA/GRU/MI6", "keyslot": 1 }
>=20
>   vs.
>=20
>   { "active": true, "new-secret": "CIA/GRU/MI6", "keyslot": 1 }
>=20
>   vs.
>=20
>   { "action": "add", "secret": "CIA/GRU/MI6", "keyslot": 1 }
>=20
> * Zap keyslot#1
>=20
>   { "keyslot": 1, "new-secret": null }
>=20
>   vs.
>=20
>   { "active": false, "keyslot": 1 }
>=20
>   vs.
>=20
>   { "action": "delete", "keyslot": 1 }
>=20
>   vs.
>=20
>   { "action": "zap", "keyslot": 1 }


Best regards,
=09Maxim Levitsky



