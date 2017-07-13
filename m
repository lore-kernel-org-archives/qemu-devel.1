Received: from eggs.gnu.org ([2001:4830:134:3::10]:60222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVbI3-00089D-9G
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVbHz-0001l3-Dl
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:24:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVbHz-0001kc-7N
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:24:07 -0400
Date: Thu, 13 Jul 2017 11:23:59 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170713102359.GH4011@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <468425bd8090e3a9fd7fc791db42e24d6c75315c.1499940552.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <468425bd8090e3a9fd7fc791db42e24d6c75315c.1499940552.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] io/channel-watch.c: Only select on
 what we are actually waiting for
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, alistair23@gmail.com

On Thu, Jul 13, 2017 at 03:15:49AM -0700, Alistair Francis wrote:
> When calling WAEventSelect() only wait on events as specified by the
> condition variable. This requires that the condition variable is set
> correctly for the specific events that we need to wait for.

Can you describe the actual problem / buggy behaviour you were seeing
with the current code.

> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  io/channel-watch.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/io/channel-watch.c b/io/channel-watch.c
> index 8640d1c464..d80722f496 100644
> --- a/io/channel-watch.c
> +++ b/io/channel-watch.c
> @@ -286,9 +286,21 @@ GSource *qio_channel_create_socket_watch(QIOChannel *ioc,
>      QIOChannelSocketSource *ssource;
>  
>  #ifdef WIN32
> -    WSAEventSelect(socket, ioc->event,
> -                   FD_READ | FD_ACCEPT | FD_CLOSE |
> -                   FD_CONNECT | FD_WRITE | FD_OOB);
> +    long bitmask = 0;
> +
> +    if (condition & (G_IO_IN | G_IO_PRI)) {
> +        bitmask |= FD_READ | FD_ACCEPT;
> +    }
> +
> +    if (condition & G_IO_HUP) {
> +        bitmask |= FD_CLOSE;
> +    }
> +
> +    if (condition & G_IO_OUT) {
> +        bitmask |= FD_WRITE | FD_CONNECT;
> +    }
> +
> +    WSAEventSelect(socket, ioc->event, bitmask);
>  #endif

I think the problem with doing this is that WSAEventSelect is a global
setting that applies to the socket handle. If you use qio_channel_create_watch
twice on the same socket with different events, the second watch will break
the first watch by potentially discarding events that it requested.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
