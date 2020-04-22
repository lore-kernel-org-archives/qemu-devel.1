Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25723C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA249206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoPOI82+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA249206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRBaT-0008UB-2w
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 05:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jRBZm-00084j-Nw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jRBZk-0008DL-H9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:21:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52138
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jRBZj-00089s-BP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587547305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IolfGC/AeWoPCnPq9Y+JeeGRdzhTUW/7rrnWBYFLkE=;
 b=BoPOI82+iDgfV2K8Hntcm8cW+hi7+Cz9vWIY4WMf/4RUpyEOnM35pTSq5QeG0Ho5zDdVQF
 ZwxEWoImF4WmIeLNrOIYQtL3Y0bAV+TSHq5v/qQtEZxJJdR1fP3DCgWM8lOFn77wB0NCHv
 ePlaUCaFoH1FtYknvFDgxDScf4iESZA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-y_SLIHPZNF-4OcemPS_TdQ-1; Wed, 22 Apr 2020 05:21:44 -0400
X-MC-Unique: y_SLIHPZNF-4OcemPS_TdQ-1
Received: by mail-pf1-f199.google.com with SMTP id 84so1504353pfx.20
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 02:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0gaFCUjCiJBcubWdy5N7In/xylyQVQxo1Gay4kHfiiI=;
 b=XKVPUdbDwHfONX5cDq4RKqhRmHr2IqjNuNnp+Ip+woUrvpknEAX3NBNAmVUT8Fpfhq
 EsWiOgAiy69gDQcDcKBOUpLsdN8mmioytHnMYyKbPO3XbYyVQ4FgzRnzAgk7RALvk55H
 brDIM+6Ze0Utyf6iB3xTrPpPVwzrSsUNmgrJF1+4SG+CQl41Qqg0HafF/7B9kOR9Jfpb
 stzBk5ixHaJgxbZy+/RSEQFRN0R7UgcAGaaRWglB3o8REdkSy96Lfc6Z8aMbwqDp3rcE
 xKvRs7Zv+FnIvF1l+U6VzelXZp8RqsvYl1uz8S4LEZrH/30N+9d+Z+UPFeM/v68QDdlu
 eDCw==
X-Gm-Message-State: AGi0PuZPjMuQj14LxM7BKl5r7y0dayBhU8nKRIy5JYVZBNqOJ+ylQmFO
 CcSURHbsaNQ09KKrswJ0UE7MEhR2tcLZOjITAsRBYMKmPyy1/P5XURxWM6DCw4x8TW0PJZnKmSp
 NGSe7r1NQS9DyOZXjJm6tlzZdfrNvG9Q=
X-Received: by 2002:a17:902:d303:: with SMTP id
 b3mr10094205plc.12.1587547302956; 
 Wed, 22 Apr 2020 02:21:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ45dIZeLjuX/qZjYMWAtf0r0XpV2gGaL51vLFbrrivL5m6pErccaa6mJ4u9sZz1+Z+DRovEjg3rF3sVAc8Wko=
X-Received: by 2002:a17:902:d303:: with SMTP id
 b3mr10094165plc.12.1587547302631; 
 Wed, 22 Apr 2020 02:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-3-lulu@redhat.com>
 <6934c4db-4bdb-2f01-3920-9d33c69a5ac9@redhat.com>
In-Reply-To: <6934c4db-4bdb-2f01-3920-9d33c69a5ac9@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 22 Apr 2020 17:21:31 +0800
Message-ID: <CACLfguUcdrvHCpHCnh=kXUepR9EQDb+4UJ5xZN+rhsi57G0DVA@mail.gmail.com>
Subject: Re: [RFC v1 2/4] vhost-vdpa: introduce vhost-vdpa net client
To: Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
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
 saugatm@xilinx.com, Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Jason Wang <jasowang@redhat.com>, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Ariel Adam <aadam@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 11:47 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 20/04/2020 11:32, Cindy Lu wrote:
> > This patch set introduces a new net client type: vhost-vdpa.
> > vhost-vdpa net client will set up a vDPA device which is svhostdevpecif=
ied
> > by a "vhostdev" parameter.
> >
> > Author: Tiwei Bie
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  include/net/vhost-vdpa.h |  18 ++++
> >  include/net/vhost_net.h  |   1 +
> >  net/Makefile.objs        |   2 +-
> >  net/clients.h            |   2 +
> >  net/net.c                |   1 +
> >  net/vhost-vdpa.c         | 211 +++++++++++++++++++++++++++++++++++++++
> >  qapi/net.json            |  21 +++-
> >  7 files changed, 253 insertions(+), 3 deletions(-)
> >  create mode 100644 include/net/vhost-vdpa.h
> >  create mode 100644 net/vhost-vdpa.c
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
> > index 77e47398c4..6f3a624cf7 100644
> > --- a/include/net/vhost_net.h
> > +++ b/include/net/vhost_net.h
> > @@ -39,5 +39,6 @@ int vhost_set_vring_enable(NetClientState * nc, int e=
nable);
> >  uint64_t vhost_net_get_acked_features(VHostNetState *net);
> >
> >  int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
> > +int vhost_set_state(NetClientState *nc, int state);
> >
> >  #endif
> > diff --git a/net/Makefile.objs b/net/Makefile.objs
> > index c5d076d19c..da459cfc19 100644
> > --- a/net/Makefile.objs
> > +++ b/net/Makefile.objs
> > @@ -26,7 +26,7 @@ tap-obj-$(CONFIG_SOLARIS) =3D tap-solaris.o
> >  tap-obj-y ?=3D tap-stub.o
> >  common-obj-$(CONFIG_POSIX) +=3D tap.o $(tap-obj-y)
> >  common-obj-$(CONFIG_WIN32) +=3D tap-win32.o
> > -
> > +common-obj-$(CONFIG_VHOST_KERNEL) +=3D vhost-vdpa.o
>
> should it be CONFIG_VHOST_NET_USER as you use net_init_vhost_vdpa()
> below inside a "#ifdef CONFIG_VHOST_NET_USER"?
>
> Why don't you define a CONFIG_VHOST_VDPA?
>
Thanks Laurent for point it out,  There is no dependence between
CONFIG_VHOST_NET_USER and vDPA,
So I will implement a new macro specific for vDPA

> >  vde.o-libs =3D $(VDE_LIBS)
> >
> >  common-obj-$(CONFIG_CAN_BUS) +=3D can/
> > diff --git a/net/clients.h b/net/clients.h
> > index a6ef267e19..92f9b59aed 100644
> > --- a/net/clients.h
> > +++ b/net/clients.h
> > @@ -61,4 +61,6 @@ int net_init_netmap(const Netdev *netdev, const char =
*name,
> >  int net_init_vhost_user(const Netdev *netdev, const char *name,
> >                          NetClientState *peer, Error **errp);
> >
> > +int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
> > +                        NetClientState *peer, Error **errp);
> >  #endif /* QEMU_NET_CLIENTS_H */
> > diff --git a/net/net.c b/net/net.c
> > index ac5080dda1..2beb95388a 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -964,6 +964,7 @@ static int (* const net_client_init_fun[NET_CLIENT_=
DRIVER__MAX])(
> >          [NET_CLIENT_DRIVER_HUBPORT]   =3D net_init_hubport,
> >  #ifdef CONFIG_VHOST_NET_USER          ^^^^^^^^^^^^^^^^^^^^^
>                    here
>
> >          [NET_CLIENT_DRIVER_VHOST_USER] =3D net_init_vhost_user,
> > +        [NET_CLIENT_DRIVER_VHOST_VDPA] =3D net_init_vhost_vdpa,
> >  #endif
> >  #ifdef CONFIG_L2TPV3
> >          [NET_CLIENT_DRIVER_L2TPV3]    =3D net_init_l2tpv3,
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > new file mode 100644
> > index 0000000000..5daeba0b76
> > --- /dev/null
> > +++ b/net/vhost-vdpa.c
> ...
> > +static int net_vhost_check_net(void *opaque, QemuOpts *opts, Error **e=
rrp)
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
> > +        error_setg(errp, "vhost-vdpa requires frontend driver virtio-n=
et-*");
> > +        return -1;
> > +    }
> >
>
> So perhaps you can build the file only if CONFIG_VIRTIO_NET is set?
>
> Thanks,
> Laurent
>
Thanks, There will be a new macro specific for vDPA


