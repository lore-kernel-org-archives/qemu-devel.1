Received: from eggs.gnu.org ([2001:4830:134:3::10]:60349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eRdyQ-0003Pc-3T
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 07:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eRdyN-0005mF-IF
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 07:59:50 -0500
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:48367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eRdyN-0005k2-8x
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 07:59:47 -0500
Received: from player795.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 7DD99B5537
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 13:59:45 +0100 (CET)
Date: Wed, 20 Dec 2017 13:59:41 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171220135941.3599222f@bahia.lan>
In-Reply-To: <151359368310.6820.9701358868942550883.stgit@bahia.lan>
References: <151359366858.6820.6567549632253797169.stgit@bahia.lan>
	<151359368310.6820.9701358868942550883.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] 9pfs: allow PDU to complete without
 sending a reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, keno@juliacomputing.com

On Mon, 18 Dec 2017 11:41:23 +0100
Greg Kurz <groug@kaod.org> wrote:

> The 9p protocol mostly relies on a request/reply dialog between the
> client and the server. A notable exception to this rule is request
> cancellation (ie, flush in 9p wording): the server shouldn't send a
> reply when the request was flushed.
> 
> This patch changes the transport API so that the core 9p code may
> choose to discard a reply instead of pushing it back to the client.
> As a consequence, the push_and_notify naming isn't quite appropriate
> anymore. And by the way, this operation also frees ring descriptors
> allocated by the transport, ie, finalizes the completion of the PDU
> in the transport layer. It is hence renamed to pdu_complete.
> 
> This will be used by a subsequent patch to fix request cancellation.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p.c               |   10 +++++-----
>  hw/9pfs/9p.h               |    2 +-
>  hw/9pfs/virtio-9p-device.c |   11 +++++++----
>  hw/9pfs/xen-9p-backend.c   |   14 ++++++++------
>  4 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 1e4ebbe57687..dd8b7c6d69c6 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -642,7 +642,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
>  
>              ret = pdu_marshal(pdu, len, "s", &str);
>              if (ret < 0) {
> -                goto out_notify;
> +                goto out_complete;
>              }
>              len += ret;
>              id = P9_RERROR;
> @@ -650,7 +650,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
>  
>          ret = pdu_marshal(pdu, len, "d", err);
>          if (ret < 0) {
> -            goto out_notify;
> +            goto out_complete;
>          }
>          len += ret;
>  
> @@ -662,15 +662,15 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
>  
>      /* fill out the header */
>      if (pdu_marshal(pdu, 0, "dbw", (int32_t)len, id, pdu->tag) < 0) {
> -        goto out_notify;
> +        goto out_complete;
>      }
>  
>      /* keep these in sync */
>      pdu->size = len;
>      pdu->id = id;
>  
> -out_notify:
> -    pdu->s->transport->push_and_notify(pdu);
> +out_complete:
> +    pdu->s->transport->pdu_complete(pdu, false);
>  
>      /* Now wakeup anybody waiting in flush for this request */
>      if (!qemu_co_queue_next(&pdu->complete)) {
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index ffe658ab8975..ea7657837784 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -363,7 +363,7 @@ struct V9fsTransport {
>                                          unsigned int *pniov, size_t size);
>      void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
>                                           unsigned int *pniov, size_t size);
> -    void        (*push_and_notify)(V9fsPDU *pdu);
> +    void        (*pdu_complete)(V9fsPDU *pdu, bool discard);
>  };
>  
>  static inline int v9fs_register_transport(V9fsState *s, const V9fsTransport *t)
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 43f4e53f336f..083df987fd93 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -20,14 +20,17 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "qemu/iov.h"
>  
> -static void virtio_9p_push_and_notify(V9fsPDU *pdu)
> +static void virtio_pdu_complete(V9fsPDU *pdu, bool discard)
>  {
>      V9fsState *s = pdu->s;
>      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem = v->elems[pdu->idx];
>  
> -    /* push onto queue and notify */
> -    virtqueue_push(v->vq, elem, pdu->size);
> +    if (discard) {
> +        virtqueue_detach_element(v->vq, elem, 0);
> +    } else {
> +        virtqueue_push(v->vq, elem, pdu->size);

We should only notify the client if we actually push something
back, ie, only call virtio_notify() if discard is false...

> +    }
>      g_free(elem);
>      v->elems[pdu->idx] = NULL;
>  
> @@ -189,7 +192,7 @@ static const V9fsTransport virtio_9p_transport = {
>      .pdu_vunmarshal = virtio_pdu_vunmarshal,
>      .init_in_iov_from_pdu = virtio_init_in_iov_from_pdu,
>      .init_out_iov_from_pdu = virtio_init_out_iov_from_pdu,
> -    .push_and_notify = virtio_9p_push_and_notify,
> +    .pdu_complete = virtio_pdu_complete,
>  };
>  
>  static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index df2a4100bf55..dc1e6c88885d 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -210,7 +210,7 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
>      *pniov = num;
>  }
>  
> -static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
> +static void xen_9pfs_pdu_complete(V9fsPDU *pdu, bool discard)
>  {
>      RING_IDX prod;
>      Xen9pfsDev *priv = container_of(pdu->s, Xen9pfsDev, state);
> @@ -222,10 +222,12 @@ static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
>      ring->intf->out_cons = ring->out_cons;
>      xen_wmb();
>  
> -    prod = ring->intf->in_prod;
> -    xen_rmb();
> -    ring->intf->in_prod = prod + pdu->size;
> -    xen_wmb();
> +    if (!discard) {
> +        prod = ring->intf->in_prod;
> +        xen_rmb();
> +        ring->intf->in_prod = prod + pdu->size;
> +        xen_wmb();
> +    }
>  
>      ring->inprogress = false;
>      xenevtchn_notify(ring->evtchndev, ring->local_port);

... should xenevtchn_notify() be moved to the !discard block ?

> @@ -238,7 +240,7 @@ static const V9fsTransport xen_9p_transport = {
>      .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
>      .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
>      .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
> -    .push_and_notify = xen_9pfs_push_and_notify,
> +    .pdu_complete = xen_9pfs_pdu_complete,
>  };
>  
>  static int xen_9pfs_init(struct XenDevice *xendev)
> 
