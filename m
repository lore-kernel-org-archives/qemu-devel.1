Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021F1C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C632087E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmLHG+Zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C632087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQpWy-0006CK-Qh
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQpUL-0003mo-06
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQpUJ-0002Kz-63
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:46:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43233
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jQpUI-0002Jd-NV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587462401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbYYB35PJCZBX/xxfoXqHx4Ubx7rA9Ze0MGqYti6GSw=;
 b=NmLHG+ZlapNK3iZCy3oMw3y/0J/RAEmqvF0SZ5iqt1j3IE1iw67xUtNEQdrx4G55yez2EB
 Kn0x5ptrdFBezdYcoKLe7sW9VmqmvRCQ+ScKEAS7kuRK53NPiIFF7r5AnGr7VnOvOsd+1j
 osDp8/egXzquso7y5C6wLwls3vA3ZWU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-igGeI8v6MMO1zEnRxnpZxw-1; Tue, 21 Apr 2020 05:46:38 -0400
X-MC-Unique: igGeI8v6MMO1zEnRxnpZxw-1
Received: by mail-pl1-f197.google.com with SMTP id x3so11076459plm.9
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 02:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sbYYB35PJCZBX/xxfoXqHx4Ubx7rA9Ze0MGqYti6GSw=;
 b=XVYep4O39uADMpsXQPHX3dQMBeldPbRbj7+jJ+4R0lZ+qD11paRshH0bo/hkOzXus4
 P/lIzNvlVnd4hL4MHUS43JfVdtkD/50CKfOnDtFjbVOPGeLBvmjlxiZGkAx8LSTX4Uyq
 /gG91KqzFvZ+OajL0Y/EnjOrUm2iOrluJUb2sbPSs8wNwFVbT4XlKNCYb3XAQY6M6Lxp
 KvZN/UW8GVqO6WUlSg3FtFGNW6jApSHvHyrd+5f+Sp1X7HKZxVEVsWkTjhqOaO37F9sj
 YaORIITzORkE7ZMnpSCIGbN0FWoIByQob61Y6xXToGmMQtfNOzWp6xMezvq28/DmFab2
 StNg==
X-Gm-Message-State: AGi0PuYObgbf40RnKvnuwkM+QDneXGawD/IrdGxLifr6X5ONf96hLAaA
 TyIfXd5Q6q8yNrB2IroICXyYpIg4IhM1OM8Cq3cAAvPiw41cBB/9Ach+ofJ+DUAflfGui75Akkm
 sxAC1szutzfY0uLGT1rAPH7er5toiXr0=
X-Received: by 2002:aa7:962c:: with SMTP id r12mr21435240pfg.232.1587462397640; 
 Tue, 21 Apr 2020 02:46:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypLPpLNrk0iFFhtkNB0gKA7BodvvWyWPUNVbngzNTZkPpdja3xrZsftl1RQVTBj2YbcgdIZIvBFZYl0grQ3Dj08=
X-Received: by 2002:aa7:962c:: with SMTP id r12mr21435217pfg.232.1587462397350; 
 Tue, 21 Apr 2020 02:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-3-lulu@redhat.com>
 <df8f85fa-290b-26f2-59da-b6cb8a45043d@redhat.com>
In-Reply-To: <df8f85fa-290b-26f2-59da-b6cb8a45043d@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 21 Apr 2020 17:46:26 +0800
Message-ID: <CACLfguWPWBnN4d3KN3FcgwV3yKwh8UC0+WEApym5Dw2WpSciBA@mail.gmail.com>
Subject: Re: [RFC v1 2/4] vhost-vdpa: introduce vhost-vdpa net client
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000049efcf05a3c9e401"
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, armbru@redhat.com, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, "Wang, Zhihong" <zhihong.wang@intel.com>,
 maxime.coquelin@redhat.com, Ariel Adam <aadam@redhat.com>, cohuck@redhat.com,
 hanand@xilinx.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000049efcf05a3c9e401
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 11:40 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:
> > This patch set introduces a new net client type: vhost-vdpa.
> > vhost-vdpa net client will set up a vDPA device which is
> svhostdevpecified
>
>
> typo.
>
> Will fix this

>
> > by a "vhostdev" parameter.
> >
> > Author: Tiwei Bie
>
>
> Please keep the sobs from the original patch.
>
>
> Will fix this

> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   include/net/vhost-vdpa.h |  18 ++++
> >   include/net/vhost_net.h  |   1 +
> >   net/Makefile.objs        |   2 +-
> >   net/clients.h            |   2 +
> >   net/net.c                |   1 +
> >   net/vhost-vdpa.c         | 211 ++++++++++++++++++++++++++++++++++++++=
+
> >   qapi/net.json            |  21 +++-
> >   7 files changed, 253 insertions(+), 3 deletions(-)
> >   create mode 100644 include/net/vhost-vdpa.h
> >   create mode 100644 net/vhost-vdpa.c
>
>
> I think this patch should come after patch 3.
>
> And it's better to make this as a module like vhost-user.
>
> Got it, Will fix this

>
> >
> > diff --git a/include/net/vhost-vdpa.h b/include/net/vhost-vdpa.h
> > new file mode 100644
> > index 0000000000..9ddd538dad
> > --- /dev/null
> > +++ b/include/net/vhost-vdpa.h
> > @@ -0,0 +1,18 @@
> > +/*
> > + * vhost-vdpa.h
> > + *
> > + * Copyright(c) 2017 Intel Corporation. All rights reserved.
>
>
> 2020 and please add Red Hat here as well.
>
>
> Will fix this

> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
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
> > index 77e47398c4..6f3a624cf7 100644
> > --- a/include/net/vhost_net.h
> > +++ b/include/net/vhost_net.h
> > @@ -39,5 +39,6 @@ int vhost_set_vring_enable(NetClientState * nc, int
> enable);
> >   uint64_t vhost_net_get_acked_features(VHostNetState *net);
> >
> >   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
> > +int vhost_set_state(NetClientState *nc, int state);
>
>
> This function is not used in this patch.
>
> Will fix this

>
> >
> >   #endif
> > diff --git a/net/Makefile.objs b/net/Makefile.objs
> > index c5d076d19c..da459cfc19 100644
> > --- a/net/Makefile.objs
> > +++ b/net/Makefile.objs
> > @@ -26,7 +26,7 @@ tap-obj-$(CONFIG_SOLARIS) =3D tap-solaris.o
> >   tap-obj-y ?=3D tap-stub.o
> >   common-obj-$(CONFIG_POSIX) +=3D tap.o $(tap-obj-y)
> >   common-obj-$(CONFIG_WIN32) +=3D tap-win32.o
> > -
> > +common-obj-$(CONFIG_VHOST_KERNEL) +=3D vhost-vdpa.o
> >   vde.o-libs =3D $(VDE_LIBS)
> >
> >   common-obj-$(CONFIG_CAN_BUS) +=3D can/
> > diff --git a/net/clients.h b/net/clients.h
> > index a6ef267e19..92f9b59aed 100644
> > --- a/net/clients.h
> > +++ b/net/clients.h
> > @@ -61,4 +61,6 @@ int net_init_netmap(const Netdev *netdev, const char
> *name,
> >   int net_init_vhost_user(const Netdev *netdev, const char *name,
> >                           NetClientState *peer, Error **errp);
> >
> > +int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
> > +                        NetClientState *peer, Error **errp);
> >   #endif /* QEMU_NET_CLIENTS_H */
> > diff --git a/net/net.c b/net/net.c
> > index ac5080dda1..2beb95388a 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -964,6 +964,7 @@ static int (* const
> net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
> >           [NET_CLIENT_DRIVER_HUBPORT]   =3D net_init_hubport,
> >   #ifdef CONFIG_VHOST_NET_USER
> >           [NET_CLIENT_DRIVER_VHOST_USER] =3D net_init_vhost_user,
> > +        [NET_CLIENT_DRIVER_VHOST_VDPA] =3D net_init_vhost_vdpa,
> >   #endif
> >   #ifdef CONFIG_L2TPV3
> >           [NET_CLIENT_DRIVER_L2TPV3]    =3D net_init_l2tpv3,
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > new file mode 100644
> > index 0000000000..5daeba0b76
> > --- /dev/null
> > +++ b/net/vhost-vdpa.c
> > @@ -0,0 +1,211 @@
> > +/*
> > + * vhost-vdpa.c
> > + *
> > + * Copyright(c) 2017-2018 Intel Corporation. All rights reserved.
> > + * Copyright(c) 2020 Red Hat, Inc.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "clients.h"
> > +#include "net/vhost_net.h"
> > +#include "net/vhost-vdpa.h"
> > +#include "hw/virtio/vhost-vdpa.h"
> > +#include "chardev/char-fe.h"
>
>
> I don't think we use charfe in this file.
>
>
> > +#include "qemu/config-file.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/option.h"
> > +#include "qapi/error.h"
> > +#include "trace.h"
>
>
> I think we don't use tracing in this file.
>
> Will fix this

>
> > +#include <linux/vfio.h>
> > +#include <sys/ioctl.h>
> > +#include <err.h>
> > +#include <linux/virtio_net.h>
> > +
> > +
> > +typedef struct VhostVDPAState {
> > +    NetClientState nc;
>
>
> This may not work for the case of multiqueue, you can either fix this or
> just leave a comment for TODO.
>
> Will fix this

>
> > +    struct vhost_vdpa vhost_vdpa;
>
>
> This explains why patch 3 should come first.
>
>
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
> > +static void vhost_vdpa_stop(NetClientState *ncs)
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
> > +static int vhost_vdpa_start(NetClientState *ncs, void *be)
> > +{
>
>
> The name of this function is confusing, we don't start vhost_vdpa actuall=
y.
>
> ok Got it , I will change it

>
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
> > +    vhost_vdpa_stop(ncs);
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
> > +                               const char *name, const char *vhostdev)
> > +{
> > +    NetClientState *nc =3D NULL;
> > +    VhostVDPAState *s;
> > +    int vdpa_device_fd;
> > +    assert(name);
> > +
> > +    nc =3D qemu_new_net_client(&net_vhost_vdpa_info, peer, device, nam=
e);
> > +    snprintf(nc->info_str, sizeof(nc->info_str), "vhost-vdpa");
> > +    nc->queue_index =3D 0;
> > +
> > +    s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > +
> > +    vdpa_device_fd =3D open(vhostdev, O_RDWR);
> > +    if (vdpa_device_fd =3D=3D -1) {
> > +        return -errno;
> > +    }
> > +    s->vhost_vdpa.device_fd =3D vdpa_device_fd;
>
>
> Need to add a step to verify the device type and fail if it was not a
> networking device.
>
> sure will add the check .

>
> > +    vhost_vdpa_start(nc, (void *)&s->vhost_vdpa);
> > +
> > +    assert(s->vhost_net);
> > +
> > +    return 0;
> > +}
> > +
> > +static int net_vhost_check_net(void *opaque, QemuOpts *opts, Error
> **errp)
> > +{
> > +    const char *name =3D opaque;
> > +    const char *driver, *netdev;
> > +
> > +    driver =3D qemu_opt_get(opts, "driver");
> > +    netdev =3D qemu_opt_get(opts, "netdev");
> > +
> > +    if (!driver || !netdev) {
> > +        return 0;
> > +    }
> > +
> > +    if (strcmp(netdev, name) =3D=3D 0 &&
> > +        !g_str_has_prefix(driver, "virtio-net-")) {
> > +        error_setg(errp, "vhost-vdpa requires frontend driver
> virtio-net-*");
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
> > +                        NetClientState *peer, Error **errp)
> > +{
> > +    const NetdevVhostVDPAOptions *vhost_vdpa_opts;
> > +
> > +    assert(netdev->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > +    vhost_vdpa_opts =3D &netdev->u.vhost_vdpa;
> > +
> > +    /* verify net frontend */
> > +    if (qemu_opts_foreach(qemu_find_opts("device"), net_vhost_check_ne=
t,
> > +                          (char *)name, errp)) {
> > +        return -1;
> > +    }
> > +
> > +
> > +    return net_vhost_vdpa_init(peer, "vhost_vdpa", name,
> > +                               vhost_vdpa_opts->vhostdev);
>
>
> Please add the support for passing fd via command line.
>

Will add the support

>
>
> +
> > +    return 0;
> > +}
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 335295be50..35a5ccee39 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -441,6 +441,22 @@
> >       '*queues':        'int' } }
> >
> >   ##
> > +# @NetdevVhostVDPAOptions:
> > +#
> > +# Vhost-vdpa network backend
> > +#
> > +# @vhostdev: name of a mdev dev path in sysfs
> > +#
> > +# @queues: number of queues to be created for multiqueue vhost-vdpa
> > +#          (default: 1) (Since 2.11)
> > +#
> > +# Since: 2.11
>
>
> The version number is wrong, I guess it's probably 5.1.
>
> Thanks
>
> Will fix this

>
> > +##
> > +{ 'struct': 'NetdevVhostVDPAOptions',
> > +  'data': {
> > +    '*vhostdev':     'str',
> > +    '*queues':       'int' } }
> > +##
> >   # @NetClientDriver:
> >   #
> >   # Available netdev drivers.
> > @@ -451,7 +467,7 @@
> >   ##
> >   { 'enum': 'NetClientDriver',
> >     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> > -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> > +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' =
]
> }
> >
> >   ##
> >   # @Netdev:
> > @@ -479,7 +495,8 @@
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
>

--00000000000049efcf05a3c9e401
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 21, 2020 at 11:40 AM Jaso=
n Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:<br>
&gt; This patch set introduces a new net client type: vhost-vdpa.<br>
&gt; vhost-vdpa net client will set up a vDPA device which is svhostdevpeci=
fied<br>
<br>
<br>
typo.<br>
<br></blockquote><div>Will fix this=C2=A0=C2=A0=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt; by a &quot;vhostdev&quot; parameter.<br>
&gt;<br>
&gt; Author: Tiwei Bie<br>
<br>
<br>
Please keep the sobs from the original patch.<br>
<br>
<br></blockquote><div>Will fix this=C2=A0=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
&gt; Signed-off-by: Cindy Lu &lt;<a href=3D"mailto:lulu@redhat.com" target=
=3D"_blank">lulu@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/net/vhost-vdpa.h |=C2=A0 18 ++++<br>
&gt;=C2=A0 =C2=A0include/net/vhost_net.h=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0net/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +-<br>
&gt;=C2=A0 =C2=A0net/clients.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0net/net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 211 ++=
+++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0qapi/net.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 21 +++-<br>
&gt;=C2=A0 =C2=A07 files changed, 253 insertions(+), 3 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/net/vhost-vdpa.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 net/vhost-vdpa.c<br>
<br>
<br>
I think this patch should come after patch 3.<br>
<br>
And it&#39;s better to make this as a module like vhost-user.<br>
<br></blockquote><div>Got it,=C2=A0Will fix this=C2=A0=C2=A0=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; diff --git a/include/net/vhost-vdpa.h b/include/net/vhost-vdpa.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..9ddd538dad<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/net/vhost-vdpa.h<br>
&gt; @@ -0,0 +1,18 @@<br>
&gt; +/*<br>
&gt; + * vhost-vdpa.h<br>
&gt; + *<br>
&gt; + * Copyright(c) 2017 Intel Corporation. All rights reserved.<br>
<br>
<br>
2020 and please add Red Hat here as well.<br>
<br>
<br></blockquote><div>Will fix this=C2=A0=C2=A0=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef VHOST_VDPA_H<br>
&gt; +#define VHOST_VDPA_H<br>
&gt; +<br>
&gt; +struct vhost_net;<br>
&gt; +struct vhost_net *vhost_vdpa_get_vhost_net(NetClientState *nc);<br>
&gt; +uint64_t vhost_vdpa_get_acked_features(NetClientState *nc);<br>
&gt; +<br>
&gt; +#endif /* VHOST_VDPA_H */<br>
&gt; diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h<br>
&gt; index 77e47398c4..6f3a624cf7 100644<br>
&gt; --- a/include/net/vhost_net.h<br>
&gt; +++ b/include/net/vhost_net.h<br>
&gt; @@ -39,5 +39,6 @@ int vhost_set_vring_enable(NetClientState * nc, int =
enable);<br>
&gt;=C2=A0 =C2=A0uint64_t vhost_net_get_acked_features(VHostNetState *net);=
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)=
;<br>
&gt; +int vhost_set_state(NetClientState *nc, int state);<br>
<br>
<br>
This function is not used in this patch.<br>
<br></blockquote><div>Will fix this=C2=A0=C2=A0=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; diff --git a/net/Makefile.objs b/net/Makefile.objs<br>
&gt; index c5d076d19c..da459cfc19 100644<br>
&gt; --- a/net/Makefile.objs<br>
&gt; +++ b/net/Makefile.objs<br>
&gt; @@ -26,7 +26,7 @@ tap-obj-$(CONFIG_SOLARIS) =3D tap-solaris.o<br>
&gt;=C2=A0 =C2=A0tap-obj-y ?=3D tap-stub.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_POSIX) +=3D tap.o $(tap-obj-y)<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_WIN32) +=3D tap-win32.o<br>
&gt; -<br>
&gt; +common-obj-$(CONFIG_VHOST_KERNEL) +=3D vhost-vdpa.o<br>
&gt;=C2=A0 =C2=A0vde.o-libs =3D $(VDE_LIBS)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_CAN_BUS) +=3D can/<br>
&gt; diff --git a/net/clients.h b/net/clients.h<br>
&gt; index a6ef267e19..92f9b59aed 100644<br>
&gt; --- a/net/clients.h<br>
&gt; +++ b/net/clients.h<br>
&gt; @@ -61,4 +61,6 @@ int net_init_netmap(const Netdev *netdev, const char=
 *name,<br>
&gt;=C2=A0 =C2=A0int net_init_vhost_user(const Netdev *netdev, const char *=
name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0NetClientState *peer, Error **errp);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +int net_init_vhost_vdpa(const Netdev *netdev, const char *name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 NetClientState *peer, Error **errp);<br>
&gt;=C2=A0 =C2=A0#endif /* QEMU_NET_CLIENTS_H */<br>
&gt; diff --git a/net/net.c b/net/net.c<br>
&gt; index ac5080dda1..2beb95388a 100644<br>
&gt; --- a/net/net.c<br>
&gt; +++ b/net/net.c<br>
&gt; @@ -964,6 +964,7 @@ static int (* const net_client_init_fun[NET_CLIENT=
_DRIVER__MAX])(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[NET_CLIENT_DRIVER_HUBPORT]=C2=
=A0 =C2=A0=3D net_init_hubport,<br>
&gt;=C2=A0 =C2=A0#ifdef CONFIG_VHOST_NET_USER<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[NET_CLIENT_DRIVER_VHOST_USER]=
 =3D net_init_vhost_user,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [NET_CLIENT_DRIVER_VHOST_VDPA] =3D net_in=
it_vhost_vdpa,<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0#ifdef CONFIG_L2TPV3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[NET_CLIENT_DRIVER_L2TPV3]=C2=
=A0 =C2=A0 =3D net_init_l2tpv3,<br>
&gt; diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..5daeba0b76<br>
&gt; --- /dev/null<br>
&gt; +++ b/net/vhost-vdpa.c<br>
&gt; @@ -0,0 +1,211 @@<br>
&gt; +/*<br>
&gt; + * vhost-vdpa.c<br>
&gt; + *<br>
&gt; + * Copyright(c) 2017-2018 Intel Corporation. All rights reserved.<br>
&gt; + * Copyright(c) 2020 Red Hat, Inc.<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;clients.h&quot;<br>
&gt; +#include &quot;net/vhost_net.h&quot;<br>
&gt; +#include &quot;net/vhost-vdpa.h&quot;<br>
&gt; +#include &quot;hw/virtio/vhost-vdpa.h&quot;<br>
&gt; +#include &quot;chardev/char-fe.h&quot;<br>
<br>
<br>
I don&#39;t think we use charfe in this file.<br>
<br>
<br>
&gt; +#include &quot;qemu/config-file.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +#include &quot;qemu/option.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
<br>
<br>
I think we don&#39;t use tracing in this file.<br>
<br></blockquote><div>Will fix this=C2=A0=C2=A0=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt; +#include &lt;linux/vfio.h&gt;<br>
&gt; +#include &lt;sys/ioctl.h&gt;<br>
&gt; +#include &lt;err.h&gt;<br>
&gt; +#include &lt;linux/virtio_net.h&gt;<br>
&gt; +<br>
&gt; +<br>
&gt; +typedef struct VhostVDPAState {<br>
&gt; +=C2=A0 =C2=A0 NetClientState nc;<br>
<br>
<br>
This may not work for the case of multiqueue, you can either fix this or <b=
r>
just leave a comment for TODO.<br>
<br></blockquote><div>Will fix this=C2=A0=C2=A0=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 struct vhost_vdpa vhost_vdpa;<br>
<br>
<br>
This explains why patch 3 should come first.<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 VHostNetState *vhost_net;<br>
&gt; +=C2=A0 =C2=A0 uint64_t acked_features;<br>
&gt; +=C2=A0 =C2=A0 bool started;<br>
&gt; +} VhostVDPAState;<br>
&gt; +<br>
&gt; +VHostNetState *vhost_vdpa_get_vhost_net(NetClientState *nc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc)=
;<br>
&gt; +=C2=A0 =C2=A0 assert(nc-&gt;info-&gt;type =3D=3D NET_CLIENT_DRIVER_VH=
OST_VDPA);<br>
&gt; +=C2=A0 =C2=A0 return s-&gt;vhost_net;<br>
&gt; +}<br>
&gt; +<br>
&gt; +uint64_t vhost_vdpa_get_acked_features(NetClientState *nc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc)=
;<br>
&gt; +=C2=A0 =C2=A0 assert(nc-&gt;info-&gt;type =3D=3D NET_CLIENT_DRIVER_VH=
OST_VDPA);<br>
&gt; +=C2=A0 =C2=A0 return s-&gt;acked_features;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vhost_vdpa_stop(NetClientState *ncs)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VhostVDPAState *s;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(ncs-&gt;info-&gt;type =3D=3D NET_CLIENT_DRIVER_V=
HOST_VDPA);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s =3D DO_UPCAST(VhostVDPAState, nc, ncs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;vhost_net) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* save acked features */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t features =3D vhost_net_get_acked=
_features(s-&gt;vhost_net);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (features) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;acked_features =3D fe=
atures;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_net_cleanup(s-&gt;vhost_net);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_start(NetClientState *ncs, void *be)<br>
&gt; +{<br>
<br>
<br>
The name of this function is confusing, we don&#39;t start vhost_vdpa actua=
lly.<br>
<br></blockquote><div>ok Got it , I will change it=C2=A0=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 VhostNetOptions options;<br>
&gt; +=C2=A0 =C2=A0 struct vhost_net *net =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 VhostVDPAState *s;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 options.backend_type =3D VHOST_BACKEND_TYPE_VDPA;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(ncs-&gt;info-&gt;type =3D=3D NET_CLIENT_DRIVER_V=
HOST_VDPA);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s =3D DO_UPCAST(VhostVDPAState, nc, ncs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 options.net_backend =3D ncs;<br>
&gt; +=C2=A0 =C2=A0 options.opaque=C2=A0 =C2=A0 =C2=A0 =3D be;<br>
&gt; +=C2=A0 =C2=A0 options.busyloop_timeout =3D 0;<br>
&gt; +=C2=A0 =C2=A0 net =3D vhost_net_init(&amp;options);<br>
&gt; +=C2=A0 =C2=A0 if (!net) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;failed to init vhost_n=
et for queue&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (s-&gt;vhost_net) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_net_cleanup(s-&gt;vhost_net);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(s-&gt;vhost_net);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0s-&gt;vhost_net =3D net;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +<br>
&gt; +err:<br>
&gt; +=C2=A0 =C2=A0 if (net) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_net_cleanup(net);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 vhost_vdpa_stop(ncs);<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +}<br>
&gt; +static void vhost_vdpa_cleanup(NetClientState *nc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;vhost_net) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_net_cleanup(s-&gt;vhost_net);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(s-&gt;vhost_net);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;vhost_net =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_purge_queued_packets(nc);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 assert(nc-&gt;info-&gt;type =3D=3D NET_CLIENT_DRIVER_VH=
OST_VDPA);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool vhost_vdpa_has_ufo(NetClientState *nc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 assert(nc-&gt;info-&gt;type =3D=3D NET_CLIENT_DRIVER_VH=
OST_VDPA);<br>
&gt; +=C2=A0 =C2=A0 VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc)=
;<br>
&gt; +=C2=A0 =C2=A0 uint64_t=C2=A0 features =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 features |=3D (1ULL &lt;&lt; VIRTIO_NET_F_HOST_UFO);<br=
>
&gt; +=C2=A0 =C2=A0 features =3D vhost_net_get_features(s-&gt;vhost_net, fe=
atures);<br>
&gt; +=C2=A0 =C2=A0 return !!(features &amp; (1ULL &lt;&lt; VIRTIO_NET_F_HO=
ST_UFO));<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +static NetClientInfo net_vhost_vdpa_info =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D NET_CLIENT_DRIVER_VHOST_VDPA,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(VhostVDPAState),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cleanup =3D vhost_vdpa_cleanup,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .has_vnet_hdr =3D vhost_vdpa_has_vnet_hdr=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .has_ufo =3D vhost_vdpa_has_ufo,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int net_vhost_vdpa_init(NetClientState *peer, const char *devi=
ce,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, const char *vho=
stdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 NetClientState *nc =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 VhostVDPAState *s;<br>
&gt; +=C2=A0 =C2=A0 int vdpa_device_fd;<br>
&gt; +=C2=A0 =C2=A0 assert(name);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 nc =3D qemu_new_net_client(&amp;net_vhost_vdpa_info, pe=
er, device, name);<br>
&gt; +=C2=A0 =C2=A0 snprintf(nc-&gt;info_str, sizeof(nc-&gt;info_str), &quo=
t;vhost-vdpa&quot;);<br>
&gt; +=C2=A0 =C2=A0 nc-&gt;queue_index =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s =3D DO_UPCAST(VhostVDPAState, nc, nc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vdpa_device_fd =3D open(vhostdev, O_RDWR);<br>
&gt; +=C2=A0 =C2=A0 if (vdpa_device_fd =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -errno;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 s-&gt;vhost_vdpa.device_fd =3D vdpa_device_fd;<br>
<br>
<br>
Need to add a step to verify the device type and fail if it was not a <br>
networking device.<br>
<br></blockquote><div>sure will add the check .=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 vhost_vdpa_start(nc, (void *)&amp;s-&gt;vhost_vdpa);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(s-&gt;vhost_net);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int net_vhost_check_net(void *opaque, QemuOpts *opts, Error **=
errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const char *name =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 const char *driver, *netdev;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 driver =3D qemu_opt_get(opts, &quot;driver&quot;);<br>
&gt; +=C2=A0 =C2=A0 netdev =3D qemu_opt_get(opts, &quot;netdev&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!driver || !netdev) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (strcmp(netdev, name) =3D=3D 0 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !g_str_has_prefix(driver, &quot;virtio-ne=
t-&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;vhost-vdpa require=
s frontend driver virtio-net-*&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int net_init_vhost_vdpa(const Netdev *netdev, const char *name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 NetClientState *peer, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const NetdevVhostVDPAOptions *vhost_vdpa_opts;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(netdev-&gt;type =3D=3D NET_CLIENT_DRIVER_VHOST_V=
DPA);<br>
&gt; +=C2=A0 =C2=A0 vhost_vdpa_opts =3D &amp;netdev-&gt;u.vhost_vdpa;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* verify net frontend */<br>
&gt; +=C2=A0 =C2=A0 if (qemu_opts_foreach(qemu_find_opts(&quot;device&quot;=
), net_vhost_check_net,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (char *)name, errp)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return net_vhost_vdpa_init(peer, &quot;vhost_vdpa&quot;=
, name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_vdpa_opts-&gt;vhostdev);<br=
>
<br>
<br>
Please add the support for passing fd via command line.<br>=C2=A0</blockquo=
te><div>Will add the support=C2=A0=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">=C2=A0<br></blockquote><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; diff --git a/qapi/net.json b/qapi/net.json<br>
&gt; index 335295be50..35a5ccee39 100644<br>
&gt; --- a/qapi/net.json<br>
&gt; +++ b/qapi/net.json<br>
&gt; @@ -441,6 +441,22 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*queues&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;int&#39; } }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0##<br>
&gt; +# @NetdevVhostVDPAOptions:<br>
&gt; +#<br>
&gt; +# Vhost-vdpa network backend<br>
&gt; +#<br>
&gt; +# @vhostdev: name of a mdev dev path in sysfs<br>
&gt; +#<br>
&gt; +# @queues: number of queues to be created for multiqueue vhost-vdpa<b=
r>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (default: 1) (Since 2.11)<br>
&gt; +#<br>
&gt; +# Since: 2.11<br>
<br>
<br>
The version number is wrong, I guess it&#39;s probably 5.1.<br>
<br>
Thanks<br>
<br></blockquote><div>Will fix this=C2=A0=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;NetdevVhostVDPAOptions&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: {<br>
&gt; +=C2=A0 =C2=A0 &#39;*vhostdev&#39;:=C2=A0 =C2=A0 =C2=A0&#39;str&#39;,<=
br>
&gt; +=C2=A0 =C2=A0 &#39;*queues&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;int&#=
39; } }<br>
&gt; +##<br>
&gt;=C2=A0 =C2=A0# @NetClientDriver:<br>
&gt;=C2=A0 =C2=A0#<br>
&gt;=C2=A0 =C2=A0# Available netdev drivers.<br>
&gt; @@ -451,7 +467,7 @@<br>
&gt;=C2=A0 =C2=A0##<br>
&gt;=C2=A0 =C2=A0{ &#39;enum&#39;: &#39;NetClientDriver&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;data&#39;: [ &#39;none&#39;, &#39;nic&#39;, &#=
39;user&#39;, &#39;tap&#39;, &#39;l2tpv3&#39;, &#39;socket&#39;, &#39;vde&#=
39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;bridge&#39;, &#39;hubp=
ort&#39;, &#39;netmap&#39;, &#39;vhost-user&#39; ] }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;bridge&#39;, &#39;hubp=
ort&#39;, &#39;netmap&#39;, &#39;vhost-user&#39;, &#39;vhost-vdpa&#39; ] }<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0##<br>
&gt;=C2=A0 =C2=A0# @Netdev:<br>
&gt; @@ -479,7 +495,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;bridge&#39;:=C2=A0 =C2=A0&#39;NetdevBri=
dgeOptions&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;hubport&#39;:=C2=A0 &#39;NetdevHubPortO=
ptions&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;netmap&#39;:=C2=A0 =C2=A0&#39;NetdevNet=
mapOptions&#39;,<br>
&gt; -=C2=A0 =C2=A0 &#39;vhost-user&#39;: &#39;NetdevVhostUserOptions&#39; =
} }<br>
&gt; +=C2=A0 =C2=A0 &#39;vhost-user&#39;: &#39;NetdevVhostUserOptions&#39;,=
<br>
&gt; +=C2=A0 =C2=A0 &#39;vhost-vdpa&#39;: &#39;NetdevVhostVDPAOptions&#39; =
} }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0##<br>
&gt;=C2=A0 =C2=A0# @NetLegacy:<br>
<br>
</blockquote></div></div>

--00000000000049efcf05a3c9e401--


