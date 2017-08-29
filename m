Received: from eggs.gnu.org ([2001:4830:134:3::10]:37117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmbqo-0004kL-Mt
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmbqk-0005su-Mo
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:26:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57409
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmbqk-0005sf-Gf
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:26:18 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T8OLES037234
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 04:26:17 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cn1hym7c6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 04:26:17 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 29 Aug 2017 02:26:16 -0600
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-5-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170828175722.0b54b59a.cohuck@redhat.com>
	<498a00ca-ea1a-ae09-0772-4a25c729841e@linux.vnet.ibm.com>
	<20170829100746.66c47fd8.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 16:26:10 +0800
MIME-Version: 1.0
In-Reply-To: <20170829100746.66c47fd8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0d7cc071-cebe-82d5-90da-9737a5f0733e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] s390x/pci: add iommu replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org



=E5=9C=A8 2017/8/29 =E4=B8=8B=E5=8D=884:07, Cornelia Huck =E5=86=99=E9=81=
=93:
> [Restored cc:s. Please remember to do reply-all.]
>
> On Tue, 29 Aug 2017 12:46:51 +0800
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> =E5=9C=A8 2017/8/28 =E4=B8=8B=E5=8D=8811:57, Cornelia Huck =E5=86=99=E9=
=81=93:
>>> On Mon, 28 Aug 2017 10:04:47 +0200
>>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>>>
>>>> Let's introduce iommu replay callback for s390 pci iommu memory regi=
on.
>>>> Currently we don't need any dma mapping replay. So let it return
>>>> directly. This implementation will avoid meaningless loops calling
>>>> translation callback.
>>>>
>>>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>>> ---
>>>>    hw/s390x/s390-pci-bus.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>> index 9e1f7ff5c5..359509ccea 100644
>>>> --- a/hw/s390x/s390-pci-bus.c
>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>> @@ -407,6 +407,13 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMU=
MemoryRegion *mr, hwaddr addr,
>>>>        return ret;
>>>>    }
>>>>   =20
>>>> +static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
>>>> +                                  IOMMUNotifier *notifier)
>>>> +{
>>>> +    /* we don't need iommu replay currently */
>>> This really needs to be heavier on the _why_. My guess is that anythi=
ng
>>> which would require replay goes through the rpcit instruction?
>> My understanding is:
>> Our arch is different from others. Each pci device has its own iommu, =
not
>> like other archs' implementation. So currently there must be no existi=
ng
>> mappings belonging to any newly plugged pci device whose iommu doesn't
>> have any mapping at the time.
> So please put that explanation into the function. (Also, "currently"?
> Are we expecting it to change?)
The iommu replay function is originally introduced for vfio. I think=20
they want to re-build
the existing mappings because vfio has a copy of mappings in kernel. For=20
our case,
the mappings would be cleanup when a pci device unplugged, and new mappin=
gs
would be created when a pci device plugged. I think replay only can=20
happen during
vfio-pci device migration.
>
>> In addition, it's also due to vfio blocking migration. If vfio-pci sup=
ports
>> migration in future, we could implement iommu replay by that time.
> That's not an argument: This is the base zpci support, it should not
> depend on the supported devices and what they do. (What's the status of
> virtio-pci, btw? Does it work with your patches applied, or is there
> still more to be done?)
>
>
My understanding is virtio-pci doesn't need replay. All mappings of any=20
pci device are existing in
guest memory. Once the mappings is built, all of them could be migrated=20
along with the guest
system. But I might misunderstand it. Please correct me.
