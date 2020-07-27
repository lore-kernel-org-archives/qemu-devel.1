Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052D8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1317206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhQFhv0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1317206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03hS-0004pB-07
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03gS-0004GV-9l
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:00:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03gQ-0004sT-61
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595858449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1PGv/gBtaVVtRbfr70LnvcqFVqdM4A8EyDI+Dcd8pJ0=;
 b=bhQFhv0/hF7e4Dwz/qXPgA4B4zWtkXbJxQbvB2J/AcWRr/NExyw0BpY9B/hidG9A8EAwCg
 ADnjOVjGWPhv6wfzy21MDRxtWhzw6RAw+IIh+hhlVMpi2YIKeASGHgBKRQVggSBnpD+95l
 bbbdxIv5wKD9KXZsZPZY768xagJYvYs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-1_IzO7lpM_Or7E1coi6f4A-1; Mon, 27 Jul 2020 10:00:47 -0400
X-MC-Unique: 1_IzO7lpM_Or7E1coi6f4A-1
Received: by mail-wr1-f72.google.com with SMTP id w1so1949095wro.4
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1PGv/gBtaVVtRbfr70LnvcqFVqdM4A8EyDI+Dcd8pJ0=;
 b=WIz9xlthDH1FYGRd/mJH+jQ5ODjm+hpu48LsKAhoo3v5ip0MmmU9PAjy5MwSCukF+v
 0psVeGzdRPVdpGPO/BYmNozPH9w7IZ4r7JFnTUocXNM5+OKpyg+3Ww9M/OMgnVKnVDiG
 zh77Jzsy6u/XqOKj4mse8nJEwLIU9BLTjbANePSNZh4T08q76lUDv9exuWi0SD7u1tT3
 3OtE6HPSjl070sNuS+JY+ojjSHtWiIlxZomd/cR4u08YGsxR1S8rrdmsWcTz/Cqq0ih8
 cMCEZwGYAhZQEYj7epBQrFxvU6WEAx6oVfL7oyf4AF3BCM5BJKUQPJ3M9u6pAKNFyVJA
 XNeQ==
X-Gm-Message-State: AOAM530T3eWzswsN7yicKNdGp73OQFsWKJFnG3Sc0n2335PJt/Xi5SKm
 lLka6FUieWClc/j9Jl+5HuDWkJj/k1vC97xTRtUCIFfhQtyjoi3i4Yrl5sr10gkMFhSjusrT2Vv
 w7yPgm6RZYzO3prw=
X-Received: by 2002:a1c:984d:: with SMTP id a74mr21877285wme.140.1595858445764; 
 Mon, 27 Jul 2020 07:00:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHYXzYzwt3dkv8R97qlEK0O+mXXb28PJ42Zp2OjiVQzKOTu/O6WPfDyi1pad56Pu08iXyCHw==
X-Received: by 2002:a1c:984d:: with SMTP id a74mr21877240wme.140.1595858445181; 
 Mon, 27 Jul 2020 07:00:45 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id t2sm18808723wmb.28.2020.07.27.07.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 07:00:44 -0700 (PDT)
Date: Mon, 27 Jul 2020 10:00:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PULL v2 31/41] virtio-pci: implement queue_enabled method
Message-ID: <20200727095743-mutt-send-email-mst@kernel.org>
References: <20200704182750.1088103-1-mst@redhat.com>
 <20200704182750.1088103-32-mst@redhat.com>
 <42c43784-627f-80ee-b9cb-5d22b127235a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <42c43784-627f-80ee-b9cb-5d22b127235a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 03:51:41PM +0200, Laurent Vivier wrote:
> On 04/07/2020 20:30, Michael S. Tsirkin wrote:
> > From: Jason Wang <jasowang@redhat.com>
> > 
> > With version 1, we can detect whether a queue is enabled via
> > queue_enabled.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > Message-Id: <20200701145538.22333-5-lulu@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 7bc8c1c056..8554cf2a03 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1107,6 +1107,18 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
> >      return pci_get_address_space(dev);
> >  }
> >  
> > +static bool virtio_pci_queue_enabled(DeviceState *d, int n)
> > +{
> > +    VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
> > +    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> > +
> > +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > +        return proxy->vqs[vdev->queue_sel].enabled;
> > +    }
> > +
> > +    return virtio_queue_enabled(vdev, n);
> > +}
> 
> With "disable-legacy=off,disable-modern=true",
> this changes introduces an infinite loop: virtio_queue_enabled() calls
> again virtio_pci_queue_enabled() that calls
> againvirtio_pci_queue_enabled()...
> 
> I think this should be changed like this:
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index ada1101d07..0a85c17e91 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1116,7 +1116,7 @@ static bool virtio_pci_queue_enabled(DeviceState
> *d, int n)
>          return proxy->vqs[vdev->queue_sel].enabled;
>      }
> 
> -    return virtio_queue_enabled(vdev, n);
> +    return virtio_queue_get_desc_addr(vdev, n) != 0;
>  }
> 

Thanks for the report and debugging the issue!

Maybe move
       return virtio_queue_get_desc_addr(vdev, n) != 0;
to a new API
	virtio_pci_queue_enabled_legacy()

to avoid code duplication.

Could you cook up a patch pls? don't forget the Fixes: tag
so people remember to backport it.




> > +
> >  static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
> >                                     struct virtio_pci_cap *cap)
> >  {
> > @@ -2064,6 +2076,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
> >      k->ioeventfd_enabled = virtio_pci_ioeventfd_enabled;
> >      k->ioeventfd_assign = virtio_pci_ioeventfd_assign;
> >      k->get_dma_as = virtio_pci_get_dma_as;
> > +    k->queue_enabled = virtio_pci_queue_enabled;
> >  }
> >  
> >  static const TypeInfo virtio_pci_bus_info = {
> > 
> 
> Thanks,
> Laurent


