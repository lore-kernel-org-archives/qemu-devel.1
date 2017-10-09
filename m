Received: from eggs.gnu.org ([2001:4830:134:3::10]:49862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1YgY-0003CC-PF
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1YgS-0004yv-NH
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:05:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39547
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1e1YgS-0004y9-Cy
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:05:28 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99DxFHi110827
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 10:05:25 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dg6vqp3r1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:05:25 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 15:05:23 +0100
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-4-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171009104244.02d60070.cohuck@redhat.com>
	<20171009110852.2dcf0c55.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 16:05:20 +0200
MIME-Version: 1.0
In-Reply-To: <20171009110852.2dcf0c55.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <7239c020-cb55-e93e-14e5-840be29ff09f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 3/5] s390x/intc: Emulate Adapter
 Interrupt Suppression
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

On 09/10/2017 11:08, Cornelia Huck wrote:
> On Mon, 9 Oct 2017 10:42:44 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
>> On Wed,  4 Oct 2017 15:49:37 +0200
>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>
>>> Emulate the Adapter Interrupt Suppression in the KVM FLIC interface w=
hen
>>> the kernel does not support AIS.
>>>
>>> When the kernel KVM does not support AIS, we can not support VFIO PCI
>>> devices but we still can support emulated devices if we emulate AIS
>>> inside QEMU.
>>> Let's emulate AIS, allowing to use emulated PCI devices without KVM A=
IS
>>> support.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>> ---
>>>   hw/intc/s390_flic.c     |  3 +-
>>>   hw/intc/s390_flic_kvm.c | 76 ++++++++++++++++++++++++++++++++++++++=
++---------
>>>   2 files changed, 64 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
>>> index 6eaf178..33a7cde 100644
>>> --- a/hw/intc/s390_flic.c
>>> +++ b/hw/intc/s390_flic.c
>>> @@ -185,8 +185,7 @@ static void s390_flic_common_realize(DeviceState =
*dev, Error **errp)
>>>                      " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI)=
;
>>>           return;
>>>       }
>>> -
>>> -    fs->ais_supported =3D s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRE=
SSION);
>>> +    fs->ais_supported =3D false;
>>>   }
>>>  =20
>>>   static void s390_flic_class_init(ObjectClass *oc, void *data)
>>> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
>>> index 7ead17a..fd1aa22 100644
>>> --- a/hw/intc/s390_flic_kvm.c
>>> +++ b/hw/intc/s390_flic_kvm.c
>>> @@ -33,6 +33,8 @@ typedef struct KVMS390FLICState {
>>>  =20
>>>       uint32_t fd;
>>>       bool clear_io_supported;
>>> +    uint8_t simm;
>>> +    uint8_t nimm;
>>>   } KVMS390FLICState;
>>
>> Instead of duplicating this, move simm/nimm into the common flic state=
?
>=20
> Also, simm/nimm need to be reset (done for the qemu flic, but not for
> the kvm flic). Doing that in common flic code would take care of that
> as well.
>=20

right.
Thanks,

Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
