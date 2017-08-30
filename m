Received: from eggs.gnu.org ([2001:4830:134:3::10]:43713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dn2bt-00061o-T4
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dn2bp-00014b-Gz
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:00:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dn2bp-00014C-7B
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:00:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED7D85D5EA
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 13:00:39 +0000 (UTC)
Date: Wed, 30 Aug 2017 09:00:39 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1116718182.6031777.1504098039370.JavaMail.zimbra@redhat.com>
In-Reply-To: <87mv6hfc9c.fsf@dusky.pond.sub.org>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-14-marcandre.lureau@redhat.com>
	<87mv6hfc9c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/14] qlit: add qobject_form_qlit()
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
> Eric already pointed out the typo in the title.
>=20
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qapi/qmp/qlit.h |  2 ++
> >  qobject/qlit.c          | 37 +++++++++++++++++++++++++++++++++++++
> >  tests/check-qlit.c      | 26 ++++++++++++++++++++++++++
> >  3 files changed, 65 insertions(+)
> >
> > diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> > index b18406bce9..56feb25e04 100644
> > --- a/include/qapi/qmp/qlit.h
> > +++ b/include/qapi/qmp/qlit.h
> > @@ -51,4 +51,6 @@ struct QLitDictEntry {
> > =20
> >  bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs);
> > =20
> > +QObject *qobject_from_qlit(const QLitObject *qlit);
> > +
> >  #endif /* QLIT_H */
> > diff --git a/qobject/qlit.c b/qobject/qlit.c
> > index 3c4882c784..e44c09e9eb 100644
> > --- a/qobject/qlit.c
> > +++ b/qobject/qlit.c
> > @@ -82,3 +82,40 @@ bool qlit_equal_qobject(const QLitObject *lhs, const
> > QObject *rhs)
> > =20
> >      return false;
> >  }
> > +
> > +QObject *qobject_from_qlit(const QLitObject *qlit)
> > +{
> > +    int i;
> > +
> > +    switch (qlit->type) {
> > +    case QTYPE_QNULL:
> > +        return QOBJECT(qnull());
> > +    case QTYPE_QNUM:
> > +        return QOBJECT(qnum_from_int(qlit->value.qnum));
>=20
> This line shows that QLitObject member value.qnum should really be named
> value.qint.  Let's not worry about that now.
>=20
> > +    case QTYPE_QSTRING:
> > +        return QOBJECT(qstring_from_str(qlit->value.qstr));
> > +    case QTYPE_QDICT: {
> > +        QDict *qdict =3D qdict_new();
>=20
> Blank line here.  Can touch up when I apply.
>=20
> > +        for (i =3D 0; qlit->value.qdict[i].value.type !=3D QTYPE_NONE;=
 i++) {
> > +            QLitDictEntry *e =3D &qlit->value.qdict[i];
>=20
> I'd prefer the laconic
>=20
>         QDict *qdict =3D qdict_new();
>         QLitDictEntry *e;
>=20
>         for (e =3D qlit->value.qdict; e->key; e++) {
>             qdict_put_obj(qdict, e->key, qobject_from_qlit(&e->value));
>         }
>         return QOBJECT(qdict);
>=20
> Can slot that in when I apply.
>=20

Indeed!

> > +
> > +            qdict_put_obj(qdict, e->key, qobject_from_qlit(&e->value))=
;
> > +        }
> > +        return QOBJECT(qdict);
> > +    }
> > +    case QTYPE_QLIST: {
> > +        QList *qlist =3D qlist_new();
> > +
> > +        for (i =3D 0; qlit->value.qlist[i].type !=3D QTYPE_NONE; i++) =
{
> > +            qlist_append_obj(qlist,
> > qobject_from_qlit(&qlit->value.qlist[i]));
> > +        }
> > +        return QOBJECT(qlist);
>=20
> Likewise
>=20
>         QList *qlist =3D qlist_new();
>         QLitObject *e;
>=20
>         for (e =3D qlit->value.qlist; e->type !=3D QTYPE_NONE; e++) {
>             qlist_append_obj(qlist, qobject_from_qlit(e));
>         }
>         return QOBJECT(qlist);
>=20
> > +    }
> > +    case QTYPE_QBOOL:
> > +        return QOBJECT(qbool_from_bool(qlit->value.qbool));
> > +    case QTYPE_NONE:
> > +        assert(0);
> > +    }
> > +
> > +    return NULL;
> > +}
> > diff --git a/tests/check-qlit.c b/tests/check-qlit.c
> > index ae74bfcb83..135a399c6d 100644
> > --- a/tests/check-qlit.c
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
> > +
> > +    bee =3D qdict_get_qlist(qdict, "bee");
> > +    obj =3D qlist_pop(bee);
> > +    g_assert_cmpint(qnum_get_int(qobject_to_qnum(obj)), =3D=3D, 43);
> > +    qobject_decref(obj);
> > +    obj =3D qlist_pop(bee);
> > +    g_assert_cmpint(qnum_get_int(qobject_to_qnum(obj)), =3D=3D, 44);
> > +    qobject_decref(obj);
> > +    obj =3D qlist_pop(bee);
> > +    g_assert(qbool_get_bool(qobject_to_qbool(obj)));
> > +    qobject_decref(obj);
> > +
> > +    qobject_decref(qobj);
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >      g_test_init(&argc, &argv, NULL);
> > =20
> >      g_test_add_func("/qlit/equal_qobject", qlit_equal_qobject_test);
> > +    g_test_add_func("/qlit/qobject_from_qlit", qobject_from_qlit_test)=
;
> > =20
> >      return g_test_run();
> >  }
>=20
> With the typo fixed and preferably with the improvements I suggested:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks
