Received: from eggs.gnu.org ([2001:4830:134:3::10]:57571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciLpf-0007lt-Sy
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciLpc-0006DV-UM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:59:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciLpc-0006DN-O3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:59:16 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C90DB61D11
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 13:59:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-12-marcandre.lureau@redhat.com>
Date: Mon, 27 Feb 2017 14:59:13 +0100
In-Reply-To: <20170221141451.28305-12-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 21 Feb 2017
	18:14:32 +0400")
Message-ID: <871sujg2fi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/30] tests: fix hd-geo-test leaks
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

> Spotted by ASAN.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/hd-geo-test.c | 47 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
>
> diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
> index 6176e81ab2..88f8d76d32 100644
> --- a/tests/hd-geo-test.c
> +++ b/tests/hd-geo-test.c
> @@ -19,6 +19,8 @@
>  #include "qemu-common.h"
>  #include "libqtest.h"
>=20=20
> +#define ARGV_SIZE 256
> +
>  static char *create_test_img(int secs)
>  {
>      char *template =3D strdup("/tmp/qtest.XXXXXX");
> @@ -66,7 +68,7 @@ static const CHST hd_chst[backend_last][mbr_last] =3D {
>      },
>  };
>=20=20
> -static const char *img_file_name[backend_last];
> +static char *img_file_name[backend_last];
>=20=20
>  static const CHST *cur_ide[4];
>=20=20
> @@ -234,28 +236,34 @@ static int setup_ide(int argc, char *argv[], int ar=
gv_sz,
>   */
>  static void test_ide_none(void)
>  {
> -    char *argv[256];
> +    char **argv =3D g_new0(char *, ARGV_SIZE);
> +    char *tmp;
>=20=20
> -    setup_common(argv, ARRAY_SIZE(argv));
> -    qtest_start(g_strjoinv(" ", argv));
> +    setup_common(argv, ARGV_SIZE);
> +    qtest_start(tmp =3D g_strjoinv(" ", argv));

While I'm totally fine with things like while ((tmp =3D ...)) when the
result is more concise, I don't like this.  Please do

       tmp =3D g_strjoinv(" ", argv);
       qtest_start(tmp);

Also, please rename tmp to extra_args, argstr, or maybe args.

> +    g_strfreev(argv);
> +    g_free(tmp);
>      test_cmos();
>      qtest_end();
>  }

I think we should have a qtest_startv() that takes an argv[] and doesn't
use the shell to split arguments.  Outside this patch's scope.

[More of the same snipped...]

With the stylistic changes outlined above:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
