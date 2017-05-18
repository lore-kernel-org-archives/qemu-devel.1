Received: from eggs.gnu.org ([2001:4830:134:3::10]:48557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBNRG-0002q9-Ra
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBNRF-000083-Ns
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:34:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBNRF-00007h-Fr
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:34:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 776B87D0C1
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 15:34:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 17:33:50 +0200
Message-Id: <20170518153350.30094-3-quintela@redhat.com>
In-Reply-To: <20170518153350.30094-1-quintela@redhat.com>
References: <20170518153350.30094-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] migration: Make savevm.c target
 independent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

It only needed TARGET_PAGE_SIZE/BITS/BITS_MIN values, so just export
them from exec.h

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 Makefile.target            |  2 +-
 exec.c                     |  9 +++++++++
 include/exec/target_page.h |  2 ++
 migration/Makefile.objs    |  2 +-
 migration/savevm.c         | 14 +++++++-------
 5 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 465a633..ce8dfe4 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -146,7 +146,7 @@ obj-$(CONFIG_KVM) += kvm-all.o
 obj-y += memory.o cputlb.o
 obj-y += memory_mapping.o
 obj-y += dump.o
-obj-y += migration/ram.o migration/savevm.o
+obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
 # Hardware support
diff --git a/exec.c b/exec.c
index de2961b..ff16f04 100644
--- a/exec.c
+++ b/exec.c
@@ -3444,6 +3444,15 @@ size_t qemu_target_page_size(void)
     return TARGET_PAGE_SIZE;
 }
 
+int qemu_target_page_bits(void)
+{
+    return TARGET_PAGE_BITS;
+}
+
+int qemu_target_page_bits_min(void)
+{
+    return TARGET_PAGE_BITS_MIN;
+}
 #endif
 
 /*
diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index 626eda8..96726c3 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -15,5 +15,7 @@
 #define EXEC_TARGET_PAGE_H
 
 size_t qemu_target_page_size(void);
+int qemu_target_page_bits(void);
+int qemu_target_page_bits_min(void);
 
 #endif
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 3272415..90f8c1f 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -1,5 +1,5 @@
 common-obj-y += migration.o socket.o fd.o exec.o
-common-obj-y += tls.o channel.o
+common-obj-y += tls.o channel.o savevm.o
 common-obj-y += colo-comm.o colo.o colo-failover.o
 common-obj-y += vmstate.o vmstate-types.o page_cache.o
 common-obj-y += qemu-file.o
diff --git a/migration/savevm.c b/migration/savevm.c
index 8763700..d971e5e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -27,7 +27,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "hw/boards.h"
 #include "hw/hw.h"
 #include "hw/qdev.h"
@@ -288,7 +287,7 @@ static void configuration_pre_save(void *opaque)
 
     state->len = strlen(current_name);
     state->name = current_name;
-    state->target_page_bits = TARGET_PAGE_BITS;
+    state->target_page_bits = qemu_target_page_bits();
 }
 
 static int configuration_pre_load(void *opaque)
@@ -299,7 +298,7 @@ static int configuration_pre_load(void *opaque)
      * predates the variable-target-page-bits support and is using the
      * minimum possible value for this CPU.
      */
-    state->target_page_bits = TARGET_PAGE_BITS_MIN;
+    state->target_page_bits = qemu_target_page_bits_min();
     return 0;
 }
 
@@ -314,9 +313,9 @@ static int configuration_post_load(void *opaque, int version_id)
         return -EINVAL;
     }
 
-    if (state->target_page_bits != TARGET_PAGE_BITS) {
+    if (state->target_page_bits != qemu_target_page_bits()) {
         error_report("Received TARGET_PAGE_BITS is %d but local is %d",
-                     state->target_page_bits, TARGET_PAGE_BITS);
+                     state->target_page_bits, qemu_target_page_bits());
         return -EINVAL;
     }
 
@@ -332,7 +331,8 @@ static int configuration_post_load(void *opaque, int version_id)
  */
 static bool vmstate_target_page_bits_needed(void *opaque)
 {
-    return TARGET_PAGE_BITS > TARGET_PAGE_BITS_MIN;
+    return qemu_target_page_bits()
+        > qemu_target_page_bits_min();
 }
 
 static const VMStateDescription vmstate_target_page_bits = {
@@ -1138,7 +1138,7 @@ void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
     }
 
     vmdesc = qjson_new();
-    json_prop_int(vmdesc, "page_size", TARGET_PAGE_SIZE);
+    json_prop_int(vmdesc, "page_size", qemu_target_page_size());
     json_start_array(vmdesc, "devices");
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
 
-- 
2.9.3
