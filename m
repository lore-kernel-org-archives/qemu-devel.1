Received: from eggs.gnu.org ([2001:4830:134:3::10]:37908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXq-0004qo-Jt
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXm-0001OX-4R
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dotXl-0001OB-VV
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:44:10 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Sep 2017 17:43:14 +0200
Message-Id: <20170904154316.4148-18-david@redhat.com>
In-Reply-To: <20170904154316.4148-1-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/19] s390x: CPU hot unplug via device_del
 cannot work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

device_del on a CPU will currently do nothing. Let's emmit an error
telling that this is will never work (there is no architecture support
on s390x). Error message copied from ppc.

(qemu) device_del cpu1
device_del cpu1
CPU hot unplug not supported on this machine

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 22a8a1b45d..dd149567bb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -338,6 +338,15 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
     }
 }
 
+static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
+                                               DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        error_setg(errp, "CPU hot unplug not supported on this machine");
+        return;
+    }
+}
+
 static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
                                                 DeviceState *dev)
 {
@@ -387,6 +396,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 248;
     mc->get_hotplug_handler = s390_get_hotplug_handler;
     hc->plug = s390_machine_device_plug;
+    hc->unplug_request = s390_machine_device_unplug_request;
     nc->nmi_monitor_handler = s390_nmi;
 }
 
-- 
2.13.5
