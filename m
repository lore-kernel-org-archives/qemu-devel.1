Received: from eggs.gnu.org ([2001:4830:134:3::10]:48412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTpvP-0001cU-AQ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTpvL-0000wk-9d
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:05:15 -0500
Received: from bran.ispras.ru ([83.149.199.196]:56106 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTpvK-0000uw-Qm
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:05:11 -0500
Date: Wed, 18 Jan 2017 16:05:08 +0300 (MSK)
From: Kirill Batuzov <batuzovk@ispras.ru>
In-Reply-To: <5ccf8414-c5d1-6006-b654-799cf6cd757b@twiddle.net>
Message-ID: <alpine.DEB.2.11.1701181535540.1724@bulbul.intra.ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-11-git-send-email-batuzovk@ispras.ru>
	<5ccf8414-c5d1-6006-b654-799cf6cd757b@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 10/18] tcg/i386: add support for vector
 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>

On Tue, 17 Jan 2017, Richard Henderson wrote:

> On 01/17/2017 01:07 AM, Kirill Batuzov wrote:
> > To be able to generate vector operations in a TCG backend we need to do
> > several things.
> > 
> > 1. We need to tell the register allocator about vector target's register.
> >    In case of x86 we'll use xmm0..xmm7. xmm7 is designated as a scratch
> >    register, others can be used by the register allocator.
> > 
> > 2. We need a new constraint to indicate where to use vector registers. In
> >    this commit the 'V' constraint is introduced.
> > 
> > 3. We need to be able to generate bare minimum: load, store and reg-to-reg
> >    move. MOVDQU is used for loads and stores. MOVDQA is used for reg-to-reg
> >    moves.
> > 
> > 4. Finally we need to support any other opcodes we want. INDEX_op_add_i32x4
> >    is the only one for now. The PADDD instruction handles it perfectly.
> > 
> > Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
> > ---
> >  tcg/i386/tcg-target.h     |  24 +++++++++-
> >  tcg/i386/tcg-target.inc.c | 109
> > +++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 125 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> > index 524cfc6..974a58b 100644
> > --- a/tcg/i386/tcg-target.h
> > +++ b/tcg/i386/tcg-target.h
> > @@ -29,8 +29,14 @@
> >  #define TCG_TARGET_TLB_DISPLACEMENT_BITS 31
> > 
> >  #ifdef __x86_64__
> > -# define TCG_TARGET_REG_BITS  64
> > -# define TCG_TARGET_NB_REGS   16
> > +# define TCG_TARGET_HAS_REG128 1
> > +# ifdef TCG_TARGET_HAS_REG128
> > +#  define TCG_TARGET_REG_BITS  64
> > +#  define TCG_TARGET_NB_REGS   24
> > +# else
> > +#  define TCG_TARGET_REG_BITS  64
> > +#  define TCG_TARGET_NB_REGS   16
> > +# endif
> >  #else
> >  # define TCG_TARGET_REG_BITS  32
> >  # define TCG_TARGET_NB_REGS    8
> > @@ -56,6 +62,16 @@ typedef enum {
> >      TCG_REG_R13,
> >      TCG_REG_R14,
> >      TCG_REG_R15,
> > +#ifdef TCG_TARGET_HAS_REG128
> > +    TCG_REG_XMM0,
> > +    TCG_REG_XMM1,
> > +    TCG_REG_XMM2,
> > +    TCG_REG_XMM3,
> > +    TCG_REG_XMM4,
> > +    TCG_REG_XMM5,
> > +    TCG_REG_XMM6,
> > +    TCG_REG_XMM7,
> > +#endif
> 
> There's no need to conditionalize this.  The registers can be always defined
> even if they're not used.  We really really really want to keep ifdefs to an
> absolute minimum.
> 
> Why are you not defining xmm8-15?

At first I thought about supporting both x86_64 and i386 targets, but
put this idea away (at least for the time being). Since defining xmm8-15
does not contradict anything (as I see it now) I'll add them too.

> 
> > @@ -634,9 +662,24 @@ static inline void tgen_arithr(TCGContext *s, int
> > subop, int dest, int src)
> >  static inline void tcg_out_mov(TCGContext *s, TCGType type,
> >                                 TCGReg ret, TCGReg arg)
> >  {
> > +    int opc;
> >      if (arg != ret) {
> > -        int opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
> > -        tcg_out_modrm(s, opc, ret, arg);
> > +        switch (type) {
> > +#ifdef TCG_TARGET_HAS_REG128
> > +        case TCG_TYPE_V128:
> > +            ret -= TCG_REG_XMM0;
> > +            arg -= TCG_REG_XMM0;
> > +            tcg_out_modrm(s, OPC_MOVDQA_R2R, ret, arg);
> > +            break;
> > +#endif
> > +        case TCG_TYPE_I32:
> > +        case TCG_TYPE_I64:
> > +            opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
> > +            tcg_out_modrm(s, opc, ret, arg);
> > +            break;
> > +        default:
> > +            assert(0);
> 
> g_assert_not_reached().
> 
> Again, no ifdefs.
> 
> We probably want to generate avx1 code when the cpu supports it, to avoid mode
> switches in the vector registers.  In this case, simply issue the same opcode,
> vex encoded.
> 
> > +#ifdef TCG_TARGET_HAS_REG128
> > +    { INDEX_op_add_i32x4, { "V", "0", "V" } },
> > +#endif
> 
> And, clearly, you need to rebase.
> 

I was too late to notice that some conflicting tcg-related pull has hit
master after my last rebase. Sorry. v2 will be rebased.

-- 
Kirill
