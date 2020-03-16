Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801A4C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 06:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF7B20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 06:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkFHmJxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF7B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDjZV-0000Eo-03
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 02:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharatb.linux@gmail.com>) id 1jDjRP-00078Q-Ex
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 02:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharatb.linux@gmail.com>) id 1jDjRN-0007G0-Vg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 02:41:35 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bharatb.linux@gmail.com>)
 id 1jDjRN-00078k-Nk; Mon, 16 Mar 2020 02:41:33 -0400
Received: by mail-qk1-x742.google.com with SMTP id s11so12985389qks.8;
 Sun, 15 Mar 2020 23:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jHrIFWBUYTbisZLiMXCYNj6xT1LOq7327qexPzoyprU=;
 b=SkFHmJxFDXomPNsVp6v6tnXhIehgkKu+faslmL1lYDVZqy5jbBq7yKb3tg6RBRaWG0
 bGQBEe1dFBT0faZ5LFGt5ptkHzKYaOFGKKy0U8glbQKxuuBer78cGI/NWIQwH6n7Me2Q
 oeAM9767yoYZjIrNax9Psh9eVGqsEmRiQgNhfNjMp90paLEVii+xXkfB/57nTwGcEgYe
 nqYIgV79VyuZH9yPklKHLSgHBQWtUb9Wz8hAV6JrwmhVoiKPtpEvmfQlxbhSddh0S5bf
 CDInQfDDKcmMxwKDLmm78f8+WQVmNk3TFnMA+ftWitGURFg2Z5GsCxMQvGVYNGegt4c2
 48ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jHrIFWBUYTbisZLiMXCYNj6xT1LOq7327qexPzoyprU=;
 b=hNN0ul0w0hX9JbGjdJ8U8uwIqkPxbw2/j66Wq2ew8Whn0wuzC7q/1PsVEks7qkCOp/
 SotcP5v8+ds8tr8GeyRJmkvGe4YyFHKSo6tGMtEEuQsv4Mq0FTJlkIo02XE6lZHkVD1k
 +habgBKTOeA3uW2V5/kSk/u3iOzztfJuwT4CY+YktFjzzLs1AbEvxodzoTEnNB3o02ju
 8G+zohs/QOJOA0pp7prcj95L2GpKJwvBK6KlSANhY1PeQh93TG+tu6dCpyErAj29PfTY
 WSiscmLz3akqLZVGYjMAED0WCgFzV3icJMPPV0hY4PX4z70dGjQ0atYH2CwlYaoXOo2p
 HLHg==
X-Gm-Message-State: ANhLgQ0inhxVPelkA78weHPsjb4kVsmjQZ9Gtx8NH9bc7j8M/G0VUmJK
 NXuWieqvV/xEELZZFuaPdtXj2oVHbNvE/dfhv7k=
X-Google-Smtp-Source: ADFU+vvNDC96kpgb7QABw69og6DNZ99nQ+pllxlAVfE4rAxSXznFxvuyQZhVMuzb8Hu0Y8o7xHZDjbYo/lx6Sc32Rt8=
X-Received: by 2002:a05:620a:22b:: with SMTP id
 u11mr24574374qkm.225.1584340892917; 
 Sun, 15 Mar 2020 23:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200313074811.27175-1-bbhushan2@marvell.com>
 <20200313074811.27175-4-bbhushan2@marvell.com>
 <da0a4d7b-c27d-839d-56b6-da67c94adeb7@redhat.com>
In-Reply-To: <da0a4d7b-c27d-839d-56b6-da67c94adeb7@redhat.com>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Mon, 16 Mar 2020 12:11:21 +0530
Message-ID: <CAAeCc_m=PKV0T8DmaE06F9NMYfU792f9TDdoyKkaPaEN3597ag@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for attach/detach
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 mst@redhat.com, drjones@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, qemu-arm@nongnu.org,
 Bharat Bhushan <bbhushan2@marvell.com>, linuc.decode@gmail.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On Fri, Mar 13, 2020 at 8:11 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Bharat
>
> On 3/13/20 8:48 AM, Bharat Bhushan wrote:
> > iommu-notifier are called when a device is attached
> IOMMU notifiers
> > or detached to as address-space.
> > This is needed for VFIO.
> and vhost for detach
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> >  hw/virtio/virtio-iommu.c | 47 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> > index e51344a53e..2006f72901 100644
> > --- a/hw/virtio/virtio-iommu.c
> > +++ b/hw/virtio/virtio-iommu.c
> > @@ -49,6 +49,7 @@ typedef struct VirtIOIOMMUEndpoint {
> >      uint32_t id;
> >      VirtIOIOMMUDomain *domain;
> >      QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
> > +    VirtIOIOMMU *viommu;
> This needs specal care on post-load. When migrating the EPs, only the id
> is migrated. On post-load you need to set viommu as it is done for
> domain. migration is allowed with vhost.

ok, I have not tried vhost/migration. Below change set viommu when
reconstructing endpoint.

@@ -984,6 +973,7 @@ static gboolean reconstruct_endpoints(gpointer
key, gpointer value,

     QLIST_FOREACH(iter, &d->endpoint_list, next) {
         iter->domain = d;
+       iter->viommu = s;
         g_tree_insert(s->endpoints, GUINT_TO_POINTER(iter->id), iter);
     }
     return false; /* continue the domain traversal */

> >  } VirtIOIOMMUEndpoint;
> >
> >  typedef struct VirtIOIOMMUInterval {
> > @@ -155,8 +156,44 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
> >      memory_region_notify_iommu(mr, 0, entry);
> >  }
> >
> > +static gboolean virtio_iommu_mapping_unmap(gpointer key, gpointer value,
> > +                                           gpointer data)
> > +{
> > +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
> > +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
> > +
> > +    virtio_iommu_notify_unmap(mr, interval->low,
> > +                              interval->high - interval->low + 1);
> > +
> > +    return false;
> > +}
> > +
> > +static gboolean virtio_iommu_mapping_map(gpointer key, gpointer value,
> > +                                         gpointer data)
> > +{
> > +    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
> > +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
> > +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
> > +
> > +    virtio_iommu_notify_map(mr, interval->low, mapping->phys_addr,
> > +                            interval->high - interval->low + 1);
> > +
> > +    return false;
> > +}
> > +
> >  static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
> >  {
> > +    VirtioIOMMUNotifierNode *node;
> > +    VirtIOIOMMU *s = ep->viommu;
> > +    VirtIOIOMMUDomain *domain = ep->domain;
> > +
> > +    QLIST_FOREACH(node, &s->notifiers_list, next) {
> > +        if (ep->id == node->iommu_dev->devfn) {
> > +            g_tree_foreach(domain->mappings, virtio_iommu_mapping_unmap,
> > +                           &node->iommu_dev->iommu_mr);
> I understand this should fo the job for domain removal

did not get the comment, are you saying we should do this on domain removal?

> > +        }
> > +    }
> > +
> >      if (!ep->domain) {
> >          return;
> >      }
> > @@ -178,6 +215,7 @@ static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
> >      }
> >      ep = g_malloc0(sizeof(*ep));
> >      ep->id = ep_id;
> > +    ep->viommu = s;
> >      trace_virtio_iommu_get_endpoint(ep_id);
> >      g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
> >      return ep;
> > @@ -272,6 +310,7 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
> >  {
> >      uint32_t domain_id = le32_to_cpu(req->domain);
> >      uint32_t ep_id = le32_to_cpu(req->endpoint);
> > +    VirtioIOMMUNotifierNode *node;
> >      VirtIOIOMMUDomain *domain;
> >      VirtIOIOMMUEndpoint *ep;
> >
> > @@ -299,6 +338,14 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
> >
> >      ep->domain = domain;
> >
> > +    /* Replay existing address space mappings on the associated memory region */
> maybe use the "domain" terminology here.

ok,

Thanks
-Bharat

> > +    QLIST_FOREACH(node, &s->notifiers_list, next) {
> > +        if (ep_id == node->iommu_dev->devfn) {
> > +            g_tree_foreach(domain->mappings, virtio_iommu_mapping_map,
> > +                           &node->iommu_dev->iommu_mr);
> > +        }
> > +    }
> > +
> >      return VIRTIO_IOMMU_S_OK;
> >  }
> >
> >
> Thanks
>
> Eric
>

