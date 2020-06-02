Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E12BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625AA2067B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC5DA0FC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625AA2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgD0e-000446-Ma
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jgD01-0003Xv-UF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:55:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54423
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jgCzz-0002Lw-WC
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591127697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VCnU65iJzriTQ16ffNx4Cnz5ZN96Q2FzmUgCNdS3hKU=;
 b=PC5DA0FCq6jsBFdOuiBdyxZx7By0dOpNY0qY3J8+EAaSMeQV1yyJ44FjJgHCjsPKibEBcY
 PbtjC7F5V3ViSKFBZCh1Jaf8Oa7JlSu+VEGKoEjS4Jkz6LeAM4FNzX6rAWO0PKTSFNAYM1
 7LaProNCJsB1R2DsAK88tE9mg2QKQyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-JSv_jKh9NHuigJEcvSCsrQ-1; Tue, 02 Jun 2020 15:54:54 -0400
X-MC-Unique: JSv_jKh9NHuigJEcvSCsrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD10C80058E;
 Tue,  2 Jun 2020 19:54:51 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1832110013C3;
 Tue,  2 Jun 2020 19:54:50 +0000 (UTC)
Date: Tue, 2 Jun 2020 13:54:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH 1/2] vfio iommu: Use shift operation for 64-bit integer
 division
Message-ID: <20200602135448.56707f25@x1.home>
In-Reply-To: <1591123357-18297-1-git-send-email-kwankhede@nvidia.com>
References: <1591123357-18297-1-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 15:54:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 00:12:36 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Fixes compilation error with ARCH=i386.
> 
> Error fixed by this commit:
> ld: drivers/vfio/vfio_iommu_type1.o: in function `vfio_dma_populate_bitmap':
> >> vfio_iommu_type1.c:(.text+0x666): undefined reference to `__udivdi3'  
> 
> Fixes: d6a4c185660c (vfio iommu: Implementation of ioctl for dirty pages tracking)
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 97a29bc04d5d..9d9c8709a24c 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -227,11 +227,12 @@ static void vfio_dma_bitmap_free(struct vfio_dma *dma)
>  static void vfio_dma_populate_bitmap(struct vfio_dma *dma, size_t pgsize)
>  {
>  	struct rb_node *p;
> +	unsigned long pgshift = __ffs(pgsize);
>  
>  	for (p = rb_first(&dma->pfn_list); p; p = rb_next(p)) {
>  		struct vfio_pfn *vpfn = rb_entry(p, struct vfio_pfn, node);
>  
> -		bitmap_set(dma->bitmap, (vpfn->iova - dma->iova) / pgsize, 1);
> +		bitmap_set(dma->bitmap, (vpfn->iova - dma->iova) >> pgshift, 1);
>  	}
>  }
>  

Applied and pushed both to the vfio next branch.  Thanks!

Alex


