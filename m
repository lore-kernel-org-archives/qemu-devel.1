Received: from eggs.gnu.org ([2001:4830:134:3::10]:57424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXPZW-0006ud-76
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXPZS-0001An-7D
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:22:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fXPZS-0001Af-2d
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:22:10 -0400
Date: Mon, 25 Jun 2018 12:22:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180625112204.GH18580@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180625110706.23332-1-sameeh@daynix.com>
	<20180625110706.23332-3-sameeh@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625110706.23332-3-sameeh@daynix.com>
Subject: Re: [Qemu-devel] [RFC v2 2/2] virtio-net: Example Patch for using
 BPF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, Amnon Ilan <ailan@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Mon, Jun 25, 2018 at 02:07:06PM +0300, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
> 
> This commit is a sample only for using the libbpf in the code and
> shouldn't be committed.
> 
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>  hw/net/Makefile.objs | 4 ++++
>  hw/net/virtio-net.c  | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> index fa461d4463..0fb271436d 100644
> --- a/hw/net/Makefile.objs
> +++ b/hw/net/Makefile.objs
> @@ -37,6 +37,10 @@ obj-$(CONFIG_PSERIES) += spapr_llan.o
>  obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
>  
>  obj-$(CONFIG_VIRTIO_NET) += virtio-net.o
> +ifeq ($(CONFIG_BPF),y)
> +	virtio-net.o-cflags := $(CFLAGS_BPF)
> +	virtio-net.o-libs := $(LIBS_BPF)
> +endif
>  obj-y += vhost_net.o
>  
>  obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 90502fca7c..b4840838c1 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -27,6 +27,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "migration/misc.h"
>  #include "standard-headers/linux/ethtool.h"
> +#include "standard-headers/linux/libbpf.h"
>  
>  #define VIRTIO_NET_VM_VERSION    11
>  
> @@ -1329,6 +1330,9 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>      VirtQueueElement *elem;
>      int32_t num_packets = 0;
>      int queue_index = vq2q(virtio_get_queue_index(q->tx_vq));
> +
> +    struct bpf_object *obj = NULL;
> +    bpf_object__load(obj);

This really doesn't tell us anything useful about how this will be
used and integrated in qemu. I'd expect this patch to actually
be doing a real feature complete impl of RSS for virtio-net.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
