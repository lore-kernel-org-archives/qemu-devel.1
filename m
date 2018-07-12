Received: from eggs.gnu.org ([2001:4830:134:3::10]:47842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdhX9-0008D8-Fi
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdhX6-0001S2-D8
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fdhX6-0001RC-4c
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 12 Jul 2018 16:45:21 -0300
Message-Id: <20180712194522.31063-3-ehabkost@redhat.com>
In-Reply-To: <20180712194522.31063-1-ehabkost@redhat.com>
References: <20180712194522.31063-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 2/3] qdev: Document ownership rules of
 qbus_create*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

The ownership rules of those functions aren't trivial: the caller
owns the new object if parent is NULL, otherwise ownership is
transferred to the parent.  Clarify that on comments.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/qdev-core.h | 24 ++++++++++++++++++++++++
 hw/core/bus.c          |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index f1fd0f8736..27d1ac3781 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -343,8 +343,32 @@ DeviceState *qdev_find_recursive(BusState *bus, const char *id);
 typedef int (qbus_walkerfn)(BusState *bus, void *opaque);
 typedef int (qdev_walkerfn)(DeviceState *dev, void *opaque);
 
+/**
+ * qbus_create_inplace:
+ * @bus: A pointer to the memory to be used for the bus object.
+ * @size: The maximum size available at @bus for the bus object.
+ * @typename: The name of the type of bus to instantiate.
+ * @parent: parent device
+ * @name: name for the new bus
+ *
+ * Creates bus in place.
+ *
+ * If @parent is not NULL the bus will be owned by @parent, otherwise
+ * the bus will be owned by the caller.
+ */
 void qbus_create_inplace(void *bus, size_t size, const char *typename,
                          DeviceState *parent, const char *name);
+/**
+ * qbus_create:
+ * @typename: The name of the type of bus to instantiate.
+ * @parent: parent device
+ * @name: name for the new bus
+ *
+ * Creates bus object.
+ *
+ * If @parent is not NULL the returned object will be owned by @parent,
+ * otherwise it will be owned by the caller.
+ */
 BusState *qbus_create(const char *typename, DeviceState *parent, const char *name);
 /* Returns > 0 if either devfn or busfn skip walk somewhere in cursion,
  *         < 0 if either devfn or busfn terminate walk somewhere in cursion,
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 4651f24486..68a0d5b085 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -74,6 +74,7 @@ int qbus_walk_children(BusState *bus,
     return 0;
 }
 
+/* If @parent is not NULL, ownership of @bus is transferred to @parent */
 static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
 {
     const char *typename = object_get_typename(OBJECT(bus));
@@ -102,6 +103,10 @@ static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
         QLIST_INSERT_HEAD(&bus->parent->child_bus, bus, sibling);
         bus->parent->num_child_bus++;
         object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT(bus), NULL);
+        /*
+         * object_property_add_child() takes a new reference, drop the
+         * reference that was transferred to us.
+         */
         object_unref(OBJECT(bus));
     } else if (bus != sysbus_get_default()) {
         /* TODO: once all bus devices are qdevified,
-- 
2.18.0.rc1.1.g3f1ff2140
