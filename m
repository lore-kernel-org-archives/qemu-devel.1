Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B54AC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 17:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF0E22254
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 17:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="c+pR2bEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF0E22254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUCks-0005Vq-IE
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 13:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUCiz-0004AB-Cl
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 13:44:05 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUCiu-0007fo-R0
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 13:44:05 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8c7e830000>; Sun, 18 Oct 2020 10:42:27 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 18 Oct
 2020 17:43:43 +0000
Subject: Re: [PATCH v26 05/17] vfio: Add VM state change handler to know state
 of VM
To: Alex Williamson <alex.williamson@redhat.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-6-git-send-email-kwankhede@nvidia.com>
 <20200925142023.54e2c7c0@x1.home>
 <0fd89808-74b2-49de-da79-ea034d83a5de@nvidia.com>
 <20201017174437.2fb6b699@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <c33278af-ab58-5786-9b70-d4f82b75cf96@nvidia.com>
Date: Sun, 18 Oct 2020 23:13:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201017174437.2fb6b699@x1.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603042947; bh=DcfF6YdomyXTrgGIjNri07Wk9CpY9REQJMtXL4P8v5g=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=c+pR2bEVvyXhndGBBF41tSkZJBDXsi2zxVnLvR5+hb/gCkhLDUmFJ/6r/YVZ7Dduo
 /w0730tVFCaIBDGo3wMEIrSL3wRkTOLXrVOFBNalLuM0GWaQvU8RwblikVR3pcy/5u
 1jUYCzgqWJjSOvEiI50nX8Y+Q5ZKcrE/tHBqJ5lztjgSRo/L8XIlMfK7afqBZ/N67g
 MJysQzISJOhkgUMFAEzgFqoGsDJRJl/eptfZsIR7oI2JOcnfAFHAnOQJwRDVfIvUm2
 lxuQScvw5rOYIsvVg3/bbqEhMALtAkrPonlcAGzxEesAzUcwb3OxOH2yC7bLtjuTle
 gUwLJo6EM/UBg==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 13:43:59
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

<snip>

>>>> +vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
>>>> +vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index 8275c4c68f45..25e3b1a3b90a 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -29,6 +29,7 @@
>>>>    #ifdef CONFIG_LINUX
>>>>    #include <linux/vfio.h>
>>>>    #endif
>>>> +#include "sysemu/sysemu.h"
>>>>    
>>>>    #define VFIO_MSG_PREFIX "vfio %s: "
>>>>    
>>>> @@ -119,6 +120,9 @@ typedef struct VFIODevice {
>>>>        unsigned int flags;
>>>>        VFIOMigration *migration;
>>>>        Error *migration_blocker;
>>>> +    VMChangeStateEntry *vm_state;
>>>> +    uint32_t device_state;
>>>> +    int vm_running;
>>>
>>> Could these be placed in VFIOMigration?  Thanks,
>>>   
>>
>> I think device_state should be part of VFIODevice since its about device
>> rather than only related to migration, others can be moved to VFIOMigration.
> 
> But these are only valid when migration is supported and thus when
> VFIOMigration exists.  Thanks,
> 

Even though it is used when migration is supported, its device's attribute.

Thanks,
Kirti


