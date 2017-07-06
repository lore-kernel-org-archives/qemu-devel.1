Received: from eggs.gnu.org ([2001:4830:134:3::10]:35835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dT5bd-0005QQ-IL
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dT5bZ-0004hJ-I2
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:01 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dT5bZ-0004gs-6O
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:09:57 -0400
References: <20170706002401.10507-1-rth@twiddle.net>
	<20170706002401.10507-6-rth@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4574d0f3-8f2d-206e-475a-57404b7892dd@vivier.eu>
Date: Thu, 6 Jul 2017 14:09:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170706002401.10507-6-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/11] linux-user/sh4: Notice gUSA regions
 during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: bruno@clisp.org, aurelien@aurel32.net

Le 06/07/2017 à 02:23, Richard Henderson a écrit :
> We translate gUSA regions atomically in a parallel context.
> But in a serial context a gUSA region may be interrupted.
> In that case, restart the region as the kernel would.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  linux-user/signal.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 3d18d1b..1e716a9 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -3471,6 +3471,23 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
>      return (sp - frame_size) & -8ul;
>  }
>  
> +/* Notice when we're in the middle of a gUSA region and reset.
> +   Note that this will only occur for !parallel_cpus, as we will
> +   translate such sequences differently in a parallel context.  */
> +static void unwind_gusa(CPUSH4State *regs)
> +{
> +    /* If the stack pointer is sufficiently negative... */
> +    if ((regs->gregs[15] & 0xc0000000u) == 0xc0000000u) {

kernel also checks PC < gUSA region end point,
try this:

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 1e716a9..4e1e4f0 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -3477,7 +3477,8 @@ static abi_ulong get_sigframe(struct
target_sigaction *ka,
 static void unwind_gusa(CPUSH4State *regs)
 {
     /* If the stack pointer is sufficiently negative... */
-    if ((regs->gregs[15] & 0xc0000000u) == 0xc0000000u) {
+    if ((regs->gregs[15] & 0xc0000000u) == 0xc0000000u &&
+        regs->pc < regs->gregs[0]) {
         /* Reset the PC to before the gUSA region, as computed from
            R0 = region end, SP = -(region size), plus one more insn
            that actually sets SP to the region size.  */

Laurent
