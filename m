Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E41EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D482313C
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ld7aZeKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D482313C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpno3-0004Ju-L5
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 03:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jpnnF-0003sI-QQ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 03:01:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20563
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jpnnC-0007Ua-PQ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 03:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593414084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFmMXoO2RzLZgdezHy40nQTpmdNgHpdVXaFOawgbj4w=;
 b=Ld7aZeKSVzUdmwxam/OmuILt+DdgnobFwHQiyU350zFpALppJatO9yaGsuXN5+Qdzi9dz5
 5wk0xt2uyBAh0oE+puaRZH2gdVyzFutIsrK0caaadYQyxUTovpo/epEGu9GlAOmV4shF4R
 O2xMn0Sl3O4j+DnItiaIg2GpGMSqpMc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-3tKC0v4sPMqiSdC5Gx6mCg-1; Mon, 29 Jun 2020 03:01:22 -0400
X-MC-Unique: 3tKC0v4sPMqiSdC5Gx6mCg-1
Received: by mail-pj1-f71.google.com with SMTP id t7so2321564pjl.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 00:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BFmMXoO2RzLZgdezHy40nQTpmdNgHpdVXaFOawgbj4w=;
 b=jNW2ccjhcfOxp11LxrIFsV9WuXu0VI9fKo91YpR0aK5WkCQXx0rC53w6Cd/ClJpf9G
 YVao83hTsumbV8LuvEGxFBV2cVGrNz/4jFlGpIUFLsnSWJdrVFGmmjK+Mt08Fv/Q14rx
 /jZlih+IEo3GqJNkAWlu1yDus2MHypkGYiSEWBM8kiZ4oEa3hlrrM4sjFjlh2o3DGmX5
 LoHFbHOFw6ZkLlYeGkAPKlItbcuOtOjEb42eyRWWlMUuoIjBQwwGfB+RXStiTNCSAbBp
 mkfADoyZtl4hkWOtUdnNCj/JREd3U1OHhRy4NsxK3uj7yyu0V5Y/+5GkHOioNJ6IGZxY
 B2mw==
X-Gm-Message-State: AOAM530F5dhJSr6Qpigsk+8PEO7cUt3sTvARAx8n44SvVfpt8WIj56pa
 /mQlE8mzNNTpdd5CDyNspdsY8gXuI+Nx9mVQsjrCBEutvQfhl5vKel8iJ8yAHBN75HXWI8+2O27
 AcycNmUcYFzKzsMSx0AYEP9E7sqAThAk=
X-Received: by 2002:a17:90b:30c4:: with SMTP id
 hi4mr15311962pjb.166.1593414081854; 
 Mon, 29 Jun 2020 00:01:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvBT0VU48ZDboIf0klmyOLV0zRh+nS0rzPzBJbVnyeBxc3MzFbc4ui1ywNx0E6cjYE9gk4A9Yoj0tr7fJ4uT8=
X-Received: by 2002:a17:90b:30c4:: with SMTP id
 hi4mr15311909pjb.166.1593414081464; 
 Mon, 29 Jun 2020 00:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-9-lulu@redhat.com>
 <debee1c4-89d6-27fa-65ff-ec2e630eca63@redhat.com>
In-Reply-To: <debee1c4-89d6-27fa-65ff-ec2e630eca63@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 29 Jun 2020 15:01:10 +0800
Message-ID: <CACLfguVmhtyWGW64Nb6V9_DN4oRNLJ1F51aa8YpepGFZVW5Xew@mail.gmail.com>
Subject: Re: [PATCH v1 08/10] vhost: implement vhost_dev_start method
To: Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Jason Wang <jasowang@redhat.com>, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Ariel Adam <aadam@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 10:35 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 22/06/2020 17:37, Cindy Lu wrote:
> > use the vhost_dev_start callback to send the status to backend
>
> I agree with Jason, squash this patch with the previous one.
>
will fix this
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/virtio/vhost.c         | 17 +++++++++++++++++
> >  include/hw/virtio/vhost.h |  2 ++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 01ebe12f28..bfd7f9ce1f 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -744,6 +744,7 @@ static void vhost_iommu_region_del(MemoryListener *=
listener,
> >      }
> >  }
> >
> > +
> >  static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
> >                                      struct vhost_virtqueue *vq,
> >                                      unsigned idx, bool enable_log)
> > @@ -1661,6 +1662,11 @@ int vhost_dev_start(struct vhost_dev *hdev, Virt=
IODevice *vdev)
> >          }
> >      }
> >
> > +    r =3D vhost_set_start(hdev, true);
>
> Perhaps you can use the same kind of name we have for the queue
> (queue_set_started()) and use something like vhost_dev_set_started()?
>
sure=EF=BC=8C will fix this
> > +    if (r) {
> > +        goto fail_log;
> > +    }
> > +
> >      if (vhost_dev_has_iommu(hdev)) {
> >          hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
> >
> > @@ -1697,6 +1703,8 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtI=
ODevice *vdev)
> >      /* should only be called after backend is connected */
> >      assert(hdev->vhost_ops);
> >
> > +    vhost_set_start(hdev, false);
> > +
> >      for (i =3D 0; i < hdev->nvqs; ++i) {
> >          vhost_virtqueue_stop(hdev,
> >                               vdev,
> > @@ -1722,3 +1730,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev=
,
> >
> >      return -1;
> >  }
> > +
> > +int vhost_set_start(struct vhost_dev *hdev, bool started)
> > +{
> > +
> > +    if (hdev->vhost_ops->vhost_dev_start) {
> > +        hdev->vhost_ops->vhost_dev_start(hdev, started);
>
> The "return" is missing.
>
> And generally a function that only embeds a call to a hook has the same
> as the hook.
>
> > +    }
> > +    return 0;
> > +}
>
> so something like:
>
>     int vhost_dev_set_started(struct vhost_dev *hdev, bool started)
>     {
>         if (hdev->vhost_ops->dev_set_started) {
>             return hdev->vhost_ops->dev_set_started(hdev, started);
>         }
>         return 0;
>     }
>
>
thanks will fix this
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 085450c6f8..59ea53f8c2 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -92,6 +92,7 @@ struct vhost_dev {
> >      const VhostDevConfigOps *config_ops;
> >  };
> >
> > +
> >  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> >                     VhostBackendType backend_type,
> >                     uint32_t busyloop_timeout);
> > @@ -137,4 +138,5 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
> >                             struct vhost_inflight *inflight);
> >  int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
> >                             struct vhost_inflight *inflight);
> > +int vhost_set_start(struct vhost_dev *dev, bool started);
>
> There is no need to export it, so set it "static" in hw/virtio/vhost.c
> and move the definition before the use.
>
thanks will fix this
> Thanks,
> Laurent
>


