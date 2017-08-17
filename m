Received: from eggs.gnu.org ([2001:4830:134:3::10]:52030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diJIT-0006bP-2m
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diJIO-0004lf-16
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:49:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diJIN-0004lY-RY
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:49:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-5-marcandre.lureau@redhat.com>
Date: Thu, 17 Aug 2017 13:48:59 +0200
In-Reply-To: <20170727154126.11339-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 27 Jul 2017 17:41:04 +0200")
Message-ID: <87shgqfm8k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/26] qapi: generate a literal qobject for
 introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Replace the generated json string with a literal qobject. The later is
> easier to deal with, at run time, as well as compile time: #if blocks
> can be more easily added than in a json string.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
> index bcf02617dc..1969733971 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -1247,24 +1247,26 @@ static void test_visitor_in_fail_alternate(TestIn=
putVisitorData *data,
>  }
>=20=20
>  static void do_test_visitor_in_qmp_introspect(TestInputVisitorData *data,
> -                                              const char *schema_json)
> +                                              const QLitObject *qlit)
>  {
>      SchemaInfoList *schema =3D NULL;
> +    QObject *obj =3D qobject_from_qlit(qlit);
>      Visitor *v;
>=20=20
> -    v =3D visitor_input_test_init_raw(data, schema_json);
> +    v =3D qobject_input_visitor_new(obj);
>=20=20
>      visit_type_SchemaInfoList(v, NULL, &schema, &error_abort);
>      g_assert(schema);
>=20=20
>      qapi_free_SchemaInfoList(schema);
> +    qobject_decref(obj);
>  }

Are you leaking @v?

>=20=20
>  static void test_visitor_in_qmp_introspect(TestInputVisitorData *data,
>                                             const void *unused)
>  {
> -    do_test_visitor_in_qmp_introspect(data, test_qmp_schema_json);
> -    do_test_visitor_in_qmp_introspect(data, qmp_schema_json);
> +    do_test_visitor_in_qmp_introspect(data, &test_qmp_schema_qlit);
> +    do_test_visitor_in_qmp_introspect(data, &qmp_schema_qlit);
>  }
>=20=20
>  int main(int argc, char **argv)
[...]
