Received: from eggs.gnu.org ([2001:4830:134:3::10]:41881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gXTpA-0005xT-Ve
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gXTp7-0001mB-M8
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:26:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gXTp7-0001k6-D4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:26:53 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBDGOSb0033748
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 11:26:52 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pbtgt9wd8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 11:26:51 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Thu, 13 Dec 2018 16:26:50 -0000
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 13 Dec 2018 11:26:42 -0500
Message-Id: <1544718402-8703-1-git-send-email-akrowiak@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2] qdev/core: Can not replug device on bus
 that allows one device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pasic@linux.ibm.com, mammedo@redhat.com, Tony Krowiak <akrowiak@linux.ibm.com>

If the maximum number of devices allowed on a bus is 1 and a device
which is plugged into the bus is subsequently unplugged, attempting to replug
the device fails with error "Bus 'xxx' does not support hotplugging".
The "error" is detected in the qbus_is_full(BusState *bus) function
(qdev_monitor.c) because bus->max_index >= bus_class->max_dev. The
root of the problem is that the bus->max_index is not decremented when a device
is unplugged from the bus. This patch fixes that problem.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 hw/core/qdev.c         | 3 +++
 include/hw/qdev-core.h | 1 +
 qdev-monitor.c         | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 6b3cc55b27c2..956923f33520 100644
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
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a24d0dd566e3..521f0a947ead 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -206,6 +206,7 @@ struct BusState {
     HotplugHandler *hotplug_handler;
     int max_index;
     bool realized;
+    int num_children;
     QTAILQ_HEAD(ChildrenHead, BusChild) children;
     QLIST_ENTRY(BusState) sibling;
 };
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 07147c63bf8b..45a8ba49644c 100644
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
2.7.4
