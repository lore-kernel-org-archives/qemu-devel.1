Received: from eggs.gnu.org ([2001:4830:134:3::10]:56245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa0sS-0007p0-Sr
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa0sR-0002p8-TK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:36:32 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:32901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fa0sR-0002oy-OY
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:36:31 -0400
Received: by mail-oi0-x244.google.com with SMTP id c6-v6so17180729oiy.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:36:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 16:36:10 +0100
Message-ID: <CAFEAcA8EPj=-ExxZeitao_gN-7XPUGQ=eOj+Q0mBU-x0QTepPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/25] OpenRISC updates for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>

On 2 July 2018 at 16:09, Stafford Horne <shorne@gmail.com> wrote:
> Hi Peter,
>
> Changes since v1:
>  - Un"fixed" an incorrect checkpatch warning pointed out by Richard.
>
> Please consider for pull.
>
> The following changes since commit 646f34fa5482e495483de230b4cf0f2ae4fd2781:
>
>   tcg: Fix --disable-tcg build breakage (2018-07-02 13:42:05 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:stffrdhrn/qemu.git tags/pull-or-20180702
>
> for you to fetch changes up to 33e1acf437ce4f0b67c262fc93b436e2e306f278:
>
>   target/openrisc: Fix writes to interrupt mask register (2018-07-03 00:05:28 +0900)
>
> ----------------------------------------------------------------
> OpenRISC cleanups and Fixes for QEMU 3.0
>
> Mostly patches from Richard Henderson fixing multiple things:
>  * Fix singlestepping in GDB.
>  * Use more TB linking.
>  * Fixes to exit TB after updating SPRs to enable registering of state
>    changes.
>  * Significant optimizations and refactors to the TLB
>  * Split out disassembly from translation.
>  * Add qemu-or1k to qemu-binfmt-conf.sh.
>  * Implement signal handling for linux-user.
>
> Then there are a few fixups from me:
>  * Fix delay slot detections to match hardware, this was masking a bug
>    in the linus kernel.
>  * Fix stores to the PIC mask register
>
> ----------------------------------------------------------------

Compile failure, for the windows crossbuilds:

/home/petmay01/qemu-for-merges/target/openrisc/mmu.c: In function
'openrisc_cpu_get_phys_page_debug':
/home/petmay01/qemu-for-merges/target/openrisc/mmu.c:133:29: error:
'PROT_EXEC' undeclared (first use in this function)
                             PROT_EXEC | PROT_READ | PROT_WRITE,
                             ^
/home/petmay01/qemu-for-merges/target/openrisc/mmu.c:133:29: note:
each undeclared identifier is reported only once for each function it
appears in
/home/petmay01/qemu-for-merges/target/openrisc/mmu.c:133:41: error:
'PROT_READ' undeclared (first use in this function)
                             PROT_EXEC | PROT_READ | PROT_WRITE,
                                         ^
/home/petmay01/qemu-for-merges/target/openrisc/mmu.c:133:53: error:
'PROT_WRITE' undeclared (first use in this function)
                             PROT_EXEC | PROT_READ | PROT_WRITE,
                                                     ^
/home/petmay01/qemu-for-merges/target/openrisc/mmu.c: In function 'tlb_fill':
/home/petmay01/qemu-for-merges/target/openrisc/mmu.c:169:53: error:
'PROT_EXEC' undeclared (first use in this function)
         int need = (access_type == MMU_INST_FETCH ? PROT_EXEC
                                                     ^
/home/petmay01/qemu-for-merges/target/openrisc/mmu.c:170:55: error:
'PROT_WRITE' undeclared (first use in this function)
                     : access_type == MMU_DATA_STORE ? PROT_WRITE
                                                       ^
/home/petmay01/qemu-for-merges/target/openrisc/mmu.c:171:23: error:
'PROT_READ' undeclared (first use in this function)
                     : PROT_READ);
                       ^
/home/petmay01/qemu-for-merges/rules.mak:69: recipe for target
'target/openrisc/mmu.o' failed

PROT_READ/WRITE/EXEC are the Posix flags for mmap().
The flags for the 'prot' argument to tlb_set_page()
and similar places are PAGE_READ/WRITE/EXEC.

PS: for trivial respins of a pullreq you don't need to resend
the whole thing, you can just resend the cover letter (and
any individual patches which got major changes).

thanks
-- PMM
