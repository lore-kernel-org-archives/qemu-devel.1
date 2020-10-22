Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1135C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E267C2463D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PYvMe+d9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E267C2463D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVclC-0000DW-U7
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 11:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVckK-0008G2-1B
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:43:20 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVckH-0006wg-Sm
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:43:19 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f91a8620000>; Thu, 22 Oct 2020 08:42:26 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Oct
 2020 15:43:01 +0000
Subject: Re: [PATCH v26 05/17] vfio: Add VM state change handler to know state
 of VM
To: Cornelia Huck <cohuck@redhat.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-6-git-send-email-kwankhede@nvidia.com>
 <20200924170220.0a9836fe.cohuck@redhat.com> <20200929110312.GF2826@work-vm>
 <3dd3fe95-c81a-de40-47b0-24f0772974d4@nvidia.com>
 <20201020125105.5cd790df.cohuck@redhat.com>
 <245abdf6-245d-5f88-e04b-35fad763560c@nvidia.com>
 <20201022095125.60319084.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <39a59eb5-9a22-4f66-531c-489de9ecdf52@nvidia.com>
Date: Thu, 22 Oct 2020 21:12:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201022095125.60319084.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603381346; bh=j8d/zw4m+TNs00Ybmo0Od/k2sGyk0o6ZBoXIKA8gZIk=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=PYvMe+d9WzVGGSQnb+XQqiZpgWwTPYPbaPX+WSF6A/wtf6H5P6QC4uojrT3WHojkk
 j/vPlNX5hpqdWPm7cmjMUDwu8DdcXWBjyCS4TTC05ot4jTkyW+v5tyq/a9iQL1ngwn
 M1tDN5k9yjO7KB+XnAXndkTpYRwL89CjBhq6Ph7XQhs9BsXJQwA/+jGp0eqyyr8ygA
 aarYgp9IYFmcMNgdsSJATk9qdTPIo4OWr6km7dUEl5i8hba3RvmbNEE8Ctv76rGAx1
 IJVt7ky3289BLbcVFUTydf8rhrCyDtL817GTMmRR0EcouNcH/i20L/kzD6CSZ00Vtq
 XTluLZzx9sRmg==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 11:43:14
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, alex.williamson@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/22/2020 1:21 PM, Cornelia Huck wrote:
> On Wed, 21 Oct 2020 11:03:23 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 10/20/2020 4:21 PM, Cornelia Huck wrote:
>>> On Sun, 18 Oct 2020 01:54:56 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>    
>>>> On 9/29/2020 4:33 PM, Dr. David Alan Gilbert wrote:
>>>>> * Cornelia Huck (cohuck@redhat.com) wrote:
>>>>>> On Wed, 23 Sep 2020 04:54:07 +0530
>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>>>>>>> +static void vfio_vmstate_change(void *opaque, int running, RunState state)
>>>>>>> +{
>>>>>>> +    VFIODevice *vbasedev = opaque;
>>>>>>> +
>>>>>>> +    if ((vbasedev->vm_running != running)) {
>>>>>>> +        int ret;
>>>>>>> +        uint32_t value = 0, mask = 0;
>>>>>>> +
>>>>>>> +        if (running) {
>>>>>>> +            value = VFIO_DEVICE_STATE_RUNNING;
>>>>>>> +            if (vbasedev->device_state & VFIO_DEVICE_STATE_RESUMING) {
>>>>>>> +                mask = ~VFIO_DEVICE_STATE_RESUMING;
>>>>>>
>>>>>> I've been staring at this for some time and I think that the desired
>>>>>> result is
>>>>>> - set _RUNNING
>>>>>> - if _RESUMING was set, clear it, but leave the other bits intact
>>>>
>>>> Upto here, you're correct.
>>>>   
>>>>>> - if _RESUMING was not set, clear everything previously set
>>>>>> This would really benefit from a comment (or am I the only one
>>>>>> struggling here?)
>>>>>>      
>>>>
>>>> Here mask should be ~0. Correcting it.
>>>
>>> Hm, now I'm confused. With value == _RUNNING, ~_RUNNING and ~0 as mask
>>> should be equivalent, shouldn't they?
>>>    
>>
>> I too got confused after reading your comment.
>> Lets walk through the device states and transitions can happen here:
>>
>> if running
>>    - device state could be either _SAVING or _RESUMING or _STOP. Both
>> _SAVING and _RESUMING can't be set at a time, that is the error state.
>> _STOP means 0.
>>    - Transition from _SAVING to _RUNNING can happen if there is migration
>> failure, in that case we have to clear _SAVING
>> - Transition from _RESUMING to _RUNNING can happen on resuming and we
>> have to clear _RESUMING.
>> - In both the above cases, we have to set _RUNNING and clear rest 2 bits.
>> Then:
>> mask = ~VFIO_DEVICE_STATE_MASK;
>> value = VFIO_DEVICE_STATE_RUNNING;
> 
> ok
> 
>>
>> if !running
>> - device state could be either _RUNNING or _SAVING|_RUNNING. Here we
>> have to reset running bit.
>> Then:
>> mask = ~VFIO_DEVICE_STATE_RUNNING;
>> value = 0;
> 
> ok
> 
>>
>> I'll add comment in the code above.
> 
> That will help.
> 
> I'm a bit worried though that all that reasoning which flags are set or
> cleared when is quite complex, and it's easy to make mistakes.
> 
> Can we model this as a FSM, where an event (running state changes)
> transitions the device state from one state to another? I (personally)
> find FSMs easier to comprehend, but I'm not sure whether that change
> would be too invasive. If others can parse the state changes with that
> mask/value interface, I won't object to it.
> 

I agree FSM will be easy and for long term may be easy to maintain. But 
at this moment it will be intrusive change. For now we can go ahead with 
this code and later we can change to FSM model, if all agrees on it.

Thanks,
Kirti


>>
>>
>>>>
>>>>   
>>>>>>> +            }
>>>>>>> +        } else {
>>>>>>> +            mask = ~VFIO_DEVICE_STATE_RUNNING;
>>>>>>> +        }
> 

