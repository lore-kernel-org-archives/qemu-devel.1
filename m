Received: from eggs.gnu.org ([2001:4830:134:3::10]:55487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1Z0N-0001Tz-9Z
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1Z0H-0006eJ-2R
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:26:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52976
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1e1Z0G-0006dx-TZ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:25:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99EPk3c113249
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 10:25:53 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dg980pq62-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:25:49 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 15:25:20 +0100
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-5-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171009110614.769c19e5.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 16:25:17 +0200
MIME-Version: 1.0
In-Reply-To: <20171009110614.769c19e5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <20906fda-0857-4bed-062b-d9230c4e50f8@linux.vnet.ibm.com>
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
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de

On 09/10/2017 11:06, Cornelia Huck wrote:
> On Wed,  4 Oct 2017 15:49:38 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
> "not supported", surely?
:)
yes, "not supported"

>=20
>> In S390x the Adapter Interrupt Suppression facility is used to mask
>> interrupts of other PCI devices during interruption handling.
>>
>> VFIO PCI allows the interrupts to be delivered rapidely through KVM vi=
a
>> IRQfd or to be delivered through QEMU.
>> The choice is made through the x-kvm-intx and x-kvo-misx properties of
>> the VFIO PCI device.
>>
>> If the VFIO PCI device is using the direct KVM access through IRQfd an=
d
>> we know that KVM does not implement AIS support we refuse to realize t=
he
>> VFIO PCI device.
>>
>> In all other cases, emulation and VFIO PCI sending interrupts through
>> QEMU, we intercept the propagated IRQ, and protect it with the QEMU AI=
S
>> implementation before to send it to the guest through KVM.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index d9c294a..4afe49b 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -21,18 +21,21 @@
>>   #include "hw/pci/pci_bus.h"
>>   #include "hw/pci/pci_bridge.h"
>>   #include "hw/pci/msi.h"
>> +#include "hw/vfio/pci.h"
>>   #include "qemu/error-report.h"
>>  =20
>>   #ifndef DEBUG_S390PCI_BUS
>>   #define DEBUG_S390PCI_BUS  0
>>   #endif
>>  =20
>> +#ifndef DPRINTF
>>   #define DPRINTF(fmt, ...)                                         \
>>       do {                                                          \
>>           if (DEBUG_S390PCI_BUS) {                                  \
>>               fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); \
>>           }                                                         \
>>       } while (0)
>> +#endif
>=20
> Ugh. Is there DPRINTF redefinition going on?

Yes in hw/vfio/vfio-common.h

But I think I better do an undef / def instead of a ifndef

#ifdef DPRINTF
#undef DPRINTF
#endif
#define DPRINTF(fmt, ...)
...



>=20
>>  =20
>>   S390pciState *s390_get_phb(void)
>>   {
>> @@ -751,6 +754,15 @@ static void s390_pcihost_hot_plug(HotplugHandler =
*hotplug_dev,
>>           }
>>  =20
>>           if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
>> +            S390FLICState *fs =3D s390_get_flic();
>> +            VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pd=
ev);
>> +
>> +            if ((!vdev->no_kvm_msix || !vdev->no_kvm_msix) &&
>=20
> One of the no_kvm_msix should probably be something else :)

:) yes

Historicaly, it used to be a no_kvm_intx but since AIS only works with=20
AEN intx has no reason to be here.

So the second no_kvm_msix must disappear.

>=20
>> +                (!fs || !fs->ais_supported)) {
>> +                error_setg(errp, "VFIO PCI is not supported "
>> +                           "because kernel has no AIS capability.");
>=20
> I think failure is per-device (i.e., you would be able to plug a
> different vfio device if you turned off irqfd support for it); should
> that be reflected in the error message?

OK, I will find something better.

>=20
>> +                return;
>> +            }
>=20
> Would it make sense to fail plugging before we try to create a zpci
> device?

clearly yes. I will put these test before the eventual zpci allocation.

>=20
>>               pbdev->fh |=3D FH_SHM_VFIO;
>>           } else {
>>               pbdev->fh |=3D FH_SHM_EMUL;
>=20
>=20

Thanks,

Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
