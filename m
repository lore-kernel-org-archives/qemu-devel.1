Received: from eggs.gnu.org ([2001:4830:134:3::10]:58442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1ejFuA-0001OS-G2
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 21:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1ejFu7-0007y2-Da
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 21:56:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53990
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1ejFu7-0007xj-7I
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 21:56:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w172sTrh082471
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 21:56:10 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyqtvthxm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 21:56:09 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 21:56:09 -0500
References: <20180205072258.5968-1-zyimin@linux.vnet.ibm.com>
	<20180206112326.455bf5b0.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 7 Feb 2018 10:56:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180206112326.455bf5b0.cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <a2faea2f-111b-f193-2c55-57d3e9e0ee57@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] s390x/pci: fixup and optimize IOTLB
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alex.williamson@redhat.com, marcel@redhat.com



=D4=DA 2018/2/6 =CF=C2=CE=E76:23, Cornelia Huck =D0=B4=B5=C0:
> On Mon,  5 Feb 2018 15:22:55 +0800
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> This series contains three patches,
>> 1) optimizes the code including walking DMA tables and rpcit handler
>> 2) fixes the issue caused by IOTLB global refresh
>> 3) uses the right pal and pba when registering ioat
>>
>> The issue mentioned above was found when we tested SMC-r tools. This
>> behavior has been introduced when linux guest started using a global
>> refresh to purge the whole IOTLB of invalid entries in a lazy fashion
>> instead of flushing each entry when invalidating table entries.
>>
>> The previous QEMU implementation didn't keep track of the mapping,
>> didn't handle correctly the global flush demand from the guest and a
>> major part of the IOTLB entries were not flushed.
>>
>> Consequently linux kernel on the host keeping the previous mapping
>> reports, as it should, -EEXIST DMA mapping error on the next mapping
>> with the same IOVA. The second patch fixes this issue.
> Introducing a local tracking mechanism still feels a bit awkward to me
> (even though it works, of course). If nobody else needs such a thing,
> our best choice is to do it like that, though.
Caching iotlb entries is also helpful for us to support 2G mapping in=20
future.
>
>> During the investigation, we noticed that the current code walking
>> PCI IOMMU page tables didn't check important flags of table entries,
>> including:
>> 1) protection bit
>> 2) table length
>> 3) table offset
>> 4) intermediate tables' invalid bit
>> 5) format control bit
>>
>> We implement the checking in the first patch before handling the
>> IOTLB global refresh issue. To keep track of the mapped IOTLB entries
>> and be able to check if the host IOTLB entries need to be refreshed
>> we implement a IOTLB cache in QEMU, and introduce some helper
>> functions to check these bits. All S390IOTLBEntry instances are stored
>> in a new hashtable which are indexed by IOVA. Each PCI device has its
>> own IOMMU. Therefore each IOMMU also has its own hashtable caching
>> corresponding PCI device's DMA entries. Finally, we split 1M
>> contiguous DMA range into 4K pages to do DMA map, and the code about
>> error notification is also optimized.
>>
>> Change log:
>> v1->v2:
>> 1) update commit messages
>> 2) move some changes from the 2nd patch to the 1st patch
>> 3) define macros for 'ett' in the 1st patch
>>
>> Yi Min Zhao (3):
>>    s390x/pci: fixup the code walking IOMMU tables
>>    s390x/pci: fixup global refresh
>>    s390x/pci: use the right pal and pba in reg_ioat()
>>
>>   hw/s390x/s390-pci-bus.c  | 233 +++++++++++++++++++++++++++++++++++++=
+---------
>>   hw/s390x/s390-pci-bus.h  |  17 ++++
>>   hw/s390x/s390-pci-inst.c | 103 ++++++++++++++-------
>>   3 files changed, 275 insertions(+), 78 deletions(-)
>>
> I have played with these patches and some virtio-pci devices (since I
> don't have access to real zpci cards), and it worked both under kvm and
> under tcg. So I'm inclined to apply this (I can't review further due to
> missing documentation), unless the pci folks have further comments.
Thanks!
>
>
