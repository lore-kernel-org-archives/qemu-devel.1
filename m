Received: from eggs.gnu.org ([2001:4830:134:3::10]:54827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOiZl-0006VD-WF
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOiZl-0004DR-0U
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:50:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fOiZk-0004Cc-RD
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:50:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EDE6859A9
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 11:50:32 +0000 (UTC)
Date: Fri, 1 Jun 2018 12:50:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601115021.GS3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-2-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180531074601.10647-2-slp@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] io: Implement QIO_CHANNEL_ERR_BROKEN
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

On Thu, May 31, 2018 at 09:45:59AM +0200, Sergio Lopez wrote:
> QIO_CHANNEL_ERR_BROKEN is used to identify a potentially unrecoverable
> error in the channel, like EPIPE.
> ---
>  include/io/channel.h | 1 +
>  io/channel-file.c    | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index e8cdadb..bbe45f6 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -38,6 +38,7 @@ typedef struct QIOChannel QIOChannel;
>  typedef struct QIOChannelClass QIOChannelClass;
>  
>  #define QIO_CHANNEL_ERR_BLOCK -2
> +#define QIO_CHANNEL_ERR_BROKEN -3
>  
>  typedef enum QIOChannelFeature QIOChannelFeature;
>  
> diff --git a/io/channel-file.c b/io/channel-file.c
> index db948ab..a990f67 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -124,6 +124,9 @@ static ssize_t qio_channel_file_writev(QIOChannel *ioc,
>          if (errno == EAGAIN) {
>              return QIO_CHANNEL_ERR_BLOCK;
>          }
> +        if (errno == EPIPE) {
> +            return QIO_CHANNEL_ERR_BROKEN;
> +        }
>          if (errno == EINTR) {
>              goto retry;
>          }

I don't see a compelling reason to add this.  EAGAIN needs special
handling because we do not wish to set the "Error **errp" object.
EPIPE can be just handled by callers in the same way as any other
errno value, by closing the connection.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
