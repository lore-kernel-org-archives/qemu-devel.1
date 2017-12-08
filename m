Received: from eggs.gnu.org ([2001:4830:134:3::10]:44747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNMxj-0006ch-2Y
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 13:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNMxi-0000L3-AV
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 13:01:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eNMxi-0000Kk-4R
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 13:01:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F68781DEA
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 18:01:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
	<20171208005825.14587-12-marcandre.lureau@redhat.com>
Date: Fri, 08 Dec 2017 19:01:20 +0100
In-Reply-To: <20171208005825.14587-12-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 8 Dec 2017
	01:58:24 +0100")
Message-ID: <87lgid9k0f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/12] tests: fix qmp-test leak
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

> Direct leak of 913 byte(s) in 43 object(s) allocated from:
>     #0 0x55880a15df60 in __interceptor_malloc (/home/elmarco/src/qq/build=
/tests/qmp-test+0x110f60)
>     #1 0x7f3f20fd098f in _IO_vasprintf (/lib64/libc.so.6+0x8098f)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qmp-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index c5a5c10b41..36feb2204b 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -271,7 +271,7 @@ static void add_query_tests(QmpSchema *schema)
>  {
>      SchemaInfoList *tail;
>      SchemaInfo *si, *arg_type, *ret_type;
> -    const char *test_name;
> +    char *test_name;
>=20=20
>      /* Test the query-like commands */
>      for (tail =3D schema->list; tail; tail =3D tail->next) {
> @@ -297,6 +297,7 @@ static void add_query_tests(QmpSchema *schema)
>=20=20
>          test_name =3D g_strdup_printf("qmp/%s", si->name);
>          qtest_add_data_func(test_name, si->name, test_query);
> +        g_free(test_name);
>      }
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
