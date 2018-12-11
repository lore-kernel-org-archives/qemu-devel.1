Received: from eggs.gnu.org ([2001:4830:134:3::10]:48061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gWjOR-0003kh-8A
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gWjON-0005ny-8R
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:52:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gWjOM-0005mH-Pf
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:52:11 -0500
Date: Tue, 11 Dec 2018 16:51:54 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181211145154.GA28105@lap1>
References: <20181211132642.3027-1-ppandit@redhat.com>
	<20181211132642.3027-2-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211132642.3027-2-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] rdma: check that num_sge does not
 exceed MAX_SGE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Tue, Dec 11, 2018 at 06:56:38PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> rdma back-end has scatter/gather array ibv_sge[MAX_SGE=4] set
> to have 4 elements. A guest could send a 'PvrdmaSqWqe' ring element
> with 'num_sge' set to > MAX_SGE, which may lead to OOB access issue.
> Add check to avoid it.
> 
> Reported-by: Saar Amar <saaramar5@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/rdma/rdma_backend.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index d7a4bbd91f..0b3b98a94c 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -311,8 +311,8 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>      }
>  
>      pr_dbg("num_sge=%d\n", num_sge);
> -    if (!num_sge) {
> -        pr_dbg("num_sge=0\n");
> +    if (!num_sge || num_sge > MAX_SGE) {
> +        pr_dbg("invalid num_sge=%d\n", num_sge);
>          comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);

Please use VENDOR_ERR_INV_NUM_SGE

>          return;
>      }
> @@ -390,8 +390,8 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>      }
>  
>      pr_dbg("num_sge=%d\n", num_sge);
> -    if (!num_sge) {
> -        pr_dbg("num_sge=0\n");
> +    if (!num_sge || num_sge > MAX_SGE) {
> +        pr_dbg("invalid num_sge=%d\n", num_sge);
>          comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);

Ditto.

And since VENDOR_ERR_NO_SGE is no loger used it can be delete.

>          return;
>      }
> -- 
> 2.19.2
> 
