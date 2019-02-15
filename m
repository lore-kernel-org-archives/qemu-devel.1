Received: from eggs.gnu.org ([209.51.188.92]:49495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1guSjM-0007UZ-Hq
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 20:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1guSjL-0001Jf-Oy
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 20:55:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1guSjL-0001J7-Ir
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 20:55:55 -0500
Date: Fri, 15 Feb 2019 09:55:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190215015549.GA3232@xz-x1>
References: <20190214185351.5927-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214185351.5927-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: Fix qemu_rdma_cleanup null
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peter.maydell@linaro.org

On Thu, Feb 14, 2019 at 06:53:51PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> If the migration fails before the channel is open (e.g. a bad
> address) we end up in the cleanup with rdma->channel==NULL.
> 
> Spotted by Coverity: CID 1398634
> Fixes: fbbaacab2758cb3f32a0
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/rdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 54a3c11540..9fa3b176eb 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2321,7 +2321,9 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
>          rdma->connected = false;
>      }
>  
> -    qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
> +    if (rdma->channel) {
> +        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
> +    }

IIUC there's no strict ordering constraint on resetting the fd
handler, then how about simply moving this line into the below "if
(rdma->channel)" altogether?

Regards,

-- 
Peter Xu
