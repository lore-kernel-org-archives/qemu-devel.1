Received: from eggs.gnu.org ([2001:4830:134:3::10]:53266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gKQfb-0003V4-Ij
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gKQfT-0005IC-FA
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:27:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36836
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gKQfT-0005H2-1F
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:26:59 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA7GIeXU000619
	for <qemu-devel@nongnu.org>; Wed, 7 Nov 2018 11:26:57 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nm1vqw7t0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 11:26:56 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 7 Nov 2018 16:26:55 -0000
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-2-david@redhat.com>
	<20181105121936.243260a6.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 7 Nov 2018 11:26:50 -0500
MIME-Version: 1.0
In-Reply-To: <20181105121936.243260a6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <63c85f6b-2a3f-941b-cac3-4ec0cf6a01d3@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 1/4] s390x/zpci: drop
 msix.available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 11/5/18 6:19 AM, Cornelia Huck wrote:
> On Mon,  5 Nov 2018 12:03:10 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> I fail to see why this is useful as we require MSIX always and
>> completely fail adding a device.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-pci-bus.c | 2 --
>>  hw/s390x/s390-pci-bus.h | 1 -
>>  2 files changed, 3 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index e1b14b131b..1eaae3aca6 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -745,7 +745,6 @@ static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
>>  
>>      pos = pci_find_capability(pbdev->pdev, PCI_CAP_ID_MSIX);
>>      if (!pos) {
>> -        pbdev->msix.available = false;
>>          return -1;
>>      }
>>  
>> @@ -761,7 +760,6 @@ static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
>>      pbdev->msix.pba_bar = pba & PCI_MSIX_FLAGS_BIRMASK;
>>      pbdev->msix.pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
>>      pbdev->msix.entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
>> -    pbdev->msix.available = true;
>>  
>>      name = g_strdup_printf("msix-s390-%04x", pbdev->uid);
>>      memory_region_init_io(&pbdev->msix_notify_mr, OBJECT(pbdev),
>> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
>> index 1f7f9b5814..f47a0f2da5 100644
>> --- a/hw/s390x/s390-pci-bus.h
>> +++ b/hw/s390x/s390-pci-bus.h
>> @@ -252,7 +252,6 @@ typedef struct ChscSeiNt2Res {
>>  } QEMU_PACKED ChscSeiNt2Res;
>>  
>>  typedef struct S390MsixInfo {
>> -    bool available;
>>      uint8_t table_bar;
>>      uint8_t pba_bar;
>>      uint16_t entries;
> 
> OK, so that was a write-only variable? :)
> 
> Question for the IBMers: is there any change we might have a different
> implementation not relying on msi-x in the future?
> 

@Conny
Currently, the plan would be to stick with a hard requirement for MSIX unless someone 
strongly supports the legacy alternatives. I'm certainly open to discuss that. Maybe it 
would make sense to fallback to MSI for devices that don't support MSIX?

@David
Thanks for the cleanup.

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Respectfully,
- Collin Walling
