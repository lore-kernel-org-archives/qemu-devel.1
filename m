Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D40C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2353820678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDmhyzpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2353820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOdL-0006U6-Du
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jgOcZ-0005ie-6Y
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:19:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60722
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jgOcX-0001qE-BK
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591172372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61zuun59b7gBuVNvrOfAhbjeEz5Q0zfBezfgoJLRp9U=;
 b=fDmhyzpuXvDBJesk0QJSvBnrNj1rQc3eSsYfCx7WN2Wiom9dF56etJYHl+YekXQhK8i/+B
 GLAPwOGggExXi3Z1VuipLUYVOxwoDWNynE8UPwtpiF0Ov4avHipBZONphPcFkdogcLfczS
 8GbWQr22tjF5awHz6tFFsrIZf3V7kF4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-sCWqNyJcOMuDBIOtib5Vig-1; Wed, 03 Jun 2020 04:19:30 -0400
X-MC-Unique: sCWqNyJcOMuDBIOtib5Vig-1
Received: by mail-pf1-f200.google.com with SMTP id o192so1290556pfg.19
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 01:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=61zuun59b7gBuVNvrOfAhbjeEz5Q0zfBezfgoJLRp9U=;
 b=lmCXxUDRvZJKzfS03n41BOh8cXJEbIKhReJos3+ZvpXaLQR+8B4a0Wlo/2E0HNKFeC
 HjvDacYF0VmOQnbB/6aB7ro3XoMixevNzON2M/uyK8ZV3YXi38IosRq8odcl+icg5M+u
 FXKDxuoVwYUmfHp334b/jjs86VTnMXxU6JoHsnL4b6A7ABUePH1O9PUutqiqqDBRvjip
 G/RovV2D/WHFgfJSyVMHJAwzO2f9wWp3/b5I20t6kIM/fbcvbj21Ve+N6F9lSh94yTPR
 4s1yCjJgHE+jaowsF4fzeg+t2aR+NlLrfeUgA8AFZWc4iH11EF7b6foDGgEp97QO9sD/
 wxAA==
X-Gm-Message-State: AOAM533o+fYPgltwOGow1ZB1HECKda0WLgOI8HpEz1Uj2t+AsBytW1x5
 BDzCOs+BT9VBrC0zZhP+ceGcYDBM801YekPSSIuqQzelpLtnRxj8gdYEAFSoDSUMSnvG9GMVUrN
 93xRbRqfunLRzs3hhZAIC1Trvs6YR2rM=
X-Received: by 2002:a17:90a:c283:: with SMTP id
 f3mr3054326pjt.166.1591172369294; 
 Wed, 03 Jun 2020 01:19:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL1Yo1JO/5mQU2E+lLdyTUQxlGshsdSXSCXwn5kRt/Nm9AXP6ooKgs3ZRL3MWcZ5mLfuLqQnVl/+Oh1bb/OYE=
X-Received: by 2002:a17:90a:c283:: with SMTP id
 f3mr3054274pjt.166.1591172368915; 
 Wed, 03 Jun 2020 01:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-9-lulu@redhat.com>
 <4ae425c2-6b5f-5f64-9e26-f20b8f52f996@redhat.com>
In-Reply-To: <4ae425c2-6b5f-5f64-9e26-f20b8f52f996@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 3 Jun 2020 16:19:17 +0800
Message-ID: <CACLfguUeYjAaknk+GEM9K6myUdCqXtxn=OEGYO4h3pqOUm9NxA@mail.gmail.com>
Subject: Re: [RFC v3 8/8] vhost-vdpa: introduce vhost-vdpa net client
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 hanand@xilinx.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

On Wed, Jun 3, 2020 at 2:39 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/5/29 =E4=B8=8B=E5=8D=8810:06, Cindy Lu wrote:
> > From: Tiwei Bie <tiwei.bie@intel.com>
>
>
> Similar for this patch, you can change the git author and keep sobs for
> both Tiwei and Ling Shan.
>
>
Will Fix this

> >
> > This patch set introduces a new net client type: vhost-vdpa.
> > vhost-vdpa net client will set up a vDPA device which is specified
> > by a "vhostdev" parameter.
> >
> > Co-authored-by: Lingshan Zhu <lingshan.zhu@intel.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   include/net/vhost-vdpa.h |  19 ++++
> >   include/net/vhost_net.h  |   2 +-
> >   net/Makefile.objs        |   2 +-
> >   net/clients.h            |   2 +
> >   net/net.c                |   3 +
> >   net/vhost-vdpa.c         | 235 ++++++++++++++++++++++++++++++++++++++=
+
> >   qapi/net.json            |  26 ++++-
> >   7 files changed, 285 insertions(+), 4 deletions(-)
> >   create mode 100644 include/net/vhost-vdpa.h
> >   create mode 100644 net/vhost-vdpa.c
> >
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
> > index 56e67fe164..0b87d3c6e9 100644
> > --- a/include/net/vhost_net.h
> > +++ b/include/net/vhost_net.h
> > @@ -41,4 +41,4 @@ uint64_t vhost_net_get_acked_features(VHostNetState *=
net);
> >
> >   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
> >   int vhost_net_get_device_id(struct vhost_net *net, uint32_t *device_i=
d);
> > -endif
> > +#endif
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
> > index 599fb61028..82624ea9ac 100644
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
> > index 0000000000..7b98c142b5
> > --- /dev/null
> > +++ b/net/vhost-vdpa.c
> > @@ -0,0 +1,235 @@
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
> > +#include <sys/ioctl.h>
> > +#include <err.h>
> > +#include "standard-headers/linux/virtio_net.h"
> > +#include "monitor/monitor.h"
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
> > +static int vhost_vdpa_check_device_id(NetClientState *nc)
>
>
> A better name is needed, something like "vhost_vdpa_net_check_devie_id"
> is better.
>
Sure will fix this
>
> > +{
> > +    uint32_t device_id;
> > +    int ret;
> > +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > +    /* Get the device id from hw*/
>
>
> The code explains itself, so no need for this comment.
>
will remove this
>
> > +    ret =3D vhost_net_get_device_id(s->vhost_net, &device_id);
> > +    if (device_id !=3D VIRTIO_ID_NET) {
> > +        return -ENOTSUP;
> > +    }
> > +    return ret;
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
> > +        }
>
>
> I'm not sure I get here, is the acked_features used in the
> vhost_net_cleanup()?
>
I think we can remove this part, seems these bit are not using anymore
>
> > +        vhost_net_cleanup(s->vhost_net);
> > +    }
> > +}
> > +
> > +static int vhost_vdpa_add(NetClientState *ncs, void *be)
> > +{
> > +    VhostNetOptions options;
> > +    struct vhost_net *net =3D NULL;
> > +    VhostVDPAState *s;
> > +    int ret;
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
> > +    }
> > +
> > +    if (s->vhost_net) {
> > +        vhost_net_cleanup(s->vhost_net);
> > +        g_free(s->vhost_net);
> > +    }
> > +    s->vhost_net =3D net;
> > +    /* check the device id for vdpa */
>
>
> The comment could be removed as well.
>
>
Sure will remove this

> > +    ret =3D vhost_vdpa_check_device_id(ncs);
> > +    if (ret) {
> > +        goto err;
> > +    }
> > +    return 0;
> > +err:
> > +    if (net) {
> > +        vhost_net_cleanup(net);
> > +    }
> > +    vhost_vdpa_del(ncs);
> > +    return -1;
> > +}
> > +
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
>
>
> Why this is needed?
>
> Thanks
>
This is to clean the packet in the queue while the vdpa remove,  I
will double check this part
>
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
> > +    int ret =3D 0;
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
> > +    }
> > +    s->vhost_vdpa.device_fd =3D vdpa_device_fd;
> > +    ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa);
> > +    assert(s->vhost_net);
> > +
> > +    if (ret) {
> > +        if (has_fd) {
> > +            close(vdpa_device_fd);
> > +        }
> > +    }
> > +    return ret;
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
> > index cebb1b52e3..37507ce9ba 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -428,6 +428,27 @@
> >       '*vhostforce':    'bool',
> >       '*queues':        'int' } }
> >
> > +##
> > +# @NetdevVhostVDPAOptions:
> > +#
> > +# Vhost-vdpa network backend
> > +#
> > +# @vhostdev: name of a vdpa dev path in sysfs
> > +#            (default path:/dev/vhost-vdpa-$ID)
> > +#
> > +# @fd: file descriptor of an already opened vdpa device
> > +#
> > +# @queues: number of queues to be created for multiqueue vhost-vdpa
> > +#          (default: 1)
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'struct': 'NetdevVhostVDPAOptions',
> > +  'data': {
> > +    '*vhostdev':     'str',
> > +    '*fd':           'str',
> > +    '*queues':       'int' } }
> > +
> >   ##
> >   # @NetClientDriver:
> >   #
> > @@ -437,7 +458,7 @@
> >   ##
> >   { 'enum': 'NetClientDriver',
> >     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> > -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> > +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' =
] }
> >
> >   ##
> >   # @Netdev:
> > @@ -465,7 +486,8 @@
> >       'bridge':   'NetdevBridgeOptions',
> >       'hubport':  'NetdevHubPortOptions',
> >       'netmap':   'NetdevNetmapOptions',
> > -    'vhost-user': 'NetdevVhostUserOptions' } }
> > +    'vhost-user': 'NetdevVhostUserOptions',
> > +    'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
> >
> >   ##
> >   # @NetLegacy:
>


