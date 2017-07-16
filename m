Received: from eggs.gnu.org ([2001:4830:134:3::10]:50444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWlJJ-0003rC-2T
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 11:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWlJI-0005Jf-0s
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 11:18:17 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:54470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dWlJH-0005JI-QW
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 11:18:15 -0400
Date: Sun, 16 Jul 2017 17:18:14 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170716151814.otba6mhnpzosqwpa@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-10-rth@twiddle.net>
	<20170715225934.lap5cnukiyotqrqs@aurel32.net>
	<00736ea7-4c08-2f01-3271-1a669110a4a9@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00736ea7-4c08-2f01-3271-1a669110a4a9@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 09/27] linux-user/sh4: Clean env->flags
 on signal boundaries
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

On 2017-07-15 16:33, Richard Henderson wrote:
> On 07/15/2017 12:59 PM, Aurelien Jarno wrote:
> > On 2017-07-06 16:20, Richard Henderson wrote:
> > > If a signal is delivered during the execution of a delay slot,
> > > or a gUSA region, clear those bits from the environment so that
> > > the signal handler does not start in that same state.
> > 
> > How are signals delivered in linux-user? At least in system mode we
> > forbid interrupts in the delay slot (see commit 5c6f3eb7db), as the
> > manual clearly declare them as indivisible. Maybe the same should be
> > done for linux-user?
> 
> Signals get queued, and delivered eventually.  I don't believe that we do
> anything to check that "signals can't be delivered yet" like we do in system
> mode.

Ok. I think it might be a good idea to implement that. I am not always
sure that running the signal handler between an instruction and the
corresponding delay slot will lead to correct behaviour.

> > > +    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
> > >   }
> > >   static void setup_frame(int sig, struct target_sigaction *ka,
> > 
> > Why not using TB_FLAG_ENVFLAGS_MASK introduced earlier in this patch
> > series?
> 
> I really want to clear these two sets.  I didn't want to assume that
> ENVFLAGS_MASK would never contain anything else.
> 

Fair enough. Therefore:

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
