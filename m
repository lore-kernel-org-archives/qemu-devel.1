Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF63C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A36B20722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObQSiFgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A36B20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqYt8-0005It-Ln
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 05:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqYsK-0004rc-KD
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:17:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58672
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqYsH-0003oi-4v
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593595068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WmR1m6AtHXy1krtH/BQk9OOHAko2FlQKf84r+AaCNzA=;
 b=ObQSiFgFLcDy9BUHF/y0UZQBQ922mUKbG1Ofgem6vB/5Odhi2euze/5Ezga6DHONHhWghF
 3a8giDJSaruwqqEw7PIbHJD7Di9+EgE6f4wYJOPFaXZIdPhjPUSP56MSlK/P/m8emLc36V
 TUD2GX9avGfLYFs0fpJxBrA21c/bqSs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-43Gwt2OhN9SwsoUxZVe9fQ-1; Wed, 01 Jul 2020 05:17:44 -0400
X-MC-Unique: 43Gwt2OhN9SwsoUxZVe9fQ-1
Received: by mail-pl1-f199.google.com with SMTP id 31so13864819plc.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 02:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WmR1m6AtHXy1krtH/BQk9OOHAko2FlQKf84r+AaCNzA=;
 b=QZSkQ7lzm5ztfIUAPfy6J2ga0Ux3stFqr8JdZIjY79HIfKwaSEqR16Vf9vp3sglVyX
 Zy9pKUXImuWRnBgjeu5qlFtwy6nMp8gOfGuS+dk6lFRz8XVfr3G28obQkCbLzYnSv7Fm
 q7wTGTkBujF9+xWToa6hYnW3vqaaI2EN+mmXRaZ/MVf82tdS4NY1YmrT6F3GW7v09kWT
 F7Rg4hqbaftC9ylIL15WObXsMWgFQp25iYYvP/Kfct1ChU1S98m1kylmxVYsTonvFpeo
 PNMZSsWK2lnSbHJUkLn/sGZf7dlVOUnvzgGVTiwUsV4Tdl4+KWX+SYOBl1dIFJzyatEp
 s+qA==
X-Gm-Message-State: AOAM531jgM0zkyAzAszaWkli19jI4HLLnowjvKdnIBWY/T9YNXAzYNhB
 vsZGr9h+zzRjCZOkz8jrIamDJtJNlzG1EoFVk3rZ1fgugCNUy3t/8g9CUHRAZ7ee5jWuzi+YKS9
 4YLFez5BJLygoMRZC+4Cjac6mkpFxfuc=
X-Received: by 2002:a17:90a:1d06:: with SMTP id
 c6mr11096075pjd.194.1593595062608; 
 Wed, 01 Jul 2020 02:17:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxECal8ZClrHCFCwt5Fsb+lF7Y+ochedQUc8BmasLBtFVDgxgvcJaFZMig2cogAFr1HGbBQGfxbA82H4oMQPOw=
X-Received: by 2002:a17:90a:1d06:: with SMTP id
 c6mr11096031pjd.194.1593595062018; 
 Wed, 01 Jul 2020 02:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200630174937.25560-1-lulu@redhat.com>
 <20200630174937.25560-12-lulu@redhat.com>
 <88395b35-1053-f470-0031-1b7b89dcc6b8@redhat.com>
In-Reply-To: <88395b35-1053-f470-0031-1b7b89dcc6b8@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 1 Jul 2020 17:17:30 +0800
Message-ID: <CACLfguVDRbhyY-Po+pGScgawY-3TDSSQdRH9Sy0NDovD7txxSg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] vhost-vdpa: introduce vhost-vdpa backend
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, rdunlap@infradead.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Jason, will fix all these and send the new version soon

On Wed, Jul 1, 2020 at 12:22 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/7/1 =E4=B8=8A=E5=8D=881:49, Cindy Lu wrote:
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
> > qemu-system-x86_64 -cpu host -enable-kvm \
> >      ......
> >      -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-id,id=3Dvhost=
-vdpa0 \
> >      -device virtio-net-pci,netdev=3Dvhost-vdpa0,page-per-vq=3Don \
> >
> > Signed-off-by: Lingshan zhu <lingshan.zhu@intel.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>
>
> I would like to add my sob here.
>
>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   configure                         |  21 ++
> >   docs/interop/index.rst            |   1 +
> >   docs/interop/vhost-vdpa.rst       |  17 ++
> >   hw/net/vhost_net.c                |  19 +-
> >   hw/net/virtio-net.c               |  22 +-
> >   hw/virtio/Makefile.objs           |   1 +
> >   hw/virtio/vhost-backend.c         |   7 +-
> >   hw/virtio/vhost-vdpa.c            | 469 +++++++++++++++++++++++++++++=
+
> >   hw/virtio/vhost.c                 |   7 +-
> >   include/hw/virtio/vhost-backend.h |   4 +-
> >   include/hw/virtio/vhost-vdpa.h    |  26 ++
> >   include/hw/virtio/vhost.h         |   7 +
> >   qemu-options.hx                   |  12 +
> >   13 files changed, 601 insertions(+), 12 deletions(-)
> >   create mode 100644 docs/interop/vhost-vdpa.rst
> >   create mode 100644 hw/virtio/vhost-vdpa.c
> >   create mode 100644 include/hw/virtio/vhost-vdpa.h
> >
> > diff --git a/configure b/configure
> > index 4a22dcd563..3db7f20185 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1575,6 +1575,10 @@ for opt do
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
> > @@ -1883,6 +1887,7 @@ disabled with --disable-FEATURE, default is enabl=
ed if available:
> >     vhost-crypto    vhost-user-crypto backend support
> >     vhost-kernel    vhost kernel backend support
> >     vhost-user      vhost-user backend support
> > +  vhost-vdpa      vhost-vdpa kernel backend support
> >     spice           spice
> >     rbd             rados block device (rbd)
> >     libiscsi        iscsi support
> > @@ -2394,6 +2399,10 @@ test "$vhost_user" =3D "" && vhost_user=3Dyes
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
> > @@ -2422,6 +2431,11 @@ test "$vhost_user_fs" =3D "" && vhost_user_fs=3D=
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
> > @@ -6936,6 +6950,7 @@ echo "vhost-scsi support $vhost_scsi"
> >   echo "vhost-vsock support $vhost_vsock"
> >   echo "vhost-user support $vhost_user"
> >   echo "vhost-user-fs support $vhost_user_fs"
> > +echo "vhost-vdpa support $vhost_vdpa"
> >   echo "Trace backends    $trace_backends"
> >   if have_backend "simple"; then
> >   echo "Trace output file $trace_file-<pid>"
> > @@ -7437,6 +7452,9 @@ fi
> >   if test "$vhost_net_user" =3D "yes" ; then
> >     echo "CONFIG_VHOST_NET_USER=3Dy" >> $config_host_mak
> >   fi
> > +if test "$vhost_net_vdpa" =3D "yes" ; then
> > +  echo "CONFIG_VHOST_NET_VDPA=3Dy" >> $config_host_mak
> > +fi
> >   if test "$vhost_crypto" =3D "yes" ; then
> >     echo "CONFIG_VHOST_CRYPTO=3Dy" >> $config_host_mak
> >   fi
> > @@ -7452,6 +7470,9 @@ fi
> >   if test "$vhost_user" =3D "yes" ; then
> >     echo "CONFIG_VHOST_USER=3Dy" >> $config_host_mak
> >   fi
> > +if test "$vhost_vdpa" =3D "yes" ; then
> > +  echo "CONFIG_VHOST_VDPA=3Dy" >> $config_host_mak
> > +fi
> >   if test "$vhost_user_fs" =3D "yes" ; then
> >     echo "CONFIG_VHOST_USER_FS=3Dy" >> $config_host_mak
> >   fi
> > diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> > index 049387ac6d..006f986420 100644
> > --- a/docs/interop/index.rst
> > +++ b/docs/interop/index.rst
> > @@ -20,3 +20,4 @@ Contents:
> >      qemu-ga
> >      vhost-user
> >      vhost-user-gpu
> > +   vhost-vdpa
> > diff --git a/docs/interop/vhost-vdpa.rst b/docs/interop/vhost-vdpa.rst
> > new file mode 100644
> > index 0000000000..5a075b8a63
> > --- /dev/null
> > +++ b/docs/interop/vhost-vdpa.rst
> > @@ -0,0 +1,17 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Vhost-vdpa Protocol
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +vDPA(Virtual data path acceleration) device is a device that uses
> > +a datapath which complies with the virtio specifications with vendor
> > +specific control path. vDPA devices can be both physically located on
> > +the hardware or emulated by software.
> > +
> > +This document describes the vDPA support in qemu
> > +
> > +Here is the kernel commit here
> > +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D4c8cf31885f69e86be0b5b9e6677a26797365e1d
> > +
> > +TODO : Moreinfo will add later
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 4096d64aaf..cbdf42ace5 100644
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
> > @@ -33,12 +35,6 @@
> >   #include "hw/virtio/vhost.h"
> >   #include "hw/virtio/virtio-bus.h"
> >
> > -struct vhost_net {
> > -    struct vhost_dev dev;
> > -    struct vhost_virtqueue vqs[2];
> > -    int backend;
> > -    NetClientState *nc;
> > -};
> >
> >   /* Features supported by host kernel. */
> >   static const int kernel_feature_bits[] =3D {
> > @@ -96,6 +92,9 @@ static const int *vhost_net_get_feature_bits(struct v=
host_net *net)
> >       case NET_CLIENT_DRIVER_VHOST_USER:
> >           feature_bits =3D user_feature_bits;
> >           break;
> > +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> > +        feature_bits =3D vdpa_feature_bits;
> > +        break;
> >       default:
> >           error_report("Feature bits not defined for this type: %d",
> >                   net->nc->info->type);
> > @@ -316,7 +315,6 @@ int vhost_net_start(VirtIODevice *dev, NetClientSta=
te *ncs,
> >       }
> >
> >       for (i =3D 0; i < total_queues; i++) {
> > -
>
>
> Unnecessary change.
>
>
> >           peer =3D qemu_get_peer(ncs, i);
> >           net =3D get_vhost_net(peer);
> >           vhost_net_set_vq_index(net, i * 2);
> > @@ -337,6 +335,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientSta=
te *ncs,
> >       }
> >
> >       for (i =3D 0; i < total_queues; i++) {
> > +
>
>
> Unnecessary change.
>
>
> >           peer =3D qemu_get_peer(ncs, i);
> >           r =3D vhost_net_start_one(get_vhost_net(peer), dev);
> >
> > @@ -433,6 +432,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
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
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index aff67a92df..6aadc2403a 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -43,6 +43,7 @@
> >   #include "monitor/qdev.h"
> >   #include "hw/pci/pci.h"
> >   #include "net_rx_pkt.h"
> > +#include "hw/virtio/vhost.h"
> >
> >   #define VIRTIO_NET_VM_VERSION    11
> >
> > @@ -124,7 +125,10 @@ static void virtio_net_get_config(VirtIODevice *vd=
ev, uint8_t *config)
> >   {
> >       VirtIONet *n =3D VIRTIO_NET(vdev);
> >       struct virtio_net_config netcfg;
> > +    int ret =3D 0;
> > +    struct vhost_dev *hdev =3D NULL;
> >
> > +    memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> >       virtio_stw_p(vdev, &netcfg.status, n->status);
> >       virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
> >       virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
> > @@ -138,21 +142,37 @@ static void virtio_net_get_config(VirtIODevice *v=
dev, uint8_t *config)
> >       virtio_stl_p(vdev, &netcfg.supported_hash_types,
> >                    VIRTIO_NET_RSS_SUPPORTED_HASHES);
> >       memcpy(config, &netcfg, n->config_size);
> > +
> > +    NetClientState *nc =3D qemu_get_queue(n->nic);
> > +    if (nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
> > +        hdev =3D &(get_vhost_net(nc->peer)->dev);
> > +        ret =3D vhost_dev_get_config(hdev, (uint8_t *)&netcfg, n->conf=
ig_size);
> > +            if (ret !=3D -1) {
> > +                memcpy(config, &netcfg, n->config_size);
> > +        }
> > +    }
> >   }
> >
> >   static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *=
config)
> >   {
> >       VirtIONet *n =3D VIRTIO_NET(vdev);
> >       struct virtio_net_config netcfg =3D {};
> > +    struct vhost_dev *hdev =3D NULL;
> >
> >       memcpy(&netcfg, config, n->config_size);
> > -
>
>
> Unnecessary change.
>
>
> >       if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR) &&
> >           !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> >           memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
> >           memcpy(n->mac, netcfg.mac, ETH_ALEN);
> >           qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
> >       }
> > +
> > +    NetClientState *nc =3D qemu_get_queue(n->nic);
> > +    if (nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
> > +        hdev =3D &(get_vhost_net(nc->peer)->dev);
> > +        vhost_dev_set_config(hdev, (uint8_t *)&netcfg, 0, n->config_si=
ze,
> > +                        VHOST_SET_CONFIG_TYPE_MASTER);
> > +    }
> >   }
> >
> >   static bool virtio_net_started(VirtIONet *n, uint8_t status)
> > diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> > index 13e75f171f..2b31e9b3dc 100644
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
> > index 48905383f8..b925a2b1ac 100644
> > --- a/hw/virtio/vhost-backend.c
> > +++ b/hw/virtio/vhost-backend.c
> > @@ -14,7 +14,7 @@
> >   #include "qemu/error-report.h"
> >   #include "qemu/main-loop.h"
> >   #include "standard-headers/linux/vhost_types.h"
> > -
> > +#include "hw/virtio/vhost-vdpa.h"
>
>
> Let's keep the newline here.
>
>
> >   #ifdef CONFIG_VHOST_KERNEL
> >   #include <linux/vhost.h>
> >   #include <sys/ioctl.h>
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
> > index 0000000000..25c9b537b0
> > --- /dev/null
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -0,0 +1,469 @@
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
> > +    msg.type =3D v->msg_type;
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
> > +    msg.type =3D v->msg_type;
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
> > +/*
> > + * IOTLB API is used by vhost-vpda which requires incremental updating
> > + * of the mapping. So we can not use generic vhost memory listener whi=
ch
> > + * depends on the addnop().
> > + */
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
> > +    uint64_t features;
> > +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA=
);
> > +
> > +    v =3D opaque;
> > +    dev->opaque =3D  opaque ;
> > +    vhost_vdpa_call(dev, VHOST_GET_FEATURES, &features);
> > +    dev->backend_features =3D features;
> > +    v->listener =3D vhost_vdpa_memory_listener;
> > +    v->msg_type =3D VHOST_IOTLB_MSG_V2;
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
> > +    int ret;
> > +    ret =3D vhost_vdpa_call(dev, VHOST_SET_FEATURES, &features);
> > +    uint8_t status =3D 0;
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
> > +    struct vhost_vdpa_config *config;
> > +    int ret;
> > +    unsigned long config_size =3D offsetof(struct vhost_vdpa_config, b=
uf);
> > +    config =3D g_malloc(size + config_size);
> > +    if (config =3D=3D NULL) {
> > +        return -1;
> > +    }
> > +    config->off =3D offset;
> > +    config->len =3D size;
> > +    memcpy(config->buf, data, size);
> > +    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_CONFIG, config);
> > +    g_free(config);
> > +    return ret;
> > +}
> > +
> > +static int vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *confi=
g,
> > +                                   uint32_t config_len)
> > +{
> > +    struct vhost_vdpa_config *v_config;
> > +    unsigned long config_size =3D offsetof(struct vhost_vdpa_config, b=
uf);
> > +    int ret;
> > +
> > +    v_config =3D g_malloc(config_len + config_size);
> > +    if (v_config =3D=3D NULL) {
> > +        return -1;
> > +    }
> > +    v_config->len =3D config_len;
> > +    v_config->off =3D 0;
> > +    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_GET_CONFIG, v_config);
> > +    memcpy(config, v_config->buf, config_len);
> > +    g_free(v_config);
> > +    return ret;
> > + }
> > +
> > +static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
> > +{
> > +    struct vhost_vdpa *v =3D dev->opaque;
> > +    if (started) {
> > +        uint8_t status =3D 0;
> > +        memory_listener_register(&v->listener, &address_space_memory);
> > +        vhost_vdpa_set_vring_ready(dev);
> > +        vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> > +        vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &status);
> > +
> > +        return !(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > +    } else {
> > +        vhost_vdpa_reset_device(dev);
> > +        vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > +                                   VIRTIO_CONFIG_S_DRIVER);
> > +        memory_listener_unregister(&v->listener);
> > +
> > +        return 0;
> > +    }
> > +}
> > +
> > +static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t bas=
e,
> > +                                     struct vhost_log *log)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_LOG_BASE, &base);
> > +}
> > +
> > +static int vhost_vdpa_set_vring_addr(struct vhost_dev *dev,
> > +                                       struct vhost_vring_addr *addr)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_VRING_ADDR, addr);
> > +}
> > +
> > +static int vhost_vdpa_set_vring_num(struct vhost_dev *dev,
> > +                                      struct vhost_vring_state *ring)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_VRING_NUM, ring);
> > +}
> > +
> > +static int vhost_vdpa_set_vring_base(struct vhost_dev *dev,
> > +                                       struct vhost_vring_state *ring)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_VRING_BASE, ring);
> > +}
> > +
> > +static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
> > +                                       struct vhost_vring_state *ring)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring);
> > +}
> > +
> > +static int vhost_vdpa_set_vring_kick(struct vhost_dev *dev,
> > +                                       struct vhost_vring_file *file)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_VRING_KICK, file);
> > +}
> > +
> > +static int vhost_vdpa_set_vring_call(struct vhost_dev *dev,
> > +                                       struct vhost_vring_file *file)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_VRING_CALL, file);
> > +}
> > +
> > +static int vhost_vdpa_get_features(struct vhost_dev *dev,
> > +                                     uint64_t *features)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_GET_FEATURES, features);
> > +}
> > +
> > +static int vhost_vdpa_set_owner(struct vhost_dev *dev)
> > +{
> > +    return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
> > +}
> > +
> > +static int vhost_vdpa_vq_get_addr(struct vhost_dev *dev,
> > +                    struct vhost_vring_addr *addr, struct vhost_virtqu=
eue *vq)
> > +{
> > +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA=
);
> > +    addr->desc_user_addr =3D (uint64_t)(unsigned long)vq->desc_phys;
> > +    addr->avail_user_addr =3D (uint64_t)(unsigned long)vq->avail_phys;
> > +    addr->used_user_addr =3D (uint64_t)(unsigned long)vq->used_phys;
> > +    return 0;
> > +}
> > +
> > +const VhostOps vdpa_ops =3D {
> > +        .backend_type =3D VHOST_BACKEND_TYPE_VDPA,
> > +        .vhost_backend_init =3D vhost_vdpa_init,
> > +        .vhost_backend_cleanup =3D vhost_vdpa_cleanup,
> > +        .vhost_set_log_base =3D vhost_vdpa_set_log_base,
> > +        .vhost_set_vring_addr =3D vhost_vdpa_set_vring_addr,
> > +        .vhost_set_vring_num =3D vhost_vdpa_set_vring_num,
> > +        .vhost_set_vring_base =3D vhost_vdpa_set_vring_base,
> > +        .vhost_get_vring_base =3D vhost_vdpa_get_vring_base,
> > +        .vhost_set_vring_kick =3D vhost_vdpa_set_vring_kick,
> > +        .vhost_set_vring_call =3D vhost_vdpa_set_vring_call,
> > +        .vhost_get_features =3D vhost_vdpa_get_features,
> > +        .vhost_set_owner =3D vhost_vdpa_set_owner,
> > +        .vhost_set_vring_endian =3D NULL,
> > +        .vhost_backend_memslots_limit =3D vhost_vdpa_memslots_limit,
> > +        .vhost_set_mem_table =3D vhost_vdpa_set_mem_table,
> > +        .vhost_set_features =3D vhost_vdpa_set_features,
> > +        .vhost_reset_device =3D vhost_vdpa_reset_device,
> > +        .vhost_get_vq_index =3D vhost_vdpa_get_vq_index,
> > +        .vhost_get_config  =3D vhost_vdpa_get_config,
> > +        .vhost_set_config =3D vhost_vdpa_set_config,
> > +        .vhost_requires_shm_log =3D NULL,
> > +        .vhost_migration_done =3D NULL,
> > +        .vhost_backend_can_merge =3D NULL,
> > +        .vhost_net_set_mtu =3D NULL,
> > +        .vhost_set_iotlb_callback =3D NULL,
> > +        .vhost_send_device_iotlb_msg =3D NULL,
> > +        .vhost_dev_start =3D vhost_vdpa_dev_start,
> > +        .vhost_get_device_id =3D vhost_vdpa_get_device_id,
> > +         .vhost_vq_get_addr =3D vhost_vdpa_vq_get_addr,
> > +};
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 1e083a8976..bcaa66e0d2 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -808,7 +808,9 @@ static int vhost_dev_set_features(struct vhost_dev =
*dev,
> >           features |=3D 0x1ULL << VHOST_F_LOG_ALL;
> >       }
> >       if (!vhost_dev_has_iommu(dev)) {
> > -        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> > +        if (dev->vhost_ops->backend_type !=3D VHOST_BACKEND_TYPE_VDPA)=
 {
> > +            features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> > +        }
>
>
> Let's add a vhost_ops here if we want to force IOMMU_PLATFORM.
>
>
> >       }
> >       r =3D dev->vhost_ops->vhost_set_features(dev, features);
> >       if (r < 0) {
> > @@ -1701,9 +1703,10 @@ int vhost_dev_start(struct vhost_dev *hdev, Virt=
IODevice *vdev)
> >               goto fail_log;
> >           }
> >       }
> > +
>
>
> Unnecessary change.
>
>
> >       if (vhost_dev_has_iommu(hdev) &&
> >           hdev->vhost_ops->vhost_set_iotlb_callback) {
> > -            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
> > +        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
>
>
> This change should belong to patch 5
>
> Thanks
>
>
> >
> >           /* Update used ring information for IOTLB to work correctly,
> >            * vhost-kernel code requires for this.*/
> > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhos=
t-backend.h
> > index bfc24207e2..01f7c0d46f 100644
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
> > @@ -167,6 +168,7 @@ typedef struct VhostOps {
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
> > index 085450c6f8..767a95ec0b 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -92,6 +92,13 @@ struct vhost_dev {
> >       const VhostDevConfigOps *config_ops;
> >   };
> >
> > +struct vhost_net {
> > +    struct vhost_dev dev;
> > +    struct vhost_virtqueue vqs[2];
> > +    int backend;
> > +    NetClientState *nc;
> > +};
> > +
> >   int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> >                      VhostBackendType backend_type,
> >                      uint32_t busyloop_timeout);
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 196f468786..fa1b19de4c 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -2418,6 +2418,10 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
> >   #ifdef CONFIG_POSIX
> >       "-netdev vhost-user,id=3Dstr,chardev=3Ddev[,vhostforce=3Don|off]\=
n"
> >       "                configure a vhost-user network, backed by a char=
dev 'dev'\n"
> > +#endif
> > +#ifdef __linux__
> > +    "-netdev vhost-vdpa,id=3Dstr,vhostdev=3D/path/to/dev\n"
> > +    "                configure a vhost-vdpa network,Establish a vhost-=
vdpa netdev\n"
> >   #endif
> >       "-netdev hubport,id=3Dstr,hubid=3Dn[,netdev=3Dnd]\n"
> >       "                configure a hub port on the hub with ID 'n'\n", =
QEMU_ARCH_ALL)
> > @@ -2897,6 +2901,14 @@ SRST
> >                -netdev type=3Dvhost-user,id=3Dnet0,chardev=3Dchr0 \
> >                -device virtio-net-pci,netdev=3Dnet0
> >
> > +``-netdev vhost-vdpa,vhostdev=3D/path/to/dev``
> > +    Establish a vhost-vdpa netdev.
> > +
> > +    vDPA device is a device that uses a datapath which complies with
> > +    the virtio specifications with a vendor specific control path.
> > +    vDPA devices can be both physically located on the hardware or
> > +    emulated by software.
> > +
> >   ``-netdev hubport,id=3Did,hubid=3Dhubid[,netdev=3Dnd]``
> >       Create a hub port on the emulated hub with ID hubid.
> >
>


