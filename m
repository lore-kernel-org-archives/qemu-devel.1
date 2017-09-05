Received: from eggs.gnu.org ([2001:4830:134:3::10]:34103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dp9qP-0000Fq-VI
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dp9qK-0008Py-Ui
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:08:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dp9qK-0008PK-Lf
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:08:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8596ro6007666
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 05:08:23 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csqt5mn7m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 05:08:23 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 05:08:22 -0400
References: <1504239778-29893-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1504239778-29893-2-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170905102928.6b23a28a.cohuck@redhat.com>
	<0923f97e-4f69-0bf3-b9ab-8e5f69a56bbb@linux.vnet.ibm.com>
	<20170905105041.3409c8cd.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 5 Sep 2017 17:08:14 +0800
MIME-Version: 1.0
In-Reply-To: <20170905105041.3409c8cd.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <07ef5826-6b09-5ac8-7d51-d00db7170437@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] s390x/pci: remove idx from msix msg
 data
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



=E5=9C=A8 2017/9/5 =E4=B8=8B=E5=8D=884:50, Cornelia Huck =E5=86=99=E9=81=93=
:
> On Tue, 5 Sep 2017 16:44:37 +0800
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> =E5=9C=A8 2017/9/5 =E4=B8=8B=E5=8D=884:29, Cornelia Huck =E5=86=99=E9=81=
=93:
>>> On Fri,  1 Sep 2017 06:22:56 +0200
>>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>>>  =20
>>>> PCIDevice pointer has been a parameter of kvm_arch_fixup_msi_route().
>>>> So we don't need to store zpci idx in msix message data to find out =
the
>>>> specific zpci device. Instead, we could use pci device id to find it=
s
>>>> corresponding zpci device.
>>>>
>>>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>>> ---
>>>>    hw/s390x/s390-pci-bus.c  | 16 +++++-----------
>>>>    hw/s390x/s390-pci-bus.h  |  2 ++
>>>>    hw/s390x/s390-pci-inst.c | 24 ------------------------
>>>>    hw/s390x/s390-pci-stub.c |  6 ++++++
>>>>    target/s390x/kvm.c       |  7 +++++--
>>>>    5 files changed, 18 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>> index 0a31a4ae88..bd8a3e1e1c 100644
>>>> --- a/hw/s390x/s390-pci-bus.c
>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>> @@ -199,8 +199,8 @@ static S390PCIBusDevice *s390_pci_find_dev_by_ui=
d(S390pciState *s, uint16_t uid)
>>>>        return NULL;
>>>>    }
>>>>   =20
>>>> -static S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *=
s,
>>>> -                                                     const char *ta=
rget)
>>>> +S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
>>>> +                                              const char *target)
>>>>    {
>>>>        S390PCIBusDevice *pbdev;
>>>>   =20
>>>> @@ -465,19 +465,13 @@ static void s390_msi_ctrl_write(void *opaque, =
hwaddr addr, uint64_t data,
>>>>                                    unsigned int size)
>>>>    {
>>>>        S390PCIBusDevice *pbdev =3D opaque;
>>>> -    uint32_t idx =3D data >> ZPCI_MSI_VEC_BITS;
>>>>        uint32_t vec =3D data & ZPCI_MSI_VEC_MASK;
>>>>        uint64_t ind_bit;
>>>>        uint32_t sum_bit;
>>>> -    uint32_t e =3D 0;
>>>>   =20
>>>> -    DPRINTF("write_msix data 0x%" PRIx64 " idx %d vec 0x%x\n", data=
, idx, vec);
>>>> -
>>>> -    if (!pbdev) {
>>>> -        e |=3D (vec << ERR_EVENT_MVN_OFFSET);
>>>> -        s390_pci_generate_error_event(ERR_EVENT_NOMSI, idx, 0, addr=
, e);
>>>> -        return;
>>>> -    }
>>>> +    assert(pbdev);
>>> I'm wondering whether you could/should generate an error event here.
>>> The one above probably won't work (as it seems to take idx as a
>>> parameter), but is this really 'this must not happen, we messed up in
>>> our code'? (Probably yes, but I want to be sure.)
>> I think this must not happen. One a pci device is plugged into zPCI bu=
s.
>> We would assign a new memory region with zpci device as opaque
>> for its msix. So if s390_msi_ctrl_write() is called, there must be a w=
rite
>> operation to a pci device's msix ctrl memory region which must has zpc=
i
>> device as a opaque. The construct is one-msi-mr-per-pci-device.
> This makes sense.
>
>>>  =20
>>>> +    DPRINTF("write_msix data 0x%" PRIx64 " idx %d vec 0x%x\n", data=
,
>>>> +            pbdev->idx, vec);
>>>>   =20
>>>>        if (pbdev->state !=3D ZPCI_FS_ENABLED) {
>>>>            return;
>>>> diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
>>>> index 7a642d376c..e501e1b9ea 100644
>>>> --- a/hw/s390x/s390-pci-stub.c
>>>> +++ b/hw/s390x/s390-pci-stub.c
>>>> @@ -74,3 +74,9 @@ S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pci=
State *s, uint32_t idx)
>>>>    {
>>>>        return NULL;
>>>>    }
>>> Please remove s390_pci_find_dev_by_idx() from the stubs file, as it i=
s
>>> not used outside of the conditionally-built pci code anymore.
>> I'm confused. s390_pci_find_dev_by_idx() can be called in
>> kvm_arch_fixup_msi_route().
>> And kvm_arch_fixup_msi_route() can be called by kvm_irqchip_add_msi_ro=
ute().
>> As the code, I think s390_pci_find_dev_by_idx() might be called. Could
>> you please
>> explain more?
> But this patch replaces this with s390_pci_find_dev_by_target(), no?
Oh! Sorry, I mixed by_target() and by_idx(). Yes, by_idx() should be=20
removed.
>
>>>  =20
>>>> +
>>>> +S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
>>>> +                                              const char *target)
>>>> +{
>>>> +    return NULL;
>>>> +}
>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>> index 1338c29528..3d490c5e4b 100644
>>>> --- a/target/s390x/kvm.c
>>>> +++ b/target/s390x/kvm.c
>>>> @@ -2533,10 +2533,13 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_=
routing_entry *route,
>>>>                                 uint64_t address, uint32_t data, PCI=
Device *dev)
>>>>    {
>>>>        S390PCIBusDevice *pbdev;
>>>> -    uint32_t idx =3D data >> ZPCI_MSI_VEC_BITS;
>>>>        uint32_t vec =3D data & ZPCI_MSI_VEC_MASK;
>>>>   =20
>>>> -    pbdev =3D s390_pci_find_dev_by_idx(s390_get_phb(), idx);
>>>> +    if (!dev) {
>>>> +        return -ENODEV;
>>> Can this actually happen?
>> I think this cannot happen. But I'm afraid that I miss something.
>> So I added this to avoid NULL pointer. But from the code and
>> my test, there has not been NULL pointer happened.
> I'm wondering if that is in the same category as the instance I
> commented on above. Do you want to log something?
>
For the case above, I ensure that zpci device must exist. But here, I'm=20
not sure.
Because it's called from outside. I'm not sure if the caller might call
kvm_irqchip_add_msi_route() with NULL as pci device argument.

Although msix ctrl mr is accessed from outside. But its initialization
is controled by our code and the pointer to zpci device is saved as
mr's opaque.
>>>  =20
>>>> +    }
>>>> +
>>>> +    pbdev =3D s390_pci_find_dev_by_target(s390_get_phb(), DEVICE(de=
v)->id);
>>>>        if (!pbdev) {
>>>>            DPRINTF("add_msi_route no dev\n");
>>>>            return -ENODEV;
>>>  =20
>
