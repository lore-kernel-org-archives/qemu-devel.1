Received: from eggs.gnu.org ([2001:4830:134:3::10]:40248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTvzO-0005aw-3s
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTvzJ-0006q4-7n
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:33:46 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTvzJ-0006pr-1P
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:33:41 -0500
Received: by mail-pf0-x241.google.com with SMTP id f144so1679689pfa.2
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 11:33:40 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170117004409.28532-1-marex@denx.de>
	<20170117004409.28532-3-marex@denx.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ecaca869-7e29-850b-d3dd-a5dd94d0b670@twiddle.net>
Date: Wed, 18 Jan 2017 11:33:37 -0800
MIME-Version: 1.0
In-Reply-To: <20170117004409.28532-3-marex@denx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V9 2/7] nios2: Add architecture emulation
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org
Cc: Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Ley Foon Tan <lftan@altera.com>

On 01/16/2017 04:44 PM, Marek Vasut wrote:
> +        TCGv_i32 tmp = tcg_const_i32(instr.imm5 + 32);
> +        gen_helper_mmu_write(dc->cpu_env, tmp, load_gpr(dc, instr.a));
> +        tcg_temp_free_i32(tmp);
> +#endif
> +        break;
> +    }
> +
> +    default:
> +        tcg_gen_mov_tl(dc->cpu_R[instr.imm5 + 32], load_gpr(dc, instr.a));
> +        break;
> +    }
> +
> +    /* If interrupts were enabled using WRCTL, trigger them. */
> +#if !defined(CONFIG_USER_ONLY)
> +    if ((instr.imm5 + 32) == CR_STATUS) {

Did you want CR_BASE here instead of hard-coding 32?


> +static const char *regnames[] = {

const char * const

> +    "reserved", "reserved", "reserved", "reserved",
> +    "reserved", "reserved", "reserved", "reserved",
> +    "reserved", "reserved", "reserved", "reserved",
> +    "reserved", "reserved", "reserved", "reserved",

You might as well number them, e.g. resXX, to make it obvious in the dumps 
what's happening.

> +        if (num_insns + 1 == max_insns && (tb->cflags & CF_LAST_IO)) {
> +            gen_io_start();
> +        }

num_insns has already be incremented; don't + 1 here.

> +        && qemu_log_in_addr_range(tb->pc)) {
> +        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
> +        log_target_disas(cs, tb->pc, dc->pc - tb->pc, 0);
> +        qemu_log("\n");
> +    }

qemu_log_lock / qemu_log_unlock around the dump.


r~
