Received: from eggs.gnu.org ([2001:4830:134:3::10]:32813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dOGUp-0005ik-ES
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dOGUo-0001B0-Gy
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:47:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dOGUo-0001Ah-90
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:47:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38F3561B84
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 04:47:01 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 23 Jun 2017 12:46:37 +0800
Message-Id: <1498193206-18007-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1498193206-18007-1-git-send-email-peterx@redhat.com>
References: <1498193206-18007-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 01/10] machine: export register_compat_prop()
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

We have HW_COMPAT_*, however that's only bound to machines, not other
things (like accelerators).  Behind it, it was register_compat_prop()
that played the trick.  Let's export the function for further use
outside HW_COMPAT_* magic.

Meanwhile, move it to qdev-properties.c where seems more proper (since
it'll be used not only in machine codes).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/machine.c            | 13 -------------
 hw/core/qdev-properties.c    | 13 +++++++++++++
 include/hw/qdev-properties.h |  3 +++
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2e7e977..ecb5552 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -770,19 +770,6 @@ static void machine_class_finalize(ObjectClass *klass, void *data)
     g_free(mc->name);
 }
 
-static void register_compat_prop(const char *driver,
-                                 const char *property,
-                                 const char *value)
-{
-    GlobalProperty *p = g_new0(GlobalProperty, 1);
-    /* Machine compat_props must never cause errors: */
-    p->errp = &error_abort;
-    p->driver = driver;
-    p->property = property;
-    p->value = value;
-    qdev_prop_register_global(p);
-}
-
 static void machine_register_compat_for_subclass(ObjectClass *oc, void *opaque)
 {
     GlobalProperty *p = opaque;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 9f1a497..6ff1ac3 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1047,6 +1047,19 @@ void qdev_prop_register_global(GlobalProperty *prop)
     global_props = g_list_append(global_props, prop);
 }
 
+void register_compat_prop(const char *driver,
+                          const char *property,
+                          const char *value)
+{
+    GlobalProperty *p = g_new0(GlobalProperty, 1);
+    /* Machine compat_props must never cause errors: */
+    p->errp = &error_abort;
+    p->driver = driver;
+    p->property = property;
+    p->value = value;
+    qdev_prop_register_global(p);
+}
+
 void qdev_prop_register_global_list(GlobalProperty *props)
 {
     int i;
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index d206fc9..1722ca4 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -201,6 +201,9 @@ void qdev_prop_set_globals(DeviceState *dev);
 void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
                                     Property *prop, const char *value);
 
+void register_compat_prop(const char *driver, const char *property,
+                          const char *value);
+
 /**
  * qdev_property_add_static:
  * @dev: Device to add the property to.
-- 
2.7.4
