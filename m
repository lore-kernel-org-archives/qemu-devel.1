Received: from eggs.gnu.org ([2001:4830:134:3::10]:57496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNnz-00013k-FR
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNny-0005rt-J9
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:59:27 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 13:58:19 +0100
Message-Id: <20180301125830.24377-17-cohuck@redhat.com>
In-Reply-To: <20180301125830.24377-1-cohuck@redhat.com>
References: <20180301125830.24377-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 16/27] s390/stattrib: Make SaveVMHandlers
 data static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

There's no need for this to be dynamic, make it static.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180212154903.8859-1-dgilbert@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-stattrib.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index a1d2135a60..adf07ef312 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -365,22 +365,22 @@ static inline void s390_stattrib_set_migration_enabled(Object *obj, bool value,
     s->migration_enabled = value;
 }
 
+static SaveVMHandlers savevm_s390_stattrib_handlers = {
+    .save_setup = cmma_save_setup,
+    .save_live_iterate = cmma_save_iterate,
+    .save_live_complete_precopy = cmma_save_complete,
+    .save_live_pending = cmma_save_pending,
+    .save_cleanup = cmma_save_cleanup,
+    .load_state = cmma_load,
+    .is_active = cmma_active,
+};
+
 static void s390_stattrib_instance_init(Object *obj)
 {
     S390StAttribState *sas = S390_STATTRIB(obj);
-    SaveVMHandlers *ops;
-
-    /* ops will always be freed by qemu when unregistering */
-    ops = g_new0(SaveVMHandlers, 1);
-
-    ops->save_setup = cmma_save_setup;
-    ops->save_live_iterate = cmma_save_iterate;
-    ops->save_live_complete_precopy = cmma_save_complete;
-    ops->save_live_pending = cmma_save_pending;
-    ops->save_cleanup = cmma_save_cleanup;
-    ops->load_state = cmma_load;
-    ops->is_active = cmma_active;
-    register_savevm_live(NULL, TYPE_S390_STATTRIB, 0, 0, ops, sas);
+
+    register_savevm_live(NULL, TYPE_S390_STATTRIB, 0, 0,
+                         &savevm_s390_stattrib_handlers, sas);
 
     object_property_add_bool(obj, "migration-enabled",
                              s390_stattrib_get_migration_enabled,
-- 
2.13.6
