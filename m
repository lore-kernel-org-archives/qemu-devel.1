Received: from eggs.gnu.org ([2001:4830:134:3::10]:33237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPpI2-0002YO-Sm
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPpHy-00053E-3h
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:12:50 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:40685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPpHx-00052w-So
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:12:46 -0400
Received: by mail-ot0-x241.google.com with SMTP id n1-v6so37523840otf.7
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 06:12:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180529105011.1914-17-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
	<20180529105011.1914-17-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 14:12:24 +0100
Message-ID: <CAFEAcA9s=okgW15DoAb5_NFbaDgvqsC+beqpc1gJG=FqeKvG=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 16/38] target-microblaze: Break out
 trap_illegal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 29 May 2018 at 11:49, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote=
:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Break out trap_illegal() to handle illegal operation traps.
> We now generally stop translation of the current insn if
> it's not valid.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

> @@ -1552,13 +1537,7 @@ static inline void decode(DisasContext *dc, uint32=
_t ir)
>      if (dc->ir)
>          dc->nr_nops =3D 0;
>      else {
> -        if ((dc->tb_flags & MSR_EE_FLAG)
> -              && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -              && (dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK)) =
{
> -            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> -            t_gen_raise_exception(dc, EXCP_HW_EXCP);
> -            return;
> -        }
> +        trap_illegal(dc, dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_=
MASK);
>
>          LOG_DIS("nr_nops=3D%d\t", dc->nr_nops);
>          dc->nr_nops++;

Here we used to return early in the "illegal insn" case, but in
the new code we don't. Coverity warns about this (CID 1391443)
because the trap_illegal() function's return code is checked
in the other 9 places where it is called.

thanks
-- PMM
