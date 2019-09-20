Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998DFC3A5A6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 01:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D44214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 01:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D44214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB7cw-0000dw-Jo
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 21:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iB7Zt-000594-TV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 21:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iB7Wa-0003Xk-SV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 21:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iB7Wa-0003XS-KV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 21:15:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 71EA318C4270;
 Fri, 20 Sep 2019 01:15:51 +0000 (UTC)
Received: from [10.72.12.88] (ovpn-12-88.pek2.redhat.com [10.72.12.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34C685D6B0;
 Fri, 20 Sep 2019 01:15:41 +0000 (UTC)
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D57B1D1@SHSMSX104.ccr.corp.intel.com>
 <6d73572e-1e89-b04a-bdd6-98ac73798083@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B90C@SHSMSX104.ccr.corp.intel.com>
 <204219fa-ee72-ca60-52a4-fb4bbc887773@redhat.com>
 <20190919052819.GA18391@joy-OptiPlex-7040>
 <7b6d6343-33de-ebd7-9846-af54a45a82a2@redhat.com>
 <20190919061756.GB18391@joy-OptiPlex-7040>
 <e0efbdc0-aad9-0d17-ec68-36460865501f@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57DD2A@SHSMSX104.ccr.corp.intel.com>
 <7906030a-00e3-012d-da4f-bb0c1b2901b2@redhat.com>
 <20190919100545-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1373899c-4cbc-cd23-512b-2994e6b26a27@redhat.com>
Date: Fri, 20 Sep 2019 09:15:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919100545-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 20 Sep 2019 01:15:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 'Alex Williamson' <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/9/19 =E4=B8=8B=E5=8D=8810:06, Michael S. Tsirkin wrote:
> On Thu, Sep 19, 2019 at 05:37:48PM +0800, Jason Wang wrote:
>> On 2019/9/19 =E4=B8=8B=E5=8D=883:16, Tian, Kevin wrote:
>>> +Paolo to help clarify here.
>>>
>>>> From: Jason Wang [mailto:jasowang@redhat.com]
>>>> Sent: Thursday, September 19, 2019 2:32 PM
>>>>
>>>>
>>>> On 2019/9/19 =E4=B8=8B=E5=8D=882:17, Yan Zhao wrote:
>>>>> On Thu, Sep 19, 2019 at 02:09:53PM +0800, Jason Wang wrote:
>>>>>> On 2019/9/19 =E4=B8=8B=E5=8D=881:28, Yan Zhao wrote:
>>>>>>> On Thu, Sep 19, 2019 at 09:05:12AM +0800, Jason Wang wrote:
>>>>>>>> On 2019/9/18 =E4=B8=8B=E5=8D=884:37, Tian, Kevin wrote:
>>>>>>>>>> From: Jason Wang [mailto:jasowang@redhat.com]
>>>>>>>>>> Sent: Wednesday, September 18, 2019 2:10 PM
>>>>>>>>>>
>>>>>>>>>>>> Note that the HVA to GPA mapping is not an 1:1 mapping. One
>>>> HVA
>>>>>>>>>> range
>>>>>>>>>>>> could be mapped to several GPA ranges.
>>>>>>>>>>> This is fine. Currently vfio_dma maintains IOVA->HVA mapping.
>>>>>>>>>>>
>>>>>>>>>>> btw under what condition HVA->GPA is not 1:1 mapping? I didn'=
t
>>>> realize it.
>>>>>>>>>> I don't remember the details e.g memory region alias? And neit=
her
>>>> kvm
>>>>>>>>>> nor kvm API does forbid this if my memory is correct.
>>>>>>>>>>
>>>>>>>>> I checked https://qemu.weilnetz.de/doc/devel/memory.html, which
>>>>>>>>> provides an example of aliased layout. However, its aliasing is=
 all
>>>>>>>>> 1:1, instead of N:1. From guest p.o.v every writable GPA implie=
s an
>>>>>>>>> unique location. Why would we hit the situation where multiple
>>>>>>>>> write-able GPAs are mapped to the same HVA (i.e. same physical
>>>>>>>>> memory location)?
>>>>>>>> I don't know, just want to say current API does not forbid this.=
 So we
>>>>>>>> probably need to take care it.
>>>>>>>>
>>>>>>> yes, in KVM API level, it does not forbid two slots to have the s=
ame
>>>> HVA(slot->userspace_addr).
>>>>>>> But
>>>>>>> (1) there's only one kvm instance for each vm for each qemu proce=
ss.
>>>>>>> (2) all ramblock->host (corresponds to HVA and slot->userspace_ad=
dr)
>>>> in one qemu
>>>>>>> process is non-overlapping as it's obtained from mmmap().
>>>>>>> (3) qemu ensures two kvm slots will not point to the same section=
 of
>>>> one ramblock.
>>>>>>> So, as long as kvm instance is not shared in two processes, and
>>>>>>> there's no bug in qemu, we can assure that HVA to GPA is 1:1.
>>>>>> Well, you leave this API for userspace, so you can't assume qemu i=
s the
>>>>>> only user or any its behavior. If you had you should limit it in t=
he API
>>>>>> level instead of open window for them.
>>>>>>
>>>>>>
>>>>>>> But even if there are two processes operating on the same kvm
>>>> instance
>>>>>>> and manipulating on memory slots, adding an extra GPA along side
>>>> current
>>>>>>> IOVA & HVA to ioctl VFIO_IOMMU_MAP_DMA can still let driver knows
>>>> the
>>>>>>> right IOVA->GPA mapping, right?
>>>>>> It looks fragile. Consider HVA was mapped to both GPA1 and GPA2.
>>>> Guest
>>>>>> maps IOVA to GPA2, so we have IOVA GPA2 HVA in the new ioctl and
>>>> then
>>>>>> log through GPA2. If userspace is trying to sync through GPA1, it =
will
>>>>>> miss the dirty page. So for safety we need log both GPA1 and GPA2.=
 (See
>>>>>> what has been done in log_write_hva() in vhost.c). The only way to=
 do
>>>>>> that is to maintain an independent HVA to GPA mapping like what KV=
M
>>>> or
>>>>>> vhost did.
>>>>>>
>>>>> why GPA1 and GPA2 should be both dirty?
>>>>> even they have the same HVA due to overlaping virtual address space=
 in
>>>>> two processes, they still correspond to two physical pages.
>>>>> don't get what's your meaning :)
>>>> The point is not leave any corner case that is hard to debug or fix =
in
>>>> the future.
>>>>
>>>> Let's just start by a single process, the API allows userspace to ma=
ps
>>>> HVA to both GPA1 and GPA2. Since it knows GPA1 and GPA2 are equivale=
nt,
>>>> it's ok to sync just through GPA1. That means if you only log GPA2, =
it
>>>> won't work.
>>>>
>>> I noted KVM itself doesn't consider such situation (one HVA is mapped
>>> to multiple GPAs), when doing its dirty page tracking. If you look at
>>> kvm_vcpu_mark_page_dirty, it simply finds the unique memslot which
>>> contains the dirty gfn and then set the dirty bit within that slot. I=
t
>>> doesn't attempt to walk all memslots to find out any other GPA which
>>> may be mapped to the same HVA.
>>>
>>> So there must be some disconnect here. let's hear from Paolo first an=
d
>>> understand the rationale behind such situation.
>>
>> Neither did vhost when IOTLB is disabled. And cc Michael who points ou=
t this
>> issue at the beginning.
>>
>> Thanks
>>
>>
>>> Thanks
>>> Kevin
> Yes, we fixed with a kind of a work around, at the time I proposed
> a new interace to fix it fully. I don't think we ever got around
> to implementing it - right?


Paolo said userspace just need to sync through all GPAs, so my=20
understanding is that work around is ok by redundant, so did the API you=20
proposed. Anything I miss?

Thanks


