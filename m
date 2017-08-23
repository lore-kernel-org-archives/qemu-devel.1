Received: from eggs.gnu.org ([2001:4830:134:3::10]:46660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dkTUA-0002Eq-Ec
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dkTU5-00030H-Gz
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:06:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37690
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1dkTU5-0002zr-B2
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:06:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7NB5RPO007664
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 07:06:04 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ch4keh4ex-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 07:06:03 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 23 Aug 2017 12:06:02 +0100
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-3-cohuck@redhat.com>
	<cb66ce20-c407-2462-0e51-8d6751af9f7b@linux.vnet.ibm.com>
	<20170822110454.200ff0ed.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 23 Aug 2017 13:05:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170822110454.200ff0ed.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <98e38bfd-0a72-2a9b-864d-112f30e82590@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/10] kvm: remove hard dependency on pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, agraf@suse.de, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On 22/08/2017 11:04, Cornelia Huck wrote:
> On Mon, 21 Aug 2017 18:02:12 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> On 21/08/2017 11:16, Cornelia Huck wrote:
>>> The msi routing code in kvm calls some pci functions: provide
>>> some stubs to enable builds without pci.
>>>
>>> Also, to make this more obvious, guard them via a pci_available boole=
an
>>> (which also can be reused in other places).
>>>
>>> Fixes: e1d4fb2de ("kvm-irqchip: x86: add msi route notify fn")
>>> Fixes: 767a554a0 ("kvm-all: Pass requester ID to MSI routing function=
s")
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    accel/kvm/kvm-all.c  |  6 +++---
>>>    hw/pci/pci-stub.c    | 15 +++++++++++++++
>>>    hw/pci/pci.c         |  2 ++
>>>    include/hw/pci/pci.h |  2 ++
>>>    4 files changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 46ce479dc3..f85553a851 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -1248,7 +1248,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int =
vector, PCIDevice *dev)
>>>        int virq;
>>>        MSIMessage msg =3D {0, 0};
>>>
>>> -    if (dev) {
>>> +    if (pci_available && dev) {
>>>            msg =3D pci_get_msi_message(dev, vector);
>>>        }
>>
>> Hi Conny,
>>
>> I did not find a case where pci_available is false and dev is true.
>> but anyway, sure is sure.
>=20
> It makes things more obvious, I think.
>=20
>>> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
>>> index ecad664946..ace43821ca 100644
>>> --- a/hw/pci/pci-stub.c
>>> +++ b/hw/pci/pci-stub.c
>>> @@ -23,10 +23,12 @@
>>>    #include "monitor/monitor.h"
>>>    #include "qapi/qmp/qerror.h"
>>>    #include "hw/pci/pci.h"
>>> +#include "hw/pci/msi.h"
>>
>> I think you forgot that...
>>
>>>    #include "qmp-commands.h"
>>>    #include "hw/pci/msi.h"
>>
>> ...you already have it included here. Didn't you ?
>=20
> Hum, once should really be enough.
>=20
>> otherwise LGTM
>=20
> Thanks. Can I translate that into a tag? :)
>=20

Yes,

Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>




--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
