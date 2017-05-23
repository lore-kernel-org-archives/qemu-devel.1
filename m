Received: from eggs.gnu.org ([2001:4830:134:3::10]:60444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDCic-0003sD-17
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDCib-0002jG-5Z
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:31:34 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDCib-0002j8-1Y
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:31:33 -0400
Received: by mail-qk0-x242.google.com with SMTP id y128so23462239qka.3
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 09:31:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-30-rth@twiddle.net>
	<20170523122820.owcu3pt6tympfeli@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <161a2a51-8b97-dd84-7828-c2e8a2db5524@twiddle.net>
Date: Tue, 23 May 2017 09:31:29 -0700
MIME-Version: 1.0
In-Reply-To: <20170523122820.owcu3pt6tympfeli@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 29/31] target/s390x: Use atomic operations
 for COMPARE SWAP PURGE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

On 05/23/2017 05:28 AM, Aurelien Jarno wrote:
> On 2017-05-22 20:03, Richard Henderson wrote:
>> +/* flush global tlb */
>> +void HELPER(purge)(CPUS390XState *env)
>> +{
>> +    S390CPU *cpu = s390_env_get_cpu(env);
>> +
>> +    tlb_flush_all_cpus(CPU(cpu));
> 
>>From what I understand from the PoP, the instruction should not complete
> before the TLB has been purged on all CPUs. Therefore I guess
> tlb_flush_all_cpus_synced() should be used instead.
I don't read that from this:

# (1) all specified entries have been cleared
# from the ALB and TLB of this CPU and

# (2) all other
# CPUs in the configuration have completed any stor-
# age accesses, including the updating of the change
# and reference bits, by using the specified ALB and
# TLB entries.

It talks about referenced bits being updated -- presumably before the tlb entry 
is flushed.  But it doesn't say "all specified ALB and TLB entries of other 
CPUs in the configuration".

But if you still disagree, it's certainly an easy change as you note.


>> +    tcg_gen_atomic_cmpxchg_i64(old, addr, o->in1, o->out2,
> 
> Here the prep generator took the 32-bit version of in1. I guess the same
> should be done for out2.

No, in1 is zero-extended for its use ...

> 
>> +                               get_mem_index(s), mop | MO_ALIGN);
>> +    tcg_temp_free_i64(addr);
>> +
>> +    /* Are the memory and expected values (un)equal?  */
>> +    cc = tcg_temp_new_i64();
>> +    tcg_gen_setcond_i64(TCG_COND_NE, cc, o->in1, old);

... here.

For out2 above, cmpxchg acts as any other store wrt MO_TEUL, in that it ignores 
the unused upper bits.


r~
