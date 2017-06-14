Received: from eggs.gnu.org ([2001:4830:134:3::10]:37742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dL2dW-0000Ww-FC
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dL2dT-0002Vu-BG
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:22:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dL2dT-0002Vj-2e
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:22:39 -0400
References: <20170613214736.19963-1-david@redhat.com>
	<20170613214736.19963-3-david@redhat.com>
	<3c564230-7879-45ff-ffa1-c4e7bea17902@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <52401112-57c8-201f-d091-afb3a196412f@redhat.com>
Date: Wed, 14 Jun 2017 09:22:35 +0200
MIME-Version: 1.0
In-Reply-To: <3c564230-7879-45ff-ffa1-c4e7bea17902@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/3] target/s390x: implement mvcos
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, Miroslav Benes <mbenes@suse.cz>

On 14.06.2017 06:41, Richard Henderson wrote:
> On 06/13/2017 02:47 PM, David Hildenbrand wrote:
>> +static inline bool psw_key_valid(CPUS390XState *env, uint8_t psw_key)
>> +{
>> +    uint16_t pkm = ((env->cregs[3] & CR3_PKM) >> 16);
>> +
>> +    if (env->psw.mask & PSW_MASK_PSTATE) {
>> +        /* PSW key has range 0..15, it is valid if the bit is 1 in the PKM */
>> +        return pkm & (1 << (psw_key & 0xff));
> 
> Did you intend to write & 0xf?  Otherwise this mask is pointless...

Yes, we will always get only 4 bits set ... but I don't want any
compiler to complain about the shift. So 0xf it is. Thanks!

> 
> 
>> +        switch (src_as) {
>> +        case 0x0:
>> +            x = cpu_ldub_primary_ra(env, src, ra);
>> +            break;
>> +        case 0x2:
>> +            x = cpu_ldub_secondary_ra(env, src, ra);
>> +            break;
>> +        case 0x3:
>> +            x = cpu_ldub_home_ra(env, src, ra);
>> +            break;
>> +        }
>> +        switch (dest_as) {
>> +        case 0x0:
>> +            cpu_stb_primary_ra(env, dest, x, ra);
>> +            break;
>> +        case 0x2:
>> +            cpu_stb_secondary_ra(env, dest, x, ra);
>> +            break;
>> +        case 0x3:
>> +            cpu_stb_home_ra(env, dest, x, ra);
>> +            break;
>> +        }
> 
> Rather than these switches, you can use helper_ret_ldub_mmu.  Of course, that 
> will only work for SOFTMMU.  But for CONFIG_USER_ONLY, there's surely only one 
> address space that's legal, so you could simply forward to fast_memmove.

That sounds like a good idea. I will look into it. This would then allow
to expose the facility also for CONFIG_USER_ONLY.

> 
>> +    if (!(env->psw.mask & PSW_MASK_DAT)) {
>> +        program_interrupt(env, PGM_SPECIAL_OP, 6);
>> +    }
> 
> You should use restore_program_state before program_interrupt (or add a new 
> entry-point to do both).  Then you can drop ...

restore_program_state -  you mean cpu_restore_state() I assume.

Would it makes sense to

a) move cpu_restore_state() into program_interrupt()
b) make all callers forward ra from GETPC() (problem with kvm code that
share handlers?)
c) fixup callers that already do the cpu_restore_state()
c) drop potential_page_fault() completely

Two questions:
a) Could we avoid having to forward the ra by doing GETPC directly in
program_interrupt()? In mem_helper, I can see that we do GETPC on
several places and pass it around, so I assume GETPC() has to be called
in the first handler?
b) With cpu_restore_state(), there is no need for update_psw_addr() +
update_cc_op(), correct?

Any other nice solution for cleaning potential_page_fault() up?

> 
>> +    potential_page_fault(s);
>> +    gen_helper_mvcos(cc_op, cpu_env, o->addr1, o->in2, regs[r3]);
> 
> ... the potential_page_fault.

I would suggest to leave it in this patch as it and then clean it up all
together in one shot (adding 5 cpu_restore_state() vs. one
potential_page_fault() temporarily looks better to me).

> 
> 
> r~
> 


-- 

Thanks,

David
