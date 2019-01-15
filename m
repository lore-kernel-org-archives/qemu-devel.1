Received: from eggs.gnu.org ([209.51.188.92]:45957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjQ3s-0003CC-Ri
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjQ3m-0003m7-NA
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:51:26 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58545)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gjQ3k-0003lT-EJ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:51:20 -0500
Date: Tue, 15 Jan 2019 09:51:17 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190115145117.GA4535@flamenco>
References: <CAMo8BfKWwT13TkBJ-C_kwYCkTcYY_Tq1vvGzanCzeDBRgTUzeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfKWwT13TkBJ-C_kwYCkTcYY_Tq1vvGzanCzeDBRgTUzeg@mail.gmail.com>
Subject: Re: [Qemu-devel] MTTCG qemu-softmmu aborted on watchpoint hit by
 atomic instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Mon, Jan 14, 2019 at 18:49:43 -0800, Max Filippov wrote:
> Hello,
> 
> I tried to debug guest application on SMP xtensa softmmu QEMU
> through the gdbserver and found that QEMU aborts when guest
> uses atomic operation to modify memory location watched by the
> debugger. It exits with the following message:
> 
> ERROR: cpus.c:1848:qemu_mutex_lock_iothread_impl: assertion failed:
> (!qemu_mutex_iothread_locked())
> 
> and the reason is that io_writex invoked from the atomic operation
> calls qemu_mutex_lock_iothread but doesn't have a chance to call
> qemu_mutex_unlock_iothread, because it exits the cpu loop at the
> following place:
> 
> #0  __libc_siglongjmp (env=0x55555628c720, val=1) at longjmp.c:28
> #1  0x000055555577ef24 in cpu_loop_exit (cpu=0x55555628c660) at
> /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/cpu-exec-common.c:68
> #2  0x00005555556e23dd in check_watchpoint (offset=3700, len=4,
> attrs=..., flags=2) at
> /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/exec.c:2762
(snip)
> #12 0x000055555577dfa1 in cpu_exec_step_atomic (cpu=0x55555628c660) at
> /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/cpu-exec.c:259
(snip)
> 
> It doesn't look like an xtensa-specific issue, any idea how to fix it?

Can you please try the appended?

Thanks,

		Emilio

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 870027d435..a5258bcbc8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -266,6 +266,9 @@ void cpu_exec_step_atomic(CPUState *cpu)
 #ifndef CONFIG_SOFTMMU
         tcg_debug_assert(!have_mmap_lock());
 #endif
+        if (qemu_mutex_iothread_locked()) {
+            qemu_mutex_unlock_iothread();
+        }
         assert_no_pages_locked();
     }
