Received: from eggs.gnu.org ([2001:4830:134:3::10]:40196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWWOr-0001gl-SL
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 19:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWWOq-0008I6-QS
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 19:23:01 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:49578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dWWOq-0008Hd-JZ
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 19:23:00 -0400
Date: Sun, 16 Jul 2017 01:22:56 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170715232256.agderyrnphikthfy@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-2-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-2-rth@twiddle.net>
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 2017-07-06 16:20, Richard Henderson wrote:
> As for other targets, cmpxchg isn't quite right for ll/sc,
> suffering from an ABA race, but is sufficient to implement
> portable atomic operations.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sh4/cpu.h       |  3 ++-
>  target/sh4/translate.c | 56 +++++++++++++++++++++++++++++++++-----------------
>  2 files changed, 39 insertions(+), 20 deletions(-)

For the linux-user case, where we need to emulate sequences that needs
to be executed on multiple CPUs, while the ISA has been designed for
a single CPU, this patch looks good. There is no real other way to do
it.

For the system case, one might imagine using MOVLI/MOVCO with a
different address, although 1) it hasn't been designed for that 2) all
the sequences I have found use the same address. I therefore wonder if
we should just add the code to correctly clear LDST in case of interrupt
or exception.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
