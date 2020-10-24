Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4707C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDC022276
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EKJFTcg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDC022276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWQ5J-0000PN-6E
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWQ43-0008Lp-J8
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:22:59 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWQ41-0003Kj-DS
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:22:59 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f948d240001>; Sat, 24 Oct 2020 13:23:00 -0700
Received: from [10.40.102.184] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 24 Oct
 2020 20:22:36 +0000
Subject: Re: [PATCH v28 04/17] vfio: Add migration region initialization and
 finalize function
To: Cornelia Huck <cohuck@redhat.com>
References: <1603449643-12851-1-git-send-email-kwankhede@nvidia.com>
 <1603449643-12851-5-git-send-email-kwankhede@nvidia.com>
 <20201023132417.3b4fc1a4.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <f7267e80-32b4-a1d9-5d09-dd596b1d773d@nvidia.com>
Date: Sun, 25 Oct 2020 01:52:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201023132417.3b4fc1a4.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603570980; bh=tLHmUfWWa01yiBzOufoKSO34CAcDVhA1aGsX9Bw3Z2A=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=EKJFTcg/v5iqCRbtMOVcVd6wDTSMoS9nfmM0U5sqIRK9HrrfbU5z3adnlOfofU9k+
 79U0bNWQIi+ulxtj2mNZ2Hk/7tqv77m7EFk5i5pbQhFJ3cGyYjNOcOQV97tTr24Smh
 sZIniA/7uXyHpdTgQEaT6pBGiTHlcXelVBtMiTdj8SV4bO949mC+1CIHlNK8zo4PYB
 Z0JBpz3PLFkQz2AFwbeb1aOTVMhWmJEpKicOBSDeURoNKG6ovOlZx3XEzGp7nbzgZf
 ZhtwrrrZo9JMMLQDkAOfPdS9A81jw9isb2fogE1m1dWhdwdNKb26fkmd8ODZToyTMP
 TFaFm1FHunkMg==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 16:22:55
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com,
 dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/23/2020 4:54 PM, Cornelia Huck wrote:
> On Fri, 23 Oct 2020 16:10:30 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Whether the VFIO device supports migration or not is decided based of
>> migration region query. If migration region query is successful and migration
>> region initialization is successful then migration is supported else
>> migration is blocked.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/vfio/meson.build           |   1 +
>>   hw/vfio/migration.c           | 133 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events          |   3 +
>>   include/hw/vfio/vfio-common.h |   9 +++
>>   4 files changed, 146 insertions(+)
>>   create mode 100644 hw/vfio/migration.c
> 
> (...)
> 
>> +static int vfio_migration_init(VFIODevice *vbasedev,
>> +                               struct vfio_region_info *info)
>> +{
>> +    int ret;
>> +    Object *obj;
>> +    VFIOMigration *migration;
>> +
>> +    if (!vbasedev->ops->vfio_get_object) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>> +    if (!obj) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    migration = g_new0(VFIOMigration, 1);
>> +
>> +    ret = vfio_region_setup(obj, vbasedev, &migration->region,
>> +                            info->index, "migration");
>> +    if (ret) {
>> +        error_report("%s: Failed to setup VFIO migration region %d: %s",
>> +                     vbasedev->name, info->index, strerror(-ret));
>> +        goto err;
>> +    }
>> +
>> +    vbasedev->migration = migration;
>> +
>> +    if (!migration->region.size) {
>> +        error_report("%s: Invalid zero-sized of VFIO migration region %d",
> 
> s/of //
> 
>> +                     vbasedev->name, info->index);
>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
>> +    return 0;
>> +
>> +err:
>> +    vfio_migration_region_exit(vbasedev);
>> +    g_free(migration);
>> +    vbasedev->migration = NULL;
>> +    return ret;
>> +}
> 
> (...)
> 
>> +void vfio_migration_finalize(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
> 
> I don't think you need this variable?
> 

Removing it.

>> +
>> +    if (migration) {
>> +        vfio_migration_region_exit(vbasedev);
>> +        g_free(vbasedev->migration);
>> +        vbasedev->migration = NULL;
>> +    }
>> +
>> +    if (vbasedev->migration_blocker) {
>> +        migrate_del_blocker(vbasedev->migration_blocker);
>> +        error_free(vbasedev->migration_blocker);
>> +        vbasedev->migration_blocker = NULL;
>> +    }
>> +}
> 
> (...)
> 

