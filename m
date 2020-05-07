Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A91C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62F32082E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bw5cQzre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62F32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiui-0006rr-3L
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jWiti-0005RY-IW
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:57:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27621
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jWitg-00020O-V5
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588867035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRSajkUHM6lER7L0rIVu3f65i583HPKvNKbmYn8jG9I=;
 b=bw5cQzrenAFNeaK3/lkcdFex41+DM2OYSB0i6Tkb8i2fEizjE+3f8+k65Nq6Kq0oiIL/i2
 zFeL6EzLF1hzaZ8qlZbLcKN2POZDNHmvDV4gdV8S25inRLsaqjITj7aJKX6VF3d3tnpcU0
 kw+JsgzBiDjVqqoo98T2UjRzolpQaVo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-R7MKVds1NxGRozHTWZbOIA-1; Thu, 07 May 2020 11:57:12 -0400
X-MC-Unique: R7MKVds1NxGRozHTWZbOIA-1
Received: by mail-pg1-f197.google.com with SMTP id l7so4569049pgb.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 08:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2SyF2372pTBjf3SVGEBfCB5pCYPLHN9ahZ+Rga2Pu7M=;
 b=Fo42COJR7alHsDqCoOzpDyTmBe5X3jTw9i/UvIS071V7Ta2jksYOHyaNelIfIeLy+X
 D5rputl62zkFr3vPEeJ16jl5prkmoCoLo/QXyg0aY5g6CxNKPxE1l406DdyDKY0yD60Z
 v+oK5hqPyTURj5gOM2HtktdyDaBPhm+wELo32zqN36Sy9VXphb1dNeRMhTqY7SP4Hy0P
 RCIv/qa7dCcgn+d3Eh6BSabv7JL8mIWSN0VuKJajdfKUjGKdLsuMx2zpAaIwCdKPM7wf
 rHD2dnnxdB98BLgqOSCKXIvnJgJPOELV50PZwzYSbBljOfaTa38WOuNcYslP1NBfWS0D
 Y5Mw==
X-Gm-Message-State: AGi0Puaco1SMN8jddhZo0yzdouXQ42xWPyLDw38uc1HUTcLV31f6HKOk
 6UmYr2WrAWa58XYIIXRuyWb2MUhUp1xfFcwe6FRQzagHdjGNq6R6kFwMc/xE/Z4VrInxiJOw8Qv
 JSwDNm2pVRqFDzU7MVs6rDVl++yoN7Sc=
X-Received: by 2002:a62:2c92:: with SMTP id
 s140mr15022600pfs.223.1588867031046; 
 Thu, 07 May 2020 08:57:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypJhU8N+AjfOqlq9v8EhzhES+n4PFesa1n0XGcA21EMIzM0DZWtIIUQ9RXi2yw36kzIIlEbmE2wXwlH7OvJwSmM=
X-Received: by 2002:a62:2c92:: with SMTP id
 s140mr15022552pfs.223.1588867030694; 
 Thu, 07 May 2020 08:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-4-lulu@redhat.com>
 <c107994b-888d-8aa4-57d2-5188837ed757@redhat.com>
In-Reply-To: <c107994b-888d-8aa4-57d2-5188837ed757@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 7 May 2020 23:56:59 +0800
Message-ID: <CACLfguUwYL_eaS81HiOhRWOg22xZoiA9QWVxAxe0FC6z4fZjCQ@mail.gmail.com>
Subject: Re: [RFC v1 3/4] vhost-vdpa: implement vhost-vdpa backend
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 rob.miller@broadcom.com, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 mhabets@solarflare.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 rdunlap@infradead.org, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 7, 2020 at 11:13 PM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 4/20/20 11:32 AM, Cindy Lu wrote:
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
> >   qemu-system-x86_64 -cpu host -enable-kvm \
> >     ......
> >   -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-id,id=3Dvhost-vd=
pa0 \
> >   -device virtio-net-pci,netdev=3Dvhost-vdpa0,page-per-vq=3Don \
> >
> > Author: Tiwei Bie
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/vhost_net.c                |  43 ++++
> >  hw/net/virtio-net.c               |   9 +
> >  hw/virtio/Makefile.objs           |   2 +-
> >  hw/virtio/vhost-backend.c         |   3 +
> >  hw/virtio/vhost-vdpa.c            | 379 ++++++++++++++++++++++++++++++
> >  hw/virtio/vhost.c                 |   5 +
> >  include/hw/virtio/vhost-backend.h |   6 +-
> >  include/hw/virtio/vhost-vdpa.h    |  14 ++
> >  8 files changed, 459 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/virtio/vhost-vdpa.c
> >  create mode 100644 include/hw/virtio/vhost-vdpa.h
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 4096d64aaf..0d13fda2fc 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -17,8 +17,10 @@
> >  #include "net/net.h"
> >  #include "net/tap.h"
> >  #include "net/vhost-user.h"
> > +#include "net/vhost-vdpa.h"
> >
> >  #include "standard-headers/linux/vhost_types.h"
> > +#include "linux-headers/linux/vhost.h"
> >  #include "hw/virtio/virtio-net.h"
> >  #include "net/vhost_net.h"
> >  #include "qemu/error-report.h"
> > @@ -85,6 +87,29 @@ static const int user_feature_bits[] =3D {
> >      VHOST_INVALID_FEATURE_BIT
> >  };
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
> >  static const int *vhost_net_get_feature_bits(struct vhost_net *net)
> >  {
> >      const int *feature_bits =3D 0;
> > @@ -96,6 +121,9 @@ static const int *vhost_net_get_feature_bits(struct =
vhost_net *net)
> >      case NET_CLIENT_DRIVER_VHOST_USER:
> >          feature_bits =3D user_feature_bits;
> >          break;
> > +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> > +        feature_bits =3D vdpa_feature_bits;
> > +        break;
> >      default:
> >          error_report("Feature bits not defined for this type: %d",
> >                  net->nc->info->type);
> > @@ -434,6 +462,10 @@ VHostNetState *get_vhost_net(NetClientState *nc)
> >          assert(vhost_net);
> >          break;
> >  #endif
> > +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> > +        vhost_net =3D vhost_vdpa_get_vhost_net(nc);
> > +        assert(vhost_net);
> > +        break;
> >      default:
> >          break;
> >      }
> > @@ -465,3 +497,14 @@ int vhost_net_set_mtu(struct vhost_net *net, uint1=
6_t mtu)
> >
> >      return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
> >  }
> > +int vhost_set_state(NetClientState *nc, int state)
> > +{
> > +    struct vhost_net *net =3D get_vhost_net(nc);
> > +    struct vhost_dev *hdev =3D &net->dev;
> > +    if (nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
>
> Maybe checking the vhost_set_state callback is implemented is enough,
> and it is not need to restrict that to Vhost-vDPA?
Sure, Will remove this

> > +        if (hdev->vhost_ops->vhost_set_state) {
> > +                return hdev->vhost_ops->vhost_set_state(hdev, state);
> > +             }
> > +        }
> > +    return 0;
> > +}
>


