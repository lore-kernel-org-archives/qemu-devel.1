Received: from eggs.gnu.org ([2001:4830:134:3::10]:47717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcDx7-0006ht-Uz
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcDx4-0005QE-SB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:53:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcDx4-0005OY-MD
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:53:54 -0400
Date: Mon, 31 Jul 2017 17:53:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170731165339.GD2122@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 03/29] io: fix qio_channel_socket_accept err
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, berrange@redhat.com, stefanha@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> When accept failed, we should setup errp with the reason. More
> importantly, the caller may assume errp be non-NULL when error happens,
> and not setting the errp may crash QEMU.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  io/channel-socket.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 53386b7..7bc308e 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -344,6 +344,7 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
>          if (errno == EINTR) {
>              goto retry;
>          }
> +        error_setg_errno(errp, errno, "Unable to accept connection");
>          goto error;

OK, but this code actually has a bigger problem as well:

the original is:

    cioc->fd = qemu_accept(ioc->fd, (struct sockaddr *)&cioc->remoteAddr,
                           &cioc->remoteAddrLen);
    if (cioc->fd < 0) {
        trace_qio_channel_socket_accept_fail(ioc);
        if (errno == EINTR) {
            goto retry;
        }
        goto error;
    }

Stefan confirmed that trace_ doesn't preserve errno; so the if
following it is wrong.  It needs to preserve errno.

(Again this patch can go on it's own)

Dave

>      }
>  
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
