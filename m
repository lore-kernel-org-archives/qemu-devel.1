Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155D3C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D012E20657
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D012E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57909 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYpaz-0000uV-5L
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 06:26:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hYpWo-0006lf-Px
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hYpWn-0003Wj-GU
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:21:50 -0400
Received: from foss.arm.com ([217.140.101.70]:41436)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>)
	id 1hYpWk-00039X-HB; Thu, 06 Jun 2019 06:21:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 073EF341;
	Thu,  6 Jun 2019 03:21:45 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A1CE3F690;
	Thu,  6 Jun 2019 03:21:43 -0700 (PDT)
Date: Thu, 6 Jun 2019 11:21:41 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190606102141.GB28398@e103592.cambridge.arm.com>
References: <20190605205706.569-1-richard.henderson@linaro.org>
	<20190605205706.569-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605205706.569-7-richard.henderson@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] [PATCH v6 6/6] tests/tcg/aarch64: Add bti smoke
 test
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 09:57:06PM +0100, Richard Henderson wrote:
> This will build with older toolchains, without the upstream support
> for -mbranch-protection.  Such a toolchain will produce a warning
> in such cases,
> 
> ld: warning: /tmp/ccyZt0kq.o: unsupported GNU_PROPERTY_TYPE (5) \
> type: 0xc0000000
> 
> but the still places the note at the correct location in the binary
> for processing by the runtime loader.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/aarch64/bti-1.c         | 77 +++++++++++++++++++++++++++++++
>  tests/tcg/aarch64/bti-crt.inc.c   | 69 +++++++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.target |  3 ++
>  3 files changed, 149 insertions(+)
>  create mode 100644 tests/tcg/aarch64/bti-1.c
>  create mode 100644 tests/tcg/aarch64/bti-crt.inc.c
> 
> diff --git a/tests/tcg/aarch64/bti-1.c b/tests/tcg/aarch64/bti-1.c
> new file mode 100644
> index 0000000000..2aee57ea7a
> --- /dev/null
> +++ b/tests/tcg/aarch64/bti-1.c
> @@ -0,0 +1,77 @@
> +/*
> + * Branch target identification, basic notskip cases.
> + */
> +
> +#include "bti-crt.inc.c"
> +
> +/*
> + * Work around lack of -mbranch-protection=standard in older toolchains.
> + * The signal handler is invoked by the kernel with PSTATE.BTYPE=2, which
> + * means that the handler must begin with a marker like BTI_C.
> + */
> +asm("skip2_sigill1:\n\
> +	hint	#34\n\
> +	b	skip2_sigill2\n\
> +.type skip2_sigill1,%function\n\
> +.size skip2_sigill1,8");
> +
> +extern void skip2_sigill1(int sig, siginfo_t *info, ucontext_t *uc)
> +    __attribute__((visibility("hidden")));
> +
> +static void __attribute__((used))
> +skip2_sigill2(int sig, siginfo_t *info, ucontext_t *uc)
> +{
> +    uc->uc_mcontext.pc += 8;
> +    uc->uc_mcontext.pstate = 1;
> +}
> +
> +#define NOP       "nop"
> +#define BTI_N     "hint #32"
> +#define BTI_C     "hint #34"
> +#define BTI_J     "hint #36"
> +#define BTI_JC    "hint #38"
> +
> +#define BTYPE_1(DEST) \
> +    asm("mov %0,#1; adr x16, 1f; br x16; 1: " DEST "; mov %0,#0" \
> +        : "=r"(skipped) : : "x16")
> +
> +#define BTYPE_2(DEST) \
> +    asm("mov %0,#1; adr x16, 1f; blr x16; 1: " DEST "; mov %0,#0" \
> +        : "=r"(skipped) : : "x16", "x30")
> +
> +#define BTYPE_3(DEST) \
> +    asm("mov %0,#1; adr x15, 1f; br x15; 1: " DEST "; mov %0,#0" \
> +        : "=r"(skipped) : : "x15")
> +
> +#define TEST(WHICH, DEST, EXPECT) \
> +    do { WHICH(DEST); fail += skipped ^ EXPECT; } while (0)
> +
> +
> +int main()
> +{
> +    int fail = 0;
> +    int skipped;
> +
> +    /* Signal-like with SA_SIGINFO.  */
> +    signal_info(SIGILL, skip2_sigill1);
> +
> +    TEST(BTYPE_1, NOP, 1);
> +    TEST(BTYPE_1, BTI_N, 1);
> +    TEST(BTYPE_1, BTI_C, 0);
> +    TEST(BTYPE_1, BTI_J, 0);
> +    TEST(BTYPE_1, BTI_JC, 0);
> +
> +    TEST(BTYPE_2, NOP, 1);
> +    TEST(BTYPE_2, BTI_N, 1);
> +    TEST(BTYPE_2, BTI_C, 0);
> +    TEST(BTYPE_2, BTI_J, 1);
> +    TEST(BTYPE_2, BTI_JC, 0);
> +
> +    TEST(BTYPE_3, NOP, 1);
> +    TEST(BTYPE_3, BTI_N, 1);
> +    TEST(BTYPE_3, BTI_C, 1);
> +    TEST(BTYPE_3, BTI_J, 0);
> +    TEST(BTYPE_3, BTI_JC, 0);
> +
> +    return fail;
> +}
> diff --git a/tests/tcg/aarch64/bti-crt.inc.c b/tests/tcg/aarch64/bti-crt.inc.c
> new file mode 100644
> index 0000000000..bb363853de
> --- /dev/null
> +++ b/tests/tcg/aarch64/bti-crt.inc.c
> @@ -0,0 +1,69 @@
> +/*
> + * Minimal user-environment for testing BTI.
> + *
> + * Normal libc is not built with BTI support enabled, and so could
> + * generate a BTI TRAP before ever reaching main.
> + */
> +
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <ucontext.h>
> +#include <asm/unistd.h>
> +
> +int main(void);
> +
> +void _start(void)
> +{
> +    exit(main());
> +}
> +
> +void exit(int ret)
> +{
> +    register int x0 __asm__("x0") = ret;
> +    register int x8 __asm__("x8") = __NR_exit;
> +
> +    asm volatile("svc #0" : : "r"(x0), "r"(x8));
> +    __builtin_unreachable();
> +}
> +
> +/*
> + * Irritatingly, the user API struct sigaction does not match the
> + * kernel API struct sigaction.  So for simplicity, isolate the
> + * kernel ABI here, and make this act like signal.
> + */
> +void signal_info(int sig, void (*fn)(int, siginfo_t *, ucontext_t *))
> +{
> +    struct kernel_sigaction {
> +        void (*handler)(int, siginfo_t *, ucontext_t *);
> +        unsigned long flags;
> +        unsigned long restorer;
> +        unsigned long mask;
> +    } sa = { fn, SA_SIGINFO, 0, 0 };
> +
> +    register int x0 __asm__("x0") = sig;
> +    register void *x1 __asm__("x1") = &sa;
> +    register void *x2 __asm__("x2") = 0;
> +    register int x3 __asm__("x3") = sizeof(unsigned long);
> +    register int x8 __asm__("x8") = __NR_rt_sigaction;
> +
> +    asm volatile("svc #0"
> +                 : : "r"(x0), "r"(x1), "r"(x2), "r"(x3), "r"(x8) : "memory");
> +}
> +
> +/*
> + * Create the PT_NOTE that will enable BTI in the page tables.
> + * This will be created by the compiler with -mbranch-protection=standard,
> + * but as of 2019-03-29, this is has not been committed to gcc mainline.
> + * This will probably be in GCC10.

FYI, GCC9 has it.

> + */
> +asm(".section .note.gnu.property,\"a\"\n\
> +	.align	3\n\
> +	.long	4\n\
> +        .long	16\n\
> +        .long	5\n\
> +        .string	\"GNU\"\n\
> +	.long	0xc0000000\n\
> +	.long	4\n\
> +	.long	1\n\
> +        .align  3\n\
> +	.previous");

Note, this won't be enough to generate the PT_GNU_PROPERTY entry in the
program header table using older tools.

This may be work-round-able with a linker script, but I haven't looked
into it.

> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
> index 2bb914975b..21da3bc37f 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -18,4 +18,7 @@ run-fcvt: fcvt
>  AARCH64_TESTS += pauth-1
>  run-pauth-%: QEMU += -cpu max
>  
> +AARCH64_TESTS += bti-1
> +bti-1: LDFLAGS += -nostartfiles -nodefaultlibs -nostdlib
> +

Doesn't -nostdlib imply -nodefaultlibs and -nostartfiles?

Cheers
---Dave

