Received: from eggs.gnu.org ([2001:4830:134:3::10]:44757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEZuc-0002GU-2v
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEZuU-0000Ai-Cy
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:01:54 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEZuU-00009R-5N
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:01:46 -0500
Received: by mail-wm0-x242.google.com with SMTP id r68so21496123wmr.3
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 04:01:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171114094203.28030-1-richard.henderson@linaro.org>
References: <20171114094203.28030-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2017 12:01:24 +0000
Message-ID: <CAFEAcA-LhPR25rb6YDbgmE141woAiHLUcWRCF11ke+Eue1Z7vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: Record code_gen_buffer address for
 user-only memory helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 November 2017 at 09:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
> When we handle a signal from a fault within a user-only memory helper,
> we cannot cpu_restore_state with the PC found within the signal frame.
> Use a TLS variable, helper_retaddr, to record the unwind start point
> to find the faulting guest insn.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Tested only with a silly test case --
>
> int main()
> {
>   int new = 1, old = 0;
>   __atomic_compare_exchange((int *)0, &old, &new, 0, 0, 0);
>   return old;
> }
>
> which even before the patch does not fail in the way Peter describes.

Probably because the 32-bit atomic compare gets done inline, rather than
via a helper. Here's a test case which does fail:

===begin===
/* segv on atomic access: check we report correct PC
 *
 * Build with:
 *  aarch64-linux-gnu-gcc -g -Wall -static -o segv-atomic segv-atomic.c
 *
 * Copyright (c) 2017 Linaro Ltd
 * License: 2-clause BSD.
 */

#include <stdlib.h>
#include <signal.h>
#include <sys/mman.h>
#include <stdio.h>
#include <string.h>
#include <sys/ucontext.h>
#include <stdint.h>
#include <inttypes.h>

static int sigcount = 0;
static unsigned char *mem = 0;

void sighandler(int s, siginfo_t *info, void *puc)
{
    struct ucontext *uc = puc;
    uint64_t pc = uc->uc_mcontext.pc;
    uint64_t faultaddr = uc->uc_mcontext.fault_address;

    printf("in sighandler, pc = %" PRIx64 " faultaddr %" PRIx64 "\n",
           pc, faultaddr);
    sigcount++;
    if (sigcount == 2) {
       printf("too many signals\n");
       exit(1);
    }
    /* Advance past the insn */
    uc->uc_mcontext.pc += 4;
}

int main(void)
{
    struct sigaction sa;
    int x;

    mem = mmap(0, 4096, PROT_READ | PROT_WRITE,
               MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
    printf("memory at %p\n", mem);

    memset(&sa, 0, sizeof(sa));
    sa.sa_sigaction = sighandler;
    sa.sa_flags = SA_SIGINFO;
    sigaction(SIGSEGV, &sa, NULL);

    memset(mem, 42, 4096);

    mprotect(mem, 4096, PROT_READ);

    /* This should fault the first time around, and then
     * the segv handler will advance the PC by 4 to skip the insn.
     * We surround it with some movs so we know the insn
     * is not at the start of a TB and so we can tell if we
     * correctly skipped it.
     */
    printf("Trying atomic stxp...\n");
    __asm__ volatile("mov %[x], #1\n"
                     "ldxp x4, x3, [%[addr]]\n"
                     "mov %[x], #2\n"
                     "stxp w5, x4, x3, [%[addr]]\n"
                     "mov %[x], #3\n"
                     : [x] "=&r" (x)
                     : [addr] "r" (mem)
                     : "w5", "x4", "x3", "memory");

    printf("...done, with x %d\n", x);
    return 0;
}
===endit===

On real hardware:
pm215@gcc115:~$ ./segv-atomic
memory at 0x7f99810000
Trying atomic stlxr...
in sighandler, pc = 4007f0 faultaddr 7f99810000
...done, with x 3

On QEMU linux-user:
$ ~/linaro/qemu-from-laptop/qemu/build/all-linux-static/aarch64-linux-user/qemu-aarch64
-d in_asm,out_asm,cpu,exec,int -D /tmp/atomic.log ./segv-atomic
memory at 0x4000801000
Trying atomic stlxr...
in sighandler, pc = 4007d8 faultaddr 4000801000
in sighandler, pc = 4007e0 faultaddr a32
too many signals

and the log file shows that the relevant TB is:

0x004007d8:  d0000460  adrp     x0, #0x48e000
0x004007dc:  9128c000  add      x0, x0, #0xa30
0x004007e0:  f9400001  ldr      x1, [x0]
0x004007e4:  d2800020  movz     x0, #0x1
0x004007e8:  c87f0c24  ldxp     x4, x3, [x1]
0x004007ec:  d2800040  movz     x0, #0x2
0x004007f0:  c8250c24  stxp     w5, x4, x3, [x1]
0x004007f4:  d2800060  movz     x0, #0x3
0x004007f8:  b9001fa0  str      w0, [x29, #0x1c]
0x004007fc:  f00002e0  adrp     x0, #0x45f000
0x00400800:  91044000  add      x0, x0, #0x110
0x00400804:  b9401fa1  ldr      w1, [x29, #0x1c]
0x00400808:  940018b6  bl       #0x406ae0

so the stxp faults but the PC reported to the handler is the start
of the TB, at which point it goes off into the weeds because we
restart in the wrong place.

Unfortunately it still fails even with your patch...haven't
investigated why yet.

thanks
-- PMM
