Received: from eggs.gnu.org ([2001:4830:134:3::10]:50507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fESDX-0005I0-5b
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fESDR-0006iD-Tu
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:21:11 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:45699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fESDR-0006i5-I0
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:21:05 -0400
Received: by mail-ot0-x241.google.com with SMTP id 15-v6so8289937otn.12
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 21:21:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPQbxEVNHSM7EC2NbkPfLoFy9cCJxGn9VCbxAKkf-3AtA@mail.gmail.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-27-git-send-email-mjc@sifive.com>
	<CAKmqyKPQbxEVNHSM7EC2NbkPfLoFy9cCJxGn9VCbxAKkf-3AtA@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 4 May 2018 16:21:04 +1200
Message-ID: <CAHNT7NumKh+ze_rd1zF4a2j8+CtjLBssApogW5A_KaPUSpKnkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 26/35] RISC-V: Update CSR and interrupt
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, RISC-V Patches <patches@groups.riscv.org>

On Fri, May 4, 2018 at 8:56 AM, Alistair Francis <alistair23@gmail.com>
wrote:

> On Wed, Apr 25, 2018 at 5:02 PM Michael Clark <mjc@sifive.com> wrote:
>
> > * Add user-mode CSR defininitions.
> > * Reorder CSR definitions to match the specification.
> > * Change H mode interrupt comment to 'reserved'.
> > * Remove unused X_COP interrupt.
> > * Add user-mode and core-level interrupts.
> > * Remove erroneous until comemnts on machine mode interrupts.
> > * Move together paging mode and page table bit definitions.
> > * Move together interrupt and exception cause definitions.
>
> > Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> > Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Alistair Francis <Alistair.Francis@wdc.com>
> > Signed-off-by: Michael Clark <mjc@sifive.com>
>
> I didn't check the values, but this looks sane.
>

The pre-existing values just have formatting changes to add titles and
group them consistently with the privileged specifiction.


> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>


Thanks.

Alistair
>
> > ---
> >   target/riscv/cpu_bits.h  | 692
> +++++++++++++++++++++++++----------------------
> >   target/riscv/op_helper.c |   4 +-
> >   2 files changed, 376 insertions(+), 320 deletions(-)
>
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 12b4757..878de62 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -6,242 +6,283 @@
> >                    (((target_ulong)(val) * ((mask) & ~((mask) << 1))) & \
> >                    (target_ulong)(mask)))
>
> > -#define PGSHIFT 12
> > -
> > -#define FSR_RD_SHIFT 5
> > -#define FSR_RD   (0x7 << FSR_RD_SHIFT)
> > -
> > -#define FPEXC_NX 0x01
> > -#define FPEXC_UF 0x02
> > -#define FPEXC_OF 0x04
> > -#define FPEXC_DZ 0x08
> > -#define FPEXC_NV 0x10
> > -
> > -#define FSR_AEXC_SHIFT 0
> > -#define FSR_NVA  (FPEXC_NV << FSR_AEXC_SHIFT)
> > -#define FSR_OFA  (FPEXC_OF << FSR_AEXC_SHIFT)
> > -#define FSR_UFA  (FPEXC_UF << FSR_AEXC_SHIFT)
> > -#define FSR_DZA  (FPEXC_DZ << FSR_AEXC_SHIFT)
> > -#define FSR_NXA  (FPEXC_NX << FSR_AEXC_SHIFT)
> > -#define FSR_AEXC (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR_NXA)
> > -
> > -/* CSR numbers */
> > -#define CSR_FFLAGS 0x1
> > -#define CSR_FRM 0x2
> > -#define CSR_FCSR 0x3
> > -#define CSR_CYCLE 0xc00
> > -#define CSR_TIME 0xc01
> > -#define CSR_INSTRET 0xc02
> > -#define CSR_HPMCOUNTER3 0xc03
> > -#define CSR_HPMCOUNTER4 0xc04
> > -#define CSR_HPMCOUNTER5 0xc05
> > -#define CSR_HPMCOUNTER6 0xc06
> > -#define CSR_HPMCOUNTER7 0xc07
> > -#define CSR_HPMCOUNTER8 0xc08
> > -#define CSR_HPMCOUNTER9 0xc09
> > -#define CSR_HPMCOUNTER10 0xc0a
> > -#define CSR_HPMCOUNTER11 0xc0b
> > -#define CSR_HPMCOUNTER12 0xc0c
> > -#define CSR_HPMCOUNTER13 0xc0d
> > -#define CSR_HPMCOUNTER14 0xc0e
> > -#define CSR_HPMCOUNTER15 0xc0f
> > -#define CSR_HPMCOUNTER16 0xc10
> > -#define CSR_HPMCOUNTER17 0xc11
> > -#define CSR_HPMCOUNTER18 0xc12
> > -#define CSR_HPMCOUNTER19 0xc13
> > -#define CSR_HPMCOUNTER20 0xc14
> > -#define CSR_HPMCOUNTER21 0xc15
> > -#define CSR_HPMCOUNTER22 0xc16
> > -#define CSR_HPMCOUNTER23 0xc17
> > -#define CSR_HPMCOUNTER24 0xc18
> > -#define CSR_HPMCOUNTER25 0xc19
> > -#define CSR_HPMCOUNTER26 0xc1a
> > -#define CSR_HPMCOUNTER27 0xc1b
> > -#define CSR_HPMCOUNTER28 0xc1c
> > -#define CSR_HPMCOUNTER29 0xc1d
> > -#define CSR_HPMCOUNTER30 0xc1e
> > -#define CSR_HPMCOUNTER31 0xc1f
> > -#define CSR_SSTATUS 0x100
> > -#define CSR_SIE 0x104
> > -#define CSR_STVEC 0x105
> > -#define CSR_SCOUNTEREN 0x106
> > -#define CSR_SSCRATCH 0x140
> > -#define CSR_SEPC 0x141
> > -#define CSR_SCAUSE 0x142
> > -#define CSR_SBADADDR 0x143
> > -#define CSR_SIP 0x144
> > -#define CSR_SPTBR 0x180
> > -#define CSR_SATP 0x180
> > -#define CSR_MSTATUS 0x300
> > -#define CSR_MISA 0x301
> > -#define CSR_MEDELEG 0x302
> > -#define CSR_MIDELEG 0x303
> > -#define CSR_MIE 0x304
> > -#define CSR_MTVEC 0x305
> > -#define CSR_MCOUNTEREN 0x306
> > -#define CSR_MSCRATCH 0x340
> > -#define CSR_MEPC 0x341
> > -#define CSR_MCAUSE 0x342
> > -#define CSR_MBADADDR 0x343
> > -#define CSR_MIP 0x344
> > -#define CSR_PMPCFG0 0x3a0
> > -#define CSR_PMPCFG1 0x3a1
> > -#define CSR_PMPCFG2 0x3a2
> > -#define CSR_PMPCFG3 0x3a3
> > -#define CSR_PMPADDR0 0x3b0
> > -#define CSR_PMPADDR1 0x3b1
> > -#define CSR_PMPADDR2 0x3b2
> > -#define CSR_PMPADDR3 0x3b3
> > -#define CSR_PMPADDR4 0x3b4
> > -#define CSR_PMPADDR5 0x3b5
> > -#define CSR_PMPADDR6 0x3b6
> > -#define CSR_PMPADDR7 0x3b7
> > -#define CSR_PMPADDR8 0x3b8
> > -#define CSR_PMPADDR9 0x3b9
> > -#define CSR_PMPADDR10 0x3ba
> > -#define CSR_PMPADDR11 0x3bb
> > -#define CSR_PMPADDR12 0x3bc
> > -#define CSR_PMPADDR13 0x3bd
> > -#define CSR_PMPADDR14 0x3be
> > -#define CSR_PMPADDR15 0x3bf
> > -#define CSR_TSELECT 0x7a0
> > -#define CSR_TDATA1 0x7a1
> > -#define CSR_TDATA2 0x7a2
> > -#define CSR_TDATA3 0x7a3
> > -#define CSR_DCSR 0x7b0
> > -#define CSR_DPC 0x7b1
> > -#define CSR_DSCRATCH 0x7b2
> > -#define CSR_MCYCLE 0xb00
> > -#define CSR_MINSTRET 0xb02
> > -#define CSR_MHPMCOUNTER3 0xb03
> > -#define CSR_MHPMCOUNTER4 0xb04
> > -#define CSR_MHPMCOUNTER5 0xb05
> > -#define CSR_MHPMCOUNTER6 0xb06
> > -#define CSR_MHPMCOUNTER7 0xb07
> > -#define CSR_MHPMCOUNTER8 0xb08
> > -#define CSR_MHPMCOUNTER9 0xb09
> > -#define CSR_MHPMCOUNTER10 0xb0a
> > -#define CSR_MHPMCOUNTER11 0xb0b
> > -#define CSR_MHPMCOUNTER12 0xb0c
> > -#define CSR_MHPMCOUNTER13 0xb0d
> > -#define CSR_MHPMCOUNTER14 0xb0e
> > -#define CSR_MHPMCOUNTER15 0xb0f
> > -#define CSR_MHPMCOUNTER16 0xb10
> > -#define CSR_MHPMCOUNTER17 0xb11
> > -#define CSR_MHPMCOUNTER18 0xb12
> > -#define CSR_MHPMCOUNTER19 0xb13
> > -#define CSR_MHPMCOUNTER20 0xb14
> > -#define CSR_MHPMCOUNTER21 0xb15
> > -#define CSR_MHPMCOUNTER22 0xb16
> > -#define CSR_MHPMCOUNTER23 0xb17
> > -#define CSR_MHPMCOUNTER24 0xb18
> > -#define CSR_MHPMCOUNTER25 0xb19
> > -#define CSR_MHPMCOUNTER26 0xb1a
> > -#define CSR_MHPMCOUNTER27 0xb1b
> > -#define CSR_MHPMCOUNTER28 0xb1c
> > -#define CSR_MHPMCOUNTER29 0xb1d
> > -#define CSR_MHPMCOUNTER30 0xb1e
> > -#define CSR_MHPMCOUNTER31 0xb1f
> > -#define CSR_MUCOUNTEREN 0x320
> > -#define CSR_MSCOUNTEREN 0x321
> > -#define CSR_MHPMEVENT3 0x323
> > -#define CSR_MHPMEVENT4 0x324
> > -#define CSR_MHPMEVENT5 0x325
> > -#define CSR_MHPMEVENT6 0x326
> > -#define CSR_MHPMEVENT7 0x327
> > -#define CSR_MHPMEVENT8 0x328
> > -#define CSR_MHPMEVENT9 0x329
> > -#define CSR_MHPMEVENT10 0x32a
> > -#define CSR_MHPMEVENT11 0x32b
> > -#define CSR_MHPMEVENT12 0x32c
> > -#define CSR_MHPMEVENT13 0x32d
> > -#define CSR_MHPMEVENT14 0x32e
> > -#define CSR_MHPMEVENT15 0x32f
> > -#define CSR_MHPMEVENT16 0x330
> > -#define CSR_MHPMEVENT17 0x331
> > -#define CSR_MHPMEVENT18 0x332
> > -#define CSR_MHPMEVENT19 0x333
> > -#define CSR_MHPMEVENT20 0x334
> > -#define CSR_MHPMEVENT21 0x335
> > -#define CSR_MHPMEVENT22 0x336
> > -#define CSR_MHPMEVENT23 0x337
> > -#define CSR_MHPMEVENT24 0x338
> > -#define CSR_MHPMEVENT25 0x339
> > -#define CSR_MHPMEVENT26 0x33a
> > -#define CSR_MHPMEVENT27 0x33b
> > -#define CSR_MHPMEVENT28 0x33c
> > -#define CSR_MHPMEVENT29 0x33d
> > -#define CSR_MHPMEVENT30 0x33e
> > -#define CSR_MHPMEVENT31 0x33f
> > -#define CSR_MVENDORID 0xf11
> > -#define CSR_MARCHID 0xf12
> > -#define CSR_MIMPID 0xf13
> > -#define CSR_MHARTID 0xf14
> > -#define CSR_CYCLEH 0xc80
> > -#define CSR_TIMEH 0xc81
> > -#define CSR_INSTRETH 0xc82
> > -#define CSR_HPMCOUNTER3H 0xc83
> > -#define CSR_HPMCOUNTER4H 0xc84
> > -#define CSR_HPMCOUNTER5H 0xc85
> > -#define CSR_HPMCOUNTER6H 0xc86
> > -#define CSR_HPMCOUNTER7H 0xc87
> > -#define CSR_HPMCOUNTER8H 0xc88
> > -#define CSR_HPMCOUNTER9H 0xc89
> > -#define CSR_HPMCOUNTER10H 0xc8a
> > -#define CSR_HPMCOUNTER11H 0xc8b
> > -#define CSR_HPMCOUNTER12H 0xc8c
> > -#define CSR_HPMCOUNTER13H 0xc8d
> > -#define CSR_HPMCOUNTER14H 0xc8e
> > -#define CSR_HPMCOUNTER15H 0xc8f
> > -#define CSR_HPMCOUNTER16H 0xc90
> > -#define CSR_HPMCOUNTER17H 0xc91
> > -#define CSR_HPMCOUNTER18H 0xc92
> > -#define CSR_HPMCOUNTER19H 0xc93
> > -#define CSR_HPMCOUNTER20H 0xc94
> > -#define CSR_HPMCOUNTER21H 0xc95
> > -#define CSR_HPMCOUNTER22H 0xc96
> > -#define CSR_HPMCOUNTER23H 0xc97
> > -#define CSR_HPMCOUNTER24H 0xc98
> > -#define CSR_HPMCOUNTER25H 0xc99
> > -#define CSR_HPMCOUNTER26H 0xc9a
> > -#define CSR_HPMCOUNTER27H 0xc9b
> > -#define CSR_HPMCOUNTER28H 0xc9c
> > -#define CSR_HPMCOUNTER29H 0xc9d
> > -#define CSR_HPMCOUNTER30H 0xc9e
> > -#define CSR_HPMCOUNTER31H 0xc9f
> > -#define CSR_MCYCLEH 0xb80
> > -#define CSR_MINSTRETH 0xb82
> > -#define CSR_MHPMCOUNTER3H 0xb83
> > -#define CSR_MHPMCOUNTER4H 0xb84
> > -#define CSR_MHPMCOUNTER5H 0xb85
> > -#define CSR_MHPMCOUNTER6H 0xb86
> > -#define CSR_MHPMCOUNTER7H 0xb87
> > -#define CSR_MHPMCOUNTER8H 0xb88
> > -#define CSR_MHPMCOUNTER9H 0xb89
> > -#define CSR_MHPMCOUNTER10H 0xb8a
> > -#define CSR_MHPMCOUNTER11H 0xb8b
> > -#define CSR_MHPMCOUNTER12H 0xb8c
> > -#define CSR_MHPMCOUNTER13H 0xb8d
> > -#define CSR_MHPMCOUNTER14H 0xb8e
> > -#define CSR_MHPMCOUNTER15H 0xb8f
> > -#define CSR_MHPMCOUNTER16H 0xb90
> > -#define CSR_MHPMCOUNTER17H 0xb91
> > -#define CSR_MHPMCOUNTER18H 0xb92
> > -#define CSR_MHPMCOUNTER19H 0xb93
> > -#define CSR_MHPMCOUNTER20H 0xb94
> > -#define CSR_MHPMCOUNTER21H 0xb95
> > -#define CSR_MHPMCOUNTER22H 0xb96
> > -#define CSR_MHPMCOUNTER23H 0xb97
> > -#define CSR_MHPMCOUNTER24H 0xb98
> > -#define CSR_MHPMCOUNTER25H 0xb99
> > -#define CSR_MHPMCOUNTER26H 0xb9a
> > -#define CSR_MHPMCOUNTER27H 0xb9b
> > -#define CSR_MHPMCOUNTER28H 0xb9c
> > -#define CSR_MHPMCOUNTER29H 0xb9d
> > -#define CSR_MHPMCOUNTER30H 0xb9e
> > -#define CSR_MHPMCOUNTER31H 0xb9f
> > -
> > -/* mstatus bits */
> > +/* Floating point round mode */
> > +#define FSR_RD_SHIFT        5
> > +#define FSR_RD              (0x7 << FSR_RD_SHIFT)
> > +
> > +/* Floating point accrued exception flags */
> > +#define FPEXC_NX            0x01
> > +#define FPEXC_UF            0x02
> > +#define FPEXC_OF            0x04
> > +#define FPEXC_DZ            0x08
> > +#define FPEXC_NV            0x10
> > +
> > +/* Floating point status register bits */
> > +#define FSR_AEXC_SHIFT      0
> > +#define FSR_NVA             (FPEXC_NV << FSR_AEXC_SHIFT)
> > +#define FSR_OFA             (FPEXC_OF << FSR_AEXC_SHIFT)
> > +#define FSR_UFA             (FPEXC_UF << FSR_AEXC_SHIFT)
> > +#define FSR_DZA             (FPEXC_DZ << FSR_AEXC_SHIFT)
> > +#define FSR_NXA             (FPEXC_NX << FSR_AEXC_SHIFT)
> > +#define FSR_AEXC            (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA |
> FSR_NXA)
> > +
> > +/* Control and Status Registers */
> > +
> > +/* User Trap Setup */
> > +#define CSR_USTATUS         0x000
> > +#define CSR_UIE             0x004
> > +#define CSR_UTVEC           0x005
> > +
> > +/* User Trap Handling */
> > +#define CSR_USCRATCH        0x040
> > +#define CSR_UEPC            0x041
> > +#define CSR_UCAUSE          0x042
> > +#define CSR_UTVAL           0x043
> > +#define CSR_UIP             0x044
> > +
> > +/* User Floating-Point CSRs */
> > +#define CSR_FFLAGS          0x001
> > +#define CSR_FRM             0x002
> > +#define CSR_FCSR            0x003
> > +
> > +/* User Timers and Counters */
> > +#define CSR_CYCLE           0xc00
> > +#define CSR_TIME            0xc01
> > +#define CSR_INSTRET         0xc02
> > +#define CSR_HPMCOUNTER3     0xc03
> > +#define CSR_HPMCOUNTER4     0xc04
> > +#define CSR_HPMCOUNTER5     0xc05
> > +#define CSR_HPMCOUNTER6     0xc06
> > +#define CSR_HPMCOUNTER7     0xc07
> > +#define CSR_HPMCOUNTER8     0xc08
> > +#define CSR_HPMCOUNTER9     0xc09
> > +#define CSR_HPMCOUNTER10    0xc0a
> > +#define CSR_HPMCOUNTER11    0xc0b
> > +#define CSR_HPMCOUNTER12    0xc0c
> > +#define CSR_HPMCOUNTER13    0xc0d
> > +#define CSR_HPMCOUNTER14    0xc0e
> > +#define CSR_HPMCOUNTER15    0xc0f
> > +#define CSR_HPMCOUNTER16    0xc10
> > +#define CSR_HPMCOUNTER17    0xc11
> > +#define CSR_HPMCOUNTER18    0xc12
> > +#define CSR_HPMCOUNTER19    0xc13
> > +#define CSR_HPMCOUNTER20    0xc14
> > +#define CSR_HPMCOUNTER21    0xc15
> > +#define CSR_HPMCOUNTER22    0xc16
> > +#define CSR_HPMCOUNTER23    0xc17
> > +#define CSR_HPMCOUNTER24    0xc18
> > +#define CSR_HPMCOUNTER25    0xc19
> > +#define CSR_HPMCOUNTER26    0xc1a
> > +#define CSR_HPMCOUNTER27    0xc1b
> > +#define CSR_HPMCOUNTER28    0xc1c
> > +#define CSR_HPMCOUNTER29    0xc1d
> > +#define CSR_HPMCOUNTER30    0xc1e
> > +#define CSR_HPMCOUNTER31    0xc1f
> > +#define CSR_CYCLEH          0xc80
> > +#define CSR_TIMEH           0xc81
> > +#define CSR_INSTRETH        0xc82
> > +#define CSR_HPMCOUNTER3H    0xc83
> > +#define CSR_HPMCOUNTER4H    0xc84
> > +#define CSR_HPMCOUNTER5H    0xc85
> > +#define CSR_HPMCOUNTER6H    0xc86
> > +#define CSR_HPMCOUNTER7H    0xc87
> > +#define CSR_HPMCOUNTER8H    0xc88
> > +#define CSR_HPMCOUNTER9H    0xc89
> > +#define CSR_HPMCOUNTER10H   0xc8a
> > +#define CSR_HPMCOUNTER11H   0xc8b
> > +#define CSR_HPMCOUNTER12H   0xc8c
> > +#define CSR_HPMCOUNTER13H   0xc8d
> > +#define CSR_HPMCOUNTER14H   0xc8e
> > +#define CSR_HPMCOUNTER15H   0xc8f
> > +#define CSR_HPMCOUNTER16H   0xc90
> > +#define CSR_HPMCOUNTER17H   0xc91
> > +#define CSR_HPMCOUNTER18H   0xc92
> > +#define CSR_HPMCOUNTER19H   0xc93
> > +#define CSR_HPMCOUNTER20H   0xc94
> > +#define CSR_HPMCOUNTER21H   0xc95
> > +#define CSR_HPMCOUNTER22H   0xc96
> > +#define CSR_HPMCOUNTER23H   0xc97
> > +#define CSR_HPMCOUNTER24H   0xc98
> > +#define CSR_HPMCOUNTER25H   0xc99
> > +#define CSR_HPMCOUNTER26H   0xc9a
> > +#define CSR_HPMCOUNTER27H   0xc9b
> > +#define CSR_HPMCOUNTER28H   0xc9c
> > +#define CSR_HPMCOUNTER29H   0xc9d
> > +#define CSR_HPMCOUNTER30H   0xc9e
> > +#define CSR_HPMCOUNTER31H   0xc9f
> > +
> > +/* Machine Timers and Counters */
> > +#define CSR_MCYCLE          0xb00
> > +#define CSR_MINSTRET        0xb02
> > +#define CSR_MCYCLEH         0xb80
> > +#define CSR_MINSTRETH       0xb82
> > +
> > +/* Machine Information Registers */
> > +#define CSR_MVENDORID       0xf11
> > +#define CSR_MARCHID         0xf12
> > +#define CSR_MIMPID          0xf13
> > +#define CSR_MHARTID         0xf14
> > +
> > +/* Machine Trap Setup */
> > +#define CSR_MSTATUS         0x300
> > +#define CSR_MISA            0x301
> > +#define CSR_MEDELEG         0x302
> > +#define CSR_MIDELEG         0x303
> > +#define CSR_MIE             0x304
> > +#define CSR_MTVEC           0x305
> > +#define CSR_MCOUNTEREN      0x306
> > +
> > +/* Legacy Counter Setup (priv v1.9.1) */
> > +#define CSR_MUCOUNTEREN     0x320
> > +#define CSR_MSCOUNTEREN     0x321
> > +
> > +/* Machine Trap Handling */
> > +#define CSR_MSCRATCH        0x340
> > +#define CSR_MEPC            0x341
> > +#define CSR_MCAUSE          0x342
> > +#define CSR_MBADADDR        0x343
> > +#define CSR_MIP             0x344
> > +
> > +/* Supervisor Trap Setup */
> > +#define CSR_SSTATUS         0x100
> > +#define CSR_SIE             0x104
> > +#define CSR_STVEC           0x105
> > +#define CSR_SCOUNTEREN      0x106
> > +
> > +/* Supervisor Trap Handling */
> > +#define CSR_SSCRATCH        0x140
> > +#define CSR_SEPC            0x141
> > +#define CSR_SCAUSE          0x142
> > +#define CSR_SBADADDR        0x143
> > +#define CSR_SIP             0x144
> > +
> > +/* Supervisor Protection and Translation */
> > +#define CSR_SPTBR           0x180
> > +#define CSR_SATP            0x180
> > +
> > +/* Physical Memory Protection */
> > +#define CSR_PMPCFG0         0x3a0
> > +#define CSR_PMPCFG1         0x3a1
> > +#define CSR_PMPCFG2         0x3a2
> > +#define CSR_PMPCFG3         0x3a3
> > +#define CSR_PMPADDR0        0x3b0
> > +#define CSR_PMPADDR1        0x3b1
> > +#define CSR_PMPADDR2        0x3b2
> > +#define CSR_PMPADDR3        0x3b3
> > +#define CSR_PMPADDR4        0x3b4
> > +#define CSR_PMPADDR5        0x3b5
> > +#define CSR_PMPADDR6        0x3b6
> > +#define CSR_PMPADDR7        0x3b7
> > +#define CSR_PMPADDR8        0x3b8
> > +#define CSR_PMPADDR9        0x3b9
> > +#define CSR_PMPADDR10       0x3ba
> > +#define CSR_PMPADDR11       0x3bb
> > +#define CSR_PMPADDR12       0x3bc
> > +#define CSR_PMPADDR13       0x3bd
> > +#define CSR_PMPADDR14       0x3be
> > +#define CSR_PMPADDR15       0x3bf
> > +
> > +/* Debug/Trace Registers (shared with Debug Mode) */
> > +#define CSR_TSELECT         0x7a0
> > +#define CSR_TDATA1          0x7a1
> > +#define CSR_TDATA2          0x7a2
> > +#define CSR_TDATA3          0x7a3
> > +
> > +/* Debug Mode Registers */
> > +#define CSR_DCSR            0x7b0
> > +#define CSR_DPC             0x7b1
> > +#define CSR_DSCRATCH        0x7b2
> > +
> > +/* Performance Counters */
> > +#define CSR_MHPMCOUNTER3    0xb03
> > +#define CSR_MHPMCOUNTER4    0xb04
> > +#define CSR_MHPMCOUNTER5    0xb05
> > +#define CSR_MHPMCOUNTER6    0xb06
> > +#define CSR_MHPMCOUNTER7    0xb07
> > +#define CSR_MHPMCOUNTER8    0xb08
> > +#define CSR_MHPMCOUNTER9    0xb09
> > +#define CSR_MHPMCOUNTER10   0xb0a
> > +#define CSR_MHPMCOUNTER11   0xb0b
> > +#define CSR_MHPMCOUNTER12   0xb0c
> > +#define CSR_MHPMCOUNTER13   0xb0d
> > +#define CSR_MHPMCOUNTER14   0xb0e
> > +#define CSR_MHPMCOUNTER15   0xb0f
> > +#define CSR_MHPMCOUNTER16   0xb10
> > +#define CSR_MHPMCOUNTER17   0xb11
> > +#define CSR_MHPMCOUNTER18   0xb12
> > +#define CSR_MHPMCOUNTER19   0xb13
> > +#define CSR_MHPMCOUNTER20   0xb14
> > +#define CSR_MHPMCOUNTER21   0xb15
> > +#define CSR_MHPMCOUNTER22   0xb16
> > +#define CSR_MHPMCOUNTER23   0xb17
> > +#define CSR_MHPMCOUNTER24   0xb18
> > +#define CSR_MHPMCOUNTER25   0xb19
> > +#define CSR_MHPMCOUNTER26   0xb1a
> > +#define CSR_MHPMCOUNTER27   0xb1b
> > +#define CSR_MHPMCOUNTER28   0xb1c
> > +#define CSR_MHPMCOUNTER29   0xb1d
> > +#define CSR_MHPMCOUNTER30   0xb1e
> > +#define CSR_MHPMCOUNTER31   0xb1f
> > +#define CSR_MHPMEVENT3      0x323
> > +#define CSR_MHPMEVENT4      0x324
> > +#define CSR_MHPMEVENT5      0x325
> > +#define CSR_MHPMEVENT6      0x326
> > +#define CSR_MHPMEVENT7      0x327
> > +#define CSR_MHPMEVENT8      0x328
> > +#define CSR_MHPMEVENT9      0x329
> > +#define CSR_MHPMEVENT10     0x32a
> > +#define CSR_MHPMEVENT11     0x32b
> > +#define CSR_MHPMEVENT12     0x32c
> > +#define CSR_MHPMEVENT13     0x32d
> > +#define CSR_MHPMEVENT14     0x32e
> > +#define CSR_MHPMEVENT15     0x32f
> > +#define CSR_MHPMEVENT16     0x330
> > +#define CSR_MHPMEVENT17     0x331
> > +#define CSR_MHPMEVENT18     0x332
> > +#define CSR_MHPMEVENT19     0x333
> > +#define CSR_MHPMEVENT20     0x334
> > +#define CSR_MHPMEVENT21     0x335
> > +#define CSR_MHPMEVENT22     0x336
> > +#define CSR_MHPMEVENT23     0x337
> > +#define CSR_MHPMEVENT24     0x338
> > +#define CSR_MHPMEVENT25     0x339
> > +#define CSR_MHPMEVENT26     0x33a
> > +#define CSR_MHPMEVENT27     0x33b
> > +#define CSR_MHPMEVENT28     0x33c
> > +#define CSR_MHPMEVENT29     0x33d
> > +#define CSR_MHPMEVENT30     0x33e
> > +#define CSR_MHPMEVENT31     0x33f
> > +#define CSR_MHPMCOUNTER3H   0xb83
> > +#define CSR_MHPMCOUNTER4H   0xb84
> > +#define CSR_MHPMCOUNTER5H   0xb85
> > +#define CSR_MHPMCOUNTER6H   0xb86
> > +#define CSR_MHPMCOUNTER7H   0xb87
> > +#define CSR_MHPMCOUNTER8H   0xb88
> > +#define CSR_MHPMCOUNTER9H   0xb89
> > +#define CSR_MHPMCOUNTER10H  0xb8a
> > +#define CSR_MHPMCOUNTER11H  0xb8b
> > +#define CSR_MHPMCOUNTER12H  0xb8c
> > +#define CSR_MHPMCOUNTER13H  0xb8d
> > +#define CSR_MHPMCOUNTER14H  0xb8e
> > +#define CSR_MHPMCOUNTER15H  0xb8f
> > +#define CSR_MHPMCOUNTER16H  0xb90
> > +#define CSR_MHPMCOUNTER17H  0xb91
> > +#define CSR_MHPMCOUNTER18H  0xb92
> > +#define CSR_MHPMCOUNTER19H  0xb93
> > +#define CSR_MHPMCOUNTER20H  0xb94
> > +#define CSR_MHPMCOUNTER21H  0xb95
> > +#define CSR_MHPMCOUNTER22H  0xb96
> > +#define CSR_MHPMCOUNTER23H  0xb97
> > +#define CSR_MHPMCOUNTER24H  0xb98
> > +#define CSR_MHPMCOUNTER25H  0xb99
> > +#define CSR_MHPMCOUNTER26H  0xb9a
> > +#define CSR_MHPMCOUNTER27H  0xb9b
> > +#define CSR_MHPMCOUNTER28H  0xb9c
> > +#define CSR_MHPMCOUNTER29H  0xb9d
> > +#define CSR_MHPMCOUNTER30H  0xb9e
> > +#define CSR_MHPMCOUNTER31H  0xb9f
> > +
> > +/* mstatus CSR bits */
> >   #define MSTATUS_UIE         0x00000001
> >   #define MSTATUS_SIE         0x00000002
> >   #define MSTATUS_HIE         0x00000004
> > @@ -276,7 +317,7 @@
> >   #define MSTATUS_SD MSTATUS64_SD
> >   #endif
>
> > -/* sstatus bits */
> > +/* sstatus CSR bits */
> >   #define SSTATUS_UIE         0x00000001
> >   #define SSTATUS_SIE         0x00000002
> >   #define SSTATUS_UPIE        0x00000010
> > @@ -297,83 +338,71 @@
> >   #define SSTATUS_SD SSTATUS64_SD
> >   #endif
>
> > -/* irqs */
> > -#define MIP_SSIP            (1 << IRQ_S_SOFT)
> > -#define MIP_HSIP            (1 << IRQ_H_SOFT)
> > -#define MIP_MSIP            (1 << IRQ_M_SOFT)
> > -#define MIP_STIP            (1 << IRQ_S_TIMER)
> > -#define MIP_HTIP            (1 << IRQ_H_TIMER)
> > -#define MIP_MTIP            (1 << IRQ_M_TIMER)
> > -#define MIP_SEIP            (1 << IRQ_S_EXT)
> > -#define MIP_HEIP            (1 << IRQ_H_EXT)
> > -#define MIP_MEIP            (1 << IRQ_M_EXT)
> > -
> > -#define SIP_SSIP            MIP_SSIP
> > -#define SIP_STIP            MIP_STIP
> > -#define SIP_SEIP            MIP_SEIP
> > -
> > +/* Privilege modes */
> >   #define PRV_U 0
> >   #define PRV_S 1
> >   #define PRV_H 2
> >   #define PRV_M 3
>
> > -/* privileged ISA 1.9.1 VM modes (mstatus.vm) */
> > -#define VM_1_09_MBARE 0
> > -#define VM_1_09_MBB   1
> > -#define VM_1_09_MBBID 2
> > -#define VM_1_09_SV32  8
> > -#define VM_1_09_SV39  9
> > -#define VM_1_09_SV48  10
> > -
> > -/* privileged ISA 1.10.0 VM modes (satp.mode) */
> > -#define VM_1_10_MBARE 0
> > -#define VM_1_10_SV32  1
> > -#define VM_1_10_SV39  8
> > -#define VM_1_10_SV48  9
> > -#define VM_1_10_SV57  10
> > -#define VM_1_10_SV64  11
> > -
> > -/* privileged ISA interrupt causes */
> > -#define IRQ_U_SOFT      0  /* since: priv-1.10 */
> > -#define IRQ_S_SOFT      1
> > -#define IRQ_H_SOFT      2  /* until: priv-1.9.1 */
> > -#define IRQ_M_SOFT      3  /* until: priv-1.9.1 */
> > -#define IRQ_U_TIMER     4  /* since: priv-1.10 */
> > -#define IRQ_S_TIMER     5
> > -#define IRQ_H_TIMER     6  /* until: priv-1.9.1 */
> > -#define IRQ_M_TIMER     7  /* until: priv-1.9.1 */
> > -#define IRQ_U_EXT       8  /* since: priv-1.10 */
> > -#define IRQ_S_EXT       9
> > -#define IRQ_H_EXT       10 /* until: priv-1.9.1 */
> > -#define IRQ_M_EXT       11 /* until: priv-1.9.1 */
> > -#define IRQ_X_COP       12 /* non-standard */
> > -
> > -/* Default addresses */
> > -#define DEFAULT_RSTVEC     0x00001000
> > -
> > -/* RV32 satp field masks */
> > -#define SATP32_MODE 0x80000000
> > -#define SATP32_ASID 0x7fc00000
> > -#define SATP32_PPN  0x003fffff
> > -
> > -/* RV64 satp field masks */
> > -#define SATP64_MODE 0xF000000000000000ULL
> > -#define SATP64_ASID 0x0FFFF00000000000ULL
> > -#define SATP64_PPN  0x00000FFFFFFFFFFFULL
> > +/* RV32 satp CSR field masks */
> > +#define SATP32_MODE         0x80000000
> > +#define SATP32_ASID         0x7fc00000
> > +#define SATP32_PPN          0x003fffff
> > +
> > +/* RV64 satp CSR field masks */
> > +#define SATP64_MODE         0xF000000000000000ULL
> > +#define SATP64_ASID         0x0FFFF00000000000ULL
> > +#define SATP64_PPN          0x00000FFFFFFFFFFFULL
>
> >   #if defined(TARGET_RISCV32)
> > -#define SATP_MODE SATP32_MODE
> > -#define SATP_ASID SATP32_ASID
> > -#define SATP_PPN  SATP32_PPN
> > +#define SATP_MODE           SATP32_MODE
> > +#define SATP_ASID           SATP32_ASID
> > +#define SATP_PPN            SATP32_PPN
> >   #endif
> >   #if defined(TARGET_RISCV64)
> > -#define SATP_MODE SATP64_MODE
> > -#define SATP_ASID SATP64_ASID
> > -#define SATP_PPN  SATP64_PPN
> > +#define SATP_MODE           SATP64_MODE
> > +#define SATP_ASID           SATP64_ASID
> > +#define SATP_PPN            SATP64_PPN
> >   #endif
>
> > -/* RISCV Exception Codes */
> > -#define EXCP_NONE                       -1 /* not a real RISCV exception
> code */
> > +/* VM modes (mstatus.vm) privileged ISA 1.9.1 */
> > +#define VM_1_09_MBARE       0
> > +#define VM_1_09_MBB         1
> > +#define VM_1_09_MBBID       2
> > +#define VM_1_09_SV32        8
> > +#define VM_1_09_SV39        9
> > +#define VM_1_09_SV48        10
> > +
> > +/* VM modes (satp.mode) privileged ISA 1.10 */
> > +#define VM_1_10_MBARE       0
> > +#define VM_1_10_SV32        1
> > +#define VM_1_10_SV39        8
> > +#define VM_1_10_SV48        9
> > +#define VM_1_10_SV57        10
> > +#define VM_1_10_SV64        11
> > +
> > +/* Page table entry (PTE) fields */
> > +#define PTE_V               0x001 /* Valid */
> > +#define PTE_R               0x002 /* Read */
> > +#define PTE_W               0x004 /* Write */
> > +#define PTE_X               0x008 /* Execute */
> > +#define PTE_U               0x010 /* User */
> > +#define PTE_G               0x020 /* Global */
> > +#define PTE_A               0x040 /* Accessed */
> > +#define PTE_D               0x080 /* Dirty */
> > +#define PTE_SOFT            0x300 /* Reserved for Software */
> > +
> > +/* Page table PPN shift amount */
> > +#define PTE_PPN_SHIFT       10
> > +
> > +/* Leaf page shift amount */
> > +#define PGSHIFT             12
> > +
> > +/* Default Reset Vector adress */
> > +#define DEFAULT_RSTVEC      0x1000
> > +
> > +/* Exception causes */
> > +#define EXCP_NONE                          -1 /* sentinel value */
> >   #define RISCV_EXCP_INST_ADDR_MIS           0x0
> >   #define RISCV_EXCP_INST_ACCESS_FAULT       0x1
> >   #define RISCV_EXCP_ILLEGAL_INST            0x2
> > @@ -382,9 +411,7 @@
> >   #define RISCV_EXCP_LOAD_ACCESS_FAULT       0x5
> >   #define RISCV_EXCP_STORE_AMO_ADDR_MIS      0x6
> >   #define RISCV_EXCP_STORE_AMO_ACCESS_FAULT  0x7
> > -#define RISCV_EXCP_U_ECALL                 0x8 /* for convenience,
> report all
> > -                                                  ECALLs as this,
> handler
> > -                                                  fixes */
> > +#define RISCV_EXCP_U_ECALL                 0x8
> >   #define RISCV_EXCP_S_ECALL                 0x9
> >   #define RISCV_EXCP_H_ECALL                 0xa
> >   #define RISCV_EXCP_M_ECALL                 0xb
> > @@ -395,15 +422,44 @@
> >   #define RISCV_EXCP_INT_FLAG                0x80000000
> >   #define RISCV_EXCP_INT_MASK                0x7fffffff
>
> > -/* page table entry (PTE) fields */
> > -#define PTE_V     0x001 /* Valid */
> > -#define PTE_R     0x002 /* Read */
> > -#define PTE_W     0x004 /* Write */
> > -#define PTE_X     0x008 /* Execute */
> > -#define PTE_U     0x010 /* User */
> > -#define PTE_G     0x020 /* Global */
> > -#define PTE_A     0x040 /* Accessed */
> > -#define PTE_D     0x080 /* Dirty */
> > -#define PTE_SOFT  0x300 /* Reserved for Software */
> > -
> > -#define PTE_PPN_SHIFT 10
> > +/* Interrupt causes */
> > +#define IRQ_U_SOFT                         0
> > +#define IRQ_S_SOFT                         1
> > +#define IRQ_H_SOFT                         2  /* reserved */
> > +#define IRQ_M_SOFT                         3
> > +#define IRQ_U_TIMER                        4
> > +#define IRQ_S_TIMER                        5
> > +#define IRQ_H_TIMER                        6  /* reserved */
> > +#define IRQ_M_TIMER                        7
> > +#define IRQ_U_EXT                          8
> > +#define IRQ_S_EXT                          9
> > +#define IRQ_H_EXT                          10 /* reserved */
> > +#define IRQ_M_EXT                          11
> > +#define IRQ_U_CORE                         12
> > +#define IRQ_S_CORE                         13
> > +#define IRQ_H_CORE                         14 /* reserved */
> > +#define IRQ_M_CORE                         15
> > +
> > +/* mip masks */
> > +#define MIP_USIP                           (1 << IRQ_U_SOFT)
> > +#define MIP_SSIP                           (1 << IRQ_S_SOFT)
> > +#define MIP_HSIP                           (1 << IRQ_H_SOFT)
> > +#define MIP_MSIP                           (1 << IRQ_M_SOFT)
> > +#define MIP_UTIP                           (1 << IRQ_U_TIMER)
> > +#define MIP_STIP                           (1 << IRQ_S_TIMER)
> > +#define MIP_HTIP                           (1 << IRQ_H_TIMER)
> > +#define MIP_MTIP                           (1 << IRQ_M_TIMER)
> > +#define MIP_UEIP                           (1 << IRQ_U_EXT)
> > +#define MIP_SEIP                           (1 << IRQ_S_EXT)
> > +#define MIP_HEIP                           (1 << IRQ_H_EXT)
> > +#define MIP_MEIP                           (1 << IRQ_M_EXT)
> > +#define MIP_UCIP                           (1 << IRQ_U_CORE)
> > +#define MIP_SCIP                           (1 << IRQ_S_CORE)
> > +#define MIP_HCIP                           (1 << IRQ_H_CORE)
> > +#define MIP_MCIP                           (1 << IRQ_M_CORE)
> > +
> > +/* sip masks */
> > +#define SIP_SSIP                           MIP_SSIP
> > +#define SIP_STIP                           MIP_STIP
> > +#define SIP_SEIP                           MIP_SEIP
> > +#define SIP_SCIP                           MIP_SCIP
> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > index 4b4d62b..9375331 100644
> > --- a/target/riscv/op_helper.c
> > +++ b/target/riscv/op_helper.c
> > @@ -90,8 +90,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong
> val_to_write,
> >           target_ulong csrno)
> >   {
> >   #ifndef CONFIG_USER_ONLY
> > -    uint64_t delegable_ints = MIP_SSIP | MIP_STIP | MIP_SEIP | (1 <<
> IRQ_X_COP);
> > -    uint64_t all_ints = delegable_ints | MIP_MSIP | MIP_MTIP;
> > +    uint64_t delegable_ints = MIP_SSIP | MIP_STIP | MIP_SEIP | MIP_SCIP;
> > +    uint64_t all_ints = delegable_ints | MIP_MSIP | MIP_MTIP | MIP_MCIP;
> >   #endif
>
> >       switch (csrno) {
> > --
> > 2.7.0
>
