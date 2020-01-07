Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913C1C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 20:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0322072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 20:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AyKN7SE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0322072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iovk9-0008Kt-Ei
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 15:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iovj8-0007T2-Kd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iovj7-0006TE-40
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:45:22 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iovj6-0006R1-SW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:45:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e14edae0001>; Tue, 07 Jan 2020 12:44:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 07 Jan 2020 12:45:18 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 12:45:18 -0800
Received: from [10.40.100.83] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 20:45:06 +0000
Subject: Re: [PATCH v11 Kernel 6/6] vfio: Selective dirty page tracking if
 IOMMU backed device pins pages
To: Alex Williamson <alex.williamson@redhat.com>
References: <1576602651-15430-1-git-send-email-kwankhede@nvidia.com>
 <1576602651-15430-7-git-send-email-kwankhede@nvidia.com>
 <20191217171219.7cc3fc1d@x1.home>
From: Kirti Wankhede <kwankhede@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <66512c1f-aedc-a718-8594-b52d266f4b60@nvidia.com>
Date: Wed, 8 Jan 2020 02:15:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191217171219.7cc3fc1d@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1578429871; bh=Q4Gvd9o6Tj+sg8tf9zs3NS6W1A1YU7OLDBX4lzl56FI=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=AyKN7SE9PsOF7o0skaKsQUREfauRFd04hsdUGFYAHXen2NB8NEFjFSxeMb9Yk0DUw
 ARcLFOAxTaCsTxdEeJoJ+Y6+r2ZtRekofL5HqRMFmwl7zhpmrqnFjpJ0Gw2PbEzSjf
 QPYBz/tCkinR/I/wvF9kJGRoBdslmywYEerJI2b+IrMgeuR7o0lgGi1snMJH7Slfho
 eP0XdJONEt+8Jze3/J12MW1DsRkgJpUyK3PpiI1MT0Qaf7oRYdJjXnNfZdgfvulhXV
 7GozGGiyTRXBDT2rdJb0azsJkWTEh/bMjHHX6pFcxIxkZvi6iZrkC6CyA8iUTGXruK
 Y0lC7cTSBpAqg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.143
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



On 12/18/2019 5:42 AM, Alex Williamson wrote:
> On Tue, 17 Dec 2019 22:40:51 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 

<snip>

> 
> This will fail when there are devices within the IOMMU group that are
> not represented as vfio_devices.  My original suggestion was:
> 
> On Thu, 14 Nov 2019 14:06:25 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
>> I think it does so by pinning pages.  Is it acceptable that if the
>> vendor driver pins any pages, then from that point forward we consider
>> the IOMMU group dirty page scope to be limited to pinned pages?  There
>> are complications around non-singleton IOMMU groups, but I think we're
>> already leaning towards that being a non-worthwhile problem to solve.
>> So if we require that only singleton IOMMU groups can pin pages and we
> 
> We could tag vfio_groups as singleton at vfio_add_group_dev() time with
> an iommu_group_for_each_dev() walk so that we can cache the value on
> the struct vfio_group. 

I don't think iommu_group_for_each_dev() is required. Checking 
group->device_list in vfio_add_group_dev() if there are more than one 
device should work, right?

         list_for_each_entry(vdev, &group->device_list, group_next) {
                 if (group->is_singleton) {
                         group->is_singleton = false;
                         break;
                 } else {
                         group->is_singleton = true;
                 }
         }


> vfio_group_nb_add_dev() could update this if
> the IOMMU group composition changes. 

I don't see vfio_group_nb_add_dev() calls vfio_add_group_dev() (?)
If checking is_singleton is taken care in vfio_group_nb_add_dev(), which 
is the only place where vfio_group is allocated, that should work, I think.


> vfio_pin_pages() could return
> -EINVAL if (!group->is_singleton).
> 
>> pass the IOMMU group as a parameter to
>> vfio_iommu_driver_ops.pin_pages(), then the type1 backend can set a
>> flag on its local vfio_group struct to indicate dirty page scope is
>> limited to pinned pages.
> 
> ie. vfio_iommu_type1_unpin_pages() calls find_iommu_group() on each
> domain in domain_list and the external_domain using the struct
> iommu_group pointer provided by vfio-core.  We set a new attribute on
> the vfio_group to indicate that vfio_group has (at some point) pinned
> pages.
> 
>>   We might want to keep a flag on the
>> vfio_iommu struct to indicate if all of the vfio_groups for each
>> vfio_domain in the vfio_iommu.domain_list dirty page scope limited to
>> pinned pages as an optimization to avoid walking lists too often.  Then
>> we could test if vfio_iommu.domain_list is not empty and this new flag
>> does not limit the dirty page scope, then everything within each
>> vfio_dma is considered dirty.
> 
> So at the point where we change vfio_group.has_pinned_pages from false
> to true, or a group is added or removed, we walk all the groups in the
> vfio_iommu and if they all have has_pinned_pages set, we can set a
> vfio_iommu.pinned_page_dirty_scope flag to true.  If that flag is
> already true on page pinning, we can skip the lookup.
> 
> I still like this approach better, it doesn't require a callback from
> type1 to vfio-core and it doesn't require a heavy weight walking for
> group devices and vfio data structures every time we fill a bitmap.
> Did you run into issues trying to implement this approach? 

Thanks for elaborative steps.
This works. Changing this last commit.

Thanks,
Kirti


