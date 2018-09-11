Received: from eggs.gnu.org ([2001:4830:134:3::10]:50891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzj0R-0007kx-1C
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzj0N-0001VW-1T
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:47:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzj0M-0001VN-QD
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:46:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42B5C34670
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 13:46:58 +0000 (UTC)
References: <20180823143125.16767-1-marcandre.lureau@redhat.com>
	<20180823143125.16767-5-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e56d721b-0e38-8cde-d432-03bf81f3174c@redhat.com>
Date: Tue, 11 Sep 2018 15:46:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180823143125.16767-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] test-char: fix random socket test
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com

On 23/08/2018 16:31, Marc-Andr=C3=A9 Lureau wrote:
> Peter reported a test failure on FreeBSD with the new reconnect test:
>=20
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> gtester -k --verbose -m=3Dquick tests/test-char
> TEST: tests/test-char... (pid=3D16190)
>   /char/null:                                                          =
OK
>   /char/invalid:                                                       =
OK
>   /char/ringbuf:                                                       =
OK
>   /char/mux:                                                           =
OK
>   /char/stdio:                                                         =
OK
>   /char/pipe:                                                          =
OK
>   /char/file:                                                          =
OK
>   /char/file-fifo:                                                     =
OK
>   /char/udp:                                                           =
OK
>   /char/serial:                                                        =
OK
>   /char/hotswap:                                                       =
OK
>   /char/socket/basic:                                                  =
OK
>   /char/socket/reconnect:                                              =
FAIL
> GTester: last random seed: R02S521380d9c12f1dac3ad1763bf5665c27
> (pid=3D16367)
>   /char/socket/fdpass:                                                 =
OK
> FAIL: tests/test-char
> **
> ERROR:tests/test-char.c:353:char_socket_test_common: assertion failed:
> (object_property_get_bool(OBJECT(chr_client), "connected",
> &error_abort))
>=20
> It turns out that the socket test code checks both server and client
> connection states, but doesn't wait for both.
>=20
> Wait for the client side as well.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-char.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 5905d31441..2b1e400542 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -349,6 +349,12 @@ static void char_socket_test_common(Chardev *chr)
>      g_assert_cmpint(id, >, 0);
>      main_loop();
> =20
> +    d.chr =3D chr_client;
> +    id =3D g_idle_add(char_socket_test_idle, &d);
> +    g_source_set_name_by_id(id, "test-idle");
> +    g_assert_cmpint(id, >, 0);
> +    main_loop();
> +
>      g_assert(object_property_get_bool(OBJECT(chr), "connected", &error=
_abort));
>      g_assert(object_property_get_bool(OBJECT(chr_client),
>                                        "connected", &error_abort));
> @@ -358,6 +364,7 @@ static void char_socket_test_common(Chardev *chr)
> =20
>      object_unparent(OBJECT(chr_client));
> =20
> +    d.chr =3D chr;
>      d.conn_expected =3D false;
>      g_idle_add(char_socket_test_idle, &d);
>      main_loop();
>=20

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
