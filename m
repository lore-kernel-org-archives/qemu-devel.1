Received: from eggs.gnu.org ([209.51.188.92]:35822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMULw-0001ih-AM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMULu-00053n-Ds
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:19:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMULs-00051Q-I7
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:19:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id y5so5874890wma.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:19:31 -0700 (PDT)
References: <20190422141156.15746-1-liq3ea@163.com>
	<20190422141156.15746-4-liq3ea@163.com>
	<0f466daa-2d94-b95e-d653-d44123829459@suse.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <32e69c86-3c92-2855-c046-15ea00b82806@redhat.com>
Date: Fri, 3 May 2019 11:19:28 +0200
MIME-Version: 1.0
In-Reply-To: <0f466daa-2d94-b95e-d653-d44123829459@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] edu: uses uint64_t in dma operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Slaby <jslaby@suse.cz>, Li Qiang <liq3ea@163.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

On 5/3/19 11:12 AM, Jiri Slaby wrote:
> On 22. 04. 19, 16:11, Li Qiang wrote:
>> The dma related variable dma.dst/src/cnt is dma_addr_t, it is
>> uint64_t in x64 platform. Change these usage from uint32_to
>> uint64_t to avoid trancation in edu_dma_timer.

Here I suggested fix the typo with "to avoid address truncation".

>>
>> Signed-off-by: Li Qiang <liq3ea@163.com>
>> Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
>> ---
>>  hw/misc/edu.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>> index 33de05141f..401ada74af 100644
>> --- a/hw/misc/edu.c
>> +++ b/hw/misc/edu.c
>> @@ -98,23 +98,24 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
>>      }
>>  }
>>  
>> -static bool within(uint32_t addr, uint32_t start, uint32_t end)
>> +static bool within(uint64_t addr, uint64_t start, uint64_t end)
>>  {
>>      return start <= addr && addr < end;
>>  }
>>  
>> -static void edu_check_range(uint32_t addr, uint32_t size1, uint32_t start,
>> +static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
>>                  uint32_t size2)
> 
> So in this version you don't change size2's type, but you still change
> size1's one :)?

On my previous review I suggested Li to keep u32 since the MMIO region
is 1 MB wide:

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03505.html

I agree to be coherent we should use one or another, but not a mix.

> 
> Other than that, looks good to me.
> 
>>  {
>> -    uint32_t end1 = addr + size1;
>> -    uint32_t end2 = start + size2;
>> +    uint64_t end1 = addr + size1;
>> +    uint64_t end2 = start + size2;
>>  
>>      if (within(addr, start, end2) &&
>>              end1 > addr && within(end1, start, end2)) {
>>          return;
>>      }
>>  
>> -    hw_error("EDU: DMA range 0x%.8x-0x%.8x out of bounds (0x%.8x-0x%.8x)!",
>> +    hw_error("EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
>> +             " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
>>              addr, end1 - 1, start, end2 - 1);
>>  }
> 
> 
> 
