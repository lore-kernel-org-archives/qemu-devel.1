Received: from eggs.gnu.org ([2001:4830:134:3::10]:56053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9X-00033a-B4
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9T-00024q-AD
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:47 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Jun 2018 18:52:18 +0200
Message-Id: <20180607165218.9558-9-david@redhat.com>
In-Reply-To: <20180607165218.9558-1-david@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 8/8] s390x: local error handling in hotplug
 handler functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>

Let's introduce and use local error variables in the hotplug handler
functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7ae5fb38dd..29ea50a177 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -434,18 +434,23 @@ static void s390_machine_reset(void)
 static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        s390_cpu_plug(hotplug_dev, dev, errp);
+        s390_cpu_plug(hotplug_dev, dev, &local_err);
     }
+    error_propagate(errp, local_err);
 }
 
 static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
                                                DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        error_setg(errp, "CPU hot unplug not supported on this machine");
-        return;
+        error_setg(&local_err, "CPU hot unplug not supported on this machine");
     }
+    error_propagate(errp, local_err);
 }
 
 static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
-- 
2.17.0
