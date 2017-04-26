Received: from eggs.gnu.org ([2001:4830:134:3::10]:43078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3WJD-0001Ny-1K
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 19:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3WJB-0000Fl-Va
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 19:25:19 -0400
Date: Wed, 26 Apr 2017 19:25:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170426232510.GB27379@flamenco>
References: <1493187803-4510-1-git-send-email-cota@braap.org>
	<1493187803-4510-2-git-send-email-cota@braap.org>
	<e206fe3e-5920-49c5-8f95-e4961aad5f89@twiddle.net>
	<20170426215604.GA16014@flamenco>
	<22fb44cc-b8de-c3fb-0980-bfc908229a2e@twiddle.net>
	<20170426224531.GB16014@flamenco> <20170426231132.GC16014@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426231132.GC16014@flamenco>
Subject: Re: [Qemu-devel] [PATCH v3 01/10] tcg-runtime: add lookup_tb_ptr
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On Wed, Apr 26, 2017 at 19:11:32 -0400, Emilio G. Cota wrote:
> On Wed, Apr 26, 2017 at 18:45:31 -0400, Emilio G. Cota wrote:
> > On Thu, Apr 27, 2017 at 00:29:49 +0200, Richard Henderson wrote:
> > > On 04/26/2017 11:56 PM, Emilio G. Cota wrote:
> > > >On Wed, Apr 26, 2017 at 10:40:45 +0200, Richard Henderson wrote:
> > > >>On 04/26/2017 08:23 AM, Emilio G. Cota wrote:
> > > >(snip)
> > > >>>+    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> > > >>>+    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
> > > >>>+    if (likely(tb && tb->pc == addr && tb->cs_base == cs_base &&
> > > >>>+               tb->flags == flags)) {
> > > >>
> > > >>This comparison is wrong.  It will incorrectly reject a TB for i386 guest
> > > >>when CS_BASE != 0.  You really want
> > > >>
> > > >>   tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
> > > >>   if (tb) {
> > > >>     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> > > >>     if (tb->pc == pc && tb->cs_base == cs_base && tb->flags == flags) {
> > > >>       return tb->tc_ptr;
> > > >>     }
> > > >>   }
> > > >>   return tcg_ctx.code_gen_epilogue;
> > > >
> > > >wrt the comparison, the only change I notice in your suggested change is
> > > >   tb->pc == pc
> > > >
> > > >instead of
> > > >   tb->pc == addr
> > > >
> > > >, which seems innocuous to me (since tb->pc == addr).
> > > >
> > > >I fail to see how this relates to your "CS_BASE != 0" comment.
> > > >What am I missing?
> > > 
> > > Recall how you computed vaddr for target/i386:
> > > 
> > >   addr = pc + cs_base
> > 
> > I see, thanks!
> 
> Hmm TB's are added to tb_jmp_cache by pc, not by pc + cs_base:
> 
>   atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(pc)], tb);
> 
> Shouldn't we then pass just the pc (without adding cs_base) to
> lookup_ptr, then? i.e.
> 
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -2533,11 +2533,7 @@ gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, TCGv jr)
>      } else if (s->tf) {
>          gen_helper_single_step(cpu_env);
>      } else if (!TCGV_IS_UNUSED(jr)) {
> -        TCGv vaddr = tcg_temp_new();
> -
> -        tcg_gen_add_tl(vaddr, jr, cpu_seg_base[R_CS]);
> -        tcg_gen_lookup_and_goto_ptr(vaddr);
> -        tcg_temp_free(vaddr);
> +        tcg_gen_lookup_and_goto_ptr(jr);
>      } else {
>          tcg_gen_exit_tb(0);
>      }
> 
> And while at it, rename the "addr" argument in lookup_ptr to "pc". Hmm?

Answering to myself again..

target/i386/cpu.c:
static inline void cpu_get_tb_cpu_state(CPUX86State *env, target_ulong *pc,
                                        target_ulong *cs_base, uint32_t *flags)
{
    *cs_base = env->segs[R_CS].base;
    *pc = *cs_base + env->eip;
    *flags = env->hflags |
        (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
}

cpu-exec.c:
        /* We add the TB in the virtual pc hash table for the fast lookup */
        atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(pc)], tb);

So in lookup_and_goto_ptr, checking tb->pc == pc or tb->pc == addr,
where addr was passed from 'jr + cpu_seg_base[R_CS]', are both correct.
FWIW, I just checked with an assertion in full-system mode.

		E.
