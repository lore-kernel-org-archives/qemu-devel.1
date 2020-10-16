Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81064C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96843206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEvgHsD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96843206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTLzO-000475-6e
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 05:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTLyM-0003Em-NB
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTLyK-00042y-Jt
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602840263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/ff1+vxvwltolUdKvgVMtfm0+Yb8feLHsrb8j3/TUQ=;
 b=EEvgHsD7HjgZRg4ZRyBjqqpRjwFIkjyNA2XhNbKiUBG3XAFVpiTZPKu2Y2y25OYVN8xC8b
 x5/yt8X8cPiCG0co0GbBnmufBKQQUyzl/YLo8g4D3pFjaDn51GVWmkKlixnFru6ieJvErH
 HQHJHaQWI71D1YCD3F2xxe5yxSR+Vow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-FDINPzJGORqs3ajOyjnUjg-1; Fri, 16 Oct 2020 05:24:21 -0400
X-MC-Unique: FDINPzJGORqs3ajOyjnUjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B5621006703;
 Fri, 16 Oct 2020 09:24:20 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F20A57512E;
 Fri, 16 Oct 2020 09:24:10 +0000 (UTC)
Subject: Re: [PATCH v10 07/10] memory: Add interface to set iommu page size
 mask
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 alex.williamson@redhat.com
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-8-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1596d3e7-274c-5744-5f2f-8f5cb50cdb40@redhat.com>
Date: Fri, 16 Oct 2020 11:24:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-8-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Hi Jean,

On 10/8/20 7:15 PM, Jean-Philippe Brucker wrote:
> From: Bharat Bhushan <bbhushan2@marvell.com>
> 
> Allow to set the page size mask supported by an iommu memory region.
> This enables a vIOMMU to communicate the page size granule supported by
> an assigned device, on hosts that use page sizes greater than 4kB.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v10: Add errp parameter
> ---
>  include/exec/memory.h | 26 ++++++++++++++++++++++++++
>  softmmu/memory.c      | 13 +++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index dee09851622..c2da8381bec 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -382,6 +382,20 @@ struct IOMMUMemoryRegionClass {
>       * @iommu: the IOMMUMemoryRegion
>       */
>      int (*num_indexes)(IOMMUMemoryRegion *iommu);
> +
> +    /*
> +     * Set supported IOMMU page size
> +     *
> +     * If supported, allows to restrict the page size mask that can be supported
To match other docs: Optional method:
> +     * with a given IOMMU memory region. For example, to propagate host physical
> +     * IOMMU page size mask limitations to the virtual IOMMU.
> +     *
> +     * Returns 0 on success, or a negative error. In case of failure, the error
> +     * object must be created.
document args as done for other functions?
> +     */
> +     int (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
> +                                     uint64_t page_size_mask,
> +                                     Error **errp);
>  };
>  
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> @@ -1389,6 +1403,18 @@ int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
>   */
>  int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
>  
> +/**
> + * memory_region_iommu_set_page_size_mask: set the supported page
> + * sizes for a given IOMMU memory region
> + *
> + * @iommu_mr: IOMMU memory region
> + * @page_size_mask: supported page size mask
> + * @errp: pointer to Error*, to store an error if it happens.
> + */
> +int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
> +                                           uint64_t page_size_mask,
> +                                           Error **errp);
> +
>  /**
>   * memory_region_name: get a memory region's name
>   *
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index fa280a19f7f..5c855a02704 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1811,6 +1811,19 @@ static int memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr,
>      return ret;
>  }
>  
> +int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
> +                                           uint64_t page_size_mask,
> +                                           Error **errp)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
> +    int ret = 0;
> +
> +    if (imrc->iommu_set_page_size_mask) {
> +        ret = imrc->iommu_set_page_size_mask(iommu_mr, page_size_mask, errp);
> +    }
> +    return ret;
> +}
> +
>  int memory_region_register_iommu_notifier(MemoryRegion *mr,
>                                            IOMMUNotifier *n, Error **errp)
>  {
> 
Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


