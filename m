Received: from eggs.gnu.org ([2001:4830:134:3::10]:51880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDDrZ-0006Bb-4m
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDDrY-0005X1-22
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:44:53 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:46532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDDrX-0005Wi-SM
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:44:51 -0400
Date: Tue, 23 May 2017 19:44:49 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170523174449.yibfredwo2vaumbg@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-30-rth@twiddle.net>
	<20170523122820.owcu3pt6tympfeli@aurel32.net>
	<161a2a51-8b97-dd84-7828-c2e8a2db5524@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161a2a51-8b97-dd84-7828-c2e8a2db5524@twiddle.net>
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
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-23 09:31, Richard Henderson wrote:
> On 05/23/2017 05:28 AM, Aurelien Jarno wrote:
> > On 2017-05-22 20:03, Richard Henderson wrote:
> > > +/* flush global tlb */
> > > +void HELPER(purge)(CPUS390XState *env)
> > > +{
> > > +    S390CPU *cpu = s390_env_get_cpu(env);
> > > +
> > > +    tlb_flush_all_cpus(CPU(cpu));
> > 
> > > From what I understand from the PoP, the instruction should not complete
> > before the TLB has been purged on all CPUs. Therefore I guess
> > tlb_flush_all_cpus_synced() should be used instead.
> I don't read that from this:
> 
> # (1) all specified entries have been cleared
> # from the ALB and TLB of this CPU and
> 
> # (2) all other
> # CPUs in the configuration have completed any stor-
> # age accesses, including the updating of the change
> # and reference bits, by using the specified ALB and
> # TLB entries.
> 
> It talks about referenced bits being updated -- presumably before the tlb
> entry is flushed.  But it doesn't say "all specified ALB and TLB entries of
> other CPUs in the configuration".
> 
> But if you still disagree, it's certainly an easy change as you note.

Well i have to say it's not very clear. My point is that given the way
QEMU model things, if we want to ensure that all storage accesses using
the specified TLB entries are completed, we currently can only just make
sure that the all TLB entries have been flushed.
 
> > > +    tcg_gen_atomic_cmpxchg_i64(old, addr, o->in1, o->out2,
> > 
> > Here the prep generator took the 32-bit version of in1. I guess the same
> > should be done for out2.
> 
> No, in1 is zero-extended for its use ...
> 
> > 
> > > +                               get_mem_index(s), mop | MO_ALIGN);
> > > +    tcg_temp_free_i64(addr);
> > > +
> > > +    /* Are the memory and expected values (un)equal?  */
> > > +    cc = tcg_temp_new_i64();
> > > +    tcg_gen_setcond_i64(TCG_COND_NE, cc, o->in1, old);
> 
> ... here.
> 
> For out2 above, cmpxchg acts as any other store wrt MO_TEUL, in that it
> ignores the unused upper bits.

Indeed you are correct, I read it too fast.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
