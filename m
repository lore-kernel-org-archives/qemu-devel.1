Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85123C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C300206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfsiWi3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C300206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClYT-0000V8-Be
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jClVC-0003dF-4P
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jClVA-0002BF-UR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:41:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40860
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jClVA-0002AQ-RD
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584110488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1zSnj9J6ob7Sfz2lTwIToqr1OnQwfXjRKbrKUiZo9n0=;
 b=BfsiWi3mu+KqLkSmu1u5E0dZedTw3cfHcyN09V5ArWEVP2dPAhu5YwPZoCp6VhCOTWU1qQ
 ffwZN+I/ib5K/4ftXa/7vmclR0NlqK8kwLmx2cFUgos/suEK/ktaprnq5G9kQezwQPT6YS
 CC7XjR2yvPnfi1DFez+S7psUJOYcVr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-O6dzKMXOPiyOFO8hglQX6g-1; Fri, 13 Mar 2020 10:41:24 -0400
X-MC-Unique: O6dzKMXOPiyOFO8hglQX6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C26D18B9FC2;
 Fri, 13 Mar 2020 14:41:22 +0000 (UTC)
Received: from [10.36.118.12] (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5F079A6A;
 Fri, 13 Mar 2020 14:41:09 +0000 (UTC)
Subject: Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for attach/detach
To: Bharat Bhushan <bbhushan2@marvell.com>, peter.maydell@linaro.org,
 peterx@redhat.com, eric.auger.pro@gmail.com, alex.williamson@redhat.com,
 kevin.tian@intel.com, mst@redhat.com, tnowicki@marvell.com,
 drjones@redhat.com, linuc.decode@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, bharatb.linux@gmail.com
References: <20200313074811.27175-1-bbhushan2@marvell.com>
 <20200313074811.27175-4-bbhushan2@marvell.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <da0a4d7b-c27d-839d-56b6-da67c94adeb7@redhat.com>
Date: Fri, 13 Mar 2020 15:41:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200313074811.27175-4-bbhushan2@marvell.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat

On 3/13/20 8:48 AM, Bharat Bhushan wrote:
> iommu-notifier are called when a device is attached
IOMMU notifiers
> or detached to as address-space.
> This is needed for VFIO.
and vhost for detach
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  hw/virtio/virtio-iommu.c | 47 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index e51344a53e..2006f72901 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -49,6 +49,7 @@ typedef struct VirtIOIOMMUEndpoint {
>      uint32_t id;
>      VirtIOIOMMUDomain *domain;
>      QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
> +    VirtIOIOMMU *viommu;
This needs specal care on post-load. When migrating the EPs, only the id
is migrated. On post-load you need to set viommu as it is done for
domain. migration is allowed with vhost.
>  } VirtIOIOMMUEndpoint;
>  
>  typedef struct VirtIOIOMMUInterval {
> @@ -155,8 +156,44 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
>      memory_region_notify_iommu(mr, 0, entry);
>  }
>  
> +static gboolean virtio_iommu_mapping_unmap(gpointer key, gpointer value,
> +                                           gpointer data)
> +{
> +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
> +
> +    virtio_iommu_notify_unmap(mr, interval->low,
> +                              interval->high - interval->low + 1);
> +
> +    return false;
> +}
> +
> +static gboolean virtio_iommu_mapping_map(gpointer key, gpointer value,
> +                                         gpointer data)
> +{
> +    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
> +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
> +
> +    virtio_iommu_notify_map(mr, interval->low, mapping->phys_addr,
> +                            interval->high - interval->low + 1);
> +
> +    return false;
> +}
> +
>  static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
>  {
> +    VirtioIOMMUNotifierNode *node;
> +    VirtIOIOMMU *s = ep->viommu;
> +    VirtIOIOMMUDomain *domain = ep->domain;
> +
> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
> +        if (ep->id == node->iommu_dev->devfn) {
> +            g_tree_foreach(domain->mappings, virtio_iommu_mapping_unmap,
> +                           &node->iommu_dev->iommu_mr);
I understand this should fo the job for domain removal
> +        }
> +    }
> +
>      if (!ep->domain) {
>          return;
>      }
> @@ -178,6 +215,7 @@ static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>      }
>      ep = g_malloc0(sizeof(*ep));
>      ep->id = ep_id;
> +    ep->viommu = s;
>      trace_virtio_iommu_get_endpoint(ep_id);
>      g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
>      return ep;
> @@ -272,6 +310,7 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>  {
>      uint32_t domain_id = le32_to_cpu(req->domain);
>      uint32_t ep_id = le32_to_cpu(req->endpoint);
> +    VirtioIOMMUNotifierNode *node;
>      VirtIOIOMMUDomain *domain;
>      VirtIOIOMMUEndpoint *ep;
>  
> @@ -299,6 +338,14 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>  
>      ep->domain = domain;
>  
> +    /* Replay existing address space mappings on the associated memory region */
maybe use the "domain" terminology here.
> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
> +        if (ep_id == node->iommu_dev->devfn) {
> +            g_tree_foreach(domain->mappings, virtio_iommu_mapping_map,
> +                           &node->iommu_dev->iommu_mr);
> +        }
> +    }
> +
>      return VIRTIO_IOMMU_S_OK;
>  }
>  
> 
Thanks

Eric


