Received: from eggs.gnu.org ([2001:4830:134:3::10]:49880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNim-0001gh-BN
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNil-00060G-Gk
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:50:44 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eSNil-0005zW-9k
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:50:43 -0500
Received: by mail-wr0-x243.google.com with SMTP id h1so27945354wre.12
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 05:50:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221212125.19075-5-maxime.coquelin@redhat.com>
References: <20171221212125.19075-1-maxime.coquelin@redhat.com>
	<20171221212125.19075-5-maxime.coquelin@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Dec 2017 14:50:41 +0100
Message-ID: <CAJ+F1CLUOEOrdL1cB73Zr3EWe93w1eNfV5VTi7CES3u0fJv0cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/5] vhost-user-test: make features mask
 an init_virtio_dev() argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Dec 21, 2017 at 10:21 PM, Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
> The goal is to generalize the use of [un]init_virtio_dev() to
> all tests, which does not necessarily expose the same features
> set.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/vhost-user-test.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 969e3932cc..6a144e8d7e 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -164,7 +164,7 @@ typedef struct TestServer {
>  static const char *tmpfs;
>  static const char *root;
>
> -static void init_virtio_dev(TestServer *s)
> +static void init_virtio_dev(TestServer *s, uint32_t features_mask)
>  {
>      uint32_t features;
>      int i;
> @@ -187,7 +187,7 @@ static void init_virtio_dev(TestServer *s)
>      }
>
>      features =3D qvirtio_get_features(&s->dev->vdev);
> -    features =3D features & (1u << VIRTIO_NET_F_MAC);
> +    features =3D features & features_mask;
>      qvirtio_set_features(&s->dev->vdev, features);
>
>      qvirtio_set_driver_ok(&s->dev->vdev);
> @@ -652,7 +652,7 @@ static void test_read_guest_mem(void)
>      s =3D qtest_start(qemu_cmd);
>      g_free(qemu_cmd);
>
> -    init_virtio_dev(server);
> +    init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
>
>      read_guest_mem(server);
>
> @@ -681,7 +681,7 @@ static void test_migrate(void)
>      from =3D qtest_start(cmd);
>      g_free(cmd);
>
> -    init_virtio_dev(s);
> +    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
>      wait_for_fds(s);
>      size =3D get_log_size(s);
>      g_assert_cmpint(size, =3D=3D, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * =
8));
> @@ -803,7 +803,7 @@ static void test_reconnect_subprocess(void)
>      qtest_start(cmd);
>      g_free(cmd);
>
> -    init_virtio_dev(s);
> +    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
>      wait_for_fds(s);
>      wait_for_rings_started(s, 2);
>
> @@ -841,7 +841,7 @@ static void test_connect_fail_subprocess(void)
>      qtest_start(cmd);
>      g_free(cmd);
>
> -    init_virtio_dev(s);
> +    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
>      wait_for_fds(s);
>      wait_for_rings_started(s, 2);
>
> @@ -871,7 +871,7 @@ static void test_flags_mismatch_subprocess(void)
>      qtest_start(cmd);
>      g_free(cmd);
>
> -    init_virtio_dev(s);
> +    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
>      wait_for_fds(s);
>      wait_for_rings_started(s, 2);
>
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
