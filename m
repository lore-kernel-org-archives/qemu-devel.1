Received: from eggs.gnu.org ([2001:4830:134:3::10]:34211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1gRJcj-0004PE-HF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1gRJci-0006W7-Nl
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:20:37 -0500
Date: Mon, 26 Nov 2018 09:17:17 -0700
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20181126161716.GR26707@localhost.localdomain>
References: <1543187035-32757-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543187035-32757-1-git-send-email-linux@roeck-us.net>
Subject: Re: [Qemu-devel] [PATCH] nvme: Only generate interupt if warranted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Sun, Nov 25, 2018 at 03:03:55PM -0800, Guenter Roeck wrote:
> So far the code generates interrupts even if it doesn't pass any new
> information to the user. This can result in spurious interrupts as
> sometimes observed with Linux.
> 
> Only generate interrupts if warranted, ie if anything new is passed
> to the emulated code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/block/nvme.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9fbe567..c543c01 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -252,6 +252,7 @@ static void nvme_post_cqes(void *opaque)
>      NvmeCQueue *cq = opaque;
>      NvmeCtrl *n = cq->ctrl;
>      NvmeRequest *req, *next;
> +    bool assert_irq = false;
>  
>      QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
>          NvmeSQueue *sq;
> @@ -271,8 +272,11 @@ static void nvme_post_cqes(void *opaque)
>          pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
>              sizeof(req->cqe));
>          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
> +        assert_irq = true;
> +    }
> +    if (assert_irq) {
> +        nvme_irq_assert(n, cq);
>      }
> -    nvme_irq_assert(n, cq);
>  }
>  
>  static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
> -- 

There is a corner case this may break. For example, a controller posts
2 completions. The host happens to only see one of those completions due
to the inherent race when reading the phase bit. After the host updates
the CQ DB, the controller ought to send another interrupt even if it
didn't post any new CQEs to prevent command completion timeouts. This
might get the right behavior:

---
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fc7dacb816..486db6e561 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -272,7 +272,9 @@ static void nvme_post_cqes(void *opaque)
             sizeof(req->cqe));
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
-    nvme_irq_assert(n, cq);
+    if (cq->tail != cq->head) {
+        nvme_irq_assert(n, cq);
+    }
 }

 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
--
