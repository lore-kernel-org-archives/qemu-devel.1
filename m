Received: from eggs.gnu.org ([2001:4830:134:3::10]:36203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cb7gr-0003d1-0p
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cb7go-0007bx-0D
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:28:21 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cb7gn-0007aj-QB
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:28:17 -0500
Received: by mail-wm0-x244.google.com with SMTP id u63so28937188wmu.2
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 07:28:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <002801d2810f$18809c20$4981d460$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ff40db3-ca73-42a3-c565-7b450e1ea2ea@redhat.com>
Date: Tue, 7 Feb 2017 16:28:15 +0100
MIME-Version: 1.0
In-Reply-To: <002801d2810f$18809c20$4981d460$@ru>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] icount: remove useless exit_request
 assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, qemu-devel@nongnu.org



On 07/02/2017 07:54, Pavel Dovgalyuk wrote:
> This patch removes unneeded assignment to cpu->exit_request.
> cpu_exec_nocache executes all available instructions and therefore
> icount becomes 0. Then other conditions will break the execution
> loop, making assignment to cpu->exit_request useless.
> 
> This patch should be applied over Paolo's series:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg426058.html
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  cpu-exec.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/cpu-exec.c b/cpu-exec.c
> index 5cef8bc..91d1faf 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -577,7 +577,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
>          if (insns_left > 0) {
>              cpu_exec_nocache(cpu, insns_left, tb, false);
>          }
> -        atomic_set(&cpu->exit_request, 1);
>      }
>  }
>  
> 

Nice, thanks.  We can just squash the two patches with my 7/7 like this:

diff --git a/cpu-exec.c b/cpu-exec.c
index 9a7ff1b..1026cd0 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -517,7 +517,10 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             *last_tb = NULL;
         }
     }
-    if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
+
+    /* Finally, check if we need to exit to the main loop.  */
+    if (unlikely(atomic_read(&cpu->exit_request)
+        || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
         atomic_set(&cpu->exit_request, 0);
         cpu->exception_index = EXCP_INTERRUPT;
         return true;
@@ -527,8 +530,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 }
 
 static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
-                                    TranslationBlock **last_tb, int *tb_exit,
-                                    SyncClocks *sc)
+                                    TranslationBlock **last_tb, int *tb_exit)
 {
     uintptr_t ret;
     int32_t insns_left;
@@ -578,10 +580,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
          */
         if (insns_left > 0) {
             cpu_exec_nocache(cpu, insns_left, tb, false);
-            align_clocks(sc, cpu);
         }
-        cpu->exception_index = EXCP_INTERRUPT;
-        cpu_loop_exit(cpu);
     }
 }
 
@@ -641,7 +640,7 @@ int cpu_exec(CPUState *cpu)
 
         while (!cpu_handle_interrupt(cpu, &last_tb)) {
             TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
-            cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
+            cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit);
             /* Try to align the host and virtual clocks
                if the guest is in advance */
             align_clocks(&sc, cpu);
