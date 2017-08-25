Received: from eggs.gnu.org ([2001:4830:134:3::10]:37906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl8WM-0006Yz-6J
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl8WJ-0000tm-19
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:55:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dl8WI-0000tF-Nz
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:55:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7870CC04B32C
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 06:55:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-7-marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 08:55:00 +0200
In-Reply-To: <20170824103350.16400-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 24 Aug 2017 12:33:42 +0200")
Message-ID: <87d17k16ij.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/14] qlit: make qlit_equal_qobject return
 a bool
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Make it more obvious about the expected return values.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h |  2 +-
>  qobject/qlit.c          | 18 +++++++++---------
>  tests/check-qjson.c     | 14 +++++++-------
>  3 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> index e299e8fab0..2e22d0f73c 100644
> --- a/include/qapi/qmp/qlit.h
> +++ b/include/qapi/qmp/qlit.h
> @@ -44,6 +44,6 @@ struct QLitDictEntry {
>  #define QLIT_QLIST(val) \
>      { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
>=20=20
> -int qlit_equal_qobject(QLitObject *lhs, QObject *rhs);
> +bool qlit_equal_qobject(QLitObject *lhs, QObject *rhs);
>=20=20
>  #endif /* QLIT_H_ */
> diff --git a/qobject/qlit.c b/qobject/qlit.c
> index 0c4101898d..a2975bef3f 100644
> --- a/qobject/qlit.c
> +++ b/qobject/qlit.c
> @@ -21,19 +21,19 @@
>  typedef struct QListCompareHelper {
>      int index;
>      QLitObject *objs;
> -    int result;
> +    bool result;
>  } QListCompareHelper;
>=20=20
>  static void compare_helper(QObject *obj, void *opaque)
>  {
>      QListCompareHelper *helper =3D opaque;
>=20=20
> -    if (helper->result =3D=3D 0) {
> +    if (!helper->result) {
>          return;
>      }
>=20=20
>      if (helper->objs[helper->index].type =3D=3D QTYPE_NONE) {
> -        helper->result =3D 0;
> +        helper->result =3D false;
>          return;
>      }
>=20=20
> @@ -41,12 +41,12 @@ static void compare_helper(QObject *obj, void *opaque)
>          qlit_equal_qobject(&helper->objs[helper->index++], obj);
>  }
>=20=20
> -int qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
> +bool qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
>  {
>      int64_t val;
>=20=20
>      if (!rhs || lhs->type !=3D qobject_type(rhs)) {
> -        return 0;
> +        return false;
>      }
>=20=20
>      switch (lhs->type) {
> @@ -64,18 +64,18 @@ int qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
>                                       lhs->value.qdict[i].key);
>=20=20
>              if (!qlit_equal_qobject(&lhs->value.qdict[i].value, obj)) {
> -                return 0;
> +                return false;
>              }
>          }
>=20=20
> -        return 1;
> +        return true;
>      }
>      case QTYPE_QLIST: {
>          QListCompareHelper helper;
>=20=20
>          helper.index =3D 0;
>          helper.objs =3D lhs->value.qlist;
> -        helper.result =3D 1;
> +        helper.result =3D true;
>=20=20
>          qlist_iter(qobject_to_qlist(rhs), compare_helper, &helper);
>=20=20

Let's use QLIST_FOREACH_ENTRY() rather than qlist_iter() with awkward
callback machinery.  Could be done before this patch (might reduce
churn) or after.  Even as a follow-up patch.

Speaking of additional cleanup: qlit_equal_dict() clones its QDict
argument for no good reason.  Drop the clone and compare
qdict_size(dict) =3D=3D i instead.  Same result except when you got
duplicates in your QLitObject, but that's a silly programming error I
wouldn't bother to cope with or catch.

> @@ -85,5 +85,5 @@ int qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
>          break;
>      }
>=20=20
> -    return 0;
> +    return false;
>  }
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index e5ca273cbc..59227934ce 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -1094,13 +1094,13 @@ static void simple_dict(void)
>          QString *str;
>=20=20
>          obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
> -        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
> +        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
>=20=20
>          str =3D qobject_to_json(obj);
>          qobject_decref(obj);
>=20=20
>          obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
> -        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
> +        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
>          qobject_decref(obj);
>          QDECREF(str);
>      }
> @@ -1203,13 +1203,13 @@ static void simple_list(void)
>          QString *str;
>=20=20
>          obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
> -        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
> +        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
>=20=20
>          str =3D qobject_to_json(obj);
>          qobject_decref(obj);
>=20=20
>          obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
> -        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
> +        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
>          qobject_decref(obj);
>          QDECREF(str);
>      }
> @@ -1265,13 +1265,13 @@ static void simple_whitespace(void)
>          QString *str;
>=20=20
>          obj =3D qobject_from_json(test_cases[i].encoded, &error_abort);
> -        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
> +        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
>=20=20
>          str =3D qobject_to_json(obj);
>          qobject_decref(obj);
>=20=20
>          obj =3D qobject_from_json(qstring_get_str(str), &error_abort);
> -        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj) =3D=3D =
1);
> +        g_assert(qlit_equal_qobject(&test_cases[i].decoded, obj));
>=20=20
>          qobject_decref(obj);
>          QDECREF(str);
> @@ -1295,7 +1295,7 @@ static void simple_varargs(void)
>      g_assert(embedded_obj !=3D NULL);
>=20=20
>      obj =3D qobject_from_jsonf("[%d, 2, %p]", 1, embedded_obj);
> -    g_assert(qlit_equal_qobject(&decoded, obj) =3D=3D 1);
> +    g_assert(qlit_equal_qobject(&decoded, obj));
>=20=20
>      qobject_decref(obj);
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>

I encourage you to pursue the additional cleanups I outlined above.
