Received: from eggs.gnu.org ([2001:4830:134:3::10]:59864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1driDv-00088t-Pp
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1driDu-0006bc-G9
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:15:19 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-29-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <52e5f270-4648-b3ce-bdaf-c4b59700ff01@redhat.com>
Date: Tue, 12 Sep 2017 12:14:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-29-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 28/38] libqtest: Add qtest_[v]startf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Ben Warren <ben@skyportsystems.com>, "open list:IDE" <qemu-block@nongnu.org>

On 11.09.2017 19:20, Eric Blake wrote:
> We have several callers that were formatting the argument strings
> themselves; consolidate this effort by adding new convenience
> functions directly in libqtest, and update all call-sites that
> can benefit from it.
[...]
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index e8c2e11817..b535d7768f 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -245,6 +245,27 @@ QTestState *qtest_start(const char *extra_args)
>      return global_qtest =3D s;
>  }
>=20
> +QTestState *qtest_vstartf(const char *fmt, va_list ap)
> +{
> +    char *args =3D g_strdup_vprintf(fmt, ap);
> +    QTestState *s;
> +
> +    s =3D qtest_start(args);
> +    global_qtest =3D NULL;

Don't you need a g_free(args) here?

> +    return s;
> +}
> +
> +QTestState *qtest_startf(const char *fmt, ...)
> +{
> +    va_list ap;
> +    QTestState *s;
> +
> +    va_start(ap, fmt);
> +    s =3D qtest_vstartf(fmt, ap);
> +    va_end(ap);
> +    return s;
> +}
[...]
> diff --git a/tests/e1000-test.c b/tests/e1000-test.c
> index 0c5fcdcc44..12bc526ad6 100644
> --- a/tests/e1000-test.c
> +++ b/tests/e1000-test.c
> @@ -14,16 +14,8 @@
>  static void test_device(gconstpointer data)
>  {
>      const char *model =3D data;
> -    QTestState *s;
> -    char *args;
>=20
> -    args =3D g_strdup_printf("-device %s", model);
> -    s =3D qtest_start(args);
> -
> -    if (s) {
> -        qtest_quit(s);
> -    }
> -    g_free(args);
> +    qtest_quit(qtest_startf("-device %s", model));

Just my personal taste, but I think I'd be nicer to keep this on
separate lines:

    QTestState *s;

    s =3D qtest_startf("-device %s", model);
    qtest_quit(s);

>  }
[...]
> diff --git a/tests/eepro100-test.c b/tests/eepro100-test.c
> index bdc8a67d57..fc9ea84d66 100644
> --- a/tests/eepro100-test.c
> +++ b/tests/eepro100-test.c
> @@ -13,18 +13,9 @@
>  static void test_device(gconstpointer data)
>  {
>      const char *model =3D data;
> -    QTestState *s;
> -    char *args;
> -
> -    args =3D g_strdup_printf("-device %s", model);
> -    s =3D qtest_start(args);
>=20
>      /* Tests only initialization so far. TODO: Implement functional te=
sts */
> -
> -    if (s) {
> -        qtest_quit(s);
> -    }
> -    g_free(args);
> +    qtest_quit(qtest_startf("-device %s", model));
>  }

dito

[...]
> diff --git a/tests/numa-test.c b/tests/numa-test.c
> index fa21d26935..e2f6c68be8 100644
> --- a/tests/numa-test.c
> +++ b/tests/numa-test.c
> @@ -12,20 +12,14 @@
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
>=20
> -static char *make_cli(const char *generic_cli, const char *test_cli)
> -{
> -    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", te=
st_cli);
> -}
> -
>  static void test_mon_explicit(const void *data)
>  {
>      char *s;
> -    char *cli;
> +    const char *args =3D data;
>=20
> -    cli =3D make_cli(data, "-smp 8 "
> -                   "-numa node,nodeid=3D0,cpus=3D0-3 "
> -                   "-numa node,nodeid=3D1,cpus=3D4-7 ");
> -    qtest_start(cli);
> +    global_qtest =3D qtest_startf("%s -smp 8 "
> +                                "-numa node,nodeid=3D0,cpus=3D0-3 "
> +                                "-numa node,nodeid=3D1,cpus=3D4-7 ", a=
rgs);
>=20
>      s =3D hmp("info numa");
>      g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
> @@ -33,16 +27,14 @@ static void test_mon_explicit(const void *data)
>      g_free(s);
>=20
>      qtest_quit(global_qtest);
> -    g_free(cli);
>  }
>=20
>  static void test_mon_default(const void *data)
>  {
>      char *s;
> -    char *cli;
> +    const char *args =3D data;
>=20
> -    cli =3D make_cli(data, "-smp 8 -numa node -numa node");
> -    qtest_start(cli);
> +    global_qtest =3D qtest_startf("%s -smp 8 -numa node -numa node", a=
rgs);
>=20
>      s =3D hmp("info numa");
>      g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
> @@ -50,18 +42,16 @@ static void test_mon_default(const void *data)
>      g_free(s);
>=20
>      qtest_quit(global_qtest);
> -    g_free(cli);
>  }
>=20
>  static void test_mon_partial(const void *data)
>  {
>      char *s;
> -    char *cli;
> +    const char *args =3D data;
>=20
> -    cli =3D make_cli(data, "-smp 8 "
> -                   "-numa node,nodeid=3D0,cpus=3D0-1 "
> -                   "-numa node,nodeid=3D1,cpus=3D4-5 ");
> -    qtest_start(cli);
> +    global_qtest =3D qtest_startf("%s -smp 8 "
> +                                "-numa node,nodeid=3D0,cpus=3D0-1 "
> +                                "-numa node,nodeid=3D1,cpus=3D4-5 ", a=
rgs);

Does GCC emit a warning if you'd used data here directly? Otherwise I
think you could simply do this without the local args variable...

 Thomas
