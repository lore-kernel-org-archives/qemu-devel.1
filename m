Received: from eggs.gnu.org ([2001:4830:134:3::10]:34160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejWIP-0005PJ-TD
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejWIK-00034f-Uw
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:26:21 -0500
Received: from mail-co1nam03on0080.outbound.protection.outlook.com
	([104.47.40.80]:18880
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejWIK-00033f-Ib
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:26:16 -0500
References: <20180207160638.98872-1-brijesh.singh@amd.com>
	<20180207160638.98872-2-brijesh.singh@amd.com>
	<3a4ba21b-1df4-3110-d211-6136dee0aca9@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <33250a09-8622-1736-340d-f1136ed68aa9@amd.com>
Date: Wed, 7 Feb 2018 14:26:07 -0600
MIME-Version: 1.0
In-Reply-To: <3a4ba21b-1df4-3110-d211-6136dee0aca9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 02/26] exec: add ram_debug_ops support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Richard Henderson <rth@twiddle.net>



On 02/07/2018 10:51 AM, Paolo Bonzini wrote:
> On 07/02/2018 17:06, Brijesh Singh wrote:
>> @@ -3148,7 +3152,11 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
>>           } else {
>>               /* RAM case */
>>               ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
>> -            memcpy(buf, ptr, l);
>> +            if (attrs.debug && mr->ram_debug_ops) {
>> +                mr->ram_debug_ops->read(buf, ptr, l, attrs);
>> +            } else {
>> +                memcpy(buf, ptr, l);
>> +            }
>>           }
>>   
>>           if (release_lock) {
> 
> You also need to tweak flatview_read in include/exec/memory.h (probably
> by adding an "&& !attrs.debug", which leaves the mr->ram_debug_ops->read
> to the slow path in exec.c).
> 


thanks, I will make the changes in flatview_read to take slow path when 
debug is enabled.


>> @@ -3218,11 +3226,13 @@ void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
>>   
>>   enum write_rom_type {
>>       WRITE_DATA,
>> +    READ_DATA,
>>       FLUSH_CACHE,
>>   };
>>   
>> -static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
>> -    hwaddr addr, const uint8_t *buf, int len, enum write_rom_type type)
>> +static inline void cpu_physical_memory_rw_internal(AddressSpace *as,
>> +    hwaddr addr, uint8_t *buf, int len, MemTxAttrs attrs,
>> +    enum write_rom_type type)
>>   {
>>       hwaddr l;
>>       uint8_t *ptr;
> 
> I wonder if READ_DATA and WRITE_DATA still need to go down to
> cpu_physical_memory_rw_internal.  Maybe you can just call
> address_space_rw with &address_space_memory as the address space, and
> "(MemTxAttrs) { .debug = 1 }" as the attributes.
> 


I will take a look to see if I can remove passing down the READ_DATA and 
WRITE_DATA.
