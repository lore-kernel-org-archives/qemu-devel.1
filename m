Received: from eggs.gnu.org ([2001:4830:134:3::10]:33686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmbdY-0001kG-02
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmbdT-0007Z8-1x
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:12:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmbdS-0007XX-P6
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:12:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T89uIt121940
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 04:12:33 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cn1kjk99d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 04:12:32 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 29 Aug 2017 02:12:32 -0600
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-2-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170828165122.041b62b2.cohuck@redhat.com>
	<aac61d9b-4d56-2fd1-b35b-407f17cf9bd4@linux.vnet.ibm.com>
	<20170829100025.639b0ebb.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 16:12:26 +0800
MIME-Version: 1.0
In-Reply-To: <20170829100025.639b0ebb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2b9494d6-c2d4-5a3f-b8f8-62b63ef42e2c@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] s390x/pci: fixup trap_msix()
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



=E5=9C=A8 2017/8/29 =E4=B8=8B=E5=8D=884:00, Cornelia Huck =E5=86=99=E9=81=
=93:
> On Tue, 29 Aug 2017 12:32:17 +0800
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> =E5=9C=A8 2017/8/28 =E4=B8=8B=E5=8D=8810:51, Cornelia Huck =E5=86=99=E9=
=81=93:
>>> On Mon, 28 Aug 2017 10:04:44 +0200
>>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>>>  =20
>>>> The function trap_msix() is to check if pcistg instruction would acc=
ess
>>>> msix table entries. The correct boundary condition should be
>>>> [table_offset, table_offset+entries*entry_size). But the current
>>>> condition calculated misses the last entry. So let's fixup it.
>>>>
>>>> Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>>> ---
>>>>    hw/s390x/s390-pci-inst.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>>>> index b7beb8c36a..eba9ffb5f2 100644
>>>> --- a/hw/s390x/s390-pci-inst.c
>>>> +++ b/hw/s390x/s390-pci-inst.c
>>>> @@ -440,8 +440,8 @@ static int trap_msix(S390PCIBusDevice *pbdev, ui=
nt64_t offset, uint8_t pcias)
>>>>    {
>>>>        if (pbdev->msix.available && pbdev->msix.table_bar =3D=3D pci=
as &&
>>>>            offset >=3D pbdev->msix.table_offset &&
>>>> -        offset <=3D pbdev->msix.table_offset +
>>>> -                  (pbdev->msix.entries - 1) * PCI_MSIX_ENTRY_SIZE) =
{
>>>> +        offset < (pbdev->msix.table_offset +
>>>> +                  pbdev->msix.entries * PCI_MSIX_ENTRY_SIZE)) {
>>>>            return 1;
>>>>        } else {
>>>>            return 0;
>>> What happened before due to the miscalculation? Write to wrong memory
>>> region?
>>>
>>>  =20
>> We tried to plug virtio-net pci device but failed. After inspected, we
>> found that the device uses two msix entries but the last one was
>> missed. Then we cannot register interrupt successfully because we
>> should call trap_msixi() in order to save some useful and arch
>> information into msix message. But what about wrong memory region
>> didn't happen.
> So, the guest just was not able to use the second msix entry, but did
> not get any exception?
>
>
Forget one thing. The zpci idx is saved in msix message. The second msix=20
entry has not been
trapped so that no idx has been saved, on the other hand idx 0 is saved. =
So
kvm_arch_fixup_msi_route() will update irq route according to the zpci=20
device whose idx is 0.
So the wrong logic in trap_msix() will result that flic mixes different=20
pci devices' adapter interrupts.
