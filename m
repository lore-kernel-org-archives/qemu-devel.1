Received: from eggs.gnu.org ([2001:4830:134:3::10]:38997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cq0l7-0000MY-PD
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cq0l1-0006hl-RV
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:06:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cq0l1-0006hV-MD
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:06:11 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Mon, 20 Mar 2017 18:05:57 +0100
Message-Id: <20170320170557.15645-3-lersek@redhat.com>
In-Reply-To: <20170320170557.15645-1-lersek@redhat.com>
References: <20170320170557.15645-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] hw/acpi/vmgenid: prevent more than one
 vmgenid device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

A system with multiple VMGENID devices is undefined in the VMGENID spec by
omission.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    v2:
    - use find_vmgenid_dev() rather than open-code
      object_resolve_path_type() [Michael]
    - add comments to both the definition of find_vmgenid_dev() and its call
      site in vmgenid_realize() [Michael]

 include/hw/acpi/vmgenid.h | 1 +
 hw/acpi/vmgenid.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index 8578476baebe..7beb9592fb01 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -24,6 +24,7 @@ typedef struct VmGenIdState {
     bool write_pointer_available;
 } VmGenIdState;
 
+/* returns NULL unless there is exactly one device */
 static inline Object *find_vmgenid_dev(void)
 {
     return object_resolve_path_type("", VMGENID_DEVICE, NULL);
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index c3ddcc8e7cb0..a32b847fe0df 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -221,6 +221,14 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Given that this function is executing, there is at least one VMGENID
+     * device. Check if there are several.
+     */
+    if (!find_vmgenid_dev()) {
+        error_setg(errp, "at most one %s device is permitted", VMGENID_DEVICE);
+        return;
+    }
+
     qemu_register_reset(vmgenid_handle_reset, vms);
 }
 
-- 
2.9.3
