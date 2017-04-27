Received: from eggs.gnu.org ([2001:4830:134:3::10]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d3oVp-0005a4-Bh
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d3oVm-0003C2-9y
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:51:33 -0400
Received: from mail.kernel.org ([198.145.29.136]:46938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d3oVm-0003Ac-0w
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:51:30 -0400
Date: Thu, 27 Apr 2017 11:51:24 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <149328636874.30266.8813988060953128881.stgit@bahia>
Message-ID: <alpine.DEB.2.10.1704271120100.11141@sstabellini-ThinkPad-X260>
References: <149328633283.30266.4224847428546759127.stgit@bahia>
	<149328636874.30266.8813988060953128881.stgit@bahia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 4/4] 9pfs: handle broken transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 27 Apr 2017, Greg Kurz wrote:
> The 9p protocol is transport agnostic: if an error occurs when copying data
> to/from the client, this should be handled by the transport layer [1] and
> the 9p server should simply stop processing requests [2].
> 
> [1] can be implemented in the transport marshal/unmarshal handlers. In the
> case of virtio, this means calling virtio_error() to inform the guest that
> the device isn't functional anymore.
> 
> [2] means that the pdu_complete() function shouldn't send a reply back to
> the client if the transport had a failure. This cannot be decided using the
> current error path though, since we cannot discriminate if the error comes
> from the transport or the backend. This patch hence introduces a flag in
> the 9pfs state to record that the transport is broken. The device needs to
> be reset for the flag to be unset.
> 
> This fixes Coverity issue CID 1348518.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - use unlikely() when checking if the transport is broken
>     - fail marshal/unmarshal if transport is broken
>     - v9fs_xattr_read() mark transport as broken if v9fs_pack() fails
> ---
>  hw/9pfs/9p.c               |   45 ++++++++++++++++++++++++++++++++++++--------
>  hw/9pfs/9p.h               |    1 +
>  hw/9pfs/virtio-9p-device.c |   16 ++++++++++++++--
>  3 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 01deffa0c3b5..406c1937ed21 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -46,10 +46,17 @@ ssize_t pdu_marshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
>      ssize_t ret;
>      va_list ap;
>  
> +    if (unlikely(pdu->s->transport_broken)) {
> +        return -EIO;
> +    }
> +
>      va_start(ap, fmt);
>      ret = pdu->s->transport->pdu_vmarshal(pdu, offset, fmt, ap);
>      va_end(ap);
>  
> +    if (ret < 0) {
> +        pdu->s->transport_broken = true;
> +    }
>      return ret;
>  }
>  
> @@ -58,10 +65,17 @@ ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
>      ssize_t ret;
>      va_list ap;
>  
> +    if (unlikely(pdu->s->transport_broken)) {
> +        return -EIO;
> +    }
> +
>      va_start(ap, fmt);
>      ret = pdu->s->transport->pdu_vunmarshal(pdu, offset, fmt, ap);
>      va_end(ap);
>  
> +    if (ret < 0) {
> +        pdu->s->transport_broken = true;
> +    }
>      return ret;
>  }
>  
> @@ -624,15 +638,15 @@ void pdu_free(V9fsPDU *pdu)
>      QLIST_INSERT_HEAD(&s->free_list, pdu, next);
>  }
>  
> -/*
> - * We don't do error checking for pdu_marshal/unmarshal here
> - * because we always expect to have enough space to encode
> - * error details
> - */
>  static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
>  {
>      int8_t id = pdu->id + 1; /* Response */
>      V9fsState *s = pdu->s;
> +    int ret;
> +
> +    if (unlikely(s->transport_broken)) {
> +        goto out_complete;
> +    }
>  
>      if (len < 0) {
>          int err = -len;
> @@ -644,11 +658,19 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
>              str.data = strerror(err);
>              str.size = strlen(str.data);
>  
> -            len += pdu_marshal(pdu, len, "s", &str);
> +            ret = pdu_marshal(pdu, len, "s", &str);
> +            if (ret < 0) {
> +                goto out_complete;
> +            }
> +            len += ret;
>              id = P9_RERROR;
>          }
>  
> -        len += pdu_marshal(pdu, len, "d", err);
> +        ret = pdu_marshal(pdu, len, "d", err);
> +        if (ret < 0) {
> +            goto out_complete;
> +        }
> +        len += ret;
>  
>          if (s->proto_version == V9FS_PROTO_2000L) {
>              id = P9_RLERROR;
> @@ -657,7 +679,10 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
>      }
>  
>      /* fill out the header */
> -    pdu_marshal(pdu, 0, "dbw", (int32_t)len, id, pdu->tag);
> +    ret = pdu_marshal(pdu, 0, "dbw", (int32_t)len, id, pdu->tag);
> +    if (ret < 0) {
> +        goto out_complete;
> +    }

If I am not mistaken, none of these "if (ret < 0)" are necessary in
pdu_complete. Just like any of the other call sites of
pdu_marshal/pdu_unmarshal, we could just let it go through the calls,
which would actually do nothing once transport_broken is set.

We could move the transport_broken check right before the call to
push_and_notify.


>      /* keep these in sync */
>      pdu->size = len;
> @@ -665,6 +690,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
>  
>      pdu->s->transport->push_and_notify(pdu);
>  
> +out_complete:
>      /* Now wakeup anybody waiting in flush for this request */
>      if (!qemu_co_queue_next(&pdu->complete)) {
>          pdu_free(pdu);
> @@ -1702,6 +1728,7 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
>                      read_count);
>      qemu_iovec_destroy(&qiov_full);
>      if (err < 0) {
> +        s->transport_broken = true;
>          return err;
>      }
>      offset += err;
> @@ -3596,6 +3623,8 @@ void v9fs_reset(V9fsState *s)
>      while (!data.done) {
>          aio_poll(qemu_get_aio_context(), true);
>      }
> +
> +    s->transport_broken = false;
>  }
>  
>  static void __attribute__((__constructor__)) v9fs_set_fd_limit(void)
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 5312d8a42405..145d0c87dd6a 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -246,6 +246,7 @@ typedef struct V9fsState
>      Error *migration_blocker;
>      V9fsConf fsconf;
>      V9fsQID root_qid;
> +    bool transport_broken;
>  } V9fsState;
>  
>  /* 9p2000.L open flags */
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index c71659823fdc..9e61fbf7c63e 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -158,8 +158,14 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
>      V9fsState *s = pdu->s;
>      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem = v->elems[pdu->idx];
> +    int ret;
>  
> -    return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
> +    ret = v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
> +    if (ret < 0) {
> +        virtio_9p_error(v, pdu->idx,
> +                        "Failed to marshal VirtFS reply type %d", pdu->id);
> +    }
> +    return ret;
>  }
>  
>  static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
> @@ -168,8 +174,14 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
>      V9fsState *s = pdu->s;
>      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem = v->elems[pdu->idx];
> +    int ret;
>  
> -    return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
> +    ret = v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
> +    if (ret < 0) {
> +        virtio_9p_error(v, pdu->idx,
> +                        "Failed to unmarshal VirtFS request type %d", pdu->id);
> +    }
> +    return ret;
>  }
>  
>  /* The size parameter is used by other transports. Do not drop it. */
