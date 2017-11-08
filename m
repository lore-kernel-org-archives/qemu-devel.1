Received: from eggs.gnu.org ([2001:4830:134:3::10]:59220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eCMWh-0000yU-QQ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eCMWc-0006O0-Pu
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:20:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eCMWc-0006NX-GV
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:19:58 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA89JJKk017600
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 04:19:57 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e3qx3na3f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 04:19:56 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 09:19:52 -0000
References: <20171107175455.73793-1-borntraeger@de.ibm.com>
	<20171107175455.73793-2-borntraeger@de.ibm.com>
	<20171108095314.7687676e.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 8 Nov 2017 10:19:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171108095314.7687676e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <7a5497d4-f8eb-e1ae-bc42-3a5afaa1b750@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/pci: let pci devices start in
 configured mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

On 08/11/2017 09:53, Cornelia Huck wrote:
> On Tue,  7 Nov 2017 18:54:55 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
>> Currently, to enable a pci device in the guest, the user has to issue
>> echo 1 > /sys/bus/pci/slots/00000000/power. This is not what people
>> expect. On an LPAR, the user can put a PCI device in configured or
>> deconfigured state via IOCDS. The "start in deconfigured state" can be
>> used for "sharing" a pci function across LPARs. This is not what we ar=
e
>> going to use in KVM, so always start configured.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Acked-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index e7a58e8..2b1e140 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -715,7 +715,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *=
hotplug_dev,
>>           pbdev->pdev =3D pdev;
>>           pbdev->iommu =3D s390_pci_get_iommu(s, pdev->bus, pdev->devf=
n);
>>           pbdev->iommu->pbdev =3D pbdev;
>> -        pbdev->state =3D ZPCI_FS_STANDBY;
>> +        pbdev->state =3D ZPCI_FS_DISABLED;
>>  =20
>>           if (s390_pci_msix_init(pbdev)) {
>>               error_setg(errp, "MSI-X support is mandatory "
>=20
> A pci function already has to be configured before we can assign it via
> vfio, right?

Yes it is right, otherwise we do not see the PCI device in the sysfs and=20
we can not provide it to QEMU.

Regards

Pierre

>=20
> I think I'll queue this for 2.11.
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
