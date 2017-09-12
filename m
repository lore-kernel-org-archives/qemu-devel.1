Received: from eggs.gnu.org ([2001:4830:134:3::10]:58322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drekc-0001US-Bu
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 02:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drekY-0006kf-CP
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 02:32:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1drekY-0006kS-3c
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 02:32:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD00DC04B928
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 06:32:44 +0000 (UTC)
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-8-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c12e1b2e-465f-7bf4-fd73-19283bef5647@redhat.com>
Date: Tue, 12 Sep 2017 08:32:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 07/38] libqtest: Inline
 qtest_query_target_endianness()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com

On 11.09.2017 19:19, Eric Blake wrote:
> There was only one caller; it's easier to inline things.  (It
> trades one forward declaration for two others, but it's not
> worth the additional churn of topological sorting, even though
> that would be possible.)
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v7: Drop the topological sorting
> ---
>  tests/libqtest.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
>=20
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 95d4159b38..1710d63276 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -49,7 +49,9 @@ static struct sigaction sigact_old;
>      g_assert_cmpint(ret, !=3D, -1); \
>  } while (0)
>=20
> -static int qtest_query_target_endianness(QTestState *s);
> +static void qtest_sendf(QTestState *s, const char *fmt, ...)
> +    GCC_FMT_ATTR(2, 3);
> +static gchar **qtest_rsp(QTestState *s, int expected_args);
>=20
>  static int init_socket(const char *socket_path)
>  {
> @@ -158,6 +160,7 @@ QTestState *qtest_init_without_qmp_handshake(const =
char *extra_args)
>      gchar *qmp_socket_path;
>      gchar *command;
>      const char *qemu_binary;
> +    gchar **args;
>=20
>      qemu_binary =3D getenv("QTEST_QEMU_BINARY");
>      if (!qemu_binary) {
> @@ -221,8 +224,11 @@ QTestState *qtest_init_without_qmp_handshake(const=
 char *extra_args)
>      }
>=20
>      /* ask endianness of the target */
> -
> -    s->big_endian =3D qtest_query_target_endianness(s);
> +    qtest_sendf(s, "endianness\n");
> +    args =3D qtest_rsp(s, 1);
> +    g_assert(strcmp(args[1], "big") =3D=3D 0 || strcmp(args[1], "littl=
e") =3D=3D 0);
> +    s->big_endian =3D strcmp(args[1], "big") =3D=3D 0;
> +    g_strfreev(args);
>=20
>      return s;
>  }
> @@ -367,20 +373,6 @@ redo:
>      return words;
>  }
>=20
> -static int qtest_query_target_endianness(QTestState *s)
> -{
> -    gchar **args;
> -    int big_endian;
> -
> -    qtest_sendf(s, "endianness\n");
> -    args =3D qtest_rsp(s, 1);
> -    g_assert(strcmp(args[1], "big") =3D=3D 0 || strcmp(args[1], "littl=
e") =3D=3D 0);
> -    big_endian =3D strcmp(args[1], "big") =3D=3D 0;
> -    g_strfreev(args);
> -
> -    return big_endian;
> -}
> -
>  typedef struct {
>      JSONMessageParser parser;
>      QDict *response;

Looking at this patch again, I'm not sure anymore whether this is really
worth the effort. Keeping code that belongs together in a separate
function also makes sense ... Not sure, but I'd maybe rather drop this
patch. But in case you want to keep it:

Reviewed-by: Thomas Huth <thuth@redhat.com>
