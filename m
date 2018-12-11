Received: from eggs.gnu.org ([2001:4830:134:3::10]:56756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWkXO-00028F-Tu
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWkXL-0000tv-RX
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:05:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gWkXL-0000rI-Cp
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:05:31 -0500
Date: Tue, 11 Dec 2018 16:05:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181211160525.GO921@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-2-marcandre.lureau@redhat.com>
	<875zw1lne9.fsf@dusky.pond.sub.org>
	<CAJ+F1CKOgnJOmBAYSG1OYKt5XpB_BCgbfCcsexbrVNM0odymNw@mail.gmail.com>
	<87va41fr45.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87va41fr45.fsf@dusky.pond.sub.org>
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Dec 10, 2018 at 02:28:26PM +0100, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>=20
> > Hi
> >
> > On Mon, Dec 10, 2018 at 1:52 PM Markus Armbruster <armbru@redhat.com>=
 wrote:
> >>
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > Now that the schema can be configured, it is crucial that all type=
s
> >> > are configured the same. Make sure config-host.h is included, by
> >> > checking osdep.h inclusion. The build-sys tracks the dependency an=
d
> >> > rebuilds the types if the configuration changed.
> >> >
> >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com=
>
> >> > ---
> >> >  scripts/qapi/types.py | 3 +++
> >> >  1 file changed, 3 insertions(+)
> >> >
> >> > diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> >> > index fd7808103c..3bb9cb6d47 100644
> >> > --- a/scripts/qapi/types.py
> >> > +++ b/scripts/qapi/types.py
> >> > @@ -201,6 +201,9 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModul=
arCVisitor):
> >> >  ''',
> >> >                                        types=3Dtypes, visit=3Dvisi=
t))
> >> >          self._genh.preamble_add(mcgen('''
> >> > +#ifndef QEMU_OSDEP_H
> >> > +#error Please include osdep.h first!
> >> > +#endif
> >> >  #include "qapi/qapi-builtin-types.h"
> >> >  '''))
> >>
> >> I understand why you propose this patch.  The QAPI-generated headers=
 use
> >> #ifdef CONFIG_FOO.  The configuration header "qemu/osdep.h" must be
> >> consistently included before the generated headers, or else you end =
up
> >> with nasty bugs, such as the same enum having different values in
> >> different .o, or the same struct having a different layout.
> >>
> >> But this applies to *all* headers that use #ifdef.  Why check it her=
e,
> >> but not there?  What makes the QAPI-generated headers special?
> >>
> >
> > It's the discussion about #if in headers (and enums in particular)
> > that started this. We want to make sure all compilation units share
> > the same data structure/ABI. I proposed to include osdep.h in qapi
> > headers, but that was rejected.
> > The warning is a different approach. I agree it could apply to all
> > headers. Do you think I should update all headers as well?
>=20
> That would replace the rule 'all .c files must include "qemu/osdep.h"
> first' by 'all .h files must check "qemu/osdep.h" has been included
> already', which is not an improvement.
>=20
> All we have right now to help with enforcing our osdep.h rule is
> scripts/clean-includes.  We run it periodically to fix rule breakers.
> It's manual, because we have a few .c files in the tree where the rule
> doesn't apply, and the script doesn't know about them.  Fixable, I
> guess.  Most recent run:
>=20
>     Subject: [PATCH] Clean up includes
>     Message-Id: <20181204172535.2799-1-armbru@redhat.com>
>     https://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg00605.h=
tml
>=20
> The obvious improvement would be flagging rule breakers before they get
> committed.
>=20
> checkpatch.pl could flag patches adding .c files that don't include
> "qemu/osdep.h" first.  The "first" part might be a bit annoying to code=
.

You can get this logic from GNULIBs syntax-check make rules. It uses
this perl code to check that config.h is included first:

    while (<>) {
        if (/^# *include\b/) {
            if (not m{^# *include <config\.h>}) {
                print "$ARGV\n";
                $$ret =3D 1;
            }
            close ARGV;
        }
    }


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
