Received: from eggs.gnu.org ([2001:4830:134:3::10]:35618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGkcx-0005M7-V5
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGkcx-0004aD-0r
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:20:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGkcw-0004Zv-PL
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:20:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2DA45702D
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 11:20:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-15-marcandre.lureau@redhat.com>
Date: Fri, 02 Jun 2017 13:20:18 +0200
In-Reply-To: <20170531135709.345-15-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:38 +0400")
Message-ID: <8737bifxfx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/45] qapi: update the qobject visitor
 to use QNUM_U64
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

One more nitpick:

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Switch to use QNum/uint where appropriate to remove i64 limitation.
>
> The input visitor will cast i64 input to u64 for compatibility
> reasons (existing json QMP client already use negative i64 for large
> u64, and expect an implicit cast in qemu).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
> diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
> index 3180d8cbde..d9f106d52e 100644
> --- a/tests/test-qobject-output-visitor.c
> +++ b/tests/test-qobject-output-visitor.c
> @@ -602,17 +602,31 @@ static void check_native_list(QObject *qobj,
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
> -         * we convert to QObjects, so we can check them all in the same
> -         * fashion, so simply fall through here
> +        for (i =3D 0; i < 32; i++) {
> +            QObject *tmp;
> +            QNum *qvalue;
> +            uint64_t val;
> +
> +            tmp =3D qlist_peek(qlist);
> +            g_assert(tmp);
> +            qvalue =3D qobject_to_qnum(tmp);
> +            g_assert(qnum_get_uint(qvalue, &val));
> +            g_assert_cmpuint(val, =3D=3D, i);
> +            qobject_decref(qlist_pop(qlist));
> +        }
> +        break;
> +
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S8:
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S16:
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S32:
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S64:
> +        /* All signed integer elements in JSON arrays get stored into
> +         * QInts when we convert to QObjects, so we can check them all
> +         * in the same fashion, so simply fall through here.
>           */
>      case USER_DEF_NATIVE_LIST_UNION_KIND_INTEGER:
>          for (i =3D 0; i < 32; i++) {

Wing both ends of the comment, please.
