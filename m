Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6EEC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5304B20857
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NG6K6tyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5304B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQoyw-0008Eb-DY
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQoxk-0007N4-GH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQoxh-0007MP-Bn
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:13:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27823
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jQoxg-0007Je-R5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587460377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bcUaMrkFXOhIm8u8h3smOV9s9F5qw+97JNum32X7vvs=;
 b=NG6K6tyiipzATZcNs8kfdSuPQoA2VFYDKMnnXhFj3lg9hL39czLrI7wflkHWHdD0ujgmjX
 sGyDIzPH/WZACMVvF8elZZ5T+SaHxKAsDpKWSl4qOW1FsJH6WB+P0/ens2MX/2SE9cUCmf
 mbynvUcV/wavsXjvXhI6AGz21sg6QLk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-fAbRuYPdM_WS2LEJQKxyPw-1; Tue, 21 Apr 2020 05:12:53 -0400
X-MC-Unique: fAbRuYPdM_WS2LEJQKxyPw-1
Received: by mail-pl1-f199.google.com with SMTP id c13so10971512plq.22
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 02:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bcUaMrkFXOhIm8u8h3smOV9s9F5qw+97JNum32X7vvs=;
 b=GtzwsLfcR5qL9P3Y+kEc8xO1fOxwvVgnbCU51SbUKNjv2NEndItsapifJQCy6mxsZv
 RdIoYYdBZIfEBEUO/sChnVEpgfFGX7Px2CuFg6NqtIxflBBE0rxR4+4nIGJz6kgFsOeF
 R1bzmnF6sABQ1CRH2lGMtsgszvc/TkOSt7qC6a/VKOE8uwSLnQBdYYRIYCeiR6u6wt5F
 zyCSrolCEXt9Grfp46Vz/JEb8uEgJn8yrOhiCtSTwLBB/7pTS0lsBywHXvklLOrlBBOw
 hT+uxFlw5aiz0OUV+ZmfLtoG2nPK+UkgF2FRfGxOGk9EijIyie0qo/Qm+YTv28iEY7lV
 eZQw==
X-Gm-Message-State: AGi0PuZCYAk1Vb59u3+Hz9XRMq+yti9zTAv9zNAjtSvoB0JjH5srznIa
 tNq/CfDCBSjlCqVRITMsdrkhFKZRC4Xa3xx1x+qYMMwNI9kAPiMW+hKCdkNF2ZUsApjHeKc0Cem
 SL/qsdoSWIRfOdEASFwr6mR7mSTSF4/o=
X-Received: by 2002:a17:90a:8994:: with SMTP id
 v20mr4518484pjn.76.1587460372527; 
 Tue, 21 Apr 2020 02:12:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypLheXJMbdfQhSe2/zU5jaepVtfMeeV+wTtCoSYT0Qui/DzTUBlW6MbXb0wdvhu9k69lSb/pq0UtVahs+/C1XDY=
X-Received: by 2002:a17:90a:8994:: with SMTP id
 v20mr4518441pjn.76.1587460372118; 
 Tue, 21 Apr 2020 02:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-4-lulu@redhat.com>
 <a6310935-83e3-903b-9221-c6ead28dffac@redhat.com>
In-Reply-To: <a6310935-83e3-903b-9221-c6ead28dffac@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 21 Apr 2020 17:12:41 +0800
Message-ID: <CACLfguX+SB0eQfrv0DwEnNpnX3LjPH+vdt_QHe+dwQGunDtiRA@mail.gmail.com>
Subject: Re: [RFC v1 3/4] vhost-vdpa: implement vhost-vdpa backend
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000009346e905a3c96b79"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: cohuck@redhat.com, Michael Tsirkin <mst@redhat.com>, mhabets@solarflare.com,
 qemu-devel@nongnu.org, hanand@xilinx.com, rob.miller@broadcom.com,
 saugatm@xilinx.com, armbru@redhat.com, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, "Wang, Zhihong" <zhihong.wang@intel.com>,
 Ariel Adam <aadam@redhat.com>, rdunlap@infradead.org,
 maxime.coquelin@redhat.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009346e905a3c96b79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 11:57 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:
> > Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> > vhost-user. The above patch provides a generic device for vDPA purpose,
> > this vDPA device exposes to user space a non-vendor-specific
> configuration
> > interface for setting up a vhost HW accelerator, this patch set
> introduces
> > a third vhost backend called vhost-vdpa based on the vDPA interface.
> >
> > Vhost-vdpa usage:
> >
> >    qemu-system-x86_64 -cpu host -enable-kvm \
> >      ......
> >    -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-id,id=3Dvhost-v=
dpa0 \
> >    -device virtio-net-pci,netdev=3Dvhost-vdpa0,page-per-vq=3Don \
>
>
> Actually, this part should belongs to patch 2.
>
> And we probably need to add a comment that vIOMMU is not supported right
> now.
>
>
> Will fix this problem

> >
> > Author: Tiwei Bie
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   hw/net/vhost_net.c                |  43 ++++
> >   hw/net/virtio-net.c               |   9 +
> >   hw/virtio/Makefile.objs           |   2 +-
> >   hw/virtio/vhost-backend.c         |   3 +
> >   hw/virtio/vhost-vdpa.c            | 379 +++++++++++++++++++++++++++++=
+
> >   hw/virtio/vhost.c                 |   5 +
> >   include/hw/virtio/vhost-backend.h |   6 +-
> >   include/hw/virtio/vhost-vdpa.h    |  14 ++
> >   8 files changed, 459 insertions(+), 2 deletions(-)
> >   create mode 100644 hw/virtio/vhost-vdpa.c
> >   create mode 100644 include/hw/virtio/vhost-vdpa.h
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 4096d64aaf..0d13fda2fc 100644
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
> >   static const int *vhost_net_get_feature_bits(struct vhost_net *net)
> >   {
> >       const int *feature_bits =3D 0;
> > @@ -96,6 +121,9 @@ static const int *vhost_net_get_feature_bits(struct
> vhost_net *net)
> >       case NET_CLIENT_DRIVER_VHOST_USER:
> >           feature_bits =3D user_feature_bits;
> >           break;
> > +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> > +        feature_bits =3D vdpa_feature_bits;
> > +        break;
> >       default:
> >           error_report("Feature bits not defined for this type: %d",
> >                   net->nc->info->type);
> > @@ -434,6 +462,10 @@ VHostNetState *get_vhost_net(NetClientState *nc)
> >           assert(vhost_net);
> >           break;
> >   #endif
> > +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> > +        vhost_net =3D vhost_vdpa_get_vhost_net(nc);
> > +        assert(vhost_net);
> > +        break;
> >       default:
> >           break;
> >       }
> > @@ -465,3 +497,14 @@ int vhost_net_set_mtu(struct vhost_net *net,
> uint16_t mtu)
> >
> >       return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
> >   }
> > +int vhost_set_state(NetClientState *nc, int state)
> > +{
> > +    struct vhost_net *net =3D get_vhost_net(nc);
> > +    struct vhost_dev *hdev =3D &net->dev;
> > +    if (nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
> > +        if (hdev->vhost_ops->vhost_set_state) {
> > +                return hdev->vhost_ops->vhost_set_state(hdev, state);
> > +             }
> > +        }
> > +    return 0;
> > +}
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index db3d7c38e6..bbecd7ab96 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -206,6 +206,9 @@ static void virtio_net_vhost_status(VirtIONet *n,
> uint8_t status)
> >       VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >       NetClientState *nc =3D qemu_get_queue(n->nic);
> >       int queues =3D n->multiqueue ? n->max_queues : 1;
> > +    NetClientState *peer =3D nc->peer;
>
>
> qemu_get_peer()?
>
> will fix it

>
> > +    uint8_t status_set  =3D vdev->status ;
> > +    uint8_t vhost_started_pre =3D n->vhost_started;
> >
> >       if (!get_vhost_net(nc->peer)) {
> >           return;
> > @@ -245,6 +248,7 @@ static void virtio_net_vhost_status(VirtIONet *n,
> uint8_t status)
> >                   return;
> >               }
> >           }
> > +        status_set =3D status_set | VIRTIO_CONFIG_S_DRIVER_OK;
> >
> >           n->vhost_started =3D 1;
> >           r =3D vhost_net_start(vdev, n->nic->ncs, queues);
> > @@ -252,11 +256,16 @@ static void virtio_net_vhost_status(VirtIONet *n,
> uint8_t status)
> >               error_report("unable to start vhost net: %d: "
> >                            "falling back on userspace virtio", -r);
> >               n->vhost_started =3D 0;
> > +            status_set =3D status_set & ~VIRTIO_CONFIG_S_DRIVER_OK;
> >           }
> >       } else {
> >           vhost_net_stop(vdev, n->nic->ncs, queues);
> > +        status_set =3D status_set & ~VIRTIO_CONFIG_S_DRIVER_OK;
> >           n->vhost_started =3D 0;
> >       }
> > +    if (vhost_started_pre !=3D n->vhost_started) {
> > +            vhost_set_state(peer, status_set);
> > +    }
> >   }
>
>
> I think this deserves an independent patch.
>
>
> will fix it

>
> >
> >   static int virtio_net_set_vnet_endian_one(VirtIODevice *vdev,
> > diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> > index e2f70fbb89..17361d959e 100644
> > --- a/hw/virtio/Makefile.objs
> > +++ b/hw/virtio/Makefile.objs
> > @@ -2,7 +2,7 @@ ifeq ($(CONFIG_VIRTIO),y)
> >   common-obj-y +=3D virtio-bus.o
> >   obj-y +=3D virtio.o
> >
> > -obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) +=3D vhost=
.o
> vhost-backend.o
> > +obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) +=3D vhost=
.o
> vhost-backend.o vhost-vdpa.o
> >   common-obj-$(call lnot,$(call
> lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL))) +=3D vhost-stub.o
> >   obj-$(CONFIG_VHOST_USER) +=3D vhost-user.o
> >
> > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > index 48905383f8..935cd9e561 100644
> > --- a/hw/virtio/vhost-backend.c
> > +++ b/hw/virtio/vhost-backend.c
> > @@ -286,6 +286,9 @@ int vhost_set_backend_type(struct vhost_dev *dev,
> VhostBackendType backend_type)
> >           dev->vhost_ops =3D &user_ops;
> >           break;
> >   #endif
> > +    case VHOST_BACKEND_TYPE_VDPA:
> > +        dev->vhost_ops =3D &vdpa_ops;
> > +        break;
> >       default:
> >           error_report("Unknown vhost backend type");
> >           r =3D -1;
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > new file mode 100644
> > index 0000000000..213b327600
> > --- /dev/null
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -0,0 +1,379 @@
> > +/*
> > + * vhost-vdpa
> > + *
> > + *  Copyright(c) 2017-2018 Intel Corporation. All rights reserved.
> > + *  Copyright(c) 2020 Red Hat, Inc.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
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
> > +static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection
> *section)
> > +{
> > +    return (!memory_region_is_ram(section->mr) &&
> > +            !memory_region_is_iommu(section->mr)) ||
> > +           /*
> > +            * Sizing an enabled 64-bit BAR can cause spurious mappings
> to
> > +            * addresses in the upper part of the 64-bit address space.
> These
> > +            * are never accessed by the CPU and beyond the address
> width of
> > +            * some IOMMU hardware.  TODO: VDPA should tell us the IOMM=
U
> width.
> > +            */
> > +           section->offset_within_address_space & (1ULL << 63);
> > +}
> > +
> > +static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwadd=
r
> size,
> > +                              void *vaddr, bool readonly)
> > +{
> > +    struct vhost_msg_v2 msg;
> > +    int fd =3D v->device_fd;
> > +    int ret =3D 0;
> > +
> > +    msg.type =3D VHOST_IOTLB_MSG_V2;
>
>
> Since V2 of the message is used here, I believe we need a kernel patch
> to allow the querying of backend capability.
>
> Sure, I will provide another patch for kernel

>
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
> > +    msg.type =3D VHOST_IOTLB_MSG_V2;
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
> > +    struct vhost_vdpa *v =3D container_of(listener, struct vhost_vdpa,
> listener);
> > +    hwaddr iova;
> > +    Int128 llend, llsize;
> > +    void *vaddr;
> > +    int ret;
> > +
> > +    if (vhost_vdpa_listener_skipped_section(section)) {
> > +        return;
> > +    }
> > +
> > +    if (unlikely((section->offset_within_address_space &
> ~TARGET_PAGE_MASK) !=3D
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
> > +            /* Allow unexpected mappings not to be fatal for RAM
> devices */
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
> > +    struct vhost_vdpa *v =3D container_of(listener, struct vhost_vdpa,
> listener);
> > +    hwaddr iova;
> > +    Int128 llend, llsize;
> > +    int ret;
> > +    bool try_unmap =3D true;
> > +
> > +    if (vhost_vdpa_listener_skipped_section(section)) {
> > +        return;
> > +    }
> > +
> > +    if (unlikely((section->offset_within_address_space &
> ~TARGET_PAGE_MASK) !=3D
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
>
>
> I think it's better to add comment to explain why vhost-vdpa use a
> different listener other than the one used by other vhost backends (e.g
> kernel or user).
>
> will fix it

>
> > +static const MemoryListener vhost_vdpa_memory_listener =3D {
> > +    .region_add =3D vhost_vdpa_listener_region_add,
> > +    .region_del =3D vhost_vdpa_listener_region_del,
> > +};
> > +
> > +
> > +static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int
> request,
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
> > +
> > +
> > +static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque)
> > +{
> > +    struct vhost_vdpa *v;
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
>
>
> A comment here is need to explain why INT_MAX is used.
>
>
> will do

> > +static int vhost_vdpa_memslots_limit(struct vhost_dev *dev)
> > +{
> > +    return INT_MAX;
> > +}
> > +
> > +static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t bas=
e,
> > +                                   struct vhost_log *log)
> > +{
> > +    return 0;
> > +}
>
>
> I think we should fail this function since we don't support dirty page
> tracking now.
>
> And it's not guarantee to use dirty page bitmap in the future.
>
>
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
>
>
> A comment is need to explain why mem table is not used. (E.g we used
> IOTLB API instead).
>
> will do

>
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
> > +
> > +    features |=3D (1ULL << VIRTIO_F_IOMMU_PLATFORM);
>
>
> This seems tricky, I don't think we need this actually.
>
>
> I will double check for this problem

> > +    return vhost_vdpa_call(dev, VHOST_SET_FEATURES, &features);
> > +
> > +}
> > +
> > +static int vhost_vdpa_get_features(struct vhost_dev *dev,
> > +                                   uint64_t *features)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_GET_FEATURES, features);
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
> > +
> > +static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
> > +{
> > +    assert(idx >=3D dev->vq_index && idx < dev->vq_index + dev->nvqs);
> > +
> > +    return idx - dev->vq_index;
> > +}
> > +
> > +static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int
> enable)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < dev->nvqs; ++i) {
> > +        struct vhost_vring_state state =3D {
> > +            .index =3D dev->vq_index + i,
> > +            .num   =3D enable,
> > +        };
> > +
> > +        state.num =3D 1;
> > +
> > +        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
>
>
> Please make sure patch 4 comes first then we don't need to fix this in
> patch 4.
>
> will do

>
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int vhost_vdpa_set_state(struct vhost_dev *dev, int state)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &state);
> > +}
> > +
> > +
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
> > +        .vhost_set_vring_enable =3D vhost_vdpa_set_vring_enable,
> > +        .vhost_requires_shm_log =3D NULL,
> > +        .vhost_migration_done =3D NULL,
> > +        .vhost_backend_can_merge =3D NULL,
> > +        .vhost_net_set_mtu =3D NULL,
> > +        .vhost_set_iotlb_callback =3D NULL,
> > +        .vhost_send_device_iotlb_msg =3D NULL,
> > +        .vhost_set_state =3D vhost_vdpa_set_state,
> > +};
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 4da0d5a6c5..d1f2c4add7 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -746,6 +746,11 @@ static int vhost_virtqueue_set_addr(struct
> vhost_dev *dev,
> >           .log_guest_addr =3D vq->used_phys,
> >           .flags =3D enable_log ? (1 << VHOST_VRING_F_LOG) : 0,
> >       };
> > +    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA) {
> > +        addr.desc_user_addr =3D (uint64_t)(unsigned long)vq->desc_phys=
;
> > +        addr.avail_user_addr =3D (uint64_t)(unsigned long)vq->avail_ph=
ys;
> > +        addr.used_user_addr =3D (uint64_t)(unsigned long)vq->used_phys=
;
> > +    }
>
>
> Comment is needed to explain why vDPA differs from others.
>
> Thanks
>
> will do

>
> >       int r =3D dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
> >       if (r < 0) {
> >           VHOST_OPS_DEBUG("vhost_set_vring_addr failed");
> > diff --git a/include/hw/virtio/vhost-backend.h
> b/include/hw/virtio/vhost-backend.h
> > index 6f6670783f..d81bd9885f 100644
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
> > @@ -112,6 +113,7 @@ typedef int (*vhost_get_inflight_fd_op)(struct
> vhost_dev *dev,
> >   typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
> >                                           struct vhost_inflight
> *inflight);
> >
> > +typedef int (*vhost_set_state_op)(struct vhost_dev *dev, int state);
> >   typedef struct VhostOps {
> >       VhostBackendType backend_type;
> >       vhost_backend_init vhost_backend_init;
> > @@ -152,9 +154,11 @@ typedef struct VhostOps {
> >       vhost_backend_mem_section_filter_op
> vhost_backend_mem_section_filter;
> >       vhost_get_inflight_fd_op vhost_get_inflight_fd;
> >       vhost_set_inflight_fd_op vhost_set_inflight_fd;
> > +    vhost_set_state_op vhost_set_state;
> >   } VhostOps;
> >
> >   extern const VhostOps user_ops;
> > +extern const VhostOps vdpa_ops;
> >
> >   int vhost_set_backend_type(struct vhost_dev *dev,
> >                              VhostBackendType backend_type);
> > diff --git a/include/hw/virtio/vhost-vdpa.h
> b/include/hw/virtio/vhost-vdpa.h
> > new file mode 100644
> > index 0000000000..889c1a4410
> > --- /dev/null
> > +++ b/include/hw/virtio/vhost-vdpa.h
> > @@ -0,0 +1,14 @@
> > +
> > +#ifndef HW_VIRTIO_VHOST_VDPA_H
> > +#define HW_VIRTIO_VHOST_VDPA_H
> > +
> > +#include "hw/virtio/virtio.h"
> > +
> > +typedef struct vhost_vdpa {
> > +    int device_fd;
> > +    MemoryListener listener;
> > +} VhostVDPA;
> > +
> > +extern AddressSpace address_space_memory;
> > +
> > +#endif
>
>

--0000000000009346e905a3c96b79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 21, 2020 at 11:57 AM Jaso=
n Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:<br>
&gt; Currently we have 2 types of vhost backends in QEMU: vhost kernel and<=
br>
&gt; vhost-user. The above patch provides a generic device for vDPA purpose=
,<br>
&gt; this vDPA device exposes to user space a non-vendor-specific configura=
tion<br>
&gt; interface for setting up a vhost HW accelerator, this patch set introd=
uces<br>
&gt; a third vhost backend called vhost-vdpa based on the vDPA interface.<b=
r>
&gt;<br>
&gt; Vhost-vdpa usage:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 qemu-system-x86_64 -cpu host -enable-kvm \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ......<br>
&gt;=C2=A0 =C2=A0 -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-id,i=
d=3Dvhost-vdpa0 \<br>
&gt;=C2=A0 =C2=A0 -device virtio-net-pci,netdev=3Dvhost-vdpa0,page-per-vq=
=3Don \<br>
<br>
<br>
Actually, this part should belongs to patch 2.<br>
<br>
And we probably need to add a comment that vIOMMU is not supported right <b=
r>
now.<br>
<br>
<br></blockquote><div>Will fix this=C2=A0problem=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Author: Tiwei Bie<br>
&gt; Signed-off-by: Cindy Lu &lt;<a href=3D"mailto:lulu@redhat.com" target=
=3D"_blank">lulu@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/vhost_net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 43 ++++<br>
&gt;=C2=A0 =C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 =C2=A0hw/virtio/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0hw/virtio/vhost-backend.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0hw/virtio/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 379 ++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/vhost-backend.h |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/vhost-vdpa.h=C2=A0 =C2=A0 |=C2=A0 14 ++<=
br>
&gt;=C2=A0 =C2=A08 files changed, 459 insertions(+), 2 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/virtio/vhost-vdpa.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/virtio/vhost-vdpa.h<br>
&gt;<br>
&gt; diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c<br>
&gt; index 4096d64aaf..0d13fda2fc 100644<br>
&gt; --- a/hw/net/vhost_net.c<br>
&gt; +++ b/hw/net/vhost_net.c<br>
&gt; @@ -17,8 +17,10 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;net/net.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;net/tap.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;net/vhost-user.h&quot;<br>
&gt; +#include &quot;net/vhost-vdpa.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;standard-headers/linux/vhost_types.h&quot;<=
br>
&gt; +#include &quot;linux-headers/linux/vhost.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/virtio/virtio-net.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;net/vhost_net.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/error-report.h&quot;<br>
&gt; @@ -85,6 +87,29 @@ static const int user_feature_bits[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_INVALID_FEATURE_BIT<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static const int vdpa_feature_bits[] =3D {<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_F_NOTIFY_ON_EMPTY,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_RING_F_INDIRECT_DESC,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_RING_F_EVENT_IDX,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_F_ANY_LAYOUT,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_F_VERSION_1,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_CSUM,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_CSUM,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_GSO,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_TSO4,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_TSO6,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_ECN,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_UFO,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_HOST_TSO4,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_HOST_TSO6,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_HOST_ECN,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_HOST_UFO,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_MRG_RXBUF,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_MTU,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_F_IOMMU_PLATFORM,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_ANNOUNCE,<br>
&gt; +=C2=A0 =C2=A0 VHOST_INVALID_FEATURE_BIT<br>
&gt; +};<br>
&gt;=C2=A0 =C2=A0static const int *vhost_net_get_feature_bits(struct vhost_=
net *net)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const int *feature_bits =3D 0;<br>
&gt; @@ -96,6 +121,9 @@ static const int *vhost_net_get_feature_bits(struct=
 vhost_net *net)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case NET_CLIENT_DRIVER_VHOST_USER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0feature_bits =3D user_feature_=
bits;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 case NET_CLIENT_DRIVER_VHOST_VDPA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 feature_bits =3D vdpa_feature_bits;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Feature bit=
s not defined for this type: %d&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ne=
t-&gt;nc-&gt;info-&gt;type);<br>
&gt; @@ -434,6 +462,10 @@ VHostNetState *get_vhost_net(NetClientState *nc)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(vhost_net);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; +=C2=A0 =C2=A0 case NET_CLIENT_DRIVER_VHOST_VDPA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_net =3D vhost_vdpa_get_vhost_net(nc=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(vhost_net);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -465,3 +497,14 @@ int vhost_net_set_mtu(struct vhost_net *net, uint=
16_t mtu)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return vhost_ops-&gt;vhost_net_set_mtu(&amp;=
net-&gt;dev, mtu);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +int vhost_set_state(NetClientState *nc, int state)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct vhost_net *net =3D get_vhost_net(nc);<br>
&gt; +=C2=A0 =C2=A0 struct vhost_dev *hdev =3D &amp;net-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 if (nc-&gt;info-&gt;type =3D=3D NET_CLIENT_DRIVER_VHOST=
_VDPA) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hdev-&gt;vhost_ops-&gt;vhost_set_stat=
e) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return hdev-&=
gt;vhost_ops-&gt;vhost_set_state(hdev, state);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index db3d7c38e6..bbecd7ab96 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -206,6 +206,9 @@ static void virtio_net_vhost_status(VirtIONet *n, =
uint8_t status)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NetClientState *nc =3D qemu_get_queue(n-&gt;=
nic);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int queues =3D n-&gt;multiqueue ? n-&gt;max_=
queues : 1;<br>
&gt; +=C2=A0 =C2=A0 NetClientState *peer =3D nc-&gt;peer;<br>
<br>
<br>
qemu_get_peer()?<br>
<br></blockquote><div>will fix=C2=A0it=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 uint8_t status_set=C2=A0 =3D vdev-&gt;status ;<br>
&gt; +=C2=A0 =C2=A0 uint8_t vhost_started_pre =3D n-&gt;vhost_started;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!get_vhost_net(nc-&gt;peer)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; @@ -245,6 +248,7 @@ static void virtio_net_vhost_status(VirtIONet *n, =
uint8_t status)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status_set =3D status_set | VIRTIO_CONFIG=
_S_DRIVER_OK;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;vhost_started =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D vhost_net_start(vdev, n-=
&gt;nic-&gt;ncs, queues);<br>
&gt; @@ -252,11 +256,16 @@ static void virtio_net_vhost_status(VirtIONet *n=
, uint8_t status)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&qu=
ot;unable to start vhost net: %d: &quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;falling back on userspace virtio&quot;, -=
r);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;vhost_star=
ted =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status_set =3D status_set &=
amp; ~VIRTIO_CONFIG_S_DRIVER_OK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_net_stop(vdev, n-&gt;nic=
-&gt;ncs, queues);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status_set =3D status_set &amp; ~VIRTIO_C=
ONFIG_S_DRIVER_OK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;vhost_started =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 if (vhost_started_pre !=3D n-&gt;vhost_started) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_set_state(peer, statu=
s_set);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
<br>
<br>
I think this deserves an independent patch.<br>
<br>
<br></blockquote><div>will fix it=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int virtio_net_set_vnet_endian_one(VirtIODevice *vd=
ev,<br>
&gt; diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs<br>
&gt; index e2f70fbb89..17361d959e 100644<br>
&gt; --- a/hw/virtio/Makefile.objs<br>
&gt; +++ b/hw/virtio/Makefile.objs<br>
&gt; @@ -2,7 +2,7 @@ ifeq ($(CONFIG_VIRTIO),y)<br>
&gt;=C2=A0 =C2=A0common-obj-y +=3D virtio-bus.o<br>
&gt;=C2=A0 =C2=A0obj-y +=3D virtio.o<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) +=3D vhos=
t.o vhost-backend.o<br>
&gt; +obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) +=3D vhos=
t.o vhost-backend.o vhost-vdpa.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(C=
ONFIG_VHOST_KERNEL))) +=3D vhost-stub.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_VHOST_USER) +=3D vhost-user.o<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c<br>
&gt; index 48905383f8..935cd9e561 100644<br>
&gt; --- a/hw/virtio/vhost-backend.c<br>
&gt; +++ b/hw/virtio/vhost-backend.c<br>
&gt; @@ -286,6 +286,9 @@ int vhost_set_backend_type(struct vhost_dev *dev, =
VhostBackendType backend_type)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;vhost_ops =3D &amp;use=
r_ops;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; +=C2=A0 =C2=A0 case VHOST_BACKEND_TYPE_VDPA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;vhost_ops =3D &amp;vdpa_ops;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Unknown vho=
st backend type&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D -1;<br>
&gt; diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..213b327600<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/virtio/vhost-vdpa.c<br>
&gt; @@ -0,0 +1,379 @@<br>
&gt; +/*<br>
&gt; + * vhost-vdpa<br>
&gt; + *<br>
&gt; + *=C2=A0 Copyright(c) 2017-2018 Intel Corporation. All rights reserve=
d.<br>
&gt; + *=C2=A0 Copyright(c) 2020 Red Hat, Inc.<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &lt;linux/vhost.h&gt;<br>
&gt; +#include &lt;linux/vfio.h&gt;<br>
&gt; +#include &lt;sys/eventfd.h&gt;<br>
&gt; +#include &lt;sys/ioctl.h&gt;<br>
&gt; +#include &quot;hw/virtio/vhost.h&quot;<br>
&gt; +#include &quot;hw/virtio/vhost-backend.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-net.h&quot;<br>
&gt; +#include &quot;hw/virtio/vhost-vdpa.h&quot;<br>
&gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt; +#include &lt;linux/kvm.h&gt;<br>
&gt; +#include &quot;sysemu/kvm.h&quot;<br>
&gt; +<br>
&gt; +<br>
&gt; +static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *=
section)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return (!memory_region_is_ram(section-&gt;mr) &amp;&amp=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !memory_region_is_iommu(sec=
tion-&gt;mr)) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Sizing an enabled 64-bit =
BAR can cause spurious mappings to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * addresses in the upper pa=
rt of the 64-bit address space.=C2=A0 These<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * are never accessed by the=
 CPU and beyond the address width of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * some IOMMU hardware.=C2=
=A0 TODO: VDPA should tell us the IOMMU width.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0section-&gt;offset_within_ad=
dress_space &amp; (1ULL &lt;&lt; 63);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwad=
dr size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *vaddr, bool readonly)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct vhost_msg_v2 msg;<br>
&gt; +=C2=A0 =C2=A0 int fd =3D v-&gt;device_fd;<br>
&gt; +=C2=A0 =C2=A0 int ret =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 msg.type =3D VHOST_IOTLB_MSG_V2;<br>
<br>
<br>
Since V2 of the message is used here, I believe we need a kernel patch <br>
to allow the querying of backend capability.<br>
<br></blockquote><div>Sure, I will provide=C2=A0another patch for kernel=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.iova =3D iova;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.size =3D size;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.uaddr =3D (uint64_t)vaddr;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.perm =3D readonly ? VHOST_ACCESS_RO : VHOST_A=
CCESS_RW;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.type =3D VHOST_IOTLB_UPDATE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (write(fd, &amp;msg, sizeof(msg)) !=3D sizeof(msg)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;failed to write, fd=3D=
%d, errno=3D%d (%s)&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd, errno, strerror(errno))=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO ;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct vhost_msg_v2 msg;<br>
&gt; +=C2=A0 =C2=A0 int fd =3D v-&gt;device_fd;<br>
&gt; +=C2=A0 =C2=A0 int ret =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 msg.type =3D VHOST_IOTLB_MSG_V2;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.iova =3D iova;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.size =3D size;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.type =3D VHOST_IOTLB_INVALIDATE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (write(fd, &amp;msg, sizeof(msg)) !=3D sizeof(msg)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;failed to write, fd=3D=
%d, errno=3D%d (%s)&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd, errno, strerror(errno))=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO ;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vhost_vdpa_listener_region_add(MemoryListener *listener,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MemoryRegionSection *section)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct vhost_vdpa *v =3D container_of(listener, struct =
vhost_vdpa, listener);<br>
&gt; +=C2=A0 =C2=A0 hwaddr iova;<br>
&gt; +=C2=A0 =C2=A0 Int128 llend, llsize;<br>
&gt; +=C2=A0 =C2=A0 void *vaddr;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vhost_vdpa_listener_skipped_section(section)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (unlikely((section-&gt;offset_within_address_space &=
amp; ~TARGET_PAGE_MASK) !=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(sectio=
n-&gt;offset_within_region &amp; ~TARGET_PAGE_MASK))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s received unaligned =
region&quot;, __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iova =3D TARGET_PAGE_ALIGN(section-&gt;offset_within_ad=
dress_space);<br>
&gt; +=C2=A0 =C2=A0 llend =3D int128_make64(section-&gt;offset_within_addre=
ss_space);<br>
&gt; +=C2=A0 =C2=A0 llend =3D int128_add(llend, section-&gt;size);<br>
&gt; +=C2=A0 =C2=A0 llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_M=
ASK));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (int128_ge(int128_make64(iova), llend)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_ref(section-&gt;mr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Here we assume that memory_region_is_ram(section-&gt=
;mr)=3D=3Dtrue */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vaddr =3D memory_region_get_ram_ptr(section-&gt;mr) +<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section-&gt;offset_within_r=
egion +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (iova - section-&gt;offset_=
within_address_space);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 llsize =3D int128_sub(llend, int128_make64(iova));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D vhost_vdpa_dma_map(v, iova, int128_get64(llsize=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vaddr, section-&gt;readonly);<br>
&gt; +=C2=A0 =C2=A0 if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;vhost vdpa map fail!&q=
uot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (memory_region_is_ram_device(section-&=
gt;mr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Allow unexpected mapping=
s not to be fatal for RAM devices */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;map ram =
fail!&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return;<br>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 =C2=A0 if (memory_region_is_ram_device(section-&gt;mr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;failed to vdpa_dma_map=
. pci p2p may not work&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* On the initfn path, store the first error in th=
e container so we<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* can gracefully fail.=C2=A0 Runtime, there&#39;s=
 not much we can do other<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* than throw a hardware error.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 error_report(&quot;vhost-vdpa: DMA mapping failed, unab=
le to continue&quot;);<br>
&gt; +=C2=A0 =C2=A0 return;<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vhost_vdpa_listener_region_del(MemoryListener *listener,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MemoryRegionSection *section)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct vhost_vdpa *v =3D container_of(listener, struct =
vhost_vdpa, listener);<br>
&gt; +=C2=A0 =C2=A0 hwaddr iova;<br>
&gt; +=C2=A0 =C2=A0 Int128 llend, llsize;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 bool try_unmap =3D true;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vhost_vdpa_listener_skipped_section(section)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (unlikely((section-&gt;offset_within_address_space &=
amp; ~TARGET_PAGE_MASK) !=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(sectio=
n-&gt;offset_within_region &amp; ~TARGET_PAGE_MASK))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s received unaligned =
region&quot;, __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iova =3D TARGET_PAGE_ALIGN(section-&gt;offset_within_ad=
dress_space);<br>
&gt; +=C2=A0 =C2=A0 llend =3D int128_make64(section-&gt;offset_within_addre=
ss_space);<br>
&gt; +=C2=A0 =C2=A0 llend =3D int128_add(llend, section-&gt;size);<br>
&gt; +=C2=A0 =C2=A0 llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_M=
ASK));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (int128_ge(int128_make64(iova), llend)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 llsize =3D int128_sub(llend, int128_make64(iova));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (try_unmap) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_vdpa_dma_unmap(v, iova, int=
128_get64(llsize));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;vhost_vd=
pa dma unmap error!&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_unref(section-&gt;mr);<br>
&gt; +}<br>
&gt; +<br>
<br>
<br>
I think it&#39;s better to add comment to explain why vhost-vdpa use a <br>
different listener other than the one used by other vhost backends (e.g <br=
>
kernel or user).<br>
<br></blockquote><div>will fix=C2=A0it=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
&gt; +static const MemoryListener vhost_vdpa_memory_listener =3D {<br>
&gt; +=C2=A0 =C2=A0 .region_add =3D vhost_vdpa_listener_region_add,<br>
&gt; +=C2=A0 =C2=A0 .region_del =3D vhost_vdpa_listener_region_del,<br>
&gt; +};<br>
&gt; +<br>
&gt; +<br>
&gt; +static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int r=
equest,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *arg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct vhost_vdpa *v =3D dev-&gt;opaque;<br>
&gt; +=C2=A0 =C2=A0 int fd =3D v-&gt;device_fd;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(dev-&gt;vhost_ops-&gt;backend_type =3D=3D VHOST_=
BACKEND_TYPE_VDPA);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ioctl(fd, request, arg);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct vhost_vdpa *v;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(dev-&gt;vhost_ops-&gt;backend_type =3D=3D VHOST_=
BACKEND_TYPE_VDPA);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 v =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 dev-&gt;opaque =3D=C2=A0 opaque ;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 v-&gt;listener =3D vhost_vdpa_memory_listener;<br>
&gt; +=C2=A0 =C2=A0 memory_listener_register(&amp;v-&gt;listener, &amp;addr=
ess_space_memory);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_cleanup(struct vhost_dev *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct vhost_vdpa *v;<br>
&gt; +=C2=A0 =C2=A0 assert(dev-&gt;vhost_ops-&gt;backend_type =3D=3D VHOST_=
BACKEND_TYPE_VDPA);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 v =3D dev-&gt;opaque;<br>
&gt; +=C2=A0 =C2=A0 memory_listener_unregister(&amp;v-&gt;listener);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dev-&gt;opaque =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
<br>
<br>
A comment here is need to explain why INT_MAX is used.<br>
<br>
<br></blockquote><div>will do=C2=A0=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
&gt; +static int vhost_vdpa_memslots_limit(struct vhost_dev *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return INT_MAX;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t ba=
se,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_log *l=
og)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
<br>
<br>
I think we should fail this function since we don&#39;t support dirty page =
<br>
tracking now.<br>
<br>
And it&#39;s not guarantee to use dirty page bitmap in the future.<br>
<br>
<br>
&gt; +<br>
&gt; +static int vhost_vdpa_set_mem_table(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_memor=
y *mem)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (mem-&gt;padding) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
<br>
<br>
A comment is need to explain why mem table is not used. (E.g we used <br>
IOTLB API instead).<br>
<br></blockquote><div>will do=C2=A0=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_set_vring_addr(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost=
_vring_addr *addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return vhost_vdpa_call(dev, VHOST_SET_VRING_ADDR, addr)=
;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_set_vring_num(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_vring=
_state *ring)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return vhost_vdpa_call(dev, VHOST_SET_VRING_NUM, ring);=
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_set_vring_base(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost=
_vring_state *ring)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring)=
;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost=
_vring_state *ring)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring)=
;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_set_vring_kick(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost=
_vring_file *file)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return vhost_vdpa_call(dev, VHOST_SET_VRING_KICK, file)=
;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_set_vring_call(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost=
_vring_file *file)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return vhost_vdpa_call(dev, VHOST_SET_VRING_CALL, file)=
;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_set_features(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t features)<=
br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 features |=3D (1ULL &lt;&lt; VIRTIO_F_IOMMU_PLATFORM);<=
br>
<br>
<br>
This seems tricky, I don&#39;t think we need this actually.<br>
<br>
<br></blockquote><div>I will double check for this problem=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 return vhost_vdpa_call(dev, VHOST_SET_FEATURES, &amp;fe=
atures);<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_get_features(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *features)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return vhost_vdpa_call(dev, VHOST_GET_FEATURES, feature=
s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_set_owner(struct vhost_dev *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_reset_device(struct vhost_dev *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return vhost_vdpa_call(dev, VHOST_RESET_OWNER, NULL);<b=
r>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 assert(idx &gt;=3D dev-&gt;vq_index &amp;&amp; idx &lt;=
 dev-&gt;vq_index + dev-&gt;nvqs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return idx - dev-&gt;vq_index;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int ena=
ble)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;nvqs; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_vring_state state =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .index =3D dev-&gt;vq_index=
 + i,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .num=C2=A0 =C2=A0=3D enable=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 state.num =3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING=
_ENABLE, &amp;state);<br>
<br>
<br>
Please make sure patch 4 comes first then we don&#39;t need to fix this in =
<br>
patch 4.<br>
<br></blockquote><div>will do=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_set_state(struct vhost_dev *dev, int state)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &amp=
;state);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +const VhostOps vdpa_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .backend_type =3D VHOST_BACKEND_TYPE_VDPA=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_backend_init =3D vhost_vdpa_init,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_backend_cleanup =3D vhost_vdpa_cle=
anup,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_backend_memslots_limit =3D vhost_v=
dpa_memslots_limit,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_log_base =3D vhost_vdpa_set_lo=
g_base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_mem_table =3D vhost_vdpa_set_m=
em_table,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_vring_addr =3D vhost_vdpa_set_=
vring_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_vring_endian =3D NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_vring_num =3D vhost_vdpa_set_v=
ring_num,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_vring_base =3D vhost_vdpa_set_=
vring_base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_get_vring_base =3D vhost_vdpa_get_=
vring_base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_vring_kick =3D vhost_vdpa_set_=
vring_kick,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_vring_call =3D vhost_vdpa_set_=
vring_call,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_features =3D vhost_vdpa_set_fe=
atures,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_get_features =3D vhost_vdpa_get_fe=
atures,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_owner =3D vhost_vdpa_set_owner=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_reset_device =3D vhost_vdpa_reset_=
device,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_get_vq_index =3D vhost_vdpa_get_vq=
_index,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_vring_enable =3D vhost_vdpa_se=
t_vring_enable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_requires_shm_log =3D NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_migration_done =3D NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_backend_can_merge =3D NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_net_set_mtu =3D NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_iotlb_callback =3D NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_send_device_iotlb_msg =3D NULL,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_state =3D vhost_vdpa_set_state=
,<br>
&gt; +};<br>
&gt; diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c<br>
&gt; index 4da0d5a6c5..d1f2c4add7 100644<br>
&gt; --- a/hw/virtio/vhost.c<br>
&gt; +++ b/hw/virtio/vhost.c<br>
&gt; @@ -746,6 +746,11 @@ static int vhost_virtqueue_set_addr(struct vhost_=
dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.log_guest_addr =3D vq-&gt;use=
d_phys,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D enable_log ? (1 &lt=
;&lt; VHOST_VRING_F_LOG) : 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 if (dev-&gt;vhost_ops-&gt;backend_type =3D=3D VHOST_BAC=
KEND_TYPE_VDPA) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr.desc_user_addr =3D (uint64_t)(unsign=
ed long)vq-&gt;desc_phys;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr.avail_user_addr =3D (uint64_t)(unsig=
ned long)vq-&gt;avail_phys;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr.used_user_addr =3D (uint64_t)(unsign=
ed long)vq-&gt;used_phys;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
<br>
Comment is needed to explain why vDPA differs from others.<br>
<br>
Thanks<br>
<br></blockquote><div>will do=C2=A0=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int r =3D dev-&gt;vhost_ops-&gt;vhost_set_vr=
ing_addr(dev, &amp;addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_OPS_DEBUG(&quot;vhost_se=
t_vring_addr failed&quot;);<br>
&gt; diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vho=
st-backend.h<br>
&gt; index 6f6670783f..d81bd9885f 100644<br>
&gt; --- a/include/hw/virtio/vhost-backend.h<br>
&gt; +++ b/include/hw/virtio/vhost-backend.h<br>
&gt; @@ -17,7 +17,8 @@ typedef enum VhostBackendType {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_BACKEND_TYPE_NONE =3D 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_BACKEND_TYPE_KERNEL =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_BACKEND_TYPE_USER =3D 2,<br>
&gt; -=C2=A0 =C2=A0 VHOST_BACKEND_TYPE_MAX =3D 3,<br>
&gt; +=C2=A0 =C2=A0 VHOST_BACKEND_TYPE_VDPA =3D 3,<br>
&gt; +=C2=A0 =C2=A0 VHOST_BACKEND_TYPE_MAX =3D 4,<br>
&gt;=C2=A0 =C2=A0} VhostBackendType;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0typedef enum VhostSetConfigType {<br>
&gt; @@ -112,6 +113,7 @@ typedef int (*vhost_get_inflight_fd_op)(struct vho=
st_dev *dev,<br>
&gt;=C2=A0 =C2=A0typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *=
dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct vhost_inflight *inflight);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +typedef int (*vhost_set_state_op)(struct vhost_dev *dev, int state);<=
br>
&gt;=C2=A0 =C2=A0typedef struct VhostOps {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VhostBackendType backend_type;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_backend_init vhost_backend_init;<br>
&gt; @@ -152,9 +154,11 @@ typedef struct VhostOps {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_backend_mem_section_filter_op vhost_ba=
ckend_mem_section_filter;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_get_inflight_fd_op vhost_get_inflight_=
fd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_set_inflight_fd_op vhost_set_inflight_=
fd;<br>
&gt; +=C2=A0 =C2=A0 vhost_set_state_op vhost_set_state;<br>
&gt;=C2=A0 =C2=A0} VhostOps;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0extern const VhostOps user_ops;<br>
&gt; +extern const VhostOps vdpa_ops;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int vhost_set_backend_type(struct vhost_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostBackendType backend_type);<br>
&gt; diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-=
vdpa.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..889c1a4410<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/virtio/vhost-vdpa.h<br>
&gt; @@ -0,0 +1,14 @@<br>
&gt; +<br>
&gt; +#ifndef HW_VIRTIO_VHOST_VDPA_H<br>
&gt; +#define HW_VIRTIO_VHOST_VDPA_H<br>
&gt; +<br>
&gt; +#include &quot;hw/virtio/virtio.h&quot;<br>
&gt; +<br>
&gt; +typedef struct vhost_vdpa {<br>
&gt; +=C2=A0 =C2=A0 int device_fd;<br>
&gt; +=C2=A0 =C2=A0 MemoryListener listener;<br>
&gt; +} VhostVDPA;<br>
&gt; +<br>
&gt; +extern AddressSpace address_space_memory;<br>
&gt; +<br>
&gt; +#endif<br>
<br>
</blockquote></div></div>

--0000000000009346e905a3c96b79--


