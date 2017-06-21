Received: from eggs.gnu.org ([2001:4830:134:3::10]:35431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiSg-0007aH-22
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiSd-0004jx-EK
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:34 -0400
Received: from mail-eopbgr30133.outbound.protection.outlook.com
	([40.107.3.133]:11974
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiSd-0004jO-30
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:31 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:19 +0300
Message-Id: <20170621162424.10462-19-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 18/23] hyperv: add synic event flag signaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Igor Mammedov <imammedo@redhat.com>

Add infrastructure to signal SynIC event flags by atomically setting the
corresponding bit in the event flags page and firing a SINT if
necessary.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v1 -> v2:
 - swapped kvm_hv_sint_route_set_sint and memory_region_set_dirty

 target/i386/hyperv.h |  2 ++
 target/i386/hyperv.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index cc08ebb..f171f7b 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -41,4 +41,6 @@ bool hyperv_synic_usable(void);
 
 int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *msg);
 
+int hyperv_set_evt_flag(HvSintRoute *sint_route, unsigned evtno);
+
 #endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 768dc2b..a96b03b 100644
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
@@ -203,6 +204,37 @@ int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *src_msg)
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
+        memory_region_set_dirty(&synic->evt_page_mr, 0,
+                                sizeof(*synic->evt_page));
+        ret = kvm_hv_sint_route_set_sint(sint_route);
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
