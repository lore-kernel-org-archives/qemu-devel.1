Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DF6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731AC20738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOv4Swju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731AC20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnf6c-0003YD-MY
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnf4Y-0001Ln-Uz
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:18:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnf4X-0000nJ-8J
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592903908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EgPXOhGpTl9TLKfsEx3+lrbm8ndEkSU5XlCTRCncOk=;
 b=QOv4SwjuNBlrJMricqhF44KHOV9WokXV09W3on9OMgkjNuYMKG9G3wEr9vZL726CGnxzPp
 sSQbCbGfvXzKeWFGitw/EJFX5Fg7/edr6HjSo4AzQzHviV6P8kiTqWyTqd/h1ECK9owuKd
 mon5l3OwyDjG+vHPGEbqKA0NgbFURJM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-PWSAAXtJPu-hVW7Wodm3eA-1; Tue, 23 Jun 2020 05:18:26 -0400
X-MC-Unique: PWSAAXtJPu-hVW7Wodm3eA-1
Received: by mail-pf1-f199.google.com with SMTP id r12so15342291pfr.16
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9EgPXOhGpTl9TLKfsEx3+lrbm8ndEkSU5XlCTRCncOk=;
 b=X1Yvf164cyFXzC9XUpowLIKnd3f9ctNJth3j2UKYMVPLximp4HXbCbl6vWd5tyehvX
 VYO6rsC3hyLfbAM2XhMvvP4CPYK0SgM0+3StIsed44yqPVFlxJSeoMdJL4IEbETkoFwz
 PBYRMLbNFUHdUDI3m8hu3Yi5amW6GcoQyDwFdoT5WX9uqdULimdEg7ng3SHm1gI3g4vk
 PvS+GCYQzoQ2xOon4rjCpCf7r76wmbokR5PTsKuogCT25fuC7Fh9qjU1B+jL7WOQnFFF
 u/KELs7DS2Mex4+COzKRAGK24rCxVhfTeULz6JRRRz8mGMAMF4Uvb/QkdED1bardUzIB
 msyA==
X-Gm-Message-State: AOAM532wOYC10aSRi8GzC81/G+pWrK0PdnqPRAqQsPk8j3GFoC3xnvjJ
 1BtOzDJn5WVPecejJf8jaMoyHdYmOX8EKengImvN69Ez9eBfqmsKPCT0esqFcxpSd3GNlK+L2sh
 cd13lSV4pGmISXUrOxMhxX353pCQNQ/I=
X-Received: by 2002:a17:90a:1aaa:: with SMTP id
 p39mr23245278pjp.127.1592903905858; 
 Tue, 23 Jun 2020 02:18:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwtoZU8IcLqCkVuVeSEbya3kfIoQ73xKlC9+oVL14ohUURzZlog3wj2hCu+gr1NQBpG9z/00BAGYjafeZGeKA=
X-Received: by 2002:a17:90a:1aaa:: with SMTP id
 p39mr23245244pjp.127.1592903905578; 
 Tue, 23 Jun 2020 02:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-5-lulu@redhat.com>
 <93b53fe1-02c9-1ff2-871a-d63928cbfe9a@redhat.com>
In-Reply-To: <93b53fe1-02c9-1ff2-871a-d63928cbfe9a@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 23 Jun 2020 17:18:14 +0800
Message-ID: <CACLfguVbuGdZbaaxjA0qDYFgTAzSvo=Ro46hi45bLggd=8YyWg@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] virtio-pci: implement queue_enabled method
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
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

On Tue, Jun 23, 2020 at 3:13 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/22 =E4=B8=8B=E5=8D=8811:37, Cindy Lu wrote:
> > From: Jason Wang <jasowang@redhat.com>
> >
> > With version 1, we can detect whether a queue is enabled via
> > queue_enabled.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   hw/virtio/virtio-pci.c | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 4cb784389c..3918aa9f6c 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1107,6 +1107,23 @@ static AddressSpace *virtio_pci_get_dma_as(Devic=
eState *d)
> >       return pci_get_address_space(dev);
> >   }
> >
> > +static bool  virtio_queue_check_enabled(VirtIODevice *vdev, int n)
>
>
> One space is sufficient between bool and virtio_queue_check_enabled.
>
>
> > +{
> > +    return  virtio_queue_get_desc_addr(vdev, n) !=3D 0;
> > +}
> > +
> > +static bool virtio_pci_queue_enabled(DeviceState *d, int n)
> > +{
> > +    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(d);
> > +    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> > +
> > +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > +        return proxy->vqs[vdev->queue_sel].enabled;
> > +    }
> > +
> > +    return  virtio_queue_check_enabled(vdev, n);
>
>
> Similar issue here.
>
> Thanks
>
Thanks, I will correct this
>
> > +}
> > +
> >   static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
> >                                      struct virtio_pci_cap *cap)
> >   {
> > @@ -2059,6 +2076,7 @@ static void virtio_pci_bus_class_init(ObjectClass=
 *klass, void *data)
> >       k->ioeventfd_enabled =3D virtio_pci_ioeventfd_enabled;
> >       k->ioeventfd_assign =3D virtio_pci_ioeventfd_assign;
> >       k->get_dma_as =3D virtio_pci_get_dma_as;
> > +    k->queue_enabled =3D virtio_pci_queue_enabled;
> >   }
> >
> >   static const TypeInfo virtio_pci_bus_info =3D {
>


