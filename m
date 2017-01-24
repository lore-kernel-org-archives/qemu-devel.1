Received: from eggs.gnu.org ([2001:4830:134:3::10]:53145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cVyJ7-0004SL-FL
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cVyJ4-00063U-QA
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:26:33 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cVyJ4-00063A-Hn
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:26:30 -0500
Received: by mail-pf0-x242.google.com with SMTP id e4so11917774pfg.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 02:26:28 -0800 (PST)
Date: Tue, 24 Jan 2017 19:26:25 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170124102625.GF7836@lianli.shorne-pla.net>
References: <20170113215720.29598-1-shorne@gmail.com>
	<20170113220252.GE25986@lianli.shorne-pla.net>
	<CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
	<20170114080435.GF25986@lianli.shorne-pla.net>
	<20170120163918.GD7836@lianli.shorne-pla.net>
	<d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org, openrisc@lists.librecores.org

On Mon, Jan 23, 2017 at 10:08:47AM -0800, Richard Henderson wrote:
> On 01/20/2017 08:39 AM, Stafford Horne wrote:
> > (+CC Rth)
> > 
> > I believe you also have some experience with openrisc.  Any thought on
> > the below?
> > 
> > On Sat, Jan 14, 2017 at 05:04:35PM +0900, Stafford Horne wrote:
> >> Hello,
> >>
> >> On Sat, Jan 14, 2017 at 12:29:32PM +0800, Jia Liu wrote:
> >>> Hi all,
> >>>
> >>> On Sat, Jan 14, 2017 at 6:02 AM, Stafford Horne <shorne@gmail.com> wrote:
> >>>> Hello,
> >>>>
> >>>> Sorry for the duplicate. There was an issue with my copy to qemu-devel
> >>>> group.  Resent to everyone with proper cc to qemu-devel.
> >>>>
> >>>> Please ignore this one.
> >>>>
> >>>> -Stafford
> >>>>
> >>>> On Sat, Jan 14, 2017 at 06:57:20AM +0900, Stafford Horne wrote:
> >>>>> I am working on testing instruction emulation patches for the linux
> >>>>> kernel. During testing I found these 2 issues:
> >>>>>
> >>>>>  - sets DSX (delay slot exception) but never clears it
> >>>>>  - EEAR for illegal insns should point to the bad exception (as per
> >>>>>    openrisc spec) but its not
> >>>>>
> >>>>> This patch fixes these two issues by clearing the DSX flag when not in a
> >>>>> delay slot and by setting EEAR to exception PC when handling illegal
> >>>>> instruction exceptions.
> >>>>>
> >>>>> After this patch the openrisc kernel with latest patches boots great on
> >>>>> qemu and instruction emulation works.
> >>>>>
> >>>>> Cc: qemu-trivial@nongnu.org
> >>>>> Cc: openrisc@lists.librecores.org
> >>>>> Signed-off-by: Stafford Horne <shorne@gmail.com>
> >>>>> ---
> >>>>>  target/openrisc/interrupt.c | 7 +++++++
> >>>>>  1 file changed, 7 insertions(+)
> >>>>>
> >>>>> diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> >>>>> index 5fe3f11..e1b0142 100644
> >>>>> --- a/target/openrisc/interrupt.c
> >>>>> +++ b/target/openrisc/interrupt.c
> >>>>> @@ -38,10 +38,17 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
> >>>>>          env->flags &= ~D_FLAG;
> >>>>>          env->sr |= SR_DSX;
> >>>>>          env->epcr -= 4;
> >>>>> +    } else {
> >>>>> +        env->sr &= ~SR_DSX;
> >>>>>      }
> >>>>>      if (cs->exception_index == EXCP_SYSCALL) {
> >>>>>          env->epcr += 4;
> >>>>>      }
> >>>>> +    /* When we have an illegal instruction the error effective address
> >>>>> +       shall be set to the illegal instruction address.  */
> >>>>> +    if (cs->exception_index == EXCP_ILLEGAL) {
> >>>>> +        env->eear = env->pc;
> >>>>> +    }
> >>>>>
> >>>>>      /* For machine-state changed between user-mode and supervisor mode,
> >>>>>         we need flush TLB when we enter&exit EXCP.  */
> 
> This patch seems sane, and I'm fine with it.  That said, I don't know what
> "latest patches" means, and was not able to find a kernel version that works.

Hi Richard,

By "latest patches", I mean the ones I posted to the lkml [1] earlier
this month and are now in linux-next.  These have actually been sitting
in the openrisc repo [2] for much longer than that though. The patches
that depend on l.swa and l.lwa (all of the atomic ones) depend on the
hardware (or emulator) being able to either:
 1. Support the l.swa/l.lwa instructions
 2. Support illegal instructions, used by emulation in patch 06/22 [3]

Qemu seems to have issues with both of these right now.  This patch will
help support illegal instructions properly.

If you are having problems booting, both mainline (4.10-rc5) and
linux-next (i.e. next-201701124) should be able to boot. i.e.

  export ARCH=openrisc
  make defconfig   # defconfig works fine on qemu

  # make any updates to CONFIG_CROSS_COMPILE needed
  make

  # start qemu
  qemu-system-or32  -cpu or1200 -M or32-sim -kernel $LINUX/vmlinux \
   -serial stdio -nographic -monitor none

I just ran those commands with linu-next and my qemu patches and the
kernel can boot, but note fails to find init due to config missing
initramfs, which I figure you know thats expected.

Let me know what you tried and what problem you are having.

> >>> +static void gen_swa(DisasContext *dc, TCGv rb, TCGv ra, int32_t ofs)
> >>> +{
> >>> +    TCGv ea, val;
> >>> +    TCGLabel *lab_fail, *lab_done;
> >>> +
> >>> +    ea = tcg_temp_new();
> >>> +    tcg_gen_addi_tl(ea, ra, ofs);
> >>> +
> >>> +    lab_fail = gen_new_label();
> >>> +    lab_done = gen_new_label();
> >>> +    tcg_gen_brcond_tl(TCG_COND_NE, ea, cpu_lock_addr, lab_fail);
> >>> +    tcg_temp_free(ea);
> >>> +
> >>> +    val = tcg_temp_new();
> >>> +    tcg_gen_qemu_ld_tl(val, cpu_lock_addr, dc->mem_idx, MO_TEUL);
> >>> +    tcg_gen_brcond_tl(TCG_COND_NE, val, cpu_lock_value, lab_fail);
> >>> +
> >>> +    tcg_gen_qemu_st_tl(rb, cpu_lock_addr, dc->mem_idx, MO_TEUL);
> >>> +    tcg_gen_movi_i32(env_btaken, 0x1);
> >>> +    tcg_gen_br(lab_done);
> >>> +
> >>> +    gen_set_label(lab_fail);
> >>> +    tcg_gen_movi_i32(env_btaken, 0x0);
> >>> +
> >>> +    gen_set_label(lab_done);
> >>> +    tcg_gen_movi_tl(cpu_lock_addr, -1);
> >>> +}
> 
> This one needs to be updated to work with the atomic operations now present in
> TCG.  See target/alpha/translate.c, gen_store_conditional among the many examples.

I haven't looked into this patch.  I am thinking I can look at it when I
try to upstream the openrisc linux SMP patches which are sitting in the
openrisc/linux repo too.

Thanks for reviewing

-Stafford

[1] https://lkml.org/lkml/2017/1/14/263
[2] https://github.com/openrisc/linux
[3] https://lkml.org/lkml/2017/1/14/265
