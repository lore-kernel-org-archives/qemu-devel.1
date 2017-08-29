Received: from eggs.gnu.org ([2001:4830:134:3::10]:48579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmYE4-0001hQ-Lr
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 00:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmYE0-0002np-OB
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 00:34:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmYE0-0002nc-FP
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 00:34:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T4Y3gE113200
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 00:34:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmvjeyqxs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 00:34:02 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 29 Aug 2017 00:33:42 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v7T4XeTv2818316
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 04:33:40 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA398AE03B
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 00:34:03 -0400 (EDT)
Received: from zyimindembp.cn.ibm.com (unknown [9.115.193.63])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 4CE80AE034
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 00:34:03 -0400 (EDT)
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-3-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170828170400.0a23b2fe.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 12:33:38 +0800
MIME-Version: 1.0
In-Reply-To: <20170828170400.0a23b2fe.cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <d9452822-7de0-2451-10c4-b5dec6ceca54@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] s390x/pci: remove idx from msix msg
 data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



=E5=9C=A8 2017/8/28 =E4=B8=8B=E5=8D=8811:04, Cornelia Huck =E5=86=99=E9=81=
=93:
> On Mon, 28 Aug 2017 10:04:45 +0200
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> PCIDevcie pointer has been a parameter of kvm_arch_fixup_msi_route().
> s/PCIDevcie/PCIDevice
Thanks!
>
>> So we don't need to store zpci idx in msix message data to find out th=
e
>> specific zpci device. Instead, we could use pci device id to find its
>> corresponding zpci device.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c  | 16 +++++-----------
>>   hw/s390x/s390-pci-bus.h  |  2 ++
>>   hw/s390x/s390-pci-inst.c | 24 ------------------------
>>   target/s390x/kvm.c       |  7 +++++--
>>   4 files changed, 12 insertions(+), 37 deletions(-)
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 1c68c36663..e348bfb7cc 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -2503,10 +2503,13 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_ro=
uting_entry *route,
>>                                uint64_t address, uint32_t data, PCIDev=
ice *dev)
>>   {
>>       S390PCIBusDevice *pbdev;
>> -    uint32_t idx =3D data >> ZPCI_MSI_VEC_BITS;
>>       uint32_t vec =3D data & ZPCI_MSI_VEC_MASK;
>>  =20
>> -    pbdev =3D s390_pci_find_dev_by_idx(s390_get_phb(), idx);
>> +    if (!dev) {
>> +        return -ENODEV;
>> +    }
>> +
>> +    pbdev =3D s390_pci_find_dev_by_target(s390_get_phb(), DEVICE(dev)=
->id);
> You need to replace the stub for s390_pci_find_dev_by_idx() with a stub
> for s390_pci_find_dev_by_target() in s390-pci-stubs.c (on my s390-next
> branch), so that it compiles without CONFIG_PCI.
OK. Got it.
>
>>       if (!pbdev) {
>>           DPRINTF("add_msi_route no dev\n");
>>           return -ENODEV;
>
>
