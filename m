Received: from eggs.gnu.org ([2001:4830:134:3::10]:49963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBBp-0002t2-Bf
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBBj-0004Sg-AK
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQBBj-0004Rk-0Q
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1872D142868
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 11:31:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Jun 2017 13:30:54 +0200
Message-Id: <20170628113106.5248-3-quintela@redhat.com>
In-Reply-To: <20170628113106.5248-1-quintela@redhat.com>
References: <20170628113106.5248-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 02/14] accel: introduce AccelClass.global_props
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

From: Peter Xu <peterx@redhat.com>

Introduce this new field for the accelerator classes so that each
specific accelerator in the future can register its own global
properties to be used further by the system. It works just like how the
old machine compatible properties do, but only tailored for
accelerators.

Introduce register_compat_props_array() for it. Export it so that it may
be used in other codes as well in the future.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1498536619-14548-3-git-send-email-peterx@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 accel/accel.c                |  6 ++++++
 hw/core/qdev-properties.c    |  7 +++++++
 include/hw/qdev-properties.h |  6 ++++++
 include/sysemu/accel.h       | 11 +++++++++++
 vl.c                         |  1 +
 5 files changed, 31 insertions(+)

diff --git a/accel/accel.c b/accel/accel.c
index 7c079a5..fa85844 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -120,6 +120,12 @@ void configure_accelerator(MachineState *ms)
     }
 }
 
+void accel_register_compat_props(AccelState *accel)
+{
+    AccelClass *class = ACCEL_GET_CLASS(accel);
+    register_compat_props_array(class->global_props);
+}
+
 static void register_accel_types(void)
 {
     type_register_static(&accel_type);
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index adf62ad..f11d578 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1098,6 +1098,13 @@ void register_compat_prop(const char *driver,
     qdev_prop_register_global(p);
 }
 
+void register_compat_props_array(GlobalProperty *prop)
+{
+    for (; prop && prop->driver; prop++) {
+        register_compat_prop(prop->driver, prop->property, prop->value);
+    }
+}
+
 void qdev_prop_register_global_list(GlobalProperty *props)
 {
     int i;
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 50ade83..0604c33 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -231,6 +231,12 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
  */
 void register_compat_prop(const char *driver, const char *property,
                           const char *value);
+/*
+ * register_compat_props_array(): using register_compat_prop(), which
+ * only registers internal global properties (which has lower priority
+ * than user-provided global properties)
+ */
+void register_compat_props_array(GlobalProperty *prop);
 
 /**
  * qdev_property_add_static:
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 15944c1..ecc5c84 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -24,6 +24,7 @@
 #define HW_ACCEL_H
 
 #include "qom/object.h"
+#include "hw/qdev-properties.h"
 
 typedef struct AccelState {
     /*< private >*/
@@ -40,6 +41,14 @@ typedef struct AccelClass {
     int (*available)(void);
     int (*init_machine)(MachineState *ms);
     bool *allowed;
+    /*
+     * Array of global properties that would be applied when specific
+     * accelerator is chosen. It works like MachineClass.compat_props
+     * but it's for accelerators not machines. Accelerator-provided
+     * global properties may be overridden by machine-type
+     * compat_props or user-provided global properties.
+     */
+    GlobalProperty *global_props;
 } AccelClass;
 
 #define TYPE_ACCEL "accel"
@@ -57,5 +66,7 @@ typedef struct AccelClass {
 extern int tcg_tb_size;
 
 void configure_accelerator(MachineState *ms);
+/* Register accelerator specific global properties */
+void accel_register_compat_props(AccelState *accel);
 
 #endif
diff --git a/vl.c b/vl.c
index 59fea15..4452d7a 100644
--- a/vl.c
+++ b/vl.c
@@ -4571,6 +4571,7 @@ int main(int argc, char **argv, char **envp)
             exit (i == 1 ? 1 : 0);
     }
 
+    accel_register_compat_props(current_machine->accelerator);
     machine_register_compat_props(current_machine);
 
     qemu_opts_foreach(qemu_find_opts("global"),
-- 
2.9.4
