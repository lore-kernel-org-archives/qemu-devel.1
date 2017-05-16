Received: from eggs.gnu.org ([2001:4830:134:3::10]:46514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAgJg-0002IZ-Nt
	for qemu-devel@nongnu.org; Tue, 16 May 2017 13:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAgJd-0003go-Iv
	for qemu-devel@nongnu.org; Tue, 16 May 2017 13:31:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAgJd-0003g5-AZ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 13:31:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E295FC056791
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 17:31:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-9-marcandre.lureau@redhat.com>
Date: Tue, 16 May 2017 19:31:07 +0200
In-Reply-To: <20170509173559.31598-9-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 9 May 2017 20:35:50 +0300")
Message-ID: <87pof86750.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/17] qapi: update the qobject visitor to
 use QUInt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On the subject: there is no such thing as "QUInt".  I guess you mean
"uint type" (like in PATCH 06's subject).  Could also say "QNUM_U64".

Apropos subject: humor me, and start your subjects with a capital
letter, like this:

    qapi: Update the qobject visitor ...

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Switch to use QNum/uint where appropriate to remove i64 limitation.
>
> The input visitor will cast i64 input to u64 for compatibility
> reasons (existing json QMP client already use negative i64 for large
> u64, and expect an implicit cast in qemu).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/qobject-input-visitor.c        | 13 +++++++++++--
>  qapi/qobject-output-visitor.c       |  3 +--
>  tests/test-qobject-output-visitor.c | 21 ++++++++++++++++-----
>  3 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index 785949ebab..72cefcf677 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -420,9 +420,9 @@ static void qobject_input_type_int64_keyval(Visitor *=
v, const char *name,
>  static void qobject_input_type_uint64(Visitor *v, const char *name,
>                                        uint64_t *obj, Error **errp)
>  {
> -    /* FIXME: qobject_to_qnum mishandles values over INT64_MAX */
>      QObjectInputVisitor *qiv =3D to_qiv(v);
>      QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
> +    Error *err =3D NULL;
>      QNum *qnum;
>=20=20
>      if (!qobj) {
> @@ -435,7 +435,16 @@ static void qobject_input_type_uint64(Visitor *v, co=
nst char *name,
>          return;
>      }
>=20=20
> -    *obj =3D qnum_get_int(qnum, errp);
> +    /* XXX: compatibility case, accept negative values as u64 */

What does "XXX" signify?

> +    *obj =3D qnum_get_int(qnum, &err);
> +

Shouldn't the comment go right here?

> +    if (err) {
> +        error_free(err);
> +        err =3D NULL;
> +        *obj =3D qnum_get_uint(qnum, &err);
> +    }
> +
> +    error_propagate(errp, err);
>  }
>=20=20
>  static void qobject_input_type_uint64_keyval(Visitor *v, const char *nam=
e,
> diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
> index 2ca5093b22..70be84ccb5 100644
> --- a/qapi/qobject-output-visitor.c
> +++ b/qapi/qobject-output-visitor.c
> @@ -150,9 +150,8 @@ static void qobject_output_type_int64(Visitor *v, con=
st char *name,
>  static void qobject_output_type_uint64(Visitor *v, const char *name,
>                                         uint64_t *obj, Error **errp)
>  {
> -    /* FIXME values larger than INT64_MAX become negative */
>      QObjectOutputVisitor *qov =3D to_qov(v);
> -    qobject_output_add(qov, name, qnum_from_int(*obj));
> +    qobject_output_add(qov, name, qnum_from_uint(*obj));

Before the patch, uint64_t values above INT64_MAX are sent as negative
values, e.g. UINT64_MAX is sent as -1.

After the patch, they are sent unmodified.  Clearly a bug fix, but we
have to consider compatibility issues anyway.  Does libvirt expect large
integers to be sent as negative integers?  Does it cope with this fix
gracefully?  Eric, any idea?

>  }
>=20=20
>  static void qobject_output_type_bool(Visitor *v, const char *name, bool =
*obj,
> diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
> index 66a682d5a8..767818e393 100644
> --- a/tests/test-qobject-output-visitor.c
> +++ b/tests/test-qobject-output-visitor.c
> @@ -595,15 +595,26 @@ static void check_native_list(QObject *qobj,
>      qlist =3D qlist_copy(qobject_to_qlist(qdict_get(qdict, "data")));
>=20=20
>      switch (kind) {
> -    case USER_DEF_NATIVE_LIST_UNION_KIND_S8:
> -    case USER_DEF_NATIVE_LIST_UNION_KIND_S16:
> -    case USER_DEF_NATIVE_LIST_UNION_KIND_S32:
> -    case USER_DEF_NATIVE_LIST_UNION_KIND_S64:
>      case USER_DEF_NATIVE_LIST_UNION_KIND_U8:
>      case USER_DEF_NATIVE_LIST_UNION_KIND_U16:
>      case USER_DEF_NATIVE_LIST_UNION_KIND_U32:
>      case USER_DEF_NATIVE_LIST_UNION_KIND_U64:
> -        /* all integer elements in JSON arrays get stored into QNums when
> +        for (i =3D 0; i < 32; i++) {
> +            QObject *tmp;
> +            QNum *qvalue;
> +            tmp =3D qlist_peek(qlist);
> +            g_assert(tmp);
> +            qvalue =3D qobject_to_qnum(tmp);
> +            g_assert_cmpuint(qnum_get_uint(qvalue, &error_abort), =3D=3D=
, i);
> +            qobject_decref(qlist_pop(qlist));
> +        }
> +        break;
> +
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S8:
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S16:
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S32:
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S64:
> +        /* all integer elements in JSON arrays get stored into QInts when
>           * we convert to QObjects, so we can check them all in the same
>           * fashion, so simply fall through here
>           */

Make that "All signed integer ...", and wing both ends of the comment.
Or simply drop the comment.
