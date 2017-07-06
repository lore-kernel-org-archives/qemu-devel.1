Received: from eggs.gnu.org ([2001:4830:134:3::10]:39903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dT93Q-0004Tm-Cx
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dT93P-0003Pg-7H
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:50:56 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dT93P-0003P6-1S
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:50:55 -0400
Date: Thu, 6 Jul 2017 17:50:51 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170706155051.placknk6o3uismoj@aurel32.net>
References: <20170706002401.10507-1-rth@twiddle.net>
	<20170706002401.10507-4-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706002401.10507-4-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 03/11] target/sh4: Handle user-space atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, bruno@clisp.org

On 2017-07-05 14:23, Richard Henderson wrote:
> For uniprocessors, SH4 uses optimistic restartable atomic sequences.
> Upon an interrupt, a real kernel would simply notice magic values in
> the registers and reset the PC to the start of the sequence.
> 
> For QEMU, we cannot do this in quite the same way.  Instead, we notice
> the normal start of such a sequence (mov #-x,r15), and start a new TB
> that can be executed under cpu_exec_step_atomic.
> 
> Reported-by: Bruno Haible  <bruno@clisp.org>
> LP: https://bugs.launchpad.net/bugs/1701971
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sh4/cpu.h       |  21 ++++++--
>  target/sh4/helper.h    |   1 +
>  target/sh4/op_helper.c |   6 +++
>  target/sh4/translate.c | 137 +++++++++++++++++++++++++++++++++++++++++++------
>  4 files changed, 147 insertions(+), 18 deletions(-)

I haven't reviewed this patch in details, but note that it breaks
booting a system under qemu-system.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
