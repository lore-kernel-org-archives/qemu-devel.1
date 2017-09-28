Received: from eggs.gnu.org ([2001:4830:134:3::10]:53391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYv-0003q1-Kw
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYu-00038c-AJ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfYu-00038H-44
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:36 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:47 +0200
Message-Id: <20170928203708.9376-10-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/30] s390x/tcg: handle WAIT PSWs during
 interrupt injection
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

If we encounter a WAIT PSW, we have to halt immediately. Using
cpu_loop_exit() at this point feels wrong. Simply leaving
cs->exception_index set doesn't result in an immediate stop.

This is also necessary to properly handle SIGP STOP interrupts later.

The CPU_INTERRUPT_HALT will be processed immediately and properly set
the CPU to halted (also resetting cs->exception_index to EXCP_HLT)

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index f6747f3877..1a0d0770a9 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -467,6 +467,12 @@ void s390_cpu_do_interrupt(CPUState *cs)
         do_mchk_interrupt(env);
         break;
     }
+
+    /* WAIT PSW during interrupt injection */
+    if (cs->exception_index == EXCP_HLT) {
+        /* don't trigger a cpu_loop_exit(), use an interrupt instead */
+        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
+    }
     cs->exception_index = -1;
 
     /* we might still have pending interrupts, but not deliverable */
-- 
2.13.5
