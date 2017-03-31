Received: from eggs.gnu.org ([2001:4830:134:3::10]:58633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cto4J-0001GN-01
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cto4F-0004fS-S1
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cto4F-0004ey-JE
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:21:43 -0400
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-15-git-send-email-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C257439032C79@shsmsx102.ccr.corp.intel.com>
	<20170327091208.GG11497@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257439032D78@shsmsx102.ccr.corp.intel.com>
	<A2975661238FB949B60364EF0F2C25743903553F@shsmsx102.ccr.corp.intel.com>
	<9c3cda64-b4a3-6f9b-f951-bf73f6613faa@redhat.com>
	<20170331025618.GB3981@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <23619b9a-b671-75ff-ffc5-01a61ea9d8c5@redhat.com>
Date: Fri, 31 Mar 2017 12:21:23 +0800
MIME-Version: 1.0
In-Reply-To: <20170331025618.GB3981@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 14/17] memory: add
 MemoryRegionIOMMUOps.replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "'alex.williamson@redhat.com'" <alex.williamson@redhat.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, "'mst@redhat.com'" <mst@redhat.com>, "'jan.kiszka@siemens.com'" <jan.kiszka@siemens.com>, "'bd.aviv@gmail.com'" <bd.aviv@gmail.com>, 'David Gibson' <david@gibson.dropbear.id.au>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>



On 2017=E5=B9=B403=E6=9C=8831=E6=97=A5 10:56, Peter Xu wrote:
>>> Just come to mind that there may be a corner case here.
>>>
>>> Intel VT-d actually has a "pt" mode which allows device use physical =
address
>>> even when VT-d is enabled. In kernel, there is a iommu_identity_mappi=
ng.
>>> If a device is in this map, then it would use "pt" mode. So that IOMM=
U driver
>>> would not build second-level page table for it.
>> Yes, but qemu does not support ECAP_PT now, so guest will still have a=
 page
>> table in this case.
>>
>>> Back to the virtual IOVA implementation, if an assigned device is in =
the
>>> iommu_identity_mapping(e.g. VGA controller), it uses GPA directly to =
do DMA.
>>> So it demands a GPA->HPA mapping in host. However, the iommu->ops.rep=
lay
>>> is not able to build it when guest SL page table is empty.
>>>
>>> So I think building an entire guest PA->HPA mapping before guest kern=
el boot
>>> would be recommended. Any thoughts?
>> We plan to add PT in 2.10, a possible rough idea is disabled iommu dma=
r
>> region and use another region without iommu_ops. Then
>> vfio_listener_region_add() will just do the correct mappings.
> Even without any new region. With the patch 16/17 ("intel_iommu: allow
> dynamic switch of IOMMU region"), we can just turn the IOMMU region
> on/off, following the device's PT bit, maybe using the new
> vtd_switch_address_space() interface. That should be enough.

Right. For vhost it was probably need more works, e.g setting up static=20
mappings during region_add().

>
> Again, we just need to wait until current series merged.
>
> (Oh, then I found why I had an extra "on/off" parameter in previous
>   versions in vtd_switch_address_space(), but it was removed.)

Good to know this.

Thanks

>
> Thanks,
>
> -- peterx
