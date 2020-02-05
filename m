Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A250C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2565220702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgzhnXBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2565220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLjT-0002fT-5x
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izLiF-0001Cl-ER
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izLiE-0002Jx-5F
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:31:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43901
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izLiE-0002Ia-1H
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580913089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3fd6swylaSuaByFBWf2JM6MkThvg4ex7Ki8CLOvkgE=;
 b=KgzhnXBDHw63UCpR356urrLMYIL9smGkNScjwUYlg68e+v2PJKxN3XFjqPlNMqkXiSNQrf
 AlZmVTJdVHJalL2WbBZ30ZWeN+Vbzi/Y935TYZ0xQJYAQZvqnnS2/3Q0I2J55835B5lrEE
 EKkAtfzi+ueSVynX0hrVDAKmsCgJZY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-B1J7H38zPESLhweoZJF99g-1; Wed, 05 Feb 2020 09:31:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3D9818A6ECB;
 Wed,  5 Feb 2020 14:31:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB847790DA;
 Wed,  5 Feb 2020 14:31:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A7DF11385EE; Wed,  5 Feb 2020 15:31:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
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
 <20200205102303.GB2221087@redhat.com>
Date: Wed, 05 Feb 2020 15:31:19 +0100
In-Reply-To: <20200205102303.GB2221087@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Wed, 5 Feb 2020 10:23:03 +0000")
Message-ID: <87a75xgl6w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: B1J7H38zPESLhweoZJF99g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Feb 05, 2020 at 10:30:11AM +0100, Kevin Wolf wrote:
>> Am 05.02.2020 um 09:24 hat Markus Armbruster geschrieben:
>> > Daniel, Kevin, any comments or objections to the QAPI schema design
>> > sketch developed below?
>> >=20
>> > For your convenience, here's the result again:
>> >=20
>> >     { 'enum': 'LUKSKeyslotState',
>> >       'data': [ 'active', 'inactive' ] }
>> >     { 'struct': 'LUKSKeyslotActive',
>> >       'data': { 'secret': 'str',
>> >                 '*iter-time': 'int } }
>> >     { 'union': 'LUKSKeyslotAmend',
>> >       'base': { '*keyslot': 'int',
>> >                 'state': 'LUKSKeyslotState' }
>> >       'discriminator': 'state',
>> >       'data': { 'active': 'LUKSKeyslotActive' } }
>
> We need 'secret' in the 'inactive' case too

Yes, my mistake.

>> I think one of the requirements was that you can specify the keyslot not
>> only by using its number, but also by specifying the old secret. Trivial
>> extension, you just get another optional field that can be specified
>> instead of 'keyslot'.
>>=20
>> Resulting commands:
>>=20
>>     Adding a key:
>>     qemu-img amend -o encrypt.keys.0.state=3Dactive,encrypt.keys.0.secre=
t=3Dsec0 test.qcow2
>>=20
>>     Deleting a key:
>>     qemu-img amend -o encrypt.keys.0.state=3Dinactive,encrypt.keys.0.key=
slot=3D2 test.qcow2
>
> I think this is good as a design.
>
> Expanding the examples to cover all scenarios we've discussed
>
>
>   - Activating a new keyslot, auto-picking slot
>
>      qemu-img amend -o encrypt.keys.0.state=3Dactive,\
>                        encrypt.keys.0.secret=3Dsec0 \
> =09=09    test.qcow2
>
>     Must raise an error if no free slots
>
>
>   - Activating a new keyslot, picking a specific slot
>
>      qemu-img amend -o encrypt.keys.0.state=3Dactive,\
>                        encrypt.keys.0.secret=3Dsec0 \
> =09=09       encrypt.keys.0.keyslot=3D3 \
> =09=09    test.qcow2
>
>     Must raise an error if slot is already active

From the "describe desired state" point of view:

* Always suceeds when slot is inactive

* No-op when active and its secret is already the desired secret

* Must raise "in place update refused" error otherwise

>   - Deactivating a old keyslot, auto-picking slot(s) from existing passwo=
rd
>
>      qemu-img amend -o encrypt.keys.0.state=3Dinactive,\
>                        encrypt.keys.0.secret=3Dsec0 \
> =09=09    test.qcow2
>
>     Must raise an error if this would leave zero keyslots
>     after processing.
>
>
>   - Deactivating a old keyslot, picking a specific slot
>
>      qemu-img amend -o encrypt.keys.0.state=3Dinactive,\
>                        encrypt.keys.0.keyslot=3D2 \
> =09=09    test.qcow2
>
>     Always succeeds even if zero keyslots left.

This one's dangerous.

Here's a variation: permit operations that may or will lose data only
with 'force': true.

When @keyslot is absent, using force has no effect.

When @keyslot is present, using force permits update in place and
deactivating the last slot.


