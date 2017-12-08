Received: from eggs.gnu.org ([2001:4830:134:3::10]:59980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNFPj-0000hy-F3
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNFPg-0004PE-Di
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:57:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eNFPg-0004Ok-7b
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:57:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 684065AFD9
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 09:57:46 +0000 (UTC)
Date: Fri, 8 Dec 2017 09:57:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171208095739.GC2403@work-vm>
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
	<20171208005825.14587-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171208005825.14587-9-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/12] tests: fix migration-test leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Direct leak of 12 byte(s) in 2 object(s) allocated from:
>     #0 0x7f50d403c850 in malloc (/lib64/libasan.so.4+0xde850)
>     #1 0x7f50d1ddf98f in vasprintf (/lib64/libc.so.6+0x8098f)
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

There's an identical patch on list from Juan from a week ago!
Either way,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/migration-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index be598d3257..799e24ebc6 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -358,13 +358,14 @@ static void migrate_check_parameter(QTestState *w=
ho, const char *parameter,
>                                      const char *value)
>  {
>      QDict *rsp, *rsp_return;
> -    const char *result;
> +    char *result;
> =20
>      rsp =3D wait_command(who, "{ 'execute': 'query-migrate-parameters'=
 }");
>      rsp_return =3D qdict_get_qdict(rsp, "return");
>      result =3D g_strdup_printf("%" PRId64,
>                               qdict_get_try_int(rsp_return,  parameter,=
 -1));
>      g_assert_cmpstr(result, =3D=3D, value);
> +    g_free(result);
>      QDECREF(rsp);
>  }
> =20
> --=20
> 2.15.1.355.g36791d7216
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
