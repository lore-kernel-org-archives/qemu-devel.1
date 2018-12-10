Received: from eggs.gnu.org ([2001:4830:134:3::10]:51100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWJVi-0001jR-9f
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWJVh-0006Np-5E
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:14:02 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gWJVg-0006NF-Tc
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:14:01 -0500
Received: by mail-wm1-x343.google.com with SMTP id n190so10546130wmd.0
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 03:14:00 -0800 (PST)
MIME-Version: 1.0
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-2-marcandre.lureau@redhat.com>
	<875zw1lne9.fsf@dusky.pond.sub.org>
In-Reply-To: <875zw1lne9.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Dec 2018 15:13:47 +0400
Message-ID: <CAJ+F1CKOgnJOmBAYSG1OYKt5XpB_BCgbfCcsexbrVNM0odymNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Mon, Dec 10, 2018 at 1:52 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Now that the schema can be configured, it is crucial that all types
> > are configured the same. Make sure config-host.h is included, by
> > checking osdep.h inclusion. The build-sys tracks the dependency and
> > rebuilds the types if the configuration changed.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi/types.py | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> > index fd7808103c..3bb9cb6d47 100644
> > --- a/scripts/qapi/types.py
> > +++ b/scripts/qapi/types.py
> > @@ -201,6 +201,9 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVi=
sitor):
> >  ''',
> >                                        types=3Dtypes, visit=3Dvisit))
> >          self._genh.preamble_add(mcgen('''
> > +#ifndef QEMU_OSDEP_H
> > +#error Please include osdep.h first!
> > +#endif
> >  #include "qapi/qapi-builtin-types.h"
> >  '''))
>
> I understand why you propose this patch.  The QAPI-generated headers use
> #ifdef CONFIG_FOO.  The configuration header "qemu/osdep.h" must be
> consistently included before the generated headers, or else you end up
> with nasty bugs, such as the same enum having different values in
> different .o, or the same struct having a different layout.
>
> But this applies to *all* headers that use #ifdef.  Why check it here,
> but not there?  What makes the QAPI-generated headers special?
>

It's the discussion about #if in headers (and enums in particular)
that started this. We want to make sure all compilation units share
the same data structure/ABI. I proposed to include osdep.h in qapi
headers, but that was rejected.
The warning is a different approach. I agree it could apply to all
headers. Do you think I should update all headers as well?


--=20
Marc-Andr=C3=A9 Lureau
