Received: from eggs.gnu.org ([209.51.188.92]:38664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1bYv-0004lr-Qr
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1bYu-00029T-RE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:46:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h1bYu-00028N-3N
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:46:40 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  6 Mar 2019 15:40:57 -0300
Message-Id: <20190306184101.9974-2-ehabkost@redhat.com>
In-Reply-To: <20190306184101.9974-1-ehabkost@redhat.com>
References: <20190306184101.9974-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] qdev/core: fix qbus_is_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>

From: Tony Krowiak <akrowiak@linux.ibm.com>

The qbus_is_full(BusState *bus) function (qdev_monitor.c) compares the max_index
value of the BusState structure with the max_dev value of the BusClass structure
to determine whether the maximum number of children has been reached for the
bus. The problem is, the max_index field of the BusState structure does not
necessarily reflect the number of devices that have been plugged into
the bus.

Whenever a child device is plugged into the bus, the bus's max_index value is
assigned to the child device and then incremented. If the child is subsequently
unplugged, the value of the max_index does not change and no longer reflects the
number of children.

When the bus's max_index value reaches the maximum number of devices
allowed for the bus (i.e., the max_dev field in the BusClass structure),
attempts to plug another device will be rejected claiming that the bus is
full -- even if the bus is actually empty.

To resolve the problem, a new 'num_children' field is being added to the
BusState structure to keep track of the number of children plugged into the
bus. It will be incremented when a child is plugged, and decremented when a
child is unplugged.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/qdev-core.h | 1 +
 hw/core/qdev.c         | 3 +++
 qdev-monitor.c         | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e70a4bfa49..35b8154e8b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -206,6 +206,7 @@ struct BusState {
     HotplugHandler *hotplug_handler;
     int max_index;
     bool realized;
+    int num_children;
     QTAILQ_HEAD(, BusChild) children;
     QLIST_ENTRY(BusState) sibling;
 };
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index d59071b8ed..00a5a39c76 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -59,6 +59,8 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
             snprintf(name, sizeof(name), "child[%d]", kid->index);
             QTAILQ_REMOVE(&bus->children, kid, sibling);
 
+            bus->num_children--;
+
             /* This gives back ownership of kid->child back to us.  */
             object_property_del(OBJECT(bus), name, NULL);
             object_unref(OBJECT(kid->child));
@@ -73,6 +75,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
     char name[32];
     BusChild *kid = g_malloc0(sizeof(*kid));
 
+    bus->num_children++;
     kid->index = bus->max_index++;
     kid->child = child;
     object_ref(OBJECT(kid->child));
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 07147c63bf..45a8ba4964 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -414,7 +414,7 @@ static DeviceState *qbus_find_dev(BusState *bus, char *elem)
 static inline bool qbus_is_full(BusState *bus)
 {
     BusClass *bus_class = BUS_GET_CLASS(bus);
-    return bus_class->max_dev && bus->max_index >= bus_class->max_dev;
+    return bus_class->max_dev && bus->num_children >= bus_class->max_dev;
 }
 
 /*
-- 
2.18.0.rc1.1.g3f1ff2140
