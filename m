Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96D8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8710820679
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYFXwpzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8710820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfT4-0004Ym-RQ
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnfO8-0004cL-As
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:38:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnfO4-0004CD-Rq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592905120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HhnnC1qbmAIwIJQohKNYqWINOFgGbO2HXJeLk/tpLc=;
 b=OYFXwpzdAbxAm3TkQqhiR7K9pHx2CEb5TldAYxT1Xar8yWKa1QAzIkw6E2OkwAz3WwxDUz
 Ow8VrYEJNAOR4IXKRb7xum03SyzgNuP+sJGbhamVhRkV79RF+QD5GfMH25e+nQFcvhdi1L
 f6+oHwoWdNB8VIVUe+okLP9nhrtx0dM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-tA4AgcJsOiebbxZdMH82cQ-1; Tue, 23 Jun 2020 05:38:38 -0400
X-MC-Unique: tA4AgcJsOiebbxZdMH82cQ-1
Received: by mail-pl1-f197.google.com with SMTP id i6so13752781plt.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6HhnnC1qbmAIwIJQohKNYqWINOFgGbO2HXJeLk/tpLc=;
 b=CA6glwFF2kuk9ugoH7DXVLAXrqKekv9F8benWPaVpXvWJSNMSEWfmfOnH6g0I/mdVb
 qso+AWJjVbQ7fhls0UaJmr2tuIdf5oQgmx2PRFgtK8urGVjvoO6DN29cRKKNfn5E42Py
 +jSUzhViphXpsBngJFNTp9frIwf0MWqYp7k+2Um9JoJu51fJ0/sje/4BXiW0fhMqZMhT
 Vx94tGMzPaqnibtEuwp85ao3ASdvlhuzZIjKXmvFGxDfZqttBgMu0EVO7Fp1pGDnwg5o
 5zkvvw1Su5Dzwz0aw0GnnhXy6yEHXhtvn3U+EEVjgfiJfiV9sD5gM9rkIQLHOuZMorGi
 OqUQ==
X-Gm-Message-State: AOAM531MQiR4MshLDhxoQ+nQDmTa+/Lf5BThVyrvhjjJCW7H3+Qg73e+
 YSIzHsUUfGzfr5dJcA7MWcRSOMaLHadM0rY58urn+cli/7GNycyStLXwZysgLwSvQ6obLQVTusO
 IshAQdUE35aJPLTkO+AeiMaJAlu0Hgys=
X-Received: by 2002:a17:90a:1aaa:: with SMTP id
 p39mr23316436pjp.127.1592905116112; 
 Tue, 23 Jun 2020 02:38:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKfYu8uZHVok9AThtciXiyEu7thdTWuPH/TfWejbNFtWUSgWOJRwNxjlYp/VYg3M1ZKYyOzp+M8ijY7KKsScs=
X-Received: by 2002:a17:90a:1aaa:: with SMTP id
 p39mr23316389pjp.127.1592905115447; 
 Tue, 23 Jun 2020 02:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-10-lulu@redhat.com>
 <83a2f604-e38f-4f63-f28c-361baa9ac012@redhat.com>
In-Reply-To: <83a2f604-e38f-4f63-f28c-361baa9ac012@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 23 Jun 2020 17:38:24 +0800
Message-ID: <CACLfguW8d+TbJstU9T6o8OUD=dXybUbo_AOpBVh9_nGt78Jbmg@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] vhost-vdpa: introduce vhost-vdpa backend
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
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

On Tue, Jun 23, 2020 at 3:31 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/22 =E4=B8=8B=E5=8D=8811:37, Cindy Lu wrote:
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
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   configure                         |  21 ++
> >   hw/net/vhost_net.c                |  19 +-
> >   hw/net/virtio-net.c               |  19 +-
> >   hw/virtio/Makefile.objs           |   1 +
> >   hw/virtio/vhost-backend.c         |  22 +-
> >   hw/virtio/vhost-vdpa.c            | 406 +++++++++++++++++++++++++++++=
+
> >   hw/virtio/vhost.c                 |  42 +++-
> >   include/hw/virtio/vhost-backend.h |   6 +-
> >   include/hw/virtio/vhost-vdpa.h    |  26 ++
> >   include/hw/virtio/vhost.h         |   6 +
> >   qemu-options.hx                   |  12 +
> >   11 files changed, 555 insertions(+), 25 deletions(-)
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
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 04cc3db264..cc259e571d 100644
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
> > @@ -84,7 +80,6 @@ static const int user_feature_bits[] =3D {
> >
> >       VHOST_INVALID_FEATURE_BIT
> >   };
> > -
>
>
> Unnecessary change.
>
>
Will remove this
> >   static const int *vhost_net_get_feature_bits(struct vhost_net *net)
> >   {
> >       const int *feature_bits =3D 0;
> > @@ -96,6 +91,9 @@ static const int *vhost_net_get_feature_bits(struct v=
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
> > @@ -348,6 +346,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientSta=
te *ncs,
> >       }
> >
> >       for (i =3D 0; i < total_queues; i++) {
> > +
>
>
> Unnecessary change.
>
Will remove this
>
> >           peer =3D qemu_get_peer(ncs, i);
> >           r =3D vhost_net_start_one(get_vhost_net(peer), dev);
> >
> > @@ -444,6 +443,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
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
> > index a46e3b37a7..8c85e2e1e1 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -42,6 +42,7 @@
> >   #include "trace.h"
> >   #include "monitor/qdev.h"
> >   #include "hw/pci/pci.h"
> > +#include "hw/virtio/vhost.h"
> >
> >   #define VIRTIO_NET_VM_VERSION    11
> >
> > @@ -131,6 +132,8 @@ static void virtio_net_get_config(VirtIODevice *vde=
v, uint8_t *config)
> >   {
> >       VirtIONet *n =3D VIRTIO_NET(vdev);
> >       struct virtio_net_config netcfg;
> > +    int ret =3D 0;
> > +    memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> >
> >       virtio_stw_p(vdev, &netcfg.status, n->status);
> >       virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
> > @@ -139,13 +142,21 @@ static void virtio_net_get_config(VirtIODevice *v=
dev, uint8_t *config)
> >       virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
> >       netcfg.duplex =3D n->net_conf.duplex;
> >       memcpy(config, &netcfg, n->config_size);
> > +    NetClientState *nc =3D qemu_get_queue(n->nic);
> > +    if (nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
> > +        ret =3D vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t=
 *)&netcfg,
> > +                             n->config_size);
> > +        if (ret !=3D -1) {
> > +            memcpy(config, &netcfg, n->config_size);
> > +        }
> > +    }
>
>
> This is kind of sub-optimal.
>
> I think the a better approach is deal all the stuffs inside
> vhost_net_get_config().
>
>
Sure will do
> >   }
> >
> >   static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *=
config)
> >   {
> >       VirtIONet *n =3D VIRTIO_NET(vdev);
> > +    NetClientState *nc =3D qemu_get_queue(n->nic);
> >       struct virtio_net_config netcfg =3D {};
> > -
>
>
> Unnecessary change.
>
Will remove this
>
> >       memcpy(&netcfg, config, n->config_size);
> >
> >       if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR) &&
> > @@ -154,6 +165,11 @@ static void virtio_net_set_config(VirtIODevice *vd=
ev, const uint8_t *config)
> >           memcpy(n->mac, netcfg.mac, ETH_ALEN);
> >           qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
> >       }
> > +    if (nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
> > +        vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netc=
fg,
> > +                               0, n->config_size,
> > +                               VHOST_SET_CONFIG_TYPE_MASTER);
> > +      }
>
>
> Similar issues as get_config.
>
>
> >   }
> >
> >   static bool virtio_net_started(VirtIONet *n, uint8_t status)
> > @@ -2958,7 +2974,6 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
> >       } else if (n->net_conf.speed >=3D 0) {
> >           n->host_features |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
> >       }
> > -
>
>
> Unnecessary change.
>
Will remove this
>
> >       if (n->failover) {
> >           n->primary_listener.should_be_hidden =3D
> >               virtio_net_primary_should_be_hidden;
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
> > index 660e9e8588..84e5b1a833 100644
> > --- a/hw/virtio/vhost-backend.c
> > +++ b/hw/virtio/vhost-backend.c
> > @@ -14,7 +14,7 @@
> >   #include "qemu/error-report.h"
> >   #include "qemu/main-loop.h"
> >   #include "standard-headers/linux/vhost_types.h"
> > -
> > +#include "hw/virtio/vhost-vdpa.h"
> >   #ifdef CONFIG_VHOST_KERNEL
> >   #include <linux/vhost.h>
> >   #include <sys/ioctl.h>
> > @@ -22,10 +22,19 @@
> >   static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int=
 request,
> >                                void *arg)
> >   {
> > -    int fd =3D (uintptr_t) dev->opaque;
> > -
> > -    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_KERN=
EL);
> > +    int fd =3D -1;
> > +    switch (dev->vhost_ops->backend_type) {
> > +    case VHOST_BACKEND_TYPE_KERNEL:
> > +        fd  =3D (uintptr_t)dev->opaque;
> > +        break;
> > +    case VHOST_BACKEND_TYPE_VDPA:
> > +        fd =3D ((struct vhost_vdpa *)dev->opaque)->device_fd;
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> >
> > +    assert(fd !=3D -1);
> >       return ioctl(fd, request, arg);
> >   }
> >
> > @@ -285,6 +294,11 @@ int vhost_set_backend_type(struct vhost_dev *dev, =
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
> > index 0000000000..1724d404ce
> > --- /dev/null
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -0,0 +1,406 @@
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
>
>
> Note that, I post patches for reporting IOVA range, we need add the
> check through that in the future.
>
>
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
>
>
> newline is needed.
>
>
will add this
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
> > +};
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index bfd7f9ce1f..a75be7216b 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -744,19 +744,34 @@ static void vhost_iommu_region_del(MemoryListener=
 *listener,
> >       }
> >   }
> >
> > +static void vhost_virtqueue_get_addr(struct vhost_dev *dev,
> > +                                    struct vhost_vring_addr *addr,
> > +                                    struct vhost_virtqueue *vq)
> > +{
> > +    /*vDPA need to use the IOVA here to set to hardware*/
> > +    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA) {
>
>
> Let's introduce a new vhost_ops for this.
>
will add this
>
> > +        addr->desc_user_addr =3D (uint64_t)(unsigned long)vq->desc_phy=
s;
> > +        addr->avail_user_addr =3D (uint64_t)(unsigned long)vq->avail_p=
hys;
> > +        addr->used_user_addr =3D (uint64_t)(unsigned long)vq->used_phy=
s;
> > +    } else {
> > +        addr->desc_user_addr =3D (uint64_t)(unsigned long)vq->desc;
> > +        addr->avail_user_addr =3D (uint64_t)(unsigned long)vq->avail;
> > +        addr->used_user_addr =3D (uint64_t)(unsigned long)vq->used;
> > +    }
> > +}
> >
> >   static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
> >                                       struct vhost_virtqueue *vq,
> >                                       unsigned idx, bool enable_log)
> >   {
> > -    struct vhost_vring_addr addr =3D {
> > -        .index =3D idx,
> > -        .desc_user_addr =3D (uint64_t)(unsigned long)vq->desc,
> > -        .avail_user_addr =3D (uint64_t)(unsigned long)vq->avail,
> > -        .used_user_addr =3D (uint64_t)(unsigned long)vq->used,
> > -        .log_guest_addr =3D vq->used_phys,
> > -        .flags =3D enable_log ? (1 << VHOST_VRING_F_LOG) : 0,
> > -    };
> > +    struct vhost_vring_addr addr;
> > +    memset(&addr, 0, sizeof(struct vhost_vring_addr));
> > +
> > +    vhost_virtqueue_get_addr(dev, &addr, vq);
> > +    addr.index =3D idx;
> > +    addr .log_guest_addr =3D vq->used_phys;
> > +    addr .flags =3D enable_log ? (1 << VHOST_VRING_F_LOG) : 0;
>
>
> Unnecessary spaces between addr and log_guest_addr/flags.
>
>
Will remove this
> > +
> >       int r =3D dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
> >       if (r < 0) {
> >           VHOST_OPS_DEBUG("vhost_set_vring_addr failed");
> > @@ -774,7 +789,9 @@ static int vhost_dev_set_features(struct vhost_dev =
*dev,
> >           features |=3D 0x1ULL << VHOST_F_LOG_ALL;
> >       }
> >       if (!vhost_dev_has_iommu(dev)) {
> > -        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
>
>
>
> A comment is needed here.
>
will add this
>
> > +        if (dev->vhost_ops->backend_type !=3D VHOST_BACKEND_TYPE_VDPA)=
 {
> > +            features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> > +        }
> >       }
> >       r =3D dev->vhost_ops->vhost_set_features(dev, features);
> >       if (r < 0) {
> > @@ -1667,7 +1684,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtI=
ODevice *vdev)
> >           goto fail_log;
> >       }
> >
> > -    if (vhost_dev_has_iommu(hdev)) {
> > +    if (vhost_dev_has_iommu(hdev) &&
> > +        hdev->vhost_ops->vhost_set_iotlb_callback) {
>
>
> A separate patch for this please
>
>
> >           hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
> >
> >           /* Update used ring information for IOTLB to work correctly,
> > @@ -1713,7 +1731,9 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtI=
ODevice *vdev)
> >       }
> >
> >       if (vhost_dev_has_iommu(hdev)) {
> > -        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
> > +        if (hdev->vhost_ops->vhost_set_iotlb_callback) {
> > +            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
> > +        }
>
>
> A separate patch for this.
>
will do
>
> >           memory_listener_unregister(&hdev->iommu_listener);
> >       }
> >       vhost_log_put(hdev, true);
> > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhos=
t-backend.h
> > index c1384bd2c7..c418c2fa0e 100644
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
> > @@ -113,6 +114,7 @@ typedef int (*vhost_set_inflight_fd_op)(struct vhos=
t_dev *dev,
> >                                           struct vhost_inflight *inflig=
ht);
> >
> >   typedef int (*vhost_dev_start_op)(struct vhost_dev *dev, bool started=
);
> > +typedef int (*vhost_get_device_id_op)(struct vhost_dev *dev, uint32_t =
*dev_id);
> >   typedef struct VhostOps {
> >       VhostBackendType backend_type;
> >       vhost_backend_init vhost_backend_init;
> > @@ -154,9 +156,11 @@ typedef struct VhostOps {
> >       vhost_get_inflight_fd_op vhost_get_inflight_fd;
> >       vhost_set_inflight_fd_op vhost_set_inflight_fd;
> >       vhost_dev_start_op vhost_dev_start;
> > +    vhost_get_device_id_op vhost_get_device_id;
> >   } VhostOps;
>
>
> A separate patch for introducing this please.
>
>
will do
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
> > index 59ea53f8c2..f69b5e4a02 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -92,6 +92,12 @@ struct vhost_dev {
> >       const VhostDevConfigOps *config_ops;
> >   };
> >
> > +struct vhost_net {
> > +    struct vhost_dev dev;
> > +    struct vhost_virtqueue vqs[2];
> > +    int backend;
> > +    NetClientState *nc;
> > +};
>
>
> A separate patch for this exporting please.
>
> Thanks
>
>
will do
> >
> >   int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> >                      VhostBackendType backend_type,
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 292d4e7c0c..d7d0daaa0e 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -2409,6 +2409,10 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
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
> > @@ -2888,6 +2892,14 @@ SRST
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


