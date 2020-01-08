Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1297EC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D237D20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="k6Eay6q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D237D20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipI9o-0007VJ-Vg
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1ipI8w-0006TA-GZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1ipI8u-0005kQ-SI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:41:30 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1ipI8u-0005i2-II
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:41:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e163e440001>; Wed, 08 Jan 2020 12:40:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 08 Jan 2020 12:41:25 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 08 Jan 2020 12:41:25 -0800
Received: from [10.40.100.122] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 20:41:16 +0000
Subject: Re: [PATCH v10 Kernel 1/5] vfio: KABI for migration interface for
 device state
To: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>
References: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
 <1576527700-21805-2-git-send-email-kwankhede@nvidia.com>
 <20191216154406.023f912b@x1.home>
 <f773a92a-acbd-874d-34ba-36c1e9ffe442@nvidia.com>
 <20191217114357.6496f748@x1.home>
 <3527321f-e310-8324-632c-339b22f15de5@nvidia.com>
 <20191219102706.0a316707@x1.home>
 <928e41b5-c3fd-ed75-abd6-ada05cda91c9@nvidia.com>
 <20191219140929.09fa24da@x1.home> <20200102182537.GK2927@work-vm>
 <20200106161851.07871e28@w520.home>
 <ce132929-64a7-9a5b-81ff-38616202b757@nvidia.com>
 <20200107100923.2f7b5597@w520.home>
 <08b7f953-6ac5-cd79-b1ff-54338da32d1e@nvidia.com>
 <20200107115602.25156c41@w520.home>
 <20200108155955.78e908c1.cohuck@redhat.com>
 <20200108113134.05c08470@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <46ac2d9e-4f4e-27d5-2a96-932c444e3461@nvidia.com>
Date: Thu, 9 Jan 2020 02:11:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108113134.05c08470@w520.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1578516037; bh=vCy0NZGb5fyV6lZNEnyS5+aG41GLJFmnPreZWZr2Ltw=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=k6Eay6q6LTxyG+xCT8+bs+4KMtg+gHQ8r6zofGagt5TKAZG9AV4ZIzc3R+tC9LPLj
 uqA84sjoWd3bkAev67IT9dNEIrzms3u6ZteFHh9PHJuO57oO9SUCPeSSbfjlB7zPfW
 wK3SXF8a4f7iKpzE9xyxXzvKd3gFEFh7+5uzu3PqPNac0KwgQ5Dyd7P5QyCQvCZCbu
 fvWqRnu8j/O5yH9IoKlVUgchPmxBrw5UO/iLc3ha8j79pxIP+EHxLTcMq8mKKJXgI6
 WtVlWnKJ0xsgReQ/GeN7EpE1d2ie/8cXCJ4H8mUHzoZ/bGViDjYbzI2X0lnRyBDz+c
 C9GF4UmE5qqNg==
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, Zhengxiao.zx@alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 yan.y.zhao@intel.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/9/2020 12:01 AM, Alex Williamson wrote:
> On Wed, 8 Jan 2020 15:59:55 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Tue, 7 Jan 2020 11:56:02 -0700
>> Alex Williamson <alex.williamson@redhat.com> wrote:
>>
>>> On Tue, 7 Jan 2020 23:23:17 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>
>>>> There are 3 invalid states:
>>>>    *  101b => Invalid state
>>>>    *  110b => Invalid state
>>>>    *  111b => Invalid state
>>>>
>>>> why only 110b should be used to report error from vendor driver to
>>>> report error? Aren't we adding more confusions in the interface?
>>>
>>> I think the only chance of confusion is poor documentation.  If we
>>> define all of the above as invalid and then say any invalid state
>>> indicates an error condition, then the burden is on the user to
>>> enumerate all the invalid states.  That's not a good idea.  Instead we
>>> could say 101b (_RESUMING|_RUNNING) is reserved, it's not currently
>>> used but it might be useful some day.  Therefore there are no valid
>>> transitions into or out of this state.  A vendor driver should fail a
>>> write(2) attempting to enter this state.
>>>
>>> That leaves 11Xb, where we consider _RESUMING and _SAVING as mutually
>>> exclusive, so neither are likely to ever be valid states.  Logically,
>>> if the device is in a failed state such that it needs to be reset to be
>>> recovered, I would hope the device is not running, so !_RUNNING (110b)
>>> seems appropriate.  I'm not sure we need that level of detail yet
>>> though, so I was actually just assuming both 11Xb states would indicate
>>> an error state and the undefined _RUNNING bit might differentiate
>>> something in the future.
>>>
>>> Therefore, I think we'd have:
>>>
>>>   * 101b => Reserved
>>>   * 11Xb => Error
>>>
>>> Where the device can only self transition into the Error state on a
>>> failed device_state transition and the only exit from the Error state
>>> is via the reset ioctl.  The Reserved state is unreachable.  The vendor
>>> driver must error on device_state writes to enter or exit the Error
>>> state and must error on writes to enter Reserved states.  Is that still
>>> confusing?
>>
>> I think one thing we could do is start to tie the meaning more to the
>> actual state (bit combination) and less to the individual bits. I.e.
>>
>> - bit 0 indicates 'running',
>> - bit 1 indicates 'saving',
>> - bit 2 indicates 'resuming',
>> - bits 3-31 are reserved. [Aside: reserved-and-ignored or
>>    reserved-and-must-be-zero?]
> 
> This version specified them as:
> 
> 	Bits 3 - 31 are reserved for future use. User should perform
> 	read-modify-write operation on this field.
> 
> The intention is that the user should not make any assumptions about
> the state of the reserved bits, but should preserve them when changing
> known bits.  Therefore I think it's ignored but preserved.  If we
> specify them as zero, then I think we lose any chance to define them
> later.
> 
>> [Note that I don't specify what happens when a bit is set or unset.]
>>
>> States are then defined as:
>> 000b => stopped state (not saving or resuming)
>> 001b => running state (not saving or resuming)
>> 010b => stop-and-copy state
>> 011b => pre-copy state
>> 100b => resuming state
>>
>> [Transitions between these states defined, as before.]
>>
>> 101b => reserved [for post-copy; no transitions defined]
>> 111b => reserved [state does not make sense; no transitions defined]
>> 110b => error state [state does not make sense per se, but it does not
>>          indicate running; transitions into this state *are* possible]
>>
>> To a 'reserved' state, we can later assign a different meaning (we
>> could even re-use 111b for a different error state, if needed); while
>> the error state must always stay the error state.
>>
>> We should probably use some kind of feature indication to signify
>> whether a 'reserved' state actually has a meaning. Also, maybe we also
>> should designate the states > 111b as 'reserved'.
>>
>> Does that make sense?
> 
> It seems you have an opinion to restrict this particular error state to
> 110b rather than 11Xb, reserving 111b for some future error condition.
> That's fine and I think we agree that using the state with _RUNNING set
> to zero is more logical as we expect the device to be non-operational
> in this state.
> 
> I'm also thinking more of these as states, but at the same time we're
> not doing away with the bit definitions.  I think the states are much
> easier to decode and use if we think about the function of each bit,
> which leads to the logical incongruity that the 11Xb states are
> impossible and therefore must be error states.
> 

I agree on bit definition is better.

Ok. Should there be a defined value for error, which can be used by 
vendor driver for error state?

#define VFIO_DEVICE_STATE_ERROR			\
		(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RESUMING)

Thanks,
Kirti

> I took a look at drawing a state transitions diagram, but I think we're
> fully interconnected for the 6 states we're defining.  The user can
> invoke transition to any of the 5 states Connie lists above from any of
> those states and the 6th error state is only reached via failed
> transition and only exited via device reset, returning the user to the
> running state.  There are a couple transitions of questionable value,
> particularly 01Xb -> 100b (_SAVING -> _RESUMING), but I can't convince
> myself that it's worthwhile to force the user to pass through another
> state in order to restrict those.  Are there any cases I'm missing
> where the vendor driver has good reason not to support arbitrary
> transitions between the above 5 states?  Thanks,
> 
> Alex
> 

