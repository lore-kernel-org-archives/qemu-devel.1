Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6427C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 07:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6850C208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 07:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6850C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ8so-0005qH-5r
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 03:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hZ8qs-0005OI-Cm
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 02:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hZ8qr-0003xM-59
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 02:59:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hZ8qq-0003tF-Sh
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 02:59:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8BBC93079B9D;
 Fri,  7 Jun 2019 06:59:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FFC05B2F1;
 Fri,  7 Jun 2019 06:59:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 15C0211386A0; Fri,  7 Jun 2019 08:59:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <87woihi1wl.fsf@dusky.pond.sub.org>
 <20190524185344.GJ10764@habkost.net>
 <87r28k1g4q.fsf@dusky.pond.sub.org>
 <e5372760-7599-3155-44f7-dc704c9cbaa5@redhat.com>
Date: Fri, 07 Jun 2019 08:59:31 +0200
In-Reply-To: <e5372760-7599-3155-44f7-dc704c9cbaa5@redhat.com> (Paolo
 Bonzini's message of "Mon, 27 May 2019 12:03:50 +0200")
Message-ID: <875zphg9t8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 07 Jun 2019 06:59:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] qapi/misc.json is too big,
 let's bite off a few chunks
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 27/05/19 10:00, Markus Armbruster wrote:
>> As long as we don't have an active QOM maintainer[*], the benefit is
>> low.
>>=20
>>=20
>> [*] We need one.  I'm not volunteering.
>
> I think Daniel, Eduardo and I could count as de facto maintainer.  I
> guess I could maintain it if I get two partners in crime as reviewers.

Alright, we need two volunteers for the reviewer role, and one patch to
MAINTAINERS.

A mention in MAINTAINERS is the traditional punishment for good work, so
let's see who's been doing the work.  Aha:

    Eduardo Habkost
    Marc-Andr=C3=A9 Lureau
    Markus Armbruster
    Eric Blake
    Philippe Mathieu-Daud=C3=A9

Details appended.

QOM is not a particularly active subsystem now: 51 commits in two years.

We obviously need maintainers to review and merge patches.  The nominal
maintainer hasn't been doing that since 2015.  Git shows the following
top committers taking on / getting sucked into QOM:

    Markus Armbruster <armbru@redhat.com>
    Eduardo Habkost <ehabkost@redhat.com>
    Paolo Bonzini <pbonzini@redhat.com>
    Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Eric Blake <eblake@redhat.com>

We really need nominal maintainer(s) again.

Of course, *active* maintainers would be even better: I consider QOM
stuck in an unhappy place where much of its potential is still
potential.

But let's start small.  Volunteers for the reviewer role, please step
forward :)



The details I promised:

Output of "scripts/get_maintainer.pl --git --git-since=3D'2-years-ago' |
grep commit_signer" sorted by file size:

=3D qom/object.c =3D
"Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com> (commit_signer:20/36=
=3D56%)
Markus Armbruster <armbru@redhat.com> (commit_signer:15/36=3D42%)
Eric Blake <eblake@redhat.com> (commit_signer:14/36=3D39%)
Eduardo Habkost <ehabkost@redhat.com> (commit_signer:14/36=3D39%)
"Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> (commit_signer:9/36=3D25%)

=3D include/qom/object.h =3D
Eduardo Habkost <ehabkost@redhat.com> (commit_signer:9/18=3D50%)
"Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com> (commit_signer:8/18=
=3D44%)
Igor Mammedov <imammedo@redhat.com> (commit_signer:6/18=3D33%)
Markus Armbruster <armbru@redhat.com> (commit_signer:6/18=3D33%)
David Gibson <david@gibson.dropbear.id.au> (commit_signer:5/18=3D28%)

=3D include/qom/object_interfaces.h =3D
Eduardo Habkost <ehabkost@redhat.com> (commit_signer:8/5=3D100%)
Igor Mammedov <imammedo@redhat.com> (commit_signer:3/5=3D60%)
"Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com> (commit_signer:2/5=
=3D40%)
"Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> (commit_signer:2/5=3D40%)
Eric Blake <eblake@redhat.com> (commit_signer:1/5=3D20%)

=3D qom/object_interfaces.c =3D
Eric Blake <eblake@redhat.com> (commit_signer:9/12=3D75%)
"Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com> (commit_signer:7/12=
=3D58%)
Markus Armbruster <armbru@redhat.com> (commit_signer:7/12=3D58%)
Eduardo Habkost <ehabkost@redhat.com> (commit_signer:6/12=3D50%)
"Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> (commit_signer:4/12=3D33%)

=3D qom/qom-qobject.c =3D

=3D include/qom/qom-qobject.h =3D

=3D qom/trace-events =3D
Stefan Hajnoczi <stefanha@redhat.com> (commit_signer:2/2=3D100%)
"Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> (commit_signer:2/2=3D100%)
Markus Armbruster <armbru@redhat.com> (commit_signer:1/2=3D50%)
Michael Tokarev <mjt@tls.msk.ru> (commit_signer:1/2=3D50%)

=3D qom/Makefile.objs =3D

