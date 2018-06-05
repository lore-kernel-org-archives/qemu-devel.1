Received: from eggs.gnu.org ([2001:4830:134:3::10]:53116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fQG08-0006Mk-9W
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fQG05-0003jb-6G
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:44:08 -0400
Received: from mail-sn1nam01on0060.outbound.protection.outlook.com
	([104.47.32.60]:16548
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1fQG04-0003jI-Rx
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 13:44:05 -0400
From: Edgar Iglesias <edgari@xilinx.com>
Date: Tue, 5 Jun 2018 17:44:01 +0000
Message-ID: <iemtxwegx187yqo3oqysh7hb.1528220734178@email.android.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
	<20180529105011.1914-17-edgar.iglesias@gmail.com>,
	<CAFEAcA9s=okgW15DoAb5_NFbaDgvqsC+beqpc1gJG=FqeKvG=w@mail.gmail.com>
In-Reply-To: <CAFEAcA9s=okgW15DoAb5_NFbaDgvqsC+beqpc1gJG=FqeKvG=w@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Yeah, I think we should perhaps remove the nop insn counting hack all toget=
her...

Cheers,
Edgar


---
Sent from my phone


-------- Original Message --------
Subject: Re: [PULL v1 16/38] target-microblaze: Break out trap_illegal()
From: Peter Maydell <peter.maydell@linaro.org>
Date: Jun 4, 2018, 20:12
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
On 29 May 2018 at 11:49, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote=
:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Break out trap_illegal() to handle illegal operation traps.
> We now generally stop translation of the current insn if
> it's not valid.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
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
