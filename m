Received: from eggs.gnu.org ([2001:4830:134:3::10]:38799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWLmK-0006OE-ED
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWLbv-00023D-IE
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:28:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWLbv-00022N-7x
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:28:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-2-marcandre.lureau@redhat.com>
	<875zw1lne9.fsf@dusky.pond.sub.org>
	<CAJ+F1CKOgnJOmBAYSG1OYKt5XpB_BCgbfCcsexbrVNM0odymNw@mail.gmail.com>
Date: Mon, 10 Dec 2018 14:28:26 +0100
In-Reply-To: <CAJ+F1CKOgnJOmBAYSG1OYKt5XpB_BCgbfCcsexbrVNM0odymNw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 10 Dec 2018
	15:13:47 +0400")
Message-ID: <87va41fr45.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 01/27] qapi: make sure osdep.h
 is included in type headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Dec 10, 2018 at 1:52 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Now that the schema can be configured, it is crucial that all types
>> > are configured the same. Make sure config-host.h is included, by
>> > checking osdep.h inclusion. The build-sys tracks the dependency and
>> > rebuilds the types if the configuration changed.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  scripts/qapi/types.py | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
>> > index fd7808103c..3bb9cb6d47 100644
>> > --- a/scripts/qapi/types.py
>> > +++ b/scripts/qapi/types.py
>> > @@ -201,6 +201,9 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCV=
isitor):
>> >  ''',
>> >                                        types=3Dtypes, visit=3Dvisit))
>> >          self._genh.preamble_add(mcgen('''
>> > +#ifndef QEMU_OSDEP_H
>> > +#error Please include osdep.h first!
>> > +#endif
>> >  #include "qapi/qapi-builtin-types.h"
>> >  '''))
>>
>> I understand why you propose this patch.  The QAPI-generated headers use
>> #ifdef CONFIG_FOO.  The configuration header "qemu/osdep.h" must be
>> consistently included before the generated headers, or else you end up
>> with nasty bugs, such as the same enum having different values in
>> different .o, or the same struct having a different layout.
>>
>> But this applies to *all* headers that use #ifdef.  Why check it here,
>> but not there?  What makes the QAPI-generated headers special?
>>
>
> It's the discussion about #if in headers (and enums in particular)
> that started this. We want to make sure all compilation units share
> the same data structure/ABI. I proposed to include osdep.h in qapi
> headers, but that was rejected.
> The warning is a different approach. I agree it could apply to all
> headers. Do you think I should update all headers as well?

That would replace the rule 'all .c files must include "qemu/osdep.h"
first' by 'all .h files must check "qemu/osdep.h" has been included
already', which is not an improvement.

All we have right now to help with enforcing our osdep.h rule is
scripts/clean-includes.  We run it periodically to fix rule breakers.
It's manual, because we have a few .c files in the tree where the rule
doesn't apply, and the script doesn't know about them.  Fixable, I
guess.  Most recent run:

    Subject: [PATCH] Clean up includes
    Message-Id: <20181204172535.2799-1-armbru@redhat.com>
    https://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg00605.html

The obvious improvement would be flagging rule breakers before they get
committed.

checkpatch.pl could flag patches adding .c files that don't include
"qemu/osdep.h" first.  The "first" part might be a bit annoying to code.
The "adding files" part already exists: checkpatch.pl warns when you add
a file without updating MAINTAINERS.

checkpatch.pl could also flag patches removing #include "qemu/osdep.h".

Other projects use a syntax-check make target to check sources.  If we
decide we like that better than checkpatch.pl for some checks, we can do
that.
