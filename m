Received: from eggs.gnu.org ([2001:4830:134:3::10]:34812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cWDy4-0001dO-Sm
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 22:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cWDxz-0005DO-Vu
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 22:09:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cWDxz-0005DC-QI
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 22:09:47 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-17-git-send-email-peterx@redhat.com>
	<d04e7a7e-1d30-69ec-4902-7b5a5cfba02e@redhat.com>
	<20170124045242.GM26526@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <db3cf882-5825-5bc5-f097-ea65298917a0@redhat.com>
Date: Wed, 25 Jan 2017 11:09:39 +0800
MIME-Version: 1.0
In-Reply-To: <20170124045242.GM26526@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com



On 2017=E5=B9=B401=E6=9C=8824=E6=97=A5 12:52, Peter Xu wrote:
> On Mon, Jan 23, 2017 at 06:36:17PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
>>> Before this one we only invalidate context cache when we receive cont=
ext
>>> entry invalidations. However it's possible that the invalidation also
>>> contains a domain switch (only if cache-mode is enabled for vIOMMU). =
In
>>> that case we need to notify all the registered components about the n=
ew
>>> mapping.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>   hw/i386/intel_iommu.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index f9c5142..4b08b4d 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -1146,6 +1146,16 @@ static void vtd_context_device_invalidate(Inte=
lIOMMUState *s,
>>>                   trace_vtd_inv_desc_cc_device(bus_n, VTD_PCI_SLOT(de=
vfn_it),
>>>                                                VTD_PCI_FUNC(devfn_it)=
);
>>>                   vtd_as->context_cache_entry.context_cache_gen =3D 0=
;
>>> +                /*
>>> +                 * So a device is moving out of (or moving into) a
>>> +                 * domain, a replay() suites here to notify all the
>>> +                 * IOMMU_NOTIFIER_MAP registers about this change.
>>> +                 * This won't bring bad even if we have no such
>>> +                 * notifier registered - the IOMMU notification
>>> +                 * framework will skip MAP notifications if that
>>> +                 * happened.
>>> +                 */
>>> +                memory_region_iommu_replay_all(&vtd_as->iommu);
>> DSI and GLOBAL questions come back again or no need to care about them=
 :) ?
> DSI/GLOBAL hanldings are in patch 20 (though it'll be squashed into 18
> in my next post). Is that what you mean above?

Seems not, I mean DSI/GLOBAL for context cache invalidation instead of=20
IOTLB :)

Thanks

>
> Thanks!
>
> -- peterx
>
