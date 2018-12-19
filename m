Received: from eggs.gnu.org ([2001:4830:134:3::10]:36796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZXfq-0003zs-6a
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZXfn-0001F9-1I
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:57:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZXfm-0001Eh-PR
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:57:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
	<CAJ+F1CLo4YRnGWHsyoUWDrPU1X2z-5+eDmdGsw-zp7ihTpD_+Q@mail.gmail.com>
Date: Wed, 19 Dec 2018 09:57:44 +0100
In-Reply-To: <CAJ+F1CLo4YRnGWHsyoUWDrPU1X2z-5+eDmdGsw-zp7ihTpD_+Q@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 19 Dec 2018
	00:35:07 +0400")
Message-ID: <87d0pxnbav.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/15] qapi: add #if pre-processor
 conditions to generated code (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Dec 18, 2018 at 10:26 PM Markus Armbruster <armbru@redhat.com> wr=
ote:
>>
>> Marc-Andr=C3=A9 posted v1 that relies on a QAPI schema language extension
>> 'top-unit' to permit splitting the generated code.  Here is his cover
>> letter:
>>
>>     The thrid and last part (of "[PATCH v2 00/54] qapi: add #if
>>     pre-processor conditions to generated code") is about adding schema
>>     conditions based on the target.
>>
>>     For now, the qapi code is compiled in common objects (common to all
>>     targets). This makes it impossible to add #if TARGET_ARM for example.
>>
>>     The patch "RFC: qapi: learn to split the schema by 'top-unit'"
>>     proposes to split the schema by "top-unit", so that generated code c=
an
>>     be built either in common objects or per-target. That patch is a bit
>>     rough, I would like to get some feedback about the approach before
>>     trying to improve it. The following patches demonstrate usage of
>>     target-based #if conditions, and getting rid of the
>>     qmp_unregister_command() hack.
>>
>> We already have a way to split generated code: QAPI modules.  I took
>> the liberty to rework Marc-Andr=C3=A9's series to use a target module
>> instead.  Less code, no change to the QAPI language.
>>
>> One of the patches (marked WIP) is a total hack.  Fixable, but I want
>> to get this out for discussion first.
>
> The approach you propose includes -target.h header in the top headers,
> effectively making all the qapi code target-dependent, no?

Yes, but...

> I am actually a bit surprised there are no poisoined define errors.
> Possibly because the top-level header is rarely included.

... next to nothing includes the top-level header:

    $ git-grep -E 'include.*"(qapi/)?qapi-[^-]*.h'
    monitor.c:#include "qapi/qapi-commands.h"

Here we actually need all commands, complete with their
target-dependence.

    monitor.c:#include "qapi/qapi-introspect.h"
    tests/test-qobject-input-visitor.c:#include "qapi/qapi-introspect.h"

qapi-introspect.[ch] are monolithic.

    ui/cocoa.m:#include "qapi/qapi-commands.h"

This is just lazy; we should include just the qapi-commands-FOO we
actually need.  I'll ask the maintainer for help with cleaning this up.

Including top-level headers has been a bad idea ever since we generate
modular headers (commit 252dc3105fc), because it leads to "touch the
QAPI schema, have some coffee while the world is recompiled".

Adding target-dependent conditionals makes this bad idea impractical in
target-independent code.  Feature!

> By contrast, my approach has the advantage of a clean split between
> target and non-target dependent code, which I would feel more
> confident about.
>
> That's the reason why I promptly discarded the QAPI modules approach
> without having second thoughts at least. Now you force me to
> reconsider it though.

Please do :)
