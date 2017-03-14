Received: from eggs.gnu.org ([2001:4830:134:3::10]:38270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnpEx-0008Qy-Rn
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnpEs-0002EF-P8
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:24:03 -0400
Received: from mail-db5eur01on0129.outbound.protection.outlook.com
	([104.47.2.129]:53500
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <janne.huttunen@nokia.com>)
	id 1cnpEs-0002Cx-Bn
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:23:58 -0400
From: Janne Huttunen <janne.huttunen@nokia.com>
Date: Tue, 14 Mar 2017 14:50:08 +0200
Message-ID: <3cb0b0330026e3b531f8eee8f2aa492f59ff75d2.1489494746.git.janne.huttunen@nokia.com>
In-Reply-To: <cover.1489494746.git.janne.huttunen@nokia.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC][PATCH 1/6] Re-factor bootdevice list handling,
 pt1.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: janne.huttunen@nokia.com

Pass the list as a parameter instead of referencing it directly. This
is done so that a second list can be added in a later patch.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
---
 bootdevice.c | 49 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index 33e3029..a29d43b 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-core.h"
 
 typedef struct FWBootEntry FWBootEntry;
+typedef QTAILQ_HEAD(, FWBootEntry) FWBootList;
 
 struct FWBootEntry {
     QTAILQ_ENTRY(FWBootEntry) link;
@@ -39,8 +40,7 @@ struct FWBootEntry {
     char *suffix;
 };
 
-static QTAILQ_HEAD(, FWBootEntry) fw_boot_order =
-    QTAILQ_HEAD_INITIALIZER(fw_boot_order);
+static FWBootList fw_boot_order = QTAILQ_HEAD_INITIALIZER(fw_boot_order);
 static QEMUBootSetHandler *boot_set_handler;
 static void *boot_set_opaque;
 
@@ -116,12 +116,13 @@ void restore_boot_order(void *opaque)
     g_free(normal_boot_order);
 }
 
-void check_boot_index(int32_t bootindex, Error **errp)
+static void do_check_boot_index(FWBootList *bootlist, int32_t bootindex,
+                                Error **errp)
 {
     FWBootEntry *i;
 
     if (bootindex >= 0) {
-        QTAILQ_FOREACH(i, &fw_boot_order, link) {
+        QTAILQ_FOREACH(i, bootlist, link) {
             if (i->bootindex == bootindex) {
                 error_setg(errp, "The bootindex %d has already been used",
                            bootindex);
@@ -131,7 +132,13 @@ void check_boot_index(int32_t bootindex, Error **errp)
     }
 }
 
-void del_boot_device_path(DeviceState *dev, const char *suffix)
+void check_boot_index(int32_t bootindex, Error **errp)
+{
+    do_check_boot_index(&fw_boot_order, bootindex, errp);
+}
+
+static void do_del_boot_device_path(FWBootList *bootlist, DeviceState *dev,
+                                    const char *suffix)
 {
     FWBootEntry *i;
 
@@ -139,10 +146,10 @@ void del_boot_device_path(DeviceState *dev, const char *suffix)
         return;
     }
 
-    QTAILQ_FOREACH(i, &fw_boot_order, link) {
+    QTAILQ_FOREACH(i, bootlist, link) {
         if ((!suffix || !g_strcmp0(i->suffix, suffix)) &&
              i->dev == dev) {
-            QTAILQ_REMOVE(&fw_boot_order, i, link);
+            QTAILQ_REMOVE(bootlist, i, link);
             g_free(i->suffix);
             g_free(i);
 
@@ -151,26 +158,31 @@ void del_boot_device_path(DeviceState *dev, const char *suffix)
     }
 }
 
-void add_boot_device_path(int32_t bootindex, DeviceState *dev,
-                          const char *suffix)
+void del_boot_device_path(DeviceState *dev, const char *suffix)
+{
+    do_del_boot_device_path(&fw_boot_order, dev, suffix);
+}
+
+static void do_add_boot_device_path(FWBootList *bootlist, int32_t bootindex,
+                                    DeviceState *dev, const char *suffix)
 {
     FWBootEntry *node, *i;
 
     if (bootindex < 0) {
-        del_boot_device_path(dev, suffix);
+        do_del_boot_device_path(bootlist, dev, suffix);
         return;
     }
 
     assert(dev != NULL || suffix != NULL);
 
-    del_boot_device_path(dev, suffix);
+    do_del_boot_device_path(bootlist, dev, suffix);
 
     node = g_malloc0(sizeof(FWBootEntry));
     node->bootindex = bootindex;
     node->suffix = g_strdup(suffix);
     node->dev = dev;
 
-    QTAILQ_FOREACH(i, &fw_boot_order, link) {
+    QTAILQ_FOREACH(i, bootlist, link) {
         if (i->bootindex == bootindex) {
             error_report("Two devices with same boot index %d", bootindex);
             exit(1);
@@ -180,7 +192,13 @@ void add_boot_device_path(int32_t bootindex, DeviceState *dev,
         QTAILQ_INSERT_BEFORE(i, node, link);
         return;
     }
-    QTAILQ_INSERT_TAIL(&fw_boot_order, node, link);
+    QTAILQ_INSERT_TAIL(bootlist, node, link);
+}
+
+void add_boot_device_path(int32_t bootindex, DeviceState *dev,
+                          const char *suffix)
+{
+    do_add_boot_device_path(&fw_boot_order, bootindex, dev, suffix);
 }
 
 DeviceState *get_boot_device(uint32_t position)
@@ -210,11 +228,14 @@ DeviceState *get_boot_device(uint32_t position)
  */
 char *get_boot_devices_list(size_t *size, bool ignore_suffixes)
 {
+    FWBootList *bootlist;
     FWBootEntry *i;
     size_t total = 0;
     char *list = NULL;
 
-    QTAILQ_FOREACH(i, &fw_boot_order, link) {
+    bootlist = &fw_boot_order;
+
+    QTAILQ_FOREACH(i, bootlist, link) {
         char *devpath = NULL,  *suffix = NULL;
         char *bootpath;
         char *d;
-- 
2.7.4
