Received: from eggs.gnu.org ([2001:4830:134:3::10]:35772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fY1Su-0006eN-9p
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fY1Sr-00061a-6r
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:49:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fY1Sq-0005wt-Th
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:49:53 -0400
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Tue, 26 Jun 2018 22:49:31 -0500
Message-Id: <20180627034935.20276-2-venu.busireddy@oracle.com>
In-Reply-To: <20180627034935.20276-1-venu.busireddy@oracle.com>
References: <20180627034935.20276-1-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH v2 1/4] Add a true or false option to the
 DEFINE_PROP_UUID macro.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: venu.busireddy@oracle.com, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

It may not always be desirable to have a random UUID stuffed into the
'_field' member. Add a new boolean option '_default' that will allow
the caller to specify if a random UUID needs be generated or not.

Also modified the instance where this macro is used.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hw/acpi/vmgenid.c            | 2 +-
 include/hw/qdev-properties.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index d78b579a20..6d53757ee5 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -215,7 +215,7 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
 }
 
 static Property vmgenid_device_properties[] = {
-    DEFINE_PROP_UUID(VMGENID_GUID, VmGenIdState, guid),
+    DEFINE_PROP_UUID(VMGENID_GUID, VmGenIdState, guid, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 4f60cc88f3..7d39a4bdcd 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -218,12 +218,12 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar;
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
                         OffAutoPCIBAR)
 
-#define DEFINE_PROP_UUID(_name, _state, _field) {                  \
+#define DEFINE_PROP_UUID(_name, _state, _field, _default) {        \
         .name      = (_name),                                      \
         .info      = &qdev_prop_uuid,                              \
         .offset    = offsetof(_state, _field)                      \
             + type_check(QemuUUID, typeof_field(_state, _field)),  \
-        .set_default = true,                                       \
+        .set_default = _default,                                   \
         }
 
 #define DEFINE_PROP_END_OF_LIST()               \
