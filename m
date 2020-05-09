Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB37C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 07:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C80C217BA
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 07:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b70wMoCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C80C217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXJyO-0008Bq-Ha
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 03:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJxb-0007kM-6V
 for qemu-devel@nongnu.org; Sat, 09 May 2020 03:31:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44407
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJxZ-0003H9-1J
 for qemu-devel@nongnu.org; Sat, 09 May 2020 03:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589009503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Awk7BE3J9j/ccdRgu8ak0+/VNKN9wtsN4y5m8kz6rC8=;
 b=b70wMoCTMLwzki0VnQCfKF1phEbDEsIuMey8Waa985W42yrW99ZoTmSKoGEJb01MoShRv5
 nkJu6qpyYdWdAvCeLGQWzp/Glj13CByRqzbVNKVqjt9t+csiN8guAsOGy1yfK7JTzXcyNT
 NggDJVSDgqrhhEuUqDg+mfgijsCRDC4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-mnDIQwkGO9uboipwHQgtCA-1; Sat, 09 May 2020 03:31:41 -0400
X-MC-Unique: mnDIQwkGO9uboipwHQgtCA-1
Received: by mail-pl1-f199.google.com with SMTP id be7so3435725plb.21
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 00:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Awk7BE3J9j/ccdRgu8ak0+/VNKN9wtsN4y5m8kz6rC8=;
 b=ifs0feKIvEZ06YcYiwvK1yAtU6sKt+eeAWQVAUoDc64aCXyUocrcmAnt3yLrKfVTjo
 s8R6L4YokkGIvBH8xbh057wcbO1Y9vXccHr9+CVpol5k9iP4kA6h1cOnm601LQNf6JDg
 YTF2SHlBQqXAwJLQaurojKe7qRZMW5dMON221tbB+osYC3G2u3O+eBo5Yblv8fv2IFC0
 /2LQNSuoGzYmXMK6McySlZTMcBC0wvHKWFCbc9Z+8/S51cqR0yHeKrE5hiA31AIQ5BHB
 dBEngxUwVGoT7UfZpUQH8Z77J4Y8IbPfP8Oh0Zdu3vbAep9fHJrWvwtfTPp2QlfIhKX7
 Y3TA==
X-Gm-Message-State: AGi0PuagF6e9fmhg3RsKxan2ceDBtMB0EGgwYxmcoQib/vnNS0NbL34F
 iDSWcVmu+VWBTdhyJe4fm3+P0fxaVDrkS/NKhnjo9I0vO754qWjfUQAiCg/V3++vlqhWXOxhKdN
 64KBpoNvde/8wjm7b5K65j5YjN20dOjQ=
X-Received: by 2002:a17:902:6b05:: with SMTP id
 o5mr5644831plk.274.1589009500070; 
 Sat, 09 May 2020 00:31:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypI8WIvIRnQUhycfWEbuWb7VBv/urtjnssHxACkgJejDKX31AnMZg0r0Ju1WgAXV3NxzOgHuNyYNqUu+3TCOQ4I=
X-Received: by 2002:a17:902:6b05:: with SMTP id
 o5mr5644778plk.274.1589009499514; 
 Sat, 09 May 2020 00:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-5-lulu@redhat.com>
 <570f92fa-dbf4-e9d0-e00d-18f02fafd0ce@redhat.com>
In-Reply-To: <570f92fa-dbf4-e9d0-e00d-18f02fafd0ce@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sat, 9 May 2020 15:31:28 +0800
Message-ID: <CACLfguXyDLdcTGVUViD-_SdYSGCzyce5M2h4g7YgdQUyADRphQ@mail.gmail.com>
Subject: Re: [RFC v2 4/9] vhost-vdpa: introduce vhost-vdpa net client
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

On Sat, May 9, 2020 at 10:40 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/5/9 =E4=B8=8A=E5=8D=8812:32, Cindy Lu wrote:
> > From: Tiwei Bie <tiwei.bie@intel.com>
>
>
> If you think you've done a huge refactor on the code, you can change the
> author but need to keep the sob of Tiwei.
>
>
> >
> > This patch set introduces a new net client type: vhost-vdpa.
> > vhost-vdpa net client will set up a vDPA device which is specified
> > by a "vhostdev" parameter.
> >
> > Co-authored-by: Lingshan Zhu <lingshan.zhu@intel.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   configure                |  21 ++++
> >   include/net/vhost-vdpa.h |  19 ++++
> >   include/net/vhost_net.h  |   1 +
>
>
> Patch 5 which is the infrastructure of vhost-vpda should come first.
> Please re-order the patch in next version.
>
Sure, Will fix this
>
> >   net/Makefile.objs        |   2 +-
> >   net/clients.h            |   2 +
> >   net/net.c                |   3 +
> >   net/vhost-vdpa.c         | 227 ++++++++++++++++++++++++++++++++++++++=
+
> >   qapi/net.json            |  22 +++-
> >   qemu-options.hx          |  19 ++++
> >   9 files changed, 313 insertions(+), 3 deletions(-)
> >   create mode 100644 include/net/vhost-vdpa.h
> >   create mode 100644 net/vhost-vdpa.c
> >
> > diff --git a/configure b/configure
> > index 6099be1d84..bdd732e3bb 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1505,6 +1505,10 @@ for opt do
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
> > @@ -1780,6 +1784,7 @@ disabled with --disable-FEATURE, default is enabl=
ed if available:
> >     vhost-crypto    vhost-user-crypto backend support
> >     vhost-kernel    vhost kernel backend support
> >     vhost-user      vhost-user backend support
> > +  vhost-vdpa      vhost-vdpa backend support
>
>
> Maybe "vhost-vdpa kernel backend support" is better.
>
>
Will  fix this
> >     spice           spice
> >     rbd             rados block device (rbd)
> >     libiscsi        iscsi support
> > @@ -2241,6 +2246,10 @@ test "$vhost_user" =3D "" && vhost_user=3Dyes
> >   if test "$vhost_user" =3D "yes" && test "$mingw32" =3D "yes"; then
> >     error_exit "vhost-user isn't available on win32"
> >   fi
> > +test "$vhost_vdpa" =3D "" && vhost_vdpa=3Dyes
> > +if test "$vhost_vdpa" =3D "yes" && test "$mingw32" =3D "yes"; then
> > +  error_exit "vhost-vdpa isn't available on win32"
> > +fi
>
>
> Let's add a check for Linux like vhost kernel below.
>
Will fix this
>
> >   test "$vhost_kernel" =3D "" && vhost_kernel=3D$linux
> >   if test "$vhost_kernel" =3D "yes" && test "$linux" !=3D "yes"; then
> >     error_exit "vhost-kernel is only available on Linux"
> > @@ -2269,6 +2278,11 @@ test "$vhost_user_fs" =3D "" && vhost_user_fs=3D=
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
> > @@ -6543,6 +6557,7 @@ echo "vhost-scsi support $vhost_scsi"
> >   echo "vhost-vsock support $vhost_vsock"
> >   echo "vhost-user support $vhost_user"
> >   echo "vhost-user-fs support $vhost_user_fs"
> > +echo "vhost-vdpa support $vhost_vdpa"
> >   echo "Trace backends    $trace_backends"
> >   if have_backend "simple"; then
> >   echo "Trace output file $trace_file-<pid>"
> > @@ -7031,6 +7046,9 @@ fi
> >   if test "$vhost_net_user" =3D "yes" ; then
> >     echo "CONFIG_VHOST_NET_USER=3Dy" >> $config_host_mak
> >   fi
> > +if test "$vhost_net_vdpa" =3D "yes" ; then
> > +  echo "CONFIG_VHOST_NET_VDPA=3Dy" >> $config_host_mak
> > +fi
> >   if test "$vhost_crypto" =3D "yes" ; then
> >     echo "CONFIG_VHOST_CRYPTO=3Dy" >> $config_host_mak
> >   fi
> > @@ -7043,6 +7061,9 @@ fi
> >   if test "$vhost_user" =3D "yes" ; then
> >     echo "CONFIG_VHOST_USER=3Dy" >> $config_host_mak
> >   fi
> > +if test "$vhost_vdpa" =3D "yes" ; then
> > +  echo "CONFIG_VHOST_VDPA=3Dy" >> $config_host_mak
> > +fi
> >   if test "$vhost_user_fs" =3D "yes" ; then
> >     echo "CONFIG_VHOST_USER_FS=3Dy" >> $config_host_mak
> >   fi
> > diff --git a/include/net/vhost-vdpa.h b/include/net/vhost-vdpa.h
> > new file mode 100644
> > index 0000000000..6ce0d04f72
> > --- /dev/null
> > +++ b/include/net/vhost-vdpa.h
> > @@ -0,0 +1,19 @@
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
> > +#ifndef VHOST_VDPA_H
> > +#define VHOST_VDPA_H
> > +
> > +struct vhost_net;
> > +struct vhost_net *vhost_vdpa_get_vhost_net(NetClientState *nc);
> > +uint64_t vhost_vdpa_get_acked_features(NetClientState *nc);
> > +
> > +#endif /* VHOST_VDPA_H */
> > diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> > index 6548a5a105..b47844bf29 100644
> > --- a/include/net/vhost_net.h
> > +++ b/include/net/vhost_net.h
> > @@ -40,4 +40,5 @@ uint64_t vhost_net_get_acked_features(VHostNetState *=
net);
> >
> >   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
> >   int vhost_set_state(NetClientState *nc, uint8_t state);
> > +int vhost_net_get_device_id(struct vhost_net *net, uint32_t *device_id=
);
>
>
> Let's move this function to vhost-vdpa generic header instead of net.
>
Will fix this
>
> >   #endif
> > diff --git a/net/Makefile.objs b/net/Makefile.objs
> > index c5d076d19c..5ab45545db 100644
> > --- a/net/Makefile.objs
> > +++ b/net/Makefile.objs
> > @@ -26,7 +26,7 @@ tap-obj-$(CONFIG_SOLARIS) =3D tap-solaris.o
> >   tap-obj-y ?=3D tap-stub.o
> >   common-obj-$(CONFIG_POSIX) +=3D tap.o $(tap-obj-y)
> >   common-obj-$(CONFIG_WIN32) +=3D tap-win32.o
> > -
> > +common-obj-$(CONFIG_VHOST_NET_VDPA) +=3D vhost-vdpa.o
> >   vde.o-libs =3D $(VDE_LIBS)
> >
> >   common-obj-$(CONFIG_CAN_BUS) +=3D can/
> > diff --git a/net/clients.h b/net/clients.h
> > index a6ef267e19..92f9b59aed 100644
> > --- a/net/clients.h
> > +++ b/net/clients.h
> > @@ -61,4 +61,6 @@ int net_init_netmap(const Netdev *netdev, const char =
*name,
> >   int net_init_vhost_user(const Netdev *netdev, const char *name,
> >                           NetClientState *peer, Error **errp);
> >
> > +int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
> > +                        NetClientState *peer, Error **errp);
> >   #endif /* QEMU_NET_CLIENTS_H */
> > diff --git a/net/net.c b/net/net.c
> > index b3192deaf1..9eff1ae982 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -965,6 +965,9 @@ static int (* const net_client_init_fun[NET_CLIENT_=
DRIVER__MAX])(
> >   #ifdef CONFIG_VHOST_NET_USER
> >           [NET_CLIENT_DRIVER_VHOST_USER] =3D net_init_vhost_user,
> >   #endif
> > +#ifdef CONFIG_VHOST_NET_VDPA
> > +        [NET_CLIENT_DRIVER_VHOST_VDPA] =3D net_init_vhost_vdpa,
> > +#endif
> >   #ifdef CONFIG_L2TPV3
> >           [NET_CLIENT_DRIVER_L2TPV3]    =3D net_init_l2tpv3,
> >   #endif
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > new file mode 100644
> > index 0000000000..c29678fdf1
> > --- /dev/null
> > +++ b/net/vhost-vdpa.c
> > @@ -0,0 +1,227 @@
> > +/*
> > + * vhost-vdpa.c
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
> > +#include "qemu/osdep.h"
> > +#include "clients.h"
> > +#include "net/vhost_net.h"
> > +#include "net/vhost-vdpa.h"
> > +#include "hw/virtio/vhost-vdpa.h"
> > +#include "qemu/config-file.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/option.h"
> > +#include "qapi/error.h"
> > +#include <linux/vfio.h>
>
>
> No need any more.
>
>
> > +#include <sys/ioctl.h>
> > +#include <err.h>
> > +#include <linux/virtio_net.h>
>
>
> That's not the way we include standard linux headers, qemu maintain a
> copy of standard linux headers.
>
> Need use #include "standard-headers/linux/xxx.h"
>
Will fix this
>
> > +#include "monitor/monitor.h"
> > +#include "qemu/sockets.h"
>
>
> Do we really need this?
>
Will fix this
>
> > +#include "hw/virtio/vhost.h"
> > +
> > +/* Todo:need to add the multiqueue support here */
> > +typedef struct VhostVDPAState {
> > +    NetClientState nc;
> > +    struct vhost_vdpa vhost_vdpa;
> > +    VHostNetState *vhost_net;
> > +    uint64_t acked_features;
> > +    bool started;
> > +} VhostVDPAState;
> > +
> > +VHostNetState *vhost_vdpa_get_vhost_net(NetClientState *nc)
> > +{
> > +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > +    return s->vhost_net;
> > +}
> > +
> > +uint64_t vhost_vdpa_get_acked_features(NetClientState *nc)
> > +{
> > +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > +    return s->acked_features;
> > +}
> > +
> > +static void vhost_vdpa_del(NetClientState *ncs)
> > +{
> > +    VhostVDPAState *s;
> > +
> > +    assert(ncs->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > +
> > +    s =3D DO_UPCAST(VhostVDPAState, nc, ncs);
> > +
> > +    if (s->vhost_net) {
> > +        /* save acked features */
> > +        uint64_t features =3D vhost_net_get_acked_features(s->vhost_ne=
t);
> > +        if (features) {
> > +            s->acked_features =3D features;
> > +         }
> > +        vhost_net_cleanup(s->vhost_net);
> > +    }
> > +}
> > +
> > +static int vhost_vdpa_add(NetClientState *ncs, void *be)
> > +{
> > +    VhostNetOptions options;
> > +    struct vhost_net *net =3D NULL;
> > +    VhostVDPAState *s;
> > +
> > +    options.backend_type =3D VHOST_BACKEND_TYPE_VDPA;
> > +
> > +    assert(ncs->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > +
> > +    s =3D DO_UPCAST(VhostVDPAState, nc, ncs);
> > +
> > +    options.net_backend =3D ncs;
> > +    options.opaque      =3D be;
> > +    options.busyloop_timeout =3D 0;
> > +    net =3D vhost_net_init(&options);
> > +    if (!net) {
> > +        error_report("failed to init vhost_net for queue");
> > +        goto err;
> > +     }
> > +
> > +     if (s->vhost_net) {
> > +        vhost_net_cleanup(s->vhost_net);
> > +        g_free(s->vhost_net);
> > +     }
> > +     s->vhost_net =3D net;
> > +
> > +    return 0;
> > +
> > +err:
> > +    if (net) {
> > +        vhost_net_cleanup(net);
> > +    }
> > +    vhost_vdpa_del(ncs);
> > +    return -1;
> > +}
> > +static void vhost_vdpa_cleanup(NetClientState *nc)
> > +{
> > +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > +
> > +    if (s->vhost_net) {
> > +        vhost_net_cleanup(s->vhost_net);
> > +        g_free(s->vhost_net);
> > +        s->vhost_net =3D NULL;
> > +    }
> > +
> > +    qemu_purge_queued_packets(nc);
> > +}
> > +
> > +static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
> > +{
> > +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > +
> > +    return true;
> > +}
> > +
> > +static bool vhost_vdpa_has_ufo(NetClientState *nc)
> > +{
> > +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > +    uint64_t  features =3D 0;
> > +
> > +    features |=3D (1ULL << VIRTIO_NET_F_HOST_UFO);
> > +    features =3D vhost_net_get_features(s->vhost_net, features);
> > +    return !!(features & (1ULL << VIRTIO_NET_F_HOST_UFO));
> > +
> > +}
> > +
> > +static int vhost_vdpa_check_device_id(NetClientState *nc)
> > +{
> > +    uint32_t device_id;
> > +    int ret;
> > +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > +    /* Get the device id from hw*/
> > +    ret =3D vhost_net_get_device_id(s->vhost_net, &device_id);
> > +    if (device_id !=3D VIRTIO_ID_NET) {
> > +        return -ENOTSUP;
> > +    }
> > +    return ret;
> > +}
> > +
> > +static NetClientInfo net_vhost_vdpa_info =3D {
> > +        .type =3D NET_CLIENT_DRIVER_VHOST_VDPA,
> > +        .size =3D sizeof(VhostVDPAState),
> > +        .cleanup =3D vhost_vdpa_cleanup,
> > +        .has_vnet_hdr =3D vhost_vdpa_has_vnet_hdr,
> > +        .has_ufo =3D vhost_vdpa_has_ufo,
> > +};
> > +
> > +static int net_vhost_vdpa_init(NetClientState *peer, const char *devic=
e,
> > +                               const char *name, const char *vhostdev,
> > +                               bool has_fd, char *fd)
> > +{
> > +    NetClientState *nc =3D NULL;
> > +    VhostVDPAState *s;
> > +    int vdpa_device_fd =3D -1;
> > +    Error *err =3D NULL;
> > +
> > +    assert(name);
> > +
> > +    nc =3D qemu_new_net_client(&net_vhost_vdpa_info, peer, device, nam=
e);
> > +    snprintf(nc->info_str, sizeof(nc->info_str), "vhost-vdpa");
> > +    nc->queue_index =3D 0;
> > +
> > +    s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > +
> > +    if (has_fd) {
> > +        vdpa_device_fd =3D monitor_fd_param(cur_mon, fd, &err);
> > +    } else{
> > +        vdpa_device_fd =3D open(vhostdev, O_RDWR);
> > +    }
> > +
> > +    if (vdpa_device_fd =3D=3D -1) {
> > +        return -errno;
> > +     }
> > +    s->vhost_vdpa.device_fd =3D vdpa_device_fd;
> > +    vhost_vdpa_add(nc, (void *)&s->vhost_vdpa);
> > +    assert(s->vhost_net);
> > +    /* check the device id for vdpa */
> > +    return vhost_vdpa_check_device_id(nc);
>
>
> We probably need to the check earlier. If we do things like this, we
> will probably leak vhost_device_fd.
>
there may have some problem to get this device id before the vdpa_add,
I will double check this and try to find a solution
>
> > +}
> > +
> > +static int net_vhost_check_net(void *opaque, QemuOpts *opts, Error **e=
rrp)
> > +{
> > +    const char *name =3D opaque;
> > +    const char *driver, *netdev;
> > +
> > +    driver =3D qemu_opt_get(opts, "driver");
> > +    netdev =3D qemu_opt_get(opts, "netdev");
> > +    if (!driver || !netdev) {
> > +        return 0;
> > +    }
> > +
> > +    if (strcmp(netdev, name) =3D=3D 0 &&
> > +        !g_str_has_prefix(driver, "virtio-net-")) {
> > +        error_setg(errp, "vhost-vdpa requires frontend driver virtio-n=
et-*");
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
> > +                        NetClientState *peer, Error **errp)
> > +{
> > +    const NetdevVhostVDPAOptions *opts;
> > +
> > +    assert(netdev->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > +    opts =3D &netdev->u.vhost_vdpa;
> > +    /* verify net frontend */
> > +    if (qemu_opts_foreach(qemu_find_opts("device"), net_vhost_check_ne=
t,
> > +                          (char *)name, errp)) {
> > +        return -1;
> > +    }
> > +    return net_vhost_vdpa_init(peer, "vhost_vdpa", name, opts->vhostde=
v,
> > +                    opts->has_fd, opts->fd);
> > +}
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 335295be50..0f4fa6fffc 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -441,6 +441,23 @@
> >       '*queues':        'int' } }
> >
> >   ##
> > +# @NetdevVhostVDPAOptions:
> > +#
> > +# Vhost-vdpa network backend
> > +#
> > +# @vhostdev: name of a vdpa dev path in sysfs
> > +#
> > +# @queues: number of queues to be created for multiqueue vhost-vdpa
> > +#          (default: 1) (Since 5.1)
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'struct': 'NetdevVhostVDPAOptions',
> > +  'data': {
> > +    '*vhostdev':     'str',
> > +    '*fd':           'str',
> > +    '*queues':       'int' } }
> > +##
> >   # @NetClientDriver:
> >   #
> >   # Available netdev drivers.
> > @@ -451,7 +468,7 @@
> >   ##
> >   { 'enum': 'NetClientDriver',
> >     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> > -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> > +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' =
] }
> >
> >   ##
> >   # @Netdev:
> > @@ -479,7 +496,8 @@
> >       'bridge':   'NetdevBridgeOptions',
> >       'hubport':  'NetdevHubPortOptions',
> >       'netmap':   'NetdevNetmapOptions',
> > -    'vhost-user': 'NetdevVhostUserOptions' } }
> > +    'vhost-user': 'NetdevVhostUserOptions',
> > +    'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
> >
> >   ##
> >   # @NetLegacy:
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 65c9473b73..08256d9d4e 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -2291,6 +2291,10 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
> >   #ifdef CONFIG_POSIX
> >       "-netdev vhost-user,id=3Dstr,chardev=3Ddev[,vhostforce=3Don|off]\=
n"
> >       "                configure a vhost-user network, backed by a char=
dev 'dev'\n"
> > +#endif
> > +#ifdef CONFIG_POSIX
> > +    "-netdev vhost-vdpa,id=3Dstr,vhostdev=3D/path/to/dev\n"
> > +    "                configure a vhost-vdpa network, backed by a vhost=
dev 'dev'\n"
> >   #endif
> >       "-netdev hubport,id=3Dstr,hubid=3Dn[,netdev=3Dnd]\n"
> >       "                configure a hub port on the hub with ID 'n'\n", =
QEMU_ARCH_ALL)
> > @@ -2310,6 +2314,9 @@ DEF("nic", HAS_ARG, QEMU_OPTION_nic,
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
> > @@ -2749,6 +2756,18 @@ qemu -m 512 -object memory-backend-file,id=3Dmem=
,size=3D512M,mem-path=3D/hugetlbfs,sha
> >        -device virtio-net-pci,netdev=3Dnet0
> >   @end example
> >
> > +@item -netdev vhost-vdpa,vhostdev=3D/path/to/dev
> > +Establish a vhost-vdpa netdev, backed by a vhostdev. The chardev shoul=
d
> > +be a unix domain socket backed one.
>
>
> This seems wrong, we don't use unix domain socket.
>
> Thanks
>
Thanks Jason, will fix this
>
> >   The vhost-vdpa uses a specifically defined
> > +protocol to pass vhost ioctl replacement messages to an application on=
 the other
> > +end of the socket.
> > +Example:
> > +@example
> > +qemu -m 512 -object memory-backend-file,id=3Dmem,size=3D512M,mem-path=
=3D/hugetlbfs,share=3Don \
> > +     -numa node,memdev=3Dmem \
> > +     -netdev type=3Dvhost-vdpa,id=3Dnet0,vhostdev=3D/path/to/dev \
> > +     -device virtio-net-pci,netdev=3Dnet0
> > +@end example
> >   @item -netdev hubport,id=3D@var{id},hubid=3D@var{hubid}[,netdev=3D@va=
r{nd}]
> >
> >   Create a hub port on the emulated hub with ID @var{hubid}.
>


