Received: from eggs.gnu.org ([2001:4830:134:3::10]:37589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXN-0004TJ-Mr
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXJ-00010D-2N
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dotXI-0000zU-Sg
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:40 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Sep 2017 17:43:04 +0200
Message-Id: <20170904154316.4148-8-david@redhat.com>
In-Reply-To: <20170904154316.4148-1-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/19] s390x: move two function declarations
 to s390-virtio-ccw.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

We can also drop the extern. Fix up includes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/hw/s390x/s390-virtio-ccw.h | 3 +++
 target/s390x/cpu.h                 | 2 --
 target/s390x/diag.c                | 1 +
 target/s390x/interrupt.c           | 3 +++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 41a9d2862b..42f2ccdb43 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -56,4 +56,7 @@ bool gs_allowed(void);
  */
 bool css_migration_enabled(void);
 
+S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
+void subsystem_reset(void);
+
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 2343f2f1f7..6c0abb9894 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -720,8 +720,6 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 
 
 /* outside of target/s390x/ */
-S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
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
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 058e219fe5..9aa6b89301 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -15,6 +15,9 @@
 #include "exec/exec-all.h"
 #include "sysemu/kvm.h"
 #include "hw/s390x/ioinst.h"
+#if !defined(CONFIG_USER_ONLY)
+#include "hw/s390x/s390-virtio-ccw.h"
+#endif
 
 /* Ensure to exit the TB after this call! */
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
-- 
2.13.5
