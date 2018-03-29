Received: from eggs.gnu.org ([2001:4830:134:3::10]:52324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f1Ydh-0004We-Aq
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 10:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f1Ydd-00085Q-8R
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 10:34:53 -0400
Date: Thu, 29 Mar 2018 16:34:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180329163437.149bb755.cohuck@redhat.com>
In-Reply-To: <1522316251-16399-1-git-send-email-thuth@redhat.com>
References: <1522316251-16399-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: Increase virtio
 timeout to 30 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, ldoktor@redhat.com

On Thu, 29 Mar 2018 11:37:31 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The current timeout is set to only three seconds - and considering that
> vring_wait_reply() or rather get_second() is not doing any rounding,
> the real timeout is likely rather 2 seconds in most cases. When the
> host is really badly loaded and we run the guest in TCG mode instead
> of KVM, it's possible that we hit this timeout by mistake. So let's
> increase the timeout to 30 seconds instead to ease this situation (30
> seconds is also the timeout that is used by the Linux SCSI subsystem
> for example, so this seems to be a sane value for block IO timeout).
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1549079
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 817e7f5..cdb66f4 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -14,7 +14,7 @@
>  #include "virtio-scsi.h"
>  #include "bswap.h"
>  
> -#define VRING_WAIT_REPLY_TIMEOUT 3
> +#define VRING_WAIT_REPLY_TIMEOUT 30
>  
>  static VRing block[VIRTIO_MAX_VQS];
>  static char ring_area[VIRTIO_RING_SIZE * VIRTIO_MAX_VQS]

Thanks, merged this and a rebuild into s390-fixes.
