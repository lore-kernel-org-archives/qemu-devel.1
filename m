Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90953C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9C020702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtZGsvQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9C020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLjV-0002kf-FI
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izLiD-00019N-DB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izLi8-00028Y-3I
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:31:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24349
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izLi7-00027B-Uq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580913082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PWFN8CtTcf18hNpsIW+5COQ6Y9KIffcUcXgL48l6AnA=;
 b=KtZGsvQhDk8IQhnIar5h3L9qL35KxpC45CnN4njU87HTkp0lYJrS/e4eQF/EApbbuDrf4W
 hpr255QXCdFGfKFEM1+VbXJuPwTSjcbptdb91rgrcLQAcLvcHzBAvWQbzqdG/9fkmDAOMs
 e5jIkenJEXMWz0V8tpihTKUDQTrbcTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-H9sjw2ICPHWP-Xe-_3Oh2w-1; Wed, 05 Feb 2020 09:31:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD1498010F6;
 Wed,  5 Feb 2020 14:31:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8F8719C7F;
 Wed,  5 Feb 2020 14:31:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6132711386A7; Wed,  5 Feb 2020 15:31:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
References: <20200128171116.GU1446339@redhat.com>
 <20200128173251.GZ1446339@redhat.com>
 <20200130123847.GE6438@linux.fritz.box>
 <20200130125319.GD1891831@redhat.com>
 <87zhe5ovbv.fsf@dusky.pond.sub.org>
 <20200130150108.GM1891831@redhat.com>
 <877e18oq76.fsf@dusky.pond.sub.org>
 <87mu9xxwzv.fsf@dusky.pond.sub.org>
 <20200205093011.GA5768@dhcp-200-226.str.redhat.com>
 <87tv45wdui.fsf@dusky.pond.sub.org>
 <20200205110250.GB5768@dhcp-200-226.str.redhat.com>
Date: Wed, 05 Feb 2020 15:31:15 +0100
In-Reply-To: <20200205110250.GB5768@dhcp-200-226.str.redhat.com> (Kevin Wolf's
 message of "Wed, 5 Feb 2020 12:02:50 +0100")
Message-ID: <87blqdgl70.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: H9sjw2ICPHWP-Xe-_3Oh2w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 05.02.2020 um 11:03 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 05.02.2020 um 09:24 hat Markus Armbruster geschrieben:
>> >> Daniel, Kevin, any comments or objections to the QAPI schema design
>> >> sketch developed below?
>> >>=20
>> >> For your convenience, here's the result again:
>> >>=20
>> >>     { 'enum': 'LUKSKeyslotState',
>> >>       'data': [ 'active', 'inactive' ] }
>> >>     { 'struct': 'LUKSKeyslotActive',
>> >>       'data': { 'secret': 'str',
>> >>                 '*iter-time': 'int } }
>> >>     { 'union': 'LUKSKeyslotAmend',
>> >>       'base': { '*keyslot': 'int',
>> >>                 'state': 'LUKSKeyslotState' }
>> >>       'discriminator': 'state',
>> >>       'data': { 'active': 'LUKSKeyslotActive' } }
>> >
>> > I think one of the requirements was that you can specify the keyslot n=
ot
>> > only by using its number, but also by specifying the old secret.
>>=20
>> Quoting myself:
>>=20
>>   When we don't specify the slot#, then "new state active" selects an
>>   inactive slot (chosen by the system, and "new state inactive selects
>>   slots by secret (commonly just one slot).
>>=20
>> This takes care of selecting (active) slots by old secret with "new
>> state inactive".
>
> "new secret inactive" can't select a slot by secret because 'secret'
> doesn't even exist for inactive.

My mistake.  My text leading up to my schema has it, but the schema
itself doesn't.  Obvious fix:

As struct:

    { 'struct': 'LUKSKeyslotUpdate',
      'data': { 'active': 'bool',       # could do enum instead
                '*keyslot': 'int',
                '*secret': 'str',       # present if @active is true
                                        #   or @keyslot is absent
                '*iter-time': 'int' } } # absent if @active is false

As union:

    { 'enum': 'LUKSKeyslotState',
      'data': [ 'active', 'inactive' ] }
    { 'struct': 'LUKSKeyslotActive',
      'data': { 'secret': 'str',
                '*iter-time': 'int } }
    { 'struct': 'LUKSKeyslotInactive',
      'data': { '*secret': 'str' } }    # either @secret or @keyslot presen=
t
                                        # might want to name this @old-secr=
et
    { 'union': 'LUKSKeyslotAmend',
      'base': { '*keyslot': 'int',
                'state': 'LUKSKeyslotState' }
      'discriminator': 'state',
      'data': { 'active': 'LUKSKeyslotActive',
                'inactive': 'LUKSKeyslotInactive' } }

The "deactivate secret" operation needs a bit of force to fit into the
amend interface's "describe desired state" mold: the desired state is
(state=3Dinactive, secret=3DS).  In other words, the inactive slot keeps it=
s
secret, you just can't use it for anything.

Sadly, even with a union, we now have optional members that aren't
really optional: "either @secret or @keyslot present".  To avoid that,
we'd have to come up with sane semantics for "neither" and "both".  Let
me try.

The basic idea is to have @keyslot and @secret each select a set of
slots, and take the intersection.

If @keyslot is present: { @keyslot }
               absent: all slots
If @secret is present: the set of slots holding @secret
              absent: all slots

Neither present: select all slots.
Both present: slot @keyslot if it holds @secret, else no slots

The ability to specify @keyslot and @secret might actually be
appreciated by some users.  Belt *and* suspenders.

Selecting no slots could be a no-op or an error.  As a user, I don't
care as long as I can tell what the command actually changed.

Selecting all slots is an error because deactivating the last slot is.
No different from selecting all slots with a particular secret when no
active slots with different secrets exist.

I'm not sure this is much of an improvement.

>> I intentionally did not provide for selecting (active) slots by old
>> secret with "new state active", because that's unsafe update in place.
>>=20
>> We want to update secrets, of course.  But the safe way to do that is to
>> put the new secret into a free slot, and if that succeeds, deactivate
>> the old secret.  If deactivation fails, you're left with both old and
>> new secret, which beats being left with no secret when update in place
>> fails.
>
> Right. I wonder if qemu-img wants support for that specifically
> (possibly with allowing to enter the key interactively) rather than
> requiring the user to call qemu-img amend twice.

Human users may well appreciate such a "replace secret" operation.  As
so often with high-level operations, the difficulty is its failure
modes:

* Activation fails: no change (old secret still active)

* Deactivate fails: both secrets are active

Humans should be able to deal with both failure modes, provided the
error reporting is sane.

If I'd have to program a machine, however, I'd rather use the primitive
operations, because each either succeeds completely or fails completely,
which means I don't have to figure out *how* something failed.

Note that such a high-level "replace secret" doesn't quite fit into the
amend interface's "describe desired state" mold: the old secret is not
part of the desired state.

>> >                                                                  Trivi=
al
>> > extension, you just get another optional field that can be specified
>> > instead of 'keyslot'.
>> >
>> > Resulting commands:
>> >
>> >     Adding a key:
>> >     qemu-img amend -o encrypt.keys.0.state=3Dactive,encrypt.keys.0.sec=
ret=3Dsec0 test.qcow2
>>=20
>> This activates an inactive slot chosen by the sysem.
>>=20
>> You can activate a specific keyslot N by throwing in
>> encrypt.keys.0.keyslot=3DN.
>
> Yes. The usual case is that you just want to add a new key somwhere.

Sure.

>> >     Deleting a key:
>> >     qemu-img amend -o encrypt.keys.0.state=3Dinactive,encrypt.keys.0.k=
eyslot=3D2 test.qcow2
>>=20
>> This deactivates keyslot#2.
>>=20
>> You can deactivate slots holding a specific secret S by replacing
>> encrypt.keys.0.keyslot=3D2 by encrypt.keys.0.secret=3DS.
>
> Not with your definition above, but with the appropriate changes, this
> makes sense.

Appropriately corrected, I hope.

>> > Previous version (if this series is applied unchanged):
>> >
>> >     Adding a key:
>> >     qemu-img amend -o encrypt.keys.0.new-secret=3Dsec0 test.qcow2
>> >
>> >     Deleting a key:
>> >     qemu-img amend -o encrypt.keys.0.new-secret=3D,encrypt.keys.0.keys=
lot=3D2 test.qcow2
>> >
>> > Adding a key gets more complicated with your proposed interface becaus=
e
>> > state must be set explicitly now whereas before it was derived
>> > automatically from the fact that if you give a key, only active makes
>> > sense.
>>=20
>> The explicitness could be viewed as an improvement :)
>
> Not really. I mean, I really know to appreciate the advantages of
> -blockdev where needed, but usually I don't want to type all that stuff
> for the most common tasks. qemu-img amend is similar.
>
> For deleting, I might actually agree that explicitness is an
> improvement, but for creating it's just unnecessary verbosity.
>
>> If you'd prefer implicit here: Max has patches for making union tags
>> optional with a default.  They'd let you default active to true.
>
> I guess this would improve the usability in this case.
>
> Kevin


