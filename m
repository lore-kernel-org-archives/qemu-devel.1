Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6BCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D2020659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThbLA4LH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D2020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgLtC-0005Cz-Av
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 01:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jgLsI-0003sr-DP
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:23:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28823
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jgLsF-0001kQ-Tm
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591161813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2I4tHvcEO7NqBnP/O3OEdUGcsjC3c68S4+0wzc8hxB4=;
 b=ThbLA4LHa+oTMFJZP+nQeH+wR1Tw7mXOV2zbKiFxKBaNpw6lqCjo3tKGtyN662yueQbgaS
 WebUVjPf9oe/jz+D0LQ9Ce0mqpvcQYjoy+6PzrNGqLchoOPufHrSBqgm6c8cD9oObnImSj
 qqEW0UTZktDcyvi+xFKi/yArLFuezhw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-Y2PJVsZnMOOXBi5Re5PCpw-1; Wed, 03 Jun 2020 01:23:31 -0400
X-MC-Unique: Y2PJVsZnMOOXBi5Re5PCpw-1
Received: by mail-pg1-f200.google.com with SMTP id k124so1341661pgc.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 22:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2I4tHvcEO7NqBnP/O3OEdUGcsjC3c68S4+0wzc8hxB4=;
 b=GpqorPklNCcUQRLKnm60q2JjmnEPQhhwybTR2mYc2w1vQYb7xs87LxhpPOBGNPm/q5
 T5zanw4nH1dcsrL6U4quZymAcFPVgOCD/RzVB9o331I6AT/n6r/QzjB+XFkXP1nNnh1u
 +FcJFHSiU0tz6nqhxDsQ/YdqsEhDXtaKxu1gZWgDajLIwGw2gdYqhLvMpfSgonSNf6h4
 fNQh0Xe6iS3erH3Z/o+q01ngkr1C4vwum0+cVAZuVAtYi/08oGSaamJnIPTQUNm0KejN
 jMX4iv88S3a8J4KggpwgHuV/33+u/jsXj7Rrpob8qQ9YkUZzdiW6HuiaeqEU/X8e/8zs
 2jsw==
X-Gm-Message-State: AOAM533g5bAEY29/6jUHpyeiiZMcTTI5h3jOab2raBjt/Po0mBphPcXP
 mXJf0ivEBgfygBUpbHru68J1sebrflME3IPBchCFoxn/KFmXREpmx1DgYiV15t85o3ZhA03lObK
 iHGxU8W/xudhKU5Jd5Os7W/zaROCou9Y=
X-Received: by 2002:a17:902:8205:: with SMTP id
 x5mr28235571pln.12.1591161808627; 
 Tue, 02 Jun 2020 22:23:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8zFA68lhpOXMCxU37mAzjaBV0h+628TNhVz/aup1hU0Ac5vPqZiqmUA5H+d2CyQ97Vv/49Ty7+r16YYCwLcM=
X-Received: by 2002:a17:902:8205:: with SMTP id
 x5mr28235528pln.12.1591161807951; 
 Tue, 02 Jun 2020 22:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-8-lulu@redhat.com>
 <3c785bbf-1124-db4e-fd28-dfe57a770aaf@redhat.com>
In-Reply-To: <3c785bbf-1124-db4e-fd28-dfe57a770aaf@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 3 Jun 2020 13:23:16 +0800
Message-ID: <CACLfguU3_W_p+LaCzKA_T5A1mTfDZCu8VMJ4LskFEdU5=Db17A@mail.gmail.com>
Subject: Re: [RFC v3 7/8] vhost-vdpa: introduce vhost-vdpa backend
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
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

Hi Jason,

On Wed, Jun 3, 2020 at 10:52 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/5/29 =E4=B8=8B=E5=8D=8810:06, Cindy Lu wrote:
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
> > ---
> >   configure                         |  21 ++
> >   hw/net/vhost_net-stub.c           |   5 +
> >   hw/net/vhost_net.c                |  47 +++-
> >   hw/virtio/Makefile.objs           |   1 +
> >   hw/virtio/vhost-backend.c         |   5 +
> >   hw/virtio/vhost-vdpa.c            | 399 +++++++++++++++++++++++++++++=
+
> >   hw/virtio/vhost.c                 |  37 ++-
> >   include/hw/virtio/vhost-backend.h |  10 +-
> >   include/hw/virtio/vhost-vdpa.h    |  26 ++
> >   include/hw/virtio/vhost.h         |   2 +
> >   include/net/vhost_net.h           |   4 +-
> >   qemu-options.hx                   |  15 ++
> >   12 files changed, 566 insertions(+), 6 deletions(-)
> >   create mode 100644 hw/virtio/vhost-vdpa.c
> >   create mode 100644 include/hw/virtio/vhost-vdpa.h
> >
> > diff --git a/configure b/configure
> > index 23b5e93752..53679ee57f 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1557,6 +1557,10 @@ for opt do
> >     ;;
> >     --enable-vhost-user) vhost_user=3D"yes"
> >     ;;
> > +  --disable-vhost-vdpa) vhost_vdpa=3D"no"
> > +  ;;
> > +  --enable-vhost-vdpa) vhost_vdpa=3D"yes"
> > +  ;;
> >     --disable-vhost-kernel) vhost_kernel=3D"no"
> >     ;;
> >     --enable-vhost-kernel) vhost_kernel=3D"yes"
> > @@ -1846,6 +1850,7 @@ disabled with --disable-FEATURE, default is enabl=
ed if available:
> >     vhost-crypto    vhost-user-crypto backend support
> >     vhost-kernel    vhost kernel backend support
> >     vhost-user      vhost-user backend support
> > +  vhost-vdpa      vhost-vdpa kernel backend support
> >     spice           spice
> >     rbd             rados block device (rbd)
> >     libiscsi        iscsi support
> > @@ -2336,6 +2341,10 @@ test "$vhost_user" =3D "" && vhost_user=3Dyes
> >   if test "$vhost_user" =3D "yes" && test "$mingw32" =3D "yes"; then
> >     error_exit "vhost-user isn't available on win32"
> >   fi
> > +test "$vhost_vdpa" =3D "" && vhost_vdpa=3D$linux
> > +if test "$vhost_vdpa" =3D "yes" && test "$linux" !=3D "yes"; then
> > +  error_exit "vhost-vdpa is only available on Linux"
> > +fi
> >   test "$vhost_kernel" =3D "" && vhost_kernel=3D$linux
> >   if test "$vhost_kernel" =3D "yes" && test "$linux" !=3D "yes"; then
> >     error_exit "vhost-kernel is only available on Linux"
> > @@ -2364,6 +2373,11 @@ test "$vhost_user_fs" =3D "" && vhost_user_fs=3D=
$vhost_user
> >   if test "$vhost_user_fs" =3D "yes" && test "$vhost_user" =3D "no"; th=
en
> >     error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
> >   fi
> > +#vhost-vdpa backends
> > +test "$vhost_net_vdpa" =3D "" && vhost_net_vdpa=3D$vhost_vdpa
> > +if test "$vhost_net_vdpa" =3D "yes" && test "$vhost_vdpa" =3D "no"; th=
en
> > +  error_exit "--enable-vhost-net-vdpa requires --enable-vhost-vdpa"
> > +fi
> >
> >   # OR the vhost-kernel and vhost-user values for simplicity
> >   if test "$vhost_net" =3D ""; then
> > @@ -6673,6 +6687,7 @@ echo "vhost-scsi support $vhost_scsi"
> >   echo "vhost-vsock support $vhost_vsock"
> >   echo "vhost-user support $vhost_user"
> >   echo "vhost-user-fs support $vhost_user_fs"
> > +echo "vhost-vdpa support $vhost_vdpa"
> >   echo "Trace backends    $trace_backends"
> >   if have_backend "simple"; then
> >   echo "Trace output file $trace_file-<pid>"
> > @@ -7170,6 +7185,9 @@ fi
> >   if test "$vhost_net_user" =3D "yes" ; then
> >     echo "CONFIG_VHOST_NET_USER=3Dy" >> $config_host_mak
> >   fi
> > +if test "$vhost_net_vdpa" =3D "yes" ; then
> > +  echo "CONFIG_VHOST_NET_VDPA=3Dy" >> $config_host_mak
> > +fi
> >   if test "$vhost_crypto" =3D "yes" ; then
> >     echo "CONFIG_VHOST_CRYPTO=3Dy" >> $config_host_mak
> >   fi
> > @@ -7182,6 +7200,9 @@ fi
> >   if test "$vhost_user" =3D "yes" ; then
> >     echo "CONFIG_VHOST_USER=3Dy" >> $config_host_mak
> >   fi
> > +if test "$vhost_vdpa" =3D "yes" ; then
> > +  echo "CONFIG_VHOST_VDPA=3Dy" >> $config_host_mak
> > +fi
> >   if test "$vhost_user_fs" =3D "yes" ; then
> >     echo "CONFIG_VHOST_USER_FS=3Dy" >> $config_host_mak
> >   fi
> > diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
> > index 43e93e1a9a..ab77a92a7d 100644
> > --- a/hw/net/vhost_net-stub.c
> > +++ b/hw/net/vhost_net-stub.c
> > @@ -94,3 +94,8 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t=
 mtu)
> >   {
> >       return 0;
> >   }
> > +int vhost_net_get_device_id(struct vhost_net *net, uint32_t * device_i=
d)
> > +{
> > +    return 0;
> > +}
> > +
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index e2bc7de2eb..25045cff59 100644
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
> > @@ -85,6 +87,30 @@ static const int user_feature_bits[] =3D {
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
> > +    VIRTIO_F_RING_PACKED,
> > +    VIRTIO_NET_F_GUEST_ANNOUNCE,
> > +    VHOST_INVALID_FEATURE_BIT
> > +};
>
>
> I think those feature bits should belong to net/vhost-vdpa.c, since it
> contains bits that are net specific.
>
Sure will move these.
>
> >   static const int *vhost_net_get_feature_bits(struct vhost_net *net)
> >   {
> >       const int *feature_bits =3D 0;
> > @@ -96,6 +122,9 @@ static const int *vhost_net_get_feature_bits(struct =
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
> > @@ -110,7 +139,10 @@ uint64_t vhost_net_get_features(struct vhost_net *=
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
> > @@ -337,6 +369,11 @@ int vhost_net_start(VirtIODevice *dev, NetClientSt=
ate *ncs,
> >       }
> >
> >       for (i =3D 0; i < total_queues; i++) {
> > +
> > +        if (virtio_queue_enabled(dev, i)) {
> > +            vhost_set_vring_ready(peer);
> > +        }
>
>
> So this may break vpda_sim since it call set_vq_ready() before
> set_vring_addr.
>
> I think maybe it's better not introduce vhost_set_vring_ready() but
> enable virtqueue in vhost_vdpa_set_state() before setting DRIVER_OK.
>
>
will fix this
> > +
> >           peer =3D qemu_get_peer(ncs, i);
> >           r =3D vhost_net_start_one(get_vhost_net(peer), dev);
> >
> > @@ -433,6 +470,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
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
> > @@ -474,3 +517,5 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16=
_t mtu)
> >
> >       return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
> >   }
> > +
> > +
>
>
> One extra newline.
>
will fix this
>
> > diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> > index 4e4d39a0a4..6b1b1a5fce 100644
> > --- a/hw/virtio/Makefile.objs
> > +++ b/hw/virtio/Makefile.objs
> > @@ -5,6 +5,7 @@ obj-y +=3D virtio.o
> >   obj-$(CONFIG_VHOST) +=3D vhost.o vhost-backend.o
> >   common-obj-$(call lnot,$(CONFIG_VHOST)) +=3D vhost-stub.o
> >   obj-$(CONFIG_VHOST_USER) +=3D vhost-user.o
> > +obj-$(CONFIG_VHOST_VDPA) +=3D vhost-vdpa.o
> >
> >   common-obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng.o
> >   common-obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-pci.o
> > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > index 42efb4967b..420341e8c5 100644
> > --- a/hw/virtio/vhost-backend.c
> > +++ b/hw/virtio/vhost-backend.c
> > @@ -291,6 +291,11 @@ int vhost_set_backend_type(struct vhost_dev *dev, =
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
> > index 0000000000..2d136a8565
> > --- /dev/null
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -0,0 +1,399 @@
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
>
>
> newline is needed here.
>
will fix this
>
> > +/* Register a new memory listener, only to get diffs from qemu,
> > + * this help to reduce the tricky codes in vhost
> > + * (e.g generating diffs of two rbtree as usnic did).*/
>
>
> This comment needs some improvement. How about:
>
> /* IOTLB API is used by vhost-vpda which requires incremental updating
> of the mapping. So we can not use generic vhost memory listener which
> depends on the addnop(). */
>
>
> > +static const MemoryListener vhost_vdpa_memory_listener =3D {
> > +    .region_add =3D vhost_vdpa_listener_region_add,
> > +    .region_del =3D vhost_vdpa_listener_region_del,
> > +};
> > +
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
> > +static void vhost_vdpa_add_status(struct vhost_dev *dev, uint8_t statu=
s)
> > +{
> > +    uint8_t s;
> > +
> > +    if (vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &s)) {
> > +        return;
> > +    }
> > +
> > +    s |=3D status;
> > +
> > +    vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &s);
> > +}
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
> > +    v->msg_type =3D VHOST_IOTLB_MSG_V2;
> > +    memory_listener_register(&v->listener, &address_space_memory);
>
>
> Let's move the memory listener register/unregister to
> vhost_vdpa_set_state(). Then we can avoid lots of unnecessary vhost
> IOTLB transactions before DRIVER_OK which vhost-vDPA doesn't care.
>
>
sure will move this

> > +
> > +    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > +                               VIRTIO_CONFIG_S_DRIVER);
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
> > +static int vhost_vdpa_memslots_limit(struct vhost_dev *dev)
> > +{
> > +    return INT_MAX;
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
> > +static int vhost_vdpa_set_features(struct vhost_dev *dev,
> > +                                   uint64_t features)
> > +{
> > +    int ret =3D vhost_vdpa_call(dev, VHOST_SET_FEATURES, &features);
> > +    uint8_t status =3D 0;
> > +
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
> > +    vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &status);
> > +
> > +    return !(status & VIRTIO_CONFIG_S_FEATURES_OK);
> > +}
> > +
> > +int vhost_vdpa_get_device_id(struct vhost_dev *dev,
> > +                                   uint32_t *device_id)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_VDPA_GET_DEVICE_ID, device_id);
> > +}
> > +
> > +static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> > +{
> > +    uint8_t status =3D 0;
> > +
> > +    return vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
> > +}
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
> > +
> > +static int vhost_vdpa_set_config(struct vhost_dev *dev, const uint8_t =
*data,
> > +                                   uint32_t offset, uint32_t size,
> > +                                   uint32_t flags)
> > +{
> > +    struct vhost_vdpa_config config;
> > +    int ret;
> > +    if ((size > VHOST_VDPA_MAX_CONFIG_SIZE) || (data =3D=3D NULL)) {
> > +        return -1;
> > +    }
> > +    memset(&config, 0, sizeof(struct vhost_vdpa_config));
> > +    config.off =3D 0;
> > +    config.len =3D size;
> > +    memcpy(&config.buf, data, size);
> > +    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_CONFIG, &config);
> > +    return ret;
> > +}
> > +
> > +static int vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *confi=
g,
> > +                                   uint32_t config_len)
> > +{
> > +    struct vhost_vdpa_config v_config;
> > +    int ret;
> > +
> > +    memset(&v_config, 0, sizeof(struct vhost_vdpa_config));
> > +    if (config =3D=3D NULL) {
> > +        return -1;
> > +    }
> > +    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_GET_CONFIG, &v_config);
> > +    if ((v_config.len > config_len) || (v_config.len =3D=3D 0)) {
> > +        return -EINVAL;
> > +    }
> > +    memcpy(config, &v_config.buf, config_len);
> > +    return ret;
> > + }
> > +
> > +static int vhost_vdpa_set_state(struct vhost_dev *dev, bool started)
>
>
> We probably need a better name, e.g vhost_vdpa_start()?
>
>
will fix this
> > +{
> > +    if (started) {
> > +        uint8_t status =3D 0;
> > +
> > +        vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> > +        vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &status);
> > +
> > +        return !(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > +    } else {
> > +        vhost_vdpa_reset_device(dev);
> > +        vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > +                                   VIRTIO_CONFIG_S_DRIVER);
> > +        return 0;
> > +    }
> > +}
> > +
> > +const VhostOps vdpa_ops =3D {
> > +        .backend_type =3D VHOST_BACKEND_TYPE_VDPA,
> > +        .vhost_backend_init =3D vhost_vdpa_init,
> > +        .vhost_backend_cleanup =3D vhost_vdpa_cleanup,
> > +        .vhost_set_log_base =3D vhost_kernel_set_log_base,
> > +        .vhost_set_vring_addr =3D vhost_kernel_set_vring_addr,
> > +        .vhost_set_vring_num =3D vhost_kernel_set_vring_num,
> > +        .vhost_set_vring_base =3D vhost_kernel_set_vring_base,
> > +        .vhost_get_vring_base =3D vhost_kernel_get_vring_base,
> > +        .vhost_set_vring_kick =3D vhost_kernel_set_vring_kick,
> > +        .vhost_set_vring_call =3D vhost_kernel_set_vring_call,
> > +        .vhost_get_features =3D vhost_kernel_get_features,
> > +        .vhost_set_owner =3D vhost_kernel_set_owner,
> > +        .vhost_set_vring_endian =3D NULL,
> > +        .vhost_backend_memslots_limit =3D vhost_vdpa_memslots_limit,
> > +        .vhost_set_mem_table =3D vhost_vdpa_set_mem_table,
> > +        .vhost_set_features =3D vhost_vdpa_set_features,
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
>
>
> Since it only accept boolean parameter I guess vhost_dev_start() is bette=
r?
>
will fix this
>
> > +        .vhost_get_device_id =3D vhost_vdpa_get_device_id,
> > +};
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 01ebe12f28..b97aa02a4c 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -756,6 +756,12 @@ static int vhost_virtqueue_set_addr(struct vhost_d=
ev *dev,
> >           .log_guest_addr =3D vq->used_phys,
> >           .flags =3D enable_log ? (1 << VHOST_VRING_F_LOG) : 0,
> >       };
> > +    /*vDPA need to use the phys address here to set to hardware*/
>
>
> Actually it's "IOVA" instead of "phys address".
>
>
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
> Let's introduce a callback here instead of such hard-coded ones.
>
will fix this
>
> >       int r =3D dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
> >       if (r < 0) {
> >           VHOST_OPS_DEBUG("vhost_set_vring_addr failed");
> > @@ -1506,6 +1512,14 @@ int vhost_dev_set_config(struct vhost_dev *hdev,=
 const uint8_t *data,
> >       return -1;
> >   }
> >
> > +int vhost_dev_get_device_id(struct vhost_dev *hdev, uint32_t *device_i=
d)
> > +{
> > +    assert(hdev->vhost_ops);
> > +    if (hdev->vhost_ops->vhost_get_device_id) {
> > +        return hdev->vhost_ops->vhost_get_device_id(hdev, device_id);
> > +    }
> > +    return -1;
> > +}
> >   void vhost_dev_set_config_notifier(struct vhost_dev *hdev,
> >                                      const VhostDevConfigOps *ops)
> >   {
> > @@ -1661,7 +1675,13 @@ int vhost_dev_start(struct vhost_dev *hdev, Virt=
IODevice *vdev)
> >           }
> >       }
> >
> > -    if (vhost_dev_has_iommu(hdev)) {
> > +    r =3D vhost_set_state(hdev, true);
> > +    if (r) {
> > +        goto fail_log;
> > +    }
>
>
> Please use a separate patch for introducing vhost_set_state().
>
will fix this
>
> > +
> > +    if (vhost_dev_has_iommu(hdev) &&
> > +        hdev->vhost_ops->vhost_set_iotlb_callback) {
>
>
> A new patch for checking vhost_set_iotlb_callback(), or just implement
> it for vhost-vpda that just warn about IOTLB miss.
>
>
> >           hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
> >
> >           /* Update used ring information for IOTLB to work correctly,
> > @@ -1697,6 +1717,8 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtI=
ODevice *vdev)
> >       /* should only be called after backend is connected */
> >       assert(hdev->vhost_ops);
> >
> > +    vhost_set_state(hdev, false);
> > +
> >       for (i =3D 0; i < hdev->nvqs; ++i) {
> >           vhost_virtqueue_stop(hdev,
> >                                vdev,
> > @@ -1705,7 +1727,9 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtI=
ODevice *vdev)
> >       }
> >
> >       if (vhost_dev_has_iommu(hdev)) {
> > -        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
> > +        if (hdev->vhost_ops->vhost_set_iotlb_callback) {
> > +            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
> > +        }
> >           memory_listener_unregister(&hdev->iommu_listener);
> >       }
> >       vhost_log_put(hdev, true);
> > @@ -1722,3 +1746,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev=
,
> >
> >       return -1;
> >   }
> > +
> > +int vhost_set_state(struct vhost_dev *hdev, bool started)
> > +{
> > +    if (hdev->vhost_ops->vhost_set_state) {
> > +        return hdev->vhost_ops->vhost_set_state(hdev, started);
> > +    }
> > +
> > +    return 0;
> > +}
> > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhos=
t-backend.h
> > index 300b59c172..1ebe3785cf 100644
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
> >   typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
> >   typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
> >                                          char *mac_addr);
> > @@ -112,6 +114,8 @@ typedef int (*vhost_get_inflight_fd_op)(struct vhos=
t_dev *dev,
> >   typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
> >                                           struct vhost_inflight *inflig=
ht);
> >
> > +typedef int (*vhost_set_state_op)(struct vhost_dev *dev, bool started)=
;
> > +typedef int (*vhost_get_device_id_op)(struct vhost_dev *dev, uint32_t =
*dev_id);
> >   typedef struct VhostOps {
> >       VhostBackendType backend_type;
> >       vhost_backend_init vhost_backend_init;
> > @@ -138,6 +142,7 @@ typedef struct VhostOps {
> >       vhost_reset_device_op vhost_reset_device;
> >       vhost_get_vq_index_op vhost_get_vq_index;
> >       vhost_set_vring_enable_op vhost_set_vring_enable;
> > +    vhost_set_vring_ready_op vhost_set_vring_ready;
> >       vhost_requires_shm_log_op vhost_requires_shm_log;
> >       vhost_migration_done_op vhost_migration_done;
> >       vhost_backend_can_merge_op vhost_backend_can_merge;
> > @@ -152,9 +157,12 @@ typedef struct VhostOps {
> >       vhost_backend_mem_section_filter_op vhost_backend_mem_section_fil=
ter;
> >       vhost_get_inflight_fd_op vhost_get_inflight_fd;
> >       vhost_set_inflight_fd_op vhost_set_inflight_fd;
> > +    vhost_set_state_op vhost_set_state;
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
> > index 0000000000..6455663388
> > --- /dev/null
> > +++ b/include/hw/virtio/vhost-vdpa.h
> > @@ -0,0 +1,26 @@
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
> > +extern int vhost_vdpa_get_device_id(struct vhost_dev *dev,
> > +                                   uint32_t *device_id);
> > +#endif
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 085450c6f8..b682545f51 100644
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
> > @@ -137,4 +138,5 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
> >                              struct vhost_inflight *inflight);
> >   int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size=
,
> >                              struct vhost_inflight *inflight);
> > +int vhost_set_state(struct vhost_dev *dev, bool started);
> >   #endif
> > diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> > index 8a6f208189..56e67fe164 100644
> > --- a/include/net/vhost_net.h
> > +++ b/include/net/vhost_net.h
> > @@ -40,5 +40,5 @@ int vhost_set_vring_ready(NetClientState *nc);
> >   uint64_t vhost_net_get_acked_features(VHostNetState *net);
> >
> >   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
> > -
> > -#endif
> > +int vhost_net_get_device_id(struct vhost_net *net, uint32_t *device_id=
);
>
>
> This should belong to vhost-vdpa header.
>
> Thanks
>
will fix this
>
> > +endif
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 292d4e7c0c..c19e10ce9c 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -2409,6 +2409,10 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
> >   #ifdef CONFIG_POSIX
> >       "-netdev vhost-user,id=3Dstr,chardev=3Ddev[,vhostforce=3Don|off]\=
n"
> >       "                configure a vhost-user network, backed by a char=
dev 'dev'\n"
> > +#endif
> > +#ifdef CONFIG_POSIX
> > +    "-netdev vhost-vdpa,id=3Dstr,vhostdev=3D/path/to/dev\n"
> > +    "                configure a vhost-vdpa network,Establish a vhost-=
vdpa netdev\n"
> >   #endif
> >       "-netdev hubport,id=3Dstr,hubid=3Dn[,netdev=3Dnd]\n"
> >       "                configure a hub port on the hub with ID 'n'\n", =
QEMU_ARCH_ALL)
> > @@ -2428,6 +2432,9 @@ DEF("nic", HAS_ARG, QEMU_OPTION_nic,
> >   #endif
> >   #ifdef CONFIG_POSIX
> >       "vhost-user|"
> > +#endif
> > +#ifdef CONFIG_POSIX
> > +    "vhost-vdpa|"
> >   #endif
> >       "socket][,option][,...][mac=3Dmacaddr]\n"
> >       "                initialize an on-board / default host NIC (using=
 MAC address\n"
> > @@ -2896,6 +2903,14 @@ SRST
> >       hubport to another netdev with ID nd by using the ``netdev=3Dnd``
> >       option.
> >
> > +``-netdev vhost-vdpa,vhostdev=3D/path/to/dev ``
> > +    Establish a vhost-vdpa netdev.
> > +
> > +    vDPA device is a device that uses a datapath which complies with
> > +    the virtio specifications with a vendor specific control path.
> > +    vDPA devices can be both physically located on the hardware or
> > +    emulated by software.
> > +
> >   ``-net nic[,netdev=3Dnd][,macaddr=3Dmac][,model=3Dtype] [,name=3Dname=
][,addr=3Daddr][,vectors=3Dv]``
> >       Legacy option to configure or create an on-board (or machine
> >       default) Network Interface Card(NIC) and connect it either to the
>


