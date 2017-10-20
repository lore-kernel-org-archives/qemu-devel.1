Received: from eggs.gnu.org ([2001:4830:134:3::10]:51585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e5Wie-00017i-PD
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e5Wia-0000By-Or
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:48:08 -0400
Received: from chuckie.co.uk ([82.165.15.123]:48846
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e5Wia-0000B4-HW
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:48:04 -0400
References: <1508006342-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508006342-5304-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<2b444c70-6a45-9f76-7c3a-47e7196717b5@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9ce0bcee-a45e-f590-e9fc-1a1a5f5511c1@ilande.co.uk>
Date: Fri, 20 Oct 2017 13:47:54 +0100
MIME-Version: 1.0
In-Reply-To: <2b444c70-6a45-9f76-7c3a-47e7196717b5@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 05/13] sun4m_iommu: move TYPE_SUN4M_IOMMU
 declaration to sun4m.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 19/10/17 05:37, Philippe Mathieu-Daudé wrote:

> On 10/14/2017 03:38 PM, Mark Cave-Ayland wrote:
>> This is in preparation to allow the type to be used elsewhere.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/dma/sun4m_iommu.c     |   14 --------------
>>  include/hw/sparc/sun4m.h |   16 ++++++++++++++++
>>  2 files changed, 16 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/dma/sun4m_iommu.c b/hw/dma/sun4m_iommu.c
>> index 335ef63..840064b 100644
>> --- a/hw/dma/sun4m_iommu.c
>> +++ b/hw/dma/sun4m_iommu.c
>> @@ -36,7 +36,6 @@
>>   * http://mediacast.sun.com/users/Barton808/media/Sun4M_SystemArchitecture_edited2.pdf
>>   */
>>  
>> -#define IOMMU_NREGS         (4*4096/4)
>>  #define IOMMU_CTRL          (0x0000 >> 2)
>>  #define IOMMU_CTRL_IMPL     0xf0000000 /* Implementation */
>>  #define IOMMU_CTRL_VERS     0x0f000000 /* Version */
>> @@ -128,19 +127,6 @@
>>  #define IOMMU_PAGE_SIZE     (1 << IOMMU_PAGE_SHIFT)
>>  #define IOMMU_PAGE_MASK     ~(IOMMU_PAGE_SIZE - 1)
>>  
>> -#define TYPE_SUN4M_IOMMU "iommu"
>> -#define SUN4M_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4M_IOMMU)
>> -
>> -typedef struct IOMMUState {
>> -    SysBusDevice parent_obj;
>> -
>> -    MemoryRegion iomem;
>> -    uint32_t regs[IOMMU_NREGS];
>> -    hwaddr iostart;
>> -    qemu_irq irq;
>> -    uint32_t version;
>> -} IOMMUState;
>> -
>>  static uint64_t iommu_mem_read(void *opaque, hwaddr addr,
>>                                 unsigned size)
>>  {
>> diff --git a/include/hw/sparc/sun4m.h b/include/hw/sparc/sun4m.h
>> index 580d87b..1f1cf91 100644
>> --- a/include/hw/sparc/sun4m.h
>> +++ b/include/hw/sparc/sun4m.h
>> @@ -4,10 +4,26 @@
>>  #include "qemu-common.h"
>>  #include "exec/hwaddr.h"
>>  #include "qapi/qmp/types.h"
>> +#include "hw/sysbus.h"
>>  
>>  /* Devices used by sparc32 system.  */
>>  
>>  /* iommu.c */
>> +#define TYPE_SUN4M_IOMMU "iommu"
> 
> Can this be "sun4m-iommu"?

Possibly. This particular patch is concerned with moving the
declarations rather than changing them. As it's freeze coming up, I'd be
quite keen to get these changes in if possible because it nicely removes
some old sun4m hacks.

In fact, I suspect that the reason the type name is "iommu" is because
sun4m was the first IOMMU implementation within QEMU, and indeed it
predates the "official" IOMMU functionality implemented as a translating
memory region. Indeed the follow-up patchset to this switches over to
use the supported IOMMU memory region and removes another set of legacy
sun4m hacks.

>> +#define SUN4M_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4M_IOMMU)
>> +
>> +#define IOMMU_NREGS         (4 * 4096 / 4)
> 
> 4096?

Possibly again, same reasoning as before: this patch is just concerned
with moving the macros rather than altering them.

>> +
>> +typedef struct IOMMUState {
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion iomem;
>> +    uint32_t regs[IOMMU_NREGS];
>> +    hwaddr iostart;
>> +    qemu_irq irq;
>> +    uint32_t version;
>> +} IOMMUState;
>> +
>>  void sparc_iommu_memory_rw(void *opaque, hwaddr addr,
>>                                   uint8_t *buf, int len, int is_write);
>>  static inline void sparc_iommu_memory_read(void *opaque,
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


ATB,

Mark.
