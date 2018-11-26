Received: from eggs.gnu.org ([2001:4830:134:3::10]:56361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gRKgV-0006yQ-4j
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gRKgU-0002cG-1Q
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:28:35 -0500
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Nov 2018 09:28:26 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181126172826.GB13784@roeck-us.net>
References: <20181126171745.4673-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126171745.4673-1-keith.busch@intel.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Fix spurious interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keith Busch <keith.busch@intel.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Nov 26, 2018 at 10:17:45AM -0700, Keith Busch wrote:
> The code had asserted an interrupt every time it was requested to check
> for new completion queue entries.This can result in spurious interrupts
> seen by the guest OS.
> 
> Fix this by asserting an interrupt only if there are un-acknowledged
> completion queue entries available.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  hw/block/nvme.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9fbe5673cb..7c8c63e8f5 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -272,7 +272,9 @@ static void nvme_post_cqes(void *opaque)
>              sizeof(req->cqe));
>          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
>      }
> -    nvme_irq_assert(n, cq);
> +    if (cq->tail != cq->head) {
> +        nvme_irq_assert(n, cq);
> +    }
>  }
>  
>  static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
> -- 
> 2.14.4
> 
