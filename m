Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85294C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 07:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4542F206D5
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 07:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYyFOIWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4542F206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXJbw-0005Mm-FP
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 03:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJb3-0004vh-MP
 for qemu-devel@nongnu.org; Sat, 09 May 2020 03:08:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26167
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJb1-0004pW-Rb
 for qemu-devel@nongnu.org; Sat, 09 May 2020 03:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589008105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZtYw4YQOOaVGs8TLcH53HILoF/DeA0chJVKfv8yoBM=;
 b=OYyFOIWPl3Lch6R0xZjoKdrzdsjy6K1N09NOh3ZPkdSob7hV9pCMcnlkCau1GoVNPrwYO+
 P4YcNlRlG2WssqH5JspBtkNB49FowYbp4iarIxdWzGcXhId6o+BO7qaGkW6N/ZCgeR4m9D
 M9/mTQ8QNzw4+lGWuUdn3UGN6eSSYRA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-SB6xUfZ1O7ysazsF5nO28A-1; Sat, 09 May 2020 03:08:23 -0400
X-MC-Unique: SB6xUfZ1O7ysazsF5nO28A-1
Received: by mail-pj1-f71.google.com with SMTP id s6so11556279pjq.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 00:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EZtYw4YQOOaVGs8TLcH53HILoF/DeA0chJVKfv8yoBM=;
 b=RbrxGoMsrR4b4kQkgcMtA80ZZb4zkJzserhUnHfkHCJM9W9YdX1hvjkdFPPz/BV6ke
 KMV6BNUOkKEegmRvF9wbmMwXekU9F5A2dKs+Gxj5PsgHxvpAe1w4JXRCvd+ycW/8WCoB
 toVg8Cw8JDc013ds0VaeM5xsN4W70i6VBY/8llDNRzpYEsEG0YuHbqrtjGk3hgnxGJhr
 EVWFkKha8DtPP6I8sHwQhjVk2b5AwGkYEEMBf4i370i2Roj+dSAT3/ikXReN7m3gE63f
 /5saHQ0uWFleKj7HlQf05lzbF+56YwzbqQIH43wjMTnNICC6K52xUakau7c0QBN5rMUk
 Ko2A==
X-Gm-Message-State: AGi0PuZb0wxvwobUra8lSzso66rcLm7/3NTsOiXPiPKlsWuXm5kaFuc+
 /uaMQE/nJ4T5zQfZWgzzF02a1grTlwVvo13Aqeysy0thBLMfTl0AGzOy8JzDe57s6yhr+Qxn0Gs
 5Ckw4jAq6uK/XNgt5tJ3Wt9ZXPxwkM6A=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr5437369pgb.203.1589008101910; 
 Sat, 09 May 2020 00:08:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypL6H0tfyO2FBYWzgluPWuSNFWHZqbn/qN7BRqZ4cXcTR5StpyGUN+I8A6Eiq1oZRNH+j8jl3591aczmLXatdnM=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr5437319pgb.203.1589008101549; 
 Sat, 09 May 2020 00:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-4-lulu@redhat.com>
 <b6988abd-d79a-8af4-4ab0-7f96a37f3c41@redhat.com>
In-Reply-To: <b6988abd-d79a-8af4-4ab0-7f96a37f3c41@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sat, 9 May 2020 15:08:10 +0800
Message-ID: <CACLfguUy+88UfVBq2D3+zNCLvxV6atoGjrV+1inagDcayZw5Hg@mail.gmail.com>
Subject: Re: [RFC v2 3/9] virtio_net: introduce vhost_set_state
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 02:50:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 rdunlap@infradead.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 9, 2020 at 10:25 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/5/9 =E4=B8=8A=E5=8D=8812:32, Cindy Lu wrote:
> > Introduce a function to set the state to the vhost driver.
> > vDPA need to sync the driver's state to NIC
>
>
> Let's split this patch into two.
>
> 1) introduce vhost_set_state
> 2) make virtio-net use of vhost_set_state
>
Sure, Will fix this
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   hw/net/vhost_net.c                | 9 +++++++++
> >   hw/net/virtio-net.c               | 9 +++++++++
> >   include/hw/virtio/vhost-backend.h | 2 ++
> >   include/net/vhost_net.h           | 2 +-
> >   4 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index d1d421e3d9..63b2a85d6e 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -465,3 +465,12 @@ int vhost_net_set_mtu(struct vhost_net *net, uint1=
6_t mtu)
> >
> >       return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
> >   }
> > +int vhost_set_state(NetClientState *nc, uint8_t state)
> > +{
> > +    struct vhost_net *net =3D get_vhost_net(nc);
> > +    struct vhost_dev *hdev =3D &net->dev;
> > +        if (hdev->vhost_ops->vhost_set_state) {
>
>
> Indentation looks wrong.
>
Will fix this
>
> > +                return hdev->vhost_ops->vhost_set_state(hdev, state);
> > +        }
> > +    return 0;
> > +}
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index db3d7c38e6..1bddb4b4af 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -206,6 +206,9 @@ static void virtio_net_vhost_status(VirtIONet *n, u=
int8_t status)
> >       VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >       NetClientState *nc =3D qemu_get_queue(n->nic);
> >       int queues =3D n->multiqueue ? n->max_queues : 1;
> > +    NetClientState *peer =3D qemu_get_peer(nc, 0);
> > +    uint8_t status_set  =3D vdev->status ;
> > +    uint8_t vhost_started_pre =3D n->vhost_started;
> >
> >       if (!get_vhost_net(nc->peer)) {
> >           return;
> > @@ -245,6 +248,7 @@ static void virtio_net_vhost_status(VirtIONet *n, u=
int8_t status)
> >                   return;
> >               }
> >           }
> > +        status_set =3D status_set | VIRTIO_CONFIG_S_DRIVER_OK;
> >
> >           n->vhost_started =3D 1;
> >           r =3D vhost_net_start(vdev, n->nic->ncs, queues);
> > @@ -252,11 +256,16 @@ static void virtio_net_vhost_status(VirtIONet *n,=
 uint8_t status)
> >               error_report("unable to start vhost net: %d: "
> >                            "falling back on userspace virtio", -r);
> >               n->vhost_started =3D 0;
> > +            status_set =3D status_set & ~VIRTIO_CONFIG_S_DRIVER_OK;
> >           }
> >       } else {
> >           vhost_net_stop(vdev, n->nic->ncs, queues);
> > +        status_set =3D status_set & ~VIRTIO_CONFIG_S_DRIVER_OK;
> >           n->vhost_started =3D 0;
> >       }
> > +    if (vhost_started_pre !=3D n->vhost_started) {
> > +            vhost_set_state(peer, status_set);
>
>
> Any reason why not just passing virtio device status to vhost-vdpa?
>
I will double check and fix this
>
> > +    }
> >   }
> >
> >   static int virtio_net_set_vnet_endian_one(VirtIODevice *vdev,
> > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhos=
t-backend.h
> > index 6f6670783f..f823055167 100644
> > --- a/include/hw/virtio/vhost-backend.h
> > +++ b/include/hw/virtio/vhost-backend.h
> > @@ -112,6 +112,7 @@ typedef int (*vhost_get_inflight_fd_op)(struct vhos=
t_dev *dev,
> >   typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
> >                                           struct vhost_inflight *inflig=
ht);
> >
> > +typedef int (*vhost_set_state_op)(struct vhost_dev *dev, uint8_t state=
);
>
>
> Need document what's the meaning of state here, is it e.g virtio device
> status? If yes, is it better to rename it to vhost_set_status()?
>
> Thanks
>
sure will fix this
>
> >   typedef struct VhostOps {
> >       VhostBackendType backend_type;
> >       vhost_backend_init vhost_backend_init;
> > @@ -152,6 +153,7 @@ typedef struct VhostOps {
> >       vhost_backend_mem_section_filter_op vhost_backend_mem_section_fil=
ter;
> >       vhost_get_inflight_fd_op vhost_get_inflight_fd;
> >       vhost_set_inflight_fd_op vhost_set_inflight_fd;
> > +    vhost_set_state_op vhost_set_state;
> >   } VhostOps;
> >
> >   extern const VhostOps user_ops;
> > diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> > index 77e47398c4..6548a5a105 100644
> > --- a/include/net/vhost_net.h
> > +++ b/include/net/vhost_net.h
> > @@ -39,5 +39,5 @@ int vhost_set_vring_enable(NetClientState * nc, int e=
nable);
> >   uint64_t vhost_net_get_acked_features(VHostNetState *net);
> >
> >   int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
> > -
> > +int vhost_set_state(NetClientState *nc, uint8_t state);
> >   #endif
>


