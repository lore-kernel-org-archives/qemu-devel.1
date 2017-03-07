Received: from eggs.gnu.org ([2001:4830:134:3::10]:38382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clCLq-0006QM-9U
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clCLp-0003tO-Gg
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:28:18 -0500
Date: Tue, 7 Mar 2017 18:28:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170307102809.GA6623@lemon.lan>
References: <20170207132723.13934-1-famz@redhat.com>
	<20170207132723.13934-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170207132723.13934-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-blk: Remove useless condition
 around g_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, 02/07 21:27, Fam Zheng wrote:
> Laszlo spotted and studied this wasteful "if". He pointed out:
> 
> The original virtio_blk_free_request needed an "if" as it accesses one
> field, since 671ec3f05655 ("virtio-blk: Convert VirtIOBlockReq.elem to
> pointer", 2014-06-11); later on in f897bf751fbd ("virtio-blk: embed
> VirtQueueElement in VirtIOBlockReq", 2014-07-09) the field became
> embedded, so the "if" became unnecessary (at which point we were using
> g_slice_free(), but it is the same.
> 
> Now drop it.
> 
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/block/virtio-blk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 702eda8..2858c31 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -42,9 +42,7 @@ static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
>  
>  static void virtio_blk_free_request(VirtIOBlockReq *req)
>  {
> -    if (req) {
> -        g_free(req);
> -    }
> +    g_free(req);
>  }
>  
>  static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
> -- 
> 2.9.3
> 
> 

Cc: qemu-trivial@nongnu.org

(Let's drop 2/2 and perhaps merge this via trivial)

Fam
