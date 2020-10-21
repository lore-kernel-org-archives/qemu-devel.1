Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25092C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640FE21D6C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640FE21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVASt-0001R3-BO
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 05:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuzenghui@huawei.com>)
 id 1kVARv-0000ef-Bj
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:30:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5713 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuzenghui@huawei.com>)
 id 1kVARs-000565-An
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:30:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9267EDCBFFAFB47D868B;
 Wed, 21 Oct 2020 17:30:16 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 21 Oct 2020 17:30:06 +0800
Subject: Re: [PATCH v26 03/17] vfio: Add save and load functions for VFIO PCI
 devices
To: Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede
 <kwankhede@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-4-git-send-email-kwankhede@nvidia.com>
 <20200924164905.1a2f1384@x1.home>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <c37eebe4-45d1-ea55-0540-3a2aecea442b@huawei.com>
Date: Wed, 21 Oct 2020 17:30:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200924164905.1a2f1384@x1.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=yuzenghui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 03:34:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, wanghaibin.wang@huawei.com, Ken.Xue@amd.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, quintela@redhat.com, lushenming@huawei.com,
 zhi.a.wang@intel.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/9/25 6:49, Alex Williamson wrote:
>> +    } else if (interrupt_type == VFIO_INT_MSIX) {
>> +        uint16_t offset;
>> +
>> +        msix_load(pdev, f);
>> +        offset = pci_default_read_config(pdev,
>> +                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
>> +        /* load enable bit and maskall bit */
>> +        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
>> +                              offset, 2);

It isn't clear that what purpose this load operation serves.  The config
space has already been restored and we'll see that MSI-X _was_ and _is_
enabled (or disabled).  vfio_msix_enable() will therefore not be invoked
and no vectors would actually be enabled...  Not sure if I had missed
something.

>> +    }
>> +    return 0;
> 
> It seems this could be simplified down to:
> 
> if (msi_enabled(pdev)) {
>      vfio_msi_enable(vdev);
> } else if (msix_enabled(pdev)) {
>      msix_load(pdev, f);
>      vfio_msix_enable(vdev);
> }

And it seems that this has fixed something :-)


Thanks,
Zenghui

