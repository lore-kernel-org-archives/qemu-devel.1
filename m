Received: from eggs.gnu.org ([2001:4830:134:3::10]:51589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQsb-0004fe-Bb
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQsY-00046C-3a
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:24:33 -0500
References: <20171129191215.11323-1-david@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f0c7605-4090-c1f6-c40d-06aab9a3e992@redhat.com>
Date: Mon, 11 Dec 2017 17:24:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171129191215.11323-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] cpus: make pause_all_cpus() play with
 SMP on single threaded TCG
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

On 29/11/2017 20:12, David Hildenbrand wrote:
> pause_all_cpus() is sometimes called from a VCPU thread (e.g. s390x
> during special reset). It cannot deal with multiple VCPUs per Thread
> (single threaded TCG) yet.
> 
> Booting an s390x guest with -smp 2 and single threaded TCG from disk
> currently fails. The DIAG 308 will issue a pause_all_cpus() and wait
> forever for the CPUs to actually stop. But it is waiting for itself.
> 
> So let's stop all VCPUs belonging to the current thread. Factor out
> stopping of a VCPU.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  cpus.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 114c29b6a0..3740c4db62 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1057,13 +1057,22 @@ static void qemu_tcg_destroy_vcpu(CPUState *cpu)
>  {
>  }
>  
> +static void qemu_cpu_stop(CPUState *cpu, bool exit)
> +{
> +    g_assert(qemu_cpu_is_self(cpu));
> +    cpu->stop = false;
> +    cpu->stopped = true;
> +    if (exit) {
> +        cpu_exit(cpu);
> +    }
> +    qemu_cond_broadcast(&qemu_pause_cond);
> +}
> +
>  static void qemu_wait_io_event_common(CPUState *cpu)
>  {
>      atomic_mb_set(&cpu->thread_kicked, false);
>      if (cpu->stop) {
> -        cpu->stop = false;
> -        cpu->stopped = true;
> -        qemu_cond_broadcast(&qemu_pause_cond);
> +        qemu_cpu_stop(cpu, false);
>      }
>      process_queued_cpu_work(cpu);
>  }
> @@ -1610,12 +1619,12 @@ void pause_all_vcpus(void)
>  
>      qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
>      CPU_FOREACH(cpu) {
> -        cpu->stop = true;
> -        qemu_cpu_kick(cpu);
> -    }
> -
> -    if (qemu_in_vcpu_thread()) {
> -        cpu_stop_current();
> +        if (qemu_cpu_is_self(cpu)) {
> +            qemu_cpu_stop(cpu, true);
> +        } else {
> +            cpu->stop = true;
> +            qemu_cpu_kick(cpu);
> +        }
>      }
>  
>      while (!all_vcpus_paused()) {
> @@ -1799,10 +1808,7 @@ void qemu_init_vcpu(CPUState *cpu)
>  void cpu_stop_current(void)
>  {
>      if (current_cpu) {
> -        current_cpu->stop = false;
> -        current_cpu->stopped = true;
> -        cpu_exit(current_cpu);
> -        qemu_cond_broadcast(&qemu_pause_cond);
> +        qemu_cpu_stop(current_cpu, true);
>      }
>  }

This function is not needed anymore, because vm_stop can just call
qemu_cpu_stop.  Does the following squash look fine to you?

diff --git a/cpus.c b/cpus.c
index 83700c1716..a65591c183 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1057,14 +1057,11 @@ static void qemu_tcg_destroy_vcpu(CPUState *cpu)
 {
 }
 
-static void qemu_cpu_stop(CPUState *cpu, bool exit)
+static void qemu_cpu_stop(CPUState *cpu)
 {
     g_assert(qemu_cpu_is_self(cpu));
     cpu->stop = false;
     cpu->stopped = true;
-    if (exit) {
-        cpu_exit(cpu);
-    }
     qemu_cond_broadcast(&qemu_pause_cond);
 }
 
@@ -1072,7 +1069,7 @@ static void qemu_wait_io_event_common(CPUState *cpu)
 {
     atomic_mb_set(&cpu->thread_kicked, false);
     if (cpu->stop) {
-        qemu_cpu_stop(cpu, false);
+        qemu_cpu_stop(cpu);
     }
     process_queued_cpu_work(cpu);
 }
@@ -1620,7 +1617,8 @@ void pause_all_vcpus(void)
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
     CPU_FOREACH(cpu) {
         if (qemu_cpu_is_self(cpu)) {
-            qemu_cpu_stop(cpu, true);
+            qemu_cpu_stop(cpu);
+            cpu_exit(cpu);
         } else {
             cpu->stop = true;
             qemu_cpu_kick(cpu);
@@ -1802,13 +1800,6 @@ void qemu_init_vcpu(CPUState *cpu)
     }
 }
 
-void cpu_stop_current(void)
-{
-    if (current_cpu) {
-        qemu_cpu_stop(current_cpu, true);
-    }
-}
-
 int vm_stop(RunState state)
 {
     if (qemu_in_vcpu_thread()) {
@@ -1818,7 +1809,8 @@ int vm_stop(RunState state)
          * FIXME: should not return to device code in case
          * vm_stop() has been requested.
          */
-        cpu_stop_current();
+        qemu_cpu_stop(current_cpu);
+        cpu_exit(current_cpu);
         return 0;
     }
 
