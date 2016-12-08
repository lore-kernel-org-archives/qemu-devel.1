Received: from eggs.gnu.org ([2001:4830:134:3::10]:34102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cEoLA-0006dC-3Q
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cEoL6-0005bH-UV
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:21:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cEoL6-0005am-P8
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:21:40 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDCA0C0567B3
	for <qemu-devel@nongnu.org>; Thu,  8 Dec 2016 02:21:39 +0000 (UTC)
References: <1481089965-3888-1-git-send-email-peterx@redhat.com>
	<1481089965-3888-2-git-send-email-peterx@redhat.com>
	<819b97f5-c1c6-c599-f681-9612a0d1a9e4@redhat.com>
	<20161208021623.GD28693@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2ecc2092-ef56-7289-0a6f-8ceaa5d0218e@redhat.com>
Date: Thu, 8 Dec 2016 10:21:35 +0800
MIME-Version: 1.0
In-Reply-To: <20161208021623.GD28693@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] intel_iommu: check validity
 for GAW bits in CE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, mst@redhat.com



On 2016=E5=B9=B412=E6=9C=8808=E6=97=A5 10:16, Peter Xu wrote:
> On Thu, Dec 08, 2016 at 10:02:15AM +0800, Jason Wang wrote:
>>
>> On 2016=E5=B9=B412=E6=9C=8807=E6=97=A5 13:52, Peter Xu wrote:
>>> Currently vt-d Context Entry (CE) only allows 39/48 bits address widt=
h.
>>> If guest software configured more than that, we complain and force
>>> shrink to the maximum supported, which is 48bits.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>   hw/i386/intel_iommu.c          | 12 +++++++++++-
>>>   hw/i386/intel_iommu_internal.h |  2 ++
>>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 5f3e351..98d45ef 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -601,7 +601,17 @@ static inline uint32_t vtd_get_level_from_contex=
t_entry(VTDContextEntry *ce)
>>>   static inline uint32_t vtd_get_agaw_from_context_entry(VTDContextEn=
try *ce)
>>>   {
>>> -    return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
>>> +    uint8_t aw =3D (ce->hi & VTD_CONTEXT_ENTRY_AW);
>>> +    /*
>>> +     * According to vt-d spec 10.4.2 bits 12:8, SAGAW only allows
>>> +     * 39/48 bits.
>>> +     */
>>> +    if (aw > VTD_CE_AW_48BIT) {
>>> +        error_report("Context entry address width not supported (aw=3D=
%d), "
>>> +                     "Shrinking to maximum.", aw);
>>> +        aw =3D VTD_CE_AW_48BIT;
>>> +    }
>> Is this behavior specified by spec?
> That's how I understand spec 10.4.2 bits 12:8 (as mentioned in above
> comment). Only 39/48 bits AGAW are allowed, and others are reserved.
>
> When writting up this patch, I thought illegal value for this aw bits
> (from guest software) might cause trouble, but I was wrong, since we
> have a "MIN(ce_agaw, VTD_MGAW)" check later on. So that won't be a
> problem, and this patch is not that necessary now.
>
> Thanks,
>
> -- peterx

Yes, and it can even report DMAR fault to guest which is better.

Thanks
