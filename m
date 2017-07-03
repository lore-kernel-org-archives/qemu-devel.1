Received: from eggs.gnu.org ([2001:4830:134:3::10]:52270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dS1P8-0002pS-Td
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dS1P7-0000Th-Op
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:28:42 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dS1P7-0000TR-CZ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:28:41 -0400
Received: by mail-lf0-x244.google.com with SMTP id f28so15185651lfi.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 06:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1499082038.git.tgolembi@redhat.com>
	<217e64d171636218b61c41f1f70e72cdb40f9144.1499082038.git.tgolembi@redhat.com>
In-Reply-To: <217e64d171636218b61c41f1f70e72cdb40f9144.1499082038.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 03 Jul 2017 13:28:29 +0000
Message-ID: <CAJ+F1CJ90ua2hirb8LC1346mxVJUO96eaa5nAEGLUz8ve6K14Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 2/3] test-qga: pass environemnt to
 qemu-ga
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

On Mon, Jul 3, 2017 at 1:40 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com>
wrote:

> Modify fixture_setup() to pass environemnt variables to spawned qemu-ga
> instance.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


---
>  tests/test-qga.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index c77f241036..631b98639a 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -46,7 +46,7 @@ static void qga_watch(GPid pid, gint status, gpointer
> user_data)
>  }
>
>  static void
> -fixture_setup(TestFixture *fixture, gconstpointer data)
> +fixture_setup(TestFixture *fixture, gconstpointer data, gchar **envp)
>  {
>      const gchar *extra_arg =3D data;
>      GError *error =3D NULL;
> @@ -67,7 +67,7 @@ fixture_setup(TestFixture *fixture, gconstpointer data)
>      g_shell_parse_argv(cmd, NULL, &argv, &error);
>      g_assert_no_error(error);
>
> -    g_spawn_async(fixture->test_dir, argv, NULL,
> +    g_spawn_async(fixture->test_dir, argv, envp,
>                    G_SPAWN_SEARCH_PATH|G_SPAWN_DO_NOT_REAP_CHILD,
>                    NULL, NULL, &fixture->pid, &error);
>      g_assert_no_error(error);
> @@ -707,7 +707,7 @@ static void test_qga_blacklist(gconstpointer data)
>      QDict *ret, *error;
>      const gchar *class, *desc;
>
> -    fixture_setup(&fix, "-b guest-ping,guest-get-time");
> +    fixture_setup(&fix, "-b guest-ping,guest-get-time", NULL);
>
>      /* check blacklist */
>      ret =3D qmp_fd(fix.fd, "{'execute': 'guest-ping'}");
> @@ -943,7 +943,7 @@ int main(int argc, char **argv)
>
>      setlocale (LC_ALL, "");
>      g_test_init(&argc, &argv, NULL);
> -    fixture_setup(&fix, NULL);
> +    fixture_setup(&fix, NULL, NULL);
>
>      g_test_add_data_func("/qga/sync-delimited", &fix,
> test_qga_sync_delimited);
>      g_test_add_data_func("/qga/sync", &fix, test_qga_sync);
> --
> 2.13.1
>
> --
Marc-Andr=C3=A9 Lureau
