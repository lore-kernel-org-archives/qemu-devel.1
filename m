Received: from eggs.gnu.org ([209.51.188.92]:45537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHcif-0001Gf-Dt
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHcie-0002QB-4L
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:14:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hHcie-0002Ph-0a
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:14:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id i14so6810902qtr.10
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:14:55 -0700 (PDT)
Date: Fri, 19 Apr 2019 19:14:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190419191328-mutt-send-email-mst@kernel.org>
References: <20190416184624.15397-1-dan.streetman@canonical.com>
	<20190416184624.15397-2-dan.streetman@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416184624.15397-2-dan.streetman@canonical.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] add VirtIONet vhost_stopped flag to
 prevent multiple stops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Streetman <dan.streetman@canonical.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Tue, Apr 16, 2019 at 02:46:23PM -0400, Dan Streetman wrote:
> From: Dan Streetman <ddstreet@canonical.com>
> 
> Buglink: https://launchpad.net/bugs/1823458
> 
> There is a race condition when using the vhost-user driver, between a guest
> shutdown and the vhost-user interface being closed.  This is explained in
> more detail at the bug link above; the short explanation is the vhost-user
> device can be closed while the main thread is in the middle of stopping
> the vhost_net.  In this case, the main thread handling shutdown will
> enter virtio_net_vhost_status() and move into the n->vhost_started (else)
> block, and call vhost_net_stop(); while it is running that function,
> another thread is notified that the vhost-user device has been closed,
> and (indirectly) calls into virtio_net_vhost_status() also.  Since the
> vhost_net status hasn't yet changed, the second thread also enters
> the n->vhost_started block, and also calls vhost_net_stop().  This
> causes problems for the second thread when it tries to stop the network
> that's already been stopped.
> 
> This adds a flag to the struct that's atomically set to prevent more than
> one thread from calling vhost_net_stop().  The atomic_fetch_inc() is likely
> overkill and probably could be done with a simple check-and-set, but
> since it's a race condition there would still be a (very, very) small
> window without using an atomic to set it.

How? Isn't all this under the BQL?

> 
> Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> ---
>  hw/net/virtio-net.c            | 3 ++-
>  include/hw/virtio/virtio-net.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index ffe0872fff..d36f50d5dd 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -13,6 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/iov.h"
> +#include "qemu/atomic.h"
>  #include "hw/virtio/virtio.h"
>  #include "net/net.h"
>  #include "net/checksum.h"
> @@ -240,7 +241,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
>                           "falling back on userspace virtio", -r);
>              n->vhost_started = 0;
>          }
> -    } else {
> +    } else if (atomic_fetch_inc(&n->vhost_stopped) == 0) {
>          vhost_net_stop(vdev, n->nic->ncs, queues);
>          n->vhost_started = 0;
>      }
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index b96f0c643f..d03fd933d0 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -164,6 +164,7 @@ struct VirtIONet {
>      uint8_t nouni;
>      uint8_t nobcast;
>      uint8_t vhost_started;
> +    int vhost_stopped;
>      struct {
>          uint32_t in_use;
>          uint32_t first_multi;

OK questions same as any state:

- do we need to migrate this?
- reset it on device reset?

> -- 
> 2.20.1
