Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210B6C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 08:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA5D2495A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 08:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3CsoZrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA5D2495A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXKeD-0000NW-1p
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 04:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXKdS-0007pq-1S
 for qemu-devel@nongnu.org; Sat, 09 May 2020 04:15:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54406
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXKdO-0003yC-Vd
 for qemu-devel@nongnu.org; Sat, 09 May 2020 04:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589012097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQ4EwCI8fPDdVfISBjRk0Rpt6XziNspQgitqRNDP0+8=;
 b=F3CsoZrKZc7vP++aQUHXawjYCUqQDsdxLIreal2PcPm+HnJXNbVvglLrBFVkoxdBTPk0x3
 mgm1m0eY5mU4+cV6zJ/QqOzXM9Rd4cnWIN0u5vIMTdX5dKjEn9pN92zT5n1++d8+QJFKsu
 cbDc0lfb/RoiNChlbj5FnL+iLAm98C8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-c1Uy7lafNJWTNUZn3mruMQ-1; Sat, 09 May 2020 04:14:55 -0400
X-MC-Unique: c1Uy7lafNJWTNUZn3mruMQ-1
Received: by mail-pg1-f200.google.com with SMTP id y4so3181044pgo.6
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 01:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sQ4EwCI8fPDdVfISBjRk0Rpt6XziNspQgitqRNDP0+8=;
 b=jTGGFCMh+VEJvkCWKmH11boE+umWNRjNWFUxyRg8mrSnkVEH1lj5sNHNCet8BT+x6Z
 9ZR2ZzP7dH/Fcs6bAjeqDZda9bg3m1p7vnCIQXWI/UeKPNKHZ7IA0sd7mP07TwTp6Ro4
 4xiPnFmB3q19curzfWeM2Ew53BxaJulf0A9CZMJZ09wBbPs9uuT5bda6EgBGbF8NyUmz
 /l4KgB3bQZx5tWt35Pa16e8nDl2wSCSsUiVfR/dES4tMpty28FbQxS/3+oDGkcJQdh+X
 4sRiv1khh86briqvTss1xrITyQF9JQF/2pk7KI5Wmy+npAV+lMa+ZWB9dxTbAkmYnRVv
 ldMA==
X-Gm-Message-State: AGi0PuZ9gdxB3SJ4h3RaHcpoM9KJyDc6bddv6oZA0ZGIwjsSGKgNIzPr
 eQSPhMRArfEzHqNk3IMQa8/IGW3rznDW3yRM3j472uT3oVQgP5heLq/6af+xf4Epm6GZG2wnhQT
 qdT4n3qhJgWiOxm95S8qXqeLfkVaMDZ8=
X-Received: by 2002:a17:90a:cb86:: with SMTP id
 a6mr10522247pju.127.1589012094275; 
 Sat, 09 May 2020 01:14:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJzQ6tfADFmOYHMQoUR4dVDrkVzeGdbqRCbzJW/wmvLYE+mGWiGaL8GP4OQZLlO/2cBm4hzhmh9AIyqm+N/auA=
X-Received: by 2002:a17:90a:cb86:: with SMTP id
 a6mr10522187pju.127.1589012093665; 
 Sat, 09 May 2020 01:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-6-lulu@redhat.com>
 <ecabe04f-e9d6-97a5-638d-c204eddb7137@redhat.com>
In-Reply-To: <ecabe04f-e9d6-97a5-638d-c204eddb7137@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sat, 9 May 2020 16:14:42 +0800
Message-ID: <CACLfguWGnzZEvvhcnMcj2cv1cq2SzVo+L6nnR1RTG6yuavtdaQ@mail.gmail.com>
Subject: Re: [RFC v2 5/9] vhost-vdpa: implement vhost-vdpa backend
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 02:50:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Cornelia Huck <cohuck@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, hanand@xilinx.com,
 rob.miller@broadcom.com, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, rdunlap@infradead.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 9, 2020 at 11:00 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/5/9 =E4=B8=8A=E5=8D=8812:32, Cindy Lu wrote:
> > From: Tiwei Bie <tiwei.bie@intel.com>
> >
> > Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> > vhost-user. The above patch provides a generic device for vDPA purpose,
> > this vDPA device exposes to user space a non-vendor-specific configurat=
ion
> > interface for setting up a vhost HW accelerator, this patch set introdu=
ces
> > a third vhost backend called vhost-vdpa based on the vDPA interface.
> >
> > Vhost-vdpa usage:
> >
> >    qemu-system-x86_64 -cpu host -enable-kvm \
> >      ......
> >    -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-id,id=3Dvhost-v=
dpa0 \
> >    -device virtio-net-pci,netdev=3Dvhost-vdpa0,page-per-vq=3Don \
> >
> > Co-Authored-By: Lingshan zhu <lingshan.zhu@intel.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> > ---
> >   hw/net/vhost_net.c                |  39 ++-
> >   hw/virtio/Makefile.objs           |   1 +
> >   hw/virtio/vhost-backend.c         |   5 +
> >   hw/virtio/vhost-vdpa.c            | 447 +++++++++++++++++++++++++++++=
+
> >   hw/virtio/vhost.c                 |  14 +
> >   include/hw/virtio/vhost-backend.h |   8 +-
> >   include/hw/virtio/vhost-vdpa.h    |  25 ++
> >   include/hw/virtio/vhost.h         |   1 +
> >   8 files changed, 538 insertions(+), 2 deletions(-)
> >   create mode 100644 hw/virtio/vhost-vdpa.c
> >   create mode 100644 include/hw/virtio/vhost-vdpa.h
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 63b2a85d6e..1af39abaf3 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -17,8 +17,10 @@
> >   #include "net/net.h"
> >   #include "net/tap.h"
> >   #include "net/vhost-user.h"
> > +#include "net/vhost-vdpa.h"
> >
> >   #include "standard-headers/linux/vhost_types.h"
> > +#include "linux-headers/linux/vhost.h"
> >   #include "hw/virtio/virtio-net.h"
> >   #include "net/vhost_net.h"
> >   #include "qemu/error-report.h"
> > @@ -85,6 +87,29 @@ static const int user_feature_bits[] =3D {
> >       VHOST_INVALID_FEATURE_BIT
> >   };
> >
> > +static const int vdpa_feature_bits[] =3D {
> > +    VIRTIO_F_NOTIFY_ON_EMPTY,
> > +    VIRTIO_RING_F_INDIRECT_DESC,
> > +    VIRTIO_RING_F_EVENT_IDX,
> > +    VIRTIO_F_ANY_LAYOUT,
> > +    VIRTIO_F_VERSION_1,
> > +    VIRTIO_NET_F_CSUM,
> > +    VIRTIO_NET_F_GUEST_CSUM,
> > +    VIRTIO_NET_F_GSO,
> > +    VIRTIO_NET_F_GUEST_TSO4,
> > +    VIRTIO_NET_F_GUEST_TSO6,
> > +    VIRTIO_NET_F_GUEST_ECN,
> > +    VIRTIO_NET_F_GUEST_UFO,
> > +    VIRTIO_NET_F_HOST_TSO4,
> > +    VIRTIO_NET_F_HOST_TSO6,
> > +    VIRTIO_NET_F_HOST_ECN,
> > +    VIRTIO_NET_F_HOST_UFO,
> > +    VIRTIO_NET_F_MRG_RXBUF,
> > +    VIRTIO_NET_F_MTU,
> > +    VIRTIO_F_IOMMU_PLATFORM,
> > +    VIRTIO_NET_F_GUEST_ANNOUNCE,
> > +    VHOST_INVALID_FEATURE_BIT
> > +};
>
>
> The framework should be ready for packed ring, let's add that.
>
Will fix this
>
> >   static const int *vhost_net_get_feature_bits(struct vhost_net *net)
> >   {
> >       const int *feature_bits =3D 0;
> > @@ -96,6 +121,9 @@ static const int *vhost_net_get_feature_bits(struct =
vhost_net *net)
> >       case NET_CLIENT_DRIVER_VHOST_USER:
> >           feature_bits =3D user_feature_bits;
> >           break;
> > +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> > +        feature_bits =3D vdpa_feature_bits;
> > +        break;
> >       default:
> >           error_report("Feature bits not defined for this type: %d",
> >                   net->nc->info->type);
> > @@ -110,7 +138,10 @@ uint64_t vhost_net_get_features(struct vhost_net *=
net, uint64_t features)
> >       return vhost_get_features(&net->dev, vhost_net_get_feature_bits(n=
et),
> >               features);
> >   }
> > -
> > +int vhost_net_get_device_id(struct vhost_net *net, uint32_t * device_i=
d)
> > +{
> > +    return vhost_dev_get_device_id(&net->dev, device_id);
> > +}
> >   void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
> >   {
> >       net->dev.acked_features =3D net->dev.backend_features;
> > @@ -433,6 +464,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
> >           vhost_net =3D vhost_user_get_vhost_net(nc);
> >           assert(vhost_net);
> >           break;
> > +#endif
> > +#ifdef CONFIG_VHOST_NET_VDPA
> > +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> > +        vhost_net =3D vhost_vdpa_get_vhost_net(nc);
> > +        assert(vhost_net);
> > +        break;
> >   #endif
> >       default:
> >           break;
> > diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> > index e2f70fbb89..e7c5d4a862 100644
> > --- a/hw/virtio/Makefile.objs
> > +++ b/hw/virtio/Makefile.objs
> > @@ -5,6 +5,7 @@ obj-y +=3D virtio.o
> >   obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) +=3D vhos=
t.o vhost-backend.o
> >   common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST=
_KERNEL))) +=3D vhost-stub.o
> >   obj-$(CONFIG_VHOST_USER) +=3D vhost-user.o
> > +obj-$(CONFIG_VHOST_VDPA) +=3D vhost-vdpa.o
> >
> >   common-obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng.o
> >   common-obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-pci.o
> > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > index 48905383f8..069ddb423d 100644
> > --- a/hw/virtio/vhost-backend.c
> > +++ b/hw/virtio/vhost-backend.c
> > @@ -285,6 +285,11 @@ int vhost_set_backend_type(struct vhost_dev *dev, =
VhostBackendType backend_type)
> >       case VHOST_BACKEND_TYPE_USER:
> >           dev->vhost_ops =3D &user_ops;
> >           break;
> > +#endif
> > +#ifdef CONFIG_VHOST_VDPA
> > +    case VHOST_BACKEND_TYPE_VDPA:
> > +        dev->vhost_ops =3D &vdpa_ops;
> > +        break;
> >   #endif
> >       default:
> >           error_report("Unknown vhost backend type");
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > new file mode 100644
> > index 0000000000..bac8a8aa2a
> > --- /dev/null
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -0,0 +1,447 @@
> > +/*
> > + * vhost-vdpa
> > + *
> > + *  Copyright(c) 2017-2018 Intel Corporation.
> > + *  Copyright(c) 2020 Red Hat, Inc.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include <linux/vhost.h>
> > +#include <linux/vfio.h>
> > +#include <sys/eventfd.h>
> > +#include <sys/ioctl.h>
> > +#include "hw/virtio/vhost.h"
> > +#include "hw/virtio/vhost-backend.h"
> > +#include "hw/virtio/virtio-net.h"
> > +#include "hw/virtio/vhost-vdpa.h"
> > +#include "qemu/main-loop.h"
> > +#include <linux/kvm.h>
> > +#include "sysemu/kvm.h"
> > +
> > +
> > +static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *s=
ection)
> > +{
> > +    return (!memory_region_is_ram(section->mr) &&
> > +            !memory_region_is_iommu(section->mr)) ||
> > +           /*
> > +            * Sizing an enabled 64-bit BAR can cause spurious mappings=
 to
> > +            * addresses in the upper part of the 64-bit address space.=
  These
> > +            * are never accessed by the CPU and beyond the address wid=
th of
> > +            * some IOMMU hardware.  TODO: VDPA should tell us the IOMM=
U width.
> > +            */
> > +           section->offset_within_address_space & (1ULL << 63);
> > +}
> > +
> > +static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwadd=
r size,
> > +                              void *vaddr, bool readonly)
> > +{
> > +    struct vhost_msg_v2 msg;
> > +    int fd =3D v->device_fd;
> > +    int ret =3D 0;
> > +
> > +    msg.type =3D  v->msg_type;
> > +    msg.iotlb.iova =3D iova;
> > +    msg.iotlb.size =3D size;
> > +    msg.iotlb.uaddr =3D (uint64_t)vaddr;
> > +    msg.iotlb.perm =3D readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
> > +    msg.iotlb.type =3D VHOST_IOTLB_UPDATE;
> > +
> > +    if (write(fd, &msg, sizeof(msg)) !=3D sizeof(msg)) {
> > +        error_report("failed to write, fd=3D%d, errno=3D%d (%s)",
> > +            fd, errno, strerror(errno));
> > +        return -EIO ;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
> > +                                hwaddr size)
> > +{
> > +    struct vhost_msg_v2 msg;
> > +    int fd =3D v->device_fd;
> > +    int ret =3D 0;
> > +
> > +    msg.type =3D  v->msg_type;
> > +    msg.iotlb.iova =3D iova;
> > +    msg.iotlb.size =3D size;
> > +    msg.iotlb.type =3D VHOST_IOTLB_INVALIDATE;
> > +
> > +    if (write(fd, &msg, sizeof(msg)) !=3D sizeof(msg)) {
> > +        error_report("failed to write, fd=3D%d, errno=3D%d (%s)",
> > +            fd, errno, strerror(errno));
> > +        return -EIO ;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +static void vhost_vdpa_listener_region_add(MemoryListener *listener,
> > +                                           MemoryRegionSection *sectio=
n)
> > +{
> > +    struct vhost_vdpa *v =3D container_of(listener, struct vhost_vdpa,=
 listener);
> > +    hwaddr iova;
> > +    Int128 llend, llsize;
> > +    void *vaddr;
> > +    int ret;
> > +
> > +    if (vhost_vdpa_listener_skipped_section(section)) {
> > +        return;
> > +    }
> > +
> > +    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_=
MASK) !=3D
> > +                 (section->offset_within_region & ~TARGET_PAGE_MASK)))=
 {
> > +        error_report("%s received unaligned region", __func__);
> > +        return;
> > +    }
> > +
> > +    iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
> > +    llend =3D int128_make64(section->offset_within_address_space);
> > +    llend =3D int128_add(llend, section->size);
> > +    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> > +
> > +    if (int128_ge(int128_make64(iova), llend)) {
> > +        return;
> > +    }
> > +
> > +    memory_region_ref(section->mr);
> > +
> > +    /* Here we assume that memory_region_is_ram(section->mr)=3D=3Dtrue=
 */
> > +
> > +    vaddr =3D memory_region_get_ram_ptr(section->mr) +
> > +            section->offset_within_region +
> > +            (iova - section->offset_within_address_space);
> > +
> > +    llsize =3D int128_sub(llend, int128_make64(iova));
> > +
> > +    ret =3D vhost_vdpa_dma_map(v, iova, int128_get64(llsize),
> > +                             vaddr, section->readonly);
> > +    if (ret) {
> > +        error_report("vhost vdpa map fail!");
> > +        if (memory_region_is_ram_device(section->mr)) {
> > +            /* Allow unexpected mappings not to be fatal for RAM devic=
es */
> > +            error_report("map ram fail!");
> > +          return ;
> > +        }
> > +        goto fail;
> > +    }
> > +
> > +    return;
> > +
> > +fail:
> > +    if (memory_region_is_ram_device(section->mr)) {
> > +        error_report("failed to vdpa_dma_map. pci p2p may not work");
> > +        return;
> > +
> > +    }
> > +    /*
> > +     * On the initfn path, store the first error in the container so w=
e
> > +     * can gracefully fail.  Runtime, there's not much we can do other
> > +     * than throw a hardware error.
> > +     */
> > +    error_report("vhost-vdpa: DMA mapping failed, unable to continue")=
;
> > +    return;
> > +
> > +}
> > +
> > +static void vhost_vdpa_listener_region_del(MemoryListener *listener,
> > +                                           MemoryRegionSection *sectio=
n)
> > +{
> > +    struct vhost_vdpa *v =3D container_of(listener, struct vhost_vdpa,=
 listener);
> > +    hwaddr iova;
> > +    Int128 llend, llsize;
> > +    int ret;
> > +    bool try_unmap =3D true;
> > +
> > +    if (vhost_vdpa_listener_skipped_section(section)) {
> > +        return;
> > +    }
> > +
> > +    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_=
MASK) !=3D
> > +                 (section->offset_within_region & ~TARGET_PAGE_MASK)))=
 {
> > +        error_report("%s received unaligned region", __func__);
> > +        return;
> > +    }
> > +
> > +    iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
> > +    llend =3D int128_make64(section->offset_within_address_space);
> > +    llend =3D int128_add(llend, section->size);
> > +    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> > +
> > +    if (int128_ge(int128_make64(iova), llend)) {
> > +        return;
> > +    }
> > +
> > +    llsize =3D int128_sub(llend, int128_make64(iova));
> > +
> > +    if (try_unmap) {
> > +        ret =3D vhost_vdpa_dma_unmap(v, iova, int128_get64(llsize));
> > +        if (ret) {
> > +            error_report("vhost_vdpa dma unmap error!");
> > +        }
> > +    }
> > +
> > +    memory_region_unref(section->mr);
> > +}
> > +
> > +static const MemoryListener vhost_vdpa_memory_listener =3D {
> > +    .region_add =3D vhost_vdpa_listener_region_add,
> > +    .region_del =3D vhost_vdpa_listener_region_del,
> > +};
> > +
>
>
> Need comment to explain why vhost-vdpa requires a specific memory
> listener other than just reusing the one that is provided by vhost.
>
>
will fix this
> > +
>
>
> This newline is unnecessary.
>
will fix this
>
> > +static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int re=
quest,
> > +                             void *arg)
> > +{
> > +    struct vhost_vdpa *v =3D dev->opaque;
> > +    int fd =3D v->device_fd;
> > +
> > +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA=
);
> > +
> > +    return ioctl(fd, request, arg);
> > +}
> > +
> > +static int vhost_vdpa_get_backend_features(struct vhost_dev *dev,
> > +                                   uint64_t *features)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, features);
> > +}
> > +
> > +static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque)
> > +{
> > +    struct vhost_vdpa *v;
> > +    uint64_t backend_features =3D 0;
> > +    int ret =3D 0;
> > +
> > +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA=
);
> > +
> > +    v =3D opaque;
> > +    dev->opaque =3D  opaque ;
> > +
> > +    v->listener =3D vhost_vdpa_memory_listener;
> > +    memory_listener_register(&v->listener, &address_space_memory);
> > +
> > +    ret =3D vhost_vdpa_get_backend_features(dev, &backend_features);
> > +   /*
> > +    * In order to compatible with older version kernel,
> > +    * If the kernel not support this ioctl,
> > +    * set the msg_type for v2 by default
> > +    */
> > +    if (ret) {
> > +        v->msg_type =3D VHOST_IOTLB_MSG_V2;
> > +        return 0;
> > +     }
> > +    if (backend_features &  (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)) {
> > +        v->msg_type =3D VHOST_IOTLB_MSG_V2;
> > +     } else {
> > +        v->msg_type =3D VHOST_IOTLB_MSG;
> > +     }
>
>
> But in vhost_vdpa_dma_unmap/vhost_vdpa_dma_map, v2 is still being used.
>
> Consider vdpa implies msg_v2, and it doesn't implement
> get_backend_features. We use v2 unconditionally and leave this check in
> the future.
>
>
will fix this
> > +    return 0;
> > +}
> > +
> > +static int vhost_vdpa_cleanup(struct vhost_dev *dev)
> > +{
> > +    struct vhost_vdpa *v;
> > +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA=
);
> > +
> > +    v =3D dev->opaque;
> > +    memory_listener_unregister(&v->listener);
> > +
> > +    dev->opaque =3D NULL;
> > +    return 0;
> > +}
> > +
> > +static int vhost_vdpa_memslots_limit(struct vhost_dev *dev)
> > +{
> > +    /*Using IOTLB API here,NOTE:please set the ulimit before using*/
>
>
> The "note" seems unrelated to the memslot here.
>
>
> > +    return INT_MAX;
> > +}
> > +
> > +static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t bas=
e,
> > +                                   struct vhost_log *log)
> > +{
> > +    return -1;
> > +}
> > +
> > +static int vhost_vdpa_set_mem_table(struct vhost_dev *dev,
> > +                                    struct vhost_memory *mem)
> > +{
> > +
> > +    if (mem->padding) {
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int vhost_vdpa_set_vring_addr(struct vhost_dev *dev,
> > +                                     struct vhost_vring_addr *addr)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_VRING_ADDR, addr);
> > +}
> > +
> > +static int vhost_vdpa_set_vring_num(struct vhost_dev *dev,
> > +                                    struct vhost_vring_state *ring)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_VRING_NUM, ring);
> > +}
> > +
> > +static int vhost_vdpa_set_vring_base(struct vhost_dev *dev,
> > +                                     struct vhost_vring_state *ring)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring);
> > +}
> > +
> > +static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
> > +                                     struct vhost_vring_state *ring)
> > +{
> > +
> > +    return vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring);
> > +}
> > +
> > +static int vhost_vdpa_set_vring_kick(struct vhost_dev *dev,
> > +                                     struct vhost_vring_file *file)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_VRING_KICK, file);
> > +}
> > +
> > +static int vhost_vdpa_set_vring_call(struct vhost_dev *dev,
> > +                                     struct vhost_vring_file *file)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_VRING_CALL, file);
> > +}
> > +
> > +static int vhost_vdpa_set_features(struct vhost_dev *dev,
> > +                                   uint64_t features)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_FEATURES, &features);
> > +}
> > +
> > +static int vhost_vdpa_get_features(struct vhost_dev *dev,
> > +                                   uint64_t *features)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_GET_FEATURES, features);
> > +}
> > +
> > +static int vhost_vdpa_get_device_id(struct vhost_dev *dev,
> > +                                   uint32_t *device_id)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_VDPA_GET_DEVICE_ID, device_id);
> > +}
> > +
> > +static int vhost_vdpa_set_owner(struct vhost_dev *dev)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
> > +}
> > +
> > +static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_RESET_OWNER, NULL);
> > +}
>
>
> I think we may want to reuse the helpers of kenrel backends instead of
> duplicating functions here.
>
will fix this
>
> > +
> > +static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
> > +{
> > +    assert(idx >=3D dev->vq_index && idx < dev->vq_index + dev->nvqs);
> > +
> > +    return idx - dev->vq_index;
> > +}
> > +
> > +static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
> > +{
> > +    int i;
> > +    for (i =3D 0; i < dev->nvqs; ++i) {
> > +        struct vhost_vring_state state =3D {
> > +            .index =3D dev->vq_index + i,
> > +            .num =3D 1,
> > +        };
> > +        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> > +    }
> > +    return 0;
> > +}
> > +static int  vhost_vdpa_set_config(struct vhost_dev *dev, const uint8_t=
 *data,
>
>
> One unnecessary space between int and "vhost_vdpa_set_config"
>
will fix this
>
> > +                                   uint32_t offset, uint32_t size,
> > +                                   uint32_t flags)
> > +{
> > +
> > +    struct vhost_vdpa_config *config;
> > +    int ret;
> > +    if ((size > VHOST_VDPA_MAX_CONFIG_SIZE) || (data =3D=3D NULL)) {
> > +        return -1;
> > +    }
> > +    config =3D g_new0(struct vhost_vdpa_config, 1);
>
>
> It's better to just use a temporary variable instead of allocate it
> dynamically?
>
sure, will fix this
>
> > +    if (config =3D=3D NULL) {
> > +        return -EINVAL;
> > +    }
> > +    config->off =3D 0;
> > +    config->len =3D size;
> > +    memcpy(config->buf, data, size);
> > +    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_CONFIG, config);
> > +     g_free(config);
> > +     return ret;
> > +}
> > +
> > + static int  vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *con=
fig,
> > +                                   uint32_t config_len)
> > +{
> > +    struct vhost_vdpa_config *v_config =3D NULL;
> > +    int ret;
> > +
> > +     if ((config_len > VHOST_VDPA_MAX_CONFIG_SIZE) || (config =3D=3D N=
ULL)) {
> > +        return -1;
> > +    }
> > +    v_config =3D g_new0(struct vhost_vdpa_config, 1);
>
>
> Let's use a variable on the stack.
>
will fix this
>
> > +
> > +    if (v_config =3D=3D NULL) {
> > +        return -EINVAL;
> > +    }
> > +   ret =3D  vhost_vdpa_call(dev, VHOST_VDPA_GET_CONFIG, v_config);
>
>
> One extra space after '=3D'.
>
>
> > +   if ((v_config->len > config_len - v_config->off) || (v_config->len =
=3D=3D 0)) {
> > +        g_free(v_config);
> > +       return -EINVAL;
> > +    }
>
>
> Indentation is wired and why need such check?
>
>
> > +
> > +    memcpy(config, v_config->buf + v_config->off, config_len);
> > +    g_free(v_config);
> > +    return ret;
> > + }
>
>
> Newline is needed here.
>
>
> > +static int vhost_vdpa_set_state(struct vhost_dev *dev, uint8_t state)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &state);
> > +}
> > +
> > +
>
>
> This new line is not needed.
>
Will fix these all
>
> > +const VhostOps vdpa_ops =3D {
> > +        .backend_type =3D VHOST_BACKEND_TYPE_VDPA,
> > +        .vhost_backend_init =3D vhost_vdpa_init,
> > +        .vhost_backend_cleanup =3D vhost_vdpa_cleanup,
> > +        .vhost_backend_memslots_limit =3D vhost_vdpa_memslots_limit,
> > +        .vhost_set_log_base =3D vhost_vdpa_set_log_base,
> > +        .vhost_set_mem_table =3D vhost_vdpa_set_mem_table,
> > +        .vhost_set_vring_addr =3D vhost_vdpa_set_vring_addr,
> > +        .vhost_set_vring_endian =3D NULL,
> > +        .vhost_set_vring_num =3D vhost_vdpa_set_vring_num,
> > +        .vhost_set_vring_base =3D vhost_vdpa_set_vring_base,
> > +        .vhost_get_vring_base =3D vhost_vdpa_get_vring_base,
> > +        .vhost_set_vring_kick =3D vhost_vdpa_set_vring_kick,
> > +        .vhost_set_vring_call =3D vhost_vdpa_set_vring_call,
> > +        .vhost_set_features =3D vhost_vdpa_set_features,
> > +        .vhost_get_features =3D vhost_vdpa_get_features,
> > +        .vhost_set_owner =3D vhost_vdpa_set_owner,
> > +        .vhost_reset_device =3D vhost_vdpa_reset_device,
> > +        .vhost_get_vq_index =3D vhost_vdpa_get_vq_index,
> > +        .vhost_set_vring_ready =3D vhost_vdpa_set_vring_ready,
> > +        .vhost_get_config  =3D vhost_vdpa_get_config,
> > +        .vhost_set_config =3D vhost_vdpa_set_config,
> > +        .vhost_requires_shm_log =3D NULL,
> > +        .vhost_migration_done =3D NULL,
> > +        .vhost_backend_can_merge =3D NULL,
> > +        .vhost_net_set_mtu =3D NULL,
> > +        .vhost_set_iotlb_callback =3D NULL,
> > +        .vhost_send_device_iotlb_msg =3D NULL,
> > +        .vhost_set_state =3D vhost_vdpa_set_state,
> > +        .vhost_get_device_id =3D vhost_vdpa_get_device_id,
> > +};
>
>
> As said previously, need to consider to reuse vhost kernel helpers.
>
I will double check this
>
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 4da0d5a6c5..6d2aa461d6 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -746,6 +746,12 @@ static int vhost_virtqueue_set_addr(struct vhost_d=
ev *dev,
> >           .log_guest_addr =3D vq->used_phys,
> >           .flags =3D enable_log ? (1 << VHOST_VRING_F_LOG) : 0,
> >       };
> > +    /*vDPA need to use the phys address here to set to hardware*/
> > +    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA) {
> > +        addr.desc_user_addr =3D (uint64_t)(unsigned long)vq->desc_phys=
;
> > +        addr.avail_user_addr =3D (uint64_t)(unsigned long)vq->avail_ph=
ys;
> > +        addr.used_user_addr =3D (uint64_t)(unsigned long)vq->used_phys=
;
> > +    }
> >       int r =3D dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
> >       if (r < 0) {
> >           VHOST_OPS_DEBUG("vhost_set_vring_addr failed");
> > @@ -1493,6 +1499,14 @@ int vhost_dev_set_config(struct vhost_dev *hdev,=
 const uint8_t *data,
> >       return -1;
> >   }
> >
> > +int vhost_dev_get_device_id(struct vhost_dev *hdev, uint32_t *device_i=
d)
> > +{
> > +    assert(hdev->vhost_ops);
> > +    if (hdev->vhost_ops->vhost_get_device_id) {
>
>
> If you introduce a new vhost_ops, please use a separate patch.
>
>
> > +        return hdev->vhost_ops->vhost_get_device_id(hdev, device_id);
> > +    }
> > +    return -1;
> > +}
> >   void vhost_dev_set_config_notifier(struct vhost_dev *hdev,
> >                                      const VhostDevConfigOps *ops)
> >   {
> > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhos=
t-backend.h
> > index f823055167..8ac898a987 100644
> > --- a/include/hw/virtio/vhost-backend.h
> > +++ b/include/hw/virtio/vhost-backend.h
> > @@ -17,7 +17,8 @@ typedef enum VhostBackendType {
> >       VHOST_BACKEND_TYPE_NONE =3D 0,
> >       VHOST_BACKEND_TYPE_KERNEL =3D 1,
> >       VHOST_BACKEND_TYPE_USER =3D 2,
> > -    VHOST_BACKEND_TYPE_MAX =3D 3,
> > +    VHOST_BACKEND_TYPE_VDPA =3D 3,
> > +    VHOST_BACKEND_TYPE_MAX =3D 4,
> >   } VhostBackendType;
> >
> >   typedef enum VhostSetConfigType {
> > @@ -77,6 +78,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev=
 *dev);
> >   typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
> >   typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
> >                                            int enable);
> > +typedef int (*vhost_set_vring_ready_op)(struct vhost_dev *dev);
>
>
> A new patch for this patch.
>
> Thanks
>
Sure, Will fix this
>
> >   typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
> >   typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
> >                                          char *mac_addr);
> > @@ -113,6 +115,7 @@ typedef int (*vhost_set_inflight_fd_op)(struct vhos=
t_dev *dev,
> >                                           struct vhost_inflight *inflig=
ht);
> >
> >   typedef int (*vhost_set_state_op)(struct vhost_dev *dev, uint8_t stat=
e);
> > +typedef int (*vhost_get_device_id_op)(struct vhost_dev *dev, uint32_t =
*dev_id);
> >   typedef struct VhostOps {
> >       VhostBackendType backend_type;
> >       vhost_backend_init vhost_backend_init;
> > @@ -139,6 +142,7 @@ typedef struct VhostOps {
> >       vhost_reset_device_op vhost_reset_device;
> >       vhost_get_vq_index_op vhost_get_vq_index;
> >       vhost_set_vring_enable_op vhost_set_vring_enable;
> > +    vhost_set_vring_ready_op vhost_set_vring_ready;
> >       vhost_requires_shm_log_op vhost_requires_shm_log;
> >       vhost_migration_done_op vhost_migration_done;
> >       vhost_backend_can_merge_op vhost_backend_can_merge;
> > @@ -154,9 +158,11 @@ typedef struct VhostOps {
> >       vhost_get_inflight_fd_op vhost_get_inflight_fd;
> >       vhost_set_inflight_fd_op vhost_set_inflight_fd;
> >       vhost_set_state_op vhost_set_state;
> > +    vhost_get_device_id_op vhost_get_device_id;
> >   } VhostOps;
> >
> >   extern const VhostOps user_ops;
> > +extern const VhostOps vdpa_ops;
> >
> >   int vhost_set_backend_type(struct vhost_dev *dev,
> >                              VhostBackendType backend_type);
> > diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-v=
dpa.h
> > new file mode 100644
> > index 0000000000..9d64fbfea9
> > --- /dev/null
> > +++ b/include/hw/virtio/vhost-vdpa.h
> > @@ -0,0 +1,25 @@
> > +/*
> > + * vhost-vdpa.h
> > + *
> > + * Copyright(c) 2017-2018 Intel Corporation.
> > + * Copyright(c) 2020 Red Hat, Inc.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef HW_VIRTIO_VHOST_VDPA_H
> > +#define HW_VIRTIO_VHOST_VDPA_H
> > +
> > +#include "hw/virtio/virtio.h"
> > +
> > +typedef struct vhost_vdpa {
> > +    int device_fd;
> > +    uint32_t msg_type;
> > +    MemoryListener listener;
> > +} VhostVDPA;
> > +
> > +extern AddressSpace address_space_memory;
> > +
> > +#endif
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 085450c6f8..020956d5a9 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -124,6 +124,7 @@ int vhost_dev_get_config(struct vhost_dev *dev, uin=
t8_t *config,
> >                            uint32_t config_len);
> >   int vhost_dev_set_config(struct vhost_dev *dev, const uint8_t *data,
> >                            uint32_t offset, uint32_t size, uint32_t fla=
gs);
> > +int vhost_dev_get_device_id(struct vhost_dev *hdev, uint32_t *device_i=
d);
> >   /* notifier callback in case vhost device config space changed
> >    */
> >   void vhost_dev_set_config_notifier(struct vhost_dev *dev,
>


