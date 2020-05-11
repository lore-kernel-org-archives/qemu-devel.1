Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E39C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5442137B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIHSNX2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5442137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY0gw-0003NV-DR
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 01:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jY0gK-0002v9-S8
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:08:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27604
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jY0gJ-0008Su-05
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589173724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSg2snSOE23g/TltK5vcp2E5JVuH2/LNMuA22SZKW3A=;
 b=QIHSNX2k5/OoS/X4yNJI/BnZWMCA1m5ARM0NPCzedHMcNYWZaSWAB2RI9y05fWCzgR7uoV
 pBvXr5OUN0Sim3HSs2flxa+jUAyIdwZV19hMwJFkIhzV6C7bak8DOgj3LAXAW2CMuas+3s
 V/hT2Wat+0uqsUSoVbm5hGPteFZ8Izs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-QRuBtVFxMFaVXw4cV6s5Tw-1; Mon, 11 May 2020 01:08:43 -0400
X-MC-Unique: QRuBtVFxMFaVXw4cV6s5Tw-1
Received: by mail-pg1-f199.google.com with SMTP id l7so6882881pgb.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 22:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gSg2snSOE23g/TltK5vcp2E5JVuH2/LNMuA22SZKW3A=;
 b=V6n2ffZGzfWswnaDg93NMoTBlVO0pFuQwDz/Bsh5hnpqO85k4GDld5A8Oxps49j3rB
 7q/JUKjdTEjls9lgLVub6d9kYvsMIaaGUOIrcA6MypAZuItO8LVDOeRmjSjOJ9ji1jEI
 wQ/pNn6A5hROuzEsiDx2z0ooX7xKEJzyPDaRCen3L562h0axz5b61slpzrpqK7yg2x3Z
 DQbKuzzvdKlJQ/uw2/oJ6bA1ogHoRsbUsV9OwtCcsmHbWDttx3a2heDstKvfKiTsGlF4
 wVo4QHSL/2LuqmPftovX0hBPcCeX+tbdSMDX28hKSuDrhzC5Kj0SS59NUlazgqCDJHSr
 o0TQ==
X-Gm-Message-State: AGi0PubkW3kyMF40J1HhTdvH2vH6YW5okAchES3M8A+lc56zxAe5ZZy0
 eenuPIt3jE9wy/btghNy4YWrSQ8vN8l04DLr1DBPFyc5snaynGahpOJL+7uBODii/OszuC0EsuU
 DnfM6pWQPQbFxMdwgauHgLk9bJ+R89qk=
X-Received: by 2002:a17:902:bb86:: with SMTP id
 m6mr13259735pls.341.1589173721913; 
 Sun, 10 May 2020 22:08:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypIdLnGnTYYRjG6hDwBaJ5E4CocVCQSpk5VrPojtCVFRg0QxpOgnUMsLav3+4J0iGjhPNsADf5ONcb2UEeSxjxc=
X-Received: by 2002:a17:902:bb86:: with SMTP id
 m6mr13259709pls.341.1589173721576; 
 Sun, 10 May 2020 22:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-8-lulu@redhat.com>
 <11e5604f-1a29-95ad-9d4b-2d75e5a26d9d@redhat.com>
In-Reply-To: <11e5604f-1a29-95ad-9d4b-2d75e5a26d9d@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 11 May 2020 13:08:30 +0800
Message-ID: <CACLfguUPr0iMv5zi5HupEss52iXhMsfrb7j61BAANfYueGJiDg@mail.gmail.com>
Subject: Re: [RFC v2 7/9] virito-pci: implement queue_enabled method
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 23:06:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Sat, May 9, 2020 at 8:02 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Typo "virtio-pci" in patch subject.
>
Thanks Philippe, I will fix this
> On 5/8/20 6:32 PM, Cindy Lu wrote:
> > From: Jason Wang <jasowang@redhat.com>
> >
> > With version 1, we can detect whether a queue is enabled via
> > queue_enabled.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   hw/virtio/virtio-pci.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index c6b47a9c73..4aaf5d953e 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1103,6 +1103,18 @@ static AddressSpace *virtio_pci_get_dma_as(Devic=
eState *d)
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
> > @@ -2053,6 +2065,7 @@ static void virtio_pci_bus_class_init(ObjectClass=
 *klass, void *data)
> >       k->ioeventfd_enabled =3D virtio_pci_ioeventfd_enabled;
> >       k->ioeventfd_assign =3D virtio_pci_ioeventfd_assign;
> >       k->get_dma_as =3D virtio_pci_get_dma_as;
> > +    k->queue_enabled =3D virtio_pci_queue_enabled;
> >   }
> >
> >   static const TypeInfo virtio_pci_bus_info =3D {
> >
>


