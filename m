Received: from eggs.gnu.org ([2001:4830:134:3::10]:43205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cbSoL-0004VH-NF
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cbSoI-0005KU-Mi
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:01:29 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cbSoI-0005Jv-G1
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:01:26 -0500
Received: by mail-pg0-x244.google.com with SMTP id 194so15282379pgd.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 06:01:24 -0800 (PST)
Date: Wed, 8 Feb 2017 23:01:20 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170208140120.GI32144@lianli.shorne-pla.net>
References: <20170120163918.GD7836@lianli.shorne-pla.net>
	<d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
	<20170125123430.GG7836@lianli.shorne-pla.net>
	<39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
	<20170126131229.GB16014@lianli.shorne-pla.net>
	<ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
	<20170201100423.GE21641@lianli.shorne-pla.net>
	<d3dac109-ad39-8bb9-2012-f7a6824139eb@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3dac109-ad39-8bb9-2012-f7a6824139eb@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org, openrisc@lists.librecores.org

On Mon, Feb 06, 2017 at 09:53:26PM -0800, Richard Henderson wrote:
> On 02/01/2017 02:04 AM, Stafford Horne wrote:
> > For kernel builds I have created toolchain binaries here:
> > 
> >   http://shorne.noip.me/crosstool/files/bin/x86_64/5.4.0/
> > 
> > These should work.
> 
> This gdb crashes on the first "stepi" that I issue.  To reproduce,
> 
> $ cat z.c
> int main() { return 0; }
> $ or1k-musl-linux-gcc -g z.c
> $ qemu-or32 -g 10001 ./a.out
> 
> // another window
> 
> $ or1k-musl-linux-gdb ./a.out
> (gdb) target remote localhost:10001
> // should see that the pc is at _start
> (gdb) stepi
> // crash
> 
> I won't be able to debug this myself until I can build my own gdb.

Hello,

The gdb branch I use is the following, it is tracking very close to
upsstream:

  git@github.com:stffrdhrn/binutils-gdb.git or1k-upstream

I have sent this for review to the gdb list and currently waiting on
comments for version 4.  Most of the code is the same as in openrisc
github. However, I have just rebased and cleaned up for upstreaming.

Note, I can get basic programs running fine on your qemu branch using
linux-user i.e.

 $ cat main.c
   #include <stdio.h>

   int main() {
     printf("hello");
     return 0;
   }
 $ or1k-linux-musl-gcc -g -static main.c
 $ ./qemu/build/or32-linux-user/qemu-or32 ./a.out
   hello

However, when debugging I ran into a few errors.

  1. qemu aborts the program and sends SIGILL to gdb, this is caused by
     the openrisc loop in linux-user missing handlers for EXCP_INTERRUPT
     and EXCP_DEBUG, I patched that see below:
  2. After patching I got 1 step to work then gdb crashes with SIGSEGV
     Currently looking at it, Interestingly the code that is failing is

       in gdb/or1k-tdep.c: or1k_single_step_through_delay()
       cgen_lookup_insn() - returns NULL (shouldnt happen though)
       then NULL is dereferenced

     Interesting because it seems you wrote cgen_lookup_insn :)
     I am investigating more, but it seems like gdb issue.

Notes on the debugger:
  - The support for linux user processes is not implemented.  Eventually
    I think it will crash somewhere.  But it shouldnt crash where it is.
  - I tested the same program with the baremetal (newlib) toolchain
     * gdb native sim - OK can debug
     * or1ksim (via target remote) - Crashes same as QEMU

-Stafford


Patch for qemu issue mentioned in (1) above.

>From 777bd1c6641ea919799579dfbc99db4338db11bf Mon Sep 17 00:00:00 2001
From: Stafford Horne <shorne@gmail.com>
Date: Wed, 8 Feb 2017 22:20:01 +0900
Subject: [PATCH] linux-user: openrisc: Implement EXCP_INTERRUPT and EXCP_DEBUG

These were not implemented.  They are required escpecially if we
want to debug user processes in openrisc.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 linux-user/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 94a636f..1c33378 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -2468,6 +2468,7 @@ void cpu_loop(CPUOpenRISCState *env)
 {
     CPUState *cs = CPU(openrisc_env_get_cpu(env));
     int trapnr, gdbsig;
+    target_siginfo_t info;
     abi_long ret;
 
     for (;;) {
@@ -2542,6 +2543,23 @@ void cpu_loop(CPUOpenRISCState *env)
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
             break;
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        case EXCP_DEBUG:
+            {
+                int sig;
+
+                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
+                if (sig)
+                  {
+                    info.si_signo = sig;
+                    info.si_errno = 0;
+                    info.si_code = TARGET_TRAP_BRKPT;
+                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                  }
+            }
+            break;
         default:
             EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x - aborting\n",
                      trapnr);
-- 
2.9.3
