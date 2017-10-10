Received: from eggs.gnu.org ([2001:4830:134:3::10]:54330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1wyx-0007AV-1g
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1wys-0004zJ-5F
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:02:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33480
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1e1wyr-0004yY-Vm
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:02:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AFxi3O006548
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 12:01:59 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgygw6r2v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 12:01:59 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 17:01:56 +0100
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-5-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171009084506.77da9d5c@t450s.home>
	<e59c8274-c390-b99f-85dd-ec3763520ff1@linux.vnet.ibm.com>
	<20171010113520.6c3d03e3.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 18:01:53 +0200
MIME-Version: 1.0
In-Reply-To: <20171010113520.6c3d03e3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <1952d9c1-6ef8-0f1d-d89a-08e1236ad275@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/5] s390x/pci: Refuse to realize
 VFIO-PCI if AIS needed but supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, agraf@suse.de

On 10/10/2017 11:35, Cornelia Huck wrote:
> On Mon, 9 Oct 2017 19:16:23 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> On 09/10/2017 16:45, Alex Williamson wrote:
>>> On Wed,  4 Oct 2017 15:49:38 +0200
>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>>   =20
>>>> In S390x the Adapter Interrupt Suppression facility is used to mask
>>>> interrupts of other PCI devices during interruption handling.
>>>>
>>>> VFIO PCI allows the interrupts to be delivered rapidely through KVM =
via
>>>> IRQfd or to be delivered through QEMU.
>>>> The choice is made through the x-kvm-intx and x-kvo-misx properties =
of
>>>> the VFIO PCI device.
>>>>
>>>> If the VFIO PCI device is using the direct KVM access through IRQfd =
and
>>>> we know that KVM does not implement AIS support we refuse to realize=
 the
>>>> VFIO PCI device.
>>>>
>>>> In all other cases, emulation and VFIO PCI sending interrupts throug=
h
>>>> QEMU, we intercept the propagated IRQ, and protect it with the QEMU =
AIS
>>>> implementation before to send it to the guest through KVM.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>>> ---
>>>>    hw/s390x/s390-pci-bus.c | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>> index d9c294a..4afe49b 100644
>>>> --- a/hw/s390x/s390-pci-bus.c
>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>> @@ -21,18 +21,21 @@
>>>>    #include "hw/pci/pci_bus.h"
>>>>    #include "hw/pci/pci_bridge.h"
>>>>    #include "hw/pci/msi.h"
>>>> +#include "hw/vfio/pci.h"
>>>>    #include "qemu/error-report.h"
>>>>   =20
>>>>    #ifndef DEBUG_S390PCI_BUS
>>>>    #define DEBUG_S390PCI_BUS  0
>>>>    #endif
>>>>   =20
>>>> +#ifndef DPRINTF
>>>>    #define DPRINTF(fmt, ...)                                        =
 \
>>>>        do {                                                         =
 \
>>>>            if (DEBUG_S390PCI_BUS) {                                 =
 \
>>>>                fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__);=
 \
>>>>            }                                                        =
 \
>>>>        } while (0)
>>>> +#endif
>>>
>>> Maybe a sign we shouldn't be including vfio/pci.h
>>>   =20
>>>>    S390pciState *s390_get_phb(void)
>>>>    {
>>>> @@ -751,6 +754,15 @@ static void s390_pcihost_hot_plug(HotplugHandle=
r *hotplug_dev,
>>>>            }
>>>>   =20
>>>>            if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
>>>> +            S390FLICState *fs =3D s390_get_flic();
>>>> +            VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, =
pdev);
>>>> +
>>>> +            if ((!vdev->no_kvm_msix || !vdev->no_kvm_msix) &&
>>>> +                (!fs || !fs->ais_supported)) {
>>>> +                error_setg(errp, "VFIO PCI is not supported "
>>>> +                           "because kernel has no AIS capability.")=
;
>>>> +                return;
>>>> +            }
>>>
>>>
>>> Hmm, you're basically looking at private data structure fields for
>>> experimental disable flags, which no user, or more importantly no
>>> management tool, could rightfully be expected to provide.  Can we not
>>> take this into account to automatically do the right thing, ie.
>>> automatically set the necessary flag during the device realize?  Than=
ks,
>>
>> I am not sure to understand.
>>
>> Here we are in a s390x specific device and without vfio/pci.h, we have
>> no access to the PCI VFIOdevice structure from the realize function.
>>
>> Do you mean to add an entry in the VFIOPCIdevice realize?
>> A new quirk ?
>> An architecture callback, because we also need access to S390FLICState=
 ?
>>
>>
>> We also have the possibility to not fall-back to AIS emulation for VFI=
O
>> but we would loose the possibility to migrate to a host not supporting=
 AIS.
>=20
> Thinking about this some more: The problem is generally "if we have to
> fall back to ais emulation, we cannot support any pci device that
> bypasses qemu's interrupt injection", no?
>=20
> So this would imply vfio devices where the experimental switch is not
> used, but also virtio-pci if it is configured to use irqfd, I think.
>=20
> The ugly thing is that the platform-specific code depends on a property
> of the plugged device being set or not set... and that's likely to be
> different from device type to device type, and may not even be
> configurable for some device types.
>=20

Yes, right.
Since in the case we have no AIS in KVM only PCI is impacted, do you=20
think we can fence IRQFD for MSI with

kvm_msi_via_irqfd_allowed =3D false;

in kvm_arch_init_irq_routing() ?

In fact, if we also verify the AIS availability in the same routine we=20
can avoid the ugly include of vfio/pci.h

Regards,

Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
