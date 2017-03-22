Received: from eggs.gnu.org ([2001:4830:134:3::10]:35167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihv-00032R-On
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqiho-0007EB-NJ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:51 -0400
Received: from mail.kernel.org ([198.145.29.136]:38824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqiho-0007Dq-HE
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:48 -0400
Date: Wed, 22 Mar 2017 18:01:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1490198476-12244-5-git-send-email-mst@redhat.com>
References: <1490198476-12244-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490198476-12244-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] hw/acpi/vmgenid: prevent more than one
 vmgenid device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

A system with multiple VMGENID devices is undefined in the VMGENID spec by
omission.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Binary file /tmp/tmp.IaAwzHwwsQ matches
---
 include/hw/acpi/vmgenid.h | 1 +
 hw/acpi/vmgenid.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index 8578476..7beb959 100644
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
index c3ddcc8..a32b847 100644
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
MST
