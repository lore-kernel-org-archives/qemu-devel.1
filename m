Received: from eggs.gnu.org ([2001:4830:134:3::10]:60655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cb6CM-0007np-AE
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cb6CL-00080m-B2
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:46 -0500
References: <20170207132723.13934-1-famz@redhat.com>
	<20170207132723.13934-3-famz@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <25ac6a9f-c393-1a9a-e7f1-f8e3374135ee@redhat.com>
Date: Tue, 7 Feb 2017 14:52:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170207132723.13934-3-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-blk: Inline request init,
 complete and free functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On 02/07/17 14:27, Fam Zheng wrote:
> These are used in each request handling, inline them.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/block/virtio-blk.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 2858c31..1da9570 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -29,8 +29,8 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
>  
> -static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
> -                                    VirtIOBlockReq *req)
> +static inline void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
> +                                           VirtIOBlockReq *req)
>  {
>      req->dev = s;
>      req->vq = vq;
> @@ -40,12 +40,13 @@ static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
>      req->mr_next = NULL;
>  }
>  
> -static void virtio_blk_free_request(VirtIOBlockReq *req)
> +static inline void virtio_blk_free_request(VirtIOBlockReq *req)
>  {
>      g_free(req);
>  }
>  
> -static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
> +static inline void virtio_blk_req_complete(VirtIOBlockReq *req,
> +                                           unsigned char status)
>  {
>      VirtIOBlock *s = req->dev;
>      VirtIODevice *vdev = VIRTIO_DEVICE(s);
> 

Hm, virtio_blk_req_complete() looks a bit too "meaty" and seems to be
called from a little too many places for me to feel convenient about
inlining it. I guess I'd leave it to the compiler to optimize the
function call. Does the explicit hint offer a noticeable perf improvement?

Inlining virtio_blk_free_request() looks reasonable.

virtio_blk_init_request() looks okay too.

Other reviewers should feel free to override my concerns :) My view on
this is distant.

Thanks
Laszlo
