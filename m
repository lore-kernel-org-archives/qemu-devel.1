Received: from eggs.gnu.org ([2001:4830:134:3::10]:39260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdo-0006OD-Tv
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdo-00038l-0j
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLdn-000388-RB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:55 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:14 +0200
Message-Id: <20170919164337.18555-16-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 15/38] s390x: move s390_virtio_hypercall() to
 s390-virtio-hcall.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Implemented in hw/s390x/s390-virtio-hcall.c, so let's move it to the
right header file.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-6-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-hcall.h | 1 +
 target/s390x/cpu.h           | 1 -
 target/s390x/kvm.c           | 1 +
 target/s390x/misc_helper.c   | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index 59fcba3a06..cbc270eef3 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -17,4 +17,5 @@
 
 typedef int (*s390_virtio_fn)(const uint64_t *args);
 void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
+int s390_virtio_hypercall(CPUS390XState *env);
 #endif /* HW_S390_VIRTIO_HCALL_H */
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 0bd97a5670..7073fa59e9 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -723,6 +723,5 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
 extern void subsystem_reset(void);
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
-int s390_virtio_hypercall(CPUS390XState *env);
 
 #endif
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 375369fd1c..720cb1d833 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -48,6 +48,7 @@
 #include "hw/s390x/ebcdic.h"
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"
+#include "hw/s390x/s390-virtio-hcall.h"
 
 #ifndef DEBUG_KVM
 #define DEBUG_KVM  0
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 50cc046ca2..b142db71c6 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -34,6 +34,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/ebcdic.h"
+#include "hw/s390x/s390-virtio-hcall.h"
 #endif
 
 /* #define DEBUG_HELPER */
-- 
2.13.5
