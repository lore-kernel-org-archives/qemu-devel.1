Received: from eggs.gnu.org ([2001:4830:134:3::10]:33525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgAop-0006vh-7c
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgAol-0001Ei-3C
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:21:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dgAok-0001Ea-Qh
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:21:39 -0400
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-2-david@redhat.com>
	<c9bb3167-3de8-42a3-2815-0851b56f49a5@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <79f9f850-f0dc-cea7-8a5c-85d23b07842b@redhat.com>
Date: Fri, 11 Aug 2017 16:21:35 +0200
MIME-Version: 1.0
In-Reply-To: <c9bb3167-3de8-42a3-2815-0851b56f49a5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/5] target/s390x: introduce internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 11.08.2017 16:00, Thomas Huth wrote:
> On 11.08.2017 09:46, David Hildenbrand wrote:
>> cpu.h should only contain what really has to be accessed outside of
>> target/s390x/. Add internal.h which can only be used inside target/s390x/.
>>
>> Move everything that isn't fast enough to run away and restructure it
>> right away.
>>
>> Minor style fixes to avoid checkpatch warning to:
>> - struct Lowcore: "{" goes into same line as typedef
>> - struct LowCore: add spaces around "-" in array length calculations
>> - time2tod() and tod2time(): move "{" to separate line
>> - get_per_atmid(): add space between ")" and "?". Move cases by one char.
>> - get_per_atmid(): drop extra paremthesis around (1 << 6)
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> [...]
>> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
>> new file mode 100644
>> index 0000000..9a55271
>> --- /dev/null
>> +++ b/target/s390x/internal.h
>> @@ -0,0 +1,560 @@
>> +/*
>> + * s390x internal definitions and helpers
>> + *
>> + *  Copyright (c) 2009 Ulrich Hecht
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * Contributions after 2012-10-29 are licensed under the terms of the
>> + * GNU GPL, version 2 or (at your option) any later version.
> 
> Slightly off-topic to your patch, but since you're at it anyway: AFAIK
> the above sentence effectively means that we should update the copyright
> boiler plate to GPL2+ nowadays. See
> https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html section 3.

(not a license expert)

Do you want me to replace it also in cpu.h?

Do we still need the remark about "contributions after 2012-10-29 are" ?


> 
>> + * You should have received a copy of the GNU (Lesser) General Public
>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +

[...]
>> +    uint8_t         pad18[0x2000 - 0x1400];    /* 0x1400 */
>> +} QEMU_PACKED LowCore;
>> +#endif /* CONFIG_USER_ONLY */
> 
> Maybe you could move the cpu_map_lowcore() below into the same #ifdef
> now? Or maybe move everything related to lowcore into a separate header
> file called "lowcore.h" instead? ... just ideas, I've got not a strong
> opinion about that yet.

I'll leave it like that for now. I would agree if we also had a separate
file called lowcore.c. We can do that later.

> 
>> +static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
>> +{
>> +    switch (mmu_idx) {
>> +    case MMU_PRIMARY_IDX:
>> +        return PSW_ASC_PRIMARY;
>> +    case MMU_SECONDARY_IDX:
>> +        return PSW_ASC_SECONDARY;
>> +    case MMU_HOME_IDX:
>> +        return PSW_ASC_HOME;
>> +    default:
>> +        abort();
>> +    }
>> +}
> 
> Only used in excp_helper.c ===> move it there?

Agreed, separate patch.

> 
>> +static inline bool psw_key_valid(CPUS390XState *env, uint8_t psw_key)
>> +{
>> +    uint16_t pkm = env->cregs[3] >> 16;
>> +
>> +    if (env->psw.mask & PSW_MASK_PSTATE) {
>> +        /* PSW key has range 0..15, it is valid if the bit is 1 in the PKM */
>> +        return pkm & (0x80 >> psw_key);
>> +    }
>> +    return true;
>> +}
> 
> Only used in mem_helper.c ==> suggest to move it there.

Agreed, separate patch.

> 
> [...]
>> +/* Check if an address is within the PER starting address and the PER
>> +   ending address.  The address range might loop.  */
>> +static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
>> +{
>> +    if (env->cregs[10] <= env->cregs[11]) {
>> +        return env->cregs[10] <= addr && addr <= env->cregs[11];
>> +    } else {
>> +        return env->cregs[10] <= addr || addr <= env->cregs[11];
>> +    }
>> +}
> 
> Only used in misc_helper.c ==> move it there?

Agreed, separate patch.

> 
> [...]
>> +/* helper functions for run_on_cpu() */
>> +static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
>> +{
>> +    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
>> +
>> +    scc->cpu_reset(cs);
>> +}
> 
> This function seems to be used in diag.c only, so you could also move it
> there instead.

Agreed, separate patch.

[...]

>> +/* mem_helper.c */
>> +target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
>> +
>> +
>> +/* mmu_helper.c */
>> +int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
>> +                  target_ulong *raddr, int *flags, bool exc);
>> +
>> +
>> +/* misc_helper.c */
>> +void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
>> +                                     uintptr_t retaddr);
>> +int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
>> +void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3);
>> +
>> +
>> +/* translate.c */
>> +void s390x_translate_init(void);
> 
> I wonder whether we maybe want to have separate headers for all these
> prototypes, at least for the files that would have a lot of them, e.g.
> ioinst.h ?

I agree for kvm, that seems to be the longest list.

> 
>  Thomas
> 


-- 

Thanks,

David
