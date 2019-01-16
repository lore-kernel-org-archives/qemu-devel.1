Received: from eggs.gnu.org ([209.51.188.92]:46395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gjlzz-0000UI-Q0
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gjlzx-0004eP-Ra
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:16:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41844
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gjlzw-0004bX-0q
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:16:53 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0GEAXdH057668
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 09:16:50 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q23br894q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 09:16:50 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 16 Jan 2019 14:16:48 -0000
Reply-To: pmorel@linux.ibm.com
References: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
	<1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
	<f6a5491a-1859-8e0a-7357-901d47ee8304@linux.ibm.com>
	<20190116134011.1189b027@oc2783563651>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 16 Jan 2019 15:16:44 +0100
MIME-Version: 1.0
In-Reply-To: <20190116134011.1189b027@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <1188d21d-3603-c291-e69b-38d341ae90f4@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: Set the iommu region size
 mpcifc request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On 16/01/2019 13:40, Halil Pasic wrote:
> On Tue, 15 Jan 2019 10:35:42 -0500
> Collin Walling <walling@linux.ibm.com> wrote:
>=20
>> On 1/10/19 8:00 AM, Pierre Morel wrote:
>>> The size of the accessible iommu memory region in the guest
>>> is given to the IOMMU by the guest through the mpcifc request
>>> specifying the PCI Base Address and the PCI Address Limit.
>>>
>>> Let set the size of the IOMMU region to:
>>>       (PCI Address Limit) - (PCI Base Address) + 1.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>    hw/s390x/s390-pci-bus.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>> index 69e0671..e97696a 100644
>>> --- a/hw/s390x/s390-pci-bus.c
>>> +++ b/hw/s390x/s390-pci-bus.c
>>> @@ -660,7 +660,7 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>>>        char *name =3D g_strdup_printf("iommu-s390-%04x", iommu->pbdev=
->uid);
>>>        memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu=
_mr),
>>>                                 TYPE_S390_IOMMU_MEMORY_REGION, OBJECT=
(&iommu->mr),
>>> -                             name, iommu->pal + 1);
>>> +                             name, iommu->pal - iommu->pba + 1);
>=20
>  From the the look of this, I would say we basically used the address
> denoting the end of the region as the size of the region. This smells
> like a bug to me, but the commit message and the title ain't clear abou=
t
> this, and there is no fixes tag. Because of the latter I did some diggi=
ng
> and came to commit f7c40aa "s390x/pci: fix failures of dma
> map/unmap" (Yi Min Zhao, 2016-06-19) which basically did the inverse of
> this commit!
>=20
> My initial motivation was to check if this is stable material. But now
> I'm very confused. I'm admittedly zPCI incompetent. Could some of the
> people that understand what is going on help me feel better about this
> patch?
>=20
> Regards,
> Halil


The patch you speak about corrected the problem described in its comment=20
by setting the offset address of the subregion to 0, making sure=20
VFIO_PCI works for Z but introduced a bug we did not see at that time by=20
making the subregion too large.

This patch correct the bug, I can add a reference to this with:
fixing: commit f7c40aa1e7feb50bc4d4bc171fa811bdd9a93e51

Regards,
Pierre

>=20
>=20
>=20
>>>        iommu->enabled =3D true;
>>>        memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iomm=
u->iommu_mr));
>>>        g_free(name);
>>>
>>
>> Acked-by: Collin Walling <walling@linux.ibm.com>
>>
>>
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
