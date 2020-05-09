Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD602C38A2A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 02:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E16217BA
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 02:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQH2AsnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E16217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXFQi-0002yI-RD
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 22:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXFPz-0002Xr-Te
 for qemu-devel@nongnu.org; Fri, 08 May 2020 22:40:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23284
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXFPx-0006mG-BG
 for qemu-devel@nongnu.org; Fri, 08 May 2020 22:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588992043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VdaPL4pEEm3GEofDCwjYVEwV/Vy6i23X38qU/xDm/XY=;
 b=bQH2AsnTvnAHA/zLeOckh8tdTKlNvxBPKuNEWo3zeuFYPDsS51SI1Kugc4l/Uf6HQPiVvg
 S1CUWlK7AqWBHTDuvI6LyBCS+sIVrdKWaiwrRJmRL1JNV5MbkxTiL+Lm4XFhbfSF4gao5S
 wl1mW9T7oLSuCT9vceSUUA3W0hCLczY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-7va8i44MOjKLCWKX90BmVA-1; Fri, 08 May 2020 22:40:41 -0400
X-MC-Unique: 7va8i44MOjKLCWKX90BmVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D22A780058A;
 Sat,  9 May 2020 02:40:38 +0000 (UTC)
Received: from [10.72.13.128] (ovpn-13-128.pek2.redhat.com [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C2FE1001925;
 Sat,  9 May 2020 02:40:19 +0000 (UTC)
Subject: Re: [RFC v2 4/9] vhost-vdpa: introduce vhost-vdpa net client
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <570f92fa-dbf4-e9d0-e00d-18f02fafd0ce@redhat.com>
Date: Sat, 9 May 2020 10:40:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508163218.22592-5-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 22:40:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, Tiwei Bie <tiwei.bie@intel.com>,
 aadam@redhat.com, rdunlap@infradead.org, maxime.coquelin@redhat.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/9 上午12:32, Cindy Lu wrote:
> From: Tiwei Bie <tiwei.bie@intel.com>


If you think you've done a huge refactor on the code, you can change the 
author but need to keep the sob of Tiwei.


>
> This patch set introduces a new net client type: vhost-vdpa.
> vhost-vdpa net client will set up a vDPA device which is specified
> by a "vhostdev" parameter.
>
> Co-authored-by: Lingshan Zhu <lingshan.zhu@intel.com>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   configure                |  21 ++++
>   include/net/vhost-vdpa.h |  19 ++++
>   include/net/vhost_net.h  |   1 +


Patch 5 which is the infrastructure of vhost-vpda should come first. 
Please re-order the patch in next version.


>   net/Makefile.objs        |   2 +-
>   net/clients.h            |   2 +
>   net/net.c                |   3 +
>   net/vhost-vdpa.c         | 227 +++++++++++++++++++++++++++++++++++++++
>   qapi/net.json            |  22 +++-
>   qemu-options.hx          |  19 ++++
>   9 files changed, 313 insertions(+), 3 deletions(-)
>   create mode 100644 include/net/vhost-vdpa.h
>   create mode 100644 net/vhost-vdpa.c
>
> diff --git a/configure b/configure
> index 6099be1d84..bdd732e3bb 100755
> --- a/configure
> +++ b/configure
> @@ -1505,6 +1505,10 @@ for opt do
>     ;;
>     --enable-vhost-user) vhost_user="yes"
>     ;;
> +  --disable-vhost-vdpa) vhost_vdpa="no"
> +  ;;
> +  --enable-vhost-vdpa) vhost_vdpa="yes"
> +  ;;
>     --disable-vhost-kernel) vhost_kernel="no"
>     ;;
>     --enable-vhost-kernel) vhost_kernel="yes"
> @@ -1780,6 +1784,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>     vhost-crypto    vhost-user-crypto backend support
>     vhost-kernel    vhost kernel backend support
>     vhost-user      vhost-user backend support
> +  vhost-vdpa      vhost-vdpa backend support


Maybe "vhost-vdpa kernel backend support" is better.


>     spice           spice
>     rbd             rados block device (rbd)
>     libiscsi        iscsi support
> @@ -2241,6 +2246,10 @@ test "$vhost_user" = "" && vhost_user=yes
>   if test "$vhost_user" = "yes" && test "$mingw32" = "yes"; then
>     error_exit "vhost-user isn't available on win32"
>   fi
> +test "$vhost_vdpa" = "" && vhost_vdpa=yes
> +if test "$vhost_vdpa" = "yes" && test "$mingw32" = "yes"; then
> +  error_exit "vhost-vdpa isn't available on win32"
> +fi


Let's add a check for Linux like vhost kernel below.


>   test "$vhost_kernel" = "" && vhost_kernel=$linux
>   if test "$vhost_kernel" = "yes" && test "$linux" != "yes"; then
>     error_exit "vhost-kernel is only available on Linux"
> @@ -2269,6 +2278,11 @@ test "$vhost_user_fs" = "" && vhost_user_fs=$vhost_user
>   if test "$vhost_user_fs" = "yes" && test "$vhost_user" = "no"; then
>     error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
>   fi
> +#vhost-vdpa backends
> +test "$vhost_net_vdpa" = "" && vhost_net_vdpa=$vhost_vdpa
> +if test "$vhost_net_vdpa" = "yes" && test "$vhost_vdpa" = "no"; then
> +  error_exit "--enable-vhost-net-vdpa requires --enable-vhost-vdpa"
> +fi
>   
>   # OR the vhost-kernel and vhost-user values for simplicity
>   if test "$vhost_net" = ""; then
> @@ -6543,6 +6557,7 @@ echo "vhost-scsi support $vhost_scsi"
>   echo "vhost-vsock support $vhost_vsock"
>   echo "vhost-user support $vhost_user"
>   echo "vhost-user-fs support $vhost_user_fs"
> +echo "vhost-vdpa support $vhost_vdpa"
>   echo "Trace backends    $trace_backends"
>   if have_backend "simple"; then
>   echo "Trace output file $trace_file-<pid>"
> @@ -7031,6 +7046,9 @@ fi
>   if test "$vhost_net_user" = "yes" ; then
>     echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
>   fi
> +if test "$vhost_net_vdpa" = "yes" ; then
> +  echo "CONFIG_VHOST_NET_VDPA=y" >> $config_host_mak
> +fi
>   if test "$vhost_crypto" = "yes" ; then
>     echo "CONFIG_VHOST_CRYPTO=y" >> $config_host_mak
>   fi
> @@ -7043,6 +7061,9 @@ fi
>   if test "$vhost_user" = "yes" ; then
>     echo "CONFIG_VHOST_USER=y" >> $config_host_mak
>   fi
> +if test "$vhost_vdpa" = "yes" ; then
> +  echo "CONFIG_VHOST_VDPA=y" >> $config_host_mak
> +fi
>   if test "$vhost_user_fs" = "yes" ; then
>     echo "CONFIG_VHOST_USER_FS=y" >> $config_host_mak
>   fi
> diff --git a/include/net/vhost-vdpa.h b/include/net/vhost-vdpa.h
> new file mode 100644
> index 0000000000..6ce0d04f72
> --- /dev/null
> +++ b/include/net/vhost-vdpa.h
> @@ -0,0 +1,19 @@
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
> +#endif /* VHOST_VDPA_H */
> diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> index 6548a5a105..b47844bf29 100644
> --- a/include/net/vhost_net.h
> +++ b/include/net/vhost_net.h
> @@ -40,4 +40,5 @@ uint64_t vhost_net_get_acked_features(VHostNetState *net);
>   
>   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
>   int vhost_set_state(NetClientState *nc, uint8_t state);
> +int vhost_net_get_device_id(struct vhost_net *net, uint32_t *device_id);


Let's move this function to vhost-vdpa generic header instead of net.


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
> index b3192deaf1..9eff1ae982 100644
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
> index 0000000000..c29678fdf1
> --- /dev/null
> +++ b/net/vhost-vdpa.c
> @@ -0,0 +1,227 @@
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
> +#include <linux/vfio.h>


No need any more.


> +#include <sys/ioctl.h>
> +#include <err.h>
> +#include <linux/virtio_net.h>


That's not the way we include standard linux headers, qemu maintain a 
copy of standard linux headers.

Need use #include "standard-headers/linux/xxx.h"


> +#include "monitor/monitor.h"
> +#include "qemu/sockets.h"


Do we really need this?


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
> +    return s->acked_features;
> +}
> +
> +static void vhost_vdpa_del(NetClientState *ncs)
> +{
> +    VhostVDPAState *s;
> +
> +    assert(ncs->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> +
> +    s = DO_UPCAST(VhostVDPAState, nc, ncs);
> +
> +    if (s->vhost_net) {
> +        /* save acked features */
> +        uint64_t features = vhost_net_get_acked_features(s->vhost_net);
> +        if (features) {
> +            s->acked_features = features;
> +         }
> +        vhost_net_cleanup(s->vhost_net);
> +    }
> +}
> +
> +static int vhost_vdpa_add(NetClientState *ncs, void *be)
> +{
> +    VhostNetOptions options;
> +    struct vhost_net *net = NULL;
> +    VhostVDPAState *s;
> +
> +    options.backend_type = VHOST_BACKEND_TYPE_VDPA;
> +
> +    assert(ncs->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> +
> +    s = DO_UPCAST(VhostVDPAState, nc, ncs);
> +
> +    options.net_backend = ncs;
> +    options.opaque      = be;
> +    options.busyloop_timeout = 0;
> +    net = vhost_net_init(&options);
> +    if (!net) {
> +        error_report("failed to init vhost_net for queue");
> +        goto err;
> +     }
> +
> +     if (s->vhost_net) {
> +        vhost_net_cleanup(s->vhost_net);
> +        g_free(s->vhost_net);
> +     }
> +     s->vhost_net = net;
> +
> +    return 0;
> +
> +err:
> +    if (net) {
> +        vhost_net_cleanup(net);
> +    }
> +    vhost_vdpa_del(ncs);
> +    return -1;
> +}
> +static void vhost_vdpa_cleanup(NetClientState *nc)
> +{
> +    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
> +
> +    if (s->vhost_net) {
> +        vhost_net_cleanup(s->vhost_net);
> +        g_free(s->vhost_net);
> +        s->vhost_net = NULL;
> +    }
> +
> +    qemu_purge_queued_packets(nc);
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
> +
> +    features |= (1ULL << VIRTIO_NET_F_HOST_UFO);
> +    features = vhost_net_get_features(s->vhost_net, features);
> +    return !!(features & (1ULL << VIRTIO_NET_F_HOST_UFO));
> +
> +}
> +
> +static int vhost_vdpa_check_device_id(NetClientState *nc)
> +{
> +    uint32_t device_id;
> +    int ret;
> +    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> +    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
> +    /* Get the device id from hw*/
> +    ret = vhost_net_get_device_id(s->vhost_net, &device_id);
> +    if (device_id != VIRTIO_ID_NET) {
> +        return -ENOTSUP;
> +    }
> +    return ret;
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
> +                               const char *name, const char *vhostdev,
> +                               bool has_fd, char *fd)
> +{
> +    NetClientState *nc = NULL;
> +    VhostVDPAState *s;
> +    int vdpa_device_fd = -1;
> +    Error *err = NULL;
> +
> +    assert(name);
> +
> +    nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device, name);
> +    snprintf(nc->info_str, sizeof(nc->info_str), "vhost-vdpa");
> +    nc->queue_index = 0;
> +
> +    s = DO_UPCAST(VhostVDPAState, nc, nc);
> +
> +    if (has_fd) {
> +        vdpa_device_fd = monitor_fd_param(cur_mon, fd, &err);
> +    } else{
> +        vdpa_device_fd = open(vhostdev, O_RDWR);
> +    }
> +
> +    if (vdpa_device_fd == -1) {
> +        return -errno;
> +     }
> +    s->vhost_vdpa.device_fd = vdpa_device_fd;
> +    vhost_vdpa_add(nc, (void *)&s->vhost_vdpa);
> +    assert(s->vhost_net);
> +    /* check the device id for vdpa */
> +    return vhost_vdpa_check_device_id(nc);


We probably need to the check earlier. If we do things like this, we 
will probably leak vhost_device_fd.


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
> +
> +    if (strcmp(netdev, name) == 0 &&
> +        !g_str_has_prefix(driver, "virtio-net-")) {
> +        error_setg(errp, "vhost-vdpa requires frontend driver virtio-net-*");
> +        return -1;
> +    }
> +
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
> +    return net_vhost_vdpa_init(peer, "vhost_vdpa", name, opts->vhostdev,
> +                    opts->has_fd, opts->fd);
> +}
> diff --git a/qapi/net.json b/qapi/net.json
> index 335295be50..0f4fa6fffc 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -441,6 +441,23 @@
>       '*queues':        'int' } }
>   
>   ##
> +# @NetdevVhostVDPAOptions:
> +#
> +# Vhost-vdpa network backend
> +#
> +# @vhostdev: name of a vdpa dev path in sysfs
> +#
> +# @queues: number of queues to be created for multiqueue vhost-vdpa
> +#          (default: 1) (Since 5.1)
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'NetdevVhostVDPAOptions',
> +  'data': {
> +    '*vhostdev':     'str',
> +    '*fd':           'str',
> +    '*queues':       'int' } }
> +##
>   # @NetClientDriver:
>   #
>   # Available netdev drivers.
> @@ -451,7 +468,7 @@
>   ##
>   { 'enum': 'NetClientDriver',
>     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' ] }
>   
>   ##
>   # @Netdev:
> @@ -479,7 +496,8 @@
>       'bridge':   'NetdevBridgeOptions',
>       'hubport':  'NetdevHubPortOptions',
>       'netmap':   'NetdevNetmapOptions',
> -    'vhost-user': 'NetdevVhostUserOptions' } }
> +    'vhost-user': 'NetdevVhostUserOptions',
> +    'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
>   
>   ##
>   # @NetLegacy:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 65c9473b73..08256d9d4e 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2291,6 +2291,10 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>   #ifdef CONFIG_POSIX
>       "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
>       "                configure a vhost-user network, backed by a chardev 'dev'\n"
> +#endif
> +#ifdef CONFIG_POSIX
> +    "-netdev vhost-vdpa,id=str,vhostdev=/path/to/dev\n"
> +    "                configure a vhost-vdpa network, backed by a vhostdev 'dev'\n"
>   #endif
>       "-netdev hubport,id=str,hubid=n[,netdev=nd]\n"
>       "                configure a hub port on the hub with ID 'n'\n", QEMU_ARCH_ALL)
> @@ -2310,6 +2314,9 @@ DEF("nic", HAS_ARG, QEMU_OPTION_nic,
>   #endif
>   #ifdef CONFIG_POSIX
>       "vhost-user|"
> +#endif
> +#ifdef CONFIG_POSIX
> +    "vhost-vdpa|"
>   #endif
>       "socket][,option][,...][mac=macaddr]\n"
>       "                initialize an on-board / default host NIC (using MAC address\n"
> @@ -2749,6 +2756,18 @@ qemu -m 512 -object memory-backend-file,id=mem,size=512M,mem-path=/hugetlbfs,sha
>        -device virtio-net-pci,netdev=net0
>   @end example
>   
> +@item -netdev vhost-vdpa,vhostdev=/path/to/dev
> +Establish a vhost-vdpa netdev, backed by a vhostdev. The chardev should
> +be a unix domain socket backed one.


This seems wrong, we don't use unix domain socket.

Thanks


>   The vhost-vdpa uses a specifically defined
> +protocol to pass vhost ioctl replacement messages to an application on the other
> +end of the socket.
> +Example:
> +@example
> +qemu -m 512 -object memory-backend-file,id=mem,size=512M,mem-path=/hugetlbfs,share=on \
> +     -numa node,memdev=mem \
> +     -netdev type=vhost-vdpa,id=net0,vhostdev=/path/to/dev \
> +     -device virtio-net-pci,netdev=net0
> +@end example
>   @item -netdev hubport,id=@var{id},hubid=@var{hubid}[,netdev=@var{nd}]
>   
>   Create a hub port on the emulated hub with ID @var{hubid}.


