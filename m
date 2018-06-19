Received: from eggs.gnu.org ([2001:4830:134:3::10]:47092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5jf-00038U-Ht
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5je-0000sf-KV
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:47:07 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:46 -0500
Message-Id: <20180619014319.28272-81-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 080/113] qdev: add helpers to be more explicit
 when using abstract QOM parent functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

QOM API learning curve is quite hard, in particular when devices inherit from
abstract parent.
To be more explicit about when a device class change the parent hooks, add few
helpers hoping a device class_init() will be easier to understand.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180114020412.26160-3-f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 46795cf2e2f643ace9454822022ba8b1e9c0cf61)
*prereq for 0c53057adb
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/core/qdev.c         | 24 ++++++++++++++++++++++++
 include/hw/qdev-core.h | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 11112951a5..a71cd264e2 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1140,6 +1140,30 @@ static void device_class_init(ObjectClass *class, void *data)
     dc->user_creatable = true;
 }
 
+void device_class_set_parent_reset(DeviceClass *dc,
+                                   DeviceReset dev_reset,
+                                   DeviceReset *parent_reset)
+{
+    *parent_reset = dc->reset;
+    dc->reset = dev_reset;
+}
+
+void device_class_set_parent_realize(DeviceClass *dc,
+                                     DeviceRealize dev_realize,
+                                     DeviceRealize *parent_realize)
+{
+    *parent_realize = dc->realize;
+    dc->realize = dev_realize;
+}
+
+void device_class_set_parent_unrealize(DeviceClass *dc,
+                                       DeviceUnrealize dev_unrealize,
+                                       DeviceUnrealize *parent_unrealize)
+{
+    *parent_unrealize = dc->unrealize;
+    dc->unrealize = dev_unrealize;
+}
+
 void device_reset(DeviceState *dev)
 {
     DeviceClass *klass = DEVICE_GET_CLASS(dev);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 83db53b3f5..0fc53b33d0 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -381,6 +381,16 @@ void qdev_machine_init(void);
  */
 void device_reset(DeviceState *dev);
 
+void device_class_set_parent_reset(DeviceClass *dc,
+                                   DeviceReset dev_reset,
+                                   DeviceReset *parent_reset);
+void device_class_set_parent_realize(DeviceClass *dc,
+                                     DeviceRealize dev_realize,
+                                     DeviceRealize *parent_realize);
+void device_class_set_parent_unrealize(DeviceClass *dc,
+                                       DeviceUnrealize dev_unrealize,
+                                       DeviceUnrealize *parent_unrealize);
+
 const struct VMStateDescription *qdev_get_vmsd(DeviceState *dev);
 
 const char *qdev_fw_name(DeviceState *dev);
-- 
2.11.0
