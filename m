Received: from eggs.gnu.org ([2001:4830:134:3::10]:57912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ1St-00040e-GM
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ1Sp-0005FI-3R
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:43:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJ1So-0005F2-Qb
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:43:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF3548F27A
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 17:43:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-44-marcandre.lureau@redhat.com>
Date: Thu, 08 Jun 2017 19:43:14 +0200
In-Reply-To: <20170607163635.17635-44-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 7 Jun 2017
	20:36:35 +0400")
Message-ID: <87h8zq1ikt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 43/43] qobject: move dump_qobject() from
 block/ to qobject/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The dump functions could be generally useful for any qobject user or for
> debugging etc.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qdict.h   |  2 ++
>  include/qapi/qmp/qlist.h   |  2 ++
>  include/qapi/qmp/qobject.h |  7 ++++
>  block/qapi.c               | 90 +++-------------------------------------=
------
>  qobject/qdict.c            | 30 ++++++++++++++++
>  qobject/qlist.c            | 23 ++++++++++++
>  qobject/qobject.c          | 19 ++++++++++
>  tests/check-qjson.c        | 19 ++++++++++
>  8 files changed, 106 insertions(+), 86 deletions(-)
>
> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> index 8c7c2b762b..1ef3bc8cda 100644
> --- a/include/qapi/qmp/qdict.h
> +++ b/include/qapi/qmp/qdict.h
> @@ -91,4 +91,6 @@ QObject *qdict_crumple(const QDict *src, Error **errp);
>=20=20
>  void qdict_join(QDict *dest, QDict *src, bool overwrite);
>=20=20
> +char *qdict_to_string(QDict *dict, int indent);
> +
>  #endif /* QDICT_H */
> diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
> index c4b5fdad9b..c93ac3e15b 100644
> --- a/include/qapi/qmp/qlist.h
> +++ b/include/qapi/qmp/qlist.h
> @@ -60,6 +60,8 @@ size_t qlist_size(const QList *qlist);
>  QList *qobject_to_qlist(const QObject *obj);
>  void qlist_destroy_obj(QObject *obj);
>=20=20
> +char *qlist_to_string(QList *list, int indent);
> +
>  static inline const QListEntry *qlist_first(const QList *qlist)
>  {
>      return QTAILQ_FIRST(&qlist->head);
> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
> index b8ddbca405..0d6ae5048a 100644
> --- a/include/qapi/qmp/qobject.h
> +++ b/include/qapi/qmp/qobject.h
> @@ -101,4 +101,11 @@ static inline QObject *qnull(void)
>      return &qnull_;
>  }
>=20=20
> +char *qobject_to_string_indent(QObject *obj, int indent);
> +
> +static inline char *qobject_to_string(QObject *obj)
> +{
> +    return qobject_to_string_indent(obj, 0);
> +}
> +
>  #endif /* QOBJECT_H */
> diff --git a/block/qapi.c b/block/qapi.c
> index 2050df29e4..9b7d42e50a 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -586,101 +586,19 @@ void bdrv_snapshot_dump(fprintf_function func_fpri=
ntf, void *f,
>      }
>  }
>=20=20
> -static void dump_qdict(fprintf_function func_fprintf, void *f, int inden=
tation,
> -                       QDict *dict);
> -static void dump_qlist(fprintf_function func_fprintf, void *f, int inden=
tation,
> -                       QList *list);
> -
> -static void dump_qobject(fprintf_function func_fprintf, void *f,
> -                         int comp_indent, QObject *obj)
> -{
> -    switch (qobject_type(obj)) {
> -        case QTYPE_QNUM: {
> -            QNum *value =3D qobject_to_qnum(obj);
> -            char *tmp =3D qnum_to_string(value);
> -            func_fprintf(f, "%s", tmp);
> -            g_free(tmp);
> -            break;
> -        }
> -        case QTYPE_QSTRING: {
> -            QString *value =3D qobject_to_qstring(obj);
> -            func_fprintf(f, "%s", qstring_get_str(value));
> -            break;
> -        }
> -        case QTYPE_QDICT: {
> -            QDict *value =3D qobject_to_qdict(obj);
> -            dump_qdict(func_fprintf, f, comp_indent, value);
> -            break;
> -        }
> -        case QTYPE_QLIST: {
> -            QList *value =3D qobject_to_qlist(obj);
> -            dump_qlist(func_fprintf, f, comp_indent, value);
> -            break;
> -        }
> -        case QTYPE_QBOOL: {
> -            QBool *value =3D qobject_to_qbool(obj);
> -            func_fprintf(f, "%s", qbool_get_bool(value) ? "true" : "fals=
e");
> -            break;
> -        }
> -        default:
> -            abort();
> -    }
> -}
> -
> -static void dump_qlist(fprintf_function func_fprintf, void *f, int inden=
tation,
> -                       QList *list)
> -{
> -    const QListEntry *entry;
> -    int i =3D 0;
> -
> -    for (entry =3D qlist_first(list); entry; entry =3D qlist_next(entry)=
, i++) {
> -        QType type =3D qobject_type(entry->value);
> -        bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QTYPE=
_QLIST);
> -        func_fprintf(f, "%*s[%i]:%c", indentation * 4, "", i,
> -                     composite ? '\n' : ' ');
> -        dump_qobject(func_fprintf, f, indentation + 1, entry->value);
> -        if (!composite) {
> -            func_fprintf(f, "\n");
> -        }
> -    }
> -}
> -
> -static void dump_qdict(fprintf_function func_fprintf, void *f, int inden=
tation,
> -                       QDict *dict)
> -{
> -    const QDictEntry *entry;
> -
> -    for (entry =3D qdict_first(dict); entry; entry =3D qdict_next(dict, =
entry)) {
> -        QType type =3D qobject_type(entry->value);
> -        bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QTYPE=
_QLIST);
> -        char *key =3D g_malloc(strlen(entry->key) + 1);
> -        int i;
> -
> -        /* replace dashes with spaces in key (variable) names */
> -        for (i =3D 0; entry->key[i]; i++) {
> -            key[i] =3D entry->key[i] =3D=3D '-' ? ' ' : entry->key[i];
> -        }
> -        key[i] =3D 0;
> -        func_fprintf(f, "%*s%s:%c", indentation * 4, "", key,
> -                     composite ? '\n' : ' ');
> -        dump_qobject(func_fprintf, f, indentation + 1, entry->value);
> -        if (!composite) {
> -            func_fprintf(f, "\n");
> -        }
> -        g_free(key);
> -    }
> -}
> -
>  void bdrv_image_info_specific_dump(fprintf_function func_fprintf, void *=
f,
>                                     ImageInfoSpecific *info_spec)
>  {
>      QObject *obj, *data;
>      Visitor *v =3D qobject_output_visitor_new(&obj);
> +    char *tmp;
>=20=20
>      visit_type_ImageInfoSpecific(v, NULL, &info_spec, &error_abort);
>      visit_complete(v, &obj);
>      data =3D qdict_get(qobject_to_qdict(obj), "data");
> -    dump_qobject(func_fprintf, f, 1, data);
> +    tmp =3D qobject_to_string_indent(data, 1);
> +    func_fprintf(f, "%s", tmp);
> +    g_free(tmp);
>      qobject_decref(obj);
>      visit_free(v);
>  }

The title claims "move dump_qobject() from block/ to qobject/", but
that's not what the patch does.  It *replaces* dump_qobject() by
qobject_to_string().  The former dumps to a callback, the latter to a
dynamic string buffer.

Providing dump functionality in one way doesn't preclude the other way:
given callback, one could define a callback that builds up a string
buffer, and given buffer, one could (and you actually do) pass the
buffer to a callback.  That's less efficient, though.

Trading efficiency for ease-of-use should be okay here, but I'm cc'ing
Max and Kevin to double-check.

Two ways forward:

1. Get Max / Kevin's blessing, change the commit message to match the
code.

2. Change the code to match the commit message.

> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index 65069baa1b..7e5a945c5e 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -1055,3 +1055,33 @@ void qdict_join(QDict *dest, QDict *src, bool over=
write)
>          entry =3D next;
>      }
>  }
> +
> +char *qdict_to_string(QDict *dict, int indent)
> +{
> +    const QDictEntry *entry;
> +    GString *str =3D g_string_new(NULL);
> +
> +    for (entry =3D qdict_first(dict); entry; entry =3D qdict_next(dict, =
entry)) {
> +        QType type =3D qobject_type(entry->value);
> +        bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QTYPE=
_QLIST);
> +        char *key =3D g_malloc(strlen(entry->key) + 1);
> +        char *val =3D qobject_to_string_indent(entry->value, indent + 1);
> +        int i;
> +
> +        /* replace dashes with spaces in key (variable) names */
> +        for (i =3D 0; entry->key[i]; i++) {
> +            key[i] =3D entry->key[i] =3D=3D '-' ? ' ' : entry->key[i];
> +        }
> +        key[i] =3D 0;
> +        g_string_append_printf(str, "%*s%s:", indent * 4, "", key);
> +        g_string_append_c(str, composite ? '\n' : ' ');
> +        g_string_append(str, val);
> +        if (!composite) {
> +            g_string_append_c(str, '\n');
> +        }
> +        g_free(val);
> +        g_free(key);
> +    }
> +
> +    return g_string_free(str, false);
> +}
> diff --git a/qobject/qlist.c b/qobject/qlist.c
> index 86b60cb88c..b769248290 100644
> --- a/qobject/qlist.c
> +++ b/qobject/qlist.c
> @@ -158,3 +158,26 @@ void qlist_destroy_obj(QObject *obj)
>=20=20
>      g_free(qlist);
>  }
> +
> +char *qlist_to_string(QList *list, int indent)
> +{
> +    GString *str =3D g_string_new(NULL);
> +    const QListEntry *entry;
> +    int i =3D 0;
> +
> +    for (entry =3D qlist_first(list); entry; entry =3D qlist_next(entry)=
, i++) {
> +        QType type =3D qobject_type(entry->value);
> +        bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QTYPE=
_QLIST);
> +        char *val =3D qobject_to_string_indent(entry->value, indent + 1);
> +
> +        g_string_append_printf(str, "%*s[%i]:", indent * 4, "", i);
> +        g_string_append_c(str, composite ? '\n' : ' ');
> +        g_string_append(str, val);
> +        if (!composite) {
> +            g_string_append_c(str, '\n');
> +        }
> +        g_free(val);
> +    }
> +
> +    return g_string_free(str, false);
> +}
> diff --git a/qobject/qobject.c b/qobject/qobject.c
> index b0cafb66f1..64e959c54f 100644
> --- a/qobject/qobject.c
> +++ b/qobject/qobject.c
> @@ -27,3 +27,22 @@ void qobject_destroy(QObject *obj)
>      assert(QTYPE_QNULL < obj->type && obj->type < QTYPE__MAX);
>      qdestroy[obj->type](obj);
>  }
> +
> +char *qobject_to_string_indent(QObject *obj, int indent)
> +{
> +    switch (qobject_type(obj)) {
> +    case QTYPE_QNUM:
> +        return qnum_to_string(qobject_to_qnum(obj));
> +    case QTYPE_QSTRING:
> +        return g_strdup(qstring_get_str(qobject_to_qstring(obj)));
> +    case QTYPE_QDICT:
> +        return qdict_to_string(qobject_to_qdict(obj), indent);
> +    case QTYPE_QLIST:
> +        return qlist_to_string(qobject_to_qlist(obj), indent);
> +    case QTYPE_QBOOL:
> +        return g_strdup(qbool_get_bool(qobject_to_qbool(obj)) ?
> +                        "true" : "false");
> +    default:
> +        abort();
> +    }
> +}
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index 53f2275b9b..dd3c102bc0 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -1372,6 +1372,23 @@ static void simple_whitespace(void)
>      }
>  }
>=20=20
> +static void qobject_to_string_test(void)
> +{
> +    QObject *obj;
> +    char *tmp;
> +
> +    obj =3D qobject_from_json("[ 43, { 'c': { 'd' : 12 } }, [ 1, 2 ], 42=
 ]",
> +                            &error_abort);
> +    tmp =3D qobject_to_string(obj);
> +    g_assert_cmpstr(tmp, =3D=3D,
> +                    "[0]: 43\n"
> +                    "[1]:\n    c:\n        d: 12\n"
> +                    "[2]:\n    [0]: 1\n    [1]: 2\n"
> +                    "[3]: 42\n");
> +    g_free(tmp);
> +    qobject_decref(obj);
> +}
> +
>  static void simple_varargs(void)
>  {
>      QObject *embedded_obj;
> @@ -1545,5 +1562,7 @@ int main(int argc, char **argv)
>      g_test_add_func("/errors/unterminated/literal", unterminated_literal=
);
>      g_test_add_func("/errors/limits/nesting", limits_nesting);
>=20=20
> +    g_test_add_func("/qobject/to_string", qobject_to_string_test);
> +
>      return g_test_run();
>  }
