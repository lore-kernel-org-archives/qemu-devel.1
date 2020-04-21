Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982AFC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 04:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A539206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 04:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEAx8q8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A539206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQk6I-0008Fd-FL
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 00:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jQk5A-0007hn-3W
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jQk59-0004i0-1X
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:00:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43609
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jQk58-0004fz-Kk
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587441621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6yX4cwHH1RB+paxpJc+1ml2synW7O7MZjj0ZEBBvsLo=;
 b=VEAx8q8lgIw1TALT/C8PgNbes0plUXlBeUZvlimxq10vsOIG67s83MGtemf+NhDfULHzDv
 TyLWuDYYuYmY4Mlo+BKke3CA8EKbQxyQKS/9bBlrfVk8v44acB3JO5v6Z+Kerpz0/cbxoB
 cLs9aEtAQK2NMSHHFqZkE6sNkjVaqps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-HqheKthtNWeoNlwp_Nsb1w-1; Tue, 21 Apr 2020 00:00:19 -0400
X-MC-Unique: HqheKthtNWeoNlwp_Nsb1w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0138A8018A4;
 Tue, 21 Apr 2020 04:00:17 +0000 (UTC)
Received: from [10.72.12.74] (ovpn-12-74.pek2.redhat.com [10.72.12.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7D6F5C1BB;
 Tue, 21 Apr 2020 03:59:50 +0000 (UTC)
Subject: Re: [RFC v1 4/4] vhost: introduce vhost_set_vring_ready method
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c70efeb6-e664-2f5b-dc90-8929f1033e35@redhat.com>
Date: Tue, 21 Apr 2020 11:59:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200420093241.4238-5-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 23:23:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 stefanha@redhat.com, zhihong.wang@intel.com, aadam@redhat.com,
 rdunlap@infradead.org, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:
> From: Jason Wang <jasowang@redhat.com>
>
> Vhost-vdpa introduces VHOST_VDPA_SET_VRING_ENABLE which complies the
> semantic of queue_enable defined in virtio spec. This method can be
> used for preventing device from executing request for a specific
> virtqueue. This patch introduces the vhost_ops for this.
>
> Note that, we've already had vhost_set_vring_enable which has different
> semantic which allows to enable or disable a specific virtqueue for
> some kinds of vhost backends. E.g vhost-user use this to changes the
> number of active queue pairs.


This patch seems to mix fours things, please use dedicated patches for:

1) introduce queue_enabled method for virtio-bus
2) implement queue_enabled for virtio-pci
3) introduce vhost_set_vring_ready method for vhost ops
4) implement vhost_set_vring_ready for vdpa (need to be squashed into=20
the patch of vhost-vdpa).

Thanks


>
> Author: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   hw/net/vhost_net-stub.c           |  5 +++++
>   hw/net/vhost_net.c                | 16 ++++++++++++++++
>   hw/virtio/vhost-vdpa.c            |  9 +++------
>   hw/virtio/virtio-pci.c            | 13 +++++++++++++
>   hw/virtio/virtio.c                |  6 ++++++
>   include/hw/virtio/vhost-backend.h |  2 ++
>   include/hw/virtio/virtio-bus.h    |  4 ++++
>   include/net/vhost_net.h           |  1 +
>   8 files changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
> index aac0e98228..f5ef1e3055 100644
> --- a/hw/net/vhost_net-stub.c
> +++ b/hw/net/vhost_net-stub.c
> @@ -86,6 +86,11 @@ int vhost_set_vring_enable(NetClientState *nc, int ena=
ble)
>       return 0;
>   }
>  =20
> +int vhost_set_vring_ready(NetClientState *nc)
> +{
> +    return 0;
> +}
> +
>   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
>   {
>       return 0;
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 0d13fda2fc..463e333531 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -380,6 +380,10 @@ int vhost_net_start(VirtIODevice *dev, NetClientStat=
e *ncs,
>                   goto err_start;
>               }
>           }
> +
> +        if (virtio_queue_enabled(dev, i)) {
> +            vhost_set_vring_ready(peer);
> +        }
>       }
>  =20
>       return 0;
> @@ -487,6 +491,18 @@ int vhost_set_vring_enable(NetClientState *nc, int e=
nable)
>       return 0;
>   }
>  =20
> +int vhost_set_vring_ready(NetClientState *nc)
> +{
> +    VHostNetState *net =3D get_vhost_net(nc);
> +    const VhostOps *vhost_ops =3D net->dev.vhost_ops;
> +
> +    if (vhost_ops && vhost_ops->vhost_set_vring_ready) {
> +        return vhost_ops->vhost_set_vring_ready(&net->dev);
> +    }
> +
> +    return 0;
> +}
> +
>   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
>   {
>       const VhostOps *vhost_ops =3D net->dev.vhost_ops;
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 213b327600..49224ef9f8 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -325,18 +325,15 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev=
 *dev, int idx)
>       return idx - dev->vq_index;
>   }
>  =20
> -static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable=
)
> +static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
>   {
>       int i;
>  =20
>       for (i =3D 0; i < dev->nvqs; ++i) {
>           struct vhost_vring_state state =3D {
>               .index =3D dev->vq_index + i,
> -            .num   =3D enable,
> +            .num =3D 1,
>           };
> -
> -        state.num =3D 1;
> -
>           vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
>       }
>  =20
> @@ -368,7 +365,7 @@ const VhostOps vdpa_ops =3D {
>           .vhost_set_owner =3D vhost_vdpa_set_owner,
>           .vhost_reset_device =3D vhost_vdpa_reset_device,
>           .vhost_get_vq_index =3D vhost_vdpa_get_vq_index,
> -        .vhost_set_vring_enable =3D vhost_vdpa_set_vring_enable,
> +        .vhost_set_vring_ready =3D vhost_vdpa_set_vring_ready,
>           .vhost_requires_shm_log =3D NULL,
>           .vhost_migration_done =3D NULL,
>           .vhost_backend_can_merge =3D NULL,
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c6b47a9c73..4aaf5d953e 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1103,6 +1103,18 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceS=
tate *d)
>       return pci_get_address_space(dev);
>   }
>  =20
> +static bool virtio_pci_queue_enabled(DeviceState *d, int n)
> +{
> +    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(d);
> +    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        return proxy->vqs[vdev->queue_sel].enabled;
> +    }
> +
> +    return virtio_queue_get_desc_addr(vdev, n) !=3D 0;
> +}
> +
>   static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
>                                      struct virtio_pci_cap *cap)
>   {
> @@ -2053,6 +2065,7 @@ static void virtio_pci_bus_class_init(ObjectClass *=
klass, void *data)
>       k->ioeventfd_enabled =3D virtio_pci_ioeventfd_enabled;
>       k->ioeventfd_assign =3D virtio_pci_ioeventfd_assign;
>       k->get_dma_as =3D virtio_pci_get_dma_as;
> +    k->queue_enabled =3D virtio_pci_queue_enabled;
>   }
>  =20
>   static const TypeInfo virtio_pci_bus_info =3D {
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 04716b5f6c..09732a8836 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3169,6 +3169,12 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vd=
ev, int n)
>  =20
>   bool virtio_queue_enabled(VirtIODevice *vdev, int n)
>   {
> +    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
> +    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> +
> +    if (k->queue_enabled)
> +        return k->queue_enabled(qbus->parent, n);
> +
>       return virtio_queue_get_desc_addr(vdev, n) !=3D 0;
>   }
>  =20
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
> index d81bd9885f..ce8de6d308 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -78,6 +78,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev *=
dev);
>   typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
>   typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
>                                            int enable);
> +typedef int (*vhost_set_vring_ready_op)(struct vhost_dev *dev);
>   typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
>   typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
>                                          char *mac_addr);
> @@ -140,6 +141,7 @@ typedef struct VhostOps {
>       vhost_reset_device_op vhost_reset_device;
>       vhost_get_vq_index_op vhost_get_vq_index;
>       vhost_set_vring_enable_op vhost_set_vring_enable;
> +    vhost_set_vring_ready_op vhost_set_vring_ready;
>       vhost_requires_shm_log_op vhost_requires_shm_log;
>       vhost_migration_done_op vhost_migration_done;
>       vhost_backend_can_merge_op vhost_backend_can_merge;
> diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bu=
s.h
> index 38c9399cd4..0f6f215925 100644
> --- a/include/hw/virtio/virtio-bus.h
> +++ b/include/hw/virtio/virtio-bus.h
> @@ -83,6 +83,10 @@ typedef struct VirtioBusClass {
>        */
>       int (*ioeventfd_assign)(DeviceState *d, EventNotifier *notifier,
>                               int n, bool assign);
> +    /*
> +     * Whether queue number n is enabled.
> +     */
> +    bool (*queue_enabled)(DeviceState *d, int n);
>       /*
>        * Does the transport have variable vring alignment?
>        * (ie can it ever call virtio_queue_set_align()?)
> diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> index 6f3a624cf7..db473ff4d2 100644
> --- a/include/net/vhost_net.h
> +++ b/include/net/vhost_net.h
> @@ -35,6 +35,7 @@ int vhost_net_notify_migration_done(VHostNetState *net,=
 char* mac_addr);
>   VHostNetState *get_vhost_net(NetClientState *nc);
>  =20
>   int vhost_set_vring_enable(NetClientState * nc, int enable);
> +int vhost_set_vring_ready(NetClientState * nc);
>  =20
>   uint64_t vhost_net_get_acked_features(VHostNetState *net);
>  =20


