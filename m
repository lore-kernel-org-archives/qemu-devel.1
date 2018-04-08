Received: from eggs.gnu.org ([2001:4830:134:3::10]:46006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f51P8-0000rE-KM
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 23:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f51P3-0001ab-On
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 23:54:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f51P3-0001Zm-Ja
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 23:54:05 -0400
Date: Sun, 8 Apr 2018 06:53:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180408065347-mutt-send-email-mst@kernel.org>
References: <20180406185125.12536-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406185125.12536-1-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12] tap: set vhostfd passed from
 qemu cli to non-blocking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Thomas.Lendacky@amd.com, Jason Wang <jasowang@redhat.com>

On Fri, Apr 06, 2018 at 01:51:25PM -0500, Brijesh Singh wrote:
> A guest boot hangs while probing the network interface when
> iommu_platform=on is used.
> 
> The following qemu cli hangs without this patch:
> 
> # $QEMU \
>   -netdev tap,fd=3,id=hostnet0,vhost=on,vhostfd=4 3<>/dev/tap67 4<>/dev/host-net \
>   -device virtio-net-pci,netdev=hostnet0,id=net0,iommu_platform=on,disable-legacy=on \
>   ...
> 
> Commit: c471ad0e9bd46 (vhost_net: device IOTLB support) took care of
> setting vhostfd to non-blocking when QEMU opens /dev/host-net but if
> the fd is passed from qemu cli then we need to ensure that fd is set
> to non-blocking.
> 
> Fixes: c471ad0e9bd46 "vhost_net: device IOTLB support"
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
> Changes since v1:
>  - use qemu_set_nonblock() instead of fcntl(..)
> 
>  net/tap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/tap.c b/net/tap.c
> index 2b3a36f9b50d..89c4e19162a2 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -40,6 +40,7 @@
>  #include "qemu-common.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> +#include "qemu/sockets.h"
>  
>  #include "net/tap.h"
>  
> @@ -693,6 +694,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>                  }
>                  return;
>              }
> +            qemu_set_nonblock(vhostfd);
>          } else {
>              vhostfd = open("/dev/vhost-net", O_RDWR);
>              if (vhostfd < 0) {
> -- 
> 2.14.3
