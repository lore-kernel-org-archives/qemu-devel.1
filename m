Received: from eggs.gnu.org ([2001:4830:134:3::10]:35628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1jt-0000Iw-I0
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1jq-0003ek-5L
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gP1jp-0003Yw-Sg
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:30 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so1602174qkj.8
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 00:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20181115143124.19234-1-pbonzini@redhat.com>
	<20181115143124.19234-8-pbonzini@redhat.com>
In-Reply-To: <20181115143124.19234-8-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 12:50:15 +0400
Message-ID: <CAMxuvay8PM8si-F2Lp+TOgJ4pH17eicGRmOXpwijAG0Jkdy9Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/10] vhost-user-test: reduce usage of
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Bonzini, Paolo" <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

On Thu, Nov 15, 2018 at 6:31 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Whenever the code can run on multiple QTestStates, use them explicitly in=
stead of
> global_qtest.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/vhost-user-test.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
>
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 59e1aec397..c3a8af3d85 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -187,12 +187,12 @@ static char *get_qemu_cmd(TestServer *s,
>      }
>  }
>
> -static void init_virtio_dev(TestServer *s, uint32_t features_mask)
> +static void init_virtio_dev(QTestState *qts, TestServer *s, uint32_t fea=
tures_mask)
>  {
>      uint32_t features;
>      int i;
>
> -    s->bus =3D qpci_init_pc(global_qtest, NULL);
> +    s->bus =3D qpci_init_pc(qts, NULL);
>      g_assert_nonnull(s->bus);
>
>      s->dev =3D qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
> @@ -203,7 +203,7 @@ static void init_virtio_dev(TestServer *s, uint32_t f=
eatures_mask)
>      qvirtio_set_acknowledge(&s->dev->vdev);
>      qvirtio_set_driver(&s->dev->vdev);
>
> -    s->alloc =3D pc_alloc_init(global_qtest);
> +    s->alloc =3D pc_alloc_init(qts);
>
>      for (i =3D 0; i < s->queues * 2; i++) {
>          s->vq[i] =3D qvirtqueue_setup(&s->dev->vdev, s->alloc, i);
> @@ -265,7 +265,7 @@ static bool wait_for_fds(TestServer *s)
>      return got_region;
>  }
>
> -static void read_guest_mem_server(TestServer *s)
> +static void read_guest_mem_server(QTestState *qts, TestServer *s)
>  {
>      uint8_t *guest_mem;
>      int i, j;
> @@ -293,7 +293,7 @@ static void read_guest_mem_server(TestServer *s)
>          guest_mem +=3D (s->memory.regions[i].mmap_offset / sizeof(*guest=
_mem));
>
>          for (j =3D 0; j < 1024; j++) {
> -            uint32_t a =3D readb(s->memory.regions[i].guest_phys_addr + =
j);
> +            uint32_t a =3D qtest_readb(qts, s->memory.regions[i].guest_p=
hys_addr + j);
>              uint32_t b =3D guest_mem[j];
>
>              g_assert_cmpint(a, =3D=3D, b);
> @@ -670,13 +670,13 @@ static void test_read_guest_mem(const void *arg)
>      s =3D qtest_start(qemu_cmd);
>      g_free(qemu_cmd);
>
> -    init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
> +    init_virtio_dev(global_qtest, server, 1u << VIRTIO_NET_F_MAC);
>
>      if (!wait_for_fds(server)) {
>          goto exit;
>      }
>
> -    read_guest_mem_server(server);
> +    read_guest_mem_server(global_qtest, server);
>
>  exit:
>      uninit_virtio_dev(server);
> @@ -690,7 +690,7 @@ static void test_migrate(void)
>      TestServer *s =3D test_server_new("src");
>      TestServer *dest =3D test_server_new("dest");
>      char *uri =3D g_strdup_printf("%s%s", "unix:", dest->mig_path);
> -    QTestState *global =3D global_qtest, *from, *to;
> +    QTestState *from, *to;
>      GSource *source;
>      gchar *cmd, *tmp;
>      QDict *rsp;
> @@ -704,7 +704,7 @@ static void test_migrate(void)
>      from =3D qtest_start(cmd);
>      g_free(cmd);
>
> -    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
> +    init_virtio_dev(from, s, 1u << VIRTIO_NET_F_MAC);
>      if (!wait_for_fds(s)) {
>          goto exit;
>      }
> @@ -717,7 +717,7 @@ static void test_migrate(void)
>      g_free(tmp);
>      to =3D qtest_init(cmd);
>      g_free(cmd);
> -    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
> +    init_virtio_dev(to, dest, 1u << VIRTIO_NET_F_MAC);
>
>      source =3D g_source_new(&test_migrate_source_funcs,
>                            sizeof(TestMigrateSource));
> @@ -753,12 +753,10 @@ static void test_migrate(void)
>      qobject_unref(rsp);
>
>      qmp_eventwait("STOP");
> +    qtest_qmp_eventwait(to, "RESUME");
>
> -    global_qtest =3D to;
> -    qmp_eventwait("RESUME");
> -
> -    g_assert(wait_for_fds(s));
> -    read_guest_mem_server(dest);
> +    g_assert(wait_for_fds(dest));
> +    read_guest_mem_server(to, dest);
>
>      uninit_virtio_dev(dest);
>      qtest_quit(to);
> @@ -773,8 +771,6 @@ exit:
>      qtest_quit(from);
>      test_server_free(s);
>      g_free(uri);
> -
> -    global_qtest =3D global;
>  }
>
>  static void wait_for_rings_started(TestServer *s, size_t count)
> @@ -831,7 +827,7 @@ static void test_reconnect_subprocess(void)
>      qtest_start(cmd);
>      g_free(cmd);
>
> -    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
> +    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
>      if (!wait_for_fds(s)) {
>          goto exit;
>      }
> @@ -873,7 +869,7 @@ static void test_connect_fail_subprocess(void)
>      qtest_start(cmd);
>      g_free(cmd);
>
> -    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
> +    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
>      if (!wait_for_fds(s)) {
>          goto exit;
>      }
> @@ -906,7 +902,7 @@ static void test_flags_mismatch_subprocess(void)
>      qtest_start(cmd);
>      g_free(cmd);
>
> -    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
> +    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
>      if (!wait_for_fds(s)) {
>          goto exit;
>      }
> @@ -957,7 +953,7 @@ static void test_multiqueue(void)
>      qtest_start(cmd);
>      g_free(cmd);
>
> -    init_virtio_dev(s, features_mask);
> +    init_virtio_dev(global_qtest, s, features_mask);
>
>      wait_for_rings_started(s, s->queues * 2);
>
> --
> 2.19.1
>
>
