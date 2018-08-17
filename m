Received: from eggs.gnu.org ([2001:4830:134:3::10]:53187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqfMq-0004yu-Dc
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqfMl-0007rC-BK
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fqfMl-0007qY-25
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:39 -0400
Date: Fri, 17 Aug 2018 15:04:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180817140434.GJ2459@work-vm>
References: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
	<1533562177-16447-11-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533562177-16447-11-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v6 10/11] migration: remove the unnecessary
 RDMA_CONTROL_ERROR message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> It's not necessary to send RDMA_CONTROL_ERROR when clean up rdma resource.
> If rdma->error_state is ture, the message may not send successfully.
> and the cm event can also notify the peer qemu.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

How does this keep 'cancel' working; I added 32bce196344 last year to
make that code also send the RDMA_CONTROL_ERROR in 'cancelling'.

Dave

> ---
>  migration/rdma.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index ae07515..e1498f2 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2305,17 +2305,6 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
>      int idx;
>  
>      if (rdma->cm_id && rdma->connected) {
> -        if ((rdma->error_state ||
> -             migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) &&
> -            !rdma->received_error) {
> -            RDMAControlHeader head = { .len = 0,
> -                                       .type = RDMA_CONTROL_ERROR,
> -                                       .repeat = 1,
> -                                     };
> -            error_report("Early error. Sending error.");
> -            qemu_rdma_post_send_control(rdma, NULL, &head);
> -        }
> -
>          rdma_disconnect(rdma->cm_id);
>          trace_qemu_rdma_cleanup_disconnect();
>          rdma->connected = false;
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
