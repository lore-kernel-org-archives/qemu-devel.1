Received: from eggs.gnu.org ([2001:4830:134:3::10]:43768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6Iqp-00062z-F1
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6Iqo-0007h1-7U
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:44:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34218 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f6Iqo-0007gm-2D
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:44:02 -0400
Date: Wed, 11 Apr 2018 17:43:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180411164357.GH2667@work-vm>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
	<1523089594-1422-5-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523089594-1422-5-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] migration: fix qemu carsh when RDMA
 live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> After postcopy, the destination qemu work in the dedicated
> thread, so only invoke yield_until_fd_readable before postcopy
> migration.

The subject line needs to be more discriptive:
   migration: Stop rdma yielding during incoming postcopy

I think.
(Also please check the subject spellings)

> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  migration/rdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 53773c7..81be482 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1489,11 +1489,13 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
>       * Coroutine doesn't start until migration_fd_process_incoming()
>       * so don't yield unless we know we're running inside of a coroutine.
>       */
> -    if (rdma->migration_started_on_destination) {
> +    if (rdma->migration_started_on_destination &&
> +        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE) {

OK, that's a bit delicate; watch if it ever gets called in a failure
case or similar - and also wathc out if we make more use of the status
on the destination, but otherwise, and with a fix for the subject;


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

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
