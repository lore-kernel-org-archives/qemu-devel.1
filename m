Received: from eggs.gnu.org ([2001:4830:134:3::10]:41676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cj0D4-0003Qg-3Z
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cj0D3-0001gc-0x
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cj0D2-0001gQ-OB
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:08 -0500
References: <1487910561-17825-1-git-send-email-peterx@redhat.com>
	<e547f430-d078-27a5-7064-4fc5b9f738d1@redhat.com>
	<20170301023635.GE13926@pxdev.xzpeter.org>
	<20170301043802-mutt-send-email-mst@kernel.org>
	<05a23bbc-4ebc-769b-aa62-d3387af57cae@redhat.com>
	<a35dbe8f-770e-c792-e5ea-1f4f8ef8df37@redhat.com>
	<40f5950f-cefe-f15c-c941-79b1e2eb0c48@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <85b3d291-e2de-3311-3365-c5969e0e1b0f@redhat.com>
Date: Wed, 1 Mar 2017 11:05:57 +0200
MIME-Version: 1.0
In-Reply-To: <40f5950f-cefe-f15c-c941-79b1e2eb0c48@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, yi.l.liu@intel.com, qemu-devel@nongnu.org, Jintack Lim <jintack@cs.columbia.edu>

On 03/01/2017 10:43 AM, Jason Wang wrote:
>
>
> On 2017=E5=B9=B403=E6=9C=8801=E6=97=A5 15:03, Marcel Apfelbaum wrote:
>> On 03/01/2017 06:14 AM, Jason Wang wrote:
>>>
>>>
>>> On 2017=E5=B9=B403=E6=9C=8801=E6=97=A5 11:23, Michael S. Tsirkin wrot=
e:
>>>> On Wed, Mar 01, 2017 at 10:36:35AM +0800, Peter Xu wrote:
>>>>> On Tue, Feb 28, 2017 at 04:42:25PM +0200, Marcel Apfelbaum wrote:
>>>>>> On 02/24/2017 06:29 AM, Peter Xu wrote:
>>>>>>> Intel vIOMMU devices are created with "-device" parameter, while =
here
>>>>>>> actually we need to make sure the dmar device be created before o=
ther
>>>>>>> PCI devices (like vfio-pci) so that we know iommu_fn will be setu=
p
>>>>>>> correctly before realizations of those PCI devices (it is sensibl=
e that
>>>>>>> PCI device fetch these info during its realization). Now this ord=
ering
>>>>>>> yet cannot be achieved elsewhere, and devices will be created in =
the
>>>>>>> order that user specified. That might be dangerous.
>>>>>>>
>>>>>>> Here we add one more function to detect this kind of misordering =
issue,
>>>>>>> then report to guest. Currently, the only known device that is af=
fected
>>>>>>> by this VT-d defect is the vfio-pci typed devices. So for now we =
just
>>>>>>> check against it to make sure we are safe.
>>>>>>>
>>>>>> Hi,
>>>>>> I can't say that I like it but if we want it for 2.9 maybe we don'=
t have a choice.
>>>>>>
>>>>>> I mentioned in another thread other idea:
>>>>>>      Maybe we should follow the same "template" as disk/drive, nic=
/netdev ?
>>>>>>      I mean something like -device iommu,id=3Di1, -device vfio-pci=
,iommu=3De1 .
>>>>>> You are able to change the order, I didn't look how it is done.
>>>>> I suppose that's done by using different keywords. For example:
>>>>>
>>>>>    -netdev user,id=3Dnet0 -device e1000,netdev=3Dnet0
>>>>>
>>>>> Here we are using "netdev" for the backend and "device" for the
>>>>> frontend.
>>>>>
>>>>> Since we have this difference, we can just make sure the ordering b=
y
>>>>> init netdev first (in net_init_clients()), then the devices (in
>>>>> device_init_func()).
>>>>>
>>>>>> A nice side effect is that you can:
>>>>>>   1. Limit the iommu scope only to the devices you want to protect=
 (tweaking APCI tables)
>>>>>>   2. In the future we can support multiple iommu devices.
>>>> Unfortunately AFAIK this needs a bunch of work in practice:
>>>> host and guest side.
>>>> So this opens a can of worms: you can all too easily create
>>>> configurations that we don't support.
>>>>
>>>>
>>>>> Yes. Thanks,
>>>>>
>>>>> -- peterx
>>>> While I agree this fixes the specific problem, we have the ordering
>>>> issue in many other places.
>>>
>>> Yes, just post a fix for virtio-pci with IOMMU. With this fix, we mee=
t the exact issue as this patch, IOMMU needs to be created before any vir=
tio-pci devices.
>>>
>>
>> Hi Jason,
>>
>> I am not saying we don't need to create the IOMMU before some other de=
vice,
>> I just don't think that the command line order should matter to user.
>>
>> BTW, are you working on a way to limit the IOMMU scope to a specific s=
et of devices?
>> If yes, this approach will also help you work.
>
> Not yet, this may work (after 2.9) but I believe we still need a fix fo=
r 2.9.
>

I agree, I am thinking about sending a patch that at least takes the "vfi=
o-pci"
check outside the iommu code in a separate header file. We can then add o=
ther
devices that need to be crated before the iommu.

Thanks,
Marcel

> Thanks
>
>>
>> Thanks,
>> Marcel
>
