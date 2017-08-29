Received: from eggs.gnu.org ([2001:4830:134:3::10]:40109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmaCz-0004P5-2u
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmaCv-0006pm-Sj
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:41:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmaCv-0006pf-JN
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:41:05 -0400
Date: Tue, 29 Aug 2017 14:40:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170829064045.GW14174@pxdev.xzpeter.org>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-12-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170824192730.8440-12-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 11/32] vhub: Open userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

On Thu, Aug 24, 2017 at 08:27:09PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Open a userfaultfd (on a postcopy_advise) and send it back in
> the reply to the qemu for it to monitor.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++++++++++++---
>  contrib/libvhost-user/libvhost-user.h |  3 +++
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 47884c0a15..f9b5b12b28 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -15,6 +15,7 @@
>  
>  #include <qemu/osdep.h>
>  #include <sys/eventfd.h>
> +#include <sys/syscall.h>
>  #include <linux/vhost.h>
>  
>  #include "qemu/atomic.h"
> @@ -773,11 +774,30 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *vmsg)
>  static bool
>  vu_set_postcopy_advise(VuDev *dev, VhostUserMsg *vmsg)
>  {
> -    /* TODO: Open ufd, pass it back in the request
> -     * TODO: Add addresses 
> -     */
> +    struct uffdio_api api_struct;
> +
> +    dev->postcopy_ufd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> +    /* TODO: Add addresses */
>      vmsg->payload.u64 = 0xcafe;
>      vmsg->size = sizeof(vmsg->payload.u64);
> +
> +    if (dev->postcopy_ufd == -1) {
> +        vu_panic(dev, "Userfaultfd not available: %s", strerror(errno));
> +        goto out;

We got error but still goto out?  I feel like we should reply with
some kind of error code when any error happens.

> +    }
> +    api_struct.api = UFFD_API;
> +    api_struct.features = 0;
> +    if (ioctl(dev->postcopy_ufd, UFFDIO_API, &api_struct)) {
> +        vu_panic(dev, "Failed UFFDIO_API: %s", strerror(errno));
> +        close(dev->postcopy_ufd);
> +        dev->postcopy_ufd = -1;
> +        goto out;

Same here.

> +    }
> +    /* TODO: Stash feature flags somewhere */
> +out:
> +    /* Return a ufd to the QEMU */
> +    vmsg->fd_num = 1;
> +    vmsg->fds[0] = dev->postcopy_ufd;
>      return true; /* = send a reply */
>  }
>  
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
> index 3987ce643d..3e8efdd919 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -234,6 +234,9 @@ struct VuDev {
>       * re-initialize */
>      vu_panic_cb panic;
>      const VuDevIface *iface;
> +
> +    /* Postcopy data */
> +    int postcopy_ufd;
>  };
>  
>  typedef struct VuVirtqElement {
> -- 
> 2.13.5
> 

-- 
Peter Xu
