Received: from eggs.gnu.org ([2001:4830:134:3::10]:55741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXYzj-00072a-CC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXYzf-0005nq-F0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:21:23 -0400
Received: from hall.aurel32.net ([163.172.24.10]:46042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXYzf-0005nV-8E
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:21:19 -0400
Date: Tue, 18 Jul 2017 22:19:06 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170718201906.grxwco4ztzgzalzb@aurel32.net>
References: <20170718200255.31647-1-rth@twiddle.net>
	<20170718200255.31647-2-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718200255.31647-2-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 01/30] target/sh4: Use cmpxchg for movco
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-07-18 10:02, Richard Henderson wrote:
> As for other targets, cmpxchg isn't quite right for ll/sc,
> suffering from an ABA race, but is sufficient to implement
> portable atomic operations.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> 
> ---
> V2: Clear lock_addr in rte, do_interrupt, syscall entry, & signal delivery.
>     Fix movli to tollerate overlap between R0 and REG(B11_8).
> ---
>  target/sh4/cpu.h       |  3 ++-
>  linux-user/main.c      |  1 +
>  linux-user/signal.c    |  2 ++
>  target/sh4/helper.c    |  2 +-
>  target/sh4/translate.c | 72 +++++++++++++++++++++++++++++---------------------
>  5 files changed, 48 insertions(+), 32 deletions(-)

I still believe that for the system case, we should implement the
behaviour described in the manual, that is setting ldst to 1 in movli
and clearing it in an interrupt. Otherwise the plainly silly following
instruction sequence will give different results than on real silicon:

    movli.l   @r1,r0
    add       #4, r1
    movco.l   r0, @r1

Yes, this is plainly silly to use movli/movco to copy data, but we have
also implemented silly behaviour for other CPUs. For the user case it's
different, we don't have real choice, plus we know that it will be used
to execute linux binaries, which are more likely to have a sane usage of
atomic instructions.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
