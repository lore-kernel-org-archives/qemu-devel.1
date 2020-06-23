Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE997C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1B420679
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kfony/zP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1B420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfQZ-0007gm-RP
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnfJx-0004ne-J9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:34:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23607
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnfJv-0001q3-QD
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592904863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUuHwU6vGTCW+Kc1yUrUqQEjtwBovtWJJJPsDWGQUeY=;
 b=Kfony/zPHReEOC3HKHuybaU7Z0azGtq2KAXd5Kc3SV88OEaGdEWCjsRA/sph3IY4AYBXUz
 paXb7wq1VrOhrBx8IwUhsTZpJmlenu2Ng9P1TUEXJxAukHMFUTPZjnMSCreCbUfepArigt
 F2YVOPc1xoy0tgg8LSp7LlZ707iSpIM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-AqbNGe4LOqCfkJAoBq80mg-1; Tue, 23 Jun 2020 05:34:21 -0400
X-MC-Unique: AqbNGe4LOqCfkJAoBq80mg-1
Received: by mail-pj1-f72.google.com with SMTP id cq18so1804222pjb.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HUuHwU6vGTCW+Kc1yUrUqQEjtwBovtWJJJPsDWGQUeY=;
 b=VBS6cd+Pl6RbbbSF03J11tSG7G3RkqzE/3X1rJGuXGebmhFyXEg60QQImek5QYzvtY
 ociy2irrm8cf4Jyw7QbBChRHzu7f7HD99w3m+W5Hr+4Cn3MN47LqOscFaGMnukrir+NM
 ODLhEp9dcFz5B4YxyXXzgS2HJRB54w+IPfjV0AnajzPHt5cDQ75LX9EgRGNpw4Mgr+N7
 iyDG4xR8EqHpbAQDDa8qJ7ZyYw4Jw9UjkjIlnbouvB0SkNi3r6j43mKH3EoA4dHwIfyU
 njrA78PcIzsrADbp/LQw1Yjz4lCMd6lUZB1/S/kl9xrfdylh7Qrc46yfpSMz9YeerPWm
 x8tA==
X-Gm-Message-State: AOAM532sWUxl6j7GrAW3ih4JdACbs8wCz5ZvAXKfT/hxTsEaoNG2WQOd
 4MOZGVJg31JPZ+PBRXM96g+uOGYc6yjcyvWc9eB2GXW4NyNwx1bmkMlHY0241Mmx6+3HNocjRcD
 fuFw9Y1UzStpgxjFCHOuUHo6ZcY2klRU=
X-Received: by 2002:a63:1617:: with SMTP id w23mr16796212pgl.248.1592904860514; 
 Tue, 23 Jun 2020 02:34:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7mcyZrmIq9tPAx13S1lwU7XCKlvhpcZpEcoXGEzlctgHXyGngKHRs447r3jnAfgrQckCw6Lpxf0BhCTSvU6c=
X-Received: by 2002:a63:1617:: with SMTP id w23mr16796185pgl.248.1592904860217; 
 Tue, 23 Jun 2020 02:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-9-lulu@redhat.com>
 <3fab12a1-1c44-b18d-cfb8-f069190e0b2c@redhat.com>
In-Reply-To: <3fab12a1-1c44-b18d-cfb8-f069190e0b2c@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 23 Jun 2020 17:34:09 +0800
Message-ID: <CACLfguWkntyF0Syrcy=90X8jweCJFASgz7=tN4yS1CpZ+Bo7=g@mail.gmail.com>
Subject: Re: [PATCH v1 08/10] vhost: implement vhost_dev_start method
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
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
Cc: Cornelia Huck <cohuck@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, hanand@xilinx.com,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 rdunlap@infradead.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 3:21 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/22 =E4=B8=8B=E5=8D=8811:37, Cindy Lu wrote:
> > use the vhost_dev_start callback to send the status to backend
>
>
> I suggest to squash this into previous patch.
>
Sure will do
>
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   hw/virtio/vhost.c         | 17 +++++++++++++++++
> >   include/hw/virtio/vhost.h |  2 ++
> >   2 files changed, 19 insertions(+)
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 01ebe12f28..bfd7f9ce1f 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -744,6 +744,7 @@ static void vhost_iommu_region_del(MemoryListener *=
listener,
> >       }
> >   }
> >
> > +
> >   static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
> >                                       struct vhost_virtqueue *vq,
> >                                       unsigned idx, bool enable_log)
> > @@ -1661,6 +1662,11 @@ int vhost_dev_start(struct vhost_dev *hdev, Virt=
IODevice *vdev)
> >           }
> >       }
> >
> > +    r =3D vhost_set_start(hdev, true);
>
>
> I think we need a better name for this function.
>
Shall we change it to vhost_set_device_start ? Since the
vhost_dev_start was occupied by other function
>
> > +    if (r) {
> > +        goto fail_log;
> > +    }
> > +
> >       if (vhost_dev_has_iommu(hdev)) {
> >           hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
> >
> > @@ -1697,6 +1703,8 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtI=
ODevice *vdev)
> >       /* should only be called after backend is connected */
> >       assert(hdev->vhost_ops);
> >
> > +    vhost_set_start(hdev, false);
> > +
> >       for (i =3D 0; i < hdev->nvqs; ++i) {
> >           vhost_virtqueue_stop(hdev,
> >                                vdev,
> > @@ -1722,3 +1730,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev=
,
> >
> >       return -1;
> >   }
> > +
> > +int vhost_set_start(struct vhost_dev *hdev, bool started)
> > +{
> > +
> > +    if (hdev->vhost_ops->vhost_dev_start) {
> > +        hdev->vhost_ops->vhost_dev_start(hdev, started);
> > +    }
> > +    return 0;
> > +}
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 085450c6f8..59ea53f8c2 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -92,6 +92,7 @@ struct vhost_dev {
> >       const VhostDevConfigOps *config_ops;
> >   };
> >
> > +
> >   int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> >                      VhostBackendType backend_type,
> >                      uint32_t busyloop_timeout);
> > @@ -137,4 +138,5 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
> >                              struct vhost_inflight *inflight);
> >   int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size=
,
> >                              struct vhost_inflight *inflight);
> > +int vhost_set_start(struct vhost_dev *dev, bool started);
>
>
> Any reason for exporting this? It looks to me there's no real user out
> this file.
>
> Thanks
>
Sure will fix this
>
> >   #endif
>


