Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0317FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38FE20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EB4GC11E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38FE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Pc8-0006Bl-0S
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j9PbU-0005eh-7V
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j9PbS-00082J-Ak
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:42:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j9PbS-0007zn-4X
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583311324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OgNwV5USrQJeZxZK5OBrqBjk/XsntILUUNhBku8etPs=;
 b=EB4GC11EpKLU8TAcNkrUY1r3S3E1nMxVz5X66Jncmqx8j4navaZEuFF9ucOeGAPnQ4NYvN
 laG1oZY/TOliNMp7I8aRkE0FH4w/XxJGYGWoaFkWjAostMnlabemyCyH1PrkLXOC7Cz1qP
 MxagplBQMHMGT6eSdZQoo5HYOhcZETg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-FIMHvM-5M3-CkriYpLjw-A-1; Wed, 04 Mar 2020 03:42:00 -0500
X-MC-Unique: FIMHvM-5M3-CkriYpLjw-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 782DB190D340;
 Wed,  4 Mar 2020 08:41:58 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 211985DA60;
 Wed,  4 Mar 2020 08:41:45 +0000 (UTC)
Subject: Re: [PATCH v16 00/10] VIRTIO-IOMMU device
To: Zhangfei Gao <zhangfei.gao@gmail.com>
References: <20200214132745.23392-1-eric.auger@redhat.com>
 <20200227111717.GG1645630@redhat.com>
 <431cb39d-833c-6d02-d7b3-02b3e90446e2@redhat.com>
 <CAMj5Bkib3CTzCB02ScueFR84r28LGowF7uxYO8Ygmnj9X7oNOg@mail.gmail.com>
 <fea625f1-b58e-6da6-8e2a-f32fc9391fc8@redhat.com>
 <CAMj5Bkgm1LKbN3E2qTTxmrGhpmdL9NWarSfX-mYCWF0yt5E9eg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <88e3b669-2998-41c0-83f7-de42a72a73e7@redhat.com>
Date: Wed, 4 Mar 2020 09:41:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMj5Bkgm1LKbN3E2qTTxmrGhpmdL9NWarSfX-mYCWF0yt5E9eg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kevin.tian@intel.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 kenneth-lee-2012@foxmail.com, tnowicki@marvell.com,
 "Michael S. Tsirkin" <mst@redhat.com>, quintela@redhat.com,
 zhangfei.gao@foxmail.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 "Wangzhou \(B\)" <wangzhou1@hisilicon.com>, jean-philippe@linaro.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zhangfei,

On 3/4/20 7:08 AM, Zhangfei Gao wrote:
> On Tue, Mar 3, 2020 at 5:41 PM Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Zhangfei,
>> On 3/3/20 4:23 AM, Zhangfei Gao wrote:
>>> Hi Eric
>>>
>>> On Thu, Feb 27, 2020 at 9:50 PM Auger Eric <eric.auger@redhat.com> wrot=
e:
>>>>
>>>> Hi Daniel,
>>>>
>>>> On 2/27/20 12:17 PM, Daniel P. Berrang=C3=A9 wrote:
>>>>> On Fri, Feb 14, 2020 at 02:27:35PM +0100, Eric Auger wrote:
>>>>>> This series implements the QEMU virtio-iommu device.
>>>>>>
>>>>>> This matches the v0.12 spec (voted) and the corresponding
>>>>>> virtio-iommu driver upstreamed in 5.3. All kernel dependencies
>>>>>> are resolved for DT integration. The virtio-iommu can be
>>>>>> instantiated in ARM virt using:
>>>>>>
>>>>>> "-device virtio-iommu-pci".
>>>>>
>>>>> Is there any more documentation besides this ?
>>>>
>>>> not yet in qemu.
>>>>>
>>>>> I'm wondering on the intended usage of this, and its relation
>>>>> or pros/cons vs other iommu devices
>>>>
>>>> Maybe if you want to catch up on the topic, looking at the very first
>>>> kernel RFC may be a good starting point. Motivation, pros & cons were
>>>> discussed in that thread (hey, April 2017!)
>>>> https://lists.linuxfoundation.org/pipermail/iommu/2017-April/021217.ht=
ml
>>>>
>>>> on ARM we have SMMUv3 emulation. But the VFIO integration is not
>>>> possible because SMMU does not have any "caching mode" and my nested
>>>> paging kernel series is blocked. So the only solution to integrate wit=
h
>>>> VFIO is looming virtio-iommu.
>>>>
>>>> In general the pros that were put forward are: virtio-iommu is
>>>> architecture agnostic, removes the burden to accurately model complex
>>>> device states, driver can support virtualization specific optimization=
s
>>>> without being constrained by production driver maintenance. Cons is pe=
rf
>>>> and mem footprint if we do not consider any optimization.
>>>>
>>>> You can have a look at
>>>>
>>>> http://events17.linuxfoundation.org/sites/events/files/slides/viommu_a=
rm.pdf
>>>>
>>> Thanks for the patches.
>>>
>>> Could I ask one question?
>>> To support vSVA and pasid in guest, which direction you recommend,
>>> virtio-iommu or vSMMU (your nested paging)
>>>
>>> Do we still have any obstacles?
>> you can ask the question but not sure I can answer ;-)
>>
>> 1) SMMUv3 2stage implementation is blocked by Will at kernel level.
>>
>> Despite this situation I may/can respin as Marvell said they were
>> interested in this effort. If you are also interested in (I know you
>> tested it several times and I am grateful to you for that), please reply
>> to:
>> [PATCH v9 00/14] SMMUv3 Nested Stage Setup (IOMMU part)
>> (https://patchwork.kernel.org/cover/11039871/) and say you are
>> interested in that work so that maintainers are aware there are
>> potential users.
>>
>> At the moment I have not supported multiple CDs because it introduced
>> other dependencies.
>>
>> 2) virtio-iommu
>>
>> So only virtio-iommu dt boot on machvirt is currently supported. For non
>> DT, Jean respinned his kernel series
>> "[PATCH v2 0/3] virtio-iommu on x86 and non-devicetree platforms" as you
>> may know. However non DT integration still is controversial. Michael is
>> pushing for putting the binding info the PCI config space. Joerg
>> yesterday challenged this solution and said he would prefer ACPI
>> integration. ACPI support depends on ACPI spec update & vote anyway.
>>
>> To support PASID at virtio-iommu level you also need virtio-iommu API
>> extensions to be proposed and written + kernel works. So that's a long
>> road. I will let Jean-Philippe comment on that.
>>
>> I would just say that Intel is working on nested paging solution with
>> their emulated intel-iommu. We can help them getting that upstream and
>> partly benefit from this work.
>>
>>> Would you mind give some breakdown.
>>> Jean mentioned PASID still not supported in QEMU.
>> Do you mean support of multiple CDs in the emulated SMMU? That's a thing
>> I could implement quite easily. What is more tricky is how to test it.
>=20
> Thanks Eric
>=20
> Discussed with Jean before, here are some obstacles for vSVA via nested p=
aging.
> Do you think they are still big issues?
>=20
> Copy "
> * PASID support in QEMU, I don't think there is anything yet
> // this is not a big issue as your comments.
>=20
> * Page response support in VFIO and QEMU. With Eric's series we can
> inject recoverable faults into the guest, but there is no channel for
> the guest to RESUME the stall after fixing it.
I guess this matches a command sent through the SMMUv3 command queue
(CMD_PRI_RESP) that should be trapped by QEMU and injected to the
physical SMMU, right?

I think everybody misses that injection path and that's not specific to
virtio-iommu. PRS is not currently addressed by in-flight Intel's kernel
series ([PATCH V9 00/10] Nested Shared Virtual Address (SVA) VT-d
support) either.

I think the topic is complex enough to separate the concerns and try to
move forward in incremental steps hence my efforts to push for simple
nested use case. Can't you support vSVA without PRS first (I think this
Intel's strategy too)
>=20
> * We can't use DVM in nested mode unless the VMID is shared with the
> CPU. For that we'll need the host SMMU driver to hook into the KVM VMID
> allocator, just like we do for the ASID allocator. I haven't yet
> investigated how to do that. It's possible to do vSVA without DVM
> though, by sending all TLB invalidations through the SMMU command queue.
> "
OK.

From the above arguments I am not sure there are technical blockers with
nested paging implementation. For sure there are things that are not
supported, because I did not address this topic yet.

If I were to work on this, you did not answer bout the testing feasibility.

Thanks

Eric
>=20
> Thanks
>=20


