Received: from eggs.gnu.org ([2001:4830:134:3::10]:57483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ds8Kv-0004hA-V6
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ds8Kr-0004O4-VV
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:08:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ds8Kr-0004NC-Pk
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:08:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77BDCC04B924
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 14:08:11 +0000 (UTC)
Date: Wed, 13 Sep 2017 10:08:10 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <752107234.14989591.1505311690362.JavaMail.zimbra@redhat.com>
In-Reply-To: <60e9ce8a-9473-cf55-5429-f70902bc59c2@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-2-marcandre.lureau@redhat.com>
	<60e9ce8a-9473-cf55-5429-f70902bc59c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/50] qlit: add qobject_from_qlit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com



----- Original Message -----
> On 09/11/2017 06:05 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Instanciate a QObject* form a literal QLitObject.
>=20
> s/Instanciate/Instantiate/
> s/form/from/

thanks

>=20
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qapi/qmp/qlit.h |  2 ++
> >  qobject/qlit.c          | 36 ++++++++++++++++++++++++++++++++++++
> >  tests/check-qlit.c      | 26 ++++++++++++++++++++++++++
> >  3 files changed, 64 insertions(+)
>=20
> > +QObject *qobject_from_qlit(const QLitObject *qlit)
> > +{
> > +    switch (qlit->type) {
> > +    case QTYPE_QNULL:
> > +        return QOBJECT(qnull());
> > +    case QTYPE_QNUM:
> > +        return QOBJECT(qnum_from_int(qlit->value.qnum));
>=20
> Is this going to work for all QNum values?
>=20
> > +++ b/tests/check-qlit.c
> > @@ -64,11 +64,37 @@ static void qlit_equal_qobject_test(void)
> >      qobject_decref(qobj);
> >  }
> > =20
> > +static void qobject_from_qlit_test(void)
> > +{
> > +    QObject *obj, *qobj =3D qobject_from_qlit(&qlit);
> > +    QDict *qdict;
> > +    QList *bee;
> > +
> > +    qdict =3D qobject_to_qdict(qobj);
> > +    g_assert_cmpint(qdict_get_int(qdict, "foo"), =3D=3D, 42);
> > +    g_assert_cmpstr(qdict_get_str(qdict, "bar"), =3D=3D, "hello world"=
);
> > +    g_assert(qobject_type(qdict_get(qdict, "baz")) =3D=3D QTYPE_QNULL)=
;
>=20
> Related to my question above - you pass because there are no floating
> point values in qlit.  Is that something we want supported?

Markus had some remarks about it when reviewing #define QLIT_QNUM. Only i64=
 are supported at this point, so it's left for whoever requires it in the f=
uture.

>=20
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20
>=20
