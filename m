Received: from eggs.gnu.org ([2001:4830:134:3::10]:44009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXpHf-0008EH-0L
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXpHb-0006um-28
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:44:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXpHa-0006uM-Nw
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:44:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 905782F86D3
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 13:44:53 +0000 (UTC)
Date: Wed, 19 Jul 2017 14:44:47 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170719134447.GH30084@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170717134238.1966-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 03/17] qio: Create new
 qio_channel_{readv, writev}_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

On Mon, Jul 17, 2017 at 03:42:24PM +0200, Juan Quintela wrote:
> The functions waits until it is able to write the full iov.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> Add tests.
> ---
>  include/io/channel.h           | 46 +++++++++++++++++++++++++
>  io/channel.c                   | 76 ++++++++++++++++++++++++++++++++++++++++++
>  migration/qemu-file-channel.c  | 29 +---------------
>  tests/io-channel-helpers.c     | 55 ++++++++++++++++++++++++++++++
>  tests/io-channel-helpers.h     |  4 +++
>  tests/test-io-channel-buffer.c | 55 ++++++++++++++++++++++++++++--
>  6 files changed, 234 insertions(+), 31 deletions(-)



> diff --git a/io/channel.c b/io/channel.c
> index cdf7454..82203ef 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -22,6 +22,7 @@
>  #include "io/channel.h"
>  #include "qapi/error.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/iov.h"
>  
>  bool qio_channel_has_feature(QIOChannel *ioc,
>                               QIOChannelFeature feature)
> @@ -85,6 +86,81 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
>  }
>  
>  
> +
> +ssize_t qio_channel_readv_all(QIOChannel *ioc,
> +                              const struct iovec *iov,
> +                              size_t niov,
> +                              Error **errp)
> +{
> +    ssize_t done = 0;
> +    struct iovec *local_iov = g_new(struct iovec, niov);
> +    struct iovec *local_iov_head = local_iov;
> +    unsigned int nlocal_iov = niov;
> +
> +    nlocal_iov = iov_copy(local_iov, nlocal_iov,
> +                          iov, niov,
> +                          0, iov_size(iov, niov));
> +
> +    while (nlocal_iov > 0) {
> +        ssize_t len;
> +        len = qio_channel_readv(ioc, local_iov, nlocal_iov, errp);
> +        if (len == QIO_CHANNEL_ERR_BLOCK) {
> +            qio_channel_wait(ioc, G_IO_OUT);
> +            continue;
> +        }
> +        if (len < 0) {
> +            error_setg_errno(errp, EIO,
> +                             "Channel was not able to read full iov");
> +            done = -1;
> +            goto cleanup;
> +        }
> +
> +        iov_discard_front(&local_iov, &nlocal_iov, len);
> +        done += len;
> +    }

If 'len == 0' (ie EOF from qio_channel_readv())  then this will busy
loop. You need to break the loop on that condition and return whatever
'done' currently is.

> +
> + cleanup:
> +    g_free(local_iov_head);
> +    return done;
> +}


> diff --git a/tests/io-channel-helpers.c b/tests/io-channel-helpers.c
> index 05e5579..3d76d95 100644
> --- a/tests/io-channel-helpers.c
> +++ b/tests/io-channel-helpers.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "io-channel-helpers.h"
>  #include "qapi/error.h"
> +#include "qemu/iov.h"
>  
>  struct QIOChannelTest {
>      QIOChannel *src;
> @@ -153,6 +154,45 @@ static gpointer test_io_thread_reader(gpointer opaque)
>      return NULL;
>  }
>  
> +static gpointer test_io_thread_writer_all(gpointer opaque)
> +{
> +    QIOChannelTest *data = opaque;
> +    size_t niov = data->niov;
> +    ssize_t ret;
> +
> +    qio_channel_set_blocking(data->src, data->blocking, NULL);
> +
> +    ret = qio_channel_writev_all(data->src,
> +                                 data->inputv,
> +                                 niov,
> +                                 &data->writeerr);
> +    if (ret != iov_size(data->inputv, data->niov)) {
> +        error_setg(&data->writeerr, "Unexpected I/O error");
> +    }
> +
> +    return NULL;
> +}
> +
> +/* This thread receives all data using iovecs */
> +static gpointer test_io_thread_reader_all(gpointer opaque)
> +{
> +    QIOChannelTest *data = opaque;
> +    size_t niov = data->niov;
> +    ssize_t ret;
> +
> +    qio_channel_set_blocking(data->dst, data->blocking, NULL);
> +
> +    ret = qio_channel_readv_all(data->dst,
> +                                data->outputv,
> +                                niov,
> +                                &data->readerr);
> +
> +    if (ret != iov_size(data->inputv, data->niov)) {
> +        error_setg(&data->readerr, "Unexpected I/O error");
> +    }
> +
> +    return NULL;
> +}
>  
>  QIOChannelTest *qio_channel_test_new(void)
>  {
> @@ -231,6 +271,21 @@ void qio_channel_test_run_reader(QIOChannelTest *test,
>      test->dst = NULL;
>  }
>  
> +void qio_channel_test_run_writer_all(QIOChannelTest *test,
> +                                     QIOChannel *src)
> +{
> +    test->src = src;
> +    test_io_thread_writer_all(test);
> +    test->src = NULL;
> +}
> +
> +void qio_channel_test_run_reader_all(QIOChannelTest *test,
> +                                     QIOChannel *dst)
> +{
> +    test->dst = dst;
> +    test_io_thread_reader_all(test);
> +    test->dst = NULL;
> +}
>  
>  void qio_channel_test_validate(QIOChannelTest *test)
>  {
> diff --git a/tests/io-channel-helpers.h b/tests/io-channel-helpers.h
> index fedc64f..17b9647 100644
> --- a/tests/io-channel-helpers.h
> +++ b/tests/io-channel-helpers.h
> @@ -36,6 +36,10 @@ void qio_channel_test_run_writer(QIOChannelTest *test,
>                                   QIOChannel *src);
>  void qio_channel_test_run_reader(QIOChannelTest *test,
>                                   QIOChannel *dst);
> +void qio_channel_test_run_writer_all(QIOChannelTest *test,
> +                                     QIOChannel *src);
> +void qio_channel_test_run_reader_all(QIOChannelTest *test,
> +                                     QIOChannel *dst);
>  
>  void qio_channel_test_validate(QIOChannelTest *test);
>  
> diff --git a/tests/test-io-channel-buffer.c b/tests/test-io-channel-buffer.c
> index 64722a2..4bf64ae 100644
> --- a/tests/test-io-channel-buffer.c
> +++ b/tests/test-io-channel-buffer.c
> @@ -22,8 +22,7 @@
>  #include "io/channel-buffer.h"
>  #include "io-channel-helpers.h"
>  
> -
> -static void test_io_channel_buf(void)
> +static void test_io_channel_buf1(void)
>  {
>      QIOChannelBuffer *buf;
>      QIOChannelTest *test;
> @@ -39,6 +38,53 @@ static void test_io_channel_buf(void)
>      object_unref(OBJECT(buf));
>  }
>  
> +static void test_io_channel_buf2(void)
> +{
> +    QIOChannelBuffer *buf;
> +    QIOChannelTest *test;
> +
> +    buf = qio_channel_buffer_new(0);
> +
> +    test = qio_channel_test_new();
> +    qio_channel_test_run_writer_all(test, QIO_CHANNEL(buf));
> +    buf->offset = 0;
> +    qio_channel_test_run_reader(test, QIO_CHANNEL(buf));
> +    qio_channel_test_validate(test);
> +
> +    object_unref(OBJECT(buf));
> +}
> +
> +static void test_io_channel_buf3(void)
> +{
> +    QIOChannelBuffer *buf;
> +    QIOChannelTest *test;
> +
> +    buf = qio_channel_buffer_new(0);
> +
> +    test = qio_channel_test_new();
> +    qio_channel_test_run_writer(test, QIO_CHANNEL(buf));
> +    buf->offset = 0;
> +    qio_channel_test_run_reader_all(test, QIO_CHANNEL(buf));
> +    qio_channel_test_validate(test);
> +
> +    object_unref(OBJECT(buf));
> +}
> +
> +static void test_io_channel_buf4(void)
> +{
> +    QIOChannelBuffer *buf;
> +    QIOChannelTest *test;
> +
> +    buf = qio_channel_buffer_new(0);
> +
> +    test = qio_channel_test_new();
> +    qio_channel_test_run_writer_all(test, QIO_CHANNEL(buf));
> +    buf->offset = 0;
> +    qio_channel_test_run_reader_all(test, QIO_CHANNEL(buf));
> +    qio_channel_test_validate(test);
> +
> +    object_unref(OBJECT(buf));
> +}
>  
>  int main(int argc, char **argv)
>  {
> @@ -46,6 +92,9 @@ int main(int argc, char **argv)
>  
>      g_test_init(&argc, &argv, NULL);
>  
> -    g_test_add_func("/io/channel/buf", test_io_channel_buf);
> +    g_test_add_func("/io/channel/buf1", test_io_channel_buf1);
> +    g_test_add_func("/io/channel/buf2", test_io_channel_buf2);
> +    g_test_add_func("/io/channel/buf3", test_io_channel_buf3);
> +    g_test_add_func("/io/channel/buf4", test_io_channel_buf4);
>      return g_test_run();
>  }

There's no need to add any of these additions to the test suite.  Instead
you can just change the existing io-channel-helpers.c functions
test_io_thread_writer() and test_io_thread_reader(), to call
qio_channel_writev_all() & qio_channel_readv_all() respectively.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
