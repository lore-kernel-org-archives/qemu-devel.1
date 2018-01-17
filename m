Received: from eggs.gnu.org ([2001:4830:134:3::10]:46778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebriO-0008Vl-Gl
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebriL-0007s7-BV
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:41:32 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 17 Jan 2018 18:40:36 +0100
Message-Id: <20180117174047.6382-8-david@redhat.com>
In-Reply-To: <20180117174047.6382-1-david@redhat.com>
References: <20180117174047.6382-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/18] s390x/tcg: tolerate wrong wakeups due
 to floating interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

This is a prparation for floating interrupt support and only applies to
MTTCG, single threaded TCG works just fine. If a floating interrupt wakes
up a VCPU and the CPU thinks it can run (clearing cs->halted), at
the point where the interrupt would be delivered, already another VCPU
might have picked up the interrupt, resulting in a wakeup without an
interrupt (executing wrong code).

It is wrong to let the VCPU continue to execute (the WAIT PSW). Instead,
we have to put the VCPU back to sleep.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index a18842ccbd..eeffb49f63 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -503,6 +503,11 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
             s390_cpu_do_interrupt(cs);
             return true;
         }
+        if (env->psw.mask & PSW_MASK_WAIT) {
+            /* Woken up because of a floating interrupt but it has already
+             * been delivered. Go back to sleep. */
+            cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
+        }
     }
     return false;
 }
-- 
2.14.3
