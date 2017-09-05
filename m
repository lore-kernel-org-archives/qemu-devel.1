Received: from eggs.gnu.org ([2001:4830:134:3::10]:33737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpDFx-0002C2-My
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpDFs-0005Je-Sx
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:47:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpDFs-0005JC-KF
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:47:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1B4B90143
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 12:46:59 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-28-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ef46a4d8-27f8-296a-1336-2678beb1a332@redhat.com>
Date: Tue, 5 Sep 2017 14:46:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-28-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 27/29] libqtest: Make qtest_init()
 accept format string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On 01.09.2017 20:03, Eric Blake wrote:
> Several callers were formatting a string into a temporary
> variable before calling qtest_init(); factor that into the
> common code.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h         |  7 ++++---
>  tests/libqtest.c         | 13 ++++++++++--
>  tests/bios-tables-test.c |  7 +------
>  tests/postcopy-test.c    |  4 ++--
>  tests/vhost-user-test.c  | 51 ++++++++++++++--------------------------=
--------
>  5 files changed, 33 insertions(+), 49 deletions(-)
>=20
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 3ae570927a..d338de3e22 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -25,11 +25,12 @@ extern QTestState *global_qtest;
>=20
>  /**
>   * qtest_init:
> - * @extra_args: other arguments to pass to QEMU.
> + * @extra_args...: other arguments to pass to QEMU, formatted as if by
> + * sprintf().
>   *
>   * Returns: #QTestState instance.
>   */
> -QTestState *qtest_init(const char *extra_args);
> +QTestState *qtest_init(const char *extra_args, ...) GCC_FMT_ATTR(1, 2)=
;

Maybe the parameter should be called "fmt" or "format" now instead?
(similar to printf() and friends)

>  /**
>   * qtest_init_without_qmp_handshake:
> @@ -518,7 +519,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const voi=
d *data);
>   */
>  static inline QTestState *qtest_start(const char *args)
>  {
> -    global_qtest =3D qtest_init(args);
> +    global_qtest =3D qtest_init("%s", args);

That's a little bit sad that there are some spots which need an explicit
"%s" now ... maybe it would be nicer to add a new function called
qtest_initf() instead and keep the old one (without the "f") as it is?

>      return global_qtest;
>  }
>=20
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index b6dd26e54a..18facbf130 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -347,9 +347,18 @@ QTestState *qtest_init_without_qmp_handshake(const=
 char *extra_args)
>      return s;
>  }
>=20
> -QTestState *qtest_init(const char *extra_args)
> +QTestState *qtest_init(const char *extra_args, ...)
>  {
> -    QTestState *s =3D qtest_init_without_qmp_handshake(extra_args);
> +    va_list ap;
> +    QTestState *s;
> +    char *cmd;
> +
> +    va_start(ap, extra_args);
> +    cmd =3D g_strdup_vprintf(extra_args, ap);
> +    va_end(ap);
> +
> +    s =3D qtest_init_without_qmp_handshake(cmd);
> +    g_free(cmd);
>=20
>      /* Read the QMP greeting and then do the handshake */
>      qtest_qmp_discard_response(s, "");
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 976792f2c5..f8a107499f 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -623,18 +623,14 @@ static void test_smbios_structs(test_data *data)
>=20
>  static void test_acpi_one(const char *params, test_data *data)
>  {
> -    char *args;
> -
>      /* Disable kernel irqchip to be able to override apic irq0. */
> -    args =3D g_strdup_printf("-machine %s,accel=3D%s,kernel-irqchip=3D=
off "
> +    data->qts =3D qtest_init("-machine %s,accel=3D%s,kernel-irqchip=3D=
off "
>                             "-net none -display none %s "
>                             "-drive id=3Dhd0,if=3Dnone,file=3D%s,format=
=3Draw "
>                             "-device ide-hd,drive=3Dhd0 ",
>                             data->machine, "kvm:tcg",
>                             params ? params : "", disk);
>=20
> -    data->qts =3D qtest_init(args);
> -
>      boot_sector_test(data->qts);
>=20
>      test_acpi_rsdp_address(data);
> @@ -657,7 +653,6 @@ static void test_acpi_one(const char *params, test_=
data *data)
>      test_smbios_structs(data);
>=20
>      qtest_quit(data->qts);
> -    g_free(args);
>  }
>=20
>  static uint8_t base_required_struct_types[] =3D {
> diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
> index 0e5fe20a83..20cfb280f6 100644
> --- a/tests/postcopy-test.c
> +++ b/tests/postcopy-test.c
> @@ -403,10 +403,10 @@ static void test_migrate(void)
>=20
>      g_free(bootpath);
>=20
> -    from =3D qtest_init(cmd_src);
> +    from =3D qtest_init("%s", cmd_src);
>      g_free(cmd_src);
>=20
> -    to =3D qtest_init(cmd_dst);
> +    to =3D qtest_init("%s", cmd_dst);
>      g_free(cmd_dst);
>=20
>      assert(!global_qtest);

 Thomas
