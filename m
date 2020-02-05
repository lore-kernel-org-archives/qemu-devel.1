Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868BAC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531322082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8dKy/uW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531322082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHqn-0006Zl-IF
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1izHq3-000618-1e
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1izHq0-0003jU-Hy
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:23:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32673
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1izHq0-0003gI-1n
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580898195;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dVhwus6S2PTnVZKT52fwWTm15OdLxme8N2uexTTkr/Q=;
 b=V8dKy/uWTr6lV/kWK7Bhb7DIL5xmxDcS24lzZwhqZnJJH92v6ukVZGiiOolS9cdyo7V/BH
 RK1sH29eeeCm40yOln+l5+t5UNDfpaCwe66xYlRAx+rrzMeQ+6VEQGZTFOxuoRuZZbJ5Lv
 6OdYhgpbGsGr9phEO8ecJwxH6KKREeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-grQdM6G1PpmoU4iX4rSRew-1; Wed, 05 Feb 2020 05:23:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA84E14EA;
 Wed,  5 Feb 2020 10:23:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75B855DA2C;
 Wed,  5 Feb 2020 10:23:05 +0000 (UTC)
Date: Wed, 5 Feb 2020 10:23:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
Message-ID: <20200205102303.GB2221087@redhat.com>
References: <dc902f2ba314b63da7ae7a003463f9268e7b3535.camel@redhat.com>
 <20200128171116.GU1446339@redhat.com>
 <20200128173251.GZ1446339@redhat.com>
 <20200130123847.GE6438@linux.fritz.box>
 <20200130125319.GD1891831@redhat.com>
 <87zhe5ovbv.fsf@dusky.pond.sub.org>
 <20200130150108.GM1891831@redhat.com>
 <877e18oq76.fsf@dusky.pond.sub.org>
 <87mu9xxwzv.fsf@dusky.pond.sub.org>
 <20200205093011.GA5768@dhcp-200-226.str.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205093011.GA5768@dhcp-200-226.str.redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: grQdM6G1PpmoU4iX4rSRew-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 10:30:11AM +0100, Kevin Wolf wrote:
> Am 05.02.2020 um 09:24 hat Markus Armbruster geschrieben:
> > Daniel, Kevin, any comments or objections to the QAPI schema design
> > sketch developed below?
> >=20
> > For your convenience, here's the result again:
> >=20
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

We need 'secret' in the 'inactive' case too

>=20
> I think one of the requirements was that you can specify the keyslot not
> only by using its number, but also by specifying the old secret. Trivial
> extension, you just get another optional field that can be specified
> instead of 'keyslot'.
>=20
> Resulting commands:
>=20
>     Adding a key:
>     qemu-img amend -o encrypt.keys.0.state=3Dactive,encrypt.keys.0.secret=
=3Dsec0 test.qcow2
>=20
>     Deleting a key:
>     qemu-img amend -o encrypt.keys.0.state=3Dinactive,encrypt.keys.0.keys=
lot=3D2 test.qcow2

I think this is good as a design.

Expanding the examples to cover all scenarios we've discussed


  - Activating a new keyslot, auto-picking slot

     qemu-img amend -o encrypt.keys.0.state=3Dactive,\
                       encrypt.keys.0.secret=3Dsec0 \
=09=09    test.qcow2

    Must raise an error if no free slots


  - Activating a new keyslot, picking a specific slot

     qemu-img amend -o encrypt.keys.0.state=3Dactive,\
                       encrypt.keys.0.secret=3Dsec0 \
=09=09       encrypt.keys.0.keyslot=3D3 \
=09=09    test.qcow2

    Must raise an error if slot is already active


  - Deactivating a old keyslot, auto-picking slot(s) from existing password

     qemu-img amend -o encrypt.keys.0.state=3Dinactive,\
                       encrypt.keys.0.secret=3Dsec0 \
=09=09    test.qcow2

    Must raise an error if this would leave zero keyslots
    after processing.


  - Deactivating a old keyslot, picking a specific slot

     qemu-img amend -o encrypt.keys.0.state=3Dinactive,\
                       encrypt.keys.0.keyslot=3D2 \
=09=09    test.qcow2

    Always succeeds even if zero keyslots left.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


