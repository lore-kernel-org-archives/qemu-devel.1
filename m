Received: from eggs.gnu.org ([2001:4830:134:3::10]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG9El-0006fo-2q
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG9Ej-0006kw-Ay
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:24:55 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dG9Ei-0006kG-UM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:24:53 -0400
Received: by mail-lf0-x244.google.com with SMTP id 99so2293926lfu.2
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-9-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-9-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 May 2017 19:24:41 +0000
Message-ID: <CAJ+F1CL+D44iLzM_tEb6=Mw6yWNRPGxvbGpaMWTLsrHHUNq1cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 08/13] test-char: split char_file_test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com

On Tue, May 30, 2017 at 6:15 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
wrote:

> makes it possible to test the existing chardev-file
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  tests/test-char.c | 127
> +++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 79 insertions(+), 48 deletions(-)
>
> diff --git a/tests/test-char.c b/tests/test-char.c
> index ad0752a..ed6b18f 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -484,75 +484,103 @@ static void char_udp_test(void)
>      char_udp_test_internal(NULL, 0);
>  }
>
> -static void char_file_test(void)
> +#ifndef _WIN32
> +static void char_file_fifo_test(void)
>  {
> +    Chardev *chr;
> +    CharBackend be;
>      char *tmp_path =3D g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
> +    char *fifo =3D g_build_filename(tmp_path, "fifo", NULL);
>      char *out =3D g_build_filename(tmp_path, "out", NULL);
> -    char *contents =3D NULL;
> -    ChardevFile file =3D { .out =3D out };
> +    ChardevFile file =3D { .in =3D fifo,
> +                         .has_in =3D true,
> +                         .out =3D out };
>      ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_FILE,
>                                 .u.file.data =3D &file };
> +    FeHandler fe =3D { 0, };
> +    int fd, ret;
> +
> +    if (mkfifo(fifo, 0600) < 0) {
> +        abort();
> +    }
> +
> +    fd =3D open(fifo, O_RDWR);
> +    ret =3D write(fd, "fifo-in", 8);
> +    g_assert_cmpint(ret, =3D=3D, 8);
> +
> +    chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
> +                           &error_abort);
> +
> +    qemu_chr_fe_init(&be, chr, &error_abort);
> +    qemu_chr_fe_set_handlers(&be,
> +                             fe_can_read,
> +                             fe_read,
> +                             fe_event,
> +                             NULL,
> +                             &fe, NULL, true);
> +
> +    main_loop();
> +
> +    close(fd);
> +
> +    g_assert_cmpint(fe.read_count, =3D=3D, 8);
> +    g_assert_cmpstr(fe.read_buf, =3D=3D, "fifo-in");
> +
> +    qemu_chr_fe_deinit(&be);
> +    object_unref(OBJECT(chr));
> +
> +    g_unlink(fifo);
> +    g_free(fifo);
> +    g_unlink(out);
> +    g_free(out);
> +    g_rmdir(tmp_path);
> +    g_free(tmp_path);
> +}
> +#endif
> +
> +static void char_file_test_internal(Chardev *ext_chr, const char
> *filepath)
> +{
> +    char *tmp_path =3D g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
> +    char *out;
>      Chardev *chr;
> +    char *contents =3D NULL;
> +    ChardevFile file =3D {};
> +    ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_FILE,
> +                               .u.file.data =3D &file };
>      gsize length;
>      int ret;
>
> -    chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
> -                           &error_abort);
> +    if (ext_chr) {
> +        chr =3D ext_chr;
> +        out =3D g_strdup(filepath);
> +        file.out =3D out;
> +    } else {
> +        out =3D g_build_filename(tmp_path, "out", NULL);
> +        file.out =3D out;
>
+        chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
> +                               &error_abort);
> +    }
>
     ret =3D qemu_chr_write_all(chr, (uint8_t *)"hello!", 6);
>      g_assert_cmpint(ret, =3D=3D, 6);
> -    object_unref(OBJECT(chr));
>
>      ret =3D g_file_get_contents(out, &contents, &length, NULL);
>      g_assert(ret =3D=3D TRUE);
>      g_assert_cmpint(length, =3D=3D, 6);
>      g_assert(strncmp(contents, "hello!", 6) =3D=3D 0);
> -    g_free(contents);
> -
> -#ifndef _WIN32
> -    {
> -        CharBackend be;
> -        FeHandler fe =3D { 0, };
> -        char *fifo =3D g_build_filename(tmp_path, "fifo", NULL);
> -        int fd;
> -
> -        if (mkfifo(fifo, 0600) < 0) {
> -            abort();
> -        }
> -
> -        fd =3D open(fifo, O_RDWR);
> -        ret =3D write(fd, "fifo-in", 8);
> -        g_assert_cmpint(ret, =3D=3D, 8);
> -
> -        file.in =3D fifo;
> -        file.has_in =3D true;
> -        chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
> -                               &error_abort);
> -
> -        qemu_chr_fe_init(&be, chr, &error_abort);
> -        qemu_chr_fe_set_handlers(&be,
> -                                 fe_can_read,
> -                                 fe_read,
> -                                 fe_event,
> -                                 NULL,
> -                                 &fe, NULL, true);
> -
> -        main_loop();
>
> -        close(fd);
> -
> -        g_assert_cmpint(fe.read_count, =3D=3D, 8);
> -        g_assert_cmpstr(fe.read_buf, =3D=3D, "fifo-in");
> -        qemu_chr_fe_deinit(&be);
> +    if (!ext_chr) {
>          object_unref(OBJECT(chr));
> -        g_unlink(fifo);
> -        g_free(fifo);
> +        g_unlink(out);
> +        g_free(out);
>      }
>

It leaks out in the other case, move the free outside the condition.

other than that:


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>

> -#endif
> -
> -    g_unlink(out);
> +    g_free(contents);
>      g_rmdir(tmp_path);
>      g_free(tmp_path);
> -    g_free(out);
> +}
> +
> +static void char_file_test(void)
> +{
> +    char_file_test_internal(NULL, NULL);
>  }
>
>  static void char_null_test(void)
> @@ -633,6 +661,9 @@ int main(int argc, char **argv)
>      g_test_add_func("/char/pipe", char_pipe_test);
>  #endif
>      g_test_add_func("/char/file", char_file_test);
> +#ifndef _WIN32
> +    g_test_add_func("/char/file-fifo", char_file_fifo_test);
> +#endif
>      g_test_add_func("/char/socket", char_socket_test);
>      g_test_add_func("/char/udp", char_udp_test);
>
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
