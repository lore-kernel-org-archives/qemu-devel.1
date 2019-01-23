Received: from eggs.gnu.org ([209.51.188.92]:34076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmGxk-0006NU-KN
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmGxj-0004U0-S3
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:44:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmGxj-0004Tj-K0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:44:55 -0500
Date: Wed, 23 Jan 2019 11:44:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190123114448.GB5771@work-vm>
References: <20190122173111.29821-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122173111.29821-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: unegister fd handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jemmy858585@gmail.com, quintela@redhat.com, peterx@redhat.com

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Unregister the fd handler before we destroy the channel,
> otherwise we've got a race where we might land in the
> fd handler just as we're closing the device.
> 
> (The race is quite data dependent, you just have to have
> the right set of devices for it to trigger).
> 
> Corresponds to RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=1666601
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued

> ---
>  migration/rdma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 9b2e7e10aa..54a3c11540 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2321,6 +2321,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
>          rdma->connected = false;
>      }
>  
> +    qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
>      g_free(rdma->dest_blocks);
>      rdma->dest_blocks = NULL;
>  
> -- 
> 2.20.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
