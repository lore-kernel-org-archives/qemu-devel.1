Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD5DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7507220723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLo/X694"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7507220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnekR-0008FO-Kv
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jnejo-0007lI-0c
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:57:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58171
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jnejk-000614-GS
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592902619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzHzjQW9nC0o8StTARCCQRfuLaCTb5IQ0oAGss6TZUo=;
 b=LLo/X694kPjXiKojhwrDQcCglD2B3P2zXl8ELjfqWVoH2TzEF7qBuizjZTIpBJa7O+5RhI
 8yVDhwrRazWgwUtcS8dxkuKJIpgFxKJjxkUCwt8VjUDsxVUYdjEYDO0SyRn99hMQ7HeA/R
 pscZuhUSX5GYlbbSvtAWOKmvIlBxqTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-4SjY-YeZPnGSS1Zjl6MQ2A-1; Tue, 23 Jun 2020 04:56:55 -0400
X-MC-Unique: 4SjY-YeZPnGSS1Zjl6MQ2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 147398035A7;
 Tue, 23 Jun 2020 08:56:52 +0000 (UTC)
Received: from [10.72.12.144] (ovpn-12-144.pek2.redhat.com [10.72.12.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BB6178FC5;
 Tue, 23 Jun 2020 08:56:32 +0000 (UTC)
Subject: Re: [PATCH v1 10/10] vhost-vdpa: introduce vhost-vdpa net client
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-11-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <36d932d1-18ad-8152-dc6e-5cf9df2b8a43@redhat.com>
Date: Tue, 23 Jun 2020 16:56:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622153756.19189-11-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, maxime.coquelin@redhat.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 Tiwei Bie <tiwei.bie@intel.com>, aadam@redhat.com, rdunlap@infradead.org,
 hanand@xilinx.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/22 下午11:37, Cindy Lu wrote:
> This patch set introduces a new net client type: vhost-vdpa.
> vhost-vdpa net client will set up a vDPA device which is specified
> by a "vhostdev" parameter.
>
> Signed-off-by: Lingshan Zhu <lingshan.zhu@intel.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   include/net/vhost-vdpa.h |  21 ++++
>   include/net/vhost_net.h  |   1 -
>   net/Makefile.objs        |   2 +-
>   net/clients.h            |   2 +
>   net/net.c                |   3 +
>   net/vhost-vdpa.c         | 230 +++++++++++++++++++++++++++++++++++++++
>   qapi/net.json            |  23 +++-
>   7 files changed, 278 insertions(+), 4 deletions(-)
>   create mode 100644 include/net/vhost-vdpa.h
>   create mode 100644 net/vhost-vdpa.c
>
> diff --git a/include/net/vhost-vdpa.h b/include/net/vhost-vdpa.h
> new file mode 100644
> index 0000000000..725c8b1c81
> --- /dev/null
> +++ b/include/net/vhost-vdpa.h
> @@ -0,0 +1,21 @@
> +/*
> + * vhost-vdpa.h
> + *
> + * Copyright(c) 2017-2018 Intel Corporation.
> + * Copyright(c) 2020 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
> +extern const int vdpa_feature_bits[];
> +
> +#endif /* VHOST_VDPA_H */
> diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> index abfb0e8e68..4843cdb36f 100644
> --- a/include/net/vhost_net.h
> +++ b/include/net/vhost_net.h
> @@ -44,5 +44,4 @@ int vhost_set_vring_enable(NetClientState * nc, int enable);
>   uint64_t vhost_net_get_acked_features(VHostNetState *net);
>   
>   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
> -


Let's keep this newline.


>   #endif
> diff --git a/net/Makefile.objs b/net/Makefile.objs
> index c5d076d19c..5ab45545db 100644
> --- a/net/Makefile.objs
> +++ b/net/Makefile.objs
> @@ -26,7 +26,7 @@ tap-obj-$(CONFIG_SOLARIS) = tap-solaris.o
>   tap-obj-y ?= tap-stub.o
>   common-obj-$(CONFIG_POSIX) += tap.o $(tap-obj-y)
>   common-obj-$(CONFIG_WIN32) += tap-win32.o
> -


And this.


> +common-obj-$(CONFIG_VHOST_NET_VDPA) += vhost-vdpa.o
>   vde.o-libs = $(VDE_LIBS)
>   
>   common-obj-$(CONFIG_CAN_BUS) += can/
> diff --git a/net/clients.h b/net/clients.h
> index a6ef267e19..92f9b59aed 100644
> --- a/net/clients.h
> +++ b/net/clients.h
> @@ -61,4 +61,6 @@ int net_init_netmap(const Netdev *netdev, const char *name,
>   int net_init_vhost_user(const Netdev *netdev, const char *name,
>                           NetClientState *peer, Error **errp);
>   
> +int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
> +                        NetClientState *peer, Error **errp);
>   #endif /* QEMU_NET_CLIENTS_H */
> diff --git a/net/net.c b/net/net.c
> index 599fb61028..82624ea9ac 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -965,6 +965,9 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
>   #ifdef CONFIG_VHOST_NET_USER
>           [NET_CLIENT_DRIVER_VHOST_USER] = net_init_vhost_user,
>   #endif
> +#ifdef CONFIG_VHOST_NET_VDPA
> +        [NET_CLIENT_DRIVER_VHOST_VDPA] = net_init_vhost_vdpa,
> +#endif
>   #ifdef CONFIG_L2TPV3
>           [NET_CLIENT_DRIVER_L2TPV3]    = net_init_l2tpv3,
>   #endif
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> new file mode 100644
> index 0000000000..34858a6ea3
> --- /dev/null
> +++ b/net/vhost-vdpa.c
> @@ -0,0 +1,230 @@
> +/*
> + * vhost-vdpa.c
> + *
> + * Copyright(c) 2017-2018 Intel Corporation.
> + * Copyright(c) 2020 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "clients.h"
> +#include "net/vhost_net.h"
> +#include "net/vhost-vdpa.h"
> +#include "hw/virtio/vhost-vdpa.h"
> +#include "qemu/config-file.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "qapi/error.h"
> +#include <sys/ioctl.h>
> +#include <err.h>
> +#include "standard-headers/linux/virtio_net.h"
> +#include "monitor/monitor.h"
> +#include "hw/virtio/vhost.h"
> +
> +/* Todo:need to add the multiqueue support here */
> +typedef struct VhostVDPAState {
> +    NetClientState nc;
> +    struct vhost_vdpa vhost_vdpa;
> +    VHostNetState *vhost_net;
> +    uint64_t acked_features;
> +    bool started;
> +} VhostVDPAState;
> +
> +const int vdpa_feature_bits[] = {
> +    VIRTIO_F_NOTIFY_ON_EMPTY,
> +    VIRTIO_RING_F_INDIRECT_DESC,
> +    VIRTIO_RING_F_EVENT_IDX,
> +    VIRTIO_F_ANY_LAYOUT,
> +    VIRTIO_F_VERSION_1,
> +    VIRTIO_NET_F_CSUM,
> +    VIRTIO_NET_F_GUEST_CSUM,
> +    VIRTIO_NET_F_GSO,
> +    VIRTIO_NET_F_GUEST_TSO4,
> +    VIRTIO_NET_F_GUEST_TSO6,
> +    VIRTIO_NET_F_GUEST_ECN,
> +    VIRTIO_NET_F_GUEST_UFO,
> +    VIRTIO_NET_F_HOST_TSO4,
> +    VIRTIO_NET_F_HOST_TSO6,
> +    VIRTIO_NET_F_HOST_ECN,
> +    VIRTIO_NET_F_HOST_UFO,
> +    VIRTIO_NET_F_MRG_RXBUF,
> +    VIRTIO_NET_F_MTU,
> +    VIRTIO_F_IOMMU_PLATFORM,
> +    VIRTIO_F_RING_PACKED,
> +    VIRTIO_NET_F_GUEST_ANNOUNCE,
> +    VHOST_INVALID_FEATURE_BIT
> +};
> +
> +VHostNetState *vhost_vdpa_get_vhost_net(NetClientState *nc)
> +{
> +    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
> +    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> +    return s->vhost_net;
> +}
> +
> +uint64_t vhost_vdpa_get_acked_features(NetClientState *nc)
> +{
> +    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
> +    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> +    s->acked_features = vhost_net_get_acked_features(s->vhost_net);
> +
> +    return s->acked_features;
> +}
> +
> +static int vhost_vdpa_net_check_device_id(NetClientState *nc)
> +{
> +    uint32_t device_id;
> +    int ret;
> +    struct vhost_net *net;
> +    struct vhost_dev *hdev;
> +    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> +    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);


Let's try to avoid those unnecessary conversion and check since the 
caller knows e.g VhostVDPAState.


> +    net = s->vhost_net;
> +    hdev = (struct vhost_dev *)&net->dev;
> +    ret = hdev->vhost_ops->vhost_get_device_id(hdev, &device_id);
> +    if (device_id != VIRTIO_ID_NET) {
> +        return -ENOTSUP;
> +    }
> +    return ret;
> +}
> +
> +static void vhost_vdpa_del(NetClientState *ncs)
> +{
> +    VhostVDPAState *s;
> +    assert(ncs->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> +    s = DO_UPCAST(VhostVDPAState, nc, ncs);
> +    if (s->vhost_net) {
> +        vhost_net_cleanup(s->vhost_net);
> +    }
> +}
> +
> +static int vhost_vdpa_add(NetClientState *ncs, void *be)
> +{
> +    VhostNetOptions options;
> +    struct vhost_net *net = NULL;
> +    VhostVDPAState *s;
> +    int ret;
> +
> +    options.backend_type = VHOST_BACKEND_TYPE_VDPA;
> +    assert(ncs->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> +    s = DO_UPCAST(VhostVDPAState, nc, ncs);
> +    options.net_backend = ncs;
> +    options.opaque      = be;
> +    options.busyloop_timeout = 0;
> +    net = vhost_net_init(&options);
> +    if (!net) {
> +        error_report("failed to init vhost_net for queue");
> +        goto err;
> +    }
> +    if (s->vhost_net) {
> +        vhost_net_cleanup(s->vhost_net);
> +        g_free(s->vhost_net);
> +    }
> +    s->vhost_net = net;
> +    ret = vhost_vdpa_net_check_device_id(ncs);


Eli pointed out it's better to validate device Id before vhost_net_init().

Otherwise driver may see e.g DRIVER before getting device id.


> +    if (ret) {
> +        goto err;
> +    }
> +    return 0;
> +err:
> +    if (net) {
> +        vhost_net_cleanup(net);
> +    }
> +    vhost_vdpa_del(ncs);
> +    return -1;
> +}
> +
> +static void vhost_vdpa_cleanup(NetClientState *nc)
> +{
> +    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
> +
> +    if (s->vhost_net) {
> +        vhost_net_cleanup(s->vhost_net);
> +        g_free(s->vhost_net);
> +        s->vhost_net = NULL;
> +    }
> +}
> +
> +static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
> +{
> +    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> +
> +    return true;
> +}
> +
> +static bool vhost_vdpa_has_ufo(NetClientState *nc)
> +{
> +    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> +    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
> +    uint64_t  features = 0;


Unnecessary spaces between uint64_t and features.


> +    features |= (1ULL << VIRTIO_NET_F_HOST_UFO);
> +    features = vhost_net_get_features(s->vhost_net, features);
> +    return !!(features & (1ULL << VIRTIO_NET_F_HOST_UFO));
> +
> +}
> +
> +static NetClientInfo net_vhost_vdpa_info = {
> +        .type = NET_CLIENT_DRIVER_VHOST_VDPA,
> +        .size = sizeof(VhostVDPAState),
> +        .cleanup = vhost_vdpa_cleanup,
> +        .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
> +        .has_ufo = vhost_vdpa_has_ufo,
> +};
> +
> +static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
> +                               const char *name, const char *vhostdev)
> +{
> +    NetClientState *nc = NULL;
> +    VhostVDPAState *s;
> +    int vdpa_device_fd = -1;
> +    int ret = 0;
> +    assert(name);
> +    nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device, name);
> +    snprintf(nc->info_str, sizeof(nc->info_str), "vhost-vdpa");


Do we need an identifier for this vhost-vdpa?

Thanks


> +    nc->queue_index = 0;
> +    s = DO_UPCAST(VhostVDPAState, nc, nc);
> +    vdpa_device_fd = qemu_open(vhostdev, O_RDWR);
> +    if (vdpa_device_fd == -1) {
> +        return -errno;
> +    }
> +    s->vhost_vdpa.device_fd = vdpa_device_fd;
> +    ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa);
> +    assert(s->vhost_net);
> +    return ret;
> +}
> +
> +static int net_vhost_check_net(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    const char *name = opaque;
> +    const char *driver, *netdev;
> +
> +    driver = qemu_opt_get(opts, "driver");
> +    netdev = qemu_opt_get(opts, "netdev");
> +    if (!driver || !netdev) {
> +        return 0;
> +    }
> +    if (strcmp(netdev, name) == 0 &&
> +        !g_str_has_prefix(driver, "virtio-net-")) {
> +        error_setg(errp, "vhost-vdpa requires frontend driver virtio-net-*");
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
> +                        NetClientState *peer, Error **errp)
> +{
> +    const NetdevVhostVDPAOptions *opts;
> +
> +    assert(netdev->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> +    opts = &netdev->u.vhost_vdpa;
> +    /* verify net frontend */
> +    if (qemu_opts_foreach(qemu_find_opts("device"), net_vhost_check_net,
> +                          (char *)name, errp)) {
> +        return -1;
> +    }
> +    return net_vhost_vdpa_init(peer, "vhost_vdpa", name, opts->vhostdev);
> +}
> diff --git a/qapi/net.json b/qapi/net.json
> index cebb1b52e3..03aad67693 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -428,6 +428,24 @@
>       '*vhostforce':    'bool',
>       '*queues':        'int' } }
>   
> +##
> +# @NetdevVhostVDPAOptions:
> +#
> +# Vhost-vdpa network backend
> +#
> +# @vhostdev: name of a vdpa dev path in sysfs
> +#            (default path:/dev/vhost-vdpa-$ID)
> +#
> +# @queues: number of queues to be created for multiqueue vhost-vdpa
> +#          (default: 1)
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'NetdevVhostVDPAOptions',
> +  'data': {
> +    '*vhostdev':     'str',
> +    '*queues':       'int' } }
> +
>   ##
>   # @NetClientDriver:
>   #
> @@ -437,7 +455,7 @@
>   ##
>   { 'enum': 'NetClientDriver',
>     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' ] }
>   
>   ##
>   # @Netdev:
> @@ -465,7 +483,8 @@
>       'bridge':   'NetdevBridgeOptions',
>       'hubport':  'NetdevHubPortOptions',
>       'netmap':   'NetdevNetmapOptions',
> -    'vhost-user': 'NetdevVhostUserOptions' } }
> +    'vhost-user': 'NetdevVhostUserOptions',
> +    'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
>   
>   ##
>   # @NetLegacy:


