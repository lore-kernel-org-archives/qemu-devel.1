Received: from eggs.gnu.org ([2001:4830:134:3::10]:46972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1f6rlF-0006jz-9Y
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 02:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1f6rlA-0004XH-9n
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 02:00:37 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1f6rlA-0004VN-0E
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 02:00:32 -0400
References: <20180411172014.24711-1-clg@kaod.org>
	<20180411115511.342c75b9@w520.home>
	<01FDBDDE256B79498DC57789713132D46A15ADFF@SHSMSX101.ccr.corp.intel.com>
	<20180412102310.51725f49@w520.home>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <678aa724-f76b-9f9c-e4a3-9249d1f512d1@nvidia.com>
Date: Fri, 13 Apr 2018 11:30:09 +0530
MIME-Version: 1.0
In-Reply-To: <20180412102310.51725f49@w520.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] migration: discard RAMBlocks of type
 ram_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, "Zhang, Yulei" <yulei.zhang@intel.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Tian, Kevin" <kevin.tian@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>



On 4/12/2018 9:53 PM, Alex Williamson wrote:
> On Thu, 12 Apr 2018 15:59:24 +0000
> "Zhang, Yulei" <yulei.zhang@intel.com> wrote:
>=20
>>> -----Original Message-----
>>> From: Alex Williamson [mailto:alex.williamson@redhat.com]
>>> Sent: Thursday, April 12, 2018 1:55 AM
>>> To: C=C3=A9dric Le Goater <clg@kaod.org>
>>> Cc: qemu-devel@nongnu.org; Juan Quintela <quintela@redhat.com>; Dr .
>>> David Alan Gilbert <dgilbert@redhat.com>; David Gibson
>>> <david@gibson.dropbear.id.au>; Zhang, Yulei <yulei.zhang@intel.com>; Ti=
an,
>>> Kevin <kevin.tian@intel.com>; joonas.lahtinen@linux.intel.com;
>>> zhenyuw@linux.intel.com; kwankhede@nvidia.com; Wang, Zhi A
>>> <zhi.a.wang@intel.com>
>>> Subject: Re: [Qemu-devel] [RFC PATCH] migration: discard RAMBlocks of t=
ype
>>> ram_device
>>>
>>> [cc +folks working on vfio-mdev migration]
>>>
>>> On Wed, 11 Apr 2018 19:20:14 +0200
>>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>>  =20
>>>> Here is some context for this strange change request.
>>>>
>>>> On the POWER9 processor, the XIVE interrupt controller can control
>>>> interrupt sources using MMIO to trigger events, to EOI or to turn off
>>>> the sources. Priority management and interrupt acknowledgment is also
>>>> controlled by MMIO in the presenter subengine.
>>>>
>>>> These MMIO regions are exposed to guests in QEMU with a set of 'ram
>>>> device' memory mappings, similarly to VFIO, and the VMAs are populated
>>>> dynamically with the appropriate pages using a fault handler.
>>>>
>>>> But, these regions are an issue for migration. We need to discard the
>>>> associated RAMBlocks from the RAM state on the source VM and let the
>>>> destination VM rebuild the memory mappings on the new host in the
>>>> post_load() operation just before resuming the system.
>>>>
>>>> This is the goal of the following proposal. Does it make sense ? It
>>>> seems to be working enough to migrate a running guest but there might
>>>> be a better, more subtle, approach. =20
>>>
>>> Yulei, is this something you've run into with GVT-g migration?  I don't=
 see
>>> how we can read from or write to ram_device regions in a useful way dur=
ing
>>> migration anyway, so the change initially looks correct to me.
>>> Thanks,
>>>
>>> Alex
>>>  =20
>>
>> Didn't meet such issue before. I think the change will be fine if the ve=
ndor driver
>> handle the reconstruction well on the target side. And I agree with Dave=
's suggestion,
>> how about vendor driver report a flag about the mapped region to indicat=
e it can
>> be registered as migratable memory block or not.  =20
>=20
> "migration" and "memory blocks" are not vfio concepts, you'd need to
> come up with flags that actually conveys the device level property of
> the region that you're trying to indicate.  I don't see why we'd do
> this though, the application of such a flag seems too narrow and it
> tarnishes the concept that a vendor driver provides a region, through
> which *all* device state is saved and restored.  Thanks,
>=20

I don't think vendor driver need to report region as migratable or not
explicitly.

I hit the issue when MMIO region is mmaped by VFIO, for example BAR1 of
vGPU, that region is marked as ram region.
vfio_region_mmap() -> memory_region_init_ram_device_ptr() -> sets
mr->ram_device =3D true
Vendor driver specifies which region to be MMAPed, based on that QEMU
can decide to skip that region during migration as in this RFC. Then
vendor driver takes care of restoring it's MMIO region state after
migration.

Thanks,
Kirti
