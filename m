Received: from eggs.gnu.org ([2001:4830:134:3::10]:47550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5X-00060Y-Gr
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5T-0007Ol-Nr
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:19 -0400
Received: from mail-eopbgr30103.outbound.protection.outlook.com
	([40.107.3.103]:45293
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dIJ5T-0007Ny-DX
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:15 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Jun 2017 21:19:43 +0300
Message-Id: <20170606181948.16238-19-rkagan@virtuozzo.com>
In-Reply-To: <20170606181948.16238-1-rkagan@virtuozzo.com>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 18/23] hyperv: add synic event flag signaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Add infrastructure to signal SynIC event flags by atomically setting the
corresponding bit in the event flags page and firing a SINT if
necessary.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.h |  2 ++
 target/i386/hyperv.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index fa3e988..a2d4304 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -39,4 +39,6 @@ void hyperv_synic_update(X86CPU *cpu);
 
 int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *msg);
 
+int hyperv_set_evt_flag(HvSintRoute *sint_route, unsigned evtno);
+
 #endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 0a7f9b1..dcf49e4 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -17,6 +17,7 @@
 #include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
 #include "sysemu/cpus.h"
+#include "qemu/bitops.h"
 #include "migration/vmstate.h"
 #include "hyperv.h"
 #include "hyperv_proto.h"
@@ -189,6 +190,37 @@ int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *src_msg)
     return 0;
 }
 
+/*
+ * Set given event flag for a given sint on a given vcpu, and signal the sint.
+ */
+int hyperv_set_evt_flag(HvSintRoute *sint_route, unsigned evtno)
+{
+    int ret;
+    SynICState *synic = sint_route->synic;
+    unsigned long *flags, set_mask;
+    unsigned set_idx;
+
+    if (evtno > HV_EVENT_FLAGS_COUNT) {
+        return -EINVAL;
+    }
+    if (!synic->enabled || !synic->evt_page_addr) {
+        return -ENXIO;
+    }
+
+    set_idx = BIT_WORD(evtno);
+    set_mask = BIT_MASK(evtno);
+    flags = synic->evt_page->slot[sint_route->sint].flags;
+
+    if ((atomic_fetch_or(&flags[set_idx], set_mask) & set_mask) != set_mask) {
+        ret = kvm_hv_sint_route_set_sint(sint_route);
+        memory_region_set_dirty(&synic->evt_page_mr, 0,
+                                sizeof(*synic->evt_page));
+    } else {
+        ret = 0;
+    }
+    return ret;
+}
+
 static void async_synic_update(CPUState *cs, run_on_cpu_data data)
 {
     SynICState *synic = data.host_ptr;
-- 
2.9.4
