Received: from eggs.gnu.org ([2001:4830:134:3::10]:37013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUqzZ-0007K6-IF
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUqzW-0001to-H6
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUqzW-0001tZ-7O
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:57:58 -0400
Date: Tue, 11 Jul 2017 10:57:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711105753.2f7f2625@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499700760-4777-10-git-send-email-thuth@redhat.com>
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
	<1499700760-4777-10-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/10] pc-bios/s390-ccw: Add virtio-net
 driver code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Mon, 10 Jul 2017 17:32:39 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The driver provides the recv() and send() functions which will
> be required by SLOF's libnet code for receiving and sending
> packets.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/netboot.mak  |   2 +-
>  pc-bios/s390-ccw/virtio-net.c | 133 ++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio.c     |   9 ++-
>  pc-bios/s390-ccw/virtio.h     |  14 ++++-
>  4 files changed, 153 insertions(+), 5 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/virtio-net.c
> 

> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
> new file mode 100644
> index 0000000..804e7af
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-net.c
> @@ -0,0 +1,133 @@
> +/*
> + * Virtio-net driver for the s390-ccw firmware
> + *
> + * Copyright 2017 Thomas Huth, Red Hat Inc.
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <ethernet.h>
> +#include "s390-ccw.h"
> +#include "virtio.h"
> +
> +#ifndef DEBUG_VIRTIO_NET
> +#define DEBUG_VIRTIO_NET 0
> +#endif
> +
> +#define VIRTIO_NET_F_MAC_BIT  (1 << 5)
> +
> +#define VQ_RX 0         /* Receive queue */
> +#define VQ_TX 1         /* Transmit queue */
> +
> +struct VirtioNetHdr {
> +    uint8_t flags;
> +    uint8_t gso_type;
> +    uint16_t hdr_len;
> +    uint16_t gso_size;
> +    uint16_t csum_start;
> +    uint16_t csum_offset;
> +    /*uint16_t num_buffers;*/ /* Only with VIRTIO_NET_F_MRG_RXBUF or VIRTIO1 */
> +};
> +typedef struct VirtioNetHdr VirtioNetHdr;
> +
> +static uint16_t rx_last_idx;  /* Last index in receive queue "used" ring */
> +
> +int virtio_net_init(void *mac_addr)
> +{
> +    VDev *vdev = virtio_get_device();
> +    VRing *rxvq = &vdev->vrings[VQ_RX];
> +    uint32_t guestfeats[2] = { VIRTIO_NET_F_MAC_BIT, 0 };
> +    void *buf;
> +    int i;
> +
> +    virtio_setup_ccw(vdev, guestfeats);

I'd assert here that the mac feature bit was actually set. That should
be the case anyway, but let's make it sure.

> +
> +    memcpy(mac_addr, vdev->config.net.mac, ETH_ALEN);
> +
> +    for (i = 0; i < 64; i++) {
> +        buf = malloc(ETH_MTU_SIZE + sizeof(VirtioNetHdr));
> +        IPL_assert(buf != NULL, "Can not allocate memory for receive buffers");
> +        vring_send_buf(rxvq, buf, ETH_MTU_SIZE + sizeof(VirtioNetHdr),
> +                       VRING_DESC_F_WRITE);
> +    }
> +    vring_notify(rxvq);
> +
> +    return 0;
> +}

> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index e3dcfd3..4cd70df 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -150,7 +150,7 @@ static void vring_init(VRing *vr, VqInfo *info)
>      debug_print_addr("init vr", vr);
>  }
>  
> -static bool vring_notify(VRing *vr)
> +bool vring_notify(VRing *vr)
>  {
>      vr->cookie = virtio_notify(vr->schid, vr->id, vr->cookie);
>      return vr->cookie >= 0;
> @@ -189,7 +189,7 @@ ulong get_second(void)
>      return (get_clock() >> 12) / 1000000;
>  }
>  
> -static int vr_poll(VRing *vr)
> +int vr_poll(VRing *vr)
>  {
>      if (vr->used->idx == vr->used_idx) {
>          vring_notify(vr);

If you're going to do a re-spin, I'd prefer to move exporting the
interfaces into one of the prep patches, if that makes sense.

But generally looks good to me.
