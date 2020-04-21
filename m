Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B25C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 03:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD15206F9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 03:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AK5gcxm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD15206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQjmg-0001qa-E3
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 23:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jQjlx-0001QX-5O
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 23:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jQjlv-0002K0-Ks
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 23:40:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32788
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jQjlv-0002Cj-67
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 23:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587440429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxr292Fa/XRyKiyzyucqKyUW7DFG74xplk749QKdRdc=;
 b=AK5gcxm52oX5BNqA++N4d2cN3675aPEReflU6P/E1C2gBZwYQN/5FnrRW1Cy4BLLm5ZGA+
 ZLhdodjjRMV7SLKvAILK/Yh2/NbWBfP9TSPJT9LIUEt4fwnybA50alcbI0YAZjMr4oQmD3
 hei3/+1eNXp7AcvMj5VETqzc7SnhcVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-bXvCgjQpMYiE6QwRxEWHlA-1; Mon, 20 Apr 2020 23:40:25 -0400
X-MC-Unique: bXvCgjQpMYiE6QwRxEWHlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33B47800D5B;
 Tue, 21 Apr 2020 03:40:23 +0000 (UTC)
Received: from [10.72.12.74] (ovpn-12-74.pek2.redhat.com [10.72.12.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72CCB10016EB;
 Tue, 21 Apr 2020 03:40:03 +0000 (UTC)
Subject: Re: [RFC v1 2/4] vhost-vdpa: introduce vhost-vdpa net client
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <df8f85fa-290b-26f2-59da-b6cb8a45043d@redhat.com>
Date: Tue, 21 Apr 2020 11:40:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200420093241.4238-3-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 23:40:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, maxime.coquelin@redhat.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 aadam@redhat.com, rdunlap@infradead.org, hanand@xilinx.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:
> This patch set introduces a new net client type: vhost-vdpa.
> vhost-vdpa net client will set up a vDPA device which is svhostdevpecifie=
d


typo.


> by a "vhostdev" parameter.
>
> Author: Tiwei Bie


Please keep the sobs from the original patch.


> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   include/net/vhost-vdpa.h |  18 ++++
>   include/net/vhost_net.h  |   1 +
>   net/Makefile.objs        |   2 +-
>   net/clients.h            |   2 +
>   net/net.c                |   1 +
>   net/vhost-vdpa.c         | 211 +++++++++++++++++++++++++++++++++++++++
>   qapi/net.json            |  21 +++-
>   7 files changed, 253 insertions(+), 3 deletions(-)
>   create mode 100644 include/net/vhost-vdpa.h
>   create mode 100644 net/vhost-vdpa.c


I think this patch should come after patch 3.

And it's better to make this as a module like vhost-user.


>
> diff --git a/include/net/vhost-vdpa.h b/include/net/vhost-vdpa.h
> new file mode 100644
> index 0000000000..9ddd538dad
> --- /dev/null
> +++ b/include/net/vhost-vdpa.h
> @@ -0,0 +1,18 @@
> +/*
> + * vhost-vdpa.h
> + *
> + * Copyright(c) 2017 Intel Corporation. All rights reserved.


2020 and please add Red Hat here as well.


> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef VHOST_VDPA_H
> +#define VHOST_VDPA_H
> +
> +struct vhost_net;
> +struct vhost_net *vhost_vdpa_get_vhost_net(NetClientState *nc);
> +uint64_t vhost_vdpa_get_acked_features(NetClientState *nc);
> +
> +#endif /* VHOST_VDPA_H */
> diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> index 77e47398c4..6f3a624cf7 100644
> --- a/include/net/vhost_net.h
> +++ b/include/net/vhost_net.h
> @@ -39,5 +39,6 @@ int vhost_set_vring_enable(NetClientState * nc, int ena=
ble);
>   uint64_t vhost_net_get_acked_features(VHostNetState *net);
>  =20
>   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
> +int vhost_set_state(NetClientState *nc, int state);


This function is not used in this patch.


>  =20
>   #endif
> diff --git a/net/Makefile.objs b/net/Makefile.objs
> index c5d076d19c..da459cfc19 100644
> --- a/net/Makefile.objs
> +++ b/net/Makefile.objs
> @@ -26,7 +26,7 @@ tap-obj-$(CONFIG_SOLARIS) =3D tap-solaris.o
>   tap-obj-y ?=3D tap-stub.o
>   common-obj-$(CONFIG_POSIX) +=3D tap.o $(tap-obj-y)
>   common-obj-$(CONFIG_WIN32) +=3D tap-win32.o
> -
> +common-obj-$(CONFIG_VHOST_KERNEL) +=3D vhost-vdpa.o
>   vde.o-libs =3D $(VDE_LIBS)
>  =20
>   common-obj-$(CONFIG_CAN_BUS) +=3D can/
> diff --git a/net/clients.h b/net/clients.h
> index a6ef267e19..92f9b59aed 100644
> --- a/net/clients.h
> +++ b/net/clients.h
> @@ -61,4 +61,6 @@ int net_init_netmap(const Netdev *netdev, const char *n=
ame,
>   int net_init_vhost_user(const Netdev *netdev, const char *name,
>                           NetClientState *peer, Error **errp);
>  =20
> +int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
> +                        NetClientState *peer, Error **errp);
>   #endif /* QEMU_NET_CLIENTS_H */
> diff --git a/net/net.c b/net/net.c
> index ac5080dda1..2beb95388a 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -964,6 +964,7 @@ static int (* const net_client_init_fun[NET_CLIENT_DR=
IVER__MAX])(
>           [NET_CLIENT_DRIVER_HUBPORT]   =3D net_init_hubport,
>   #ifdef CONFIG_VHOST_NET_USER
>           [NET_CLIENT_DRIVER_VHOST_USER] =3D net_init_vhost_user,
> +        [NET_CLIENT_DRIVER_VHOST_VDPA] =3D net_init_vhost_vdpa,
>   #endif
>   #ifdef CONFIG_L2TPV3
>           [NET_CLIENT_DRIVER_L2TPV3]    =3D net_init_l2tpv3,
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> new file mode 100644
> index 0000000000..5daeba0b76
> --- /dev/null
> +++ b/net/vhost-vdpa.c
> @@ -0,0 +1,211 @@
> +/*
> + * vhost-vdpa.c
> + *
> + * Copyright(c) 2017-2018 Intel Corporation. All rights reserved.
> + * Copyright(c) 2020 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "clients.h"
> +#include "net/vhost_net.h"
> +#include "net/vhost-vdpa.h"
> +#include "hw/virtio/vhost-vdpa.h"
> +#include "chardev/char-fe.h"


I don't think we use charfe in this file.


> +#include "qemu/config-file.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "qapi/error.h"
> +#include "trace.h"


I think we don't use tracing in this file.


> +#include <linux/vfio.h>
> +#include <sys/ioctl.h>
> +#include <err.h>
> +#include <linux/virtio_net.h>
> +
> +
> +typedef struct VhostVDPAState {
> +    NetClientState nc;


This may not work for the case of multiqueue, you can either fix this or=20
just leave a comment for TODO.


> +    struct vhost_vdpa vhost_vdpa;


This explains why patch 3 should come first.


> +    VHostNetState *vhost_net;
> +    uint64_t acked_features;
> +    bool started;
> +} VhostVDPAState;
> +
> +VHostNetState *vhost_vdpa_get_vhost_net(NetClientState *nc)
> +{
> +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> +    return s->vhost_net;
> +}
> +
> +uint64_t vhost_vdpa_get_acked_features(NetClientState *nc)
> +{
> +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> +    return s->acked_features;
> +}
> +
> +static void vhost_vdpa_stop(NetClientState *ncs)
> +{
> +    VhostVDPAState *s;
> +
> +    assert(ncs->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> +
> +    s =3D DO_UPCAST(VhostVDPAState, nc, ncs);
> +
> +    if (s->vhost_net) {
> +        /* save acked features */
> +        uint64_t features =3D vhost_net_get_acked_features(s->vhost_net)=
;
> +        if (features) {
> +            s->acked_features =3D features;
> +         }
> +        vhost_net_cleanup(s->vhost_net);
> +    }
> +}
> +
> +static int vhost_vdpa_start(NetClientState *ncs, void *be)
> +{


The name of this function is confusing, we don't start vhost_vdpa actually.


> +    VhostNetOptions options;
> +    struct vhost_net *net =3D NULL;
> +    VhostVDPAState *s;
> +
> +    options.backend_type =3D VHOST_BACKEND_TYPE_VDPA;
> +
> +    assert(ncs->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> +
> +    s =3D DO_UPCAST(VhostVDPAState, nc, ncs);
> +
> +    options.net_backend =3D ncs;
> +    options.opaque      =3D be;
> +    options.busyloop_timeout =3D 0;
> +    net =3D vhost_net_init(&options);
> +    if (!net) {
> +        error_report("failed to init vhost_net for queue");
> +        goto err;
> +     }
> +
> +     if (s->vhost_net) {
> +        vhost_net_cleanup(s->vhost_net);
> +        g_free(s->vhost_net);
> +     }
> +     s->vhost_net =3D net;
> +
> +    return 0;
> +
> +err:
> +    if (net) {
> +        vhost_net_cleanup(net);
> +    }
> +    vhost_vdpa_stop(ncs);
> +    return -1;
> +}
> +static void vhost_vdpa_cleanup(NetClientState *nc)
> +{
> +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +
> +    if (s->vhost_net) {
> +        vhost_net_cleanup(s->vhost_net);
> +        g_free(s->vhost_net);
> +        s->vhost_net =3D NULL;
> +    }
> +
> +    qemu_purge_queued_packets(nc);
> +}
> +
> +static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
> +{
> +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> +
> +    return true;
> +}
> +
> +static bool vhost_vdpa_has_ufo(NetClientState *nc)
> +{
> +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +    uint64_t  features =3D 0;
> +
> +    features |=3D (1ULL << VIRTIO_NET_F_HOST_UFO);
> +    features =3D vhost_net_get_features(s->vhost_net, features);
> +    return !!(features & (1ULL << VIRTIO_NET_F_HOST_UFO));
> +
> +}
> +
> +static NetClientInfo net_vhost_vdpa_info =3D {
> +        .type =3D NET_CLIENT_DRIVER_VHOST_VDPA,
> +        .size =3D sizeof(VhostVDPAState),
> +        .cleanup =3D vhost_vdpa_cleanup,
> +        .has_vnet_hdr =3D vhost_vdpa_has_vnet_hdr,
> +        .has_ufo =3D vhost_vdpa_has_ufo,
> +};
> +
> +static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
> +                               const char *name, const char *vhostdev)
> +{
> +    NetClientState *nc =3D NULL;
> +    VhostVDPAState *s;
> +    int vdpa_device_fd;
> +    assert(name);
> +
> +    nc =3D qemu_new_net_client(&net_vhost_vdpa_info, peer, device, name)=
;
> +    snprintf(nc->info_str, sizeof(nc->info_str), "vhost-vdpa");
> +    nc->queue_index =3D 0;
> +
> +    s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +
> +    vdpa_device_fd =3D open(vhostdev, O_RDWR);
> +    if (vdpa_device_fd =3D=3D -1) {
> +        return -errno;
> +    }
> +    s->vhost_vdpa.device_fd =3D vdpa_device_fd;


Need to add a step to verify the device type and fail if it was not a=20
networking device.


> +    vhost_vdpa_start(nc, (void *)&s->vhost_vdpa);
> +
> +    assert(s->vhost_net);
> +
> +    return 0;
> +}
> +
> +static int net_vhost_check_net(void *opaque, QemuOpts *opts, Error **err=
p)
> +{
> +    const char *name =3D opaque;
> +    const char *driver, *netdev;
> +
> +    driver =3D qemu_opt_get(opts, "driver");
> +    netdev =3D qemu_opt_get(opts, "netdev");
> +
> +    if (!driver || !netdev) {
> +        return 0;
> +    }
> +
> +    if (strcmp(netdev, name) =3D=3D 0 &&
> +        !g_str_has_prefix(driver, "virtio-net-")) {
> +        error_setg(errp, "vhost-vdpa requires frontend driver virtio-net=
-*");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
> +                        NetClientState *peer, Error **errp)
> +{
> +    const NetdevVhostVDPAOptions *vhost_vdpa_opts;
> +
> +    assert(netdev->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> +    vhost_vdpa_opts =3D &netdev->u.vhost_vdpa;
> +
> +    /* verify net frontend */
> +    if (qemu_opts_foreach(qemu_find_opts("device"), net_vhost_check_net,
> +                          (char *)name, errp)) {
> +        return -1;
> +    }
> +
> +
> +    return net_vhost_vdpa_init(peer, "vhost_vdpa", name,
> +                               vhost_vdpa_opts->vhostdev);


Please add the support for passing fd via command line.


> +
> +    return 0;
> +}
> diff --git a/qapi/net.json b/qapi/net.json
> index 335295be50..35a5ccee39 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -441,6 +441,22 @@
>       '*queues':        'int' } }
>  =20
>   ##
> +# @NetdevVhostVDPAOptions:
> +#
> +# Vhost-vdpa network backend
> +#
> +# @vhostdev: name of a mdev dev path in sysfs
> +#
> +# @queues: number of queues to be created for multiqueue vhost-vdpa
> +#          (default: 1) (Since 2.11)
> +#
> +# Since: 2.11


The version number is wrong, I guess it's probably 5.1.

Thanks


> +##
> +{ 'struct': 'NetdevVhostVDPAOptions',
> +  'data': {
> +    '*vhostdev':     'str',
> +    '*queues':       'int' } }
> +##
>   # @NetClientDriver:
>   #
>   # Available netdev drivers.
> @@ -451,7 +467,7 @@
>   ##
>   { 'enum': 'NetClientDriver',
>     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' ] =
}
>  =20
>   ##
>   # @Netdev:
> @@ -479,7 +495,8 @@
>       'bridge':   'NetdevBridgeOptions',
>       'hubport':  'NetdevHubPortOptions',
>       'netmap':   'NetdevNetmapOptions',
> -    'vhost-user': 'NetdevVhostUserOptions' } }
> +    'vhost-user': 'NetdevVhostUserOptions',
> +    'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
>  =20
>   ##
>   # @NetLegacy:


