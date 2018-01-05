Received: from eggs.gnu.org ([2001:4830:134:3::10]:37628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eXLqO-0001xm-13
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eXLqM-0006cO-RT
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:51:08 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eXLqM-0006bh-HH
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:51:06 -0500
Received: by mail-oi0-x241.google.com with SMTP id t81so2559839oih.13
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 22:51:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9831f4cc-c5ad-a43d-d677-8773f9f7b63e@linaro.org>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-11-git-send-email-mjc@sifive.com>
	<9831f4cc-c5ad-a43d-d677-8773f9f7b63e@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 5 Jan 2018 19:51:05 +1300
Message-ID: <CAHNT7Ns5E0KYMX1BQcmAuZRgjK+cP5x-03o=ed2hm_OT+D9FGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 10/21] RISC-V Linux User Emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Thu, Jan 4, 2018 at 12:47 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 01/02/2018 04:44 PM, Michael Clark wrote:
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index 20f3d8c..178af56 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -1272,6 +1272,28 @@ static inline void init_thread(struct
> target_pt_regs *regs,
> >
> >  #endif /* TARGET_TILEGX */
> >
> > +#ifdef TARGET_RISCV
> > +
> > +#define ELF_START_MMAP 0x80000000
>
> For riscv64 too?  Surely closer to ((TASK_SIZE / 3) * 2).
>
> > diff --git a/linux-user/main.c b/linux-user/main.c
> > index 71696ed..8900141 100644
> > --- a/linux-user/main.c
> > +++ b/linux-user/main.c
> > @@ -227,7 +227,7 @@ void cpu_loop(CPUX86State *env)
> >          cpu_exec_end(cs);
> >          process_queued_cpu_work(cs);
> >
> > -        switch(trapnr) {
> > +        switch (trapnr) {
>
> Even though the formatting is wrong, don't change unrelated code.


I didn't intend for this to happen. False assumption that only the RISC-V
code was broken. Will attend to this in the next spin.


> > +        case EXCP_DEBUG:
> > +        gdbstep:
> > +            signum = gdb_handlesig(cs, TARGET_SIGTRAP);
> > +            sigcode = TARGET_TRAP_BRKPT;
> > +            break;
> > +        default:
> > +            EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x -
> aborting\n",
> > +                     trapnr);
> > +            exit(EXIT_FAILURE);
>
> You will need to handle the generic EXCP_ATOMIC as well.
> Though of course you won't see that until you use tcg_gen_atomic_*.
>
