Received: from eggs.gnu.org ([2001:4830:134:3::10]:44405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimRz-0004Ar-Mt
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimRy-0004rN-Cx
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:11 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimRy-0004qe-5N
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:10 -0500
Received: by mail-wm0-x244.google.com with SMTP id 141so27956862wme.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:10 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:17 +0100
Message-Id: <1517858941-5538-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/47] qdev: add helpers to be more explicit
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

QOM API learning curve is quite hard, in particular when devices inherit from
abstract parent.
To be more explicit about when a device class change the parent hooks, add few
helpers hoping a device class_init() will be easier to understand.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180114020412.26160-3-f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c         | 24 ++++++++++++++++++++++++
 include/hw/qdev-core.h | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2456035..11f8a27 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1075,6 +1075,30 @@ static void device_class_init(ObjectClass *class, void *data)
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
index 85fa26d..18c0251 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -382,6 +382,16 @@ void qdev_machine_init(void);
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
1.8.3.1
