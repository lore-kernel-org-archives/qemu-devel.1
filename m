Received: from eggs.gnu.org ([2001:4830:134:3::10]:49015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drQXd-0004EV-DI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drQXc-0000CE-8e
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:22:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drQXc-0000AF-2Y
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:22:28 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Sep 2017 17:21:35 +0200
Message-Id: <20170911152150.12535-7-david@redhat.com>
In-Reply-To: <20170911152150.12535-1-david@redhat.com>
References: <20170911152150.12535-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 06/21] s390x: move subsystem_reset() to
 s390-virtio-ccw.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

Implemented in s390-virtio-ccw.c, so move it to the right header.
We can also drop the extern. Fix up one include.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/hw/s390x/s390-virtio-ccw.h | 2 ++
 target/s390x/cpu.h                 | 1 -
 target/s390x/diag.c                | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 41a9d2862b..a9a90c2022 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -56,4 +56,6 @@ bool gs_allowed(void);
  */
 bool css_migration_enabled(void);
 
+void subsystem_reset(void);
+
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7073fa59e9..372f7d8885 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -721,7 +721,6 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
-extern void subsystem_reset(void);
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index e6b5e6de37..82a623948d 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -20,6 +20,7 @@
 #include "hw/watchdog/wdt_diag288.h"
 #include "sysemu/cpus.h"
 #include "hw/s390x/ipl.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
 static int modified_clear_reset(S390CPU *cpu)
 {
-- 
2.13.5
