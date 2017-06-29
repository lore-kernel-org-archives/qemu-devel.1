Received: from eggs.gnu.org ([2001:4830:134:3::10]:42496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQivo-0005KB-SC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQivl-0001oV-Kk
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:33:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dQivl-0001o1-Be
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:33:01 -0400
Date: Fri, 30 Jun 2017 02:32:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170630023253-mutt-send-email-mst@kernel.org>
References: <149868263738.23385.16723444264552987199.stgit@bahia.lan>
	<149868266150.23385.2902323487462062636.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149868266150.23385.2902323487462062636.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v5 2/5] virtio-9p: message header is 7-byte
 long
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

On Wed, Jun 28, 2017 at 10:44:21PM +0200, Greg Kurz wrote:
> The 9p spec at http://man.cat-v.org/plan_9/5/intro reads:
> 
>  "Each 9P message begins with a four-byte size field specify-
>   ing the length in bytes of the complete message including
>   the four bytes of the size field itself.  The next byte is
>   the message type, one of the constants in the enumeration in
>   the include file <fcall.h>.  The next two bytes are an iden-
>   tifying tag, described below."
> 
> ie, each message starts with a 7-byte long header.
> 
> The core 9P code already assumes this pretty much everywhere. This patch
> does the following:
> - makes the assumption explicit in the common 9p.h header, since it isn't
>   related to the transport
> - open codes the header size in handle_9p_output() and hardens the sanity
>   check on the space needed for the reply message
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/9pfs/9p.h               |    5 +++++
>  hw/9pfs/virtio-9p-device.c |    8 +++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index c886ba78d2ee..aac1b0b2ce3d 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -124,6 +124,11 @@ typedef struct {
>      uint8_t id;
>      uint16_t tag_le;
>  } QEMU_PACKED P9MsgHeader;
> +/* According to the specification, 9p messages start with a 7-byte header.
> + * Since most of the code uses this header size in literal form, we must be
> + * sure this is indeed the case.
> + */
> +QEMU_BUILD_BUG_ON(sizeof(P9MsgHeader) != 7);
>  
>  struct V9fsPDU
>  {
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 3380bfc0c551..1a68c1622d3a 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -53,17 +53,15 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
>              goto out_free_pdu;
>          }
>  
> -        if (elem->in_num == 0) {
> +        if (iov_size(elem->in_sg, elem->in_num) < 7) {
>              virtio_error(vdev,
>                           "The guest sent a VirtFS request without space for "
>                           "the reply");
>              goto out_free_req;
>          }
> -        QEMU_BUILD_BUG_ON(sizeof(out) != 7);
>  
> -        len = iov_to_buf(elem->out_sg, elem->out_num, 0,
> -                         &out, sizeof(out));
> -        if (len != sizeof(out)) {
> +        len = iov_to_buf(elem->out_sg, elem->out_num, 0, &out, 7);
> +        if (len != 7) {
>              virtio_error(vdev, "The guest sent a malformed VirtFS request: "
>                           "header size is %zd, should be 7", len);
>              goto out_free_req;
