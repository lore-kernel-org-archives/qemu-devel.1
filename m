Received: from eggs.gnu.org ([2001:4830:134:3::10]:47668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUOG6-00032g-4O
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 22:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUOG2-0001bK-Vk
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 22:17:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUOG2-0001aV-Op
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 22:17:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id z6so12458003pfk.3
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 19:17:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <201707101004393739204@zte.com.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <584340a3-950c-293b-c874-c5eb10686bb8@twiddle.net>
Date: Sun, 9 Jul 2017 16:15:57 -1000
MIME-Version: 1.0
In-Reply-To: <201707101004393739204@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/mips: Bugfix for crash when
 runningprogram with qemu-i386.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiang.biao2@zte.com.cn
Cc: qemu-devel@nongnu.org, james.hogan@imgtec.com, zhong.weidong@zte.com.cn, wang.liang82@zte.com.cn, shi.zhongbing@zte.com.cn, jinguojie@loongson.cn, jiang.yong5@zte.com.cn

On 07/09/2017 04:04 PM, jiang.biao2@zte.com.cn wrote:
>  >>       if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
>  >>           tcg_out_ext32u(s, base, addr_regl);
>  >> -        addr_regl = base;
>  >> +        tcg_out_mov(s, TCG_TYPE_PTR, addr_regl, base);
>  >>       }
>  >>       if (guest_base == 0 && data_regl != addr_regl) {
>  >>           base = addr_regl;
>  >
>  > This is wrong, because you're not allowed to modify the input operands.
>  >
>  > Try this, just a few lines lower in the function:
> 
>  > -        tcg_out_movi(s, TCG_TYPE_PTR, base, guest_base);
>  > -        tcg_out_opc_reg(s, ALIAS_PADD, base, base, addr_regl);
>  > +        tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, guest_base);
>  > +        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP0, addr_regl);
> 
>  >
> 
> Got it, but the real problem is for addr_regl instead of guest_base.

Guest base is a problem simply because we require a temporary for it, and we 
were trying to put two temporaries into the same register.

If we retain guest_base in a register all of the time, then (1) we do not have 
to recompute it for every memory load and (2) we do not need a temporary for it.

>  > Better would be to reserve a register for the guest_base, like we do for ppc.
>  > See all of the uses of TCG_GUEST_BASE_REG in tcg/ppc/tcg-target.inc.c.
> 
> It uses base(TCG_REG_A0) for temperary use for guest_base in this case.

No it doesn't.  It computes guest_base into a register in the prologue:

> #ifndef CONFIG_SOFTMMU
>     if (guest_base) {
>         tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
>         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
>     }
> #endif

and then it uses a reg+reg addressing mode during qemu_ld/st:

>     rbase = guest_base ? TCG_GUEST_BASE_REG : 0;
...
>             insn = qemu_ldx_opc[opc & (MO_SIZE | MO_BSWAP)];
>             tcg_out32(s, insn | TAB(datalo, rbase, addrlo));

Obviously mips doesn't have a reg+reg addressing mode, so a PADD instruction is 
required, but otherwise you can use the same scheme.  Using TCG_REG_S1 on mips 
for TCG_GUEST_BASE_REG would be fine.


r~
