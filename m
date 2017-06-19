Received: from eggs.gnu.org ([2001:4830:134:3::10]:42409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8V-0002u7-9o
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8Q-0004N6-Te
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMw8Q-0004MA-Je
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 854EC81F01
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:50:25 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Jun 2017 20:49:38 +0800
Message-Id: <1497876588-947-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1497876588-947-1-git-send-email-peterx@redhat.com>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/13] qdev: remove
 qdev_prop_register_global()
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

It works very similar to register_compat_prop() but does not need a
malloc, however mostly all the callers of it are doing malloc on their
own. Then it makes little sense to keep it.

Replacing all the callers with register_compat_prop(), meanwhile adding
one more parameter "user_provided" for it to make it even more
powerful (there is only one usage of it to be true).

This greatly reduces tens of LOCs and should have no functional change.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/machine.c            |  6 ++++--
 hw/core/qdev-properties.c    | 20 ++++++++++----------
 include/hw/qdev-properties.h |  6 +++---
 qom/cpu.c                    |  8 ++------
 target/i386/cpu.c            |  9 ++-------
 vl.c                         | 39 +++++++++------------------------------
 6 files changed, 30 insertions(+), 58 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index b4b3449..181f69d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -774,7 +774,8 @@ static void machine_class_finalize(ObjectClass *klass, void *data)
 static void machine_register_compat_for_subclass(ObjectClass *oc, void *opaque)
 {
     GlobalProperty *p = opaque;
-    register_compat_prop(object_class_get_name(oc), p->property, p->value);
+    register_compat_prop(object_class_get_name(oc), p->property,
+                         p->value, false);
 }
 
 void machine_register_compat_props(MachineState *machine)
@@ -804,7 +805,8 @@ void machine_register_compat_props(MachineState *machine)
             object_class_foreach(machine_register_compat_for_subclass,
                                  p->driver, false, p);
         } else {
-            register_compat_prop(p->driver, p->property, p->value);
+            register_compat_prop(p->driver, p->property,
+                                 p->value, false);
         }
     }
 }
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index dc3b0ac..e9efb78 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1043,7 +1043,8 @@ void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value)
 static GList *global_props;
 
 GList *global_prop_list_add(GList *list, const char *driver,
-                            const char *property, const char *value)
+                            const char *property, const char *value,
+                            bool user_provided)
 {
     GList *l;
     GlobalProperty *p;
@@ -1055,6 +1056,7 @@ GList *global_prop_list_add(GList *list, const char *driver,
             if (value) {
                 /* Modify existing value */
                 p->value = value;
+                p->user_provided = user_provided;
             } else {
                 /* Delete this entry entirely */
                 list = g_list_remove_link(list, l);
@@ -1078,21 +1080,18 @@ GList *global_prop_list_add(GList *list, const char *driver,
     p->driver = driver;
     p->property = property;
     p->value = value;
+    p->user_provided = user_provided;
 
     return g_list_append(list, p);
 }
 
 void register_compat_prop(const char *driver,
                           const char *property,
-                          const char *value)
+                          const char *value,
+                          bool user_provided)
 {
-    global_props = global_prop_list_add(global_props, driver,
-                                        property, value);
-}
-
-void qdev_prop_register_global(GlobalProperty *prop)
-{
-    global_props = g_list_append(global_props, prop);
+    global_props = global_prop_list_add(global_props, driver, property,
+                                        value, user_provided);
 }
 
 void qdev_prop_register_global_list(GlobalProperty *props)
@@ -1100,7 +1099,8 @@ void qdev_prop_register_global_list(GlobalProperty *props)
     int i;
 
     for (i = 0; props[i].driver != NULL; i++) {
-        qdev_prop_register_global(props+i);
+        register_compat_prop(props[i].driver, props[i].property,
+                             props[i].value, props[i].user_provided);
     }
 }
 
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 55ad507..8a63c2e 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -194,7 +194,6 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 /* FIXME: Remove opaque pointer properties.  */
 void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value);
 
-void qdev_prop_register_global(GlobalProperty *prop);
 void qdev_prop_register_global_list(GlobalProperty *props);
 int qdev_prop_check_globals(void);
 void qdev_prop_set_globals(DeviceState *dev);
@@ -212,9 +211,10 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
  *   - if value == NULL, delete the entry
  */
 GList *global_prop_list_add(GList *list, const char *driver,
-                            const char *property, const char *value);
+                            const char *property, const char *value,
+                            bool user_provided);
 void register_compat_prop(const char *driver, const char *property,
-                          const char *value);
+                          const char *value, bool user_provided);
 
 /**
  * qdev_property_add_static:
diff --git a/qom/cpu.c b/qom/cpu.c
index 5069876..1027d90 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -342,14 +342,10 @@ static void cpu_common_parse_features(const char *typename, char *features,
     while (featurestr) {
         val = strchr(featurestr, '=');
         if (val) {
-            GlobalProperty *prop = g_new0(typeof(*prop), 1);
             *val = 0;
             val++;
-            prop->driver = typename;
-            prop->property = g_strdup(featurestr);
-            prop->value = g_strdup(val);
-            prop->errp = &error_fatal;
-            qdev_prop_register_global(prop);
+            register_compat_prop(typename, g_strdup(featurestr),
+                                 g_strdup(val), false);
         } else {
             error_setg(errp, "Expected key=value format, found %s.",
                        featurestr);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b2b1d20..1bd20e2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2039,7 +2039,6 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
         const char *val = NULL;
         char *eq = NULL;
         char num[32];
-        GlobalProperty *prop;
 
         /* Compatibility syntax: */
         if (featurestr[0] == '+') {
@@ -2091,12 +2090,8 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
             name = "tsc-frequency";
         }
 
-        prop = g_new0(typeof(*prop), 1);
-        prop->driver = typename;
-        prop->property = g_strdup(name);
-        prop->value = g_strdup(val);
-        prop->errp = &error_fatal;
-        qdev_prop_register_global(prop);
+        register_compat_prop(typename, g_strdup(name),
+                             g_strdup(val), false);
     }
 
     if (ambiguous) {
diff --git a/vl.c b/vl.c
index 32db19e..c58ffc0 100644
--- a/vl.c
+++ b/vl.c
@@ -891,13 +891,8 @@ static void configure_rtc(QemuOpts *opts)
     value = qemu_opt_get(opts, "driftfix");
     if (value) {
         if (!strcmp(value, "slew")) {
-            static GlobalProperty slew_lost_ticks = {
-                .driver   = "mc146818rtc",
-                .property = "lost_tick_policy",
-                .value    = "slew",
-            };
-
-            qdev_prop_register_global(&slew_lost_ticks);
+            register_compat_prop("mc146818rtc", "lost_tick_policy",
+                                 "slew", false);
         } else if (!strcmp(value, "none")) {
             /* discard is default */
         } else {
@@ -2945,15 +2940,9 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
 
 static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
-    GlobalProperty *g;
-
-    g = g_malloc0(sizeof(*g));
-    g->driver   = qemu_opt_get(opts, "driver");
-    g->property = qemu_opt_get(opts, "property");
-    g->value    = qemu_opt_get(opts, "value");
-    g->user_provided = true;
-    g->errp = &error_fatal;
-    qdev_prop_register_global(g);
+    register_compat_prop(qemu_opt_get(opts, "driver"),
+                         qemu_opt_get(opts, "property"),
+                         qemu_opt_get(opts, "value"), true);
     return 0;
 }
 
@@ -3689,13 +3678,8 @@ int main(int argc, char **argv, char **envp)
                 win2k_install_hack = 1;
                 break;
             case QEMU_OPTION_rtc_td_hack: {
-                static GlobalProperty slew_lost_ticks = {
-                    .driver   = "mc146818rtc",
-                    .property = "lost_tick_policy",
-                    .value    = "slew",
-                };
-
-                qdev_prop_register_global(&slew_lost_ticks);
+                register_compat_prop("mc146818rtc", "lost_tick_policy",
+                                     "slew", false);
                 break;
             }
             case QEMU_OPTION_acpitable:
@@ -3746,15 +3730,10 @@ int main(int argc, char **argv, char **envp)
                 break;
             }
             case QEMU_OPTION_no_kvm_pit_reinjection: {
-                static GlobalProperty kvm_pit_lost_tick_policy = {
-                    .driver   = "kvm-pit",
-                    .property = "lost_tick_policy",
-                    .value    = "discard",
-                };
-
                 error_report("warning: deprecated, replaced by "
                              "-global kvm-pit.lost_tick_policy=discard");
-                qdev_prop_register_global(&kvm_pit_lost_tick_policy);
+                register_compat_prop("kvm-pit", "lost_tick_policy",
+                                     "discard", false);
                 break;
             }
             case QEMU_OPTION_accel: {
-- 
2.7.4
