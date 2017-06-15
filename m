Received: from eggs.gnu.org ([2001:4830:134:3::10]:42096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dLUH6-00026J-BH
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dLUH5-0004dj-AC
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:53:24 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:54488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dLUH5-0004bZ-3W
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:53:23 -0400
Date: Thu, 15 Jun 2017 14:53:12 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170615125312.nlzx37tfduoakceg@aurel32.net>
References: <20170615055356.20684-1-rth@twiddle.net>
	<20170615055356.20684-3-rth@twiddle.net>
	<20170615070122.z44mdwhe25wlrn6q@aurel32.net>
	<97f3a8c2-5fc4-4df9-2372-f5b258ca7808@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f3a8c2-5fc4-4df9-2372-f5b258ca7808@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] target/s390x: Enforce instruction
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 2017-06-15 13:28, David Hildenbrand wrote:
> On 15.06.2017 09:01, Aurelien Jarno wrote:
> > On 2017-06-14 22:53, Richard Henderson wrote:
> >> Signed-off-by: Richard Henderson <rth@twiddle.net>
> >> ---
> >>  target/s390x/translate.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> >> index af18ffb..48cee25 100644
> >> --- a/target/s390x/translate.c
> >> +++ b/target/s390x/translate.c
> >> @@ -55,6 +55,7 @@ typedef struct DisasFields DisasFields;
> >>  
> >>  struct DisasContext {
> >>      struct TranslationBlock *tb;
> >> +    const unsigned long *features;
> >>      const DisasInsn *insn;
> >>      DisasFields *fields;
> >>      uint64_t ex_value;
> >> @@ -5600,6 +5601,12 @@ static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
> >>      }
> >>  #endif
> >>  
> >> +    /* Check for insn feature enabled.  */
> >> +    if (!test_bit(insn->fac, s->features)) {
> >> +        gen_program_exception(s, PGM_OPERATION);
> >> +        return EXIT_NORETURN;
> >> +    }
> >> +
> >>      /* Check for insn specification exceptions.  */
> >>      if (insn->spec) {
> >>          int spec = insn->spec, excp = 0, r;
> >> @@ -5726,6 +5733,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
> >>      }
> >>  
> >>      dc.tb = tb;
> >> +    dc.features = cpu->model->features;
> >>      dc.pc = pc_start;
> >>      dc.cc_op = CC_OP_DYNAMIC;
> >>      dc.ex_value = tb->cs_base;
> > 
> > It looks correct technically. Now I am not sure we want to do that,
> > without at least provided a user to enable those instructions. There are
> > a lot facilities that are partially implemented, usually because only
> > the really used instructions are implemented, but also because some
> > facilities are grouped in a single feature bit. This includes for
> > example FPE, LPP, MIE, LAT, IEEEE_SIM and more.
> 
> A "sane" guest (e.g. Linux) will only use an instruction if the
> corresponding stfl(e) bit is set. So in my opinion, this should be just
> fine. If the bit is not set currently, the guest will not use it == dead
> code.

Not necessarily. Depending on the distribution, gcc and hence binaries
default to a different ISA. Over the time people have added the
corresponding instructions to QEMU so that these binaries work. Now
given that GCC does not necessarily use all the instructions from a
given facility, we end up with missing instructions.

Taking this to its logical extreme, given we don't fully implement the Z
facility (for example the HFP instructions are missing), we should
prevent all the programs to run until that is fixed.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
