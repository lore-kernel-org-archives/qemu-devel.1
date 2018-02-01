Received: from eggs.gnu.org ([2001:4830:134:3::10]:43891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ehETC-0007D3-E6
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ehET7-0003Dt-G4
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:00:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1ehET7-0003DK-77
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:59:57 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w11CxrOZ134371
	for <qemu-devel@nongnu.org>; Thu, 1 Feb 2018 07:59:55 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fv119xtss-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 07:59:55 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 1 Feb 2018 12:55:46 -0000
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
	<20180130094715.11578-3-zyimin@linux.vnet.ibm.com>
	<20180131123533.52c47971.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 1 Feb 2018 13:55:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180131123533.52c47971.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b889ea29-1f04-ac11-b523-dff3ce863b1e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/pci: fixup global refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, alex.williamson@redhat.com, marcel@redhat.com

On 31/01/2018 12:35, Cornelia Huck wrote:
> On Tue, 30 Jan 2018 10:47:14 +0100
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> The VFIO common code doesn't provide the possibility to modify a
>> previous mapping entry in another way than unmapping and mapping again
>> with new properties.
> I'm wondering why other architectures don't need that. Is this
> refreshing an unique ability on s390 (due to that instruction)?

It is not specific to S390 but to the iommu_type1.

May be we should have different VFIO_IOMMU for mediated devices and
architectures with SR_IOV capabilities to suppress this restriction.

Other architectures using vfio_iommu_spapr_tce do not seem to have
the problem (AFAIU the code).

>
>> To avoid -EEXIST DMA mapping error, this we introduce a GHashTable to
> s/this//
>
>> store S390IOTLBEntry instances in order to cache the mapped entries.
>> When intercepting rpcit instruction, ignore the identical mapped
>> entries to avoid doing map operations multiple times and do unmap and
>> re-map operations for the case of updating the valid entries. To
>> achieve that goal, we also export the DMA walking function and
>> optimize the code handling errors in rpcit handler.
> How often does such a thing happen in practice?

It depends on the size of the guest memory and of the guest OS.
Linux allows an IOMMU IOVA size up to the minimal of high_memory, iommu=20
aperture
and maximal size of RT IOMMU entry.
Linux guest use lazy TLB flush and waits for the allowed IOMMU size is=20
used to
flush the TLB.
When the flush is done it is a global flush not a global invalidation,=20
it follows
that some entries in the IOTLB are still valid and must be kept while oth=
er
are to be invalidated.

Since we have no possibility to know which the entries of the IOMMU TLB
have been modified, we must check all entries.

When does the -EEXIST error happen?
- Linux before lazy flush : (c60d1ae4e 2014... we did not have zPCI at=20
that time)
 =C2=A0=C2=A0=C2=A0 never
- Linux with lazy flush and new IOMMU_TYPE1:
 =C2=A0=C2=A0=C2=A0 always as soon as the global flush occurs
 =C2=A0=C2=A0=C2=A0 which depends of the number of allowed IOMMU IOVA siz=
e and mapped=20
entries in IOTLB

When does the implemented cache be used and avoid errors?
- an entry in the cache exist for all mapped IOTLB entries
- a miss -> add the entry and issue a DMA_MAP to the host
- a hit for IOMMU_NONE -> issue a DMA_UNMAP and remove the entry
- a hit for valid unmodified entry -> do nothing (already mapped)
- hit for a valid but nmodified entry -> issue UNMAP/MAP update the entry

Regards,

Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
