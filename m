Received: from eggs.gnu.org ([2001:4830:134:3::10]:37422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTw-0006yU-QY
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTt-0007rd-2T
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyTs-0007rE-TC
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:09 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 17:59:52 +0200
Message-Id: <20170918160012.4317-8-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 07/27] s390x/tcg: STOPPED cpus can never
 wake up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Interrupts can't wake such CPUs up. SIGP from other CPUs has to be used
to toggle the state.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f42e28ea25..64db086702 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -58,6 +58,12 @@ static bool s390_cpu_has_work(CPUState *cs)
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
 
+    /* STOPPED cpus can never wake up */
+    if (s390_cpu_get_state(cpu) != CPU_STATE_LOAD &&
+        s390_cpu_get_state(cpu) != CPU_STATE_OPERATING) {
+        return false;
+    }
+
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
            (env->psw.mask & PSW_MASK_EXT);
 }
-- 
2.13.5
