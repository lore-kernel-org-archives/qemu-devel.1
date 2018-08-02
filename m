Received: from eggs.gnu.org ([2001:4830:134:3::10]:39610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fl5B4-0003r1-AG
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 00:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fl5B2-0002tc-RP
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 00:25:30 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:35428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fl5B2-0002s0-AB
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 00:25:28 -0400
Received: by mail-oi0-x236.google.com with SMTP id m11-v6so1612648oic.2
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 21:25:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <24c01558-7352-74a6-31b8-9a495aa9fc13@amsat.org>
References: <9cd33f65-c0df-637c-4d7e-90c8c4227216@amsat.org>
	<20180731104059.55s76c2ent772z4b@toto>
	<24c01558-7352-74a6-31b8-9a495aa9fc13@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 2 Aug 2018 16:25:26 +1200
Message-ID: <CAHNT7Nv_1JjzUT+go-9b_7jZ0H4K6g_uy8CbGdUa=tRZVCvyjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] microblaze build failure due to definition clash
 on riscv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <alistair23@gmail.com>

On Thu, Aug 2, 2018 at 3:57 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Oops I just realized I forgot to Cc the QEMU list, doing it now.
>
> On 07/31/2018 07:40 AM, Edgar E. Iglesias wrote:
> > On Mon, Jul 30, 2018 at 03:22:46PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> Hi, I'm getting this error while building microblaze on riscv host:
> >>
> >>   ...
> >>   CC      disas/microblaze.o
> >> disas/microblaze.c:179:0: error: "REG_SP" redefined [-Werror]
> >>
> >>  #define REG_SP  1 /* stack pointer */
> >>
> >> In file included from /usr/include/signal.h:306:0,
> >>                  from include/qemu/osdep.h:101,
> >>                  from disas/microblaze.c:36:
> >> /usr/include/sys/ucontext.h:36:0: note: this is the location of the
> >> previous definition
> >>  # define REG_SP 2
> >>
> >> cc1: all warnings being treated as errors
> >> make: *** [rules.mak:69: disas/microblaze.o] Error 1
> >>
> >>
> >> Having /usr/include/sys/ucontext.h:
> >>
> >>      31 #ifdef __USE_MISC
> >>      32 # define NGREG  32
> >>      33
> >>      34 # define REG_PC 0
> >>      35 # define REG_RA 1
> >>      36 # define REG_SP 2
> >>      37 # define REG_TP 4
> >>      38 # define REG_S0 8
> >>      39 # define REG_S1 9
> >>      40 # define REG_A0 10
> >>      41 # define REG_S2 18
> >>      42 # define REG_NARGS 8
> >>
> >> Edgar is it OK to rename REG_* -> MB_REG_*?
> >
> > Yes, no problems with me!
> >
> > Allthough it doesn't seem to be a good idea to have such generic names
> in riscv system header files.
>
> OK this might be a Linux problem indeed, maybe this file lacks some
> #ifdef __riscv (previous to the __USE_MISC?).
>
> I'll wait for the riscv folks before to send a dumb rename patch.
>

It seems to be a generic Linux problem or perhaps even a microblaze problem
in this case, where QEMU microblaze definitions just happen to clash with
system definitions. It depends on which way around you look at the problem.

x86_64 has REG_R8, REG_R9, REG_R10, etc so RISC-V is just following the
Linux scheme.

Indeed RISC-V in QEMU unlike microblaze has this in disas/riscv.c

typedef enum {
    rv_ireg_zero,
    rv_ireg_ra,
    rv_ireg_sp,
    rv_ireg_gp,
    rv_ireg_tp,
    rv_ireg_t0,
    rv_ireg_t1,
    rv_ireg_t2,
    rv_ireg_s0,
    rv_ireg_s1,
    rv_ireg_a0,
    rv_ireg_a1,
    rv_ireg_a2,
    rv_ireg_a3,
    rv_ireg_a4,
    rv_ireg_a5,
    rv_ireg_a6,
    rv_ireg_a7,
    rv_ireg_s2,
    rv_ireg_s3,
    rv_ireg_s4,
    rv_ireg_s5,
    rv_ireg_s6,
    rv_ireg_s7,
    rv_ireg_s8,
    rv_ireg_s9,
    rv_ireg_s10,
    rv_ireg_s11,
    rv_ireg_t3,
    rv_ireg_t4,
    rv_ireg_t5,
    rv_ireg_t6,
} rv_ireg;

So from that perspective, one could suggest to change microblaze. It will
be a lot harder to change glibc given it is already baked into a large
number of binary images, and they are system headers.

Prefixing the definitions inside the mircoblaze disassembler would cause
the least havoc. Changing system headers in glibc will take a long time to
propagate via the current distros.
