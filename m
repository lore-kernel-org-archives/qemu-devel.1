Received: from eggs.gnu.org ([2001:4830:134:3::10]:46482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBl6l-00083s-Sq
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBl6h-0007bJ-P7
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:55:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBl6h-0007bF-Ji
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:54:59 -0400
Date: Thu, 26 Apr 2018 18:54:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180426175454.GO2631@work-vm>
References: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
	<1524666934-8064-6-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524666934-8064-6-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] migration: Stop rdma yielding
 during incoming postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, licq@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> During incoming postcopy, the destination qemu will invoke
> qemu_rdma_wait_comp_channel in a seprate thread. So does not use rdma
> yield, and poll the completion channel fd instead.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

OK, I think so; it's a bit delicate, but I can't currently see a better
way.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/rdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 0652224..4ba9fe2 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1490,11 +1490,13 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
>       * Coroutine doesn't start until migration_fd_process_incoming()
>       * so don't yield unless we know we're running inside of a coroutine.
>       */
> -    if (rdma->migration_started_on_destination) {
> +    if (rdma->migration_started_on_destination &&
> +        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE) {
>          yield_until_fd_readable(rdma->comp_channel->fd);
>      } else {
>          /* This is the source side, we're in a separate thread
>           * or destination prior to migration_fd_process_incoming()
> +         * after postcopy, the destination also in a seprate thread.
>           * we can't yield; so we have to poll the fd.
>           * But we need to be able to handle 'cancel' or an error
>           * without hanging forever.
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
