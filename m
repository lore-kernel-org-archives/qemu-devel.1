Received: from eggs.gnu.org ([2001:4830:134:3::10]:40098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLeo-0007LA-3T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLel-00041g-AZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLel-00040A-5A
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:55 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:26 +0200
Message-Id: <20170919164337.18555-28-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 27/38] s390x: CPU hot unplug via device_del
 cannot work for now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

device_del on a CPU will currently do nothing. Let's emit an error
telling that this is will currently not work (there is no architecture
support on s390x). Error message copied from ppc.

(qemu) device_del cpu1
device_del cpu1
CPU hot unplug not supported on this machine

Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-18-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 99c36a1315..acdd53573c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -339,6 +339,15 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
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
@@ -388,6 +397,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 248;
     mc->get_hotplug_handler = s390_get_hotplug_handler;
     hc->plug = s390_machine_device_plug;
+    hc->unplug_request = s390_machine_device_unplug_request;
     nc->nmi_monitor_handler = s390_nmi;
 }
 
-- 
2.13.5
