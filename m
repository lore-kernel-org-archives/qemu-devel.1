Received: from eggs.gnu.org ([2001:4830:134:3::10]:45744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffM0z-0003zG-Ke
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffM0w-0000sF-Gf
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:11:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ffM0w-0000rj-Cr
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:11:22 -0400
Date: Tue, 17 Jul 2018 11:11:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180717111118.3ff93bc9.cohuck@redhat.com>
In-Reply-To: <20180716173743.133393-3-dgilbert@redhat.com>
References: <20180716173743.133393-1-dgilbert@redhat.com>
	<20180716173743.133393-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.1 2/4] virtio: Check
 qemu_get_virtqueue_element returns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, famz@redhat.com, amit@kernel.org

On Mon, 16 Jul 2018 18:37:41 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Check calls to qemu_get_virtqueue_element for NULL and pass
> up the chain.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/block/virtio-blk.c       | 4 ++++
>  hw/char/virtio-serial-bus.c | 4 ++++
>  hw/scsi/virtio-scsi.c       | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 50b5c869e3..324c6b2b27 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -888,6 +888,10 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
>          }
>  
>          req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
> +        if (!req) {
> +            error_report("%s: Bad vq element %u", __func__, vq_idx);

Minor nit: vq_idx is the virtqueue index, and this message makes it
look like it is the 'bad vq element'... either add 'vq index', or drop
it completely from the error message?

> +            return -EINVAL;
> +        }
>          virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
>          req->next = s->rq;
>          s->rq = req;

Anyway,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
