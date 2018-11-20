Received: from eggs.gnu.org ([2001:4830:134:3::10]:35567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1jo-0000Gm-0R
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1jj-0003RH-UP
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:27 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gP1jj-0003Pp-6f
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id n12so1579125qkh.11
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 00:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20181115143124.19234-1-pbonzini@redhat.com>
	<20181115143124.19234-9-pbonzini@redhat.com>
In-Reply-To: <20181115143124.19234-9-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 12:50:10 +0400
Message-ID: <CAMxuvawzLqf2dv2rks-R9n5QbihUtv+ozSM17R2bPv-Hb=PHDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] vhost-user-test: create a main loop
 per TestServer
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
> This makes the tests more independent and removes the need to defer test_=
server_free
> via an idle event source.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/vhost-user-test.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
>
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index c3a8af3d85..93d5157b13 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -143,6 +143,8 @@ typedef struct TestServer {
>      int fds_num;
>      int fds[VHOST_MEMORY_MAX_NREGIONS];
>      VhostUserMemory memory;
> +    GMainLoop *loop;
> +    GThread *thread;
>      GMutex data_mutex;
>      GCond data_cond;
>      int log_fd;
> @@ -490,6 +492,10 @@ static TestServer *test_server_new(const gchar *name=
)
>  {
>      TestServer *server =3D g_new0(TestServer, 1);
>
> +    server->loop =3D g_main_loop_new(NULL, FALSE);
> +    /* run the main loop thread so the chardev may operate */
> +    server->thread =3D g_thread_new(NULL, thread_function, server->loop)=
;
> +
>      server->socket_path =3D g_strdup_printf("%s/%s.sock", tmpfs, name);
>      server->mig_path =3D g_strdup_printf("%s/%s.mig", tmpfs, name);
>      server->chr_name =3D g_strdup_printf("chr-%s", name);
> @@ -533,9 +539,18 @@ static void test_server_listen(TestServer *server)
>      test_server_create_chr(server, ",server,nowait");
>  }
>
> -static gboolean _test_server_free(TestServer *server)
> +static void test_server_free(TestServer *server)
>  {
>      int i;
> +    int ret;
> +
> +    /* finish the helper thread and dispatch pending sources */
> +    g_main_loop_quit(server->loop);
> +    g_thread_join(server->thread);
> +    while (g_main_context_pending(NULL)) {
> +        g_main_context_iteration (NULL, TRUE);
> +    }
> +    g_main_loop_unref(server->loop);
>
>      qemu_chr_fe_deinit(&server->chr, true);
>
> @@ -558,13 +573,6 @@ static gboolean _test_server_free(TestServer *server=
)
>      qpci_free_pc(server->bus);
>
>      g_free(server);
> -
> -    return FALSE;
> -}
> -
> -static void test_server_free(TestServer *server)
> -{
> -    g_idle_add((GSourceFunc)_test_server_free, server);
>  }
>
>  static void wait_for_log_fd(TestServer *s)
> @@ -969,8 +977,6 @@ int main(int argc, char **argv)
>      const char *hugefs;
>      int ret;
>      char template[] =3D "/tmp/vhost-test-XXXXXX";
> -    GMainLoop *loop;
> -    GThread *thread;
>
>      g_test_init(&argc, &argv, NULL);
>
> @@ -991,10 +997,6 @@ int main(int argc, char **argv)
>          root =3D tmpfs;
>      }
>
> -    loop =3D g_main_loop_new(NULL, FALSE);
> -    /* run the main loop thread so the chardev may operate */
> -    thread =3D g_thread_new(NULL, thread_function, loop);
> -
>      if (qemu_memfd_check(0)) {
>          qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
>                              GINT_TO_POINTER(TEST_MEMFD_YES),
> @@ -1022,14 +1024,6 @@ int main(int argc, char **argv)
>
>      /* cleanup */
>
> -    /* finish the helper thread and dispatch pending sources */
> -    g_main_loop_quit(loop);
> -    g_thread_join(thread);
> -    while (g_main_context_pending(NULL)) {
> -        g_main_context_iteration (NULL, TRUE);
> -    }
> -    g_main_loop_unref(loop);
> -
>      ret =3D rmdir(tmpfs);
>      if (ret !=3D 0) {
>          g_test_message("unable to rmdir: path (%s): %s\n",
> --
> 2.19.1
>
>
