Received: from eggs.gnu.org ([2001:4830:134:3::10]:34718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWrVi-0002ZC-FY
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 17:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWrVh-0006PC-FL
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 17:55:30 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:56892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dWrVh-0006Jh-9e
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 17:55:29 -0400
Date: Sun, 16 Jul 2017 23:55:25 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170716215525.e57rklv3d5357mkj@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-2-rth@twiddle.net>
	<20170715232256.agderyrnphikthfy@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170715232256.agderyrnphikthfy@aurel32.net>
Subject: Re: [Qemu-devel] [PATCH v2 01/27] target/sh4: Use cmpxchg for movco
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: bruno@clisp.org, qemu-devel@nongnu.org, glaubitz@debian.org, laurent@vivier.eu

On 2017-07-16 01:22, Aurelien Jarno wrote:
> On 2017-07-06 16:20, Richard Henderson wrote:
> > As for other targets, cmpxchg isn't quite right for ll/sc,
> > suffering from an ABA race, but is sufficient to implement
> > portable atomic operations.
> > 
> > Signed-off-by: Richard Henderson <rth@twiddle.net>
> > ---
> >  target/sh4/cpu.h       |  3 ++-
> >  target/sh4/translate.c | 56 +++++++++++++++++++++++++++++++++-----------------
> >  2 files changed, 39 insertions(+), 20 deletions(-)
> 
> For the linux-user case, where we need to emulate sequences that needs
> to be executed on multiple CPUs, while the ISA has been designed for
> a single CPU, this patch looks good. There is no real other way to do
> it.
> 
> For the system case, one might imagine using MOVLI/MOVCO with a
> different address, although 1) it hasn't been designed for that 2) all
> the sequences I have found use the same address. I therefore wonder if
> we should just add the code to correctly clear LDST in case of interrupt
> or exception.

I guess the patch for the system case is as simple as:

--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -86,6 +86,9 @@ void superh_cpu_do_interrupt(CPUState *cs)
     int do_irq = cs->interrupt_request & CPU_INTERRUPT_HARD;
     int do_exp, irq_vector = cs->exception_index;
 
+    /* LDST flag is cleared by an exception or an interrupt.  */
+    env->ldst = 0;
+
     /* prioritize exceptions over interrupts */
 
     do_exp = cs->exception_index != -1;

Of course to integrate it with your patch it means adding the #ifdef
#else #endif around the system and the user version.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
