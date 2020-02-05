Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0078DC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22772051A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aV2xGNpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22772051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHXa-0003hu-Sl
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izHWq-0003BD-RX
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izHWo-00056p-J2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:03:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55960
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izHWo-0004wD-4S
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580897004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUU97/UpNXetFVDKJUuEd9jNZw5vmrXzjuYQAUGm0d0=;
 b=aV2xGNpAUZWrxwWRh29mDp1Y011hXWH0ep7yyMf9u+4/52lZ4Y7HFX9yPfsD2HNWl5iaB+
 CMrta3hQGmAijhRw6cvZn4UHEiucACt2/j5Epa1W6tA/rW/qyR+WnZgmTPtODyAsTUxKHT
 633JILA12fsTsUSRmBC2bhFCG3VKzvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-rK2jtPkoP9qaXXdLcUAMCg-1; Wed, 05 Feb 2020 05:03:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86A07DB22;
 Wed,  5 Feb 2020 10:03:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA0C45C1B5;
 Wed,  5 Feb 2020 10:03:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 62CD411386A7; Wed,  5 Feb 2020 11:03:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
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
 <20200205093011.GA5768@dhcp-200-226.str.redhat.com>
Date: Wed, 05 Feb 2020 11:03:17 +0100
In-Reply-To: <20200205093011.GA5768@dhcp-200-226.str.redhat.com> (Kevin Wolf's
 message of "Wed, 5 Feb 2020 10:30:11 +0100")
Message-ID: <87tv45wdui.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: rK2jtPkoP9qaXXdLcUAMCg-1
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
Cc: "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 05.02.2020 um 09:24 hat Markus Armbruster geschrieben:
>> Daniel, Kevin, any comments or objections to the QAPI schema design
>> sketch developed below?
>>=20
>> For your convenience, here's the result again:
>>=20
>>     { 'enum': 'LUKSKeyslotState',
>>       'data': [ 'active', 'inactive' ] }
>>     { 'struct': 'LUKSKeyslotActive',
>>       'data': { 'secret': 'str',
>>                 '*iter-time': 'int } }
>>     { 'union': 'LUKSKeyslotAmend',
>>       'base': { '*keyslot': 'int',
>>                 'state': 'LUKSKeyslotState' }
>>       'discriminator': 'state',
>>       'data': { 'active': 'LUKSKeyslotActive' } }
>
> I think one of the requirements was that you can specify the keyslot not
> only by using its number, but also by specifying the old secret.

Quoting myself:

  When we don't specify the slot#, then "new state active" selects an
  inactive slot (chosen by the system, and "new state inactive selects
  slots by secret (commonly just one slot).

This takes care of selecting (active) slots by old secret with "new
state inactive".

I intentionally did not provide for selecting (active) slots by old
secret with "new state active", because that's unsafe update in place.

We want to update secrets, of course.  But the safe way to do that is to
put the new secret into a free slot, and if that succeeds, deactivate
the old secret.  If deactivation fails, you're left with both old and
new secret, which beats being left with no secret when update in place
fails.

>                                                                  Trivial
> extension, you just get another optional field that can be specified
> instead of 'keyslot'.
>
> Resulting commands:
>
>     Adding a key:
>     qemu-img amend -o encrypt.keys.0.state=3Dactive,encrypt.keys.0.secret=
=3Dsec0 test.qcow2

This activates an inactive slot chosen by the sysem.

You can activate a specific keyslot N by throwing in
encrypt.keys.0.keyslot=3DN.

>     Deleting a key:
>     qemu-img amend -o encrypt.keys.0.state=3Dinactive,encrypt.keys.0.keys=
lot=3D2 test.qcow2

This deactivates keyslot#2.

You can deactivate slots holding a specific secret S by replacing
encrypt.keys.0.keyslot=3D2 by encrypt.keys.0.secret=3DS.

> Previous version (if this series is applied unchanged):
>
>     Adding a key:
>     qemu-img amend -o encrypt.keys.0.new-secret=3Dsec0 test.qcow2
>
>     Deleting a key:
>     qemu-img amend -o encrypt.keys.0.new-secret=3D,encrypt.keys.0.keyslot=
=3D2 test.qcow2
>
> Adding a key gets more complicated with your proposed interface because
> state must be set explicitly now whereas before it was derived
> automatically from the fact that if you give a key, only active makes
> sense.

The explicitness could be viewed as an improvement :)

If you'd prefer implicit here: Max has patches for making union tags
optional with a default.  They'd let you default active to true.

> Deleting stays more or less the same, you just change the state instead
> of clearing the secret.

Thanks for your input!


