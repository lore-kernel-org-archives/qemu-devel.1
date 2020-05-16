Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAF7C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 19:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C5120709
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 19:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C5120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja2BO-0001FP-P2
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 15:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1ja2Ah-0000cC-W3
 for qemu-devel@nongnu.org; Sat, 16 May 2020 15:08:32 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1ja2Ag-0003tr-1C
 for qemu-devel@nongnu.org; Sat, 16 May 2020 15:08:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ec03a1f0000>; Sat, 16 May 2020 12:08:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sat, 16 May 2020 12:08:27 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sat, 16 May 2020 12:08:27 -0700
Received: from [10.40.103.94] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 16 May
 2020 19:08:19 +0000
Subject: Re: [PATCH Kernel v21 5/8] vfio iommu: Implementation of ioctl for
 dirty pages tracking
To: Alex Williamson <alex.williamson@redhat.com>
References: <1589577203-20640-1-git-send-email-kwankhede@nvidia.com>
 <1589577203-20640-6-git-send-email-kwankhede@nvidia.com>
 <20200515163307.72951dd2@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <a8fdd629-d49d-d333-0711-0d8d742d9b47@nvidia.com>
Date: Sun, 17 May 2020 00:38:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200515163307.72951dd2@w520.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 15:08:28
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1589656095; bh=+tZ0dBYIJDY6PHAfvMYygljkbJgDRKM2mXYJTiJ5LAU=;
	h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
	 Content-Transfer-Encoding;
	b=AIbO+yRdmNHn4LV2XE0br8vquXdgTLtrWscElXmWTZiSzrFeRqlATyPGsHleQF3QU
	 nBcXsRa9tsbQOwgPkyh0nhMBzcV+q6CoKMw4c3CmRhkSXWG6XnQepdpEF4WDC5VJ1j
	 /kxVKDvmS/WIGEMLowaG/lra0BpLqY9FQLPkCc2up9t94NJ15nHzMx+poYTeVeomWq
	 x3b9j+KGJesMojeYHF4p02v5kpaquce7dYmP7FjlUMTdEZTgbB46FMu/GynDs3ZPLp
	 5Jj51SmTeTP/0NR8+K7XjbAFdNc/ux1RzpNITw6FFJ7kmcIImwoKGPat0qKhpN2P6u
	 J2ThfIZtvw0wg==


On 5/16/2020 4:03 AM, Alex Williamson wrote:
> On Sat, 16 May 2020 02:43:20 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 

<snip>

>> +static int vfio_iova_dirty_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
>> +				  dma_addr_t iova, size_t size, size_t pgsize)
>> +{
>> +	struct vfio_dma *dma;
>> +	unsigned long pgshift = __ffs(pgsize);
>> +	int ret;
>> +
>> +	/*
>> +	 * GET_BITMAP request must fully cover vfio_dma mappings.  Multiple
>> +	 * vfio_dma mappings may be clubbed by specifying large ranges, but
>> +	 * there must not be any previous mappings bisected by the range.
>> +	 * An error will be returned if these conditions are not met.
>> +	 */
>> +	dma = vfio_find_dma(iommu, iova, 1);
>> +	if (dma && dma->iova != iova)
>> +		return -EINVAL;
>> +
>> +	dma = vfio_find_dma(iommu, iova + size - 1, 0);
>> +	if (dma && dma->iova + dma->size != iova + size)
>> +		return -EINVAL;
>> +
>> +	dma = vfio_find_dma(iommu, iova, size);
>> +
>> +	while (dma && (dma->iova >= iova) &&
>> +		(dma->iova + dma->size <= iova + size)) {
> 
> Thanks for doing this!  Unfortunately I think I've mislead you :(
> But I think there was a bug here in the last version as well, so maybe
> it's all for the better ;)
> 
> vfio_find_dma() does not guarantee to find the first dma in the range
> (ie. the lowest iova), it only guarantees to find a dma in the range.
> Since we have a tree structure, as we descend the nodes we might find
> multiple nodes within the range.  vfio_find_dma() only returns the first
> occurrence it finds, so we can't assume that other matching nodes are
> next in the tree or that their iovas are greater than the iova of the
> node we found.
> 
> All the other use cases of vfio_find_dma() are looking for specific
> pages or boundaries or checking for the existence of a conflict or are
> removing all of the instances within the range, which is probably the
> example that was used in the v20 version of this patch, since it was
> quite similar to vfio_dma_do_unmap() but tried to adjust the size to
> get the next match rather than removing the entry.  That could
> potentially lead to an entire unexplored half of the tree making our
> bitmap incomplete.
> 
> So I think my initial suggestion[1] on the previous version is probably
> the way we should go.  Sorry!  OTOH, it would have been a nasty bug to
> find later, it's a subtle semantic that's easy to overlook.  Thanks,
> 
> Alex
> 
> [1]https://lore.kernel.org/kvm/20200514212720.479cc3ba@x1.home/
> 

Ok. Got your point.

Replacing
	dma = vfio_find_dma(iommu, iova, size);

with below should work

for (n = rb_first(&iommu->dma_list); n; n = rb_next(n)) {
         struct vfio_dma *ldma = rb_entry(n, struct vfio_dma, node);

         if (ldma->iova >= iova)
                 break;
}

dma = n ? rb_entry(n, struct vfio_dma, node) : NULL;

Should I update all patches with v22 version? or Is it fine to update 
this patch with v21 only?

Thanks,
Kirti


