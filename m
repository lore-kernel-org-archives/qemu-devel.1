Received: from eggs.gnu.org ([2001:4830:134:3::10]:56750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mbenes@suse.cz>) id 1cj3EY-0008R1-F4
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mbenes@suse.cz>) id 1cj3EU-0007W4-FF
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:19:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:52188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mbenes@suse.cz>) id 1cj3EU-0007Vj-5k
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:19:50 -0500
Date: Wed, 1 Mar 2017 13:19:47 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
In-Reply-To: <e30b5e57-82a0-d030-6be0-1b78492ada0e@redhat.com>
Message-ID: <alpine.LSU.2.20.1703011310200.5005@pobox.suse.cz>
References: <20170228131710.10593-1-mbenes@suse.cz>
	<e30b5e57-82a0-d030-6be0-1b78492ada0e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [RFC PATCH] target-s390x: Implement mvcos
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: rth@twiddle.net, agraf@suse.de, qemu-devel@nongnu.org, mmarek@suse.com, ebischoff@suse.com

On Wed, 1 Mar 2017, Thomas Huth wrote:

> On 28.02.2017 14:17, Miroslav Benes wrote:
> > Implement MVCOS instruction, which the Linux kernel uses in user access
> > functions.
> > 
> > Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> > ---
> > I tried to do my best to follow the specification but it is quite
> > possible that I got something wrong because of my lack of
> > understanding. Especially I am not sure about all those bit ops :/.
> > 
> > Anyway, there is one piece missing. The actual use of keys and
> > address-space-control during the move. I used fast_memmove, but
> > it is not correct. Is there a helper which I could use? I looked at
> > other instructions which should implement access control, but there were
> > silently ignore it :).
> 
> I'm not aware of a function that could deal with two address spaces
> already (but that does not mean that there is no such function already)
> ... still, I guess, you likely need to write your own memmove helper
> function that can deal with two different address spaces.

Ok, I thought that was the case. I'll try to come up with something.
 
> >  target/s390x/helper.h      |  1 +
> >  target/s390x/insn-data.def |  2 ++
> >  target/s390x/mem_helper.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++++
> >  target/s390x/translate.c   | 12 +++++++
> >  4 files changed, 95 insertions(+)
> > 
> > diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> > index 9102071d0aa4..bc5dfccc3d7e 100644
> > --- a/target/s390x/helper.h
> > +++ b/target/s390x/helper.h
> > @@ -104,6 +104,7 @@ DEF_HELPER_FLAGS_2(iske, TCG_CALL_NO_RWG_SE, i64, env, i64)
> >  DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
> >  DEF_HELPER_FLAGS_2(rrbe, TCG_CALL_NO_RWG, i32, env, i64)
> >  DEF_HELPER_3(csp, i32, env, i32, i64)
> > +DEF_HELPER_5(mvcos, i32, env, i64, i64, i64, i64)
> >  DEF_HELPER_4(mvcs, i32, env, i64, i64, i64)
> >  DEF_HELPER_4(mvcp, i32, env, i64, i64, i64)
> >  DEF_HELPER_4(sigp, i32, env, i64, i32, i64)
> > diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> > index 075ff597c3de..a1e6d735d090 100644
> > --- a/target/s390x/insn-data.def
> > +++ b/target/s390x/insn-data.def
> > @@ -854,6 +854,8 @@
> >  /* LOAD USING REAL ADDRESS */
> >      C(0xb24b, LURA,    RRE,   Z,   0, r2, new, r1_32, lura, 0)
> >      C(0xb905, LURAG,   RRE,   Z,   0, r2, r1, 0, lurag, 0)
> > +/* MOVE WITH OPTIONAL SPECIFICATION */
> > +    C(0xc800, MVCOS,   SSF,   MVCOS, la1, a2, 0, 0, mvcos, 0)
> >  /* MOVE TO PRIMARY */
> >      C(0xda00, MVCP,    SS_d,  Z,   la1, a2, 0, 0, mvcp, 0)
> >  /* MOVE TO SECONDARY */
> > diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> > index 675aba2e44d4..ca8f7c49250c 100644
> > --- a/target/s390x/mem_helper.c
> > +++ b/target/s390x/mem_helper.c
> > @@ -1089,6 +1089,86 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
> >      return cc;
> >  }
> >  
> > +uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t r0, uint64_t dest,
> > +                       uint64_t src, uint64_t len)
> > +{
> > +    int cc;
> > +    int key1, as1, abit1, kbit1;
> > +    int key2, as2, abit2, kbit2;
> > +
> > +    HELPER_LOG("%s dest %" PRIx64 ", src %" PRIx64 ", len %" PRIx64 "\n",
> > +               __func__, dest, src, len);
> > +
> > +    /* check DAT */
> > +    if (!(env->psw.mask & PSW_MASK_DAT)) {
> > +        program_interrupt(env, PGM_SPECIAL_OP, 2);
> 
> Length of the opcode is 6 bytes, not 2.

True. Sorry, I don't know where 2 came from. It does not make sense.

> > +    }
> > +
> > +    /* access control for the first operand */
> > +    abit1 = (r0 & 0x0010000ULL) >> 16;
> > +    kbit1 = (r0 & 0x0020000ULL) >> 17;
> > +    as1 = (r0 & 0x00c00000ULL) >> 22;
> > +    key1 = (r0 & 0xf0000000ULL) >> 28;
> > +
> > +    if (!kbit1) {
> > +        key1 = (env->psw.mask & PSW_MASK_KEY) >> (PSW_SHIFT_KEY - 4);
> 
> I wonder whether it would make sense to define PSW_SHIFT_KEY directly to
> 52 instead ... I can't see the reason for 56 here. The only other spot
> that uses it also subtracts 4.

Right, I'll make a patch to change that.

> > +    }
> > +
> > +    if (!abit1) {
> > +        as1 = (env->psw.mask & PSW_MASK_ASC) >> 46;
> > +    }
> > +
> > +    /*
> > +     * abit1 is set, as1 designates the home-space mode, psw is in the problem
> > +     * state.
> > +     * */
> 
> Cosmetic nit: Make the closing comment just "*/" instead of "* */".

Oh, sure.
 
> > +    if (abit1 && (as1 == 3) && (env->psw.mask & PSW_MASK_PSTATE)) {
> > +        program_interrupt(env, PGM_SPECIAL_OP, 2);
> 
> set instruction length = 6 again
> 
> > +    }
> > +
> > +    /* access control for the second operand */
> > +    abit2 = (r0 & 0x0010000ULL);
> > +    kbit2 = (r0 & 0x0020000ULL) >> 1;
> > +    as2 = (r0 & 0x00c00000ULL) >> 6;
> > +    key2 = (r0 & 0xf0000000ULL) >> 12;
> 
> The above four lines look wrong ... are you sure that you've got the
> masks right? If I read the POP correctly, the values should be in the
> lowest two bytes instead?

You're right. Stupid copy-paste error, I only changed shift constants. 
Sorry for that.

> > +    if (!kbit2) {
> > +        key2 = (env->psw.mask & PSW_MASK_KEY) >> (PSW_SHIFT_KEY - 4);
> > +    }
> > +
> > +    if (!abit2) {
> > +        as2 = (env->psw.mask & PSW_MASK_ASC) >> 46;
> > +    }
> > +
> > +    /*
> > +     * Secondary-space control bit is zero (bit 37 of r0) and either as
> > +     * designates secondary-space mode.
> > +     */
> > +    if (!(r0 & 0x2000000000ULL) && (as1 == 2 || as2 == 2)) {
> 
> You mixed up "control register 0" with "general purpose register 0"
> here, i.e. you must not use r0 but rather env->cregs[0] here.

Correct. Will fix it.

> > +        program_interrupt(env, PGM_SPECIAL_OP, 2);
> 
> s/2/6/
> 
> > +    }
> > +
> > +    /* psw is in the problem state and either key is invalid */
> > +    if ((env->psw.mask & PSW_MASK_PSTATE) &&
> > +        (!(env->cregs[3] & (1 << (31 - key1))) ||
> > +         !(env->cregs[3] & (1 << (31 - key2))))) {
> > +        program_interrupt(env, PGM_PRIVILEGED, 2);
> 
> s/2/6/
> 
> > +    }
> > +
> > +    if (len <= 4096) {
> > +        cc = 0;
> > +    } else {
> > +        cc = 3;
> > +        len = 4096;
> > +    }
> > +
> > +    /* move */
> > +    /* XXX use keys and as during the move */
> > +    fast_memmove(env, dest, src, len);
> > +
> > +    return cc;
> > +}
> > +
> >  /* invalidate pte */
> >  void HELPER(ipte)(CPUS390XState *env, uint64_t pte_addr, uint64_t vaddr)
> >  {
> > diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> > index 01c62176bf70..ac90b758d312 100644
> > --- a/target/s390x/translate.c
> > +++ b/target/s390x/translate.c
> > @@ -1194,6 +1194,7 @@ typedef enum DisasFacility {
> >      FAC_SCF,                /* store clock fast */
> >      FAC_SFLE,               /* store facility list extended */
> >      FAC_ILA,                /* interlocked access facility 1 */
> > +    FAC_MVCOS,              /* move-with-optional-specification */
> >  } DisasFacility;
> >  
> >  struct DisasInsn {
> > @@ -2877,6 +2878,17 @@ static ExitStatus op_mvcs(DisasContext *s, DisasOps *o)
> >      set_cc_static(s);
> >      return NO_EXIT;
> >  }
> > +
> > +static ExitStatus op_mvcos(DisasContext *s, DisasOps *o)
> > +{
> > +    int r3 = get_field(s->fields, r3);
> > +
> > +    check_privileged(s);
> 
> I think it is possible to use this instruction in PRoblem state, so the
> general check_privileged() check seems to be wrong here. The instruction
> only generates a PRIVILEGE exception if the keys are invalid.

Ok.

Thanks for the feedback! I'm new to qemu, so everything is more than 
useful.

Miroslav
