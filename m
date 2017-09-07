Received: from eggs.gnu.org ([2001:4830:134:3::10]:38916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3Bj-0004Ap-Hf
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3Be-0002En-TC
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dq3Be-0002EQ-Mq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Sep 2017 22:13:22 +0200
Message-Id: <20170907201335.13956-9-david@redhat.com>
In-Reply-To: <20170907201335.13956-1-david@redhat.com>
References: <20170907201335.13956-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/21] s390x: move sclp_service_call() to
 sclp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

Implemented in sclp.c, so let's move it to the right include file.
Fix up one include. Do a forward declaration of CPUS390XState to fix the
two sclp consoles complaining.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/hw/s390x/sclp.h    | 2 ++
 target/s390x/cpu.h         | 1 -
 target/s390x/misc_helper.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index a72d096081..4b86a8a293 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -242,5 +242,7 @@ sclpMemoryHotplugDev *init_sclp_memory_hotplug_dev(void);
 sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
 void sclp_service_interrupt(uint32_t sccb);
 void raise_irq_cpu_hotplug(void);
+typedef struct CPUS390XState CPUS390XState;
+int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
 
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 3aa2e46aac..032d1de2e8 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -721,6 +721,5 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
-int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
 
 #endif
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index b142db71c6..8b07535b02 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -35,6 +35,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/s390x/ebcdic.h"
 #include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/sclp.h"
 #endif
 
 /* #define DEBUG_HELPER */
-- 
2.13.5
