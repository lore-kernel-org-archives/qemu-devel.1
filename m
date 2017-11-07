Received: from eggs.gnu.org ([2001:4830:134:3::10]:39625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eC81c-0001oZ-6G
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eC81Y-0001zp-6N
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:51:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53066
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eC81Y-0001zP-1Z
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:50:56 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA7Hog6B055307
	for <qemu-devel@nongnu.org>; Tue, 7 Nov 2017 12:50:51 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e3gec3f3d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 12:50:48 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 7 Nov 2017 17:50:13 -0000
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171107183125.10ab7032.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 7 Nov 2017 18:50:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171107183125.10ab7032.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <209811bf-8fef-6b02-455d-11e29daeb9ab@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] s390x/pci: Improve zPCI to cover more
 cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org



On 11/07/2017 06:31 PM, Cornelia Huck wrote:
> On Tue,  7 Nov 2017 18:24:32 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> 
>> Right now the PCI support is very limited (e.g. pass through of a
>> host vfio device)
>> To enable features like virtio-pci several modifications needs to be
>> done.
>>
>> Virtio-PCI uses subregions, which may eventually be discontinuous
>> inside bars instead of a single flat region.
>> The address offset being formerly calculated from the BAR base address
>> must be adapted to the subregions instead of to the single region.
>>
>> This patch provides the new calculation for the three kind of BAR
>> access, zPCI STORE, zPCI LOAD and zPCI STORE BLOCK.
>>
>> We use the opportunity to
>>  - enhance the fault detection for zPCI STORE and LOAD,
>>  - enhance the fault detection and to provide the maximum STORE BLOCK
>>    block size, maxstbl, for zPCI STORE BLOCK
>>  - factor out part of the code used to calculate the offset and
>>    access the BARs,
>>  - factor out the code for endianess conversion.
> 
> Will look at this later. Just a quick question: What kind of further
> functionality is enabled by this? E.g., I can attach a virtio-net-pci
> device right now, does this enable more virtio devices?

You can attach a virtio-net-pci today, with these patches it now starts to work ;-)
In essence to me this all looks like a bugfix (a big one though)

> 
>>
>>
>> Pierre Morel (7):
>>   s390x/pci: factor out endianess conversion
>>   s390x/pci: rework PCI STORE
>>   s390x/pci: rework PCI LOAD
>>   s390x/pci: rework PCI STORE BLOCK
>>   s390x/pci: move the memory region read from pcilg
>>   s390x/pci: move the memory region write from pcistg
>>   s390x/pci: search for subregion inside the BARs
>>
>>  hw/s390x/s390-pci-bus.h  |   1 +
>>  hw/s390x/s390-pci-inst.c | 250 ++++++++++++++++++++++++++++-------------------
>>  hw/s390x/s390-pci-inst.h |   2 +-
>>  3 files changed, 153 insertions(+), 100 deletions(-)
>>
> 
