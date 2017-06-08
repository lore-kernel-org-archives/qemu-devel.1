Received: from eggs.gnu.org ([2001:4830:134:3::10]:42021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ0Pt-0001MU-S8
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ0Pq-0001SD-HH
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:36:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJ0Pq-0001Rn-9U
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:36:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51979A091E
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 16:36:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-12-marcandre.lureau@redhat.com>
Date: Thu, 08 Jun 2017 18:36:05 +0200
In-Reply-To: <20170607163635.17635-12-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 7 Jun 2017
	20:36:03 +0400")
Message-ID: <87vao64etm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/43] qapi: update the qobject visitor
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Switch to use QNum/uint where appropriate to remove i64 limitation.
>
> The input visitor will cast i64 input to u64 for compatibility
> reasons (existing json QMP client already use negative i64 for large
> u64, and expect an implicit cast in qemu).
>
> Note: before the patch, uint64_t values above INT64_MAX are sent over
> json QMP as negative values, e.g. UINT64_MAX is sent as -1. After the
> patch, they are sent unmodified.  Clearly a bug fix, but we have to
> consider compatibility issues anyway.  libvirt should cope fine,
> because its parsing of unsigned integers accepts negative values
> modulo 2^64.  There's hope that other clients will, too.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/i386/acpi-build.c                |  2 +-
>  qapi/qobject-input-visitor.c        | 21 ++++++++++++++++-----
>  qapi/qobject-output-visitor.c       |  3 +--
>  tests/test-qobject-input-visitor.c  |  7 ++-----
>  tests/test-qobject-output-visitor.c | 20 ++++++++++++++++----
>  5 files changed, 36 insertions(+), 17 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index d7d2b65fe4..3eb43677f0 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2614,7 +2614,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>      if (!o) {
>          return false;
>      }
> -    mcfg->mcfg_base =3D qnum_get_int(qobject_to_qnum(o));
> +    mcfg->mcfg_base =3D qnum_get_uint(qobject_to_qnum(o));
>      qobject_decref(o);
>=20=20
>      o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index 539b3b825d..35aff78f2b 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -417,7 +417,6 @@ static void qobject_input_type_int64_keyval(Visitor *=
v, const char *name,
>  static void qobject_input_type_uint64(Visitor *v, const char *name,
>                                        uint64_t *obj, Error **errp)
>  {
> -    /* FIXME: qobject_to_qnum mishandles values over INT64_MAX */
>      QObjectInputVisitor *qiv =3D to_qiv(v);
>      QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
>      QNum *qnum;
> @@ -427,11 +426,23 @@ static void qobject_input_type_uint64(Visitor *v, c=
onst char *name,
>          return;
>      }
>      qnum =3D qobject_to_qnum(qobj);
> -    if (!qnum || !qnum_get_try_int(qnum, &val)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
> -                   full_name(qiv, name), "integer");
> +    if (!qnum) {
> +        goto err;
> +    }
> +
> +    if (qnum_get_try_uint(qnum, obj)) {
> +        return;
>      }
> -    *obj =3D val;
> +
> +    /* Need to accept negative values for backward compatibility */
> +    if (qnum_get_try_int(qnum, &val)) {
> +        *obj =3D val;
> +        return;
> +    }
> +
> +err:
> +    error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +               full_name(qiv, name), "uint64");
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
>  }
>=20=20
>  static void qobject_output_type_bool(Visitor *v, const char *name, bool =
*obj,
> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
> index 40a135db89..3bcdb9a045 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -123,7 +123,6 @@ static void test_visitor_in_int(TestInputVisitorData =
*data,
>  static void test_visitor_in_uint(TestInputVisitorData *data,
>                                  const void *unused)
>  {
> -    Error *err =3D NULL;
>      uint64_t res =3D 0;
>      int64_t i64;
>      double dbl;
> @@ -147,12 +146,10 @@ static void test_visitor_in_uint(TestInputVisitorDa=
ta *data,
>      visit_type_uint64(v, NULL, &res, &error_abort);
>      g_assert_cmpuint(res, =3D=3D, (uint64_t)-value);
>=20=20
> -    /* BUG: value between INT64_MAX+1 and UINT64_MAX rejected */
> -
>      v =3D visitor_input_test_init(data, "18446744073709551574");
>=20=20
> -    visit_type_uint64(v, NULL, &res, &err);
> -    error_free_or_abort(&err);
> +    visit_type_uint64(v, NULL, &res, &error_abort);
> +    g_assert_cmpuint(res, =3D=3D, 18446744073709551574U);
>=20=20
>      visit_type_number(v, NULL, &dbl, &error_abort);
>  }
> diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
> index a16c8f663f..d23c8eb352 100644
> --- a/tests/test-qobject-output-visitor.c
> +++ b/tests/test-qobject-output-visitor.c
> @@ -602,14 +602,26 @@ static void check_native_list(QObject *qobj,
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
> +        for (i =3D 0; i < 32; i++) {
> +            QObject *tmp;
> +            QNum *qvalue;
> +
> +            tmp =3D qlist_peek(qlist);
> +            g_assert(tmp);
> +            qvalue =3D qobject_to_qnum(tmp);
> +            g_assert_cmpuint(qnum_get_uint(qvalue), =3D=3D, i);

You use qnum_get_uint() here, but...

> +            qobject_decref(qlist_pop(qlist));
> +        }
> +        break;
> +
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S8:
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S16:
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S32:
> +    case USER_DEF_NATIVE_LIST_UNION_KIND_S64:
>          /*
>           * All integer elements in JSON arrays get stored into QNums
>           * when we convert to QObjects, so we can check them all in
            * the same fashion, so simply fall through here.
            */
       case USER_DEF_NATIVE_LIST_UNION_KIND_INTEGER:
           for (i =3D 0; i < 32; i++) {
               QObject *tmp;
               QNum *qvalue;
               int64_t val;

               tmp =3D qlist_peek(qlist);
               g_assert(tmp);
               qvalue =3D qobject_to_qnum(tmp);
               g_assert(qnum_get_try_int(qvalue, &val));

qnum_get_try_int() here.  Either is fine with me, but let's to it the
same way.

You seem to prefer qnum_get_try_int() elsewhere in tests, probably
because it fails more nicely, at the cost of one extra line.  I don't
mind.

               g_assert_cmpint(val, =3D=3D, i);
               qobject_decref(qlist_pop(qlist));
           }
           break;

With that tidied up, my R-by stands.
