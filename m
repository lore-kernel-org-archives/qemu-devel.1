Received: from eggs.gnu.org ([2001:4830:134:3::10]:53611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0yki-0004PC-W0
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0ykg-0004rA-UH
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:15:44 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:44139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0ykg-0004pb-Ko
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:15:42 -0400
Received: by mail-ot0-x244.google.com with SMTP id x6-v6so759438otg.11
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 17:15:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0b20ff75-00d7-80db-ed2a-8b644a57b415@amsat.org>
References: <1522180487-22899-1-git-send-email-mjc@sifive.com>
	<1522180487-22899-2-git-send-email-mjc@sifive.com>
	<0b20ff75-00d7-80db-ed2a-8b644a57b415@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Mar 2018 17:15:41 -0700
Message-ID: <CAHNT7Nt40C8Bh3VJHjv8f+obSbU6Ki8ThXH2L7o4zoSM2LnK5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] RISC-V: Workaround for critical
 mstatus.FS MTTCG bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, RISC-V Patches <patches@groups.riscv.org>

On Tue, Mar 27, 2018 at 3:17 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Cc'ing Alex and Richard.
>
> On 03/27/2018 04:54 PM, Michael Clark wrote:
> > This change is a workaround for a bug where mstatus.FS
> > is not correctly reporting dirty when MTTCG and SMP are
> > enabled which results in the floating point register file
> > not being saved during context switches. This a critical
> > bug for RISC-V in QEMU as it results in floating point
> > register file corruption when running SMP Linux in the
> > RISC-V 'virt' machine.
> >
> > This workaround will return dirty if mstatus.FS is
> > switched from off to initial or clean. We have checked
> > the specification and it is legal for an implementation
> > to return either off, or dirty, if set to initial or clean.
> >
> > This workaround will result in unnecessary floating point
> > save restore. When mstatus.FS is off, floating point
> > instruction trap to indicate the process is using the FPU.
> > The OS can then save floating-point state of the previous
> > process using the FPU and set mstatus.FS to initial or
> > clean. With this workaround, mstatus.FS will always return
> > dirty if set to a non-zero value, indicating floating point
> > save restore is necessary, versus misreporting mstatus.FS
> > resulting in floating point register file corruption.
> >
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> > Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Tested-by: Richard W.M. Jones <rjones@redhat.com>
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
> >  target/riscv/op_helper.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > index e34715d..7281b98 100644
> > --- a/target/riscv/op_helper.c
> > +++ b/target/riscv/op_helper.c
> > @@ -144,8 +144,23 @@ void csr_write_helper(CPURISCVState *env,
> target_ulong val_to_write,
> >          }
> >
> >          mstatus =3D (mstatus & ~mask) | (val_to_write & mask);
> > -        int dirty =3D (mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS;
> > -        dirty |=3D (mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS;
> > +
> > +        /* Note: this is a workaround for an issue where mstatus.FS
> > +           does not report dirty when SMP and MTTCG is enabled. This
> > +           workaround is technically compliant with the RISC-V
> Privileged
> > +           specification as it is legal to return only off, or dirty,
> > +           however this may cause unnecessary saves of floating point
> state.
> > +           Without this workaround, floating point state is not saved
> and
> > +           restored correctly when SMP and MTTCG is enabled, */
>

On looking at this again, I think we may need to remove the
qemu_tcg_mttcg_enabled conditional and always return dirty if the state is
initial or clean, but not off.

While testing on uniprocessor worked okay, it's likely because we were
lucky and there was no task migration or multiple FPU tasks working. This
would mean we would revert to Richard W.M. Jones initial patch.

> +        if (qemu_tcg_mttcg_enabled()) {
> > +            /* FP is always dirty or off */
> > +            if (mstatus & MSTATUS_FS) {
> > +                mstatus |=3D MSTATUS_FS;
> > +            }
> > +        }
> > +
> > +        int dirty =3D ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS) |
> > +                    ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
> >          mstatus =3D set_field(mstatus, MSTATUS_SD, dirty);
> >          env->mstatus =3D mstatus;
> >          break;
> >
>

The text from the specification that allows us to always return dirty if
set to initial or clean, is below i.e. Dirty implies state has
"potentially" been modified, so that gives us wriggle room.

"
When an extension's status is set to Off , any instruction that attempts to
read or write the corresponding
state will cause an exception. When the status is Initial, the
corresponding state should
have an initial constant value. When the status is Clean, the corresponding
state is potentially
di fferent from the initial value, but matches the last value stored on a
context swap. When the
status is Dirty, the corresponding state has potentially been modif ed
since the last context save.
"

I think the problem is Linux is setting the state to clean after saving
fpu register state [1], but we have no code in the QEMU FPU operations to
set the state to dirty, if is clean or initial, only code to cause an
exception if the floating point extension state is set to off e.g.

static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
        int rs2, target_long imm)
{
    TCGv t0;

    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
        gen_exception_illegal(ctx);
        return;
    }

    t0 =3D tcg_temp_new();
    gen_get_gpr(t0, rs1);
    tcg_gen_addi_tl(t0, t0, imm);

    switch (opc) {
    case OPC_RISC_FSW:
        tcg_gen_qemu_st_i64(cpu_fpr[rs2], t0, ctx->mem_idx, MO_TEUL);
        break;
    case OPC_RISC_FSD:
        tcg_gen_qemu_st_i64(cpu_fpr[rs2], t0, ctx->mem_idx, MO_TEQ);
        break;
    default:
        gen_exception_illegal(ctx);
        break;
    }

    tcg_temp_free(t0);
}

[1]
https://github.com/torvalds/linux/blob/master/arch/riscv/include/asm/switch=
_to.h
