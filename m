Received: from eggs.gnu.org ([2001:4830:134:3::10]:60194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mbenes@suse.cz>) id 1dKh1s-0006v0-78
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mbenes@suse.cz>) id 1dKh1n-0007Hu-4A
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:18:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39577 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mbenes@suse.cz>) id 1dKh1m-0007H5-P9
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:18:19 -0400
Date: Tue, 13 Jun 2017 10:18:13 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
In-Reply-To: <a2a007b2-3472-ad4a-bf10-a043a1d6b7cf@redhat.com>
Message-ID: <alpine.LSU.2.20.1706131015030.29266@pobox.suse.cz>
References: <20170228131710.10593-1-mbenes@suse.cz>
	<e30b5e57-82a0-d030-6be0-1b78492ada0e@redhat.com>
	<alpine.LSU.2.20.1703011310200.5005@pobox.suse.cz>
	<faddb81d-8fe2-bb67-ce85-5b6ca321fc14@redhat.com>
	<a2a007b2-3472-ad4a-bf10-a043a1d6b7cf@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, ebischoff@suse.com, mmarek@suse.com, agraf@suse.de, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>

On Mon, 12 Jun 2017, David Hildenbrand wrote:

> On 12.06.2017 18:44, Thomas Huth wrote:
> > On 01.03.2017 13:19, Miroslav Benes wrote:
> >> On Wed, 1 Mar 2017, Thomas Huth wrote:
> >>
> >>> On 28.02.2017 14:17, Miroslav Benes wrote:
> >>>> Implement MVCOS instruction, which the Linux kernel uses in user access
> >>>> functions.
> >>>>
> >>>> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> >>>> ---
> >>>> I tried to do my best to follow the specification but it is quite
> >>>> possible that I got something wrong because of my lack of
> >>>> understanding. Especially I am not sure about all those bit ops :/.
> >>>>
> >>>> Anyway, there is one piece missing. The actual use of keys and
> >>>> address-space-control during the move. I used fast_memmove, but
> >>>> it is not correct. Is there a helper which I could use? I looked at
> >>>> other instructions which should implement access control, but there were
> >>>> silently ignore it :).
> >>>
> >>> I'm not aware of a function that could deal with two address spaces
> >>> already (but that does not mean that there is no such function already)
> >>> ... still, I guess, you likely need to write your own memmove helper
> >>> function that can deal with two different address spaces.
> >>
> >> Ok, I thought that was the case. I'll try to come up with something.
> >>  
> >>>>  target/s390x/helper.h      |  1 +
> >>>>  target/s390x/insn-data.def |  2 ++
> >>>>  target/s390x/mem_helper.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++++
> >>>>  target/s390x/translate.c   | 12 +++++++
> >>>>  4 files changed, 95 insertions(+)
> >>>>
> >>>> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> >>>> index 9102071d0aa4..bc5dfccc3d7e 100644
> >>>> --- a/target/s390x/helper.h
> >>>> +++ b/target/s390x/helper.h
> >>>> @@ -104,6 +104,7 @@ DEF_HELPER_FLAGS_2(iske, TCG_CALL_NO_RWG_SE, i64, env, i64)
> >>>>  DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
> >>>>  DEF_HELPER_FLAGS_2(rrbe, TCG_CALL_NO_RWG, i32, env, i64)
> >>>>  DEF_HELPER_3(csp, i32, env, i32, i64)
> >>>> +DEF_HELPER_5(mvcos, i32, env, i64, i64, i64, i64)
> >>>>  DEF_HELPER_4(mvcs, i32, env, i64, i64, i64)
> >>>>  DEF_HELPER_4(mvcp, i32, env, i64, i64, i64)
> >>>>  DEF_HELPER_4(sigp, i32, env, i64, i32, i64)
> >>>> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> >>>> index 075ff597c3de..a1e6d735d090 100644
> >>>> --- a/target/s390x/insn-data.def
> >>>> +++ b/target/s390x/insn-data.def
> >>>> @@ -854,6 +854,8 @@
> >>>>  /* LOAD USING REAL ADDRESS */
> >>>>      C(0xb24b, LURA,    RRE,   Z,   0, r2, new, r1_32, lura, 0)
> >>>>      C(0xb905, LURAG,   RRE,   Z,   0, r2, r1, 0, lurag, 0)
> >>>> +/* MOVE WITH OPTIONAL SPECIFICATION */
> >>>> +    C(0xc800, MVCOS,   SSF,   MVCOS, la1, a2, 0, 0, mvcos, 0)
> >>>>  /* MOVE TO PRIMARY */
> >>>>      C(0xda00, MVCP,    SS_d,  Z,   la1, a2, 0, 0, mvcp, 0)
> >>>>  /* MOVE TO SECONDARY */
> >>>> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> >>>> index 675aba2e44d4..ca8f7c49250c 100644
> >>>> --- a/target/s390x/mem_helper.c
> >>>> +++ b/target/s390x/mem_helper.c
> >>>> @@ -1089,6 +1089,86 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
> >>>>      return cc;
> >>>>  }
> >>>>  
> >>>> +uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t r0, uint64_t dest,
> >>>> +                       uint64_t src, uint64_t len)
> >>>> +{
> >>>> +    int cc;
> >>>> +    int key1, as1, abit1, kbit1;
> >>>> +    int key2, as2, abit2, kbit2;
> >>>> +
> >>>> +    HELPER_LOG("%s dest %" PRIx64 ", src %" PRIx64 ", len %" PRIx64 "\n",
> >>>> +               __func__, dest, src, len);
> >>>> +
> >>>> +    /* check DAT */
> >>>> +    if (!(env->psw.mask & PSW_MASK_DAT)) {
> >>>> +        program_interrupt(env, PGM_SPECIAL_OP, 2);
> >>>
> >>> Length of the opcode is 6 bytes, not 2.
> >>
> >> True. Sorry, I don't know where 2 came from. It does not make sense.
> > 
> > As I recently had to learn it the hard way (while implementing the TEST
> > BLOCK instruction), you should use ILEN_LATER_INC here instead of 2 (or
> > 6), since the Special operation exception is suppressing, too, i.e. the
> > program counter should be increased afterwards to the next instruction.
> > 
> 
> This is no longer needed with
> https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg02631.html
> 
> You can either use 6 or ILEN_AUTO here, suppression will be handled
> internally.

ok, good to know.
 
> > BTW, are you still working on a new version of this patch?

Unfortunately, I haven't touched it since the submission. It is only a 
side project at work and I only started reading about s390x address spaces 
to implement a proper memmove helper. No implementation yet so far :/

So if anyone wants to work on this, they can of course take my patch as a 
basis.

Thanks,
Miroslav
