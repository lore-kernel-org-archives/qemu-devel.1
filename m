Received: from eggs.gnu.org ([2001:4830:134:3::10]:41604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dpbi8-0000K4-Ig
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dpbi5-0005xH-U4
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:53:48 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dpbi5-0005uw-Mt
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:53:45 -0400
Received: by mail-oi0-f52.google.com with SMTP id x190so27293616oix.3
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:53:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170906085024.GB15510@redhat.com>
References: <20170905191114.5959-1-eblake@redhat.com>
	<20170905191114.5959-2-eblake@redhat.com>
	<20170906085024.GB15510@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Sep 2017 16:53:43 +0200
Message-ID: <CABgObfb7yOAAKX9YeNVYrnXdhhNP94O1Wsfo9qGGHDaofMXOEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] io: Yield rather than wait when
 already in coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "P. Berrange, Daniel" <berrange@redhat.com>
Cc: "Blake, Eric" <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org

Il 06 set 2017 10:51 AM, "Daniel P. Berrange" <berrange@redhat.com> ha
scritto:

On Tue, Sep 05, 2017 at 02:11:12PM -0500, Eric Blake wrote:
> The new qio_channel_{read,write}{,v}_all functions are documented
> as yielding until data is available.  When used on a blocking
> channel, this yield is done via qio_channel_wait() which spawns
> a new coroutine under the hood (so it is the new entry point that
> yields as needed); but if we are already in a coroutine (at which

qio_channel_wait doesn't spawn any coroutine - it simply rnus a
nested event loop to wait for the channel...

> point QIO_CHANNEL_ERR_BLOCK is only possible if we are a
> non-blocking channel), we want to yield the current coroutine
> instead of spawning a new one.

...none the less, I think this is ok.


Great, this works for me on the pr-helper too.

Paolo


>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  io/channel.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/io/channel.c b/io/channel.c
> index 5e8c2f0a91..9e62794cab 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -105,7 +105,11 @@ int qio_channel_readv_all(QIOChannel *ioc,
>          ssize_t len;
>          len = qio_channel_readv(ioc, local_iov, nlocal_iov, errp);
>          if (len == QIO_CHANNEL_ERR_BLOCK) {
> -            qio_channel_wait(ioc, G_IO_IN);
> +            if (qemu_in_coroutine()) {
> +                qio_channel_yield(ioc, G_IO_IN);
> +            } else {
> +                qio_channel_wait(ioc, G_IO_IN);
> +            }
>              continue;
>          } else if (len < 0) {
>              goto cleanup;
> @@ -143,7 +147,11 @@ int qio_channel_writev_all(QIOChannel *ioc,
>          ssize_t len;
>          len = qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
>          if (len == QIO_CHANNEL_ERR_BLOCK) {
> -            qio_channel_wait(ioc, G_IO_OUT);
> +            if (qemu_in_coroutine()) {
> +                qio_channel_yield(ioc, G_IO_OUT);
> +            } else {
> +                qio_channel_wait(ioc, G_IO_OUT);
> +            }
>              continue;
>          }
>          if (len < 0) {

Acked-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
--
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange
:|
|: https://libvirt.org         -o-            https://fstop138.berrange.com
:|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange
:|
