Received: from eggs.gnu.org ([2001:4830:134:3::10]:50219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDaUK-0000wj-8Y
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDaUJ-0003c6-5D
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:54:24 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:55722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDaUI-0003Xg-V9
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:54:23 -0400
Date: Wed, 24 May 2017 19:54:09 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170524175409.oi5vzjvvpp3hcsfj@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-3-rth@twiddle.net>
	<20170523104851.37tseiq5zlpwevr6@aurel32.net>
	<d059a3b3-ac6c-27d2-5270-b6d5b32cc41d@twiddle.net>
	<20170523172858.aqvgqlrwrwu6jk2o@aurel32.net>
	<d9b3afcc-2def-ee43-9865-ab82c3361b3c@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b3afcc-2def-ee43-9865-ab82c3361b3c@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 02/31] target/s390x: Implement EXECUTE via
 new TranslationBlock
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

On 2017-05-23 16:21, Richard Henderson wrote:
> On 05/23/2017 10:28 AM, Aurelien Jarno wrote:
> > > Something like this, as a delta patch.

I confirm this patch is really needed, otherwise the executed
instruction seems to be executed at the next instruction.

> > Unfortunately it doesn't work. So far I have no real idea what could be
> > the root cause of the issue. I have just determined that up to the crash,
> > only a very limited set of instructions are being executed. They are the
> > 4 bytes long versions of MVC, CLC, XC, TR.
> 
> Yeah, it appears XC is the culprit, though I have not yet determined exactly
> what's going wrong.

It seems the problem arise if an interrupt happens when the TB
containing the EXECUTE instruction is being executed. In that case at
the end of the TB, the interruption code is translated with the ex_value
set, which means with the wrong PC, wrong permissions and wrong return
address.

This is the same kind of issue I identified on SH4 recently:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03880.html

The same king of solution also works, that is disabling the interrupts
when the ex_value is set:

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 6f81b1a16c..a33abdef16 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -655,6 +657,10 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         S390CPU *cpu = S390_CPU(cs);
         CPUS390XState *env = &cpu->env;
 
+        if (env->ex_value) {
+            return false;
+        }
+
         if (env->psw.mask & PSW_MASK_EXT) {
             s390_cpu_do_interrupt(cs);
             return true;

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
