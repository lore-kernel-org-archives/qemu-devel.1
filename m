Received: from eggs.gnu.org ([2001:4830:134:3::10]:32845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cTHiX-0000Iz-IN
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 19:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cTHiW-0000io-HY
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 19:33:41 -0500
Message-ID: <1484613210.2028.3.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Tue, 17 Jan 2017 11:33:30 +1100
In-Reply-To: <20170116213617.GF15853@umbus>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-5-git-send-email-sjitindarsingh@gmail.com>
	<20170116213617.GF15853@umbus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 04/17] target/ppc/POWER9: Add ISAv3.00
 MMU definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org

On Tue, 2017-01-17 at 08:36 +1100, David Gibson wrote:
> On Fri, Jan 13, 2017 at 05:28:10PM +1100, Suraj Jitindar Singh wrote:
> > 
> > POWER9 processors implement the mmu as defined in version 3.00 of
> > the ISA.
> > 
> > Add a definition for this mmu model and set the POWER9 cpu model to
> > use
> > this mmu model.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  target/ppc/cpu-qom.h        | 5 ++++-
> >  target/ppc/mmu_helper.c     | 2 ++
> >  target/ppc/translate_init.c | 3 +--
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> > index d46c31a..1577cc8 100644
> > --- a/target/ppc/cpu-qom.h
> > +++ b/target/ppc/cpu-qom.h
> > @@ -86,10 +86,13 @@ enum powerpc_mmu_t {
> >      POWERPC_MMU_2_07       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> >                               | POWERPC_MMU_64K
> >                               | POWERPC_MMU_AMR | 0x00000004,
> > -    /* FIXME Add POWERPC_MMU_3_OO defines */
> >      /* Architecture 2.07 "degraded" (no 1T segments)           */
> >      POWERPC_MMU_2_07a      = POWERPC_MMU_64 | POWERPC_MMU_AMR
> >                               | 0x00000004,
> > +    /* Architecture 3.00 variant                               */
> > +    POWERPC_MMU_3_00       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> > +                             | POWERPC_MMU_64K
> > +                             | POWERPC_MMU_AMR | 0x00000005,
> Hmm.  I guess it works for now, but I'm not really sure that having
> this include POWERPC_MMU_64 is a great idea.  The name is kind of
> misleading, but I'm pretty sure a number of places assume that the
> POWERPC_MMU_64 bitindicates a 64-bit *hash* MMU, which is no longer
> really the case.
Good catch, I didn't realise this assumption was made in the code.

There are some cases where this bit needs to be set for correct
behaviour but other places where, while it doesn't break anything, it
leads to incorrect code being called.

Time for me to investigate :)
> 
> > 
> >  };
> >  
> >  /*****************************************************************
> > ************/
> > diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> > index d09fc0a..2ab4562 100644
> > --- a/target/ppc/mmu_helper.c
> > +++ b/target/ppc/mmu_helper.c
> > @@ -1935,6 +1935,7 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
> >      case POWERPC_MMU_2_06a:
> >      case POWERPC_MMU_2_07:
> >      case POWERPC_MMU_2_07a:
> > +    case POWERPC_MMU_3_00:
> >  #endif /* defined(TARGET_PPC64) */
> >          env->tlb_need_flush = 0;
> >          tlb_flush(CPU(cpu), 1);
> > @@ -1974,6 +1975,7 @@ void ppc_tlb_invalidate_one(CPUPPCState *env,
> > target_ulong addr)
> >      case POWERPC_MMU_2_06a:
> >      case POWERPC_MMU_2_07:
> >      case POWERPC_MMU_2_07a:
> > +    case POWERPC_MMU_3_00:
> >          /* tlbie invalidate TLBs for all segments */
> >          /* XXX: given the fact that there are too many segments to
> > invalidate,
> >           *      and we still don't have a tlb_flush_mask(env, n,
> > mask) in QEMU,
> > diff --git a/target/ppc/translate_init.c
> > b/target/ppc/translate_init.c
> > index bfc1f24..2402eef 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -8838,8 +8838,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void
> > *data)
> >                      (1ull << MSR_PMM) |
> >                      (1ull << MSR_RI) |
> >                      (1ull << MSR_LE);
> > -    /* Using 2.07 defines until new radix model is added. */
> > -    pcc->mmu_model = POWERPC_MMU_2_07;
> > +    pcc->mmu_model = POWERPC_MMU_3_00;
> >  #if defined(CONFIG_SOFTMMU)
> >      pcc->handle_mmu_fault = ppc_hash64_handle_mmu_fault;
> >      /* segment page size remain the same */
