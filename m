Received: from eggs.gnu.org ([2001:4830:134:3::10]:53838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFceV-0001O9-E5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFceU-0005UB-I3
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:37:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFceU-0005U5-CC
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:37:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6600FC049DFD
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:37:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 30 May 2017 10:37:05 +0200
Message-Id: <20170530083705.15141-4-quintela@redhat.com>
In-Reply-To: <20170530083705.15141-1-quintela@redhat.com>
References: <20170530083705.15141-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] migration: Remove section_id parameter
 from vmstate_load
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

Everything else assumes that we always load a device from its own
savevm handler.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 14af5ad..e5dd7ef 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -723,13 +723,13 @@ void vmstate_unregister(DeviceState *dev, const VMStateDescription *vmsd,
     }
 }
 
-static int vmstate_load(QEMUFile *f, SaveStateEntry *se, int version_id)
+static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
 {
     trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {         /* Old style */
-        return se->ops->load_state(f, se->opaque, version_id);
+        return se->ops->load_state(f, se->opaque, se->load_version_id);
     }
-    return vmstate_load_state(f, se->vmsd, se->opaque, version_id);
+    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se, QJSON *vmdesc)
@@ -1858,7 +1858,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
-    ret = vmstate_load(f, se, se->load_version_id);
+    ret = vmstate_load(f, se);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%x of"
                      " device '%s'", instance_id, idstr);
@@ -1891,7 +1891,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
-    ret = vmstate_load(f, se, se->load_version_id);
+    ret = vmstate_load(f, se);
     if (ret < 0) {
         error_report("error while loading state section id %d(%s)",
                      section_id, se->idstr);
-- 
2.9.4
