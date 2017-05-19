Received: from eggs.gnu.org ([2001:4830:134:3::10]:36786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbdx-0000ll-IF
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbdw-0004Ej-7y
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBbdv-0004Ee-V5
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:44:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD856C056782
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:44:06 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 14:43:32 +0800
Message-Id: <1495176212-14446-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1495176212-14446-1-git-send-email-peterx@redhat.com>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 6/6] migration: enable return path for
 precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Let this be a flag, default to on. Turn it off for <=2.9 versions.

After this patch, return path will be on even for pre-copy migration as
long as the transport support, e.g., for socket typed transport
including "tcp|udp|unix" typed.

This will naturally fix the bug mentioned below, when destination failed
on migration but source assumed it was successful - since now even for
precopy, source will wait for destination's MIG_RP_MSG_SHUT signal,
which will carry the final migration status of destination. Then, when
destination failed at any point of migration, source will know it, and
it'll resume the VM instead of a data lost.

Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1439147
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/compat.h           |  4 ++++
 include/migration/migration.h |  3 +++
 migration/migration.c         | 15 ++++++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 55b1765..049457b 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -6,6 +6,10 @@
         .driver   = "pci-bridge",\
         .property = "shpc",\
         .value    = "off",\
+    },{\
+        .driver   = "migration",\
+        .property = "return-path",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_8 \
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 70710de..e44119c 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -169,6 +169,9 @@ typedef struct MigrationState {
     int64_t colo_checkpoint_time;
     QEMUTimer *colo_delay_timer;
 
+    /* Whether to try to enable return-path even for pre-copy */
+    bool enable_return_path;
+
     /* The last error that occurred */
     Error *error;
 } MigrationState ;
diff --git a/migration/migration.c b/migration/migration.c
index 6df3483..16a856a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2046,7 +2046,7 @@ static void *migration_thread(void *opaque)
 static bool migrate_return_path_create(MigrationState *s)
 {
     /* Whether we should enable return path */
-    bool enable_return_path = false;
+    bool enable_return_path = s->enable_return_path;
     /* Whether we should force its success */
     bool force_return_path = false;
 
@@ -2114,9 +2114,22 @@ static void migration_instance_init(Object *obj)
     ms->parameters.tls_hostname = g_strdup("");
 }
 
+static Property migration_properties[] = {
+    DEFINE_PROP_BOOL("return-path", MigrationState, enable_return_path, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void migration_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->props = migration_properties;
+}
+
 static const TypeInfo migration_type = {
     .name = TYPE_MIGRATION,
     .parent = TYPE_DEVICE,
+    .class_init = migration_class_init,
     .class_size = sizeof(MigrationClass),
     .instance_size = sizeof(MigrationState),
     .instance_init = migration_instance_init,
-- 
2.7.4
