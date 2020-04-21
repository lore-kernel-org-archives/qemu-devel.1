Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B88DC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 03:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDED2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 03:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeLvPzeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDED2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQk2z-0006sT-1G
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 23:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jQk2G-0006TA-Rz
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 23:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jQk2E-0008Pt-Rx
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 23:57:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31577
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jQk2E-0008M8-Bt
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 23:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587441440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9PDU5rLChasez2noTfFtNiEfffdyqhEIRs+zN4Q3s0=;
 b=UeLvPzePt/jvBEMazkhjqaIiCcJQ5fa+KCujh+Q43V7Qf1pnc9a86TrSS540qXw2mUcKAJ
 d+2Inhm7F17BU9mbUlKGqL6u7yP1BkAk+rj6ZDbZh4eO0hOCZFFaFSV4lYHLK3QkAG9M6g
 L4j/I35a3NcVPQJafmp5HJQ0mTNZfMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-tb4X4rUQPQ6FdKG9tWbR8A-1; Mon, 20 Apr 2020 23:57:16 -0400
X-MC-Unique: tb4X4rUQPQ6FdKG9tWbR8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DAE0DB25;
 Tue, 21 Apr 2020 03:57:14 +0000 (UTC)
Received: from [10.72.12.74] (ovpn-12-74.pek2.redhat.com [10.72.12.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60BDE5DA7C;
 Tue, 21 Apr 2020 03:56:48 +0000 (UTC)
Subject: Re: [RFC v1 3/4] vhost-vdpa: implement vhost-vdpa backend
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a6310935-83e3-903b-9221-c6ead28dffac@redhat.com>
Date: Tue, 21 Apr 2020 11:56:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200420093241.4238-4-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 23:40:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, aadam@redhat.com,
 rdunlap@infradead.org, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:
> Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> vhost-user. The above patch provides a generic device for vDPA purpose,
> this vDPA device exposes to user space a non-vendor-specific configuratio=
n
> interface for setting up a vhost HW accelerator, this patch set introduce=
s
> a third vhost backend called vhost-vdpa based on the vDPA interface.
>
> Vhost-vdpa usage:
>
>    qemu-system-x86_64 -cpu host -enable-kvm \
>      ......
>    -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-id,id=3Dvhost-vdp=
a0 \
>    -device virtio-net-pci,netdev=3Dvhost-vdpa0,page-per-vq=3Don \


Actually, this part should belongs to patch 2.

And we probably need to add a comment that vIOMMU is not supported right=20
now.


>
> Author: Tiwei Bie
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   hw/net/vhost_net.c                |  43 ++++
>   hw/net/virtio-net.c               |   9 +
>   hw/virtio/Makefile.objs           |   2 +-
>   hw/virtio/vhost-backend.c         |   3 +
>   hw/virtio/vhost-vdpa.c            | 379 ++++++++++++++++++++++++++++++
>   hw/virtio/vhost.c                 |   5 +
>   include/hw/virtio/vhost-backend.h |   6 +-
>   include/hw/virtio/vhost-vdpa.h    |  14 ++
>   8 files changed, 459 insertions(+), 2 deletions(-)
>   create mode 100644 hw/virtio/vhost-vdpa.c
>   create mode 100644 include/hw/virtio/vhost-vdpa.h
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 4096d64aaf..0d13fda2fc 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -17,8 +17,10 @@
>   #include "net/net.h"
>   #include "net/tap.h"
>   #include "net/vhost-user.h"
> +#include "net/vhost-vdpa.h"
>  =20
>   #include "standard-headers/linux/vhost_types.h"
> +#include "linux-headers/linux/vhost.h"
>   #include "hw/virtio/virtio-net.h"
>   #include "net/vhost_net.h"
>   #include "qemu/error-report.h"
> @@ -85,6 +87,29 @@ static const int user_feature_bits[] =3D {
>       VHOST_INVALID_FEATURE_BIT
>   };
>  =20
> +static const int vdpa_feature_bits[] =3D {
> +    VIRTIO_F_NOTIFY_ON_EMPTY,
> +    VIRTIO_RING_F_INDIRECT_DESC,
> +    VIRTIO_RING_F_EVENT_IDX,
> +    VIRTIO_F_ANY_LAYOUT,
> +    VIRTIO_F_VERSION_1,
> +    VIRTIO_NET_F_CSUM,
> +    VIRTIO_NET_F_GUEST_CSUM,
> +    VIRTIO_NET_F_GSO,
> +    VIRTIO_NET_F_GUEST_TSO4,
> +    VIRTIO_NET_F_GUEST_TSO6,
> +    VIRTIO_NET_F_GUEST_ECN,
> +    VIRTIO_NET_F_GUEST_UFO,
> +    VIRTIO_NET_F_HOST_TSO4,
> +    VIRTIO_NET_F_HOST_TSO6,
> +    VIRTIO_NET_F_HOST_ECN,
> +    VIRTIO_NET_F_HOST_UFO,
> +    VIRTIO_NET_F_MRG_RXBUF,
> +    VIRTIO_NET_F_MTU,
> +    VIRTIO_F_IOMMU_PLATFORM,
> +    VIRTIO_NET_F_GUEST_ANNOUNCE,
> +    VHOST_INVALID_FEATURE_BIT
> +};
>   static const int *vhost_net_get_feature_bits(struct vhost_net *net)
>   {
>       const int *feature_bits =3D 0;
> @@ -96,6 +121,9 @@ static const int *vhost_net_get_feature_bits(struct vh=
ost_net *net)
>       case NET_CLIENT_DRIVER_VHOST_USER:
>           feature_bits =3D user_feature_bits;
>           break;
> +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> +        feature_bits =3D vdpa_feature_bits;
> +        break;
>       default:
>           error_report("Feature bits not defined for this type: %d",
>                   net->nc->info->type);
> @@ -434,6 +462,10 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>           assert(vhost_net);
>           break;
>   #endif
> +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> +        vhost_net =3D vhost_vdpa_get_vhost_net(nc);
> +        assert(vhost_net);
> +        break;
>       default:
>           break;
>       }
> @@ -465,3 +497,14 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_=
t mtu)
>  =20
>       return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
>   }
> +int vhost_set_state(NetClientState *nc, int state)
> +{
> +    struct vhost_net *net =3D get_vhost_net(nc);
> +    struct vhost_dev *hdev =3D &net->dev;
> +    if (nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
> +        if (hdev->vhost_ops->vhost_set_state) {
> +                return hdev->vhost_ops->vhost_set_state(hdev, state);
> +             }
> +        }
> +    return 0;
> +}
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index db3d7c38e6..bbecd7ab96 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -206,6 +206,9 @@ static void virtio_net_vhost_status(VirtIONet *n, uin=
t8_t status)
>       VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>       NetClientState *nc =3D qemu_get_queue(n->nic);
>       int queues =3D n->multiqueue ? n->max_queues : 1;
> +    NetClientState *peer =3D nc->peer;


qemu_get_peer()?


> +    uint8_t status_set  =3D vdev->status ;
> +    uint8_t vhost_started_pre =3D n->vhost_started;
>  =20
>       if (!get_vhost_net(nc->peer)) {
>           return;
> @@ -245,6 +248,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uin=
t8_t status)
>                   return;
>               }
>           }
> +        status_set =3D status_set | VIRTIO_CONFIG_S_DRIVER_OK;
>  =20
>           n->vhost_started =3D 1;
>           r =3D vhost_net_start(vdev, n->nic->ncs, queues);
> @@ -252,11 +256,16 @@ static void virtio_net_vhost_status(VirtIONet *n, u=
int8_t status)
>               error_report("unable to start vhost net: %d: "
>                            "falling back on userspace virtio", -r);
>               n->vhost_started =3D 0;
> +            status_set =3D status_set & ~VIRTIO_CONFIG_S_DRIVER_OK;
>           }
>       } else {
>           vhost_net_stop(vdev, n->nic->ncs, queues);
> +        status_set =3D status_set & ~VIRTIO_CONFIG_S_DRIVER_OK;
>           n->vhost_started =3D 0;
>       }
> +    if (vhost_started_pre !=3D n->vhost_started) {
> +            vhost_set_state(peer, status_set);
> +    }
>   }


I think this deserves an independent patch.



>  =20
>   static int virtio_net_set_vnet_endian_one(VirtIODevice *vdev,
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index e2f70fbb89..17361d959e 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -2,7 +2,7 @@ ifeq ($(CONFIG_VIRTIO),y)
>   common-obj-y +=3D virtio-bus.o
>   obj-y +=3D virtio.o
>  =20
> -obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) +=3D vhost.o=
 vhost-backend.o
> +obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) +=3D vhost.o=
 vhost-backend.o vhost-vdpa.o
>   common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_K=
ERNEL))) +=3D vhost-stub.o
>   obj-$(CONFIG_VHOST_USER) +=3D vhost-user.o
>  =20
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 48905383f8..935cd9e561 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -286,6 +286,9 @@ int vhost_set_backend_type(struct vhost_dev *dev, Vho=
stBackendType backend_type)
>           dev->vhost_ops =3D &user_ops;
>           break;
>   #endif
> +    case VHOST_BACKEND_TYPE_VDPA:
> +        dev->vhost_ops =3D &vdpa_ops;
> +        break;
>       default:
>           error_report("Unknown vhost backend type");
>           r =3D -1;
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> new file mode 100644
> index 0000000000..213b327600
> --- /dev/null
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -0,0 +1,379 @@
> +/*
> + * vhost-vdpa
> + *
> + *  Copyright(c) 2017-2018 Intel Corporation. All rights reserved.
> + *  Copyright(c) 2020 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include <linux/vhost.h>
> +#include <linux/vfio.h>
> +#include <sys/eventfd.h>
> +#include <sys/ioctl.h>
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-backend.h"
> +#include "hw/virtio/virtio-net.h"
> +#include "hw/virtio/vhost-vdpa.h"
> +#include "qemu/main-loop.h"
> +#include <linux/kvm.h>
> +#include "sysemu/kvm.h"
> +
> +
> +static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *sec=
tion)
> +{
> +    return (!memory_region_is_ram(section->mr) &&
> +            !memory_region_is_iommu(section->mr)) ||
> +           /*
> +            * Sizing an enabled 64-bit BAR can cause spurious mappings t=
o
> +            * addresses in the upper part of the 64-bit address space.  =
These
> +            * are never accessed by the CPU and beyond the address width=
 of
> +            * some IOMMU hardware.  TODO: VDPA should tell us the IOMMU =
width.
> +            */
> +           section->offset_within_address_space & (1ULL << 63);
> +}
> +
> +static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr =
size,
> +                              void *vaddr, bool readonly)
> +{
> +    struct vhost_msg_v2 msg;
> +    int fd =3D v->device_fd;
> +    int ret =3D 0;
> +
> +    msg.type =3D VHOST_IOTLB_MSG_V2;


Since V2 of the message is used here, I believe we need a kernel patch=20
to allow the querying of backend capability.


> +    msg.iotlb.iova =3D iova;
> +    msg.iotlb.size =3D size;
> +    msg.iotlb.uaddr =3D (uint64_t)vaddr;
> +    msg.iotlb.perm =3D readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
> +    msg.iotlb.type =3D VHOST_IOTLB_UPDATE;
> +
> +    if (write(fd, &msg, sizeof(msg)) !=3D sizeof(msg)) {
> +        error_report("failed to write, fd=3D%d, errno=3D%d (%s)",
> +            fd, errno, strerror(errno));
> +        return -EIO ;
> +    }
> +
> +    return ret;
> +}
> +
> +static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
> +                                hwaddr size)
> +{
> +    struct vhost_msg_v2 msg;
> +    int fd =3D v->device_fd;
> +    int ret =3D 0;
> +
> +    msg.type =3D VHOST_IOTLB_MSG_V2;
> +    msg.iotlb.iova =3D iova;
> +    msg.iotlb.size =3D size;
> +    msg.iotlb.type =3D VHOST_IOTLB_INVALIDATE;
> +
> +    if (write(fd, &msg, sizeof(msg)) !=3D sizeof(msg)) {
> +        error_report("failed to write, fd=3D%d, errno=3D%d (%s)",
> +            fd, errno, strerror(errno));
> +        return -EIO ;
> +    }
> +
> +    return ret;
> +}
> +
> +static void vhost_vdpa_listener_region_add(MemoryListener *listener,
> +                                           MemoryRegionSection *section)
> +{
> +    struct vhost_vdpa *v =3D container_of(listener, struct vhost_vdpa, l=
istener);
> +    hwaddr iova;
> +    Int128 llend, llsize;
> +    void *vaddr;
> +    int ret;
> +
> +    if (vhost_vdpa_listener_skipped_section(section)) {
> +        return;
> +    }
> +
> +    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MA=
SK) !=3D
> +                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
> +        error_report("%s received unaligned region", __func__);
> +        return;
> +    }
> +
> +    iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +    llend =3D int128_make64(section->offset_within_address_space);
> +    llend =3D int128_add(llend, section->size);
> +    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> +
> +    if (int128_ge(int128_make64(iova), llend)) {
> +        return;
> +    }
> +
> +    memory_region_ref(section->mr);
> +
> +    /* Here we assume that memory_region_is_ram(section->mr)=3D=3Dtrue *=
/
> +
> +    vaddr =3D memory_region_get_ram_ptr(section->mr) +
> +            section->offset_within_region +
> +            (iova - section->offset_within_address_space);
> +
> +    llsize =3D int128_sub(llend, int128_make64(iova));
> +
> +    ret =3D vhost_vdpa_dma_map(v, iova, int128_get64(llsize),
> +                             vaddr, section->readonly);
> +    if (ret) {
> +        error_report("vhost vdpa map fail!");
> +        if (memory_region_is_ram_device(section->mr)) {
> +            /* Allow unexpected mappings not to be fatal for RAM devices=
 */
> +            error_report("map ram fail!");
> +          return ;
> +        }
> +        goto fail;
> +    }
> +
> +    return;
> +
> +fail:
> +    if (memory_region_is_ram_device(section->mr)) {
> +        error_report("failed to vdpa_dma_map. pci p2p may not work");
> +        return;
> +
> +    }
> +    /*
> +     * On the initfn path, store the first error in the container so we
> +     * can gracefully fail.  Runtime, there's not much we can do other
> +     * than throw a hardware error.
> +     */
> +    error_report("vhost-vdpa: DMA mapping failed, unable to continue");
> +    return;
> +
> +}
> +
> +static void vhost_vdpa_listener_region_del(MemoryListener *listener,
> +                                           MemoryRegionSection *section)
> +{
> +    struct vhost_vdpa *v =3D container_of(listener, struct vhost_vdpa, l=
istener);
> +    hwaddr iova;
> +    Int128 llend, llsize;
> +    int ret;
> +    bool try_unmap =3D true;
> +
> +    if (vhost_vdpa_listener_skipped_section(section)) {
> +        return;
> +    }
> +
> +    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MA=
SK) !=3D
> +                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
> +        error_report("%s received unaligned region", __func__);
> +        return;
> +    }
> +
> +    iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +    llend =3D int128_make64(section->offset_within_address_space);
> +    llend =3D int128_add(llend, section->size);
> +    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> +
> +    if (int128_ge(int128_make64(iova), llend)) {
> +        return;
> +    }
> +
> +    llsize =3D int128_sub(llend, int128_make64(iova));
> +
> +    if (try_unmap) {
> +        ret =3D vhost_vdpa_dma_unmap(v, iova, int128_get64(llsize));
> +        if (ret) {
> +            error_report("vhost_vdpa dma unmap error!");
> +        }
> +    }
> +
> +    memory_region_unref(section->mr);
> +}
> +


I think it's better to add comment to explain why vhost-vdpa use a=20
different listener other than the one used by other vhost backends (e.g=20
kernel or user).


> +static const MemoryListener vhost_vdpa_memory_listener =3D {
> +    .region_add =3D vhost_vdpa_listener_region_add,
> +    .region_del =3D vhost_vdpa_listener_region_del,
> +};
> +
> +
> +static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int requ=
est,
> +                             void *arg)
> +{
> +    struct vhost_vdpa *v =3D dev->opaque;
> +    int fd =3D v->device_fd;
> +
> +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA);
> +
> +    return ioctl(fd, request, arg);
> +}
> +
> +
> +
> +static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque)
> +{
> +    struct vhost_vdpa *v;
> +
> +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA);
> +
> +    v =3D opaque;
> +    dev->opaque =3D  opaque ;
> +
> +    v->listener =3D vhost_vdpa_memory_listener;
> +    memory_listener_register(&v->listener, &address_space_memory);
> +
> +    return 0;
> +}
> +
> +static int vhost_vdpa_cleanup(struct vhost_dev *dev)
> +{
> +    struct vhost_vdpa *v;
> +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA);
> +
> +    v =3D dev->opaque;
> +    memory_listener_unregister(&v->listener);
> +
> +    dev->opaque =3D NULL;
> +    return 0;
> +}
> +


A comment here is need to explain why INT_MAX is used.


> +static int vhost_vdpa_memslots_limit(struct vhost_dev *dev)
> +{
> +    return INT_MAX;
> +}
> +
> +static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
> +                                   struct vhost_log *log)
> +{
> +    return 0;
> +}


I think we should fail this function since we don't support dirty page=20
tracking now.

And it's not guarantee to use dirty page bitmap in the future.


> +
> +static int vhost_vdpa_set_mem_table(struct vhost_dev *dev,
> +                                    struct vhost_memory *mem)
> +{
> +
> +    if (mem->padding) {
> +        return -1;
> +    }
> +
> +    return 0;


A comment is need to explain why mem table is not used. (E.g we used=20
IOTLB API instead).


> +}
> +
> +static int vhost_vdpa_set_vring_addr(struct vhost_dev *dev,
> +                                     struct vhost_vring_addr *addr)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_VRING_ADDR, addr);
> +}
> +
> +static int vhost_vdpa_set_vring_num(struct vhost_dev *dev,
> +                                    struct vhost_vring_state *ring)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_VRING_NUM, ring);
> +}
> +
> +static int vhost_vdpa_set_vring_base(struct vhost_dev *dev,
> +                                     struct vhost_vring_state *ring)
> +{
> +    return vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring);
> +}
> +
> +static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
> +                                     struct vhost_vring_state *ring)
> +{
> +
> +    return vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring);
> +}
> +
> +static int vhost_vdpa_set_vring_kick(struct vhost_dev *dev,
> +                                     struct vhost_vring_file *file)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_VRING_KICK, file);
> +}
> +
> +static int vhost_vdpa_set_vring_call(struct vhost_dev *dev,
> +                                     struct vhost_vring_file *file)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_VRING_CALL, file);
> +}
> +
> +static int vhost_vdpa_set_features(struct vhost_dev *dev,
> +                                   uint64_t features)
> +{
> +
> +    features |=3D (1ULL << VIRTIO_F_IOMMU_PLATFORM);


This seems tricky, I don't think we need this actually.


> +    return vhost_vdpa_call(dev, VHOST_SET_FEATURES, &features);
> +
> +}
> +
> +static int vhost_vdpa_get_features(struct vhost_dev *dev,
> +                                   uint64_t *features)
> +{
> +    return vhost_vdpa_call(dev, VHOST_GET_FEATURES, features);
> +}
> +
> +static int vhost_vdpa_set_owner(struct vhost_dev *dev)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
> +}
> +
> +static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> +{
> +    return vhost_vdpa_call(dev, VHOST_RESET_OWNER, NULL);
> +}
> +
> +static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
> +{
> +    assert(idx >=3D dev->vq_index && idx < dev->vq_index + dev->nvqs);
> +
> +    return idx - dev->vq_index;
> +}
> +
> +static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable=
)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < dev->nvqs; ++i) {
> +        struct vhost_vring_state state =3D {
> +            .index =3D dev->vq_index + i,
> +            .num   =3D enable,
> +        };
> +
> +        state.num =3D 1;
> +
> +        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);


Please make sure patch 4 comes first then we don't need to fix this in=20
patch 4.


> +    }
> +
> +    return 0;
> +}
> +
> +static int vhost_vdpa_set_state(struct vhost_dev *dev, int state)
> +{
> +    return vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &state);
> +}
> +
> +
> +const VhostOps vdpa_ops =3D {
> +        .backend_type =3D VHOST_BACKEND_TYPE_VDPA,
> +        .vhost_backend_init =3D vhost_vdpa_init,
> +        .vhost_backend_cleanup =3D vhost_vdpa_cleanup,
> +        .vhost_backend_memslots_limit =3D vhost_vdpa_memslots_limit,
> +        .vhost_set_log_base =3D vhost_vdpa_set_log_base,
> +        .vhost_set_mem_table =3D vhost_vdpa_set_mem_table,
> +        .vhost_set_vring_addr =3D vhost_vdpa_set_vring_addr,
> +        .vhost_set_vring_endian =3D NULL,
> +        .vhost_set_vring_num =3D vhost_vdpa_set_vring_num,
> +        .vhost_set_vring_base =3D vhost_vdpa_set_vring_base,
> +        .vhost_get_vring_base =3D vhost_vdpa_get_vring_base,
> +        .vhost_set_vring_kick =3D vhost_vdpa_set_vring_kick,
> +        .vhost_set_vring_call =3D vhost_vdpa_set_vring_call,
> +        .vhost_set_features =3D vhost_vdpa_set_features,
> +        .vhost_get_features =3D vhost_vdpa_get_features,
> +        .vhost_set_owner =3D vhost_vdpa_set_owner,
> +        .vhost_reset_device =3D vhost_vdpa_reset_device,
> +        .vhost_get_vq_index =3D vhost_vdpa_get_vq_index,
> +        .vhost_set_vring_enable =3D vhost_vdpa_set_vring_enable,
> +        .vhost_requires_shm_log =3D NULL,
> +        .vhost_migration_done =3D NULL,
> +        .vhost_backend_can_merge =3D NULL,
> +        .vhost_net_set_mtu =3D NULL,
> +        .vhost_set_iotlb_callback =3D NULL,
> +        .vhost_send_device_iotlb_msg =3D NULL,
> +        .vhost_set_state =3D vhost_vdpa_set_state,
> +};
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 4da0d5a6c5..d1f2c4add7 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -746,6 +746,11 @@ static int vhost_virtqueue_set_addr(struct vhost_dev=
 *dev,
>           .log_guest_addr =3D vq->used_phys,
>           .flags =3D enable_log ? (1 << VHOST_VRING_F_LOG) : 0,
>       };
> +    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA) {
> +        addr.desc_user_addr =3D (uint64_t)(unsigned long)vq->desc_phys;
> +        addr.avail_user_addr =3D (uint64_t)(unsigned long)vq->avail_phys=
;
> +        addr.used_user_addr =3D (uint64_t)(unsigned long)vq->used_phys;
> +    }


Comment is needed to explain why vDPA differs from others.

Thanks


>       int r =3D dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
>       if (r < 0) {
>           VHOST_OPS_DEBUG("vhost_set_vring_addr failed");
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
> index 6f6670783f..d81bd9885f 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -17,7 +17,8 @@ typedef enum VhostBackendType {
>       VHOST_BACKEND_TYPE_NONE =3D 0,
>       VHOST_BACKEND_TYPE_KERNEL =3D 1,
>       VHOST_BACKEND_TYPE_USER =3D 2,
> -    VHOST_BACKEND_TYPE_MAX =3D 3,
> +    VHOST_BACKEND_TYPE_VDPA =3D 3,
> +    VHOST_BACKEND_TYPE_MAX =3D 4,
>   } VhostBackendType;
>  =20
>   typedef enum VhostSetConfigType {
> @@ -112,6 +113,7 @@ typedef int (*vhost_get_inflight_fd_op)(struct vhost_=
dev *dev,
>   typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
>                                           struct vhost_inflight *inflight=
);
>  =20
> +typedef int (*vhost_set_state_op)(struct vhost_dev *dev, int state);
>   typedef struct VhostOps {
>       VhostBackendType backend_type;
>       vhost_backend_init vhost_backend_init;
> @@ -152,9 +154,11 @@ typedef struct VhostOps {
>       vhost_backend_mem_section_filter_op vhost_backend_mem_section_filte=
r;
>       vhost_get_inflight_fd_op vhost_get_inflight_fd;
>       vhost_set_inflight_fd_op vhost_set_inflight_fd;
> +    vhost_set_state_op vhost_set_state;
>   } VhostOps;
>  =20
>   extern const VhostOps user_ops;
> +extern const VhostOps vdpa_ops;
>  =20
>   int vhost_set_backend_type(struct vhost_dev *dev,
>                              VhostBackendType backend_type);
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> new file mode 100644
> index 0000000000..889c1a4410
> --- /dev/null
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -0,0 +1,14 @@
> +
> +#ifndef HW_VIRTIO_VHOST_VDPA_H
> +#define HW_VIRTIO_VHOST_VDPA_H
> +
> +#include "hw/virtio/virtio.h"
> +
> +typedef struct vhost_vdpa {
> +    int device_fd;
> +    MemoryListener listener;
> +} VhostVDPA;
> +
> +extern AddressSpace address_space_memory;
> +
> +#endif


