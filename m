Received: from eggs.gnu.org ([2001:4830:134:3::10]:42032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgDOy-0007JA-Hp
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgDOv-0003Nl-Ei
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:34:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgDOv-0003NE-5O
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:34:53 -0500
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<20170221092137.5b6cecbb@t450s.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27972408-a43b-60f9-86ad-e4e47f4f8f14@redhat.com>
Date: Tue, 21 Feb 2017 17:34:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170221092137.5b6cecbb@t450s.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, zhong@linux.vnet.ibm.com



On 21/02/2017 17:21, Alex Williamson wrote:
> On Tue, 21 Feb 2017 14:46:55 +0800
> Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:
> 
>> At the moment ram device's memory regions are NATIVE_ENDIAN. This does
>> not work on PPC64 because VFIO PCI device is little endian but PPC64
>> always defines static macro TARGET_WORDS_BIGENDIAN.
>>
>> This fixes endianness for ram device the same way as it is done
>> for VFIO region in commit 6758008e2c4e79fb6bd04fe8e7a41665fa583965.
> 
> The referenced commit was to vfio code where the endianness is fixed,
> here you're modifying shared generic code to assume the same
> endianness as vfio.  That seems wrong.

Is the goal to have the same endianness as VFIO?  Or is it just a trick
to ensure the number of swaps is always 0 or 2, so that they cancel away?

In other words, would Yongji's patch just work if it used
DEVICE_BIG_ENDIAN and beNN_to_cpu/cpu_to_beNN?  If so, then I think the
patch is okay.

Paolo

> 
> Alex
>  
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>  memory.c |   14 +++++++-------
>>  1 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/memory.c b/memory.c
>> index 6c58373..1ccb99f 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1139,13 +1139,13 @@ static uint64_t memory_region_ram_device_read(void *opaque,
>>          data = *(uint8_t *)(mr->ram_block->host + addr);
>>          break;
>>      case 2:
>> -        data = *(uint16_t *)(mr->ram_block->host + addr);
>> +        data = le16_to_cpu(*(uint16_t *)(mr->ram_block->host + addr));
>>          break;
>>      case 4:
>> -        data = *(uint32_t *)(mr->ram_block->host + addr);
>> +        data = le32_to_cpu(*(uint32_t *)(mr->ram_block->host + addr));
>>          break;
>>      case 8:
>> -        data = *(uint64_t *)(mr->ram_block->host + addr);
>> +        data = le64_to_cpu(*(uint64_t *)(mr->ram_block->host + addr));
>>          break;
>>      }
>>  
>> @@ -1166,13 +1166,13 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
>>          *(uint8_t *)(mr->ram_block->host + addr) = (uint8_t)data;
>>          break;
>>      case 2:
>> -        *(uint16_t *)(mr->ram_block->host + addr) = (uint16_t)data;
>> +        *(uint16_t *)(mr->ram_block->host + addr) = cpu_to_le16((uint16_t)data);
>>          break;
>>      case 4:
>> -        *(uint32_t *)(mr->ram_block->host + addr) = (uint32_t)data;
>> +        *(uint32_t *)(mr->ram_block->host + addr) = cpu_to_le32((uint32_t)data);
>>          break;
>>      case 8:
>> -        *(uint64_t *)(mr->ram_block->host + addr) = data;
>> +        *(uint64_t *)(mr->ram_block->host + addr) = cpu_to_le64(data);
>>          break;
>>      }
>>  }
>> @@ -1180,7 +1180,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
>>  static const MemoryRegionOps ram_device_mem_ops = {
>>      .read = memory_region_ram_device_read,
>>      .write = memory_region_ram_device_write,
>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>      .valid = {
>>          .min_access_size = 1,
>>          .max_access_size = 8,
> 
