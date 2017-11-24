Received: from eggs.gnu.org ([2001:4830:134:3::10]:44261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1eIE0t-00009W-3t
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1eIE0p-0000Z8-1m
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:27:27 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:3107 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1eIE0o-0000YZ-LL
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:27:22 -0500
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Fri, 24 Nov 2017 16:26:50 +0300
Message-Id: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: rkagan@virtuozzo.com, dplotnikov@virtuozzo.com, den@virtuozzo.com, qemu-devel@nongnu.org

Commit 14c985cffa "target-i386: present virtual L3 cache info for vcpus"
introduced and set by default exposing l3 to the guest.

The motivation behind it was that in the Linux scheduler, when waking up
a task on a sibling CPU, the task was put onto the target CPU's runqueue
directly, without sending a reschedule IPI.  Reduction in the IPI count
led to performance gain.

However, this isn't the whole story.  Once the task is on the target
CPU's runqueue, it may have to preempt the current task on that CPU, be
it the idle task putting the CPU to sleep or just another running task.
For that a reschedule IPI will have to be issued, too.  Only when that
other CPU is running a normal task for too little time, the fairness
constraints will prevent the preemption and thus the IPI.

This boils down to the improvement being only achievable in workloads
with many actively switching tasks.  We had no access to the
(proprietary?) SAP HANA benchmark the commit referred to, but the
pattern is also reproduced with "perf bench sched messaging -g 1"
on 1 socket, 8 cores vCPU topology, we see indeed:

l3-cache	#res IPI /s	#time / 10000 loops
off		560K		1.8 sec
on		40K		0.9 sec

Now there's a downside: with L3 cache the Linux scheduler is more eager
to wake up tasks on sibling CPUs, resulting in unnecessary cross-vCPU
interactions and therefore exessive halts and IPIs.  E.g. "perf bench
sched pipe -i 100000" gives

l3-cache	#res IPI /s	#HLT /s		#time /100000 loops
off		200 (no K)	230		0.2 sec
on		400K		330K		0.5 sec

In a more realistic test, we observe 15% degradation in VM density
(measured as the number of VMs, each running Drupal CMS serving 2 http
requests per second to its main page, with 95%-percentile response
latency under 100 ms) with l3-cache=on.

We think that mostly-idle scenario is more common in cloud and personal
usage, and should be optimized for by default; users of highly loaded
VMs should be able to tune them up themselves.

So switch l3-cache off by default, and add a compat clause for the range
of machine types where it was on.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
---
 include/hw/i386/pc.h | 7 ++++++-
 target/i386/cpu.c    | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 087d184..1d2dcae 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -375,7 +375,12 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = TYPE_X86_CPU,\
         .property = "x-hv-max-vps",\
         .value    = "0x40",\
-    },
+    },\
+    {\
+        .driver   = TYPE_X86_CPU,\
+        .property = "l3-cache",\
+        .value    = "on",\
+    },\
 
 #define PC_COMPAT_2_9 \
     HW_COMPAT_2_9 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1edcf29..95a51bd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4154,7 +4154,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor_id),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
-    DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
+    DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, false),
     DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
-- 
2.7.4
