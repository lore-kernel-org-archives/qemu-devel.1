Received: from eggs.gnu.org ([2001:4830:134:3::10]:42369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8M-0002r0-31
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8L-0004KL-0C
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMw8K-0004Jf-N1
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AD0C80C09
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:50:19 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Jun 2017 20:49:37 +0800
Message-Id: <1497876588-947-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1497876588-947-1-git-send-email-peterx@redhat.com>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/13] qdev: enhance global_prop_list_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Originally it can only alloc new entries and insert. Let it be smarter
that it can update existing fields, and even delete elements. This is
preparation of (finally) the replacement of x86_cpu_apply_props(). If
you see x86_cpu_apply_props(), it allows to skip entries when value is
NULL. Here, it works just like deleting an existing entry.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/qdev-properties.c    | 28 +++++++++++++++++++++++++++-
 include/hw/qdev-properties.h | 10 ++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 4b74382..dc3b0ac 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1045,7 +1045,33 @@ static GList *global_props;
 GList *global_prop_list_add(GList *list, const char *driver,
                             const char *property, const char *value)
 {
-    GlobalProperty *p = g_new0(GlobalProperty, 1);
+    GList *l;
+    GlobalProperty *p;
+
+    /* Look up the (property, value) first in the list */
+    for (l = list; l; l = l->next) {
+        p = l->data;
+        if (!strcmp(driver, p->driver) && !strcmp(property, p->property)) {
+            if (value) {
+                /* Modify existing value */
+                p->value = value;
+            } else {
+                /* Delete this entry entirely */
+                list = g_list_remove_link(list, l);
+                g_free(p);
+                g_list_free(l);
+            }
+            return list;
+        }
+    }
+
+    /* Entry not exist. If we are deleting one entry, we're done. */
+    if (!value) {
+        return list;
+    }
+
+    /* If not found and value is set, we try to create a new entry */
+    p = g_new0(GlobalProperty, 1);
 
     /* These properties cannot fail the apply */
     p->errp = &error_abort;
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 15ee6ba..55ad507 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -201,6 +201,16 @@ void qdev_prop_set_globals(DeviceState *dev);
 void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
                                     Property *prop, const char *value);
 
+/*
+ * Register global property on the list. Elements of list should be
+ * GlobalProperty.
+ *
+ * - If (driver, property) is not existing on the list, create a new
+ *   one and link to the list.
+ * - If (driver, property) exists on the list, then:
+ *   - if value != NULL, update with new value
+ *   - if value == NULL, delete the entry
+ */
 GList *global_prop_list_add(GList *list, const char *driver,
                             const char *property, const char *value);
 void register_compat_prop(const char *driver, const char *property,
-- 
2.7.4
