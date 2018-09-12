Received: from eggs.gnu.org ([2001:4830:134:3::10]:42362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0ApE-0003ei-Pj
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0AlL-0006A6-NR
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:25:23 -0400
Received: from mail-co1nam05on060c.outbound.protection.outlook.com
	([2a01:111:f400:fe50::60c]:17882
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g0AlL-00069S-Dj
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:25:19 -0400
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-5-git-send-email-brijesh.singh@amd.com>
	<20180912183510.1fe2c3b8@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <88997184-3509-4a6d-4fca-cd3fa64d1858@amd.com>
Date: Wed, 12 Sep 2018 14:24:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180912183510.1fe2c3b8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] i386: acpi: add IVHD device entry for
 IOAPIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>



On 09/12/2018 11:35 AM, Igor Mammedov wrote:
...

>>   
>> +    /*
>> +     * When interrupt remapping is enabled, Linux IOMMU driver also checks
>> +     * for special IVHD device (type IO-APIC), which is typically presented
>> +     * as PCI device 14:00.0.
> Probably it shouldn't be a 'typically' device from somewhere but rather address
> fetched from corresponding device model QEMU implements.
> 

IOAPIC is not presented as a true PCI device to guest OS. When IOMMU is
enabled a pseudo address space to added under root PCI bus. PCI 14:0.0
presents to this pseudo device.

> 
>> +     */
>> +    if (s->intr_enabled) {
>> +        build_append_int_noprefix(table_data, 0x0100a00000000048, 8);
>                                                   ^^ this is incomprehensible,
> where does this magic number comes from and how was it calculated?
> 

In order to provide interrupt remap support, a special IVHD device need
to be added,  the magic number uses the format defined in Table 95 (IVHD
device entry type codes).

0x01 00a0 00 00 0000 48

Byte 0: 0x48 (special device)
Byte 1 & 2: must be zero
Byte 3: 0 (dte setting)
Byte 4: 0 (handle)
Byte 5 & 6: IOAPIC devfn (14:0.0)
Byte 7: 0x1 (IOAPIC) - See Table 97 in spec


>> +    }
>> +
>>       build_header(linker, table_data, (void *)(table_data->data + iommu_start),
>>                    "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
>>   }
> 
