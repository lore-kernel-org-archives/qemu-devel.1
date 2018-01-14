Received: from eggs.gnu.org ([2001:4830:134:3::10]:54246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaXfE-00075p-LD
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaXfD-0006sI-Mc
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:04:48 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:42880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaXfD-0006s1-H0
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:04:47 -0500
Received: by mail-qk0-x241.google.com with SMTP id q1so13190877qkb.9
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 18:04:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 23:04:11 -0300
Message-Id: <20180114020412.26160-3-f4bug@amsat.org>
In-Reply-To: <20180114020412.26160-1-f4bug@amsat.org>
References: <20180114020412.26160-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/3] qdev: add helpers to be more explicit
 when using abstract QOM parent functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

QOM API learning curve is quite hard, in particular when devices inherit from
abstract parent.
To be more explicit about when a device class change the parent hooks, add few
helpers hoping a device class_init() will be easier to understand.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-core.h | 10 ++++++++++
 hw/core/qdev.c         | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

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
-- 
2.15.1
