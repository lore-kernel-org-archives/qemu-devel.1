Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88A7C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D432072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2H0gWZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D432072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLlv-0004q5-Ll
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jGLjp-0003bP-Qs
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jGLjo-0001bn-Ox
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:59:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59349)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jGLjo-0001bI-Ki
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584964764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyjvP9l3FJXSBKAiaO4Zbc3n56DNlUk6OaDVmr68ffo=;
 b=S2H0gWZCboKrpfq2h6vnLhfzRVCVxe0drklPh9w+A5txIcXS3IJswTS5vXH2h1z5Zq6juE
 HorSpey3Vqq/slHm9VHo/0Y2InMQ7BMWM4fq1gR9epVGkS/2TL88qjr+f95kY+SJZODQNc
 XW+CTqmi0bcTrtqVBc+RsqZj7vY8TeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-2Q_PMBJYOjCF6fwLcNmUBA-1; Mon, 23 Mar 2020 07:59:21 -0400
X-MC-Unique: 2Q_PMBJYOjCF6fwLcNmUBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67C9B477;
 Mon, 23 Mar 2020 11:59:19 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AACE7E31F;
 Mon, 23 Mar 2020 11:59:10 +0000 (UTC)
Subject: Re: [PATCH v14 Kernel 2/7] vfio iommu: Remove atomicity of ref_count
 of pinned pages
To: Kirti Wankhede <kwankhede@nvidia.com>, alex.williamson@redhat.com,
 cjia@nvidia.com
References: <1584560474-19946-1-git-send-email-kwankhede@nvidia.com>
 <1584560474-19946-3-git-send-email-kwankhede@nvidia.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e81dda25-33af-9a6b-454c-fe3349142e9b@redhat.com>
Date: Mon, 23 Mar 2020 12:59:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1584560474-19946-3-git-send-email-kwankhede@nvidia.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yan.y.zhao@intel.com, kvm@vger.kernel.org, eskultet@redhat.com,
 ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com,
 felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kirti,

On 3/18/20 8:41 PM, Kirti Wankhede wrote:
> vfio_pfn.ref_count is always updated by holding iommu->lock, using atomic
> variable is overkill.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 9fdfae1cb17a..70aeab921d0f 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -112,7 +112,7 @@ struct vfio_pfn {
>  	struct rb_node		node;
>  	dma_addr_t		iova;		/* Device address */
>  	unsigned long		pfn;		/* Host pfn */
> -	atomic_t		ref_count;
> +	unsigned int		ref_count;
>  };
>  
>  struct vfio_regions {

> @@ -233,7 +233,7 @@ static int vfio_add_to_pfn_list(struct vfio_dma *dma, dma_addr_t iova,
>  
>  	vpfn->iova = iova;
>  	vpfn->pfn = pfn;
> -	atomic_set(&vpfn->ref_count, 1);
> +	vpfn->ref_count = 1;
>  	vfio_link_pfn(dma, vpfn);
>  	return 0;
>  }
> @@ -251,7 +251,7 @@ static struct vfio_pfn *vfio_iova_get_vfio_pfn(struct vfio_dma *dma,
>  	struct vfio_pfn *vpfn = vfio_find_vpfn(dma, iova);
>  
>  	if (vpfn)
> -		atomic_inc(&vpfn->ref_count);
> +		vpfn->ref_count++;
>  	return vpfn;
>  }
>  
> @@ -259,7 +259,8 @@ static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn)
>  {
>  	int ret = 0;
>  
> -	if (atomic_dec_and_test(&vpfn->ref_count)) {
> +	vpfn->ref_count--;
> +	if (!vpfn->ref_count) {
>  		ret = put_pfn(vpfn->pfn, dma->prot);
>  		vfio_remove_from_pfn_list(dma, vpfn);
>  	}
> 

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


