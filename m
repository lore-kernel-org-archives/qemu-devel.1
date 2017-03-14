Received: from eggs.gnu.org ([2001:4830:134:3::10]:44098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnxfE-0006I2-ML
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnxfB-0006qZ-GQ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:23:44 -0400
Received: from mail-ve1eur01on0098.outbound.protection.outlook.com
	([104.47.1.98]:47428
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <janne.huttunen@nokia.com>)
	id 1cnxfA-0006pq-SJ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:23:41 -0400
From: Janne Huttunen <janne.huttunen@nokia.com>
Date: Tue, 14 Mar 2017 14:50:10 +0200
Message-ID: <208c825227726c5a816678b72eccae75089965a0.1489494746.git.janne.huttunen@nokia.com>
In-Reply-To: <cover.1489494746.git.janne.huttunen@nokia.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC][PATCH 3/6] Add support for "bootonceindex"
 property.
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

The property works just like the "bootindex" property does, but uses
a separate list. When the list of boot devices is queried, the boot
once list is consulted first. The normal list is returned only if the
boot once list is empty.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
---
 bootdevice.c            | 11 ++++++++++-
 include/sysemu/sysemu.h |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/bootdevice.c b/bootdevice.c
index 30e98ae..b5515f8 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -48,6 +48,7 @@ struct FWBootEntry {
 };
 
 static FWBootList fw_boot_order = QTAILQ_HEAD_INITIALIZER(fw_boot_order);
+static FWBootList fw_boot_once = QTAILQ_HEAD_INITIALIZER(fw_boot_once);
 static QEMUBootSetHandler *boot_set_handler;
 static void *boot_set_opaque;
 
@@ -240,7 +241,7 @@ char *get_boot_devices_list(size_t *size, bool ignore_suffixes)
     size_t total = 0;
     char *list = NULL;
 
-    bootlist = &fw_boot_order;
+    bootlist = QTAILQ_EMPTY(&fw_boot_once) ? &fw_boot_order : &fw_boot_once;
 
     QTAILQ_FOREACH(i, bootlist, link) {
         char *devpath = NULL,  *suffix = NULL;
@@ -373,3 +374,11 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
     do_add_bootindex_prop(&fw_boot_order, obj, bootindex,
                           name, suffix, dev, errp);
 }
+
+void device_add_bootonceindex_property(Object *obj, int32_t *bootindex,
+                                       const char *name, const char *suffix,
+                                       DeviceState *dev, Error **errp)
+{
+    do_add_bootindex_prop(&fw_boot_once, obj, bootindex,
+                          name, suffix, dev, errp);
+}
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 576c7ce..9acf2d9 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -214,6 +214,9 @@ void del_boot_device_path(DeviceState *dev, const char *suffix);
 void device_add_bootindex_property(Object *obj, int32_t *bootindex,
                                    const char *name, const char *suffix,
                                    DeviceState *dev, Error **errp);
+void device_add_bootonceindex_property(Object *obj, int32_t *bootindex,
+                                       const char *name, const char *suffix,
+                                       DeviceState *dev, Error **errp);
 void restore_boot_order(void *opaque);
 void validate_bootdevices(const char *devices, Error **errp);
 
-- 
2.7.4
