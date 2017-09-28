Received: from eggs.gnu.org ([2001:4830:134:3::10]:53755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaY-0005G7-Vh
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaU-0003os-Vg
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfaU-0003oT-Pg
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:14 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:37:08 +0200
Message-Id: <20170928203708.9376-31-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 30/30] target/s390x: special handling when
 starting a CPU with WAIT PSW
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

When we try to start a CPU with a WAIT PSW, we have to take care that
TCG will actually try to continue executing instructions.

We must therefore really only unhalt the CPU if we don't have a WAIT
PSW. Also document the special order for restart interrupts, which
load a new PSW and change the state to operating.

To keep KVM working, simply don't have a look at the WAIT bit when
loading the PSW. Otherwise the behavior of a restart interrupt when
a CPU stopped would be changed.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c  | 11 +++++++++--
 target/s390x/sigp.c |  6 +++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index e27827afb3..981f5d4f39 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -335,8 +335,15 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
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
2.13.5
