Received: from eggs.gnu.org ([2001:4830:134:3::10]:46376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gDRnh-0007Bs-VR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gDRnd-0008Il-4D
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:14:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gDRna-0008DY-Ol
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:14:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id d14-v6so37629223qto.4
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 03:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181018223501.21683-1-jusual@mail.ru>
	<20181018223501.21683-4-jusual@mail.ru>
In-Reply-To: <20181018223501.21683-4-jusual@mail.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 19 Oct 2018 14:14:17 +0400
Message-ID: <CAMxuvawrC2xEHPJ=4y3+odxc4H4Ot1HufxKCBWU5qBX4VoaE4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] tests/test-char: Check websocket
 chardev functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jusual@mail.ru
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange,
	Daniel" <berrange@redhat.com>, "Blake, Eric" <eblake@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, joel@jms.id.au, jim@groklearning.com, mail@steffen-goertz.de

Hi

On Fri, Oct 19, 2018 at 2:35 AM Julia Suvorova <jusual@mail.ru> wrote:
>
> Test order:
>     Creating server websocket chardev
>     Creating usual tcp chardev client
>     Sending handshake message from client
>     Receiving handshake reply
>     Sending ping frame with "hello" payload
>     Receiving pong reply
>     Sending binary data "world"
>     Checking the received data on server side
>     Checking of closing handshake
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/test-char.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 831e37fbf4..19c3efad72 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -420,6 +420,130 @@ static void char_socket_fdpass_test(void)
>  }
>
>
> +static void websock_server_read(void *opaque, const uint8_t *buf, int si=
ze)
> +{
> +    g_assert_cmpint(size, =3D=3D, 5);
> +    g_assert(memcmp(buf, "world", size) =3D=3D 0);
> +    quit =3D true;
> +}
> +
> +
> +static int websock_server_can_read(void *opaque)
> +{
> +    return 10;
> +}
> +
> +
> +static bool websock_check_http_headers(char *buf, int size)
> +{
> +    int i;
> +    const char *ans[] =3D { "HTTP/1.1 101 Switching Protocols\r\n",
> +                          "Server: QEMU VNC\r\n",
> +                          "Upgrade: websocket\r\n",
> +                          "Connection: Upgrade\r\n",
> +                          "Sec-WebSocket-Accept:",
> +                          "Sec-WebSocket-Protocol: binary\r\n" };
> +
> +    for (i =3D 0; i < 6; i++) {
> +        if (g_strstr_len(buf, size, ans[i]) =3D=3D NULL) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +
> +static void websock_client_read(void *opaque, const uint8_t *buf, int si=
ze)
> +{
> +    const uint8_t ping[] =3D { 0x89, 0x85,                  /* Ping head=
er */
> +                             0x07, 0x77, 0x9e, 0xf9,      /* Masking key=
 */
> +                             0x6f, 0x12, 0xf2, 0x95, 0x68 /* "hello" */ =
};
> +
> +    const uint8_t binary[] =3D { 0x82, 0x85,                  /* Binary =
header */
> +                               0x74, 0x90, 0xb9, 0xdf,      /* Masking k=
ey */
> +                               0x03, 0xff, 0xcb, 0xb3, 0x10 /* "world" *=
/ };
> +    Chardev *chr_client =3D opaque;
> +
> +    if (websock_check_http_headers((char *) buf, size)) {
> +        qemu_chr_fe_write(chr_client->be, ping, sizeof(ping));
> +    } else if (buf[0] =3D=3D 0x8a && buf[1] =3D=3D 0x05) {
> +        g_assert(strncmp((char *) buf + 2, "hello", 5) =3D=3D 0);
> +        qemu_chr_fe_write(chr_client->be, binary, sizeof(binary));
> +    } else {
> +        g_assert(buf[0] =3D=3D 0x88 && buf[1] =3D=3D 0x16);
> +        g_assert(strncmp((char *) buf + 4, "peer requested close", 10) =
=3D=3D 0);
> +        quit =3D true;
> +    }
> +}
> +
> +
> +static int websock_client_can_read(void *opaque)
> +{
> +    return 4096;
> +}
> +
> +
> +static void char_websock_test(void)
> +{
> +    QObject *addr;
> +    QDict *qdict;
> +    const char *port;
> +    char *tmp;
> +    char *handshake_port;
> +    CharBackend be;
> +    CharBackend client_be;
> +    Chardev *chr_client;
> +    Chardev *chr =3D qemu_chr_new("server",
> +                                "websocket:127.0.0.1:0,server,nowait");
> +    const char handshake[] =3D "GET / HTTP/1.1\r\n"
> +                             "Upgrade: websocket\r\n"
> +                             "Connection: Upgrade\r\n"
> +                             "Host: localhost:%s\r\n"
> +                             "Origin: http://localhost:%s\r\n"
> +                             "Sec-WebSocket-Key: o9JHNiS3/0/0zYE1wa3yIw=
=3D=3D\r\n"
> +                             "Sec-WebSocket-Version: 13\r\n"
> +                             "Sec-WebSocket-Protocol: binary\r\n\r\n";
> +    const uint8_t close[] =3D { 0x88, 0x82,             /* Close header =
*/
> +                              0xef, 0xaa, 0xc5, 0x97, /* Masking key */
> +                              0xec, 0x42              /* Status code */ =
};
> +
> +    addr =3D object_property_get_qobject(OBJECT(chr), "addr", &error_abo=
rt);
> +    qdict =3D qobject_to(QDict, addr);
> +    port =3D qdict_get_str(qdict, "port");
> +    tmp =3D g_strdup_printf("tcp:127.0.0.1:%s", port);
> +    handshake_port =3D g_strdup_printf(handshake, port, port);
> +    qobject_unref(qdict);
> +
> +    qemu_chr_fe_init(&be, chr, &error_abort);
> +    qemu_chr_fe_set_handlers(&be, websock_server_can_read, websock_serve=
r_read,
> +                             NULL, NULL, chr, NULL, true);
> +
> +    chr_client =3D qemu_chr_new("client", tmp);
> +    qemu_chr_fe_init(&client_be, chr_client, &error_abort);
> +    qemu_chr_fe_set_handlers(&client_be, websock_client_can_read,
> +                             websock_client_read,
> +                             NULL, NULL, chr_client, NULL, true);
> +    g_free(tmp);
> +
> +    qemu_chr_write_all(chr_client,
> +                       (uint8_t *) handshake_port,
> +                       strlen(handshake_port));
> +    g_free(handshake_port);
> +    main_loop();
> +
> +    g_assert(object_property_get_bool(OBJECT(chr), "connected", &error_a=
bort));
> +    g_assert(object_property_get_bool(OBJECT(chr_client),
> +                                      "connected", &error_abort));
> +
> +    qemu_chr_write_all(chr_client, close, sizeof(close));
> +    main_loop();
> +
> +    object_unparent(OBJECT(chr_client));
> +    object_unparent(OBJECT(chr));
> +}
> +
> +
>  #ifndef _WIN32
>  static void char_pipe_test(void)
>  {
> @@ -842,6 +966,7 @@ int main(int argc, char **argv)
>      g_test_add_func("/char/serial", char_serial_test);
>  #endif
>      g_test_add_func("/char/hotswap", char_hotswap_test);
> +    g_test_add_func("/char/websocket", char_websock_test);
>
>      return g_test_run();
>  }
> --
> 2.17.1
>
