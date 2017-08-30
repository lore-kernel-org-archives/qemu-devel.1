Received: from eggs.gnu.org ([2001:4830:134:3::10]:36228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dn22A-0007vj-MO
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dn225-0002Ov-OB
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:23:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dn225-0002Oe-En
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:23:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 651C9C0587F7
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:23:44 +0000 (UTC)
Date: Wed, 30 Aug 2017 08:23:44 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <130508726.5983911.1504095824230.JavaMail.zimbra@redhat.com>
In-Reply-To: <87efrtgsjv.fsf@dusky.pond.sub.org>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-11-marcandre.lureau@redhat.com>
	<87efrtgsjv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/14] tests: add qlit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/check-qlit.c     | 64
> >  ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/Makefile.include |  5 +++-
> >  2 files changed, 68 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/check-qlit.c
> >
> > diff --git a/tests/check-qlit.c b/tests/check-qlit.c
> > new file mode 100644
> > index 0000000000..47fde92a46
> > --- /dev/null
> > +++ b/tests/check-qlit.c
> > @@ -0,0 +1,64 @@
> > +/*
> > + * QLit unit-tests.
> > + *
> > + * Copyright (C) 2017 Red Hat Inc.
> > + *
> > + * This work is licensed under the terms of the GNU LGPL, version 2.1 =
or
> > later.
> > + * See the COPYING.LIB file in the top-level directory.
>=20
> Please use GPLv2+ unless you have a specific reason for something else.
> In that case, explain your reason in the commit message.
>=20
> May I change the copyright notice to GPLv2+ for you?

I copied that header from some other files. Sure, feel free (although I lik=
e LGPL better in general, so we can easily move the code to a shared librar=
y)

>=20
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "qapi/qmp/qbool.h"
> > +#include "qapi/qmp/qdict.h"
> > +#include "qapi/qmp/qlit.h"
> > +#include "qapi/qmp/qnum.h"
> > +#include "qapi/qmp/qstring.h"
> > +
> > +static QLitObject qlit =3D QLIT_QDICT(((QLitDictEntry[]) {
> > +    { "foo", QLIT_QNUM(42) },
> > +    { "bar", QLIT_QSTR("hello world") },
> > +    { "baz", QLIT_QNULL },
> > +    { "bee", QLIT_QLIST(((QLitObject[]) {
> > +        QLIT_QNUM(43),
> > +        QLIT_QNUM(44),
> > +        QLIT_QBOOL(true),
> > +        { },
> > +    }))},
> > +    { },
> > +}));
> > +
> > +static QObject *make_qobject(void)
> > +{
> > +    QDict *qdict =3D qdict_new();
> > +    QList *list =3D qlist_new();
> > +
> > +    qdict_put_int(qdict, "foo", 42);
> > +    qdict_put_str(qdict, "bar", "hello world");
> > +    qdict_put_null(qdict, "baz");
> > +
> > +    qlist_append_int(list, 43);
> > +    qlist_append_int(list, 44);
> > +    qlist_append_bool(list, true);
> > +    qdict_put(qdict, "bee", list);
> > +
> > +    return QOBJECT(qdict);
> > +}
> > +
> > +static void qlit_equal_qobject_test(void)
> > +{
> > +    QObject *qobj =3D make_qobject();
> > +
> > +    g_assert(qlit_equal_qobject(&qlit, qobj));
> > +
> > +    qobject_decref(qobj);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    g_test_init(&argc, &argv, NULL);
> > +
> > +    g_test_add_func("/qlit/equal_qobject", qlit_equal_qobject_test);
> > +
> > +    return g_test_run();
> > +}
>=20
> We also need negative tests.  Could be done as follow-up patch.

There are a few in following patches iirc, more is always welcome.

Thanks

>=20
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 37c1bed683..3653c7b40a 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -43,6 +43,8 @@ check-unit-y +=3D tests/check-qnull$(EXESUF)
> >  gcov-files-check-qnull-y =3D qobject/qnull.c
> >  check-unit-y +=3D tests/check-qjson$(EXESUF)
> >  gcov-files-check-qjson-y =3D qobject/qjson.c
> > +check-unit-y +=3D tests/check-qlit$(EXESUF)
> > +gcov-files-check-qlit-y =3D qobject/qlit.c
> >  check-unit-y +=3D tests/test-qobject-output-visitor$(EXESUF)
> >  gcov-files-test-qobject-output-visitor-y =3D qapi/qobject-output-visit=
or.c
> >  check-unit-y +=3D tests/test-clone-visitor$(EXESUF)
> > @@ -535,7 +537,7 @@ GENERATED_FILES +=3D tests/test-qapi-types.h
> > tests/test-qapi-visit.h \
> > =20
> >  test-obj-y =3D tests/check-qnum.o tests/check-qstring.o tests/check-qd=
ict.o
> >  \
> >  =09tests/check-qlist.o tests/check-qnull.o \
> > -=09tests/check-qjson.o \
> > +=09tests/check-qjson.o tests/check-qlit.o \
> >  =09tests/test-coroutine.o tests/test-string-output-visitor.o \
> >  =09tests/test-string-input-visitor.o tests/test-qobject-output-visitor=
.o \
> >  =09tests/test-clone-visitor.o \
> > @@ -569,6 +571,7 @@ tests/check-qdict$(EXESUF): tests/check-qdict.o
> > $(test-util-obj-y)
> >  tests/check-qlist$(EXESUF): tests/check-qlist.o $(test-util-obj-y)
> >  tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
> >  tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
> > +tests/check-qlit$(EXESUF): tests/check-qlit.o $(test-util-obj-y)
> >  tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o
> >  $(test-qom-obj-y)
> >  tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o
> >  $(test-qom-obj-y)
>=20
