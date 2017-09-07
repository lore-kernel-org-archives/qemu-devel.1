Received: from eggs.gnu.org ([2001:4830:134:3::10]:58125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpt1S-000334-KS
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpt1N-00011k-OQ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:22:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpt1N-00011K-Hz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:22:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A70FDC0587D6
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 09:22:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Sep 2017 11:22:42 +0200
Message-Id: <1504776162-31400-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/core/qdev: Do not allow hot-plugging
 without hotplug controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

qdev_unplug() bails out with an assertion if the user tries to device_del
a hot-plugged device that does not have a hotplug controller. Unfortunately,
our devices are all marked with hotpluggable = true by default (see the
device_class_init() function in qdev.c), so it currently can happen that
the user runs into this situation and QEMU gets terminated unexpectedly:

$ qemu-system-aarch64 -M virt -nographic -nodefaults -monitor stdio -S
QEMU 2.10.50 monitor - type 'help' for more information
(qemu) device_add aux-to-i2c-bridge,id=x
(qemu) device_del x
**
ERROR:qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
Aborted (core dumped)

Hotplugging devices without a hotplug controller does not make much sense,
so we should disallow this during the device_add process already!

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/qdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 606ab53..d9ccce6 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -908,6 +908,11 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             if (local_err != NULL) {
                 goto fail;
             }
+        } else if (dev->hotplugged) {
+            /* Hot-plugged device without hotplug controller? No way! */
+            error_setg(&local_err, QERR_DEVICE_NO_HOTPLUG,
+                       object_get_typename(obj));
+            goto fail;
         }
 
         if (dc->realize) {
-- 
1.8.3.1
