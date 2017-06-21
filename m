Received: from eggs.gnu.org ([2001:4830:134:3::10]:54803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNnlf-00083K-Mb
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNnlc-0005m7-Dk
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:06:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dNnlc-0005lB-7b
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:06:28 -0400
Date: Thu, 22 Jun 2017 01:06:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170622010619-mutt-send-email-mst@kernel.org>
References: <149806690313.3840.13274158676579302242.stgit@bahia.lan>
	<149806691869.3840.9613299727376965070.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149806691869.3840.9613299727376965070.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3 1/4] virtio-9p: record element after
 sanity checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Jun 21, 2017 at 07:41:58PM +0200, Greg Kurz wrote:
> If the guest sends a malformed request, we end up with a dangling pointer
> in V9fsVirtioState. This doesn't seem to cause any bug, but let's remove
> this side effect anyway.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/9pfs/virtio-9p-device.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 245abd8aaef1..3380bfc0c551 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -61,7 +61,6 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
>          }
>          QEMU_BUILD_BUG_ON(sizeof(out) != 7);
>  
> -        v->elems[pdu->idx] = elem;
>          len = iov_to_buf(elem->out_sg, elem->out_num, 0,
>                           &out, sizeof(out));
>          if (len != sizeof(out)) {
> @@ -70,6 +69,8 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
>              goto out_free_req;
>          }
>  
> +        v->elems[pdu->idx] = elem;
> +
>          pdu_submit(pdu, &out);
>      }
>  
