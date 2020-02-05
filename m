Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98574C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622C120674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xn0nXOz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622C120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izITz-0005Jj-GR
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izISV-0003eQ-5Z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izIST-0000D1-BU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:03:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izIST-00009a-5R
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580900580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OVuAzJAhuAFKivRROuy2Tyt9JRqx9UEUFCROLUmtXkM=;
 b=Xn0nXOz/Do2cq9J//vr+cf9+b0EUY6N8verHWWxu/Xir2/LYXAyAi7IQFgXn7rfx5icxNj
 YMUSETKe86HvOuMY22hyBQ2R5MOjCUbnE8ZKz79sEKMPBT4yEbQmvuWjicUaeFgIksa3D2
 ebu6nl+VLg1LEeMRxiGk3NOPfIuus4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-_oKoZvf6OUiKKrradIwmWg-1; Wed, 05 Feb 2020 06:02:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 374768C86D0;
 Wed,  5 Feb 2020 11:02:56 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D23D857BA;
 Wed,  5 Feb 2020 11:02:52 +0000 (UTC)
Date: Wed, 5 Feb 2020 12:02:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
Message-ID: <20200205110250.GB5768@dhcp-200-226.str.redhat.com>
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
MIME-Version: 1.0
In-Reply-To: <87tv45wdui.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _oKoZvf6OUiKKrradIwmWg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.02.2020 um 11:03 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 05.02.2020 um 09:24 hat Markus Armbruster geschrieben:
> >> Daniel, Kevin, any comments or objections to the QAPI schema design
> >> sketch developed below?
> >>=20
> >> For your convenience, here's the result again:
> >>=20
> >>     { 'enum': 'LUKSKeyslotState',
> >>       'data': [ 'active', 'inactive' ] }
> >>     { 'struct': 'LUKSKeyslotActive',
> >>       'data': { 'secret': 'str',
> >>                 '*iter-time': 'int } }
> >>     { 'union': 'LUKSKeyslotAmend',
> >>       'base': { '*keyslot': 'int',
> >>                 'state': 'LUKSKeyslotState' }
> >>       'discriminator': 'state',
> >>       'data': { 'active': 'LUKSKeyslotActive' } }
> >
> > I think one of the requirements was that you can specify the keyslot no=
t
> > only by using its number, but also by specifying the old secret.
>=20
> Quoting myself:
>=20
>   When we don't specify the slot#, then "new state active" selects an
>   inactive slot (chosen by the system, and "new state inactive selects
>   slots by secret (commonly just one slot).
>=20
> This takes care of selecting (active) slots by old secret with "new
> state inactive".

"new secret inactive" can't select a slot by secret because 'secret'
doesn't even exist for inactive.

> I intentionally did not provide for selecting (active) slots by old
> secret with "new state active", because that's unsafe update in place.
>=20
> We want to update secrets, of course.  But the safe way to do that is to
> put the new secret into a free slot, and if that succeeds, deactivate
> the old secret.  If deactivation fails, you're left with both old and
> new secret, which beats being left with no secret when update in place
> fails.

Right. I wonder if qemu-img wants support for that specifically
(possibly with allowing to enter the key interactively) rather than
requiring the user to call qemu-img amend twice.

> >                                                                  Trivia=
l
> > extension, you just get another optional field that can be specified
> > instead of 'keyslot'.
> >
> > Resulting commands:
> >
> >     Adding a key:
> >     qemu-img amend -o encrypt.keys.0.state=3Dactive,encrypt.keys.0.secr=
et=3Dsec0 test.qcow2
>=20
> This activates an inactive slot chosen by the sysem.
>=20
> You can activate a specific keyslot N by throwing in
> encrypt.keys.0.keyslot=3DN.

Yes. The usual case is that you just want to add a new key somwhere.

> >     Deleting a key:
> >     qemu-img amend -o encrypt.keys.0.state=3Dinactive,encrypt.keys.0.ke=
yslot=3D2 test.qcow2
>=20
> This deactivates keyslot#2.
>=20
> You can deactivate slots holding a specific secret S by replacing
> encrypt.keys.0.keyslot=3D2 by encrypt.keys.0.secret=3DS.

Not with your definition above, but with the appropriate changes, this
makes sense.

> > Previous version (if this series is applied unchanged):
> >
> >     Adding a key:
> >     qemu-img amend -o encrypt.keys.0.new-secret=3Dsec0 test.qcow2
> >
> >     Deleting a key:
> >     qemu-img amend -o encrypt.keys.0.new-secret=3D,encrypt.keys.0.keysl=
ot=3D2 test.qcow2
> >
> > Adding a key gets more complicated with your proposed interface because
> > state must be set explicitly now whereas before it was derived
> > automatically from the fact that if you give a key, only active makes
> > sense.
>=20
> The explicitness could be viewed as an improvement :)

Not really. I mean, I really know to appreciate the advantages of
-blockdev where needed, but usually I don't want to type all that stuff
for the most common tasks. qemu-img amend is similar.

For deleting, I might actually agree that explicitness is an
improvement, but for creating it's just unnecessary verbosity.

> If you'd prefer implicit here: Max has patches for making union tags
> optional with a default.  They'd let you default active to true.

I guess this would improve the usability in this case.

Kevin


