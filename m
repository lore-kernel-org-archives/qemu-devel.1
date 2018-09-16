Received: from eggs.gnu.org ([2001:4830:134:3::10]:40447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1g1Zle-0002Cr-OA
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 12:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1g1Zla-0007ql-4H
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 12:19:26 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:41331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1g1ZlZ-0007o7-Nm
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 12:19:22 -0400
Date: Sun, 16 Sep 2018 18:19:17 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20180916161917.GA5982@sx-9>
References: <20180707194137.GB14409@localhost.localdomain>
	<alpine.LFD.2.21.1808010159390.4967@eddie.linux-mips.org>
	<20180801133922.GC2371@localhost.localdomain>
	<c4b04967-c6fa-eea6-4c6e-7001c48344ba@linaro.org>
	<20180907191619.GA11275@r52>
	<alpine.LFD.2.21.1809080119040.19783@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1809080119040.19783@eddie.linux-mips.org>
Subject: Re: [Qemu-devel] [PATCH v3] target/mips: Support R5900 GCC programs
 in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@mips.com>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Many thanks for your review, Maciej,

>  I have been more thorough on this occasion, and I do hope I have caught 
> everything.  See the notes below, in addition to what the others wrote.  
> 
>  Please apply to v3 accordingly; I started writing this before you sent 
> that version.

Sure, next version submitted as a patch series will be a lot better, thanks!

>  I think this has to be (CPU_MIPS3 | INSN_R5900) really.
> 
>  While the CPU does support MIPS IV MOVN, MOVZ and PREF instructions, 
> that's all it has from that ISA.  Even the Tx79, which was supposed to 
> have a regular IEEE-754 FPU, did not have the extra FP condition bits, 
> MOVN.fmt, MOVZ.fmt or any of the MOVF* or MOVT* instructions, indexed 
> load/store instructions, multiply-accumulate instructions, etc. defined.
> 
>  So I think the R5900 has to be treated as a MIPS III implementation, with 
> some aberrations.  I don't expect it to be a big deal to add INSN_R5900 
> qualification to MOVN, MOVZ and PREF instruction emulation code right 
> away.

Trivial to add, in fact. :)

>  Then presumably you are going to add emulation for all the missing MIPS 
> III instructions to the Linux kernel eventually, to match the MIPS III 
> Linux user ABI?  Apart from LLD and SCD discussed previously this will 
> have to include DDIV, DDIVU, DMULT and DMULTU.

That sounds reasonable!

>  Eventually you'll have to remove all these instructions (plus LL and SC) 
> from the system emulation mode.  In fact I think it would make sense to do 
> that right away, because I believe it will be a reasonably simple update. 
> However if it turns out to be a can of worms after all, then I think we 
> can defer it, because we do not have a bare-metal environment ready for 
> this CPU anyway (or do we?).

Indeed, very simple. I added a new check function check_insn_opc_user_only,
similar to check_insn_opc_removed, conditional on USER_ONLY and so a simple

	check_insn_opc_user_only(ctx, INSN_R5900);

has to be added for these OPC cases. To test this I tried to build GCC with
the target mips64r5900el but it unfortunately didn't work as GCC failed to
compile itself:

	../sysdeps/mips/mips64/mul_1.S:49: Error: opcode not supported on
		this processor: r5900 (mips3) `dmultu $8,$7'

>  I think there is no point in executing the multiplication twice if `rd != 
> 0' and also we want to continue trapping on `sa != 0' for the non-Vr54xx 
> case, so how about:
> 
>         if (sa) {
>             check_insn(ctx, INSN_VR54XX);
>             op1 = MASK_MUL_VR54XX(ctx->opcode);
>             gen_mul_vr54xx(ctx, op1, rd, rs, rt);
>         } else if (rd && (ctx->insn_flags & INSN_R5900)) {
>             gen_mul_r5900(ctx, op1, rd, rs, rt);
>         } else {
>             gen_muldiv(ctx, op1, rd & 3, rs, rt);
>         }
> 
> ?

Agreed, that's better. The point was to reuse a bit of code, but now I've
folded all of it into gen_mul_r5900. There are also R5900 specific MULT1 and
MULTU1 instructions which might use it, so I folded the rd != 0 test into it
as well.

> > +        /* No L2 cache, icache size 32k, dcache size 32k, uncached coherency. */
> > +        .CP0_Config0 = (1 << 17) | (0x3 << 9) | (0x3 << 6) | (0x2 << CP0C0_K0),
> 
>  Why ICE set but DCE clear?  I guess this corresponds to the incorrect L2 
> cache reference as bit #17 is SC on the original R4000.  That reference 
> has to go, obviously, as there's no L2 cache indication in the R5900's 
> Config register.
> 
>  As to ICE and DCE their reset defaults are both 0, so we might as well 
> use that, as we don't emulate caches anyway.  If it turns out to matter to 
> any software, then we'll have to provide a more correct Config register 
> emulation as its writable bits are processor-specific.

Agreed, thanks for finding this!

> > +        /* Note: Config1 is only used internally, the R5900 has only Config0. */
> > +        .CP0_Status_rw_bitmask = 0xF4C79C1F,
> 
>  Maybe swap the two lines so that the Config1 register reference does not 
> confusingly seem to describe the Status r/w bitmask?

Done.

> > +#ifdef CONFIG_USER_ONLY
> > +	/*
> > +	 * R5900 hardware traps to the Linux kernel for IEEE 754-1985 and LL/SC
> > +	 * emulation. For user-only, qemu is the kernel, so we emulate the traps
> > +	 * by simply emulating the instructions directly.
> > +	 */
> 
>  Please use spaces rather than tabs for indentation, as per QEMU's coding 
> standard.

Done.

> > +        .SEGBITS = 19,
> 
>  This has to be 32, as with any MIPS CPU that implements 32-bit virtual 
> addressing only.  Specifically EntryHi register's VPN2 field goes up to 
> bit #31, which is (SEGBITS - 1).
> 
> > +        .PABITS = 20,
> 
>  And this has to be 32 as well, reflecting EntryLo0/1 registers' PFN 
> fields going up to bit #25.  This corresponds to bit #31 on the external 
> address bus, which is (PABITS - 1).

Right. I was unaware of these details, thanks!

Fredrik
