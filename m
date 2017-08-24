Received: from eggs.gnu.org ([2001:4830:134:3::10]:50988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkxis-0006Re-5j
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkxiq-0001YK-S0
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:23:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkxiq-0001Xg-Lp
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:23:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 24 Aug 2017 16:23:13 -0300
Message-Id: <20170824192315.5897-2-ehabkost@redhat.com>
In-Reply-To: <20170824192315.5897-1-ehabkost@redhat.com>
References: <20170824192315.5897-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] vl: Clean up user-creatable objects
 when exiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Zack Cornelius <zack.cornelius@kove.net>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Delete all user-creatable objects in /objects when exiting QEMU, so they
can perform cleanup actions.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (none)
---
 include/qom/object_interfaces.h | 8 ++++++++
 qom/object_interfaces.c         | 5 +++++
 vl.c                            | 1 +
 3 files changed, 14 insertions(+)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index fdd7603..3f5f206 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -148,4 +148,12 @@ int user_creatable_add_opts_foreach(void *opaque,
  */
 void user_creatable_del(const char *id, Error **errp);
 
+/**
+ * user_creatable_cleanup:
+ *
+ * Delete all user-creatable objects and the user-creatable
+ * objects container.
+ */
+void user_creatable_cleanup(void);
+
 #endif
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index ff27e06..dbf8878 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -193,6 +193,11 @@ void user_creatable_del(const char *id, Error **errp)
     object_unparent(obj);
 }
 
+void user_creatable_cleanup(void)
+{
+    object_unparent(object_get_objects_root());
+}
+
 static void register_types(void)
 {
     static const TypeInfo uc_interface_info = {
diff --git a/vl.c b/vl.c
index 8e247cc..91d0ef0 100644
--- a/vl.c
+++ b/vl.c
@@ -4801,6 +4801,7 @@ int main(int argc, char **argv, char **envp)
     audio_cleanup();
     monitor_cleanup();
     qemu_chr_cleanup();
+    user_creatable_cleanup();
     /* TODO: unref root container, check all devices are ok */
 
     return 0;
-- 
2.9.4
