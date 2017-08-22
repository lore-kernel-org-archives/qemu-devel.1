Received: from eggs.gnu.org ([2001:4830:134:3::10]:34875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkBHr-0000dT-V8
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkBHo-0000fr-NW
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:40:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkBHo-0000dz-E0
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:40:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50F8D806A2
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 15:40:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-5-marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 17:40:01 +0200
In-Reply-To: <20170822132255.23945-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 22 Aug 2017 15:22:05 +0200")
Message-ID: <87r2w37gry.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/54] qlit: add qobject_form_qlit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Typo in the subject: s/form/from/

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h |  2 ++
>  qobject/qlit.c          | 37 +++++++++++++++++++++++++++++++++++++
>  tests/check-qlit.c      | 26 ++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+)
>
> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> index 2cdceb448d..dd562b7d69 100644
> --- a/include/qapi/qmp/qlit.h
> +++ b/include/qapi/qmp/qlit.h
> @@ -51,4 +51,6 @@ struct QLitDictEntry {
>=20=20
>  bool qlit_equal_qobject(QLitObject *lhs, QObject *rhs);
>=20=20
> +QObject *qobject_from_qlit(const QLitObject *qlit);
> +
>  #endif /* QLIT_H_ */
> diff --git a/qobject/qlit.c b/qobject/qlit.c
> index f4ebeb6259..5a2aa44355 100644
> --- a/qobject/qlit.c
> +++ b/qobject/qlit.c
> @@ -104,3 +104,40 @@ bool qlit_equal_qobject(QLitObject *lhs, QObject *rh=
s)
>=20=20
>      return false;
>  }
> +
> +QObject *qobject_from_qlit(const QLitObject *qlit)
> +{
> +    int i;
> +
> +    switch (qlit->type) {
> +    case QTYPE_QNULL:
> +        return QOBJECT(qnull());
> +    case QTYPE_QNUM:
> +        return QOBJECT(qnum_from_int(qlit->value.qnum));
> +    case QTYPE_QSTRING:
> +        return QOBJECT(qstring_from_str(qlit->value.qstr));
> +    case QTYPE_QDICT: {
> +        QDict *qdict =3D qdict_new();
> +        for (i =3D 0; qlit->value.qdict[i].value.type !=3D QTYPE_NONE; i=
++) {

Terser:

           for (i =3D 0; qlit->value.qdict[i].key; i++) {

> +            QLitDictEntry *e =3D &qlit->value.qdict[i];
> +
> +            qdict_put_obj(qdict, e->key, qobject_from_qlit(&e->value));
> +        }
> +        return QOBJECT(qdict);
> +    }
> +    case QTYPE_QLIST: {
> +        QList *qlist =3D qlist_new();
> +
> +        for (i =3D 0; qlit->value.qlist[i].type !=3D QTYPE_NONE; i++) {

Could omit !=3D QTYPE_NONE, because we're very much relying on QTYPE_NONE
being zero anyway.  Matter of taste.

> +            qlist_append_obj(qlist, qobject_from_qlit(&qlit->value.qlist=
[i]));
> +        }
> +        return QOBJECT(qlist);
> +    }
> +    case QTYPE_QBOOL:
> +        return QOBJECT(qbool_from_bool(qlit->value.qbool));
> +    case QTYPE_NONE:

Make that

       default:

to remove all doubt.

> +        assert(0);
> +    }
> +
> +    return NULL;
> +}
> diff --git a/tests/check-qlit.c b/tests/check-qlit.c
> index 5736b61ebf..f25f3d9633 100644
> --- a/tests/check-qlit.c
> +++ b/tests/check-qlit.c
> @@ -58,11 +58,37 @@ static void qlit_equal_qobject_test(void)
>      qobject_decref(qobj);
>  }
>=20=20
> +static void qobject_from_qlit_test(void)
> +{
> +    QObject *obj, *qobj =3D qobject_from_qlit(&qlit);
> +    QDict *qdict;
> +    QList *bee;
> +
> +    qdict =3D qobject_to_qdict(qobj);
> +    g_assert_cmpint(qdict_get_int(qdict, "foo"), =3D=3D, 42);
> +    g_assert_cmpstr(qdict_get_str(qdict, "bar"), =3D=3D, "hello world");
> +    g_assert(qobject_type(qdict_get(qdict, "baz")) =3D=3D QTYPE_QNULL);
> +
> +    bee =3D qdict_get_qlist(qdict, "bee");
> +    obj =3D qlist_pop(bee);
> +    g_assert_cmpint(qnum_get_int(qobject_to_qnum(obj)), =3D=3D, 43);
> +    qobject_decref(obj);
> +    obj =3D qlist_pop(bee);
> +    g_assert_cmpint(qnum_get_int(qobject_to_qnum(obj)), =3D=3D, 44);
> +    qobject_decref(obj);
> +    obj =3D qlist_pop(bee);
> +    g_assert(qbool_get_bool(qobject_to_qbool(obj)));
> +    qobject_decref(obj);
> +
> +    qobject_decref(qobj);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
>=20=20
>      g_test_add_func("/qlit/equal_qobject", qlit_equal_qobject_test);
> +    g_test_add_func("/qlit/qobject_from_qlit", qobject_from_qlit_test);
>=20=20
>      return g_test_run();
>  }
