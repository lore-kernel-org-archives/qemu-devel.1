Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0853FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344FF2076E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344FF2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxh8-000462-8O
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lushenming@huawei.com>)
 id 1kZtkS-00040h-Ct
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:41:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:2126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lushenming@huawei.com>)
 id 1kZtkL-0006cW-E3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:41:07 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQRC16w3xz6xH3;
 Tue,  3 Nov 2020 18:40:45 +0800 (CST)
Received: from [10.174.187.195] (10.174.187.195) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 18:40:38 +0800
To: Alex Williamson <alex.williamson@redhat.com>, "Kirti Wankhede,"
 <kwankhede@nvidia.com>
From: Shenming Lu <lushenming@huawei.com>
Subject: Re: [PATCH v25 03/17] vfio: Add save and load functions for VFIO PCI
 devices
Message-ID: <2b3878a1-1241-beba-20ce-837601413e0c@huawei.com>
Date: Tue, 3 Nov 2020 18:40:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.195]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=lushenming@huawei.com;
 helo=szxga07-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:32:14
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Nov 2020 09:38:50 -0500
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
 felipe@nutanix.com, yuzenghui@huawei.com, wanghaibin.wang@huawei.com,
 Ken.Xue@amd.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, quintela@redhat.com,
 lushenming@huawei.com, zhi.a.wang@intel.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/2020 1:58 AM, Alex Williamson wrote:
>> +    } else if (interrupt_type == VFIO_INT_MSIX) {
>> +        uint16_t offset;
>> +
>> +        offset = pci_default_read_config(pdev,
>> +                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
>> +        /* load enable bit and maskall bit */
>> +        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
>> +                              offset, 2);
>> +        msix_load(pdev, f);
>
> Isn't this ordering backwards, or at least less efficient?  The config
> write will cause us to enable MSI-X; presumably we'd have nothing in
> the vector table though.  Then msix_load() will write the vector
> and pba tables and trigger a use notifier for each vector.  It seems
> like that would trigger a bunch of SET_IRQS ioctls as if the guest
> wrote individual unmasked vectors to the vector table, whereas if we
> setup the vector table and then enable MSI-X, we do it with one ioctl.
>

As you said, it's better to call msix_load() first (only restore the vector
and pba tables), and then enable MSI-X, where we will trigger the use notifier
for all unmasked vectors and make only one ioctl (in msix_set_vector_notifiers()?).
But what I see is that we will still do_use these vectors one by one in
msix_set_vector_notifiers() and trigger a bunch of SET_IRQS ioctls...
Not sure if I have missed something.

Thanks,
Shenming

