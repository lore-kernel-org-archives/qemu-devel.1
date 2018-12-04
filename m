Received: from eggs.gnu.org ([2001:4830:134:3::10]:36906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUDit-0002ap-BX
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUDhU-0006PF-MJ
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:37:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUDhU-0006O0-GW
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:37:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E012811DB
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 16:37:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-6-marcandre.lureau@redhat.com>
	<877egpwc1z.fsf@dusky.pond.sub.org>
	<CAMxuvaxCAXHDXvDSH9rsWxU12CLGmVpCJD+M_bWFuMUMJx8ZQg@mail.gmail.com>
Date: Tue, 04 Dec 2018 17:37:25 +0100
In-Reply-To: <CAMxuvaxCAXHDXvDSH9rsWxU12CLGmVpCJD+M_bWFuMUMJx8ZQg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 4 Dec 2018
	19:32:52 +0400")
Message-ID: <87o9a1uu2i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Tue, Dec 4, 2018 at 7:23 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Now that the schema can be configured, it is crucial that all types
>> > are configured the same. Make sure config-host.h is included, so
>> > build-sys tracks the dependency and rebuilds the types, by including
>> > osdep.h first.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  scripts/qapi/types.py | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
>> > index fd7808103c..91f87d0b8f 100644
>> > --- a/scripts/qapi/types.py
>> > +++ b/scripts/qapi/types.py
>> > @@ -201,6 +201,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCV=
isitor):
>> >  ''',
>> >                                        types=3Dtypes, visit=3Dvisit))
>> >          self._genh.preamble_add(mcgen('''
>> > +#include "qemu/osdep.h"
>> >  #include "qapi/qapi-builtin-types.h"
>> >  '''))
>>
>> No.  Every .c must include qemu/osdep.h first.  No .h may include it.
>> We clean this up periodically.  scripts/clean-includes can help with
>> that.  We currently have a few offenders in the tree.
>
> Ok, I don't know the reason an internal header couldn't include osdep,
> could you explain?
>
> I think we can replace osdep.h by config-host.h for the same result,
> I'd have to check.

Quote ./HACKING:

1.2. Include directives

Order include directives as follows:

#include "qemu/osdep.h"  /* Always first... */
#include <...>           /* then system headers... */
#include "..."           /* and finally QEMU headers. */

The "qemu/osdep.h" header contains preprocessor macros that affect the beha=
vior
of core system headers like <stdint.h>.  It must be the first include so th=
at
core system headers included by external libraries get the preprocessor mac=
ros
that QEMU depends on.

Do not include "qemu/osdep.h" from header files since the .c file will have
already included it.
