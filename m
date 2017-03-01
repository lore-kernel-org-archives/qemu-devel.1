Received: from eggs.gnu.org ([2001:4830:134:3::10]:46142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciyJ7-0005ZM-GG
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 02:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciyJ2-0001S9-Ig
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 02:04:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ciyJ2-0001Rv-9t
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 02:04:12 -0500
References: <1487910561-17825-1-git-send-email-peterx@redhat.com>
	<e547f430-d078-27a5-7064-4fc5b9f738d1@redhat.com>
	<20170301023635.GE13926@pxdev.xzpeter.org>
	<20170301043802-mutt-send-email-mst@kernel.org>
	<05a23bbc-4ebc-769b-aa62-d3387af57cae@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <a35dbe8f-770e-c792-e5ea-1f4f8ef8df37@redhat.com>
Date: Wed, 1 Mar 2017 09:03:47 +0200
MIME-Version: 1.0
In-Reply-To: <05a23bbc-4ebc-769b-aa62-d3387af57cae@redhat.com>
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

On 03/01/2017 06:14 AM, Jason Wang wrote:
>
>
> On 2017=E5=B9=B403=E6=9C=8801=E6=97=A5 11:23, Michael S. Tsirkin wrote:
>> On Wed, Mar 01, 2017 at 10:36:35AM +0800, Peter Xu wrote:
>>> On Tue, Feb 28, 2017 at 04:42:25PM +0200, Marcel Apfelbaum wrote:
>>>> On 02/24/2017 06:29 AM, Peter Xu wrote:
>>>>> Intel vIOMMU devices are created with "-device" parameter, while he=
re
>>>>> actually we need to make sure the dmar device be created before oth=
er
>>>>> PCI devices (like vfio-pci) so that we know iommu_fn will be setup
>>>>> correctly before realizations of those PCI devices (it is sensible =
that
>>>>> PCI device fetch these info during its realization). Now this order=
ing
>>>>> yet cannot be achieved elsewhere, and devices will be created in th=
e
>>>>> order that user specified. That might be dangerous.
>>>>>
>>>>> Here we add one more function to detect this kind of misordering is=
sue,
>>>>> then report to guest. Currently, the only known device that is affe=
cted
>>>>> by this VT-d defect is the vfio-pci typed devices. So for now we ju=
st
>>>>> check against it to make sure we are safe.
>>>>>
>>>> Hi,
>>>> I can't say that I like it but if we want it for 2.9 maybe we don't =
have a choice.
>>>>
>>>> I mentioned in another thread other idea:
>>>>      Maybe we should follow the same "template" as disk/drive, nic/n=
etdev ?
>>>>      I mean something like -device iommu,id=3Di1, -device vfio-pci,i=
ommu=3De1 .
>>>> You are able to change the order, I didn't look how it is done.
>>> I suppose that's done by using different keywords. For example:
>>>
>>>    -netdev user,id=3Dnet0 -device e1000,netdev=3Dnet0
>>>
>>> Here we are using "netdev" for the backend and "device" for the
>>> frontend.
>>>
>>> Since we have this difference, we can just make sure the ordering by
>>> init netdev first (in net_init_clients()), then the devices (in
>>> device_init_func()).
>>>
>>>> A nice side effect is that you can:
>>>>   1. Limit the iommu scope only to the devices you want to protect (=
tweaking APCI tables)
>>>>   2. In the future we can support multiple iommu devices.
>> Unfortunately AFAIK this needs a bunch of work in practice:
>> host and guest side.
>> So this opens a can of worms: you can all too easily create
>> configurations that we don't support.
>>
>>
>>> Yes. Thanks,
>>>
>>> -- peterx
>> While I agree this fixes the specific problem, we have the ordering
>> issue in many other places.
>
> Yes, just post a fix for virtio-pci with IOMMU. With this fix, we meet =
the exact issue as this patch, IOMMU needs to be created before any virti=
o-pci devices.
>

Hi Jason,

I am not saying we don't need to create the IOMMU before some other devic=
e,
I just don't think that the command line order should matter to user.

BTW, are you working on a way to limit the IOMMU scope to a specific set =
of devices?
If yes, this approach will also help you work.

Thanks,
Marcel

> Thanks
>
>>   For example, this is one of the reasons we
>> don't create built-in PC devices using QOM composition.
>>
>> So I think that support for dependencies does make a lot of sense
>> generally.
>>
>>
>
