Received: from eggs.gnu.org ([2001:4830:134:3::10]:42435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8Y-0002wg-Io
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8W-0004SQ-Tt
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMw8W-0004RZ-Kz
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B57681129
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:50:31 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Jun 2017 20:49:39 +0800
Message-Id: <1497876588-947-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1497876588-947-1-git-send-email-peterx@redhat.com>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/13] accel: introduce
 AccelState.global_props
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

Introduce this new field for the accelerator instances so that each
specific accelerator in the future can register its own global
properties to be used further by the system.  It works just like how the
old machine compatible properties do, but only tailored for
accelerators.

Use the newly exported register_compat_prop() to pass the accelerator
global properties to the global_props list.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel.c                | 12 ++++++++++++
 include/sysemu/accel.h | 11 +++++++++++
 vl.c                   |  1 +
 3 files changed, 24 insertions(+)

diff --git a/accel.c b/accel.c
index 62edd29..f747d65 100644
--- a/accel.c
+++ b/accel.c
@@ -130,6 +130,18 @@ void configure_accelerator(MachineState *ms)
     }
 }
 
+static void accel_prop_pass_to_global(gpointer data, gpointer user_data)
+{
+    GlobalProperty *prop = data;
+
+    register_compat_prop(prop->driver, prop->property,
+                         prop->value, false);
+}
+
+void accel_register_compat_props(AccelState *accel)
+{
+    g_list_foreach(accel->global_props, accel_prop_pass_to_global, NULL);
+}
 
 static void tcg_accel_class_init(ObjectClass *oc, void *data)
 {
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 15944c1..83bb60e 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -28,6 +28,15 @@
 typedef struct AccelState {
     /*< private >*/
     Object parent_obj;
+
+    /*< public >*/
+    /*
+     * Global properties that would be applied when specific
+     * accelerator is chosen. It works just like
+     * MachineState.compat_props but it's for accelerators not
+     * machines.
+     */
+    GList *global_props;
 } AccelState;
 
 typedef struct AccelClass {
@@ -57,5 +66,7 @@ typedef struct AccelClass {
 extern int tcg_tb_size;
 
 void configure_accelerator(MachineState *ms);
+/* Register accelerator specific global properties */
+void accel_register_compat_props(AccelState *accel);
 
 #endif
diff --git a/vl.c b/vl.c
index c58ffc0..d3f5594 100644
--- a/vl.c
+++ b/vl.c
@@ -4553,6 +4553,7 @@ int main(int argc, char **argv, char **envp)
             exit (i == 1 ? 1 : 0);
     }
 
+    accel_register_compat_props(current_machine->accelerator);
     machine_register_compat_props(current_machine);
 
     qemu_opts_foreach(qemu_find_opts("global"),
-- 
2.7.4
