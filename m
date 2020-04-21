Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570FCC55182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 161A72072D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADyKfMrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161A72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQoVw-0003iB-5N
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQoUo-0001zC-8r
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQoUn-0002Th-2H
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:43:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jQoUm-0002Sy-LB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587458588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AvcAgPnrKup1HE6AR/JSXCVBa02rH1+as1JX5Cj3QC0=;
 b=ADyKfMrc721xHqX1fSzGSGuJRM9aC/buSOo8mybQIXXAHd4ffcDkmLpvw3ij37oTsSHUDF
 6tUu/JsM3b7nced6aPxsEpbpE3Gnc94tCphJGaFaaz7ELO0ArdLoExDIowuVtRiy/NUs+I
 M26oK5URz1CstRMHTdQJnhoz0BOEJuA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-dj34ICsxNrOCFiHNlOf9Lg-1; Tue, 21 Apr 2020 04:43:05 -0400
X-MC-Unique: dj34ICsxNrOCFiHNlOf9Lg-1
Received: by mail-pf1-f199.google.com with SMTP id 84so8313580pfx.20
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 01:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AvcAgPnrKup1HE6AR/JSXCVBa02rH1+as1JX5Cj3QC0=;
 b=b55akYKElNT7b/uoJ0TmJOCfc0zyji/oHX+0Sxoa0tiHqGKDDvw2kCe4s12dLp7GIY
 0Wl0+ZfbRVwaWtuaOrq84qm2bhGGQEN6U0dYBAwywrwzjXe59/VySzvmnmeZde3zz2NS
 zTQr91WYz/Aquw17PLbjoHzJBK9vFQd/xIx3updTtBPjJqIvHbSs1bj5lhY5Qjldzfvk
 aLFe030uS5KfjEDWooCygw3NpQzdpxexqH1+S7v4GeYsrIauNplxqRiJu/G/U78WWCCE
 3ass0HUJ/ikgTQj1G0ByDly1pVDkZuduFrlGLJ6YgOyyTNe1vosxDaaUWbqg/rscdkJJ
 edbQ==
X-Gm-Message-State: AGi0Pua2HL71ZZtmc9H89CskDMe5nH+46BuAeN3TKZROh6tgEgiEuzVv
 RMFgEjrKZtqJHHGFyFtCjSatu5CuOtL0tQ1ZyBUuQWC6eg1lxsOY8P1GlPAC2BxtBUcn8rvcZTc
 Y6jvhrC3/cVhoTAROZvY69ZJUyU7lmfU=
X-Received: by 2002:a17:90a:8994:: with SMTP id
 v20mr4385765pjn.76.1587458584904; 
 Tue, 21 Apr 2020 01:43:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypIJ+k1DrFkElCqR/GG4Zu7R55hy9VOAU4IYNoN0HL/FFbPsrYC4SKzjJGx1+Hewx7nFOsBMIK6jgJ2msCv0nO8=
X-Received: by 2002:a17:90a:8994:: with SMTP id
 v20mr4385718pjn.76.1587458584582; 
 Tue, 21 Apr 2020 01:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-5-lulu@redhat.com>
 <c70efeb6-e664-2f5b-dc90-8929f1033e35@redhat.com>
In-Reply-To: <c70efeb6-e664-2f5b-dc90-8929f1033e35@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 21 Apr 2020 16:42:53 +0800
Message-ID: <CACLfguW4xHTAKp+RysqNBs06TBEVTDNisrz-4WodzuNGybxe_A@mail.gmail.com>
Subject: Re: [RFC v1 4/4] vhost: introduce vhost_set_vring_ready method
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000007aaf105a3c90127"
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
Cc: cohuck@redhat.com, Michael Tsirkin <mst@redhat.com>, mhabets@solarflare.com,
 qemu-devel@nongnu.org, hanand@xilinx.com, rob.miller@broadcom.com,
 saugatm@xilinx.com, armbru@redhat.com, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, "Wang, Zhihong" <zhihong.wang@intel.com>,
 Ariel Adam <aadam@redhat.com>, rdunlap@infradead.org,
 maxime.coquelin@redhat.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000007aaf105a3c90127
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 12:00 PM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:
> > From: Jason Wang <jasowang@redhat.com>
> >
> > Vhost-vdpa introduces VHOST_VDPA_SET_VRING_ENABLE which complies the
> > semantic of queue_enable defined in virtio spec. This method can be
> > used for preventing device from executing request for a specific
> > virtqueue. This patch introduces the vhost_ops for this.
> >
> > Note that, we've already had vhost_set_vring_enable which has different
> > semantic which allows to enable or disable a specific virtqueue for
> > some kinds of vhost backends. E.g vhost-user use this to changes the
> > number of active queue pairs.
>
>
> This patch seems to mix fours things, please use dedicated patches for:
>
> 1) introduce queue_enabled method for virtio-bus
> 2) implement queue_enabled for virtio-pci
> 3) introduce vhost_set_vring_ready method for vhost ops
> 4) implement vhost_set_vring_ready for vdpa (need to be squashed into
> the patch of vhost-vdpa).
>
> Thanks
>
> Sure, Will fix this

>
> >
> > Author: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   hw/net/vhost_net-stub.c           |  5 +++++
> >   hw/net/vhost_net.c                | 16 ++++++++++++++++
> >   hw/virtio/vhost-vdpa.c            |  9 +++------
> >   hw/virtio/virtio-pci.c            | 13 +++++++++++++
> >   hw/virtio/virtio.c                |  6 ++++++
> >   include/hw/virtio/vhost-backend.h |  2 ++
> >   include/hw/virtio/virtio-bus.h    |  4 ++++
> >   include/net/vhost_net.h           |  1 +
> >   8 files changed, 50 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
> > index aac0e98228..f5ef1e3055 100644
> > --- a/hw/net/vhost_net-stub.c
> > +++ b/hw/net/vhost_net-stub.c
> > @@ -86,6 +86,11 @@ int vhost_set_vring_enable(NetClientState *nc, int
> enable)
> >       return 0;
> >   }
> >
> > +int vhost_set_vring_ready(NetClientState *nc)
> > +{
> > +    return 0;
> > +}
> > +
> >   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
> >   {
> >       return 0;
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 0d13fda2fc..463e333531 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -380,6 +380,10 @@ int vhost_net_start(VirtIODevice *dev,
> NetClientState *ncs,
> >                   goto err_start;
> >               }
> >           }
> > +
> > +        if (virtio_queue_enabled(dev, i)) {
> > +            vhost_set_vring_ready(peer);
> > +        }
> >       }
> >
> >       return 0;
> > @@ -487,6 +491,18 @@ int vhost_set_vring_enable(NetClientState *nc, int
> enable)
> >       return 0;
> >   }
> >
> > +int vhost_set_vring_ready(NetClientState *nc)
> > +{
> > +    VHostNetState *net =3D get_vhost_net(nc);
> > +    const VhostOps *vhost_ops =3D net->dev.vhost_ops;
> > +
> > +    if (vhost_ops && vhost_ops->vhost_set_vring_ready) {
> > +        return vhost_ops->vhost_set_vring_ready(&net->dev);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
> >   {
> >       const VhostOps *vhost_ops =3D net->dev.vhost_ops;
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index 213b327600..49224ef9f8 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -325,18 +325,15 @@ static int vhost_vdpa_get_vq_index(struct
> vhost_dev *dev, int idx)
> >       return idx - dev->vq_index;
> >   }
> >
> > -static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int
> enable)
> > +static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
> >   {
> >       int i;
> >
> >       for (i =3D 0; i < dev->nvqs; ++i) {
> >           struct vhost_vring_state state =3D {
> >               .index =3D dev->vq_index + i,
> > -            .num   =3D enable,
> > +            .num =3D 1,
> >           };
> > -
> > -        state.num =3D 1;
> > -
> >           vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> >       }
> >
> > @@ -368,7 +365,7 @@ const VhostOps vdpa_ops =3D {
> >           .vhost_set_owner =3D vhost_vdpa_set_owner,
> >           .vhost_reset_device =3D vhost_vdpa_reset_device,
> >           .vhost_get_vq_index =3D vhost_vdpa_get_vq_index,
> > -        .vhost_set_vring_enable =3D vhost_vdpa_set_vring_enable,
> > +        .vhost_set_vring_ready =3D vhost_vdpa_set_vring_ready,
> >           .vhost_requires_shm_log =3D NULL,
> >           .vhost_migration_done =3D NULL,
> >           .vhost_backend_can_merge =3D NULL,
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index c6b47a9c73..4aaf5d953e 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1103,6 +1103,18 @@ static AddressSpace
> *virtio_pci_get_dma_as(DeviceState *d)
> >       return pci_get_address_space(dev);
> >   }
> >
> > +static bool virtio_pci_queue_enabled(DeviceState *d, int n)
> > +{
> > +    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(d);
> > +    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> > +
> > +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > +        return proxy->vqs[vdev->queue_sel].enabled;
> > +    }
> > +
> > +    return virtio_queue_get_desc_addr(vdev, n) !=3D 0;
> > +}
> > +
> >   static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
> >                                      struct virtio_pci_cap *cap)
> >   {
> > @@ -2053,6 +2065,7 @@ static void virtio_pci_bus_class_init(ObjectClass
> *klass, void *data)
> >       k->ioeventfd_enabled =3D virtio_pci_ioeventfd_enabled;
> >       k->ioeventfd_assign =3D virtio_pci_ioeventfd_assign;
> >       k->get_dma_as =3D virtio_pci_get_dma_as;
> > +    k->queue_enabled =3D virtio_pci_queue_enabled;
> >   }
> >
> >   static const TypeInfo virtio_pci_bus_info =3D {
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 04716b5f6c..09732a8836 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3169,6 +3169,12 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice
> *vdev, int n)
> >
> >   bool virtio_queue_enabled(VirtIODevice *vdev, int n)
> >   {
> > +    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
> > +    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> > +
> > +    if (k->queue_enabled)
> > +        return k->queue_enabled(qbus->parent, n);
> > +
> >       return virtio_queue_get_desc_addr(vdev, n) !=3D 0;
> >   }
> >
> > diff --git a/include/hw/virtio/vhost-backend.h
> b/include/hw/virtio/vhost-backend.h
> > index d81bd9885f..ce8de6d308 100644
> > --- a/include/hw/virtio/vhost-backend.h
> > +++ b/include/hw/virtio/vhost-backend.h
> > @@ -78,6 +78,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev
> *dev);
> >   typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
> >   typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
> >                                            int enable);
> > +typedef int (*vhost_set_vring_ready_op)(struct vhost_dev *dev);
> >   typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
> >   typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
> >                                          char *mac_addr);
> > @@ -140,6 +141,7 @@ typedef struct VhostOps {
> >       vhost_reset_device_op vhost_reset_device;
> >       vhost_get_vq_index_op vhost_get_vq_index;
> >       vhost_set_vring_enable_op vhost_set_vring_enable;
> > +    vhost_set_vring_ready_op vhost_set_vring_ready;
> >       vhost_requires_shm_log_op vhost_requires_shm_log;
> >       vhost_migration_done_op vhost_migration_done;
> >       vhost_backend_can_merge_op vhost_backend_can_merge;
> > diff --git a/include/hw/virtio/virtio-bus.h
> b/include/hw/virtio/virtio-bus.h
> > index 38c9399cd4..0f6f215925 100644
> > --- a/include/hw/virtio/virtio-bus.h
> > +++ b/include/hw/virtio/virtio-bus.h
> > @@ -83,6 +83,10 @@ typedef struct VirtioBusClass {
> >        */
> >       int (*ioeventfd_assign)(DeviceState *d, EventNotifier *notifier,
> >                               int n, bool assign);
> > +    /*
> > +     * Whether queue number n is enabled.
> > +     */
> > +    bool (*queue_enabled)(DeviceState *d, int n);
> >       /*
> >        * Does the transport have variable vring alignment?
> >        * (ie can it ever call virtio_queue_set_align()?)
> > diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> > index 6f3a624cf7..db473ff4d2 100644
> > --- a/include/net/vhost_net.h
> > +++ b/include/net/vhost_net.h
> > @@ -35,6 +35,7 @@ int vhost_net_notify_migration_done(VHostNetState
> *net, char* mac_addr);
> >   VHostNetState *get_vhost_net(NetClientState *nc);
> >
> >   int vhost_set_vring_enable(NetClientState * nc, int enable);
> > +int vhost_set_vring_ready(NetClientState * nc);
> >
> >   uint64_t vhost_net_get_acked_features(VHostNetState *net);
> >
>
>

--00000000000007aaf105a3c90127
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 21, 2020 at 12:00 PM Jaso=
n Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:<br>
&gt; From: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"=
_blank">jasowang@redhat.com</a>&gt;<br>
&gt;<br>
&gt; Vhost-vdpa introduces VHOST_VDPA_SET_VRING_ENABLE which complies the<b=
r>
&gt; semantic of queue_enable defined in virtio spec. This method can be<br=
>
&gt; used for preventing device from executing request for a specific<br>
&gt; virtqueue. This patch introduces the vhost_ops for this.<br>
&gt;<br>
&gt; Note that, we&#39;ve already had vhost_set_vring_enable which has diff=
erent<br>
&gt; semantic which allows to enable or disable a specific virtqueue for<br=
>
&gt; some kinds of vhost backends. E.g vhost-user use this to changes the<b=
r>
&gt; number of active queue pairs.<br>
<br>
<br>
This patch seems to mix fours things, please use dedicated patches for:<br>
<br>
1) introduce queue_enabled method for virtio-bus<br>
2) implement queue_enabled for virtio-pci<br>
3) introduce vhost_set_vring_ready method for vhost ops<br>
4) implement vhost_set_vring_ready for vdpa (need to be squashed into <br>
the patch of vhost-vdpa).<br>
<br>
Thanks<br>
<br></blockquote><div>Sure, Will fix this=C2=A0=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Author: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=
=3D"_blank">jasowang@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" t=
arget=3D"_blank">jasowang@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/vhost_net-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 5 +++++<br>
&gt;=C2=A0 =C2=A0hw/net/vhost_net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 16 ++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/virtio/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 9 +++------<br>
&gt;=C2=A0 =C2=A0hw/virtio/virtio-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 13 +++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++++++<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/vhost-backend.h |=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-bus.h=C2=A0 =C2=A0 |=C2=A0 4 ++++=
<br>
&gt;=C2=A0 =C2=A0include/net/vhost_net.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A08 files changed, 50 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c<br>
&gt; index aac0e98228..f5ef1e3055 100644<br>
&gt; --- a/hw/net/vhost_net-stub.c<br>
&gt; +++ b/hw/net/vhost_net-stub.c<br>
&gt; @@ -86,6 +86,11 @@ int vhost_set_vring_enable(NetClientState *nc, int =
enable)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +int vhost_set_vring_ready(NetClientState *nc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)=
<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c<br>
&gt; index 0d13fda2fc..463e333531 100644<br>
&gt; --- a/hw/net/vhost_net.c<br>
&gt; +++ b/hw/net/vhost_net.c<br>
&gt; @@ -380,6 +380,10 @@ int vhost_net_start(VirtIODevice *dev, NetClientS=
tate *ncs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0go=
to err_start;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (virtio_queue_enabled(dev, i)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_set_vring_ready(peer)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; @@ -487,6 +491,18 @@ int vhost_set_vring_enable(NetClientState *nc, in=
t enable)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +int vhost_set_vring_ready(NetClientState *nc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VHostNetState *net =3D get_vhost_net(nc);<br>
&gt; +=C2=A0 =C2=A0 const VhostOps *vhost_ops =3D net-&gt;dev.vhost_ops;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vhost_ops &amp;&amp; vhost_ops-&gt;vhost_set_vring_=
ready) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return vhost_ops-&gt;vhost_set_vring_read=
y(&amp;net-&gt;dev);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)=
<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const VhostOps *vhost_ops =3D net-&gt;dev.vh=
ost_ops;<br>
&gt; diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c<br>
&gt; index 213b327600..49224ef9f8 100644<br>
&gt; --- a/hw/virtio/vhost-vdpa.c<br>
&gt; +++ b/hw/virtio/vhost-vdpa.c<br>
&gt; @@ -325,18 +325,15 @@ static int vhost_vdpa_get_vq_index(struct vhost_=
dev *dev, int idx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return idx - dev-&gt;vq_index;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int ena=
ble)<br>
&gt; +static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; dev-&gt;nvqs; ++i) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_vring_state state=
 =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.index =3D dev-&=
gt;vq_index + i,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .num=C2=A0 =C2=A0=3D enable=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .num =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 state.num =3D 1;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_vdpa_call(dev, VHOST_VDP=
A_SET_VRING_ENABLE, &amp;state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -368,7 +365,7 @@ const VhostOps vdpa_ops =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.vhost_set_owner =3D vhost_vdp=
a_set_owner,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.vhost_reset_device =3D vhost_=
vdpa_reset_device,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.vhost_get_vq_index =3D vhost_=
vdpa_get_vq_index,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_vring_enable =3D vhost_vdpa_se=
t_vring_enable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_vring_ready =3D vhost_vdpa_set=
_vring_ready,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.vhost_requires_shm_log =3D NU=
LL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.vhost_migration_done =3D NULL=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.vhost_backend_can_merge =3D N=
ULL,<br>
&gt; diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c<br>
&gt; index c6b47a9c73..4aaf5d953e 100644<br>
&gt; --- a/hw/virtio/virtio-pci.c<br>
&gt; +++ b/hw/virtio/virtio-pci.c<br>
&gt; @@ -1103,6 +1103,18 @@ static AddressSpace *virtio_pci_get_dma_as(Devi=
ceState *d)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return pci_get_address_space(dev);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static bool virtio_pci_queue_enabled(DeviceState *d, int n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIOPCIProxy *proxy =3D VIRTIO_PCI(d);<br>
&gt; +=C2=A0 =C2=A0 VirtIODevice *vdev =3D virtio_bus_get_device(&amp;proxy=
-&gt;bus);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return proxy-&gt;vqs[vdev-&gt;queue_sel].=
enabled;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return virtio_queue_get_desc_addr(vdev, n) !=3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virti=
o_pci_cap *cap)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; @@ -2053,6 +2065,7 @@ static void virtio_pci_bus_class_init(ObjectClas=
s *klass, void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0k-&gt;ioeventfd_enabled =3D virtio_pci_ioeve=
ntfd_enabled;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0k-&gt;ioeventfd_assign =3D virtio_pci_ioeven=
tfd_assign;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0k-&gt;get_dma_as =3D virtio_pci_get_dma_as;<=
br>
&gt; +=C2=A0 =C2=A0 k-&gt;queue_enabled =3D virtio_pci_queue_enabled;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const TypeInfo virtio_pci_bus_info =3D {<br>
&gt; diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
&gt; index 04716b5f6c..09732a8836 100644<br>
&gt; --- a/hw/virtio/virtio.c<br>
&gt; +++ b/hw/virtio/virtio.c<br>
&gt; @@ -3169,6 +3169,12 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice =
*vdev, int n)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0bool virtio_queue_enabled(VirtIODevice *vdev, int n)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));<b=
r>
&gt; +=C2=A0 =C2=A0 VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (k-&gt;queue_enabled)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return k-&gt;queue_enabled(qbus-&gt;paren=
t, n);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return virtio_queue_get_desc_addr(vdev, n) !=
=3D 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vho=
st-backend.h<br>
&gt; index d81bd9885f..ce8de6d308 100644<br>
&gt; --- a/include/hw/virtio/vhost-backend.h<br>
&gt; +++ b/include/hw/virtio/vhost-backend.h<br>
&gt; @@ -78,6 +78,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_de=
v *dev);<br>
&gt;=C2=A0 =C2=A0typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev=
, int idx);<br>
&gt;=C2=A0 =C2=A0typedef int (*vhost_set_vring_enable_op)(struct vhost_dev =
*dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int enable);<br>
&gt; +typedef int (*vhost_set_vring_ready_op)(struct vhost_dev *dev);<br>
&gt;=C2=A0 =C2=A0typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev=
 *dev);<br>
&gt;=C2=A0 =C2=A0typedef int (*vhost_migration_done_op)(struct vhost_dev *d=
ev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 char *mac_addr);<br>
&gt; @@ -140,6 +141,7 @@ typedef struct VhostOps {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_reset_device_op vhost_reset_device;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_get_vq_index_op vhost_get_vq_index;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_set_vring_enable_op vhost_set_vring_en=
able;<br>
&gt; +=C2=A0 =C2=A0 vhost_set_vring_ready_op vhost_set_vring_ready;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_requires_shm_log_op vhost_requires_shm=
_log;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_migration_done_op vhost_migration_done=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_backend_can_merge_op vhost_backend_can=
_merge;<br>
&gt; diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio=
-bus.h<br>
&gt; index 38c9399cd4..0f6f215925 100644<br>
&gt; --- a/include/hw/virtio/virtio-bus.h<br>
&gt; +++ b/include/hw/virtio/virtio-bus.h<br>
&gt; @@ -83,6 +83,10 @@ typedef struct VirtioBusClass {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*ioeventfd_assign)(DeviceState *d, Even=
tNotifier *notifier,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int n, bool assign);<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Whether queue number n is enabled.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 bool (*queue_enabled)(DeviceState *d, int n);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Does the transport have variable vring al=
ignment?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * (ie can it ever call virtio_queue_set_ali=
gn()?)<br>
&gt; diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h<br>
&gt; index 6f3a624cf7..db473ff4d2 100644<br>
&gt; --- a/include/net/vhost_net.h<br>
&gt; +++ b/include/net/vhost_net.h<br>
&gt; @@ -35,6 +35,7 @@ int vhost_net_notify_migration_done(VHostNetState *n=
et, char* mac_addr);<br>
&gt;=C2=A0 =C2=A0VHostNetState *get_vhost_net(NetClientState *nc);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int vhost_set_vring_enable(NetClientState * nc, int enable=
);<br>
&gt; +int vhost_set_vring_ready(NetClientState * nc);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0uint64_t vhost_net_get_acked_features(VHostNetState *net);=
<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div></div>

--00000000000007aaf105a3c90127--


