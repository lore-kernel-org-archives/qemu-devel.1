Received: from eggs.gnu.org ([2001:4830:134:3::10]:54228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1df0lz-0001Vv-Ns
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1df0lv-0006Ul-MR
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1df0lv-0006UT-DO
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:25:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 274B8356CD
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 09:25:54 +0000 (UTC)
Date: Tue, 8 Aug 2017 10:25:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170808092548.GC9393@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-4-quintela@redhat.com>
	<20170719134447.GH30084@redhat.com> <87o9rqbggn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o9rqbggn.fsf@secure.mitica>
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

On Tue, Aug 08, 2017 at 10:40:08AM +0200, Juan Quintela wrote:
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > On Mon, Jul 17, 2017 at 03:42:24PM +0200, Juan Quintela wrote:
> >> The functions waits until it is able to write the full iov.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> 
> >> --
> >> 
> >> Add tests.
> >> ---
> >>  include/io/channel.h           | 46 +++++++++++++++++++++++++
> >>  io/channel.c                   | 76 ++++++++++++++++++++++++++++++++++++++++++
> >>  migration/qemu-file-channel.c  | 29 +---------------
> >>  tests/io-channel-helpers.c     | 55 ++++++++++++++++++++++++++++++
> >>  tests/io-channel-helpers.h     |  4 +++
> >>  tests/test-io-channel-buffer.c | 55 ++++++++++++++++++++++++++++--
> >>  6 files changed, 234 insertions(+), 31 deletions(-)
> >
> >
> >
> >> diff --git a/io/channel.c b/io/channel.c
> >> index cdf7454..82203ef 100644
> >> --- a/io/channel.c
> >> +++ b/io/channel.c
> >> @@ -22,6 +22,7 @@
> >>  #include "io/channel.h"
> >>  #include "qapi/error.h"
> >>  #include "qemu/main-loop.h"
> >> +#include "qemu/iov.h"
> >>  
> >>  bool qio_channel_has_feature(QIOChannel *ioc,
> >>                               QIOChannelFeature feature)
> >> @@ -85,6 +86,81 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
> >>  }
> >>  
> >>  
> >> +
> >> +ssize_t qio_channel_readv_all(QIOChannel *ioc,
> >> +                              const struct iovec *iov,
> >> +                              size_t niov,
> >> +                              Error **errp)
> >> +{
> >> +    ssize_t done = 0;
> >> +    struct iovec *local_iov = g_new(struct iovec, niov);
> >> +    struct iovec *local_iov_head = local_iov;
> >> +    unsigned int nlocal_iov = niov;
> >> +
> >> +    nlocal_iov = iov_copy(local_iov, nlocal_iov,
> >> +                          iov, niov,
> >> +                          0, iov_size(iov, niov));
> >> +
> >> +    while (nlocal_iov > 0) {
> >> +        ssize_t len;
> >> +        len = qio_channel_readv(ioc, local_iov, nlocal_iov, errp);
> >> +        if (len == QIO_CHANNEL_ERR_BLOCK) {
> >> +            qio_channel_wait(ioc, G_IO_OUT);
> >> +            continue;
> >> +        }
> >> +        if (len < 0) {
> >> +            error_setg_errno(errp, EIO,
> >> +                             "Channel was not able to read full iov");
> >> +            done = -1;
> >> +            goto cleanup;
> >> +        }
> >> +
> >> +        iov_discard_front(&local_iov, &nlocal_iov, len);
> >> +        done += len;
> >> +    }
> >
> > If 'len == 0' (ie EOF from qio_channel_readv())  then this will busy
> > loop. You need to break the loop on that condition and return whatever
> > 'done' currently is.
> 
> Done.
> 
> >> +static void test_io_channel_buf2(void)
> >> +{
> >> +    QIOChannelBuffer *buf;
> >> +    QIOChannelTest *test;
> >> +
> >> +    buf = qio_channel_buffer_new(0);
> >> +
> >> +    test = qio_channel_test_new();
> >> +    qio_channel_test_run_writer_all(test, QIO_CHANNEL(buf));
> >> +    buf->offset = 0;
> >> +    qio_channel_test_run_reader(test, QIO_CHANNEL(buf));
> >> +    qio_channel_test_validate(test);
> >> +
> >> +    object_unref(OBJECT(buf));
> >> +}
> >> +
> >> +static void test_io_channel_buf3(void)
> >> +{
> >> +    QIOChannelBuffer *buf;
> >> +    QIOChannelTest *test;
> >> +
> >> +    buf = qio_channel_buffer_new(0);
> >> +
> >> +    test = qio_channel_test_new();
> >> +    qio_channel_test_run_writer(test, QIO_CHANNEL(buf));
> >> +    buf->offset = 0;
> >> +    qio_channel_test_run_reader_all(test, QIO_CHANNEL(buf));
> >> +    qio_channel_test_validate(test);
> >> +
> >> +    object_unref(OBJECT(buf));
> >> +}
> >> +
> >> +static void test_io_channel_buf4(void)
> >> +{
> >> +    QIOChannelBuffer *buf;
> >> +    QIOChannelTest *test;
> >> +
> >> +    buf = qio_channel_buffer_new(0);
> >> +
> >> +    test = qio_channel_test_new();
> >> +    qio_channel_test_run_writer_all(test, QIO_CHANNEL(buf));
> >> +    buf->offset = 0;
> >> +    qio_channel_test_run_reader_all(test, QIO_CHANNEL(buf));
> >> +    qio_channel_test_validate(test);
> >> +
> >> +    object_unref(OBJECT(buf));
> >> +}
> >>  
> >>  int main(int argc, char **argv)
> >>  {
> >> @@ -46,6 +92,9 @@ int main(int argc, char **argv)
> >>  
> >>      g_test_init(&argc, &argv, NULL);
> >>  
> >> -    g_test_add_func("/io/channel/buf", test_io_channel_buf);
> >> +    g_test_add_func("/io/channel/buf1", test_io_channel_buf1);
> >> +    g_test_add_func("/io/channel/buf2", test_io_channel_buf2);
> >> +    g_test_add_func("/io/channel/buf3", test_io_channel_buf3);
> >> +    g_test_add_func("/io/channel/buf4", test_io_channel_buf4);
> >>      return g_test_run();
> >>  }
> >
> > There's no need to add any of these additions to the test suite.  Instead
> > you can just change the existing io-channel-helpers.c functions
> > test_io_thread_writer() and test_io_thread_reader(), to call
> > qio_channel_writev_all() & qio_channel_readv_all() respectively.
> 
> They are already done now, and the advantage of this was that I was able
> to test that everything worked well against everything.  That was good
> to be able to check that all worked as expected.

The existing test_io_thread_reader/writer() methods that I mention are
common code used by multiple tests - test-io-channel-buffer,
test-io-chanel-socket, test-io-channel-file, test-io-channel-tls.

I don't want to add code to test-io-channel-buffer that duplicates
functionality that already exists, and is exercised by only one of the
many IO channel implementation tests.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
