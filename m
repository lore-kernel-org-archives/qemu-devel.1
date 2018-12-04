Received: from eggs.gnu.org ([2001:4830:134:3::10]:37011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUDj0-0002mB-Ea
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUDb3-0000LP-QL
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:30:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gUDb3-0000Cv-JR
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:30:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 159F03082DDB
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 16:30:51 +0000 (UTC)
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-6-marcandre.lureau@redhat.com>
	<877egpwc1z.fsf@dusky.pond.sub.org>
	<CAMxuvaxCAXHDXvDSH9rsWxU12CLGmVpCJD+M_bWFuMUMJx8ZQg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <087549a9-a28e-0f3d-f710-8c2be0abfe69@redhat.com>
Date: Tue, 4 Dec 2018 10:30:45 -0600
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxCAXHDXvDSH9rsWxU12CLGmVpCJD+M_bWFuMUMJx8ZQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/27] qapi: include osdep.h in type
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 12/4/18 9:32 AM, Marc-Andr=C3=A9 Lureau wrote:

>>> +++ b/scripts/qapi/types.py
>>> @@ -201,6 +201,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularC=
Visitor):
>>>   ''',
>>>                                         types=3Dtypes, visit=3Dvisit)=
)
>>>           self._genh.preamble_add(mcgen('''
>>> +#include "qemu/osdep.h"
>>>   #include "qapi/qapi-builtin-types.h"
>>>   '''))
>>
>> No.  Every .c must include qemu/osdep.h first.  No .h may include it.
>> We clean this up periodically.  scripts/clean-includes can help with
>> that.  We currently have a few offenders in the tree.
>=20
> Ok, I don't know the reason an internal header couldn't include osdep,
> could you explain?

Per HACKING:

>> Do not include "qemu/osdep.h" from header files since the .c file will=
 have
>> already included it.


That is, if we follow the rule that every .c file included osdep.h=20
before anything else, then by the time any other internal .h is included=20
(necessarily second or later) from a .c, then osdep.h is already active,=20
so no .h needs to reproduce the effort that has already occurred.

>=20
> I think we can replace osdep.h by config-host.h for the same result,
> I'd have to check.

osdep.h includes config-host.h, so you don't need that either.

What are you really trying to accomplish by including a header from=20
another header?  And why isn't it already happening by our coding rule=20
that all .c files include osdep.h first?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
