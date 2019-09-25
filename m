Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F935C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 03:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F215620665
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 03:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F215620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCyGt-0006rf-Vr
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 23:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iCyG3-000648-Cq
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 23:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iCyG1-0006Zl-Br
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 23:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iCyG1-0006Z7-2w
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 23:46:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 586B918CB8EC;
 Wed, 25 Sep 2019 03:46:23 +0000 (UTC)
Received: from [10.72.12.148] (ovpn-12-148.pek2.redhat.com [10.72.12.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CCBD19C58;
 Wed, 25 Sep 2019 03:46:15 +0000 (UTC)
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
To: "Tian, Kevin" <kevin.tian@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <8302a4ae-1914-3046-b3b5-b3234d7dda02@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B1D1@SHSMSX104.ccr.corp.intel.com>
 <6d73572e-1e89-b04a-bdd6-98ac73798083@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B90C@SHSMSX104.ccr.corp.intel.com>
 <204219fa-ee72-ca60-52a4-fb4bbc887773@redhat.com>
 <20190919052819.GA18391@joy-OptiPlex-7040>
 <7b6d6343-33de-ebd7-9846-af54a45a82a2@redhat.com>
 <20190919061756.GB18391@joy-OptiPlex-7040>
 <e0efbdc0-aad9-0d17-ec68-36460865501f@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57DD2A@SHSMSX104.ccr.corp.intel.com>
 <1ec55b2e-6a59-f1df-0604-5b524da0f001@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D587E3C@SHSMSX104.ccr.corp.intel.com>
 <51578ae6-cc36-3b1a-9184-70a847e58712@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D58C8B9@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <80c81bb7-9532-3237-99d5-e184efc27617@redhat.com>
Date: Wed, 25 Sep 2019 11:46:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D58C8B9@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 25 Sep 2019 03:46:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Adalbert Lazar <alazar@bitdefender.com>,
 'Alex Williamson' <alex.williamson@redhat.com>,
 "tamas@tklengyel.com" <tamas@tklengyel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/9/24 =E4=B8=8A=E5=8D=8810:02, Tian, Kevin wrote:
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Friday, September 20, 2019 9:19 AM
>>
>> On 2019/9/20 =E4=B8=8A=E5=8D=886:54, Tian, Kevin wrote:
>>>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>>>> Sent: Thursday, September 19, 2019 7:14 PM
>>>>
>>>> On 19/09/19 09:16, Tian, Kevin wrote:
>>>>>>> why GPA1 and GPA2 should be both dirty?
>>>>>>> even they have the same HVA due to overlaping virtual address
>> space
>>>> in
>>>>>>> two processes, they still correspond to two physical pages.
>>>>>>> don't get what's your meaning :)
>>>>>> The point is not leave any corner case that is hard to debug or fi=
x in
>>>>>> the future.
>>>>>>
>>>>>> Let's just start by a single process, the API allows userspace to =
maps
>>>>>> HVA to both GPA1 and GPA2. Since it knows GPA1 and GPA2 are
>>>> equivalent,
>>>>>> it's ok to sync just through GPA1. That means if you only log GPA2=
, it
>>>>>> won't work.
>>>>> I noted KVM itself doesn't consider such situation (one HVA is mapp=
ed
>>>>> to multiple GPAs), when doing its dirty page tracking. If you look =
at
>>>>> kvm_vcpu_mark_page_dirty, it simply finds the unique memslot which
>>>>> contains the dirty gfn and then set the dirty bit within that slot.=
 It
>>>>> doesn't attempt to walk all memslots to find out any other GPA whic=
h
>>>>> may be mapped to the same HVA.
>>>>>
>>>>> So there must be some disconnect here. let's hear from Paolo first =
and
>>>>> understand the rationale behind such situation.
>>>> In general, userspace cannot assume that it's okay to sync just thro=
ugh
>>>> GPA1.  It must sync the host page if *either* GPA1 or GPA2 are marke=
d
>>>> dirty.
>>> Agree. In this case the kernel only needs to track whether GPA1 or
>>> GPA2 is dirtied by guest operations.
>>
>> Not necessarily guest operations.
>>
>>
>>>    The reason why vhost has to
>>> set both GPA1 and GPA2 is due to its own design - it maintains
>>> IOVA->HVA and GPA->HVA mappings thus given a IOVA you have
>>> to reverse lookup GPA->HVA memTable which gives multiple possible
>>> GPAs.
>>
>> So if userspace need to track both GPA1 and GPA2, vhost can just stop
>> when it found a one HVA->GPA mapping there.
>>
>>
>>>    But in concept if vhost can maintain a IOVA->GPA mapping,
>>> then it is straightforward to set the right GPA every time when a IOV=
A
>>> is tracked.
>>
>> That means, the translation is done twice by software, IOVA->GPA and
>> GPA->HVA for each packet.
>>
>> Thanks
>>
> yes, it's not necessary if we care about only the content of the dirty =
GPA,
> as seen in live migration. In that case, just setting the first GPA in =
the loop
> is sufficient as you pointed out. However there is one corner case whic=
h I'm
> not sure. What about an usage (e.g. VM introspection) which cares only
> about the guest access pattern i.e. which GPA is dirtied instead of pok=
ing
> its content? Neither setting the first GPA nor setting all the aliasing=
 GPAs
> can provide the accurate info, if no explicit IOVA->GPA mapping is main=
tained
> inside vhost. But I cannot tell whether maintaining such accuracy for a=
liasing
> GPAs is really necessary. +VM introspection guys if they have some opin=
ions.


Interesting, for vhost, vIOMMU can pass IOVA->GPA actually and vhost can=20
keep it and just do the translation from GPA->HVA in the map command. So=20
it can have both IOVA->GPA and IOVA->HVA mapping.

Thanks


>
> Thanks
> Kevin
>

