Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B864C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 07:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D154820748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 07:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="l/bbfoV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D154820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbfLk-0002rJ-2a
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 03:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbfLC-0002NW-G1
 for qemu-devel@nongnu.org; Thu, 21 May 2020 03:10:06 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbfLA-00081S-N2
 for qemu-devel@nongnu.org; Thu, 21 May 2020 03:10:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ec6293e0002>; Thu, 21 May 2020 00:09:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 21 May 2020 00:10:02 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 21 May 2020 00:10:02 -0700
Received: from [10.40.103.233] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 May
 2020 07:09:53 +0000
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
To: Yan Zhao <yan.y.zhao@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home> <20200520025500.GA10369@joy-OptiPlex-7040>
 <97977ede-3c5b-c5a5-7858-7eecd7dd531c@nvidia.com>
 <20200520104612.03a32977@w520.home>
 <20200521050846.GC10369@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <d8b40fed-5f54-31ac-0b7c-e2ae74a0ad19@nvidia.com>
Date: Thu, 21 May 2020 12:39:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521050846.GC10369@joy-OptiPlex-7040>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1590044990; bh=VTiS02EYYni68rR9NU0+vdz2D4dkf+0GDnLnrPiq+ME=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=l/bbfoV9yySFjoD9dUxGw8hsF4Mg8lz3z7H/q+x+Cjm3p/LkNlZU23B8seg6HkVyR
 zlJ41KCFJvCRbU/KMjndtiI18o2JFSfAxljilRaxZMuBPaNtbZYyb5gmk7Xe1zBM6K
 dvM1+CJPUKlfiDk51q00MTbq3Ph0xnrlayuDYLes0qEzH06KpPKJDrw9iNNWEqivFf
 IkkXLgxgaEv8FS6HJGeE/reqa2fB53dWZ4JD3qWYLCZ7JUkYtS2aPWnTBCmz6GvG5N
 XtNUzgh3Hkg+rSBYIyOv0RjcFGxHAeGh7P4e2zUjINrblYqVcgTZ64Mjes2rwiHeLA
 IyH6nd1tXcpVQ==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 03:10:03
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/21/2020 10:38 AM, Yan Zhao wrote:
> On Wed, May 20, 2020 at 10:46:12AM -0600, Alex Williamson wrote:
>> On Wed, 20 May 2020 19:10:07 +0530
>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>
>>> On 5/20/2020 8:25 AM, Yan Zhao wrote:
>>>> On Tue, May 19, 2020 at 10:58:04AM -0600, Alex Williamson wrote:
>>>>> Hi folks,
>>>>>
>>>>> My impression is that we're getting pretty close to a workable
>>>>> implementation here with v22 plus respins of patches 5, 6, and 8.  We
>>>>> also have a matching QEMU series and a proposal for a new i40e
>>>>> consumer, as well as I assume GVT-g updates happening internally at
>>>>> Intel.  I expect all of the latter needs further review and discussion,
>>>>> but we should be at the point where we can validate these proposed
>>>>> kernel interfaces.  Therefore I'd like to make a call for reviews so
>>>>> that we can get this wrapped up for the v5.8 merge window.  I know
>>>>> Connie has some outstanding documentation comments and I'd like to make
>>>>> sure everyone has an opportunity to check that their comments have been
>>>>> addressed and we don't discover any new blocking issues.  Please send
>>>>> your Acked-by/Reviewed-by/Tested-by tags if you're satisfied with this
>>>>> interface and implementation.  Thanks!
>>>>>   
>>>> hi Alex and Kirti,
>>>> after porting to qemu v22 and kernel v22, it is found out that
>>>> it can not even pass basic live migration test with error like
>>>>
>>>> "Failed to get dirty bitmap for iova: 0xca000 size: 0x3000 err: 22"
>>>>    
>>>
>>> Thanks for testing Yan.
>>> I think last moment change in below cause this failure
>>>
>>> https://lore.kernel.org/kvm/1589871178-8282-1-git-send-email-kwankhede@nvidia.com/
>>>
>>>   > 	if (dma->iova > iova + size)
>>>   > 		break;
>>>
>>> Surprisingly with my basic testing with 2G sys mem QEMU didn't raise
>>> abort on g_free, but I do hit this with large sys mem.
>>> With above change, that function iterated through next vfio_dma as well.
>>> Check should be as below:
>>>
>>> -               if (dma->iova > iova + size)
>>> +               if (dma->iova > iova + size -1)
>>
>>
>> Or just:
>>
>> 	if (dma->iova >= iova + size)
>>
>> Thanks,
>> Alex
>>
>>
>>>                           break;
>>>
>>> Another fix is in QEMU.
>>> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04751.html
>>>
>>>   > > +        range->bitmap.size = ROUND_UP(pages, 64) / 8;
>>>   >
>>>   > ROUND_UP(npages/8, sizeof(u64))?
>>>   >
>>>
>>> If npages < 8, npages/8 is 0 and ROUND_UP(0, 8) returns 0.
>>>
>>> Changing it as below
>>>
>>> -        range->bitmap.size = ROUND_UP(pages / 8, sizeof(uint64_t));
>>> +        range->bitmap.size = ROUND_UP(pages, sizeof(__u64) *
>>> BITS_PER_BYTE) /
>>> +                             BITS_PER_BYTE;
>>>
>>> I'm updating patches with these fixes and Cornelia's suggestion soon.
>>>
>>> Due to short of time I may not be able to address all the concerns
>>> raised on previous versions of QEMU, I'm trying make QEMU side code
>>> available for testing for others with latest kernel changes. Don't
>>> worry, I will revisit comments on QEMU patches. Right now first priority
>>> is to test kernel UAPI and prepare kernel patches for 5.8
>>>
>>
> hi Kirti
> by updating kernel/qemu to v23, still met below two types of errors.
> just basic migration test.
> (the guest VM size is 2G for all reported bugs).
> 
> "Failed to get dirty bitmap for iova: 0xfe011000 size: 0x3fb0 err: 22"
> 

size doesn't look correct here, below check should be failing.
  range.size & (iommu_pgsize - 1)

> or
> 
> "qemu-system-x86_64-lm: vfio_load_state: Error allocating buffer
> qemu-system-x86_64-lm: error while loading state section id 49(vfio)
> qemu-system-x86_64-lm: load of migration failed: Cannot allocate memory"
> 
> 

Above error is from:
         buf = g_try_malloc0(data_size);
         if (!buf) {
             error_report("%s: Error allocating buffer ", __func__);
             return -ENOMEM;
         }

Seems you are running out of memory?

Thanks,
Kirti

