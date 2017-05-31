Received: from eggs.gnu.org ([2001:4830:134:3::10]:35126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG9Fi-0007QT-DW
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG9Fh-0007Jw-1o
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:25:54 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dG9Fg-0007JF-MU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:25:52 -0400
Received: by mail-lf0-x242.google.com with SMTP id 99so2295906lfu.2
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-10-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-10-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 May 2017 19:25:40 +0000
Message-ID: <CAJ+F1C+Ha_Y3+-ka4qZJ_JL+0sVc3OYRrY5p2-PFcGcvgvwXPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/13] test-char: add hotswap test
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

Hi

On Tue, May 30, 2017 at 6:15 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
wrote:

> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  tests/test-char.c | 68
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/tests/test-char.c b/tests/test-char.c
> index ed6b18f..cd54f88 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -635,6 +635,73 @@ static void char_invalid_test(void)
>      g_assert_null(chr);
>  }
>
> +static int chardev_change(void *opaque)
> +{
> +    return 0;
> +}
> +
> +static int chardev_change_denied(void *opaque)
> +{
> +    return -1;
> +}
> +
> +static void char_hotswap_test(void)
> +{
> +    char *chr_args;
> +    Chardev *chr;
> +    CharBackend be;
> +
> +    gchar *tmp_path =3D g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
> +    char *filename =3D g_build_filename(tmp_path, "file", NULL);
> +    ChardevFile file =3D { .out =3D filename };
> +    ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_FILE,
> +                               .u.file.data =3D &file };
> +
> +    int port;
> +    int sock =3D make_udp_socket(&port);
> +    g_assert_cmpint(sock, >, 0);
> +
> +    chr_args =3D g_strdup_printf("udp:127.0.0.1:%d", port);
> +
> +    chr =3D qemu_chr_new("chardev", chr_args);
> +    qemu_chr_fe_init(&be, chr, &error_abort);
> +
> +    /* check that chardev operates correctly */
> +    char_udp_test_internal(chr, sock);
> +
> +    /* set the handler that denies the hotswap */
> +    qemu_chr_fe_set_handlers(&be, NULL, NULL,
> +                             NULL, chardev_change_denied, NULL, NULL,
> true);
> +
> +    /* now, change is denied and has to keep the old backend operating *=
/
> +    qmp_chardev_change("chardev", &backend, NULL);
>

Please add qapi_free_ChardevReturn(ret);

other than that:

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

+    g_assert(be.chr =3D=3D chr);
> +
> +    char_udp_test_internal(chr, sock);
> +
> +    /* now allow the change */
> +    qemu_chr_fe_set_handlers(&be, NULL, NULL,
> +                             NULL, chardev_change, NULL, NULL, true);
> +
> +    /* has to succeed now */
> +    qmp_chardev_change("chardev", &backend, &error_abort);
> +    g_assert(be.chr !=3D chr);
> +
> +    close(sock);
> +    chr =3D be.chr;
> +
> +    /* run the file chardev test */
> +    char_file_test_internal(chr, filename);
> +
> +    object_unparent(OBJECT(chr));
> +
> +    g_unlink(filename);
> +    g_free(filename);
> +    g_rmdir(tmp_path);
> +    g_free(tmp_path);
> +    g_free(chr_args);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      qemu_init_main_loop(&error_abort);
> @@ -666,6 +733,7 @@ int main(int argc, char **argv)
>  #endif
>      g_test_add_func("/char/socket", char_socket_test);
>      g_test_add_func("/char/udp", char_udp_test);
> +    g_test_add_func("/char/hotswap", char_hotswap_test);
>
>      return g_test_run();
>  }
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
