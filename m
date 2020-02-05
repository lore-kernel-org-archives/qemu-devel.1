Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C6AC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E94020661
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSXmk02T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E94020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izH2a-000868-9x
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izH0v-0007KL-5W
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izH0q-0006XR-2x
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:30:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54023
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izH0p-0006B4-Oa
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580895021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+9s4EJpN3zuiNGb+emK201J7sNdD6Zh0aLNzoL5bBY=;
 b=MSXmk02TrtA6xAlPxeRCGaOCQgN8v+XHfz6chXWSM8zQo+FwkE/zd0Bogq6AihTDhfVHi2
 bxaKVnimTjkJopCMXc9gjvRNyOP2EwuG6bneQEpr2xLSv5eg0PnTslovVFEztV21ZjT4xH
 a2tyUPAMtsMN5Qd7rxmeFg4vZBSPS6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-nF-LUT5INse15w0K2Dto4A-1; Wed, 05 Feb 2020 04:30:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 491E88010E6;
 Wed,  5 Feb 2020 09:30:17 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3068687B1B;
 Wed,  5 Feb 2020 09:30:13 +0000 (UTC)
Date: Wed, 5 Feb 2020 10:30:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
Message-ID: <20200205093011.GA5768@dhcp-200-226.str.redhat.com>
References: <87r1zti6r8.fsf@dusky.pond.sub.org>
 <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
 <20200128171116.GU1446339@redhat.com>
 <20200128173251.GZ1446339@redhat.com>
 <20200130123847.GE6438@linux.fritz.box>
 <20200130125319.GD1891831@redhat.com>
 <87zhe5ovbv.fsf@dusky.pond.sub.org>
 <20200130150108.GM1891831@redhat.com>
 <877e18oq76.fsf@dusky.pond.sub.org>
 <87mu9xxwzv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87mu9xxwzv.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nF-LUT5INse15w0K2Dto4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.02.2020 um 09:24 hat Markus Armbruster geschrieben:
> Daniel, Kevin, any comments or objections to the QAPI schema design
> sketch developed below?
>=20
> For your convenience, here's the result again:
>=20
>     { 'enum': 'LUKSKeyslotState',
>       'data': [ 'active', 'inactive' ] }
>     { 'struct': 'LUKSKeyslotActive',
>       'data': { 'secret': 'str',
>                 '*iter-time': 'int } }
>     { 'union': 'LUKSKeyslotAmend',
>       'base': { '*keyslot': 'int',
>                 'state': 'LUKSKeyslotState' }
>       'discriminator': 'state',
>       'data': { 'active': 'LUKSKeyslotActive' } }

I think one of the requirements was that you can specify the keyslot not
only by using its number, but also by specifying the old secret. Trivial
extension, you just get another optional field that can be specified
instead of 'keyslot'.

Resulting commands:

    Adding a key:
    qemu-img amend -o encrypt.keys.0.state=3Dactive,encrypt.keys.0.secret=
=3Dsec0 test.qcow2

    Deleting a key:
    qemu-img amend -o encrypt.keys.0.state=3Dinactive,encrypt.keys.0.keyslo=
t=3D2 test.qcow2

Previous version (if this series is applied unchanged):

    Adding a key:
    qemu-img amend -o encrypt.keys.0.new-secret=3Dsec0 test.qcow2

    Deleting a key:
    qemu-img amend -o encrypt.keys.0.new-secret=3D,encrypt.keys.0.keyslot=
=3D2 test.qcow2

Adding a key gets more complicated with your proposed interface because
state must be set explicitly now whereas before it was derived
automatically from the fact that if you give a key, only active makes
sense.

Deleting stays more or less the same, you just change the state instead
of clearing the secret.

Kevin

> Markus Armbruster <armbru@redhat.com> writes:
>=20
> [...]
> > A keyslot can be either inactive or active.
> >
> > Let's start low-level, i.e. we specify the slot by slot#:
> >
> >     state       new state   action
> >     inactive    inactive    nop
> >     inactive    active      put secret, iter-time, mark active
> >     active      inactive    mark inactive (effectively deletes secret)
> >     active      active      in general, error (unsafe update in place)
> >                             we can make it a nop when secret, iter-time
> >                                 remain unchanged
> >                             we can allow unsafe update with force: true
> >
> > As struct:
> >
> >     { 'struct': 'LUKSKeyslotUpdate',
> >       'data': { 'active': 'bool',       # could do enum instead
> >                 'keyslot': 'int',
> >                 '*secret': 'str',       # present if @active is true
> >                 '*iter-time': 'int' } } # absent if @active is false
> >
> > As union:
> >
> >     { 'enum': 'LUKSKeyslotState',
> >       'data': [ 'active', 'inactive' ] }
> >     { 'struct': 'LUKSKeyslotActive',
> >       'data': { 'secret': 'str',
> >                 '*iter-time': 'int } }
> >     { 'union': 'LUKSKeyslotAmend',
> >       'base': { 'state': 'LUKSKeyslotState' }   # must do enum
> >       'discriminator': 'state',
> >       'data': { 'active': 'LUKSKeyslotActive' } }
> >
> > When we don't specify the slot#, then "new state active" selects an
> > inactive slot (chosen by the system, and "new state inactive selects
> > slots by secret (commonly just one slot).
> >
> > New state active:
> >
> >     state       new state   action
> >     inactive    active      put secret, iter-time, mark active
> >     active      active      N/A (system choses inactive slot)
> >
> > New state inactive, for each slot holding the specified secret:
> >
> >     state       new state   action
> >     inactive    inactive    N/A (inactive slot holds no secret)
> >     active      inactive    mark inactive (effectively deletes secret)
> >
> > As struct:
> >
> >     { 'struct': 'LUKSKeyslotUpdate',
> >       'data': { 'active': 'bool',       # could do enum instead
> >                 '*keyslot': 'int',
> >                 '*secret': 'str',       # present if @active is true
> >                 '*iter-time': 'int' } } # absent if @active is false
> >
> > As union:
> >
> >     { 'enum': 'LUKSKeyslotState',
> >       'data': [ 'active', 'inactive' ] }
> >     { 'struct': 'LUKSKeyslotActive',
> >       'data': { 'secret': 'str',
> >                 '*iter-time': 'int } }
> >     { 'union': 'LUKSKeyslotAmend',
> >       'base': { '*keyslot': 'int',
> >                 'state': 'LUKSKeyslotState' }
> >       'discriminator': 'state',
> >       'data': { 'active': 'LUKSKeyslotActive' } }
> >
> > Union looks more complicated because our union notation sucks[*].  I
> > like it anyway, because you don't have to explain when which optional
> > members aren't actually optional.
> >
> > Regardless of struct vs. union, this supports an active -> active
> > transition only with an explicit keyslot.  Feels fine to me.  If we wan=
t
> > to support it without keyslot as well, we need a way to specify both ol=
d
> > and new secret.  Do we?
> >
> >
> > [*] I hope to fix that one day.  It's not even hard.


