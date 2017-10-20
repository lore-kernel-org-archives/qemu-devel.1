Received: from eggs.gnu.org ([2001:4830:134:3::10]:59308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuE-0003L7-NM
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuD-0003on-IL
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:03 +0200
Message-Id: <20171020115418.2050-32-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 31/46] target/s390x: special handling when
 starting a CPU with WAIT PSW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

When we try to start a CPU with a WAIT PSW, we have to take care that
TCG will actually try to continue executing instructions.

We must therefore really only unhalt the CPU if we don't have a WAIT
PSW. Also document the special order for restart interrupts, which
load a new PSW and change the state to operating.

To keep KVM working, simply don't have a look at the WAIT bit when
loading the PSW. Otherwise the behavior of a restart interrupt when
a CPU stopped would be changed.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-31-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c  | 11 +++++++++--
 target/s390x/sigp.c |  6 +++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 92f6707bcb..95f4283188 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -337,8 +337,15 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
         break;
     case CPU_STATE_OPERATING:
     case CPU_STATE_LOAD:
-        /* unhalt the cpu for common infrastructure */
-        s390_cpu_unhalt(cpu);
+        /*
+         * Starting a CPU with a PSW WAIT bit set:
+         * KVM: handles this internally and triggers another WAIT exit.
+         * TCG: will actually try to continue to run. Don't unhalt, will
+         *      be done when the CPU actually has work (an interrupt).
+         */
+        if (!tcg_enabled() || !(cpu->env.psw.mask & PSW_MASK_WAIT)) {
+            s390_cpu_unhalt(cpu);
+        }
         break;
     default:
         error_report("Requested CPU state is not a valid S390 CPU state: %u",
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 964c75a736..ac3f8e7dc2 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -232,8 +232,12 @@ static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
     case CPU_STATE_STOPPED:
         /* the restart irq has to be delivered prior to any other pending irq */
         cpu_synchronize_state(cs);
-        do_restart_interrupt(&cpu->env);
+        /*
+         * Set OPERATING (and unhalting) before loading the restart PSW.
+         * load_psw() will then properly halt the CPU again if necessary (TCG).
+         */
         s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
+        do_restart_interrupt(&cpu->env);
         break;
     case CPU_STATE_OPERATING:
         cpu_inject_restart(cpu);
-- 
2.13.6
