Received: from eggs.gnu.org ([2001:4830:134:3::10]:53445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQxL-0001AM-Bz
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQxI-0007LP-4q
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:29:27 -0500
References: <20171129191319.11483-1-david@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8e11154-00a7-745d-451b-38a3c6f42b6f@redhat.com>
Date: Mon, 11 Dec 2017 17:29:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171129191319.11483-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] cpu-exec: fix missed CPU kick during
 interrupt injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 29/11/2017 20:13, David Hildenbrand wrote:
> The conditional memory barrier not only looks strange but actually is
> wrong.
> 
> On s390x, I can reproduce interrupts via cpu_interrupt() not leading to
> a proper kick out of emulation every now and then. cpu_interrupt() is
> especially used for inter CPU communication via SIGP (esp. external
> calls and emergency interrupts).
> 
> With this patch, I was not able to reproduce. (esp. no stalls or hangs
> in the guest).
> 
> My setup is s390x MTTCG with 16 VCPUs on 8 CPU host, running make -j16.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  accel/tcg/cpu-exec.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 9b544d88c8..dfba5ebd29 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -525,19 +525,15 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>                                          TranslationBlock **last_tb)
>  {
>      CPUClass *cc = CPU_GET_CLASS(cpu);
> -    int32_t insns_left;
>  
>      /* Clear the interrupt flag now since we're processing
>       * cpu->interrupt_request and cpu->exit_request.
>       */
> -    insns_left = atomic_read(&cpu->icount_decr.u32);
>      atomic_set(&cpu->icount_decr.u16.high, 0);
> -    if (unlikely(insns_left < 0)) {
> -        /* Ensure the zeroing of icount_decr comes before the next read
> -         * of cpu->exit_request or cpu->interrupt_request.
> -         */
> -        smp_mb();
> -    }
> +    /* Ensure zeroing happens before reading cpu->exit_request or
> +     * cpu->interrupt_request. (also see cpu_exit())
> +     */
> +    smp_mb();
>  
>      if (unlikely(atomic_read(&cpu->interrupt_request))) {
>          int interrupt_request;
> 

atomic_mb_set can be a little faster on x86, so:

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index dfba5ebd29..4452cd9856 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -528,12 +528,10 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 
     /* Clear the interrupt flag now since we're processing
      * cpu->interrupt_request and cpu->exit_request.
+     * Ensure zeroing happens before reading cpu->exit_request or
+     * cpu->interrupt_request (see also smp_wmb in cpu_exit())
      */
-    atomic_set(&cpu->icount_decr.u16.high, 0);
-    /* Ensure zeroing happens before reading cpu->exit_request or
-     * cpu->interrupt_request. (also see cpu_exit())
-     */
-    smp_mb();
+    atomic_mb_set(&cpu->icount_decr.u16.high, 0);
 
     if (unlikely(atomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
