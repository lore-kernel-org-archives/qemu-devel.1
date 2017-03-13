Received: from eggs.gnu.org ([2001:4830:134:3::10]:38907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnSrL-0005pY-0f
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnSrK-0007iF-0E
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:30:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cnSrJ-0007hH-Nz
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:30:09 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E29D23CBA2B
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 16:30:09 +0000 (UTC)
Date: Mon, 13 Mar 2017 16:30:03 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170313163003.GJ4799@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170313124434.1043-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/16] qio: create new qio_channel_read_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

On Mon, Mar 13, 2017 at 01:44:20PM +0100, Juan Quintela wrote:
> It is the symmetric function from qio_channel_write_all
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/io/channel.h | 23 +++++++++++++++++++++++
>  io/channel.c         | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index f786c4f..2f55831 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -269,6 +269,29 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
>                                  Error **errp);
>  
>  /**
> + * qio_channel_readv_all:
> + * @ioc: the channel object
> + * @iov: the array of memory regions to read data into
> + * @niov: the length of the @iov array
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Read data from the IO channel, storing it in the
> + * memory regions referenced by @iov. Each element
> + * in the @iov will be fully populated with data
> + * before the next one is used. The @niov parameter
> + * specifies the total number of elements in @iov.
> + *
> + * Returns: the number of bytes read, or -1 on error,
> + * or QIO_CHANNEL_ERR_BLOCK if no data is available
> + * and the channel is non-blocking
> + */
> +ssize_t qio_channel_readv_all(QIOChannel *ioc,
> +                              const struct iovec *iov,
> +                              size_t niov,
> +                              Error **errp);
> +
> +
> +/**
>   * qio_channel_writev_all:
>   * @ioc: the channel object
>   * @iov: the array of memory regions to write data from
> diff --git a/io/channel.c b/io/channel.c
> index c5a1bd5..82203ef 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -87,6 +87,43 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
>  
>  
>  
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
> +
> + cleanup:
> +    g_free(local_iov_head);
> +    return done;
> +}
> +

Again, can you make sure this is covered in the test suite - the
test_io_thread_reader() method can probably be replaced by this code.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
