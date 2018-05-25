Received: from eggs.gnu.org ([2001:4830:134:3::10]:37094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fManJ-00050o-60
	for qemu-devel@nongnu.org; Sat, 26 May 2018 11:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fManF-0007No-3Z
	for qemu-devel@nongnu.org; Sat, 26 May 2018 11:07:45 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fManE-0007NG-TX
	for qemu-devel@nongnu.org; Sat, 26 May 2018 11:07:41 -0400
Received: by mail-pf0-x244.google.com with SMTP id c10-v6so3893606pfi.12
	for <qemu-devel@nongnu.org>; Sat, 26 May 2018 08:07:40 -0700 (PDT)
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-23-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <82f51480-4c52-52bf-9dd7-0f2e742af8ba@linaro.org>
Date: Fri, 25 May 2018 11:53:27 -0700
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-23-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 22/30] RISC-V: Add misa runtime write
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On 05/22/2018 05:15 PM, Michael Clark wrote:
> +    /* Suppress 'C' if next instruction is not aligned
> +       TODO: this should check next_pc */
> +    if ((val & RVC) && (GETPC() & ~3) != 0) {
> +        val &= ~RVC;
> +    }

This is checking the host PC, which is useless.

Isn't this backward anyway?  Why would *setting* C require an aligned address?
Surely it's *clearing* C that would require an aligned address.

You can read the guest PC of the current instruction by doing

  cpu_restore_state(cs, GETPC(), false);
  xxx = env->pc;

In order to get the next pc, I guess you'd just need to add 4, since all of the
csr insns are not in the compact encoding space?

Alternately, to save the not insignificant amount of work that
cpu_restore_state does, and since all of the csr insns end the TB anyway, you
could move

    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);

before the call to helper_csr*.  If an exception is raised by the helper, this
store to PC will be overwritten by the existing cpu_restore_state in
do_raise_exception_err so that the correct PC value is seen on entry to
do_interrupt.


r~
