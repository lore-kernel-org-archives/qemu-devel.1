Received: from eggs.gnu.org ([209.51.188.92]:50179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gp22e-00075m-2i
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 21:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gp22a-0004yy-AJ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 21:25:22 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gp22Y-0004xO-Ml
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 21:25:19 -0500
Received: by mail-wr1-x42b.google.com with SMTP id v13so1574073wrw.5
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 18:25:17 -0800 (PST)
MIME-Version: 1.0
References: <20190130031427.13129-1-jasowang@redhat.com>
In-Reply-To: <20190130031427.13129-1-jasowang@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 31 Jan 2019 10:25:04 +0800
Message-ID: <CAK3tnvKVBthFyYSc+kummftPUCQwCpaYVF7H8HHhOUmmoB0GGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V2] test-filter-mirror: pass UNIX domain
 socket through fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On Wed, Jan 30, 2019 at 11:14 AM Jason Wang <jasowang@redhat.com> wrote:

> The tests tries to let qemu server mode to process the connection
> which turns out to be racy after commit 8258292e18c3 ("monitor: Remove
> "x-oob", offer capability "oob" unconditionally"). This is because the
> filter may try to mirror the packets before UNIX socket object is
> ready (connected was set to true) from the view of qemu. In this case
> the packet will be dropped silently.
>
> Fixing this by passing pre-connected socket created by socketpair() to
> qemu through fd.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
>

Looks good for me.
Reviewed-by: Zhang Chen <zhangckid@gmail.com>

By the way: Do we need add ASCII diagram to explain data flow in this file
or commit log?

Thanks
Zhang Chen


> ---
> Changes from v1:
> - close the socket pairs in the end of test
> ---
>  tests/test-filter-mirror.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
> index 7ab2aed8a0..d942c74a3f 100644
> --- a/tests/test-filter-mirror.c
> +++ b/tests/test-filter-mirror.c
> @@ -21,10 +21,9 @@
>
>  static void test_mirror(void)
>  {
> -    int send_sock[2], recv_sock;
> +    int send_sock[2], recv_sock[2];
>      uint32_t ret = 0, len = 0;
>      char send_buf[] = "Hello! filter-mirror~";
> -    char sock_path[] = "filter-mirror.XXXXXX";
>      char *recv_buf;
>      uint32_t size = sizeof(send_buf);
>      size = htonl(size);
> @@ -38,18 +37,15 @@ static void test_mirror(void)
>      ret = socketpair(PF_UNIX, SOCK_STREAM, 0, send_sock);
>      g_assert_cmpint(ret, !=, -1);
>
> -    ret = mkstemp(sock_path);
> +    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, recv_sock);
>      g_assert_cmpint(ret, !=, -1);
>
>      qts = qtest_initf(
>          "-netdev socket,id=qtest-bn0,fd=%d "
>          "-device %s,netdev=qtest-bn0,id=qtest-e0 "
> -        "-chardev socket,id=mirror0,path=%s,server,nowait "
> +        "-chardev socket,id=mirror0,fd=%d "
>          "-object
> filter-mirror,id=qtest-f0,netdev=qtest-bn0,queue=tx,outdev=mirror0 "
> -        , send_sock[1], devstr, sock_path);
> -
> -    recv_sock = unix_connect(sock_path, NULL);
> -    g_assert_cmpint(recv_sock, !=, -1);
> +        , send_sock[1], devstr, recv_sock[1]);
>
>      struct iovec iov[] = {
>          {
> @@ -67,18 +63,20 @@ static void test_mirror(void)
>      g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
>      close(send_sock[0]);
>
> -    ret = qemu_recv(recv_sock, &len, sizeof(len), 0);
> +    ret = qemu_recv(recv_sock[0], &len, sizeof(len), 0);
>      g_assert_cmpint(ret, ==, sizeof(len));
>      len = ntohl(len);
>
>      g_assert_cmpint(len, ==, sizeof(send_buf));
>      recv_buf = g_malloc(len);
> -    ret = qemu_recv(recv_sock, recv_buf, len, 0);
> +    ret = qemu_recv(recv_sock[0], recv_buf, len, 0);
>      g_assert_cmpstr(recv_buf, ==, send_buf);
>
>      g_free(recv_buf);
> -    close(recv_sock);
> -    unlink(sock_path);
> +    close(send_sock[0]);
> +    close(send_sock[1]);
> +    close(recv_sock[0]);
> +    close(recv_sock[1]);
>      qtest_quit(qts);
>  }
>
> --
> 2.17.1
>
>
