Received: from eggs.gnu.org ([2001:4830:134:3::10]:49992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrewoates@gmail.com>) id 1fqj70-0004ct-Ke
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrewoates@gmail.com>) id 1fqj6w-0006VP-F4
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:04:38 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:41797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrewoates@gmail.com>)
	id 1fqj6w-0006V6-9y
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:04:34 -0400
Received: by mail-ua1-f44.google.com with SMTP id h1-v6so6212786uao.8
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 11:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180816011903.39816-1-andrew@andrewoates.com>
	<b45d87b9-38ac-427a-8622-ac9c49350511@redhat.com>
In-Reply-To: <b45d87b9-38ac-427a-8622-ac9c49350511@redhat.com>
From: Andrew Oates <andrew@andrewoates.com>
Date: Fri, 17 Aug 2018 14:04:22 -0400
Message-ID: <CAAVLcG6m_x2p4r9dqD6B2qG-Z_G_iTh5rAubS44PRM2-Mqnpkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target-i386: fix segment limit check in
 ljmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, Andrew Oates <aoates@google.com>

On Fri, Aug 17, 2018 at 1:38 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 16/08/2018 03:19, andrew@andrewoates.com wrote:
> > From: Andrew Oates <aoates@google.com>
> >
> > The current implementation has three bugs,
> >  * segment limits are not enforced in protected mode if the L bit is set
> >    in the target segment descriptor[1]
> >  * segment limits are not enforced in compatability mode (ljmp to 32-bit
> >    code segment in long mode)
> >  * #GP(new_cs) is generated rather than #GP(0)
> >
> > Now the segment limits are enforced if we're not in long mode OR the
> > target code segment doesn't have the L bit set.
> >
> > [1] this is an invalid configuration (in protected mode the L bit is
> > reserved and should be set to zero), but qemu doesn't enforce that.
>
> Stupid question, why not fix that instead at least for this case?
>

I suppose we could check for that here, sure.  I was thinking we'd want to
check for that when the segment descriptor was actually loaded, but now
that I think about it there isn't a central place to do that other than in
the lgdt and lldt instructions.

Is there a central place to do that sort of validation?  We could do it in
load_segment_ra, but that doesn't feel quite right.  Otherwise it's
whack-a-mole to check validity at every place a code segment is
referenced---but maybe that's ok, there probably aren't too many of them.

WDYT?


>
> > Signed-off-by: Andrew Oates <aoates@google.com>
> > ---
> > The limit check is still incorrect for ljmp-through-call-gate in 64-bit
> > mode.  That's a larger fix I'm still working on.
>
> Can you resend the call-gate for both ljmp and lcall when you're done
> (there's plenty of time until 3.1)?
>

Yeah, absolutely, just want to do some more testing on it to make sure it
covers all the corner cases correctly.


>
> Thanks,
>
> Paolo
>
> >  target/i386/seg_helper.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
> > index 00301a0c04..975365fd30 100644
> > --- a/target/i386/seg_helper.c
> > +++ b/target/i386/seg_helper.c
> > @@ -1628,8 +1628,8 @@ void helper_ljmp_protected(CPUX86State *env, int
> new_cs, target_ulong new_eip,
> >          }
> >          limit = get_seg_limit(e1, e2);
> >          if (new_eip > limit &&
> > -            !(env->hflags & HF_LMA_MASK) && !(e2 & DESC_L_MASK)) {
> > -            raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc,
> GETPC());
> > +            (!(env->hflags & HF_LMA_MASK) || !(e2 & DESC_L_MASK))) {
> > +            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
> >          }
> >          cpu_x86_load_seg_cache(env, R_CS, (new_cs & 0xfffc) | cpl,
> >                         get_seg_base(e1, e2), limit, e2);
> >
>
>
