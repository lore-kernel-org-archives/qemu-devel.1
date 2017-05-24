Received: from eggs.gnu.org ([2001:4830:134:3::10]:44563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDS4q-0007ak-4O
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDS4p-000725-DV
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dDS4p-00071e-7A
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:31 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 24 May 2017 10:55:19 +0200
Message-Id: <20170524085519.22856-4-quintela@redhat.com>
In-Reply-To: <20170524085519.22856-1-quintela@redhat.com>
References: <20170524085519.22856-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] migration: Remove section_id parameter
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Juan Quintela <quintela@trasno.org>

From: Juan Quintela <quintela@trasno.org>

Everything else assumes that we always load a device from its own
savevm handler.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 96b7173..e847a6b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -721,13 +721,13 @@ void vmstate_unregister(DeviceState *dev, const VMStateDescription *vmsd,
     }
 }
 
-static int vmstate_load(QEMUFile *f, SaveStateEntry *se, int version_id)
+static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
 {
     trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {         /* Old style */
-        return se->ops->load_state(f, se->opaque, version_id);
+        return se->ops->load_state(f, se->opaque, se->version_id);
     }
-    return vmstate_load_state(f, se->vmsd, se->opaque, version_id);
+    return vmstate_load_state(f, se->vmsd, se->opaque, se->version_id);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se, QJSON *vmdesc)
@@ -1855,7 +1855,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
-    ret = vmstate_load(f, se, se->version_id);
+    ret = vmstate_load(f, se);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%x of"
                      " device '%s'", instance_id, idstr);
@@ -1888,7 +1888,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
-    ret = vmstate_load(f, se, se->version_id);
+    ret = vmstate_load(f, se);
     if (ret < 0) {
         error_report("error while loading state section id %d(%s)",
                      section_id, se->idstr);
-- 
2.9.3
