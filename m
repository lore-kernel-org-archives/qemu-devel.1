Received: from eggs.gnu.org ([2001:4830:134:3::10]:55068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOiaP-0006u2-32
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOiaL-0004kR-6D
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:51:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fOiaL-0004k9-1c
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:51:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B87940BC040
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 11:51:08 +0000 (UTC)
Date: Fri, 1 Jun 2018 12:51:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601115105.GT3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-3-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180531074601.10647-3-slp@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] chardev: On QIO_CHANNEL_ERR_BROKEN set
 errno to EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

On Thu, May 31, 2018 at 09:46:00AM +0200, Sergio Lopez wrote:
> This allows callers to identify this potentially unrecoverable error.
> ---
>  chardev/char-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/chardev/char-io.c b/chardev/char-io.c
> index f810524..f934eb9 100644
> --- a/chardev/char-io.c
> +++ b/chardev/char-io.c
> @@ -168,6 +168,9 @@ int io_channel_send_full(QIOChannel *ioc,
>  
>              errno = EAGAIN;
>              return -1;
> +        } else if (ret == QIO_CHANNEL_ERR_BROKEN) {
> +            errno = EPIPE;
> +            return -1;
>          } else if (ret < 0) {
>              errno = EINVAL;
>              return -1;

Again, I don't see any reason to add this special case for EPIPE


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
