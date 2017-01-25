Received: from eggs.gnu.org ([2001:4830:134:3::10]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cWIGS-0001L4-Uu
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cWIGS-0002sJ-0U
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:45:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cWIGR-0002rX-O4
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:45:07 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-17-git-send-email-peterx@redhat.com>
	<d04e7a7e-1d30-69ec-4902-7b5a5cfba02e@redhat.com>
	<20170124045242.GM26526@pxdev.xzpeter.org>
	<db3cf882-5825-5bc5-f097-ea65298917a0@redhat.com>
	<20170125034623.GA5151@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C1BA0F@SHSMSX101.ccr.corp.intel.com>
	<20170125064450.GF5151@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <734b2467-1e64-03b9-9a40-c0e48e03c56e@redhat.com>
Date: Wed, 25 Jan 2017 15:45:01 +0800
MIME-Version: 1.0
In-Reply-To: <20170125064450.GF5151@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 16/20] intel_iommu: do replay when
 context invalidate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>



On 2017=E5=B9=B401=E6=9C=8825=E6=97=A5 14:44, Peter Xu wrote:
> On Wed, Jan 25, 2017 at 06:37:23AM +0000, Tian, Kevin wrote:
>>> From: Peter Xu [mailto:peterx@redhat.com]
>>> Sent: Wednesday, January 25, 2017 11:46 AM
>>>
>>> On Wed, Jan 25, 2017 at 11:09:39AM +0800, Jason Wang wrote:
>>>>
>>>> On 2017=E5=B9=B401=E6=9C=8824=E6=97=A5 12:52, Peter Xu wrote:
>>>>> On Mon, Jan 23, 2017 at 06:36:17PM +0800, Jason Wang wrote:
>>>>>> On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
>>>>>>> Before this one we only invalidate context cache when we receive =
context
>>>>>>> entry invalidations. However it's possible that the invalidation =
also
>>>>>>> contains a domain switch (only if cache-mode is enabled for vIOMM=
U). In
>>>>>>> that case we need to notify all the registered components about t=
he new
>>>>>>> mapping.
>>>>>>>
>>>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>>>> ---
>>>>>>>   hw/i386/intel_iommu.c | 10 ++++++++++
>>>>>>>   1 file changed, 10 insertions(+)
>>>>>>>
>>>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>>>>> index f9c5142..4b08b4d 100644
>>>>>>> --- a/hw/i386/intel_iommu.c
>>>>>>> +++ b/hw/i386/intel_iommu.c
>>>>>>> @@ -1146,6 +1146,16 @@ static void
>>> vtd_context_device_invalidate(IntelIOMMUState *s,
>>>>>>>                   trace_vtd_inv_desc_cc_device(bus_n, VTD_PCI_SLO=
T(devfn_it),
>>>>>>>                                                VTD_PCI_FUNC(devfn=
_it));
>>>>>>>                   vtd_as->context_cache_entry.context_cache_gen =3D=
 0;
>>>>>>> +                /*
>>>>>>> +                 * So a device is moving out of (or moving into)=
 a
>>>>>>> +                 * domain, a replay() suites here to notify all =
the
>>>>>>> +                 * IOMMU_NOTIFIER_MAP registers about this chang=
e.
>>>>>>> +                 * This won't bring bad even if we have no such
>>>>>>> +                 * notifier registered - the IOMMU notification
>>>>>>> +                 * framework will skip MAP notifications if that
>>>>>>> +                 * happened.
>>>>>>> +                 */
>>>>>>> +                memory_region_iommu_replay_all(&vtd_as->iommu);
>>>>>> DSI and GLOBAL questions come back again or no need to care about =
them :) ?
>>>>> DSI/GLOBAL hanldings are in patch 20 (though it'll be squashed into=
 18
>>>>> in my next post). Is that what you mean above?
>>>> Seems not, I mean DSI/GLOBAL for context cache invalidation instead =
of IOTLB
>>>> :)
>>> Yes, I should possibly do the same thing for context cache global
>>> invalidations. IIUC context global invalidation should be a superset
>>> of iotlb invalidation, so maybe I'll add one more patch to call iotlb
>>> invalidation in context invalidation as well. Kevin/others, please
>>> correct me if I misunderstood the spec. Thanks,
>>>
>> context invalidation is not superset of iotlb invalidation. The spec j=
ust
>> requires software to always follow a context-cache invalidation with
>> a PASID-cache invalidation, followed by an IOTLB invalidation.
> Thanks for pointing out. If so, looks like current version suffice for
> this, right? (so no further change needed for this one)
>
> -- peterx
>

We could not depends on guest or driver behavior. I still prefer to add=20
unamp for DSI/GLOBAL to prevent us from leaking mappings.

Thanks
