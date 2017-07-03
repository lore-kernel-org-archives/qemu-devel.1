Received: from eggs.gnu.org ([2001:4830:134:3::10]:43699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dS2Nv-0001X7-Os
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dS2Nu-0006iQ-CQ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:31:31 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dS2Nt-0006hZ-VZ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:31:30 -0400
Received: by mail-lf0-x241.google.com with SMTP id t72so15399663lff.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 07:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1499082038.git.tgolembi@redhat.com>
	<d1ee0939a084ec0f120dbf7831cb7985123f7774.1499082038.git.tgolembi@redhat.com>
In-Reply-To: <d1ee0939a084ec0f120dbf7831cb7985123f7774.1499082038.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 03 Jul 2017 14:31:18 +0000
Message-ID: <CAJ+F1CJQA-S+4z0tHm6HR2R4AUp31ajfC8+YMXhTXCjzKNuHAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 3/3] test-qga: add test for
 guest-get-osinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Mon, Jul 3, 2017 at 1:40 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com>
wrote:

> Add test for guest-get-osinfo command.
>
> Qemu-ga was modified to accept QGA_OS_RELEASE environment variable. If
> the variable is defined it is interpreted as path to the os-release file
> and it is parsed instead of the default paths.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c           | 13 +++++++---
>  tests/data/test-qga-os-release |  7 ++++++
>  tests/test-qga.c               | 55
> ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+), 3 deletions(-)
>  create mode 100644 tests/data/test-qga-os-release
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 7a933a5f12..16b18c96ef 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2683,9 +2683,16 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>      info->kernel_release =3D g_strdup(kinfo.release);
>      info->machine_hardware =3D g_strdup(kinfo.machine);
>
> -    GKeyFile *osrelease =3D ga_parse_osrelease("/etc/os-release");
> -    if (osrelease =3D=3D NULL) {
> -        osrelease =3D ga_parse_osrelease("/usr/lib/os-release");
> +    GKeyFile *osrelease =3D NULL;
> +
> +    const char *qga_os_release =3D g_getenv("QGA_OS_RELEASE");
> +    if (qga_os_release !=3D NULL) {
> +        osrelease =3D ga_parse_osrelease(qga_os_release);
> +    } else {
> +        osrelease =3D ga_parse_osrelease("/etc/os-release");
> +        if (osrelease =3D=3D NULL) {
> +            osrelease =3D ga_parse_osrelease("/usr/lib/os-release");
> +        }
>      }
>
>      if (osrelease !=3D NULL) {
> diff --git a/tests/data/test-qga-os-release
> b/tests/data/test-qga-os-release
> new file mode 100644
> index 0000000000..70664eb6ec
> --- /dev/null
> +++ b/tests/data/test-qga-os-release
> @@ -0,0 +1,7 @@
> +ID=3Dqemu-ga-test
> +NAME=3DQEMU-GA
> +PRETTY_NAME=3D"QEMU Guest Agent test"
> +VERSION=3D"Test 1"
> +VERSION_ID=3D1
> +VARIANT=3D"Unit test \"\'\$\`\\ and \\\\ etc."
> +VARIANT_ID=3Dunit-test
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index 631b98639a..c151dfdc34 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -936,6 +936,59 @@ static void test_qga_guest_exec_invalid(gconstpointe=
r
> fix)
>      QDECREF(ret);
>  }
>
> +static void test_qga_guest_get_osinfo(gconstpointer data)
> +{
> +    TestFixture fixture;
> +    const gchar *str;
> +    gchar *cwd, *env[2];
> +    QDict *ret, *val;
> +
> +    cwd =3D g_get_current_dir();
> +    env[0] =3D g_strdup_printf(
> +        "QGA_OS_RELEASE=3D%s%ctests%cdata%ctest-qga-os-release",
> +        cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
> +    env[1] =3D NULL;
> +    g_free(cwd);
> +    fixture_setup(&fixture, NULL, env);
> +
> +    ret =3D qmp_fd(fixture.fd, "{'execute': 'guest-get-osinfo'}");
> +    g_assert_nonnull(ret);
> +    qmp_assert_no_error(ret);
> +
> +    val =3D qdict_get_qdict(ret, "return");
> +
> +    str =3D qdict_get_try_str(val, "id");
> +    g_assert_nonnull(str);
> +    g_assert_cmpstr(str, =3D=3D, "qemu-ga-test");
> +
> +    str =3D qdict_get_try_str(val, "name");
> +    g_assert_nonnull(str);
> +    g_assert_cmpstr(str, =3D=3D, "QEMU-GA");
> +
> +    str =3D qdict_get_try_str(val, "pretty-name");
> +    g_assert_nonnull(str);
> +    g_assert_cmpstr(str, =3D=3D, "QEMU Guest Agent test");
> +
> +    str =3D qdict_get_try_str(val, "version");
> +    g_assert_nonnull(str);
> +    g_assert_cmpstr(str, =3D=3D, "Test 1");
> +
> +    str =3D qdict_get_try_str(val, "version-id");
> +    g_assert_nonnull(str);
> +    g_assert_cmpstr(str, =3D=3D, "1");
> +
> +    str =3D qdict_get_try_str(val, "variant");
> +    g_assert_nonnull(str);
> +    g_assert_cmpstr(str, =3D=3D, "Unit test \"'$`\\ and \\\\ etc.");
> +
> +    str =3D qdict_get_try_str(val, "variant-id");
> +    g_assert_nonnull(str);
> +    g_assert_cmpstr(str, =3D=3D, "unit-test");
> +
> +    QDECREF(ret);
> +    g_free(env[0]);
>

 +    fixture_tear_down(&fixture, NULL);

+}
> +
>  int main(int argc, char **argv)
>  {
>      TestFixture fix;
> @@ -972,6 +1025,8 @@ int main(int argc, char **argv)
>      g_test_add_data_func("/qga/guest-exec", &fix, test_qga_guest_exec);
>      g_test_add_data_func("/qga/guest-exec-invalid", &fix,
>                           test_qga_guest_exec_invalid);
> +    g_test_add_data_func("/qga/guest-get-osinfo", &fix,
> +                         test_qga_guest_get_osinfo);
>
>      if (g_getenv("QGA_TEST_SIDE_EFFECTING")) {
>          g_test_add_data_func("/qga/fsfreeze-and-thaw", &fix,
> --
> 2.13.1
>
>
With that

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau
