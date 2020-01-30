Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAEEC35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2DF206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foNWFr3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2DF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixB8J-0007rK-Vo
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ixB69-00061r-Qx
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ixB66-0004AV-VA
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:47:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53761
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ixB66-00046h-Rq
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580395629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+WOuojqhG3Knbh0/cyr8zEdG89BbXDN/3MUWOCMAzB8=;
 b=foNWFr3WZeuKY+D6DJe5PKVz+4T5mIGZgmirbfp5gZ+FTpo7SftqCx3RthuZ8xNrol5iAR
 ua8SkOc3DgTgSYydg+VB0h8tpnmpfiHIrSzbd8ASY+jxjCBOzbRaq3SchtRj8M2Frlk9j/
 ifRPxLmQXbruketlXxS/9QtFgaErMqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-xOuNnqq5Nf6bEjZ-r6Z5EA-1; Thu, 30 Jan 2020 09:47:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C5A68010DD;
 Thu, 30 Jan 2020 14:47:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4D3048;
 Thu, 30 Jan 2020 14:47:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3587F1138404; Thu, 30 Jan 2020 15:47:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87r1zti6r8.fsf@dusky.pond.sub.org>
 <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
 <20200128171116.GU1446339@redhat.com>
 <20200128173251.GZ1446339@redhat.com>
 <20200130123847.GE6438@linux.fritz.box>
 <20200130125319.GD1891831@redhat.com>
Date: Thu, 30 Jan 2020 15:47:00 +0100
In-Reply-To: <20200130125319.GD1891831@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 30 Jan 2020 12:53:19 +0000")
Message-ID: <87zhe5ovbv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: xOuNnqq5Nf6bEjZ-r6Z5EA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jan 30, 2020 at 01:38:47PM +0100, Kevin Wolf wrote:
>> Am 28.01.2020 um 18:32 hat Daniel P. Berrang=C3=A9 geschrieben:
>> > On Tue, Jan 28, 2020 at 05:11:16PM +0000, Daniel P. Berrang=C3=A9 wrot=
e:
>> > > On Tue, Jan 21, 2020 at 03:13:01PM +0200, Maxim Levitsky wrote:
>> > > > On Tue, 2020-01-21 at 08:54 +0100, Markus Armbruster wrote:
>> > > >=20
>> > > > <trimmed>
>> > > >=20
>> > > > > > +##
>> > > > > > +# @LUKSKeyslotUpdate:
>> > > > > > +#
>> > > > > > +# @keyslot:         If specified, will update only keyslot wi=
th this index
>> > > > > > +#
>> > > > > > +# @old-secret:      If specified, will only update keyslots t=
hat
>> > > > > > +#                   can be opened with password which is cont=
ained in
>> > > > > > +#                   QCryptoSecret with @old-secret ID
>> > > > > > +#
>> > > > > > +#                   If neither @keyslot nor @old-secret is sp=
ecified,
>> > > > > > +#                   first empty keyslot is selected for the u=
pdate
>> > > > > > +#
>> > > > > > +# @new-secret:      The ID of a QCryptoSecret object providin=
g a new decryption
>> > > > > > +#                   key to place in all matching keyslots.
>> > > > > > +#                   null/empty string erases all matching key=
slots
>> > > > >=20
>> > > > > I hate making the empty string do something completely different=
 than a
>> > > > > non-empty string.
>> > > > >=20
>> > > > > What about making @new-secret optional, and have absent @new-sec=
ret
>> > > > > erase?
>> > > >=20
>> > > > I don't remember already why I and Keven Wolf decided to do this t=
his way, but I think that you are right here.
>> > > > I don't mind personally to do this this way.
>> > > > empty string though is my addition, since its not possible to pass=
 null on command line.
>> > >=20
>> > > IIUC this a result of using  "StrOrNull" for this one field...
>> > >=20
>> > >=20
>> > > > > > +# Since: 5.0
>> > > > > > +##
>> > > > > > +{ 'struct': 'LUKSKeyslotUpdate',
>> > > > > > +  'data': {
>> > > > > > +           '*keyslot': 'int',
>> > > > > > +           '*old-secret': 'str',
>> > > > > > +           'new-secret' : 'StrOrNull',
>> > > > > > +           '*iter-time' : 'int' } }
>> > >=20
>> > > It looks wierd here to be special casing "new-secret" to "StrOrNull"
>> > > instead of just marking it as an optional string field
>> > >=20
>> > >    "*new-secret": "str"
>> > >=20
>> > > which would be possible to use from the command line, as you simply
>> > > omit the field.
>> > >=20
>> > > I guess the main danger here is that we're using this as a trigger
>> > > to erase keyslots. So simply omitting "new-secret" can result
>> > > in damage to the volume by accident which is not an attractive
>> > > mode.
>>=20
>> Right. It's been a while since I discussed this with Maxim, but I think
>> this was the motivation for me to suggest an explicit null value.

A bit of redundancy to guard against catastrophic accidents makes sense.
We can discuss its shape.

>> As long as we don't support passing null from the command line, I see
>> the problem with it, though. Empty string (which I think we didn't
>> discuss before) looks like a reasonable enough workaround to me, but if
>> you think this is too much magic, then maybe not.
>>=20
>> > Thinking about this again, I really believe we ought to be moire
>> > explicit about disabling the keyslot by having the "active" field.
>> > eg
>> >=20
>> > { 'struct': 'LUKSKeyslotUpdate',
>> >   'data': {
>> >           'active': 'bool',
>> >           '*keyslot': 'int',
>> >           '*old-secret': 'str',
>> >           '*new-secret' : 'str',
>> >           '*iter-time' : 'int' } }
>> >=20
>> > "new-secret" is thus only needed when "active" =3D=3D true.

I figure @iter-time, too.

>> Hm. At the very least, I would make 'active' optional and default to
>> true, so that for adding or updating you must only specify 'new-secret'
>> and for deleting only 'active'.
>
> Is that asymmetry really worth while ? It merely saves a few
> characters of typing by omitting "active: true", so I'm not
> really convinced.
>
>> > This avoids the problem with being unable to specify a null for
>> > StrOrNull on the command line too.
>>=20
>> If we ever get a way to pass null on the command line, how would we
>> think about a struct like this? Will it still feel right, or will it
>> feel like we feel about simple unions today (they exist, we would like
>> to get rid of them, but we can't because compatibility)?
>
> Personally I really don't like the idea of using "new-secret:null"
> as a way to request deletion of a keyslot. That's too magical
> for an action that is so dangerous to data IMhO.

I tend to agree.  Expressing "zap the secret" as '"new-secret": null' is
clever and kind of cute, but "clever" and "cute" have no place next to
"irrevocably destroy data".

> I think of these operations as activating & deactivating keyslots,
> hence my suggestion to use an explicit "active: true|false" to
> associate the core action being performed, instead of inferring
> the action indirectly from the secret.
>
> I think this could lend itself better to future extensions too.
> eg currently we're just activating or deactivating a keyslot.
> it is conceivable in future (LUKS2) we might want to modify an
> existing keyslot in some way. In that scenario, "active" can
> be updated to be allowed to be optional such that:
>
>  - active: true ->  activate a currently inactive keyslot
>  - active: false -> deactivate a currently active keyslot
>  - active omitted -> modify a currently active keyslot

A boolean provides two actions.  By making it optional, we can squeeze
out a third, at the price of making the interface unintuitive: how would
you know what "@active absent" means without looking it up?

Why not have an @action of enum type instead?  Values "add" and "delete"
now (or "activate" and "deactivate", whatever makes the most sense when
writing the docs), leaving us room to later add whatever comes up.

This also lets us turn LUKSKeyslotUpdate into a union.

Brief detour before I sketch that: update safety.

Unless writing a keyslot is atomic, i.e. always either succeeds
completely, or fails without changing anything, updating a slot in place
is dangerous: you may destroy the old key without getting your new one
in place.

To safely replace an existing secret, you first write the new secret to
a free slot, and only when that succeeded, you delete the old one.

This leads to the following safe operations:

* "Activate": write a secret to a free keyslot (chosen by the system)

* "Deactivate": delete an existing secret from all keyslots containing
  it (commonly just one)

Dangerous and unwanted:

* Replace existing secret in place

Low-level operations we may or may not want to support:

* Write a secret to specific keyslot (dangerous unless it's free)

* Zap a specific keyslot (hope it contains the secret you think it does)

Now let me sketch LUKSKeyslotUpdate as union.  First without support for
the low-level operations:

    { state: 'LUKSKeyslotUpdateAction',
      'data': [ 'add', 'delete' ] }
    { 'struct': 'LUKSKeyslotAdd',
      'data': { 'secret': 'str',
                '*iter-time': 'int' } }
    { 'struct': 'LUKSKeyslotDelete',
      'data': { 'secret': 'str' }
    { 'union: 'LUKSKeyslotUpdate',
      'base': { 'action': 'LUKSKeyslotUpdateAction' }
      'discriminator': 'action',
      'data': { 'add': 'LUKSKeyslotAdd' },
              { 'delete': 'LUKSKeyslotDelete' } }

Since @secret occurs in all variants, we could also put it in @base
instead.  Matter of taste.  I think this way is clearer.  Lets us easily
add a variant that doesn't want @secret later on (although moving it
from @base to variants then would be possible).

Compare:

* Activate free keyslot to hold a secret

  { "new-secret": "CIA/GRU/MI6" }

  vs.

  { "active": true, "new-secret": "CIA/GRU/MI6" }

  vs.

  { "action": "add", "secret": "CIA/GRU/MI6" }

* Deactivate keyslots holding a secret

  { "old-secret": "CIA/GRU/MI6", "new-secret": null }

  vs.

  { "active": false, "old-secret": "CIA/GRU/MI6" }

  vs.

  { "action": "delete", "secret": "CIA/GRU/MI6" }

* Replace existing secret in-place (unsafe!)

  { "old-secret": "OSS/NKVD/MI6", "new-secret": "CIA/GRU/MI6" }

  vs.

  Can't do.

Now let's add support for the low-level operations.  To "write specific
slot" to "add", we add optional LUKSKeyslotAdd member @keyslot to direct
the write to that keyslot instead of the first free one:

    { 'struct': 'LUKSKeyslotAdd',
      'data': { 'secret': 'str',
                '*keyslot': 'int',
                '*iter-time': 'int' } }

To add "zap specific slot" to delete, we need to pass a slot number
instead of the old secret.  We could add member @keyslot, make both
optional, and require users to specify exactly one of them:

    { 'struct': 'LUKSKeyslotDelete',
      'data': { '*secret': 'str',       # must pass either @secret
                '*keyslot': 'int' } }   # or @keyslot

Or we use an alternate:

    { 'alternate': 'LUKSKeyslotMatch',
      'data': { 'secret': 'str',
                'keyslot': 'int' } }
    { 'struct': 'LUKSKeyslotDelete',
      'data': { 'match': 'LUKSKeyslotMatch' } }

Hmm, that gets us into trouble with dotted keys, because match=3D1 could
be keyslot#1 or the (truly bad) secret "1".  Nevermind.

Or we add a separate "zap" action:

    { state: 'LUKSKeyslotUpdateAction',
      'data': [ 'add', 'delete', 'zap' ] }
    { 'struct': 'LUKSKeyslotZap',
      'data': { 'keyslot': 'int' } }
    { 'union: 'LUKSKeyslotUpdate',
      'base': { 'action': 'LUKSKeyslotUpdateAction' }
      'discriminator': 'action',
      'data': { 'add': 'LUKSKeyslotAdd' },
              { 'delete': 'LUKSKeyslotDelete' },
              { 'zap': 'LUKSKeyslotZap' } }

Compare:

* Write to keyslot#1

  { "new-secret": "CIA/GRU/MI6", "keyslot": 1 }

  vs.

  { "active": true, "new-secret": "CIA/GRU/MI6", "keyslot": 1 }

  vs.

  { "action": "add", "secret": "CIA/GRU/MI6", "keyslot": 1 }

* Zap keyslot#1

  { "keyslot": 1, "new-secret": null }

  vs.

  { "active": false, "keyslot": 1 }

  vs.

  { "action": "delete", "keyslot": 1 }

  vs.

  { "action": "zap", "keyslot": 1 }


