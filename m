Received: from eggs.gnu.org ([2001:4830:134:3::10]:37647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fWvQ4-0002jM-VY
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fWvQ3-0001vO-QT
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:10:28 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:41120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fWvQ3-0001uY-4g
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:10:27 -0400
Received: by mail-vk0-x241.google.com with SMTP id j11-v6so732404vke.8
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 20:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-13-richard.henderson@linaro.org>
	<20180622064043.GE24595@lianli.shorne-pla.net>
In-Reply-To: <20180622064043.GE24595@lianli.shorne-pla.net>
From: Stafford Horne <shorne@gmail.com>
Date: Sun, 24 Jun 2018 12:10:15 +0900
Message-ID: <CAAfxs747sr6Mx1fi1wTZ2wnZZ8Z-38gW3d_4+P_Z2NKJ+kVH+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 12/22] target/openrisc: Fix tlb flushing
 in mtspr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

On Fri, Jun 22, 2018 at 3:40 PM Stafford Horne <shorne@gmail.com> wrote:
>
> On Mon, Jun 18, 2018 at 08:40:36AM -1000, Richard Henderson wrote:
> > The previous code was confused, avoiding the flush of the old entry
> > if the new entry is invalid.  We need to flush the old page if the
> > old entry is valid and the new page if the new entry is valid.
> >
> > This bug was masked by over-flushing elsewhere.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/openrisc/sys_helper.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> > index 8ad7a7d898..e00aaa332e 100644
> > --- a/target/openrisc/sys_helper.c
> > +++ b/target/openrisc/sys_helper.c
> > @@ -32,6 +32,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
> >  #ifndef CONFIG_USER_ONLY
> >      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
> >      CPUState *cs = CPU(cpu);
> > +    target_ulong mr;
> >      int idx;
> >
> >      switch (spr) {
> > @@ -84,12 +85,15 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
> >
> >      case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
> >          idx = spr - TO_SPR(1, 512);
> > -        if (!(rb & 1)) {
> > -            tlb_flush_page(cs, env->tlb.dtlb[idx].mr & TARGET_PAGE_MASK);
> > +        mr = env->tlb.dtlb[idx].mr;
> > +        if (mr & 1) {
> > +            tlb_flush_page(cs, mr & TARGET_PAGE_MASK);
> > +        }
> > +        if (rb & 1) {
> > +            tlb_flush_page(cs, rb & TARGET_PAGE_MASK);
>
> Hi Richard,
>
> On openrisc we write 0 to the TLB SPR to flush the old entry out of the TLB, I
> don't see much documentation on this, but this is what is done in the kernel.
> This patch is causing the linux kernel to not boot.
>
> I thought flush is to get rid of the old mapping from the tlb, if we need to do
> it for new mappings too should we do.  Why do we need to flush new mappings?
>
>     /* flush old page if it was valid or we are invalidating */
>     if ((mr & 1) || !(rb & 1)) {
>         tlb_flush_page(cs, mr & TARGET_PAGE_MASK);
>     }
>     /* flush new page if its being entered into tlb */
>     if (rb & 1) {
>         tlb_flush_page(cs, rb & TARGET_PAGE_MASK);
>     }
>
> I didn't write the original code, but I think it was right as is.
>

Ignore this for now your code makes more sense, maybe we don't need to
flush the new page though?  This is causing a failure but something
more interesting is failing with the next patch "target/openrisc: Fix
cpu_mmu_index".

-Stafford
