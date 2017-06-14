Received: from eggs.gnu.org ([2001:4830:134:3::10]:34331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEvf-0000v2-MV
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEve-0005iQ-D4
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dLEve-0005iH-6w
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E9AB334599
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 20:30:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 14 Jun 2017 17:29:56 -0300
Message-Id: <20170614203000.19984-2-ehabkost@redhat.com>
In-Reply-To: <20170614203000.19984-1-ehabkost@redhat.com>
References: <20170614203000.19984-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] vl: Clean up user-creatable objects when
 exiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Delete all user-creatable objects in /objects when exiting QEMU, so they
can perform cleanup actions.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object_interfaces.h | 8 ++++++++
 qom/object_interfaces.c         | 5 +++++
 vl.c                            | 1 +
 3 files changed, 14 insertions(+)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index fdd7603c84..3f5f206921 100644
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
index ff27e0669e..dbf8878322 100644
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
index 32db19e3b9..4e9a7fd05a 100644
--- a/vl.c
+++ b/vl.c
@@ -4762,6 +4762,7 @@ int main(int argc, char **argv, char **envp)
     audio_cleanup();
     monitor_cleanup();
     qemu_chr_cleanup();
+    user_creatable_cleanup();
     /* TODO: unref root container, check all devices are ok */
 
     return 0;
-- 
2.11.0.259.g40922b1
