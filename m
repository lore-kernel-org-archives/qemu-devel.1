Received: from eggs.gnu.org ([209.51.188.92]:48655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1go4Bx-0005FT-Vt
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1go4Bs-0007ZD-9X
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:31:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1go4Bs-0007XU-0M
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:30:56 -0500
Date: Mon, 28 Jan 2019 10:30:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190128103048.GA15071@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190128041159.28643-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190128041159.28643-1-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] test-filter-mirror: pass UNIX domain
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Jan 28, 2019 at 12:11:59PM +0800, Jason Wang wrote:
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
> ---
>  tests/test-filter-mirror.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
> index 7ab2aed8a0..3c3d1f8961 100644
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
>          "-object filter-mirror,id=qtest-f0,netdev=qtest-bn0,queue=tx,outdev=mirror0 "
> -        , send_sock[1], devstr, sock_path);
> -
> -    recv_sock = unix_connect(sock_path, NULL);
> -    g_assert_cmpint(recv_sock, !=, -1);
> +        , send_sock[1], devstr, recv_sock[1]);
>  
>      struct iovec iov[] = {
>          {
> @@ -67,18 +63,16 @@ static void test_mirror(void)
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

You're leaking recv_sock[0] and recv_sock[1] now. For that matter it
seems send_sock[0] & send_sock[1] are already both leaked too.

> -    unlink(sock_path);
>      qtest_quit(qts);
>  }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
