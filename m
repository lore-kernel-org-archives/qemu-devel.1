Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3424C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184E52080A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyVo8rnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184E52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKmc-0004fL-1U
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 04:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTKkI-0003lf-MA
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTKkG-0001dU-KU
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602835546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IIF++QRrWGPDssGgeuYwm4Se6kbcGJAqBUvQJliqRo=;
 b=KyVo8rnMOYPdsu0aPhdePgj/PWnrw6llpS0Md+Vo6ApNC8e9imE03ItLMr1HfMuhc/igAy
 0XEzSHRh7yWdnRiky/mWQvv1A/88tO8MYZ42H3yji/t7SyItYBDmYVKuY0NnChgZG4HU3q
 k2NpiS1WIxP/g/pCzg2NKZ/j4QwNWKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-dhcOJZ3qOTWgDBlRl8sWlg-1; Fri, 16 Oct 2020 04:05:44 -0400
X-MC-Unique: dhcOJZ3qOTWgDBlRl8sWlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5EAC803634;
 Fri, 16 Oct 2020 08:05:43 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 848201002391;
 Fri, 16 Oct 2020 08:05:33 +0000 (UTC)
Subject: Re: [PATCH v10 04/10] virtio-iommu: Call memory notifiers in
 attach/detach
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 alex.williamson@redhat.com
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-5-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <baeff067-ea2c-256b-e9f7-88d51791508d@redhat.com>
Date: Fri, 16 Oct 2020 10:05:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-5-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, bbhushan2@marvell.com, qemu-devel@nongnu.org,
 peterx@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi jean,

On 10/8/20 7:15 PM, Jean-Philippe Brucker wrote:
> From: Bharat Bhushan <bbhushan2@marvell.com>
> 
> Call the memory notifiers when attaching an endpoint to a domain, to
> replay existing mappings, and when detaching the endpoint, to remove all
> mappings.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v10: Remove notifiers_list, rename callbacks
> ---
>  hw/virtio/virtio-iommu.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index fcdf3a819f8..7e6e3cf5200 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -168,11 +168,39 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr virt_start,
>      memory_region_notify_iommu(mr, 0, entry);
>  }
>  
> +static gboolean virtio_iommu_notify_unmap_cb(gpointer key, gpointer value,
> +                                             gpointer data)
> +{
> +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
> +
> +    virtio_iommu_notify_unmap(mr, interval->low, interval->high);
> +
> +    return false;
> +}
> +
> +static gboolean virtio_iommu_notify_map_cb(gpointer key, gpointer value,
> +                                           gpointer data)
> +{
> +    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
> +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
> +
> +    virtio_iommu_notify_map(mr, interval->low, interval->high,
> +                            mapping->phys_addr);
Here also I think we should apply the mapping->flags.
> +
> +    return false;
> +}
> +
>  static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
>  {
> +    VirtIOIOMMUDomain *domain = ep->domain;
> +
>      if (!ep->domain) {
>          return;
>      }
> +    g_tree_foreach(domain->mappings, virtio_iommu_notify_unmap_cb,
> +                   ep->iommu_mr);
>      QLIST_REMOVE(ep, next);
>      ep->domain = NULL;
>  }
> @@ -315,6 +343,10 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>  
>      ep->domain = domain;
>  
> +    /* Replay domain mappings on the associated memory region */
> +    g_tree_foreach(domain->mappings, virtio_iommu_notify_map_cb,
> +                   ep->iommu_mr);
> +
>      return VIRTIO_IOMMU_S_OK;
>  }
>  
> 
Thanks

Eric


