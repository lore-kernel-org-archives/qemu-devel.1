Received: from eggs.gnu.org ([2001:4830:134:3::10]:57790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fz9Ub-0000vj-1q
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 19:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fz9Ik-0000VZ-NS
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 19:39:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56638 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fz9Ii-0000Sh-Sb
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 19:39:34 -0400
References: <20180820150903.1224-1-pbonzini@redhat.com>
	<20180820150903.1224-4-pbonzini@redhat.com>
	<20180831220744.GB18048@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <709a7ba9-685e-5813-1222-197563fdf7d1@redhat.com>
Date: Mon, 10 Sep 2018 01:39:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180831220744.GB18048@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] cpus: protect TimerState writes with a
 spinlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 01/09/2018 00:07, Emilio G. Cota wrote:
> On Mon, Aug 20, 2018 at 17:09:02 +0200, Paolo Bonzini wrote:
>> In the next patch, we will need to write cpu_ticks_offset from any
>> thread, even outside the BQL.  Currently, it is protected by the BQL
>> just because cpu_enable_ticks and cpu_disable_ticks happen to hold it,
>> but the critical sections are well delimited and it's easy to remove
>> the BQL dependency.
>>
>> Add a spinlock that matches vm_clock_seqlock, and hold it when writing
>> to the TimerState.  This also lets us fix cpu_update_icount when 64-bit
>> atomics are not available.
>>
>> Fields of TiemrState are reordered to avoid padding.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  cpus.c | 72 ++++++++++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 47 insertions(+), 25 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index 680706aefa..63ddd4fd21 100644
>> --- a/cpus.c
>> +++ b/cpus.c
> (snip)
>> @@ -244,11 +250,15 @@ void cpu_update_icount(CPUState *cpu)
>>      int64_t executed = cpu_get_icount_executed(cpu);
>>      cpu->icount_budget -= executed;
>>  
>> -#ifdef CONFIG_ATOMIC64
>> +#ifndef CONFIG_ATOMIC64
>> +    seqlock_write_lock(&timers_state.vm_clock_seqlock,
>> +                       &timers_state.vm_clock_lock);
>> +#endif
>>      atomic_set__nocheck(&timers_state.qemu_icount,
>>                          timers_state.qemu_icount + executed);
>> -#else /* FIXME: we need 64bit atomics to do this safely */
>> -    timers_state.qemu_icount += executed;
>> +#ifndef CONFIG_ATOMIC64
>> +    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
>> +                         &timers_state.vm_clock_lock);
>>  #endif
> 
> 
> I'm puzzled by this hunk. Why are we only adding the seqlock_write
> if !CONFIG_ATOMIC64, if we always read .qemu_icount with seqlock_read?

Yeah, I missed that qemu_icount is read by icount_adjust and so it
indirectly affects qemu_icount_bias.  It needs the seqlock always.

Paolo
