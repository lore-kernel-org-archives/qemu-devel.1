Received: from eggs.gnu.org ([2001:4830:134:3::10]:34239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG9Cq-0005Qg-LZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG9Cp-0005Tx-EB
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:22:56 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:32891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dG9Cp-0005TS-2p
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:22:55 -0400
Received: by mail-lf0-x244.google.com with SMTP id u62so67977lfg.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-8-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 May 2017 19:22:43 +0000
Message-ID: <CAJ+F1CKGV72FzogF-nnOieCjrRf+waSfsVne2J7eDUoGC8GbQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/13] test-char: split char_udp_test
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

On Tue, May 30, 2017 at 6:02 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
wrote:

> makes it possible to test the existing chardev-udp
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/test-char.c | 58
> +++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 41 insertions(+), 17 deletions(-)
>
> diff --git a/tests/test-char.c b/tests/test-char.c
> index d63d3d2..ad0752a 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -413,16 +413,11 @@ static void char_pipe_test(void)
>  }
>  #endif
>
> -static void char_udp_test(void)
> +static int make_udp_socket(int *port)
>  {
> -    struct sockaddr_in addr =3D { 0, }, other;
> -    SocketIdleData d =3D { 0, };
> -    Chardev *chr;
> -    CharBackend be;
> +    struct sockaddr_in addr =3D { 0, };
>      socklen_t alen =3D sizeof(addr);
>      int ret, sock =3D qemu_socket(PF_INET, SOCK_DGRAM, 0);
> -    char buf[10];
> -    char *tmp;
>
>      g_assert_cmpint(sock, >, 0);
>      addr.sin_family =3D AF_INET ;
> @@ -433,19 +428,41 @@ static void char_udp_test(void)
>      ret =3D getsockname(sock, (struct sockaddr *)&addr, &alen);
>      g_assert_cmpint(ret, =3D=3D, 0);
>
> -    tmp =3D g_strdup_printf("udp:127.0.0.1:%d",
> -                          ntohs(addr.sin_port));
> -    chr =3D qemu_chr_new("client", tmp);
> -    g_assert_nonnull(chr);
> +    *port =3D ntohs(addr.sin_port);
> +    return sock;
> +}
> +
> +static void char_udp_test_internal(Chardev *reuse_chr, int sock)
> +{
> +    struct sockaddr_in other;
> +    SocketIdleData d =3D { 0, };
> +    Chardev *chr;
> +    CharBackend *be;
> +    socklen_t alen =3D sizeof(other);
> +    int ret;
> +    char buf[10];
> +    char *tmp =3D NULL;
> +
> +    if (reuse_chr) {
> +        chr =3D reuse_chr;
> +        be =3D chr->be;
> +    } else {
> +        int port;
> +        sock =3D make_udp_socket(&port);
> +        tmp =3D g_strdup_printf("udp:127.0.0.1:%d", port);
> +        chr =3D qemu_chr_new("client", tmp);
> +        g_assert_nonnull(chr);
> +
> +        be =3D g_alloca(sizeof(CharBackend));
> +        qemu_chr_fe_init(be, chr, &error_abort);
> +    }
>
>      d.chr =3D chr;
> -    qemu_chr_fe_init(&be, chr, &error_abort);
> -    qemu_chr_fe_set_handlers(&be, socket_can_read_hello,
> socket_read_hello,
> +    qemu_chr_fe_set_handlers(be, socket_can_read_hello, socket_read_hell=
o,
>                               NULL, NULL, &d, NULL, true);
>      ret =3D qemu_chr_write_all(chr, (uint8_t *)"hello", 5);
>      g_assert_cmpint(ret, =3D=3D, 5);
>
> -    alen =3D sizeof(addr);
>      ret =3D recvfrom(sock, buf, sizeof(buf), 0,
>                     (struct sockaddr *)&other, &alen);
>      g_assert_cmpint(ret, =3D=3D, 5);
> @@ -454,10 +471,17 @@ static void char_udp_test(void)
>
>      main_loop();
>
> -    close(sock);
> +    if (!reuse_chr) {
> +        close(sock);
> +        qemu_chr_fe_deinit(be);
> +        object_unparent(OBJECT(chr));
> +    }
>      g_free(tmp);
> -    qemu_chr_fe_deinit(&be);
> -    object_unparent(OBJECT(chr));
> +}
> +
> +static void char_udp_test(void)
> +{
> +    char_udp_test_internal(NULL, 0);
>  }
>
>  static void char_file_test(void)
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
