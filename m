Received: from eggs.gnu.org ([2001:4830:134:3::10]:44329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cX7dY-0003AU-0x
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cX7dU-0003ri-VJ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:36:24 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 27 Jan 2017 15:36:18 +0100
Message-Id: <1485527778-29560-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/core/register: Mark the device with
 cannot_instantiate_with_device_add_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>

The "qemu,register" device is just used internally. It's strange to
see this device showing up in the "-device ?" help text. Let's mark it
with cannot_instantiate_with_device_add_yet to hide it from the users.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/register.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/core/register.c b/hw/core/register.c
index 4bfbc50..e0659be 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -274,9 +274,18 @@ void register_finalize_block(RegisterInfoArray *r_array)
     g_free(r_array);
 }
 
+static void register_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    /* It's just used internally, and should not be exposed to users */
+    dc->cannot_instantiate_with_device_add_yet = true;
+}
+
 static const TypeInfo register_info = {
     .name  = TYPE_REGISTER,
     .parent = TYPE_DEVICE,
+    .class_init = register_class_init,
 };
 
 static void register_register_types(void)
-- 
1.8.3.1
