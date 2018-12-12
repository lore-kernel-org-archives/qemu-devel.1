Received: from eggs.gnu.org ([2001:4830:134:3::10]:50368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWyJT-0007k6-6D
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWyJQ-0004kF-1k
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:48:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWyJP-0004ha-8e
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:48:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-2-marcandre.lureau@redhat.com>
	<875zw1lne9.fsf@dusky.pond.sub.org>
	<CAJ+F1CKOgnJOmBAYSG1OYKt5XpB_BCgbfCcsexbrVNM0odymNw@mail.gmail.com>
	<87va41fr45.fsf@dusky.pond.sub.org>
	<CAJ+F1CKSrO2JtNiPm1_V0DbRUDX3VdUMEQGW7iyd_JUMc73k_A@mail.gmail.com>
Date: Wed, 12 Dec 2018 07:47:59 +0100
In-Reply-To: <CAJ+F1CKSrO2JtNiPm1_V0DbRUDX3VdUMEQGW7iyd_JUMc73k_A@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 11 Dec 2018
	19:47:45 +0400")
Message-ID: <87ftv3kzq8.fsf@dusky.pond.sub.org>
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
> On Mon, Dec 10, 2018 at 5:28 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>> > Hi
>> >
>> > On Mon, Dec 10, 2018 at 1:52 PM Markus Armbruster <armbru@redhat.com> =
wrote:
>> >>
>> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>> >>
>> >> > Now that the schema can be configured, it is crucial that all types
>> >> > are configured the same. Make sure config-host.h is included, by
>> >> > checking osdep.h inclusion. The build-sys tracks the dependency and
>> >> > rebuilds the types if the configuration changed.
>> >> >
>> >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> > ---
>> >> >  scripts/qapi/types.py | 3 +++
>> >> >  1 file changed, 3 insertions(+)
>> >> >
>> >> > diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
>> >> > index fd7808103c..3bb9cb6d47 100644
>> >> > --- a/scripts/qapi/types.py
>> >> > +++ b/scripts/qapi/types.py
>> >> > @@ -201,6 +201,9 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModula=
rCVisitor):
>> >> >  ''',
>> >> >                                        types=3Dtypes, visit=3Dvisit=
))
>> >> >          self._genh.preamble_add(mcgen('''
>> >> > +#ifndef QEMU_OSDEP_H
>> >> > +#error Please include osdep.h first!
>> >> > +#endif
>> >> >  #include "qapi/qapi-builtin-types.h"
>> >> >  '''))
>> >>
>> >> I understand why you propose this patch.  The QAPI-generated headers =
use
>> >> #ifdef CONFIG_FOO.  The configuration header "qemu/osdep.h" must be
>> >> consistently included before the generated headers, or else you end up
>> >> with nasty bugs, such as the same enum having different values in
>> >> different .o, or the same struct having a different layout.
>> >>
>> >> But this applies to *all* headers that use #ifdef.  Why check it here,
>> >> but not there?  What makes the QAPI-generated headers special?
>> >>
>> >
>> > It's the discussion about #if in headers (and enums in particular)
>> > that started this. We want to make sure all compilation units share
>> > the same data structure/ABI. I proposed to include osdep.h in qapi
>> > headers, but that was rejected.
>> > The warning is a different approach. I agree it could apply to all
>> > headers. Do you think I should update all headers as well?
>>
>> That would replace the rule 'all .c files must include "qemu/osdep.h"
>> first' by 'all .h files must check "qemu/osdep.h" has been included
>> already', which is not an improvement.
>
> That would be an improvement since headers may also be impacted by osdep.h
>
> Alternatively, why not use -include ?

Requiring .c to include the configuration header first follows
established Autoconf practice.  The "first" part covers all headers.

I've seen plenty of autoconfiscated code, yet none where the headers
double-check the configuration header has been included already.  Such a
check is neither sufficient nor really necessary.  Checking the .c is
both.

I have no strong feelings about using -include instead.  I'd prefer to
avoid the difference to what other projects do, though.

Circling back to the issue that made you propose this patch.

I think I'm (belatedly) coming around to your initial view that the use
of conditionals in generated QAPI code is safe enough.

I shouldn't be worried about #if defined(CONFIG_HOST_THING) where
CONFIG_HOST_THING belongs to config-host.h.  That's always pulled in via
qemu/osdep.h.

I also shouldn't be worried about #if defined(CONFIG_TARGET_THING) where
CONFIG_TARGET_THING belongs to config-target.h.  qemu/osdep.h pulls in
either that or exec/poison.h.

I even shouldn't be worried about #if defined(RANDOM_MACRO) as long as
qemu/osdep.h pulls in its owner or poisons it.  I might legitimately be
worried about the "as long as" part.

We could perhaps extract the ifconds and look for macros that belong
neither to config-host.h nor config-target.h.  But I'm not sure it's
worth the bother.
