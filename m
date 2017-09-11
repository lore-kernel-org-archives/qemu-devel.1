Received: from eggs.gnu.org ([2001:4830:134:3::10]:59015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLs8-0003xR-Pe
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLs5-0007U8-K9
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:23:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drLs5-0007Tb-BL
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:23:17 -0400
References: <20170907201335.13956-1-david@redhat.com>
	<20170907201335.13956-9-david@redhat.com>
	<1603f6bf-f481-13c2-c7eb-ac155c5a14cc@redhat.com>
	<b8f78724-b6be-3e95-60fa-8c7dcafe2eec@redhat.com>
	<20170909220737.GL7570@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c758ae70-a664-d13a-dd24-768f71e3f2e4@redhat.com>
Date: Mon, 11 Sep 2017 12:23:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170909220737.GL7570@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/21] s390x: move sclp_service_call()
 to sclp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 10/09/2017 00:07, Eduardo Habkost wrote:
> On Fri, Sep 08, 2017 at 02:46:36PM +0200, David Hildenbrand wrote:
>> On 08.09.2017 06:21, Thomas Huth wrote:
>>> On 07.09.2017 22:13, David Hildenbrand wrote:
>>>> Implemented in sclp.c, so let's move it to the right include file.
>>>> Fix up one include. Do a forward declaration of CPUS390XState to fix the
>>>> two sclp consoles complaining.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  include/hw/s390x/sclp.h    | 2 ++
>>>>  target/s390x/cpu.h         | 1 -
>>>>  target/s390x/misc_helper.c | 1 +
>>>>  3 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>>>> index a72d096081..4b86a8a293 100644
>>>> --- a/include/hw/s390x/sclp.h
>>>> +++ b/include/hw/s390x/sclp.h
>>>> @@ -242,5 +242,7 @@ sclpMemoryHotplugDev *init_sclp_memory_hotplug_dev(void);
>>>>  sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
>>>>  void sclp_service_interrupt(uint32_t sccb);
>>>>  void raise_irq_cpu_hotplug(void);
>>>> +typedef struct CPUS390XState CPUS390XState;
>>>> +int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
>>>
>>> That's dangerous and likely does not work with certain versions of GCC.
>>> You can't do a "forward declaration" with typedef in C, I'm afraid. See
>>> for example:
>>>
>>>  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01454.html
>>>  https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03337.html
>>>  https://stackoverflow.com/questions/8367646/redefinition-of-typedef
>>>
>>> All this typedef'ing in QEMU is pretty bad ... we run into this problem
>>> again and again. include/qemu/typedefs.h is just a work-around for this.
>>> I know people like typedefs for some reasons (I used to do that, too,
>>> before I realized the trouble with them), but IMHO we should rather
>>> adopt the typedef-related rules from the kernel coding conventions instead:
>>>
>>>  https://www.kernel.org/doc/html/v4.13/process/coding-style.html#typedefs
>>>
>>>   Thomas
>>>
>>
>> Yes, this is really nasty. And I wasn't aware of the involved issues.
>>
>> This seems to be the only feasible solution (including cpu.h sounds
>> wrong and will require a bunch of other includes):
>>
>>
>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>> index a72d096081..ce80915a02 100644
>> --- a/include/hw/s390x/sclp.h
>> +++ b/include/hw/s390x/sclp.h
>> @@ -242,5 +242,7 @@ sclpMemoryHotplugDev
>> *init_sclp_memory_hotplug_dev(void);
>>  sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
>>  void sclp_service_interrupt(uint32_t sccb);
>>  void raise_irq_cpu_hotplug(void);
>> +struct CPUS390XState;
>> +int sclp_service_call(struct CPUS390XState *env, uint64_t sccb,
>> uint32_t code);
>>
>>  #endif
> 
> Why not use typedefs.h?

See Markus's reply.  But, maybe it's even better to use S390CPU* and
include target/s390x/cpu-qom.h, which by design provides as little
definitions as needed.

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index 4b86a8a293..3512bf8283 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -242,7 +242,6 @@ sclpMemoryHotplugDev *init_sclp_memory_hotplug_dev(void);
>  sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
>  void sclp_service_interrupt(uint32_t sccb);
>  void raise_irq_cpu_hotplug(void);
> -typedef struct CPUS390XState CPUS390XState;
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
>  
>  #endif
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 39bc8351a3..9c97bffa92 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -21,6 +21,7 @@ typedef struct Chardev Chardev;
>  typedef struct CompatProperty CompatProperty;
>  typedef struct CPUAddressSpace CPUAddressSpace;
>  typedef struct CPUState CPUState;
> +typedef struct CPUS390XState CPUS390XState;
>  typedef struct DeviceListener DeviceListener;
>  typedef struct DeviceState DeviceState;
>  typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 032d1de2e8..f99a82cd5e 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -80,7 +80,7 @@ typedef struct MchkQueue {
>      uint16_t type;
>  } MchkQueue;
>  
> -typedef struct CPUS390XState {
> +struct CPUS390XState {
>      uint64_t regs[16];     /* GP registers */
>      /*
>       * The floating point registers are part of the vector registers.
> @@ -174,7 +174,7 @@ typedef struct CPUS390XState {
>      /* currently processed sigp order */
>      uint8_t sigp_order;
>  
> -} CPUS390XState;
> +};
>  
>  static inline CPU_DoubleU *get_freg(CPUS390XState *cs, int nr)
>  {
> 
> 
> 
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 3aa2e46aac..032d1de2e8 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -721,6 +721,5 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr,
>> uint8_t ar, void *hostbuf,
>>
>>  /* outside of target/s390x/ */
>>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
>> -int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
>>
>>  #endif
>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>> index b142db71c6..8b07535b02 100644
>> --- a/target/s390x/misc_helper.c
>> +++ b/target/s390x/misc_helper.c
>> @@ -35,6 +35,7 @@
>>  #include "sysemu/sysemu.h"
>>  #include "hw/s390x/ebcdic.h"
>>  #include "hw/s390x/s390-virtio-hcall.h"
>> +#include "hw/s390x/sclp.h"
>>  #endif
>>
>>  /* #define DEBUG_HELPER */
>>
>>
>> Opinions?
>>
>>
>>
>> -- 
>>
>> Thanks,
>>
>> David
> 
