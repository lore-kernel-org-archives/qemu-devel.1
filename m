Received: from eggs.gnu.org ([2001:4830:134:3::10]:33781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkNuE-0001CP-R7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkNuD-0004ND-Mv
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:08:42 -0400
Date: Wed, 23 Aug 2017 13:08:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170823050830.GD21343@lemon>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/10] io: add qio_channel_read/write_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>

On Tue, 08/22 15:18, Paolo Bonzini wrote:
> It is pretty common to read a fixed-size buffer from a socket.  Add a
> function that does this, either with multiple reads (on blocking sockets)
> or by yielding if called from a coroutine.
> 
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/io/channel.h | 36 ++++++++++++++++++++++++++++++++++-
>  io/channel.c         | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index db9bb022a1..9cfb4d081f 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -299,7 +299,7 @@ ssize_t qio_channel_writev(QIOChannel *ioc,
>                             Error **errp);
>  
>  /**
> - * qio_channel_readv:
> + * qio_channel_read:
>   * @ioc: the channel object
>   * @buf: the memory region to read data into
>   * @buflen: the length of @buf
> @@ -315,6 +315,23 @@ ssize_t qio_channel_read(QIOChannel *ioc,
>                           Error **errp);
>  
>  /**
> + * qio_channel_read_all:
> + * @ioc: the channel object
> + * @buf: the memory region to read data into
> + * @buflen: the number of bytes to @buf
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Reads @buflen bytes into @buf, possibly blocking or (if the
> + * channel is non-blocking) yielding from the current coroutine
> + * multiple times until the entire content is read.  Otherwise
> + * behaves as qio_channel_read().
> + */
> +ssize_t coroutine_fn qio_channel_read_all(QIOChannel *ioc,
> +                                          char *buf,
> +                                          size_t buflen,
> +                                          Error **errp);
> +
> +/**
>   * qio_channel_write:
>   * @ioc: the channel object
>   * @buf: the memory regions to send data from
> @@ -331,6 +348,23 @@ ssize_t qio_channel_write(QIOChannel *ioc,
>                            Error **errp);
>  
>  /**
> + * qio_channel_write_all:
> + * @ioc: the channel object
> + * @buf: the memory region to write data into
> + * @buflen: the number of bytes to @buf
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Writes @buflen bytes from @buf, possibly blocking or (if the
> + * channel is non-blocking) yielding from the current coroutine
> + * multiple times until the entire content is written.  Otherwise
> + * behaves as qio_channel_write().
> + */
> +ssize_t coroutine_fn qio_channel_write_all(QIOChannel *ioc,
> +                                           const char *buf,
> +                                           size_t buflen,
> +                                           Error **errp);
> +
> +/**
>   * qio_channel_set_blocking:
>   * @ioc: the channel object
>   * @enabled: the blocking flag state
> diff --git a/io/channel.c b/io/channel.c
> index 1cfb8b33a2..7ab3f4eede 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -113,6 +113,60 @@ ssize_t qio_channel_read(QIOChannel *ioc,
>  }
>  
>  
> +ssize_t qio_channel_read_all(QIOChannel *ioc,
> +                             char *buf,
> +                             size_t buflen,
> +                             Error **errp)
> +{
> +    ssize_t total = 0;
> +    while (buflen > 0) {
> +        ssize_t n_read = qio_channel_read(ioc, buf, buflen, errp);
> +
> +        if (n_read == QIO_CHANNEL_ERR_BLOCK) {
> +            assert(ioc->ctx);
> +            qio_channel_yield(ioc, G_IO_IN);
> +            continue;
> +        }
> +        if (n_read < 0) {
> +            return n_read;
> +        }
> +
> +        buf += n_read;
> +        total += n_read;
> +        buflen -= n_read;
> +    }
> +
> +    return total;
> +}
> +
> +
> +ssize_t qio_channel_write_all(QIOChannel *ioc,
> +                              const char *buf,
> +                              size_t buflen,
> +                              Error **errp)
> +{
> +    ssize_t total = 0;
> +    while (buflen > 0) {
> +        ssize_t n_written = qio_channel_write(ioc, buf, buflen, errp);
> +
> +        if (n_written == QIO_CHANNEL_ERR_BLOCK) {
> +            assert(ioc->ctx);
> +            qio_channel_yield(ioc, G_IO_OUT);
> +            continue;
> +        }
> +        if (n_written < 0) {
> +            return n_written;
> +        }
> +
> +        buf += n_written;
> +        total += n_written;
> +        buflen -= n_written;
> +    }
> +
> +    return total;
> +}
> +
> +
>  ssize_t qio_channel_write(QIOChannel *ioc,
>                            const char *buf,
>                            size_t buflen,
> -- 
> 2.13.5
> 
> 

Are there any caller depending on short read/write? Is it okay to change all (or
most) qio_channel_{read,write}* functions to this "full read/write" behavior?

Fam
