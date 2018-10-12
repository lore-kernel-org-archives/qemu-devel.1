Received: from eggs.gnu.org ([2001:4830:134:3::10]:52655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAwqS-0003mg-0b
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAwqN-00048V-Va
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:47:07 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAwqN-00046x-Md
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:47:03 -0400
Received: by mail-wr1-f45.google.com with SMTP id g15-v6so13297016wru.9
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 05:47:03 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b41a233c-988c-19bb-0d4b-b17655912839@redhat.com>
Date: Fri, 12 Oct 2018 14:47:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QOM: Can devices having link properties be
 user-creatable?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

While looking at Mao's series
(https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02519.html) I
wondered if devices having link properties can be user-creatable.

Using the following patch (I don't think this is correct to put qdev
code into qobject, but I used this as PoC):

-- >8 --
diff --git a/qom/object.c b/qom/object.c
index 547dcf97c3..2dd3a25531 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -16,4 +16,5 @@
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 #include "qapi/visitor.h"
 #include "qapi/string-input-visitor.h"
@@ -1662,4 +1663,11 @@ void object_property_add_link(Object *obj, const
char *name,
     gchar *full_type;
     ObjectProperty *op;
+    ObjectClass *klass = object_get_class(obj);
+
+    if (klass && object_dynamic_cast(obj, TYPE_DEVICE) &&
+                 DEVICE_CLASS(klass)->user_creatable == false) {
+        warn_report("Device type '%s' is user_creatable "
+                    "(linked property: '%s')", type, name);
+    }

     prop->child = child;
---

I get:

$ aarch64-softmmu/qemu-system-aarch64 -M virt
qemu-system-aarch64: warning: Device type 'bus' is user_creatable
(linked property: 'parent_bus')
qemu-system-aarch64: warning: Device type 'qemu:memory-region' is
user_creatable (linked property: 'memory')
qemu-system-aarch64: warning: Device type 'bus' is user_creatable
(linked property: 'parent_bus')
qemu-system-aarch64: warning: Device type 'irq' is user_creatable
(linked property: 'unnamed-gpio-out[0]')
qemu-system-aarch64: warning: Device type 'irq' is user_creatable
(linked property: 'unnamed-gpio-out[1]')
qemu-system-aarch64: warning: Device type 'irq' is user_creatable
(linked property: 'unnamed-gpio-out[2]')
qemu-system-aarch64: warning: Device type 'irq' is user_creatable
(linked property: 'unnamed-gpio-out[3]')
qemu-system-aarch64: warning: Device type 'irq' is user_creatable
(linked property: 'gicv3-maintenance-interrupt[0]')
qemu-system-aarch64: warning: Device type 'irq' is user_creatable
(linked property: 'pmu-interrupt[0]')
qemu-system-aarch64: warning: Device type 'qemu:memory-region' is
user_creatable (linked property: 'secure-memory')
qemu-system-aarch64: warning: Device type 'bus' is user_creatable
(linked property: 'parent_bus')
qemu-system-aarch64: warning: Device type 'bus' is user_creatable
(linked property: 'parent_bus')
qemu-system-aarch64: warning: Device type 'bus' is user_creatable
(linked property: 'parent_bus')
qemu-system-aarch64: warning: Device type 'irq' is user_creatable
(linked property: 'sysbus-irq[0]')
qemu-system-aarch64: warning: Device type 'irq' is user_creatable
(linked property: 'sysbus-irq[1]')
qemu-system-aarch64: warning: Device type 'irq' is user_creatable
(linked property: 'sysbus-irq[2]')
qemu-system-aarch64: warning: Device type 'irq' is user_creatable
(linked property: 'sysbus-irq[3]')

Are we incorrectly using user_creatable = true in those devices/
Am I missing something?

Thanks,

Phil.
